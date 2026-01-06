# Salesforce UAT Test Script Generator

Generate comprehensive UAT (User Acceptance Testing) test scripts for end users with click-path instructions, action steps, and expected results.

## What It Generates

- **Standard Test Scripts**: Single feature/scenario tests
- **Multi-Scenario Tests**: Complex features with multiple user paths
- **Regression Test Suites**: Collections of tests for validation

## Format

Based on enterprise UAT best practices:
- Clear test script names
- Persona-based (Sales User, Manager, Admin)
- Numbered step-by-step instructions
- Specific field names and values
- Expected results as bullet points
- Prerequisites clearly stated

## Installation

```bash
cp -r SalesforceUAT $PAI_DIR/Skills/
```

## Usage

```
"Create UAT test script for lead disposition validation"
"Generate UAT for Contact page layout with action buttons"
"Create UAT test for admin vs standard user permissions on Opportunity"
```

## Real-World Example

**Input:**
```
"Create UAT test script for validating that sales users must enter a disposition reason when marking leads as Nurturing or Unqualified"
```

**Output:**
```markdown
# Test Script: Dispositioning Nurture/Unqualified Leads

**Test Script Number:** TS-00015  
**Persona:** Sales User  
**Category:** Disposition Leads  
**Sub-Category:** Nurture/Unqualified Leads

## Prerequisites
None - Sales User with standard lead permissions can complete this test.

## Test Steps
1. Create a new test lead record
2. Set Disposition Reason to '-None-' and Lead Status to 'Nurturing'
3. Attempt to save - validation should prevent saving
4. Select a Disposition Reason
5. Save again - should save successfully
6. Repeat for 'Unqualified' status

## Expected Results
• Validation prevents saving without Disposition Reason
• Error message clearly states requirement
• Record saves successfully when Disposition Reason selected
```

## Key Features

- ✅ Persona-specific test scripts
- ✅ Numbered, detailed steps
- ✅ Specific field names and values
- ✅ Click-path instructions
- ✅ Tests both positive and negative scenarios
- ✅ Clear expected results
- ✅ Prerequisites documented

## Workflows

- **StandardTestScript.md** - Single feature tests
- **MultiScenarioTest.md** - Complex features
- **RegressionTestSuite.md** - Test collections

## Benefits

- **End-User Friendly**: Written for non-technical users
- **Executable**: Testers can follow exactly
- **Comprehensive**: Covers positive and negative cases
- **Consistent**: Same format every time
- **Time Savings**: 30-60 minutes → 2 minutes per test script
