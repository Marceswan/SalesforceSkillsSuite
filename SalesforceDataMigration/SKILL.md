---
name: SalesforceDataMigration
description: Generate data migration plans, field mappings, transformation scripts, and bulk API code. USE WHEN user mentions data migration, field mapping, bulk API, data import, data transformation, OR says migrate, import, map, transform followed by data or fields.
---

# Salesforce Data Migration

Generate comprehensive data migration documentation and scripts.

## Workflow Routing

- **Field Mapping** → `workflows/FieldMapping.md`
  - When: Mapping fields between systems
  - Use for: Legacy system to Salesforce, Salesforce to Salesforce
  
- **Migration Plan** → `workflows/MigrationPlan.md`
  - When: Creating migration strategy
  - Use for: Large-scale migrations, phased rollouts
  
- **Bulk API Script** → `workflows/BulkAPIScript.md`
  - When: Writing bulk data load script
  - Use for: Loading 50,000+ records
  
- **Data Transformation** → `workflows/DataTransformation.md`
  - When: Transforming data during migration
  - Use for: Data cleanup, format conversion

## Key Patterns

**Migration Standards:**
- **Field Mapping First**: Document all field mappings before migration
- **Validation Rules**: Disable during migration, re-enable after
- **Bulk API**: Use for volumes > 5,000 records
- **Test Migration**: Always run in sandbox first
- **Rollback Plan**: Document how to undo the migration
- **Data Quality**: Clean data before migration

## Examples

**Example 1: Field Mapping**
```
User: "Create field mapping from legacy CRM to Salesforce Account"
→ Generates mapping document:
  - Source to target field mappings
  - Data type conversions
  - Transformation logic
  - Default values
  - Validation rules impact
```

**Example 2: Migration Plan**
```
User: "Generate migration plan for 100,000 contacts"
→ Creates comprehensive plan:
  - Phase breakdown
  - Volume estimates
  - Timeline
  - Risk mitigation
  - Rollback procedures
```
