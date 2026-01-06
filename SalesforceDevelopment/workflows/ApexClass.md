# Apex Class Workflow

Generate production-ready Apex classes following best practices.

## Service Class Pattern

```apex
/**
 * @description Service class for Opportunity business logic
 * @author [Your Name]
 * @date [Date]
 */
public with sharing class OpportunityService {
    
    /**
     * @description Calculate commission for opportunities
     * @param opportunityIds Set of opportunity IDs
     * @return Map of opportunity ID to commission amount
     */
    public static Map<Id, Decimal> calculateCommissions(Set<Id> opportunityIds) {
        Map<Id, Decimal> commissionMap = new Map<Id, Decimal>();
        
        // Query opportunities with related data
        List<Opportunity> opps = [
            SELECT Id, Amount, Territory__c, Territory__r.CommissionRate__c
            FROM Opportunity
            WHERE Id IN :opportunityIds
            AND Amount != null
        ];
        
        // Calculate commissions
        for (Opportunity opp : opps) {
            Decimal rate = opp.Territory__r.CommissionRate__c != null 
                ? opp.Territory__r.CommissionRate__c 
                : 0.05; // Default 5%
            commissionMap.put(opp.Id, opp.Amount * rate);
        }
        
        return commissionMap;
    }
    
    /**
     * @description Update opportunity owners based on territory
     * @param opportunities List of opportunities to process
     */
    public static void assignTerritoryOwners(List<Opportunity> opportunities) {
        // Get territory mappings
        Map<Id, Id> territoryToOwnerMap = getTerritoryOwners();
        
        // Assign owners
        for (Opportunity opp : opportunities) {
            if (opp.Territory__c != null && territoryToOwnerMap.containsKey(opp.Territory__c)) {
                opp.OwnerId = territoryToOwnerMap.get(opp.Territory__c);
            }
        }
    }
    
    /**
     * @description Get territory to owner mappings
     * @return Map of territory ID to owner ID
     */
    private static Map<Id, Id> getTerritoryOwners() {
        Map<Id, Id> ownerMap = new Map<Id, Id>();
        
        for (Territory2 territory : [
            SELECT Id, DefaultOwner__c
            FROM Territory2
            WHERE IsActive = true
        ]) {
            if (territory.DefaultOwner__c != null) {
                ownerMap.put(territory.Id, territory.DefaultOwner__c);
            }
        }
        
        return ownerMap;
    }
}
```

## Controller Class Pattern

```apex
/**
 * @description Controller for LWC opportunity product list
 */
public with sharing class OpportunityProductController {
    
    /**
     * @description Get products for opportunity
     * @param opportunityId Opportunity ID
     * @return List of opportunity line items
     */
    @AuraEnabled(cacheable=true)
    public static List<OpportunityLineItem> getProducts(Id opportunityId) {
        try {
            return [
                SELECT Id, Product2.Name, Quantity, UnitPrice, TotalPrice
                FROM OpportunityLineItem
                WHERE OpportunityId = :opportunityId
                ORDER BY CreatedDate
            ];
        } catch (Exception e) {
            throw new AuraHandledException('Failed to load products: ' + e.getMessage());
        }
    }
    
    /**
     * @description Save product changes
     * @param products List of products to update
     */
    @AuraEnabled
    public static void saveProducts(List<OpportunityLineItem> products) {
        try {
            update products;
        } catch (DmlException e) {
            throw new AuraHandledException('Failed to save products: ' + e.getDmlMessage(0));
        }
    }
}
```

## Batch Class Pattern

```apex
/**
 * @description Batch class to archive old closed opportunities
 */
public class OpportunityArchiveBatch implements Database.Batchable<SObject>, Database.Stateful {
    
    private Integer recordsProcessed = 0;
    private Integer recordsArchived = 0;
    
    public Database.QueryLocator start(Database.BatchableContext bc) {
        Date cutoffDate = Date.today().addYears(-2);
        return Database.getQueryLocator([
            SELECT Id, Name, CloseDate, StageName
            FROM Opportunity
            WHERE CloseDate < :cutoffDate
            AND (StageName = 'Closed Won' OR StageName = 'Closed Lost')
        ]);
    }
    
    public void execute(Database.BatchableContext bc, List<Opportunity> scope) {
        List<OpportunityArchive__c> archives = new List<OpportunityArchive__c>();
        
        for (Opportunity opp : scope) {
            archives.add(new OpportunityArchive__c(
                OriginalOpportunityId__c = opp.Id,
                OpportunityName__c = opp.Name,
                CloseDate__c = opp.CloseDate,
                StageName__c = opp.StageName,
                ArchivedDate__c = Date.today()
            ));
            recordsProcessed++;
        }
        
        if (!archives.isEmpty()) {
            insert archives;
            recordsArchived += archives.size();
            delete scope;
        }
    }
    
    public void finish(Database.BatchableContext bc) {
        // Send completion email
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new String[]{'admin@company.com'});
        email.setSubject('Opportunity Archive Complete');
        email.setPlainTextBody(
            'Archive batch completed.\n' +
            'Records processed: ' + recordsProcessed + '\n' +
            'Records archived: ' + recordsArchived
        );
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
    }
}
```

## Best Practices

1. **Use `with sharing`**: Enforce sharing rules
2. **Bulkify**: Handle 200 records minimum
3. **JSDoc Comments**: Document all public methods
4. **Error Handling**: Try-catch with meaningful messages
5. **Governor Limits**: Always consider SOQL/DML limits
6. **Test Coverage**: Write tests first (TDD)
