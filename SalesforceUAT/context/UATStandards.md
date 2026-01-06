# UAT Test Script Standards

Enterprise standards for UAT test script creation.

## Test Script Structure

### Required Elements

Every UAT test script must include:

1. **Test Script Name** - Clear, descriptive name of what's being tested
2. **Test Script Number** - Sequential identifier (TS-00001, TS-00002, etc.)
3. **Persona** - Who performs this test
4. **Category** - High-level grouping
5. **Sub-Category** - More specific classification
6. **Prerequisites** - Setup required (or "None")
7. **Test Steps** - Numbered, detailed instructions
8. **Expected Results** - Bullet points of expected behavior

### Optional Elements

- **Notes** - Additional context, video links, feedback instructions
- **Known Issues** - Things to watch for
- **Video Walkthrough** - Loom or other video link

## Persona Types

Standard personas:

### Sales User
- Standard sales rep permissions
- Cannot delete or clone records (typically)
- Limited to own records unless shared
- Most common UAT persona

### Manager
- Sales User + team visibility
- Can see/edit team member records
- May have additional approvals

### Admin/IT/IS
- Full administrative access
- View All / Modify All permissions
- Can access setup areas
- Can perform administrative actions (delete, clone)

### All
- Test can be performed by any user
- Usually for general functionality testing
- Often used for initial app onboarding

## Category Types

Standard categories:

### Core Object LEX Pages
- Standard object page layouts (Account, Contact, Lead, Opportunity)
- Record detail pages
- List views
- Related lists

### Validation Rules
- Field validation testing
- Required field checking
- Data quality rules

### Automation (Flows/Triggers)
- Automated field updates
- Record creation/updates
- Email notifications
- Assignment rules

### Permissions & Access
- CRUD permissions testing
- Sharing rules
- Field-level security
- Button/action availability

### Disposition/Status Management
- Lead dispositioning
- Opportunity stage changes
- Case status updates

### Integration
- External system connections
- API functionality
- Data sync testing

### Reporting
- Report accuracy
- Dashboard functionality
- Data visibility

### Admin Access
- Administrative functionality
- Setup access
- Bulk operations

## Test Steps Format

### Numbering Convention

**Main Steps:**
```
1. [First action]
2. [Second action]
3. [Third action]
```

**With Sub-Steps:**
```
1. [Main action]
   a. [First sub-action]
   b. [Second sub-action]
   c. [Third sub-action]
```

**Multiple Levels:**
```
2. [Main action]
   a. [Sub-action]
      i. [Detail]
      ii. [Detail]
   b. [Another sub-action]
```

### Action Verbs

Use specific, clear action verbs:
- **Navigate to** - For moving to tabs/pages
- **Click** - For buttons/links
- **Enter** / **Type** - For text fields
- **Select** - For picklists/dropdowns
- **Set** - For field values
- **Confirm** / **Verify** - For checking results
- **Attempt** - For actions that might fail
- **Review** - For visual inspection

### Field References

Always use exact field labels and API names:

**Good:**
```
3. Set the Disposition Reason field to 'Not Interested'
4. Set Lead Status to 'Nurturing'
```

**Bad:**
```
3. Update the disposition
4. Change the status
```

### Picklist Values

Always include exact picklist value:

**Good:**
```
5. Set Account Type to 'Customer - Direct' (not 'Prospect')
```

**Bad:**
```
5. Change account type to customer
```

## Expected Results Format

### Structure

Use bullet points (•) for each expected behavior:

```
## Expected Results

• [Primary behavior]
• [Secondary behavior]
• [Validation message: "exact text"]
• [UI element that should appear/disappear]
```

### Be Specific

**Good:**
```
• Validation error appears: "Disposition Reason is required when Lead Status is Nurturing or Unqualified"
• Record cannot be saved
• Error message displays at the top of the page in red
```

**Bad:**
```
• Validation fires
• User can't save
```

### Include What SHOULD and SHOULD NOT Happen

```
• Delete button SHOULD be visible for Admin users
• Delete button should NOT be visible for Sales Users
• Clone button SHOULD be available on Contact records
• Clone button should NOT be available on Lead records for standard users
```

## Prerequisites

### When to Include

Include prerequisites if:
- Specific user permissions required
- Test data must exist first
- Settings must be configured
- Another test must be completed first

### Format

```
## Prerequisites

- User must have [specific permission/profile]
- [Object] record must exist: [specific criteria]
- [Feature] must be enabled in Setup
- Complete Test Script TS-00005 before starting this test
```

### When to Say "None"

If the test can be performed with standard access and no special setup:

```
## Prerequisites

None - Sales User with standard lead permissions can complete this test.
```

## Testing Best Practices

### Test Both Positive and Negative

Always test:
- What SHOULD work (positive test)
- What SHOULD fail (negative test)

Example:
```
4. Attempt to save without required field
   - Should see validation error
5. Fill in required field
6. Save again
   - Should save successfully
```

### Test Edge Cases

Include boundary conditions:
- Null/blank values
- Maximum length fields
- Invalid formats
- Special characters

### Test for All Personas

Consider different user experiences:
- What can an Admin do that a Sales User cannot?
- What buttons/actions vary by persona?
- What records are visible to different users?

## Common Test Patterns

### Validation Rule Testing

```
1. Create new record
2. Fill in fields with invalid data
3. Attempt to save
   - Validation error should appear
4. Note exact error message
5. Correct the data
6. Save again
   - Record should save successfully
```

### Permission Testing

```
1. As [Persona], navigate to [Object]
2. Create new record
3. Verify available actions:
   a. Edit - should be present
   b. Delete - should/should not be present
   c. Clone - should/should not be present
4. Attempt to view records owned by others
   - Should/should not be visible
5. Attempt to edit record owned by another user
   - Should/should not be allowed
```

### Automation Testing

```
1. Create record that triggers automation
2. Fill in required fields
3. Save record
4. Verify automated field updates:
   a. [Field] should be set to [Value]
   b. [Field] should be calculated as [Formula]
5. Check for related record creation
   - [Related Object] should be created automatically
6. Verify notification sent
   - Email should be sent to [Recipient]
```

### Page Layout Testing

```
1. Navigate to [Object] record
2. Review field visibility:
   a. [Field] should be visible
   b. [Field] should be hidden
3. Review field groupings:
   - Are related fields grouped logically?
4. Review action buttons:
   a. [Button] should be present
   b. [Button] should not be present
5. Provide feedback on layout usability
```

## Video Walkthrough Links

When available, include Loom or other video links:

```
## Notes

- Pay special attention to [specific aspect]
- If you encounter [issue], note it in feedback

Video Walkthrough:
https://www.loom.com/share/[video-id]
```

## Feedback Instructions

Encourage testers to provide detailed feedback:

```
## Notes

- If you encounter any issues, please document:
  - Exact error message
  - Steps you performed
  - What you expected vs what happened
- If you have suggestions for layout improvements, include:
  - Which fields should be moved/added/removed
  - How groupings could be improved
  - Any confusing labels or fields
```

## Test Script Numbering

Follow sequential numbering:
- TS-00000 - Onboarding/intro test
- TS-00001, TS-00002, etc. - Feature tests
- Group related tests with consecutive numbers

## Quality Checklist

Good UAT test script has:
- [ ] Clear, descriptive name
- [ ] Appropriate persona assigned
- [ ] Category and sub-category defined
- [ ] Prerequisites stated (or "None")
- [ ] Numbered test steps with specific actions
- [ ] Exact field names and values
- [ ] Sub-steps for complex actions
- [ ] Expected results with specific behaviors
- [ ] Tests both positive and negative scenarios
- [ ] Clear success criteria
- [ ] Feedback instructions if needed

## Example Template Application

```markdown
# Test Script: [Feature Name]

**Test Script Number:** TS-[####]  
**Persona:** [Sales User | Manager | Admin/IT/IS | All]  
**Category:** [Category]  
**Sub-Category:** [Sub-Category]

---

## Prerequisites

[Specific requirements or "None"]

---

## Test Steps

1. [First action with navigation]

2. [Second action with specific values]:
   a. [Field]: [Value]
   b. [Field]: [Value]

3. [Action that might fail]
   - [What should happen]

4. [Verification step]

---

## Expected Results

• [Primary expected behavior]
• [Validation behavior]
• [UI element behavior]

---

## Notes

[Optional: Additional context or video links]
```
