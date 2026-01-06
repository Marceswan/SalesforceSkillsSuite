# Technical Spec Workflow

Generate comprehensive technical documentation for developers and administrators.

## Purpose

Technical specs are for **developers, admins, and architects** who need to understand how something works and how to implement or maintain it.

## Template Structure

```markdown
# Technical Specification: [Feature Name]

**Document Version:** 1.0  
**Last Updated:** [Date]  
**Author:** [Name]  
**Status:** Draft | Review | Approved

---

## Executive Summary

[2-3 paragraph overview of the feature, its purpose, and business value]

**Key Points:**
- [Main capability 1]
- [Main capability 2]
- [Main capability 3]

---

## Architecture Overview

### System Context Diagram

```
[ASCII art showing how this feature fits in the larger system]

External System → Integration Layer → Salesforce → User Interface
                       ↓
                   Data Storage
```

### Component Diagram

```
[ASCII art showing components and data flow]

UI (LWC) → Apex Controller → Service Layer → Database
              ↓
         External API
```

---

## Data Model

### Objects

#### [Object Name]__c

**Purpose:** [What this object stores]

**Key Fields:**

| API Name | Type | Description | Required | Notes |
|----------|------|-------------|----------|-------|
| Field1__c | Text(80) | Brief description | Yes | Validation: [rules] |
| Field2__c | Number(16,2) | Brief description | No | Default: 0 |
| Field3__c | Lookup(Account) | Brief description | Yes | Delete: Cascade |

**Relationships:**
- Master-Detail to Account
- Lookup to Contact
- Many-to-many via Junction__c

**Sharing Model:** Private (OWD)

**Security:**
- Read: Sales User profile
- Create/Edit: Sales Manager profile
- Delete: System Admin only

---

### Object Relationships

```
Account (1) ─────< Opportunity (M)
   │
   │ (1)
   │
   └──────< CustomObject__c (M)
                  │
                  │ (1)
                  │
                  └──────< JunctionObject__c (M) ──────> Contact (1)
```

---

## Business Logic

### Automation Rules

#### Flow: Record_Triggered_Flow_Name

**Trigger:**
- Object: Opportunity
- Trigger: Before Save
- Entry Conditions: `Status = "Closed Won" AND Amount > 100000`

**Logic:**
1. Calculate commission: `Amount * 0.05`
2. Query territory assignment
3. Update owner based on territory
4. Send notification email
5. Create follow-up task

**Bulkification:** Yes - handles up to 200 records

**Governor Limits:**
- SOQL Queries: 2 per record
- DML Operations: 1 per record
- CPU Time: ~50ms per record

---

#### Apex Trigger: OpportunityTrigger

**Pattern:** Handler pattern with separate class

**Events Handled:**
- Before Insert: Default field values
- After Insert: Create related records
- Before Update: Validation logic
- After Update: External system sync

**Code Location:** `/force-app/main/default/triggers/`

---

### Validation Rules

#### Rule: Amount_Required_For_Closed_Won

**Formula:**
```apex
AND(
    ISPICKVAL(StageName, "Closed Won"),
    ISNULL(Amount)
)
```

**Error Message:** "Amount is required for Closed Won opportunities"

**Error Location:** Amount field

**Active:** Yes

---

## Integration Points

### External API: Shipping Calculation Service

**Type:** REST API  
**Authentication:** Named Credential (OAuth 2.0)  
**Endpoint:** `https://api.shippingservice.com/v2/calculate`

**Request:**
```json
{
  "amount": 150000,
  "state": "TX",
  "orderYear": 2026
}
```

**Response:**
```json
{
  "shippingCost": 7500,
  "effectiveRate": 0.05,
  "jurisdiction": "Texas"
}
```

**Error Handling:**
- Timeout: 30 seconds, retry 3 times
- 500 error: Log and notify admin
- 401 error: Refresh credentials

**Callout Location:** `ShippingCalculationService.cls`

---

## User Interface

### Lightning Web Component: opportunityShippingCalculator

**Purpose:** Allow users to calculate shipping on opportunities

**Location:** Opportunity record page

**Properties:**
- `@api recordId` - Current opportunity ID
- `@api amount` - Opportunity amount

**Events Emitted:**
- `shippingcalculated` - When calculation succeeds
- `shippingerror` - When calculation fails

**Dependencies:**
- Apex: OpportunityShippingController
- External API: Shipping Calculation Service

**File Structure:**
```
opportunityShippingCalculator/
├── opportunityShippingCalculator.html
├── opportunityShippingCalculator.js
├── opportunityShippingCalculator.js-meta.xml
├── opportunityShippingCalculator.css
└── __tests__/
    └── opportunityShippingCalculator.test.js
```

---

## Security Model

### Profiles & Permission Sets

| Profile/PermSet | Read | Create | Edit | Delete |
|-----------------|------|--------|------|--------|
| Sales User | ✓ | ✓ | Own | Own |
| Sales Manager | ✓ | ✓ | All | Own |
| System Admin | ✓ | ✓ | All | All |

### Sharing Rules

**Rule:** Territory_Based_Sharing
- Type: Criteria-based
- Criteria: `Territory__c = User.Territory__c`
- Access: Read/Write

### Field-Level Security

| Field | Sales User | Sales Manager | System Admin |
|-------|------------|---------------|--------------|
| Amount__c | Read/Edit | Read/Edit | Read/Edit |
| InternalNotes__c | None | Read | Read/Edit |
| CommissionRate__c | Read | Read/Edit | Read/Edit |

---

## Performance Considerations

### Expected Data Volume

- Records per day: 1,000
- Total records: 500,000+
- Growth rate: 20% per year

### Optimization Strategies

1. **Indexing:** Custom index on `Territory__c` and `Status__c`
2. **Archiving:** Move closed opportunities >2 years to archive
3. **Batch Processing:** Use batch apex for bulk updates
4. **Caching:** Cache territory mappings (refresh daily)

### Governor Limits Analysis

| Operation | Per Transaction | Budgeted | Margin |
|-----------|----------------|----------|--------|
| SOQL Queries | 100 | 4 | 96 |
| DML Statements | 150 | 2 | 148 |
| CPU Time (ms) | 10,000 | 200 | 9,800 |
| Heap Size (MB) | 6 | 0.5 | 5.5 |

---

## Testing Strategy

### Unit Tests

**Coverage Target:** 85%+

**Test Classes:**
- `OpportunityTriggerHandler_Test.cls`
- `ShippingCalculationService_Test.cls`
- `OpportunityShippingController_Test.cls`

**Key Test Scenarios:**
- Happy path with valid data
- Invalid data handling
- Bulk processing (200 records)
- Governor limit safety

### Integration Tests

**Scenarios:**
- End-to-end flow from UI to database
- External API integration (mock)
- Multi-user concurrent access

### UAT Scenarios

**Test Case 1:** Create Closed Won Opportunity
- Login as Sales User
- Create opportunity with amount > $100K
- Set stage to Closed Won
- Verify shipping calculation automatic
- Verify commission calculated

---

## Deployment

### Deployment Order

1. Custom Objects & Fields
2. Permission Sets
3. Apex Classes (test first, then production)
4. Triggers
5. Flows
6. Lightning Components
7. Page Layouts
8. Record Types
9. Validation Rules (deploy inactive, activate manually)

### Pre-Deployment Checklist

- [ ] All tests pass in source org
- [ ] Code coverage >= 85%
- [ ] Security review completed
- [ ] Documentation updated
- [ ] Backup of production metadata
- [ ] Deployment window scheduled
- [ ] Rollback plan documented

### Post-Deployment Verification

- [ ] Smoke test: Create sample record
- [ ] Verify automation executes
- [ ] Check integration logs
- [ ] Confirm no errors in debug logs
- [ ] User acceptance sign-off

### Rollback Procedure

**If critical issue found:**
1. Deactivate automation (flows, triggers)
2. Deploy previous version of apex classes
3. Notify users of temporary downtime
4. Investigate root cause
5. Fix and redeploy

---

## Monitoring & Support

### Logging

**Apex Logging:**
- Custom debug logs in CustomLog__c object
- Error level: ERROR, WARN, INFO
- Retention: 90 days

**Integration Logging:**
- All API calls logged to IntegrationLog__c
- Fields: Request, Response, Status, Timestamp
- Retention: 30 days

### Monitoring Dashboard

**Metrics to Track:**
- Daily record creation count
- API success/failure rate
- Average processing time
- Error count by type

**Alert Thresholds:**
- Error rate > 5%: Email admin
- Processing time > 10s: Email admin
- API failure rate > 10%: Page admin

### Support Runbook

**Common Issue 1: External API Call Fails**
- Check: Named Credential still valid?
- Check: External system status page
- Fix: Refresh OAuth token or retry manually

**Common Issue 2: Records Not Creating**
- Check: Validation rules blocking insert?
- Check: User has required permissions?
- Fix: Review error message, adjust data or permissions

---

## Future Enhancements

**Phase 2:**
- Multi-currency support
- Advanced territory hierarchies
- Machine learning for opportunity scoring

**Phase 3:**
- Mobile app integration
- Real-time analytics dashboard
- Einstein AI recommendations

---

## Appendix

### Glossary

- **OWD**: Organization-Wide Default
- **FLS**: Field-Level Security
- **CRUD**: Create, Read, Update, Delete

### Related Documentation

- User Guide: [Link]
- Job Aid: [Link]
- API Documentation: [Link]
- Runbook: [Link]

### Change Log

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-01-04 | Salesforce Architect | Initial release |
```

## Tips for Technical Specs

1. **Be comprehensive but concise**
2. **Use diagrams liberally**
3. **Include code examples**
4. **Document governor limit usage**
5. **Always include security model**
6. **Link to related docs**
7. **Keep updated with changes**
