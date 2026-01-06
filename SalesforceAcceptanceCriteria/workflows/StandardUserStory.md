# Standard User Story Workflow

Generate comprehensive acceptance criteria for a single Salesforce user story.

## Input Requirements

Gather from the user:
1. **User Story** - The core requirement (As a [role], I want [capability] so that [benefit])
2. **Context** - What Salesforce objects/features are involved
3. **Scope** - Is this a new feature, enhancement, or bug fix?
4. **Complexity** - Simple, medium, or complex?

## Execution Steps

### Step 1: Parse the User Story

Extract:
- **Role/Persona**: Who is the user?
- **Capability**: What do they want to do?
- **Business Value**: Why does this matter?
- **Salesforce Objects**: What data is involved?
- **Feature Type**: UI, automation, data, integration?

### Step 2: Generate Core Acceptance Criteria

Create acceptance criteria following this structure:

#### Functional Requirements
- Primary happy path scenario
- User interface requirements (if applicable)
- Data requirements (fields, objects, relationships)
- Business logic and rules

#### Edge Cases and Validation
- What happens when required data is missing?
- What happens with invalid data?
- What happens with duplicate records?
- What happens when related records don't exist?
- What happens with permissions/sharing issues?

#### Security and Access
- Who can perform this action?
- What field-level security applies?
- What record-level security applies?
- Are there any sharing rule implications?

#### Error Handling
- What error messages should users see?
- How should system errors be logged?
- What's the graceful degradation path?

#### Testing Requirements
- Unit test scenarios
- Integration test scenarios  
- User acceptance test scenarios
- Regression test considerations

### Step 3: Add Technical Implementation Guidance

Include:
- **Fields Required**: List custom fields with types and descriptions
- **Automation Type**: Flow, Apex trigger, Process Builder, etc.
- **Validation Rules**: Specific error conditions
- **Integration Points**: If calling external systems
- **Performance Considerations**: Bulk operations, governor limits

### Step 4: Format the Output

```markdown
# User Story: [Title]

**As a** [role]  
**I want** [capability]  
**So that** [benefit]

## Acceptance Criteria

### Functional Requirements

**AC 1: [Primary Happy Path]**
- Given [precondition]
- When [action]
- Then [expected result]

**AC 2: [Additional Requirement]**
- Given [precondition]
- When [action]
- Then [expected result]

### Edge Cases and Validation

**AC 3: [Edge Case Name]**
- Given [unusual condition]
- When [action]
- Then [how system should handle it]

**AC 4: [Validation Rule]**
- Given [invalid data condition]
- When [user attempts action]
- Then [validation error message shown]

### Security and Access

**AC 5: [Permission Check]**
- Given [user with/without permission]
- When [attempts action]
- Then [allowed/denied with message]

### Error Handling

**AC 6: [Error Scenario]**
- Given [error condition]
- When [action triggers error]
- Then [graceful error message displayed]

### Testing Requirements

**Unit Tests Required:**
- [ ] Test case 1
- [ ] Test case 2

**Integration Tests Required:**
- [ ] Test case 1
- [ ] Test case 2

**UAT Scenarios:**
- [ ] Happy path with real data
- [ ] Edge case scenario 1
- [ ] Edge case scenario 2

## Technical Implementation Notes

### Fields Required
| Field API Name | Type | Description | Required? |
|----------------|------|-------------|-----------|
| Field1__c | Text(255) | Purpose | Yes |
| Field2__c | Picklist | Options: A, B, C | No |

### Automation
- **Type**: Flow / Apex Trigger / Process Builder
- **Trigger Object**: [Object API Name]
- **Trigger Event**: [Before/After Insert/Update/Delete]

### Validation Rules
```apex
// Rule Name: Descriptive_Name
// Error Condition: [condition]
// Error Message: "[User-friendly message]"
AND(
  ISBLANK(Field1__c),
  ISPICKVAL(Status__c, "Active")
)
```

### Performance Considerations
- Expected record volume: [estimate]
- Bulk operation support: Yes/No
- Governor limit concerns: [list any]

## Definition of Done
- [ ] All acceptance criteria tests pass
- [ ] Code review completed
- [ ] Unit test coverage >= 85%
- [ ] Documentation updated
- [ ] UAT sign-off obtained
```

## Example Output

For a user story: "As a Sales Rep, I want leads to automatically assign to me based on my territory so that I can follow up quickly"

```markdown
# User Story: Territory-Based Lead Assignment

**As a** Sales Rep  
**I want** leads to automatically assign to me based on my territory  
**So that** I can follow up quickly with prospects in my region

## Acceptance Criteria

### Functional Requirements

**AC 1: Lead Auto-Assignment Based on Territory**
- Given a new lead is created with a valid state/postal code
- When the lead's state matches my territory assignment
- Then the lead owner is automatically set to me
- And I receive an email notification about the new lead

**AC 2: Territory Assignment Priority**
- Given multiple sales reps have overlapping territory assignments
- When a lead is created in the overlap zone
- Then the lead assigns to the rep with the highest priority score
- And the assignment logic is documented in the lead history

### Edge Cases and Validation

**AC 3: No Matching Territory**
- Given a lead is created with a state that doesn't match any territory
- When the auto-assignment process runs
- Then the lead assigns to the default queue "Unassigned Leads"
- And a notification is sent to the sales manager

**AC 4: Invalid Territory Data**
- Given a lead is created without a state/postal code
- When the auto-assignment attempts to run
- Then the lead assigns to the default queue
- And the lead is flagged for data quality review

**AC 5: Rep Not Active**
- Given a lead matches my territory assignment
- When my user record is inactive or I'm out of office
- Then the lead assigns to my backup rep (if configured)
- Or assigns to the territory queue if no backup exists

### Security and Access

**AC 6: Territory Assignment Permissions**
- Given I am not a Sales Rep (different profile)
- When a lead is created in my assigned territory
- Then auto-assignment still works based on territory rules
- But I can only see leads according to sharing rules

**AC 7: Manual Override Capability**
- Given I am a Sales Manager
- When I manually change a lead owner
- Then the auto-assignment does not override my change
- And the override reason is logged

### Error Handling

**AC 8: Territory Service Unavailable**
- Given the territory mapping service fails
- When a lead is created
- Then the lead assigns to the default queue
- And an error is logged for admin review
- And lead creation still succeeds

**AC 9: Email Notification Failure**
- Given lead assignment succeeds
- When the email notification fails to send
- Then the assignment is not rolled back
- And the failure is logged for retry

### Testing Requirements

**Unit Tests Required:**
- [ ] Test assignment with valid territory match
- [ ] Test assignment with no territory match
- [ ] Test assignment with missing state data
- [ ] Test assignment when rep is inactive
- [ ] Test assignment priority when territories overlap
- [ ] Test manual override is not overwritten

**Integration Tests Required:**
- [ ] Test end-to-end from lead creation to email notification
- [ ] Test bulk lead import with territory assignment
- [ ] Test territory reassignment updating existing leads

**UAT Scenarios:**
- [ ] Create lead in my territory, verify I'm assigned
- [ ] Create lead outside all territories, verify queue assignment
- [ ] Create 50 leads via import, verify assignments
- [ ] Deactivate my user, verify backup assignment

## Technical Implementation Notes

### Fields Required
| Field API Name | Type | Description | Required? |
|----------------|------|-------------|-----------|
| Territory__c | Lookup(Territory2) | Matched territory | Yes |
| AssignmentReason__c | Text(255) | Why this owner was assigned | Yes |
| BackupRep__c | Lookup(User) | Backup if primary unavailable | No |
| TerritoryPriority__c | Number(2,0) | Priority for overlap resolution | No |

### Automation
- **Type**: Flow (Auto-Launched)
- **Trigger Object**: Lead
- **Trigger Event**: After Insert
- **Named Flow**: Lead_Territory_Assignment

**Flow Logic:**
1. Get lead state/postal code
2. Query Territory2 for matching assignment
3. If multiple matches, sort by priority
4. Lookup assigned user, check if active
5. If inactive, check for backup rep
6. Update lead owner
7. Send email notification
8. Log assignment reason

### Validation Rules
```apex
// Rule Name: State_Required_For_Assignment
// Error Condition: Lead created without state
// Error Message: "State is required for automatic territory assignment"
AND(
  ISBLANK(State),
  ISPICKVAL(LeadSource, "Web"),
  $Setup.AutoAssignment__c.RequireState__c
)
```

### Performance Considerations
- Expected volume: 500-1000 leads/day
- Bulk operation support: Yes - flow handles up to 200 records
- Governor limits: 
  - SOQL queries: 2 per lead (territory lookup + user lookup)
  - DML operations: 1 per lead (owner update)
  - Consider batch apex if volume exceeds 5000/day

## Definition of Done
- [ ] All acceptance criteria tests pass
- [ ] Flow reviewed and approved
- [ ] Unit test coverage >= 85%
- [ ] Territory mapping documented
- [ ] UAT completed with sales team
- [ ] Email templates configured
- [ ] Runbook created for support team
```

## Tips for Quality AC

1. **Be Specific**: "Lead assigns to queue" not "Lead is handled"
2. **Include Numbers**: "Within 5 minutes" not "quickly"
3. **Name Edge Cases**: Don't just say "handle errors" - name specific scenarios
4. **Think About Scale**: What happens with 1 record vs 1000?
5. **Security First**: Always include permission checks
6. **Real Error Messages**: Write the actual text users will see
7. **Test Coverage**: Specify the test scenarios, not just "write tests"

## Common Pitfalls to Avoid

- ❌ Vague criteria: "System works correctly"
- ❌ Missing edge cases: Only happy path
- ❌ No security checks: Assuming everyone can do everything
- ❌ Generic errors: "An error occurred"
- ❌ Untestable criteria: "User is happy"
- ❌ No performance considerations: "Works for 1 record"
- ❌ Missing integration impacts: Ignoring related systems
