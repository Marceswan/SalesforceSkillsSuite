---
name: SalesforceTesting
description: Generate Salesforce test classes, test data builders, and test scenarios. USE WHEN user mentions test class, unit test, test coverage, test data, mock, OR says generate, create, write followed by test, testing, or coverage.
---

# Salesforce Testing

Generate comprehensive test classes following Salesforce best practices and established testing patterns.

## Workflow Routing

- **Apex Test Class** → `workflows/ApexTestClass.md`
  - When: Creating test class for Apex code
  - Use for: Trigger handlers, controllers, service classes
  
- **LWC Test** → `workflows/LWCTest.md`
  - When: Creating Jest tests for Lightning Web Components
  - Use for: Component logic, event handling, API calls
  
- **Test Data Builder** → `workflows/TestDataBuilder.md`
  - When: Creating reusable test data factories
  - Use for: Creating consistent test data across test classes

## Examples

**Example 1: Apex Test Class**
```
User: "Generate test class for OpportunityTriggerHandler"
→ Creates comprehensive test class with:
  - @testSetup for data
  - Tests for all trigger contexts
  - Bulk testing (200 records)
  - Negative test cases
  - 85%+ coverage guaranteed
```

**Example 2: Test Data Builder**
```
User: "Create a test data builder for Account and Opportunity"
→ Generates builder pattern class
→ Includes realistic defaults
→ Chainable methods for customization
```

## Key Patterns

- **Test Setup Method**: Use @testSetup for data creation
- **Given/When/Then**: Clear test structure
- **Bulk Testing**: Always test with 200 records
- **Assertions**: System.assertEquals with meaningful messages
- **Test Isolation**: Each test is independent
- **85% Coverage**: Minimum requirement
