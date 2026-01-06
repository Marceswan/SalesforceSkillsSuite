---
name: SalesforceUAT
description: Generate comprehensive UAT (User Acceptance Testing) test scripts for end users with click-path instructions, action steps, and expected results. USE WHEN user mentions UAT, user acceptance testing, test script, testing script, end user testing, OR says generate, create, write followed by UAT, test script, or testing instructions.
---

# Salesforce UAT Test Scripts

Generate comprehensive UAT test scripts for end users following enterprise best practices with numbered steps, click-paths, and expected results.

## Workflow Routing

**When executing a workflow, do BOTH of these:**

1. **Call the notification script** (for observability tracking):
   ```bash
   ~/.claude/Tools/SkillWorkflowNotification WORKFLOWNAME SalesforceUAT
   ```

2. **Output the text notification** (for user visibility):
   ```
   Running the **WorkflowName** workflow from the **SalesforceUAT** skill...
   ```

### Workflow Selection

- **Standard Test Script** → `workflows/StandardTestScript.md`
  - When: Creating UAT test for a single feature or scenario
  - Use for: Object layouts, validation rules, automation, permissions
  
- **Multi-Scenario Test** → `workflows/MultiScenarioTest.md`
  - When: Testing multiple related scenarios or user paths
  - Use for: Complex features with multiple outcomes
  
- **Regression Test Suite** → `workflows/RegressionTestSuite.md`
  - When: Creating suite of tests for existing functionality
  - Use for: Post-deployment validation, release testing

## Examples

**Example 1: Validation Rule Testing**
```
User: "Create UAT test script for lead disposition validation"
→ Generates test script with:
  - Test Script Name
  - Persona (Sales User)
  - Category & Sub-Category
  - Numbered test steps with specific actions
  - Expected results (validation fires correctly)
```

**Example 2: Page Layout Testing**
```
User: "Generate UAT script for Contact page layout with action buttons"
→ Creates complete test with:
  - Click-path instructions
  - Field verification steps
  - Button availability checks
  - Expected UI elements
```

**Example 3: Permission Testing**
```
User: "Create UAT for admin vs standard user permissions on Opportunity"
→ Generates tests for both personas:
  - Admin capabilities (CRUD, View All, Modify All)
  - Standard user restrictions
  - Action button differences
```

## Key Patterns

This skill follows enterprise UAT standards:

- **Numbered Steps**: Clear 1, 2, 3 sequence with sub-steps (a, b, c)
- **Click-Path Instructions**: Exact navigation and field names
- **Specific Actions**: "Set field X to value Y", "Click button Z"
- **Expected Results**: Bullet points of what should happen
- **Persona-Based**: Tests written for specific user roles
- **Validation Verification**: Tests for both positive and negative cases

## Context Files

- `UATStandards.md` - enterprise best practices and best practices
- `CommonPersonas.md` - Standard personas and their typical permissions
- `TestCategories.md` - Standard categories and sub-categories

## Success Criteria

Good UAT test scripts from this skill should:
1. Be executable by non-technical end users
2. Have clear, numbered step-by-step instructions
3. Include specific field names and values
4. Define expected results for each scenario
5. Test both positive (should work) and negative (should fail) cases
6. Be appropriate for the target persona
7. Include prerequisites if needed
