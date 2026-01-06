# Field Mapping Workflow

Generate detailed field mapping documentation for data migration.

## Template

```markdown
# Field Mapping: [Source System] to Salesforce [Object]

**Migration Date:** [Date]  
**Prepared By:** [Name]  
**Source System:** [Legacy CRM Name]  
**Target Object:** [Salesforce Object API Name]

---

## Overview

**Total Fields to Migrate:** [Number]  
**Direct Mappings:** [Number with no transformation]  
**Transformations Required:** [Number needing logic]  
**New Fields:** [Number not in source]  
**Deprecated Fields:** [Number in source but not migrated]

---

## Field Mapping Table

| Source Field | Target Field | Type Conversion | Transformation Logic | Default Value | Notes |
|--------------|--------------|-----------------|----------------------|---------------|-------|
| CustomerID | AccountNumber | Text → Text(20) | None | - | Direct mapping |
| CompanyName | Name | Text → Text(255) | Trim whitespace | - | Required field |
| ContactEmail | PersonEmail | Email → Email | Lowercase | - | Person Account only |
| Status | Status__c | Integer → Picklist | Map: 1=Active, 2=Inactive, 3=Pending | Active | See mapping below |
| CreatedDate | Legacy_Created_Date__c | Date → DateTime | Add midnight timestamp | - | Preserve original |
| Amount | AnnualRevenue | Currency → Currency | Convert to USD if foreign | 0 | Use exchange rate table |
| - | Territory__c | - → Lookup | Lookup by State field | Default Territory | New field |
| Region | - | Text → - | Not migrated | - | Deprecated |

---

## Detailed Mapping Specifications

### Status Field Transformation

**Source:** Integer (1, 2, 3, 99)  
**Target:** Picklist (Active, Inactive, Pending, Unknown)

**Mapping Logic:**
```javascript
// JavaScript transformation
const statusMapping = {
    1: 'Active',
    2: 'Inactive', 
    3: 'Pending',
    99: 'Unknown'
};

const targetStatus = statusMapping[sourceStatus] || 'Unknown';
```

**Edge Cases:**
- NULL → 'Unknown'
- Invalid value → 'Unknown' + log warning
- 0 → 'Inactive'

---

### Territory Assignment Logic

**Source:** No equivalent field  
**Target:** Territory__c (Lookup to Territory2)

**Logic:**
```apex
// Apex logic for territory assignment
if (String.isNotBlank(account.BillingState)) {
    Territory2 territory = [
        SELECT Id 
        FROM Territory2 
        WHERE State__c = :account.BillingState 
        LIMIT 1
    ];
    account.Territory__c = territory?.Id;
} else {
    // Default territory
    account.Territory__c = DEFAULT_TERRITORY_ID;
}
```

**Fallback:** If state not found, assign to "Unassigned" territory (ID: 0XX000000000000)

---

### Currency Conversion

**Source:** Amount (in various currencies)  
**Target:** AnnualRevenue (USD only)

**Logic:**
```sql
-- SQL transformation
CASE 
    WHEN Currency = 'USD' THEN Amount
    WHEN Currency = 'EUR' THEN Amount * 1.10
    WHEN Currency = 'GBP' THEN Amount * 1.27
    ELSE Amount  -- Default to source value
END AS AnnualRevenue
```

**Exchange Rates:** As of [Date]  
**Update Frequency:** Monthly

---

## Data Quality Rules

### Pre-Migration Cleanup

**Required Actions:**

1. **Remove Duplicates**
   - Logic: Group by Email, keep most recent
   - Estimated duplicates: [Number]

2. **Standardize Phone Numbers**
   - Format: (XXX) XXX-XXXX
   - Remove international codes
   - Strip special characters

3. **Validate Emails**
   - Remove invalid formats
   - Remove role-based (info@, admin@)
   - Mark bounced emails

4. **Complete Required Fields**
   - Name: Cannot be blank
   - Status: Default to 'Active' if NULL
   - CreatedDate: Use migration date if NULL

---

## Validation Rules Impact

### Rules to Disable During Migration

| Rule Name | Reason | Re-enable After? |
|-----------|--------|------------------|
| Account_Name_Required | Will fail for legacy records with no name | No - fix data first |
| Phone_Format_Validation | Legacy data uses different format | Yes - after cleanup |
| Email_Domain_Check | Blocks personal emails, some legacy has them | Yes - exceptions granted |

### Rules to Keep Active

| Rule Name | Reason |
|-----------|--------|
| Prevent_Duplicate_Email | Catch duplicates during migration |
| Required_Field_Check | Ensure data quality |

---

## Sample Data

### Source System Sample

```json
{
    "CustomerID": "CUST-12345",
    "CompanyName": "Acme Corporation  ",
    "ContactEmail": "JOHN.DOE@ACME.COM",
    "Status": 1,
    "CreatedDate": "2020-01-15",
    "Amount": "150000.00",
    "Currency": "USD",
    "Region": "West"
}
```

### Expected Salesforce Output

```json
{
    "AccountNumber": "CUST-12345",
    "Name": "Acme Corporation",
    "PersonEmail": "john.doe@acme.com",
    "Status__c": "Active",
    "Legacy_Created_Date__c": "2020-01-15T00:00:00Z",
    "AnnualRevenue": 150000.00,
    "Territory__c": "0XX000000000XYZ"
}
```

---

## Migration Sequence

### Phase 1: Prepare

1. Export data from source system
2. Run data quality checks
3. Clean data per rules above
4. Generate CSV files

### Phase 2: Load

1. Disable validation rules (listed above)
2. Load data using Bulk API
3. Monitor for errors
4. Fix and reload failed records

### Phase 3: Validate

1. Verify record counts match
2. Spot-check field values
3. Run data quality reports
4. Re-enable validation rules

### Phase 4: Clean Up

1. Update related records (if any)
2. Run assignment rules
3. Trigger automation (if disabled)
4. Archive migration files

---

## Error Handling

### Common Errors and Solutions

| Error | Cause | Solution |
|-------|-------|----------|
| "Required field missing: Name" | Blank company name | Use AccountNumber as Name |
| "Duplicate external ID" | Same AccountNumber exists | Append timestamp to ID |
| "Invalid picklist value" | Status code not in mapping | Use 'Unknown' default |
| "Field integrity exception" | Territory lookup failed | Use default territory |

---

## Testing Plan

### Sandbox Testing

**Test Scenarios:**

1. **Happy Path**
   - Load 100 records with valid data
   - Verify all fields map correctly
   - Check transformations

2. **Edge Cases**
   - NULL values in optional fields
   - NULL values in required fields (should use defaults)
   - Invalid status codes
   - Missing territory matches

3. **Volume Testing**
   - Load 10,000 records
   - Verify processing time < 10 minutes
   - Check for governor limit issues

4. **Duplicate Handling**
   - Load same record twice
   - Verify deduplication logic works

---

## Rollback Plan

### If Migration Fails

1. **Delete migrated records:**
   ```apex
   DELETE [SELECT Id FROM Account WHERE Legacy_Created_Date__c = TODAY];
   ```

2. **Re-enable validation rules**

3. **Restore any modified data** (if applicable)

4. **Review error logs**

5. **Fix data issues**

6. **Re-attempt migration**

---

## Sign-Off

| Stakeholder | Role | Approval | Date |
|-------------|------|----------|------|
| [Name] | Data Owner | ☐ | |
| [Name] | Salesforce Admin | ☐ | |
| [Name] | Business Analyst | ☐ | |

---

**Document Version:** 1.0  
**Last Updated:** [Date]
```

## Tips for Field Mapping

1. **Document Everything**: Every field, every transformation
2. **Use Real Examples**: Show actual source and target data
3. **List Edge Cases**: NULL, blanks, invalid values
4. **Test Incrementally**: Small batch first, then scale
5. **Plan for Rollback**: Know how to undo
6. **Validate Post-Load**: Don't assume it worked
7. **Keep History**: Archive mapping docs and data files
