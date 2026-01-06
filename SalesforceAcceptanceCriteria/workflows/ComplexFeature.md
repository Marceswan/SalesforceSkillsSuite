# Complex Feature Workflow

Generate comprehensive acceptance criteria for multi-component Salesforce features that span multiple objects, systems, or teams.

## When to Use This Workflow

Use this workflow when:
- Feature impacts multiple Salesforce objects
- Multiple teams are involved (Sales, Service, Marketing)
- Integration with external systems required
- Complex automation across multiple steps
- Significant architectural implications

Examples: multi-team opportunity routing, complex quote generation, multi-team approval processes

## Input Requirements

Gather from the user:
1. **Feature Description**: High-level overview of what's being built
2. **Objects Involved**: Which Salesforce objects are affected?
3. **Teams Involved**: Who will use different parts of this feature?
4. **Dependencies**: What must exist before this can work?
5. **Integration Points**: Any external systems involved?
6. **Data Volume**: Expected scale of data/transactions?

## Execution Steps

### Step 1: Break Down into Components

Identify discrete components:
- **Data Model**: New objects, fields, relationships
- **User Interface**: Screen flows, LWC components, page layouts
- **Automation**: Flows, triggers, batch jobs
- **Integration**: APIs, platform events, middleware
- **Security**: Profiles, permission sets, sharing rules
- **Reporting**: Dashboards, reports, analytics

### Step 2: Create Component Map

For each component, document:
```
Component: [Name]
- Purpose: [What it does]
- Dependencies: [What it needs]
- Impacts: [What it affects]
- Team: [Who owns it]
- Complexity: Low/Medium/High
```

### Step 3: Generate AC for Each Component

For each component, create:

#### Data Model Component
```markdown
### Data Model: [Component Name]

**Objects Created/Modified:**
- Object1__c (New)
- Object2__c (Modified - 3 new fields)

**Relationships:**
- Object1__c → Account (Lookup)
- Object1__c → Object2__c (Master-Detail)

**Acceptance Criteria:**

**AC 1: Object Creation**
- Given admin access
- When Object1__c is created with required fields
- Then object is available for use across all profiles
- And relationships function correctly

**AC 2: Data Migration**
- Given existing data in legacy system
- When migration script runs
- Then all data maps correctly to new fields
- And no data loss occurs
- And relationships are properly established

[Continue with validation rules, security, etc.]
```

#### Automation Component
```markdown
### Automation: [Component Name]

**Flow/Trigger:** [Name]
**Trigger Object:** [Object API Name]
**Trigger Event:** [When it runs]

**Acceptance Criteria:**

**AC 1: Primary Automation Path**
- Given [trigger condition]
- When [record action]
- Then [automation executes]
- And [expected result]

**AC 2: Bulk Processing**
- Given 200 records processed simultaneously
- When automation runs
- Then all records process successfully
- And no governor limit errors occur
- And execution completes within 60 seconds

[Continue with error handling, etc.]
```

#### Integration Component
```markdown
### Integration: [Component Name]

**External System:** [System name]
**Integration Type:** REST API / Platform Event / Middleware
**Authentication:** Named Credential / OAuth

**Acceptance Criteria:**

**AC 1: Successful Data Exchange**
- Given valid authentication credentials
- When Salesforce sends data to external system
- Then external system receives data correctly
- And confirmation is logged in Salesforce

**AC 2: Integration Failure Handling**
- Given external system is unavailable
- When integration attempts to send data
- Then retry logic executes (3 attempts)
- And failure is logged for admin review
- And user receives appropriate error message

[Continue with security, monitoring, etc.]
```

### Step 4: Define Component Dependencies

Create dependency matrix:
```
Component A → Depends on → Component B, Component C
Component B → Depends on → Component D
Component C → No dependencies
Component D → No dependencies

Recommended Build Order:
1. Component D (no dependencies)
2. Component B (depends on D)
3. Component C (no dependencies)
4. Component A (depends on B, C)
```

### Step 5: Integration Testing Scenarios

Define how components work together:
```markdown
## Integration Testing

**Scenario 1: End-to-End Happy Path**
- Given all components are deployed
- When user performs [primary action]
- Then Data Model component creates records
- And Automation component processes them
- And Integration component syncs to external system
- And User Interface component displays results

**Scenario 2: Partial Failure Handling**
- Given Data Model and Automation succeed
- When Integration component fails
- Then user still sees created records
- And failure is logged for retry
- And user is notified of sync delay
```

### Step 6: Format Output

```markdown
# Complex Feature: [Feature Name]

## Overview
[High-level description of what this feature accomplishes]

**Epic/Initiative:** [Jira Epic ID or Initiative name]
**Teams Involved:** [List teams]
**Target Release:** [Release number/date]

## Component Architecture

```
[ASCII diagram showing components and data flow]

Data Entry (UI) → Validation (Flow) → Record Creation (Apex) → External Sync (API)
       ↓                ↓                    ↓                        ↓
   User Input      Business Rules      Database Changes        Integration Log
```

## Component Breakdown

### 1. [Component Name] - Data Model
[Component-specific AC here]

### 2. [Component Name] - Automation  
[Component-specific AC here]

### 3. [Component Name] - Integration
[Component-specific AC here]

### 4. [Component Name] - User Interface
[Component-specific AC here]

## Dependencies and Build Order

**Phase 1 - Foundation** (Sprint 1-2)
- Component D: Core data model
- Component C: Base validation rules

**Phase 2 - Automation** (Sprint 3-4)
- Component B: Business logic flows
- Component E: Batch processing

**Phase 3 - Integration** (Sprint 5)
- Component F: External API integration
- Component G: Error handling and logging

**Phase 4 - UI** (Sprint 6)
- Component A: User-facing components
- Component H: Reporting and dashboards

## Cross-Component Testing

### Integration Test 1: Full Happy Path
[End-to-end scenario]

### Integration Test 2: Data Quality Validation
[What happens with bad data across components]

### Integration Test 3: Performance at Scale
[Bulk processing across components]

### Integration Test 4: Failure Recovery
[How system degrades gracefully]

## Security Matrix

| Component | Profile Access | Permission Set | Sharing Rules |
|-----------|----------------|----------------|---------------|
| Component A | Sales User | - | Private |
| Component B | System Admin | Integration_User | Controlled by Parent |
| Component C | All Users | - | Public Read Only |

## Technical Debt and Future Enhancements

**Known Limitations:**
- [List current scope limitations]

**Future Enhancements:**
- [List planned improvements]

**Technical Debt:**
- [List any shortcuts taken for MVP]

## Rollout Plan

**Phase 1: Internal Testing** (Week 1)
- Deploy to Sandbox
- QA testing of all components
- Performance testing with production data volume

**Phase 2: Pilot** (Week 2-3)  
- Deploy to production
- Enable for 10 pilot users
- Monitor logs and gather feedback

**Phase 3: Full Rollout** (Week 4)
- Enable for all users
- Communication and training
- Monitor for issues

## Success Metrics

**Technical Metrics:**
- All components deploy successfully
- Zero critical bugs in first 2 weeks
- API integration success rate > 99%
- Average processing time < 5 seconds

**Business Metrics:**
- User adoption rate > 80% in first month
- Reduction in manual work by X hours/week
- Improvement in data accuracy by X%

## Definition of Done

- [ ] All component AC validated
- [ ] Integration testing passed
- [ ] Security review completed
- [ ] Performance testing passed (bulk operations)
- [ ] Documentation completed (technical + user)
- [ ] Training materials created
- [ ] Pilot users signed off
- [ ] Rollback plan documented
- [ ] Production deployment successful
```

## Real-World Example: Multi-Team Opportunity Routing

```markdown
# Complex Feature: Multi-Team Opportunity Routing System

## Overview
Automatically route opportunities to the correct team based on product type, deal size, and territory, with approval workflows for exceptions.

**Epic:** TAXS-1234 - Intelligent Opportunity Routing
**Teams Involved:** Sales Ops, Sales Leaders, System Admins
**Target Release:** Spring '26

## Component Architecture

```
Lead/Opp Creation → Territory Match → Team Assignment → Approval Flow → Record Update
        ↓                 ↓                 ↓                 ↓              ↓
   User Input      Geography Rules    Role Hierarchy    Manager Review   Owner Set
                                           ↓
                                    Duplicate Check
```

## Component Breakdown

### 1. Data Model - Territory and Team Configuration

**Objects Created:**
- TerritoryTeamMapping__c (Custom Object)
  - Territory__c (Lookup to Territory2)
  - Team__c (Picklist: Enterprise, Mid-Market, SMB)
  - Product__c (Multi-select Picklist)
  - MinDealSize__c (Currency)
  - MaxDealSize__c (Currency)
  - Active__c (Checkbox)

**Fields Modified on Opportunity:**
- AssignedTeam__c (Picklist: Enterprise, Mid-Market, SMB)
- RoutingReason__c (Text 255)
- RoutingDate__c (DateTime)
- ApprovalStatus__c (Picklist: Pending, Approved, Rejected)

**Acceptance Criteria:**

**AC 1.1: Territory Team Mapping Configuration**
- Given I am a Sales Ops Admin
- When I create a TerritoryTeamMapping__c record
- Then I can specify territory, team, products, and deal size range
- And validation ensures MaxDealSize > MinDealSize
- And validation prevents overlapping ranges for same territory/product

**AC 1.2: Opportunity Field Population**
- Given an opportunity is created
- When routing logic executes
- Then AssignedTeam__c is populated
- And RoutingReason__c documents why this team was selected
- And RoutingDate__c records when routing occurred

### 2. Automation - Routing Logic Flow

**Flow:** RT_Opportunity_TeamRouting
**Trigger Object:** Opportunity
**Trigger Event:** After Insert, After Update (when Product or Amount changes)

**Acceptance Criteria:**

**AC 2.1: Standard Routing Path**
- Given a new opportunity with Product = "Enterprise Tax Software" and Amount = 500000
- When the routing flow executes
- Then the flow queries TerritoryTeamMapping__c for matching rules
- And finds Enterprise team based on territory + product + amount
- And assigns owner to Enterprise queue
- And logs "Enterprise team - Product: Enterprise Tax Software, Amount: $500K" in RoutingReason__c

**AC 2.2: Multiple Match Resolution**
- Given routing rules match both Enterprise and Mid-Market teams
- When routing flow executes
- Then the flow selects the team with highest deal size minimum
- And documents "Multiple matches - selected team with highest threshold" in routing reason

**AC 2.3: No Match Scenario**
- Given no routing rules match the opportunity criteria
- When routing flow executes
- Then opportunity assigns to "Unassigned Opportunities" queue
- And ApprovalStatus__c = "Pending"
- And notification sent to Sales Ops for manual review

**AC 2.4: Bulk Processing**
- Given 200 opportunities are created via import
- When routing flow executes for all records
- Then all records route successfully without timeout
- And total execution time < 60 seconds
- And no governor limit errors occur

### 3. Automation - Duplicate Management

**Flow:** RT_Opportunity_DuplicateCheck
**Trigger Object:** Opportunity
**Trigger Event:** Before Insert

**Acceptance Criteria:**

**AC 3.1: Duplicate Detection**
- Given an opportunity is being created
- When account and product match an existing open opportunity
- Then flow identifies potential duplicate
- And prevents insert
- And shows error: "Potential duplicate found: [Existing Opp Name]"

**AC 3.2: Duplicate Override**
- Given I am a Sales Manager (Profile: Sales Manager)
- When I encounter duplicate warning
- Then I can override using DuplicateOverride__c checkbox
- And override reason is required
- And duplicate override is logged in opportunity history

### 4. Automation - Approval Workflow

**Approval Process:** Manual_Routing_Approval
**Trigger:** When ApprovalStatus__c = "Pending"

**Acceptance Criteria:**

**AC 4.1: Approval Submission**
- Given opportunity routes to "Unassigned" queue
- When Sales Ops submits for approval
- Then approval request goes to appropriate Sales Manager based on territory
- And opportunity is locked from editing
- And manager receives email notification

**AC 4.2: Approval Grant**
- Given manager approves routing
- When approval is granted
- Then ApprovalStatus__c = "Approved"
- And opportunity owner is set per manager's selection
- And record is unlocked
- And submitter receives approval notification

**AC 4.3: Approval Rejection**
- Given manager rejects routing
- When rejection occurs with comments
- Then ApprovalStatus__c = "Rejected"
- And opportunity remains in Unassigned queue
- And rejection comments are logged
- And Sales Ops receives rejection notification

### 5. User Interface - Queue Management

**LWC Component:** teamQueueDashboard
**Location:** Sales team home pages

**Acceptance Criteria:**

**AC 5.1: Queue Visibility**
- Given I am assigned to Enterprise Sales team
- When I view my home page
- Then I see all opportunities in Enterprise queue
- And opportunities are sorted by RoutingDate__c (newest first)
- And I can filter by product type

**AC 5.2: Quick Claim Action**
- Given I view an opportunity in my team's queue
- When I click "Claim" button
- Then opportunity owner changes to me
- And opportunity moves out of queue
- And AssignedTeam__c remains unchanged

## Dependencies and Build Order

**Phase 1 - Foundation** (Sprint 1)
- Component 1: Data Model setup
- Configure TerritoryTeamMapping__c records

**Phase 2 - Core Automation** (Sprint 2)
- Component 2: Routing logic flow
- Component 3: Duplicate management

**Phase 3 - Approvals** (Sprint 3)
- Component 4: Approval workflow

**Phase 4 - UI** (Sprint 4)
- Component 5: Queue dashboard component

## Cross-Component Testing

### Integration Test 1: Full Happy Path
- Given new opportunity: Account="ABC Corp", Product="Enterprise", Amount=600K
- When opportunity is created
- Then routing flow executes (Component 2)
- And duplicate check passes (Component 3)
- And territory mapping found (Component 1)
- And opportunity routes to Enterprise queue
- And dashboard shows new opportunity (Component 5)

### Integration Test 2: Duplicate Scenario
- Given existing opportunity: Account="ABC Corp", Product="Enterprise", Status="Open"
- When new opportunity created with same account/product
- Then duplicate check blocks insert (Component 3)
- And error message shown to user
- And no routing occurs

### Integration Test 3: Manual Approval Path
- Given opportunity with unusual criteria (no routing match)
- When opportunity routes to Unassigned queue (Component 2)
- Then approval process triggers (Component 4)
- And manager reviews and approves
- And opportunity moves to correct team queue
- And dashboard reflects update (Component 5)

## Security Matrix

| Component | Profile Access | Permission Set | Sharing Rules |
|-----------|----------------|----------------|---------------|
| TerritoryTeamMapping__c | System Admin, Sales Ops | - | Public Read Only |
| Opportunity Routing Fields | All Sales Profiles | - | OWD Private |
| Approval Process | Sales Managers | Approval_Manager | - |
| Queue Dashboard | Sales Teams | - | View queue records only |

## Rollout Plan

**Phase 1: Internal Testing** (Week 1)
- Deploy to Full Sandbox
- Test with 50 historical opportunities
- Performance test with 200-record bulk load

**Phase 2: Pilot** (Week 2-3)
- Deploy to Production
- Enable for Enterprise Sales team only (20 users)
- Monitor routing accuracy and performance
- Gather feedback on dashboard usability

**Phase 3: Full Rollout** (Week 4)
- Enable for all sales teams (200 users)
- Send communication about new routing
- Provide training on queue dashboard
- Monitor first week closely for issues

## Success Metrics

**Technical:**
- 100% of opportunities route successfully
- Zero timeout errors with bulk processing
- Duplicate detection rate > 95%
- Average routing time < 2 seconds

**Business:**
- Reduce manual routing effort by 80%
- Improve opportunity assignment speed by 50%
- Increase lead conversion by 15% (better team alignment)

## Definition of Done

- [ ] All component AC validated in Sandbox
- [ ] Integration testing passed
- [ ] Security review approved
- [ ] Performance test passed (200 records < 60s)
- [ ] Duplicate logic accuracy > 95%
- [ ] Technical documentation complete
- [ ] User guide and training deck created
- [ ] Pilot team signed off
- [ ] Production deployment successful
- [ ] Monitoring dashboard configured
```

## Tips for Complex Features

1. **Start with Data Model**: Get the structure right first
2. **Build in Phases**: Don't try to do everything at once
3. **Test Integration Early**: Don't wait until the end to test components together
4. **Document Dependencies**: Make it clear what depends on what
5. **Plan for Failure**: Every integration can fail - plan for it
6. **Think About Rollback**: How do you undo this if needed?
7. **Monitor Actively**: First week of production is critical
8. **Communicate Often**: Keep stakeholders updated on progress
