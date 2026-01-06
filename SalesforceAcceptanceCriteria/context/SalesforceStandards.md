# Salesforce Standards and Patterns

This document captures established patterns, preferences, and best practices for Salesforce implementations.

## Technology Stack Preferences

- **LWC over Aura**: Always use Lightning Web Components for new development
- **Flow over Process Builder**: Use Flow for declarative automation (Process Builder is deprecated)
- **Apex when needed**: Use Apex for complex logic that can't be done declaratively
- **SOQL optimization**: Always consider bulkification and governor limits
- **Test-driven**: 85%+ code coverage requirement

## Architecture Patterns

### Object Model Design
- Custom objects use `__c` suffix
- Related objects use lookup/master-detail appropriately
- Always consider sharing model during design
- Document object relationships in ERD format
- Use standard objects when possible before creating custom

### Automation Strategy
1. **Validation Rules**: Simple field-level validation
2. **Flows**: Complex business logic, multi-object updates
3. **Apex Triggers**: Bulk operations, complex calculations, external callouts
4. **Scheduled Jobs**: Batch processing, data cleanup, scheduled integrations

### Integration Patterns
- REST APIs for modern integrations
- Platform Events for asynchronous processing
- Named Credentials for authentication
- Proper error handling and retry logic
- Integration monitoring and logging

## Acceptance Criteria Standards

### User Story Format
```
As a [specific role/persona]
I want [specific capability]
So that [clear business value]
```

### AC Structure (Always Include)
1. **Functional Requirements** (Happy path + variations)
2. **Edge Cases** (What could go wrong?)
3. **Validation Rules** (Data quality checks)
4. **Security/Permissions** (Who can do what?)
5. **Error Handling** (User-friendly messages)
6. **Testing Requirements** (Unit, Integration, UAT)
7. **Technical Notes** (Implementation guidance)

### Edge Cases to Always Consider
- Missing/null data
- Duplicate records
- Inactive/deleted related records
- Insufficient permissions
- Bulk operations (1 vs 200 records)
- Concurrent updates
- Governor limit scenarios
- Integration failures

## Field Naming Conventions

### Custom Fields
- **API Name**: DescriptiveName__c (PascalCase + __c)
- **Label**: Descriptive Name (Title Case with spaces)
- **Help Text**: Always provide context for users
- **Description**: Document purpose and any business rules

### Field Types
- **Text**: Specify max length (usually 255, 80, or 40)
- **Number**: Specify precision (decimals) - e.g., Number(16,2) for currency
- **Picklist**: Document all values and their meanings
- **Lookup**: Document relationship and deletion behavior
- **Formula**: Document formula logic in description
- **Date/DateTime**: Specify timezone handling

## Flow Best Practices

### Flow Naming
- **Prefix by Type**: 
  - `Record-Triggered: RT_ObjectName_Description`
  - `Screen Flow: SF_Description`
  - `Auto-Launched: AL_Description`
  - `Scheduled: SCH_Description`

### Flow Design
- One flow per trigger event (avoid multiple triggers on same object)
- Use subflows for reusable logic
- Always handle null values
- Include debug elements for troubleshooting
- Document complex decisions with annotations
- Test bulk scenarios (200 records)

### Flow Formulas (enterprise Patterns)
```
// Date Calculations
TEXT(YEAR(TODAY())) & "-Q" & TEXT(CEILING(MONTH(TODAY()) / 3))

// String Manipulation
IF(ISBLANK({!AccountName}), "Unknown", LEFT({!AccountName}, 40))

// Number Formatting
TEXT(ROUND({!Amount}, 2))

// Multi-Level Conditionals
IF(
  {!Priority} = "High", 
  "24 hours",
  IF({!Priority} = "Medium", "3 days", "1 week")
)
```

## Apex Best Practices

### Trigger Pattern (enterprise Standard)
```apex
trigger OpportunityTrigger on Opportunity (before insert, before update, after insert, after update) {
    if (Trigger.isBefore && Trigger.isInsert) {
        OpportunityTriggerHandler.handleBeforeInsert(Trigger.new);
    }
    // ... other contexts
}
```

### Handler Class Pattern
```apex
public class OpportunityTriggerHandler {
    
    public static void handleBeforeInsert(List<Opportunity> newOpps) {
        // Bulkified logic here
        validateRequiredFields(newOpps);
        setDefaultValues(newOpps);
    }
    
    private static void validateRequiredFields(List<Opportunity> opps) {
        for (Opportunity opp : opps) {
            if (opp.Amount == null) {
                opp.addError('Amount is required');
            }
        }
    }
}
```

### Test Class Pattern
```apex
@isTest
private class OpportunityTriggerHandler_Test {
    
    @testSetup
    static void setupTestData() {
        // Create test data
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
    }
    
    @isTest
    static void testBeforeInsert_ValidData_Success() {
        // Given
        Opportunity opp = new Opportunity(
            Name = 'Test Opp',
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(30)
        );
        
        // When
        Test.startTest();
        insert opp;
        Test.stopTest();
        
        // Then
        Opportunity result = [SELECT Id, Amount FROM Opportunity WHERE Id = :opp.Id];
        System.assertNotEquals(null, result);
    }
    
    @isTest
    static void testBeforeInsert_MissingAmount_Error() {
        // Given
        Opportunity opp = new Opportunity(
            Name = 'Test Opp',
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(30),
            Amount = null
        );
        
        // When/Then
        try {
            insert opp;
            System.assert(false, 'Expected error was not thrown');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('Amount is required'));
        }
    }
}
```

## LWC Best Practices

### Component Structure
```
lwcComponentName/
├── lwcComponentName.html
├── lwcComponentName.js
├── lwcComponentName.js-meta.xml
├── lwcComponentName.css
└── __tests__/
    └── lwcComponentName.test.js
```

### Property Naming
- **@api properties**: camelCase (e.g., recordId, objectApiName)
- **Private properties**: camelCase with underscore prefix (e.g., _internalData)
- **Constants**: UPPER_SNAKE_CASE (e.g., MAX_RECORDS)

### Error Handling
```javascript
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

handleError(error) {
    const evt = new ShowToastEvent({
        title: 'Error',
        message: error.body.message || 'An error occurred',
        variant: 'error',
        mode: 'sticky'
    });
    this.dispatchEvent(evt);
}
```

## Documentation Standards

### Job Aids
- **Audience**: End users (non-technical)
- **Format**: Step-by-step with screenshots
- **Tone**: Friendly and clear
- **Structure**: 
  1. Purpose/When to use
  2. Prerequisites
  3. Step-by-step instructions
  4. Tips and tricks
  5. Troubleshooting

### Technical Specs
- **Audience**: Developers/admins
- **Format**: Technical detail with code examples
- **Structure**:
  1. Overview/purpose
  2. Architecture diagram
  3. Data model
  4. Business logic
  5. Integration points
  6. Security considerations
  7. Testing approach

### Acceptance Criteria
- **Audience**: Product owners, QA, developers
- **Format**: Given/When/Then scenarios
- **Must Include**: All edge cases, security, error handling, testing

## Industry Pattern Examples

### Enterprise Organizations
- Multi-level approval flows
- Complex role hierarchies
- Duplicate management requirements
- External system integrations
- High data volume (100k+ records)
- Territory management complexity

### B2B Commerce
- Commerce Cloud integration
- Multi-currency support
- Quote configuration complexity
- Product catalog management
- Pricing and discounting rules

### Partner/Community Portals
- Experience Cloud customization
- Partner relationship management
- Custom branding requirements
- External user access patterns
- Case deflection strategies

## Common Gotchas to Avoid

1. **Governor Limits**: Always bulkify, never query in loops
2. **Null Pointer Exceptions**: Check for null before accessing properties
3. **Sharing Rules**: Consider OWD and sharing when querying
4. **Field-Level Security**: Use WITH SECURITY_ENFORCED or Security.stripInaccessible()
5. **API Version**: Keep components on latest API version
6. **Hard-Coded IDs**: Never hard-code record IDs, use Custom Metadata
7. **Mixed DML**: Don't mix setup and non-setup objects in same transaction
8. **Test Data**: Use @testSetup for efficient test data creation

## Quality Checklist

Before marking any work as done:
- [ ] Code coverage >= 85%
- [ ] All edge cases have test coverage
- [ ] Security review completed
- [ ] Performance tested with bulk data
- [ ] Error messages are user-friendly
- [ ] Documentation updated
- [ ] UAT sign-off obtained
- [ ] Deployment plan documented
