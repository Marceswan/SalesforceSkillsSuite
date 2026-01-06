# Standard Test Script Workflow

Generate comprehensive UAT test scripts for end users.

## Purpose

UAT test scripts are for **end users** (not QA or developers) to validate that Salesforce features work as expected in real-world scenarios.

## Input Requirements

Gather from the user:
1. **Feature/Functionality**: What is being tested?
2. **Persona**: Who should perform this test? (Sales User, Manager, Admin, etc.)
3. **Category**: Broad grouping (Core Object Pages, Validation Rules, Automation, etc.)
4. **Scenarios**: What specific scenarios need testing?
5. **Prerequisites**: Any setup required before testing?

## Template Structure

```markdown
# Test Script: [Descriptive Name]

**Test Script Number:** [TS-####]  
**Persona:** [Sales User | Manager | Admin/IT/IS | All]  
**Category:** [Category Name]  
**Sub-Category:** [More specific grouping]

---

## Prerequisites

[Any setup or permissions needed before starting. If none, state "None"]

- User must have [permission/access]
- [Specific data/records] must exist
- [Feature/setting] must be enabled

---

## Test Steps

[Numbered steps with specific click-paths and actions. Include sub-steps with letters.]

1. [First major action with specific navigation]
   
2. [Second action with field names and values]
   a. [Sub-step with specific detail]
   b. [Another sub-step]
   
3. [Action that should trigger validation/automation]

4. [Verification step - what to check]

5. [Additional scenarios or edge cases]

---

## Expected Results

[Bullet points describing what the tester should see/experience]

• [Primary expected behavior]
• [Secondary expected behavior]
• [Validation messages that should appear]
• [UI elements that should be visible/hidden]
• [Data that should be updated]

---

## Notes

[Optional: Additional context, known issues, or feedback instructions]

- If you encounter [specific issue], please note it in the test instance
- Pay special attention to [specific aspect]
- [Link to video walkthrough if available]
```

## Execution Steps

### Step 1: Define Test Metadata

Extract:
- **Test Script Name**: Clear, descriptive (what feature/scenario)
- **Persona**: Primary user role who performs this test
- **Category**: High-level grouping
  - Core Object LEX Pages
  - Validation Rules
  - Automation (Flows/Triggers)
  - Permissions & Access
  - Integration
  - Reporting
- **Sub-Category**: Specific feature area

### Step 2: Identify Prerequisites

List any setup needed:
- User permissions required
- Test data that must exist
- Settings/configuration that must be enabled
- Previous tests that must be completed first

If no prerequisites: State "None"

### Step 3: Write Test Steps

Use this format:

**Numbered Main Steps:**
```
1. [Action with specific navigation path]
```

**With Sub-Steps:**
```
2. [Main action]
   a. [Specific sub-action]
   b. [Another sub-action]
   c. [Final sub-action]
```

**Click-Path Format:**
```
1. Navigate to the Leads tab
2. Click the "New" button to create a new lead
3. In the Lead form, enter the following values:
   a. Company: "Test Company"
   b. Last Name: "Test Lead"
   c. Lead Status: "New"
4. Click "Save"
```

**Field-Specific Format:**
```
3. Set the Disposition Reason value to '-None-'
4. Set Lead Status to 'Nurturing'
5. Attempt to save
```

**Verification Steps:**
```
6. Confirm that the following action buttons are present:
   a. Edit
   b. Change Owner
   c. Add to Campaign
7. Confirm that the Delete button is NOT present
```

### Step 4: Define Expected Results

Write as bullet points:
- What should the user see?
- What should happen to the data?
- What validations should fire?
- What UI elements should appear/disappear?

Format:
```
• [Primary expected behavior with specific outcome]
• [Validation message: "exact text of the error"]
• [UI element that should be visible/hidden]
• [Data that should be automatically populated]
```

### Step 5: Add Notes (if applicable)

Include:
- Links to video walkthroughs
- Feedback instructions
- Known issues to watch for
- Important context

## Real Example: Validation Rule Test

```markdown
# Test Script: Dispositioning Nurture/Unqualified Leads

**Test Script Number:** TS-00015  
**Persona:** Sales User  
**Category:** Disposition Leads  
**Sub-Category:** Nurture/Unqualified Leads

---

## Prerequisites

None - Sales User with standard lead permissions can complete this test.

---

## Test Steps

1. Create a new test lead record by clicking "New" on the Leads tab.

2. Fill in required fields:
   a. Company: "UAT Test Company"
   b. Last Name: "UAT Test Lead"
   c. Lead Status: Leave as default "New"

3. Save the record to create the lead.

4. Edit the lead record and set the following values:
   a. Disposition Reason: Leave as '-None-'
   b. Lead Status: 'Nurturing'

5. Attempt to save the record.
   - A validation error should prevent saving

6. Note the validation error message that appears.

7. Now select any Disposition Reason from the picklist (e.g., "Not Interested").

8. Attempt to save the record again.
   - The record should save successfully

9. Edit the lead again and test the 'Unqualified' status:
   a. Disposition Reason: Change back to '-None-'
   b. Lead Status: 'Unqualified'

10. Attempt to save.
    - A validation error should prevent saving

11. Select a Disposition Reason value.

12. Save the record.
    - The record should save successfully

---

## Expected Results

• A validation rule should prevent a Sales User from saving a lead record without a disposition reason when the lead status is updated to 'Nurturing' or 'Unqualified'

• The validation error message should clearly indicate that a Disposition Reason is required

• When a Disposition Reason is selected, the record should save successfully

• The validation should only fire when Lead Status is 'Nurturing' or 'Unqualified' (not for other statuses)

---

## Notes

- This validation ensures proper lead disposition tracking for reporting
- If the validation does not fire, please note this in your test instance feedback
- Make sure to test both 'Nurturing' and 'Unqualified' statuses
```

## Real Example: Page Layout Test

```markdown
# Test Script: Standard User Contact Page Layout

**Test Script Number:** TS-00002  
**Persona:** Sales User  
**Category:** Core Object LEX Pages  
**Sub-Category:** Contact Page Layout

---

## Prerequisites

User must be logged in as a Sales User (non-manager) with standard contact permissions.

---

## Test Steps

1. Navigate to the Contacts tab.

2. Click "New" to create a new Contact record.

3. Fill in the required fields:
   a. First Name: "Test"
   b. Last Name: "Contact UAT"
   c. Email: "testcontact@uattest.com"
   d. Account Name: Select or create a test account

4. Click "Save" to create the contact.

5. Once the record is created, review the Highlights Panel in the top-right corner of the page.

6. Confirm the following action buttons ARE present:
   a. Edit
   b. Change Owner
   c. Email (Send Email action)
   d. Any other standard actions

7. Confirm the following action buttons are NOT present:
   a. Delete
   b. Clone

8. Review the overall page layout and note any feedback:
   a. Are field groupings logical?
   b. Are the most important fields easily visible?
   c. Are there any fields specific to your territory/team that should be added?
   d. Are there any fields that are confusing or unnecessary?

9. Include any layout optimization suggestions in the test instance notes.

---

## Expected Results

• User can create a new Contact record successfully

• Action buttons in the Highlights Panel are appropriate for a Sales User:
  - Edit, Change Owner, and other standard actions are available
  - Delete and Clone buttons are NOT available (admin-only actions)

• Page layout is functional and intuitive for daily use

• All required fields are clearly marked

• Field groupings make sense for the sales process

---

## Notes

- This test validates both permissions (button visibility) and usability (layout design)
- Please provide specific feedback on layout improvements in the test instance notes
- Video Walkthrough: https://www.loom.com/share/0f98566c88b04c5c89417882ba1bb026
```

## Real Example: Admin Permissions Test

```markdown
# Test Script: System Administrator Permissions

**Test Script Number:** TS-00009  
**Persona:** Admin/IT/IS  
**Category:** Admin Access  
**Sub-Category:** Administrative Permissions

---

## Prerequisites

User must be logged in with System Administrator profile or equivalent administrative permissions.

---

## Test Steps

1. Test Account object permissions:
   a. Navigate to the Accounts tab
   b. Click "New" to create a test account
   c. Save the record (Create permission verified)
   d. Edit and update a field (Edit permission verified)
   e. Delete the test record (Delete permission verified)
   f. Verify "View All" by checking records owned by other users
   g. Verify "Modify All" by editing a record owned by another user

2. Test Contact object permissions:
   a. Navigate to the Contacts tab
   b. Create a new test contact (Create permission)
   c. Verify the following action buttons are present:
      - Edit
      - Delete
      - Clone
      - Add to Campaign
      - Any cadence-related actions
   d. Verify "View All" and "Modify All" by accessing contacts owned by others
   e. Test the "Clone" button to verify it works
   f. If available, test "Assign to Multi-Lingual user" action

3. Test Lead object permissions:
   a. Navigate to the Leads tab
   b. Create a new test lead (Create permission)
   c. Verify the following action buttons are present:
      - Edit
      - Delete
      - Clone
      - Change Owner
      - Convert
      - Add to Campaign
      - Cadence actions (if applicable)
   d. Verify "View All" and "Modify All"
   e. Test the "Clone" button

4. Test Opportunity object permissions:
   a. Navigate to the Opportunities tab
   b. Create a new test opportunity (Create permission)
   c. Verify the following action buttons are present:
      - Edit
      - Delete
      - Clone
      - Change Owner
   d. Verify "View All" and "Modify All"
   e. Test the "Clone" button

---

## Expected Results

• Admin user has full CRUD (Create, Read, Edit, Delete) permissions on all standard objects

• "View All" permission allows admin to see all records regardless of owner

• "Modify All" permission allows admin to edit any record regardless of owner

• All administrative action buttons are present and functional:
  - Delete (admin-only)
  - Clone (admin-only in some objects)
  - Assign to Cadence (if High Velocity Sales is enabled)
  - All standard actions

• Admin can perform actions that standard users cannot (verified by button availability)

---

## Notes

- This test validates that admin-level permissions are correctly configured
- Compare these permissions to those available to Sales Users to verify proper security
- CRED = Create, Read, Edit, Delete permissions
```

## Best Practices

### Writing Clear Steps

**Good:**
```
3. Set the Disposition Reason field to '-None-' (leave blank)
4. Set Lead Status to 'Nurturing'
5. Click the "Save" button
```

**Bad:**
```
3. Update the lead fields
4. Try to save
```

### Specific Field Names

**Good:**
```
2. In the Lead form, enter:
   a. Company: "Test Company"
   b. Last Name: "Test Lead"
   c. Lead Status: "New"
```

**Bad:**
```
2. Fill in the lead information
```

### Testing Both Positive and Negative

**Good:**
```
5. Attempt to save without selecting a Disposition Reason
   - Validation error should appear
6. Select a Disposition Reason
7. Save again
   - Record should save successfully
```

**Bad:**
```
5. Make sure validation works
```

### Clear Expected Results

**Good:**
```
• Validation error message appears: "Disposition Reason is required when Lead Status is Nurturing or Unqualified"
• Record cannot be saved until Disposition Reason is selected
• After selecting Disposition Reason, record saves successfully
```

**Bad:**
```
• Validation should work correctly
```

## Common Scenarios

### Testing Validation Rules
- Create record with valid data (should succeed)
- Create record with invalid data (should fail with specific message)
- Verify exact error message text
- Test boundary conditions

### Testing Page Layouts
- Verify field visibility
- Check field groupings
- Verify action button availability
- Test persona-specific differences

### Testing Automation
- Trigger the automation condition
- Verify expected field updates
- Check related record creation/updates
- Verify notifications/emails sent

### Testing Permissions
- Test CRUD operations for persona
- Verify View All / Modify All (if applicable)
- Check action button visibility
- Test sharing/visibility rules

## Tips for UAT Scripts

1. **Be Specific**: Use exact field names, button labels, error messages
2. **Number Everything**: Make it easy to reference specific steps
3. **Test Edge Cases**: Include scenarios that should fail
4. **User Language**: Write for end users, not developers
5. **Click-Path**: Exact navigation (Tab → Button → Field)
6. **Expected Results**: Clear success criteria
7. **Prerequisites**: Don't assume setup is already done
8. **Feedback Loop**: Encourage testers to note issues/suggestions
