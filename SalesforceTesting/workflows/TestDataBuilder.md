# Test Data Builder Workflow

Generate reusable test data builder classes using the Builder pattern.

## Builder Pattern Template

```apex
/**
 * @description Builder class for creating test Account records
 * @author [Your Name]
 * @date [Date]
 */
@isTest
public class TestAccountBuilder {
    
    private Account record;
    
    /**
     * @description Constructor with sensible defaults
     */
    public TestAccountBuilder() {
        this.record = new Account(
            Name = 'Test Account ' + Crypto.getRandomInteger(),
            Industry = 'Technology',
            Type = 'Prospect',
            BillingCountry = 'United States',
            BillingState = 'CA',
            BillingCity = 'San Francisco',
            BillingStreet = '123 Test St',
            BillingPostalCode = '94105',
            Phone = '(415) 555-1234',
            Website = 'https://testaccount.com',
            AnnualRevenue = 1000000,
            NumberOfEmployees = 100,
            Rating = 'Hot'
        );
    }
    
    /**
     * @description Set custom name
     */
    public TestAccountBuilder withName(String name) {
        this.record.Name = name;
        return this;
    }
    
    /**
     * @description Set industry
     */
    public TestAccountBuilder withIndustry(String industry) {
        this.record.Industry = industry;
        return this;
    }
    
    /**
     * @description Set annual revenue
     */
    public TestAccountBuilder withRevenue(Decimal revenue) {
        this.record.AnnualRevenue = revenue;
        return this;
    }
    
    /**
     * @description Set billing state (for territory assignment)
     */
    public TestAccountBuilder inState(String state) {
        this.record.BillingState = state;
        return this;
    }
    
    /**
     * @description Create enterprise account preset
     */
    public TestAccountBuilder asEnterprise() {
        this.record.AnnualRevenue = 10000000;
        this.record.NumberOfEmployees = 1000;
        this.record.Type = 'Customer - Direct';
        this.record.Rating = 'Hot';
        return this;
    }
    
    /**
     * @description Create small business preset
     */
    public TestAccountBuilder asSmallBusiness() {
        this.record.AnnualRevenue = 500000;
        this.record.NumberOfEmployees = 10;
        this.record.Type = 'Prospect';
        this.record.Rating = 'Warm';
        return this;
    }
    
    /**
     * @description Build without inserting
     */
    public Account build() {
        return this.record;
    }
    
    /**
     * @description Build and insert
     */
    public Account create() {
        insert this.record;
        return this.record;
    }
    
    /**
     * @description Build multiple accounts
     */
    public static List<Account> createMultiple(Integer count) {
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < count; i++) {
            accounts.add(new TestAccountBuilder().build());
        }
        insert accounts;
        return accounts;
    }
}
```

## Usage Examples

```apex
// Simple usage
Account testAccount = new TestAccountBuilder().create();

// Customized account
Account enterpriseAccount = new TestAccountBuilder()
    .withName('Acme Corporation')
    .asEnterprise()
    .inState('TX')
    .create();

// Build without inserting (for relationship setup)
Account parentAccount = new TestAccountBuilder()
    .withName('Parent Corp')
    .build();
insert parentAccount;

Account childAccount = new TestAccountBuilder()
    .withName('Child Corp')
    .build();
childAccount.ParentId = parentAccount.Id;
insert childAccount;

// Bulk creation
List<Account> accounts = TestAccountBuilder.createMultiple(200);
```

## Complete Test Data Builder Suite

```apex
/**
 * @description Builder for Opportunity records
 */
@isTest
public class TestOpportunityBuilder {
    private Opportunity record;
    private Account relatedAccount;
    
    public TestOpportunityBuilder() {
        this.record = new Opportunity(
            Name = 'Test Opportunity ' + Crypto.getRandomInteger(),
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(30),
            Amount = 50000,
            Probability = 10,
            Type = 'New Business'
        );
    }
    
    public TestOpportunityBuilder forAccount(Account acc) {
        this.relatedAccount = acc;
        this.record.AccountId = acc.Id;
        this.record.Name = acc.Name + ' Opportunity';
        return this;
    }
    
    public TestOpportunityBuilder withStage(String stage) {
        this.record.StageName = stage;
        return this;
    }
    
    public TestOpportunityBuilder withAmount(Decimal amount) {
        this.record.Amount = amount;
        return this;
    }
    
    public TestOpportunityBuilder asClosedWon() {
        this.record.StageName = 'Closed Won';
        this.record.Probability = 100;
        this.record.CloseDate = Date.today();
        return this;
    }
    
    public Opportunity build() {
        if (this.record.AccountId == null) {
            this.relatedAccount = new TestAccountBuilder().create();
            this.record.AccountId = this.relatedAccount.Id;
        }
        return this.record;
    }
    
    public Opportunity create() {
        Opportunity opp = this.build();
        insert opp;
        return opp;
    }
}
```

## Usage in Test Classes

```apex
@isTest
private class OpportunityTriggerHandler_Test {
    
    @testSetup
    static void setupTestData() {
        // Create related account
        Account testAccount = new TestAccountBuilder()
            .withName('Test Account')
            .asEnterprise()
            .create();
        
        // Create opportunities
        List<Opportunity> opps = new List<Opportunity>();
        for (Integer i = 0; i < 200; i++) {
            opps.add(new TestOpportunityBuilder()
                .forAccount(testAccount)
                .withAmount(50000 + (i * 1000))
                .build()
            );
        }
        insert opps;
    }
    
    @isTest
    static void testCloseWon_CalculatesCommission() {
        // Given
        Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
        
        // When
        Test.startTest();
        Opportunity updated = new TestOpportunityBuilder()
            .asClosedWon()
            .build();
        updated.Id = opp.Id;
        update updated;
        Test.stopTest();
        
        // Then
        Opportunity result = [
            SELECT Commission__c 
            FROM Opportunity 
            WHERE Id = :opp.Id
        ];
        System.assertNotEquals(null, result.Commission__c);
    }
}
```
