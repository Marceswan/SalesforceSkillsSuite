# Apex Test Class Workflow

Generate comprehensive Apex test classes following Salesforce best practices.

## Template

```apex
/**
 * @description Test class for [ClassName]
 * @author [Your Name]
 * @date [Date]
 */
@isTest
private class [ClassName]_Test {
    
    /**
     * @description Create test data used across all test methods
     */
    @testSetup
    static void setupTestData() {
        // Create test accounts
        List<Account> testAccounts = new List<Account>();
        for (Integer i = 0; i < 200; i++) {
            testAccounts.add(new Account(
                Name = 'Test Account ' + i,
                Industry = 'Technology',
                AnnualRevenue = 1000000 + (i * 10000)
            ));
        }
        insert testAccounts;
        
        // Create test opportunities
        List<Opportunity> testOpps = new List<Opportunity>();
        for (Account acc : testAccounts) {
            testOpps.add(new Opportunity(
                Name = acc.Name + ' Opportunity',
                AccountId = acc.Id,
                StageName = 'Prospecting',
                CloseDate = Date.today().addDays(30),
                Amount = 50000
            ));
        }
        insert testOpps;
    }
    
    /**
     * @description Test happy path for [method/trigger]
     */
    @isTest
    static void test[MethodName]_ValidData_Success() {
        // Given - Setup test data
        List<Opportunity> opps = [SELECT Id, StageName, Amount FROM Opportunity LIMIT 200];
        
        // When - Execute the operation
        Test.startTest();
        for (Opportunity opp : opps) {
            opp.StageName = 'Closed Won';
        }
        update opps;
        Test.stopTest();
        
        // Then - Verify results
        List<Opportunity> updatedOpps = [
            SELECT Id, StageName, CustomField__c 
            FROM Opportunity 
            WHERE Id IN :opps
        ];
        
        for (Opportunity opp : updatedOpps) {
            System.assertEquals('Closed Won', opp.StageName, 
                'Stage should be Closed Won');
            System.assertNotEquals(null, opp.CustomField__c, 
                'Custom field should be populated');
        }
        
        // Verify all 200 records processed
        System.assertEquals(200, updatedOpps.size(), 
            'All records should be processed');
    }
    
    /**
     * @description Test with invalid data
     */
    @isTest
    static void test[MethodName]_InvalidData_Error() {
        // Given - Setup with invalid data
        Opportunity opp = new Opportunity(
            Name = 'Test Opp',
            StageName = 'Closed Won',
            CloseDate = Date.today(),
            Amount = null  // Invalid - amount required for closed won
        );
        
        // When/Then - Expect error
        Test.startTest();
        try {
            insert opp;
            System.assert(false, 'Expected DmlException was not thrown');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('Amount is required'), 
                'Error message should mention Amount field');
        }
        Test.stopTest();
    }
    
    /**
     * @description Test bulk processing (200 records)
     */
    @isTest
    static void test[MethodName]_BulkProcessing_Success() {
        // Given - Get all 200 test records
        List<Opportunity> opps = [SELECT Id FROM Opportunity];
        System.assertEquals(200, opps.size(), 'Should have 200 test records');
        
        // When - Process all in one transaction
        Test.startTest();
        // Your bulk operation here
        Test.stopTest();
        
        // Then - Verify no governor limit errors
        System.assertEquals(200, [SELECT COUNT() FROM Opportunity WHERE CustomField__c != null], 
            'All 200 records should be processed');
    }
    
    /**
     * @description Test with user who lacks permissions
     */
    @isTest
    static void test[MethodName]_NoPermissions_Error() {
        // Given - Create user without required permissions
        Profile readOnlyProfile = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        User testUser = new User(
            FirstName = 'Test',
            LastName = 'User',
            Email = 'testuser@example.com',
            Username = 'testuser' + DateTime.now().getTime() + '@example.com',
            Alias = 'tuser',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            ProfileId = readOnlyProfile.Id,
            LanguageLocaleKey = 'en_US'
        );
        insert testUser;
        
        // When/Then - Run as user without permissions
        System.runAs(testUser) {
            Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];
            opp.Amount = 999999;
            
            try {
                update opp;
                System.assert(false, 'Expected exception was not thrown');
            } catch (Exception e) {
                System.assert(e.getMessage().contains('insufficient'), 
                    'Should fail due to insufficient permissions');
            }
        }
    }
    
    /**
     * @description Test external API callout with mock
     */
    @isTest
    static void test[MethodName]_ExternalAPI_Success() {
        // Given - Set mock for HTTP callout
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        // When - Execute code that makes callout
        Test.startTest();
        String result = YourClassName.makeCallout('test-data');
        Test.stopTest();
        
        // Then - Verify mock response was processed
        System.assertNotEquals(null, result, 'Should return data from mock');
        System.assert(result.contains('success'), 'Should process mock response');
    }
}

/**
 * @description Mock HTTP response for testing callouts
 */
@isTest
private class MockHttpResponseGenerator implements HttpCalloutMock {
    public HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"status":"success","data":"test-data"}');
        res.setStatusCode(200);
        return res;
    }
}
```

## Test Coverage Strategies

### For Trigger Handlers

Test each context:
```apex
@isTest static void testBeforeInsert_ValidData_Success() { }
@isTest static void testAfterInsert_ValidData_Success() { }
@isTest static void testBeforeUpdate_ValidData_Success() { }
@isTest static void testAfterUpdate_ValidData_Success() { }
@isTest static void testBeforeDelete_ValidData_Success() { }
@isTest static void testAfterDelete_ValidData_Success() { }
@isTest static void testAfterUndelete_ValidData_Success() { }
```

### For Conditional Logic

Test all branches:
```apex
@isTest static void testMethod_ConditionTrue_BranchA() { }
@isTest static void testMethod_ConditionFalse_BranchB() { }
@isTest static void testMethod_NullValue_DefaultBranch() { }
```

### For Exception Handling

Test error scenarios:
```apex
@isTest static void testMethod_NetworkTimeout_RetryThreeTimes() { }
@isTest static void testMethod_InvalidData_ThrowException() { }
@isTest static void testMethod_DuplicateRecord_MergeData() { }
```

## Best Practices

1. **Use @testSetup**: Create data once, use in all tests
2. **Test.startTest()/stopTest()**: Reset governor limits
3. **200 Records**: Always test bulk processing
4. **System.runAs()**: Test different user contexts
5. **Meaningful Assertions**: Include description messages
6. **Negative Tests**: Test what SHOULD fail
7. **Mock External Calls**: Use Test.setMock()
8. **85%+ Coverage**: Minimum requirement
