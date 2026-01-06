# Multi-Scenario Test Workflow

Generate UAT test scripts for features with multiple scenarios or user paths.

## When to Use

Use this workflow when testing:
- Features with multiple possible outcomes
- Complex business processes with branching paths
- Features that vary significantly by persona
- Integration points with multiple scenarios

## Template

```markdown
# Test Script: [Feature Name]

**Test Script Number:** TS-[####]  
**Persona:** [Persona or "Multiple"]  
**Category:** [Category]  
**Sub-Category:** [Sub-Category]

---

## Overview

[Brief description of what this test covers and why multiple scenarios are needed]

---

## Prerequisites

[Any setup required for ALL scenarios]

- [Prerequisite 1]
- [Prerequisite 2]

---

## Scenario 1: [Scenario Name]

**Persona:** [If different from main]  
**Purpose:** [What this scenario tests]

### Test Steps

1. [Step with specific action]
2. [Step with specific values]
3. [Verification step]

### Expected Results

• [What should happen in this scenario]
• [Specific behaviors]

---

## Scenario 2: [Scenario Name]

**Persona:** [If different from main]  
**Purpose:** [What this scenario tests]

### Test Steps

1. [Step with specific action]
2. [Step with different values than Scenario 1]
3. [Verification step]

### Expected Results

• [What should happen in this scenario]
• [How it differs from Scenario 1]

---

## Scenario 3: [Edge Case Name]

**Purpose:** [What edge case this tests]

### Test Steps

1. [Step that triggers edge case]
2. [Verification that system handles it correctly]

### Expected Results

• [How system should handle this edge case]

---

## Summary

[Brief summary of all scenarios and what they validate together]

---

## Notes

[Any additional context, known issues, or feedback instructions]
```

## Real Example: Opportunity Routing with Multiple Outcomes

```markdown
# Test Script: Multi-Team Opportunity Routing

**Test Script Number:** TS-00125  
**Persona:** Multiple (Sales User + Manager)  
**Category:** Automation  
**Sub-Category:** Opportunity Assignment

---

## Overview

This test validates that opportunities automatically route to the correct team based on territory, product, and deal size. It covers multiple routing scenarios including Enterprise, Mid-Market, and SMB teams.

---

## Prerequisites

- User must have access to create opportunities
- Territory assignments must be configured in the system
- Test accounts in different territories must exist:
  - Account in California (for Enterprise routing)
  - Account in Texas (for Mid-Market routing)
  - Account in Florida (for SMB routing)

---

## Scenario 1: Enterprise Team Routing

**Purpose:** Validate that large deals in specific territories route to Enterprise team

### Test Steps

1. Navigate to the Opportunities tab

2. Click "New" to create a new opportunity

3. Fill in the following values:
   a. Opportunity Name: "Enterprise Test Opp"
   b. Account: Select the California test account
   c. Close Date: 30 days from today
   d. Stage: "Prospecting"
   e. Amount: $500,000
   f. Product: "Enterprise Tax Software"

4. Click "Save"

5. After save, verify the following fields are automatically populated:
   a. Territory: Should be "California Enterprise"
   b. Assigned Team: Should be "Enterprise"
   c. Owner: Should be assigned to Enterprise queue or rep
   d. Routing Reason: Should document why Enterprise team was selected

6. Check the opportunity Activity Timeline for routing log entry

### Expected Results

• Opportunity automatically routes to Enterprise team based on territory + amount
• Territory field is populated with matching territory
• Assigned Team field is set to "Enterprise"
• Owner is assigned to Enterprise sales team or queue
• Routing Reason documents: "Enterprise team - California territory, Amount: $500K"
• Activity log shows automatic routing occurred

---

## Scenario 2: Mid-Market Team Routing

**Purpose:** Validate that medium-sized deals route to Mid-Market team

### Test Steps

1. Create a new opportunity with:
   a. Opportunity Name: "Mid-Market Test Opp"
   b. Account: Select the Texas test account
   c. Close Date: 30 days from today
   d. Stage: "Prospecting"
   e. Amount: $150,000
   f. Product: "Professional Tax Software"

2. Save the opportunity

3. Verify automatic field population:
   a. Territory: "Texas Mid-Market"
   b. Assigned Team: "Mid-Market"
   c. Owner: Mid-Market queue or rep
   d. Routing Reason: Documents Mid-Market assignment

### Expected Results

• Opportunity routes to Mid-Market team based on amount range ($100K-$500K)
• Territory matches account location
• Assigned Team is "Mid-Market"
• Routing Reason documents: "Mid-Market team - Texas territory, Amount: $150K"

---

## Scenario 3: SMB Team Routing

**Purpose:** Validate that smaller deals route to SMB team

### Test Steps

1. Create a new opportunity with:
   a. Opportunity Name: "SMB Test Opp"
   b. Account: Select the Florida test account
   c. Close Date: 30 days from today
   d. Stage: "Prospecting"
   e. Amount: $25,000
   f. Product: "Basic Tax Software"

2. Save the opportunity

3. Verify automatic field population:
   a. Territory: "Florida SMB"
   b. Assigned Team: "SMB"
   c. Owner: SMB queue or rep
   d. Routing Reason: Documents SMB assignment

### Expected Results

• Opportunity routes to SMB team based on amount (<$100K)
• Territory matches account location
• Assigned Team is "SMB"
• Routing Reason documents: "SMB team - Florida territory, Amount: $25K"

---

## Scenario 4: No Territory Match

**Purpose:** Validate handling when no territory matches

### Test Steps

1. Create a new opportunity with:
   a. Opportunity Name: "Unassigned Test Opp"
   b. Account: Create a test account with State: "Alaska" (no territory)
   c. Close Date: 30 days from today
   d. Stage: "Prospecting"
   e. Amount: $100,000

2. Save the opportunity

3. Verify default routing:
   a. Territory: Should be blank or "Unassigned"
   b. Assigned Team: Should be blank or "Unassigned"
   c. Owner: Should be assigned to "Unassigned Opportunities" queue
   d. Routing Reason: Should document no territory match

4. Verify approval process:
   a. Opportunity should be submitted for manual routing approval
   b. Sales Manager should receive notification

### Expected Results

• When no territory matches, opportunity routes to default "Unassigned" queue
• Approval process automatically triggers for manual review
• Sales Manager receives notification email
• Routing Reason documents: "No territory match - requires manual assignment"
• Opportunity is flagged for Sales Ops review

---

## Scenario 5: Territory Overlap (Multiple Matches)

**Purpose:** Validate priority handling when multiple territories match

### Test Steps

1. Create opportunity in overlapping territory:
   a. Opportunity Name: "Overlap Test Opp"
   b. Account: Select account in overlapping territory zone
   c. Amount: $300,000 (could match multiple teams)
   d. Product: Select product available to multiple teams

2. Save the opportunity

3. Verify priority routing:
   a. Check which team was assigned
   b. Verify Routing Reason explains priority logic

### Expected Results

• System selects team with highest priority rating for territory
• Routing Reason documents: "Multiple matches - selected Enterprise (Priority 1)"
• Only one team is assigned (not multiple)
• Assignment follows documented priority hierarchy

---

## Scenario 6: Manager Override

**Purpose:** Validate that managers can manually override automatic routing

### Test Steps

**Persona:** Manager

1. Open any opportunity from previous scenarios

2. Click "Change Owner" button

3. Select a different owner from a different team

4. In the override reason field, enter: "Manual reassignment - customer request"

5. Save the change

6. Verify that:
   a. Owner changes to selected user
   b. Assigned Team updates to match new owner's team
   c. Routing Reason is preserved but marked as "Manually Overridden"
   d. Override is logged in Activity Timeline

7. Make additional changes to the opportunity (amount, product)

8. Save changes

9. Verify automatic routing does NOT override manual assignment

### Expected Results

• Manager can manually override automatic routing
• Manual assignments are preserved even when opportunity is updated
• System logs the override with reason
• Automatic routing respects manual overrides
• Only authorized users (Manager profile) can override

---

## Summary

This test validates the complete opportunity routing system including:

✓ Enterprise team routing ($500K+)
✓ Mid-Market team routing ($100K-$500K)
✓ SMB team routing (<$100K)
✓ Default handling for no territory match
✓ Priority logic for overlapping territories
✓ Manual override capability for managers

All routing decisions are logged in Routing Reason field and Activity Timeline.

---

## Notes

- Pay special attention to the Routing Reason field - it should clearly document WHY each assignment was made
- If any routing seems incorrect, note the specific territory, amount, and product combination in your feedback
- Test the timing - routing should occur within 2 seconds of saving
- Verify that bulk opportunity creation (import 10+ records) also routes correctly

Video Walkthrough:
https://www.loom.com/share/[video-id]
```

## Real Example: Permission Variations

```markdown
# Test Script: Record Access by Persona

**Test Script Number:** TS-00089  
**Persona:** Multiple  
**Category:** Permissions & Access  
**Sub-Category:** Record Visibility

---

## Overview

This test validates that different user personas see appropriate records and have appropriate actions available.

---

## Prerequisites

- Test accounts and opportunities must be created by different users
- User hierarchy must be configured (Manager > Sales User)

---

## Scenario 1: Sales User - Own Records Only

**Persona:** Sales User  
**Purpose:** Validate Sales User sees only their own records

### Test Steps

1. As Sales User, navigate to Opportunities tab

2. Review the list view

3. Verify you see ONLY opportunities where:
   a. You are the owner, OR
   b. Record has been explicitly shared with you

4. Attempt to search for opportunities owned by others

5. Try to open an opportunity owned by another user

### Expected Results

• Sales User sees only own records in list views
• Cannot search for or access records owned by others
• Receives "Insufficient Privileges" error when attempting to access others' records
• Can see records explicitly shared with them

---

## Scenario 2: Manager - Team Records

**Persona:** Manager  
**Purpose:** Validate Manager sees team records

### Test Steps

1. As Manager, navigate to Opportunities tab

2. Review the list view

3. Verify you see:
   a. Your own records
   b. Records owned by your direct reports
   c. Records in your team's queue

4. Open an opportunity owned by a direct report

5. Edit the opportunity and verify you can save changes

### Expected Results

• Manager sees own records plus team members' records
• Can open and edit team members' records
• List views automatically filter to "My Team's Opportunities"
• Has full edit access to team records

---

## Scenario 3: Admin - All Records

**Persona:** Admin/IT/IS  
**Purpose:** Validate Admin has "View All" and "Modify All"

### Test Steps

1. As Admin, navigate to Opportunities tab

2. Change list view to "All Opportunities"

3. Verify you see ALL opportunities in the system regardless of owner

4. Open an opportunity owned by any user

5. Edit and save changes

### Expected Results

• Admin sees all records regardless of owner or sharing
• Can edit any record ("Modify All" permission)
• No "Insufficient Privileges" errors
• Has access to all list views and filters

---

## Summary

Record visibility correctly enforces hierarchy:
- Sales Users: Own records only
- Managers: Own + team records
- Admins: All records

---

## Notes

This test is critical for data security - record access must follow the defined hierarchy.
```

## Tips for Multi-Scenario Tests

1. **Clearly Label Each Scenario**: Use descriptive names
2. **State Purpose**: Why this scenario matters
3. **Link Scenarios**: Reference how they relate
4. **Test Boundaries**: Where one scenario ends and another begins
5. **Summary**: Tie all scenarios together at the end
6. **Common Prerequisites**: List shared setup once at top
7. **Scenario-Specific Setup**: Include if scenarios need different setup
