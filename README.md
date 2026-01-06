# Salesforce PAI Skills Suite

Complete set of PAI skills for Salesforce development, testing, documentation, and data migration.

## What's Included

### 1. SalesforceAcceptanceCriteria
Generate comprehensive acceptance criteria for user stories and complex features.
- Standard user stories
- Multi-component features
- All edge cases covered
- Technical implementation guidance

### 2. SalesforceDocumentation
Generate professional documentation for all audiences.
- Job aids for end users
- Technical specs for developers
- Runbooks for operations
- User guides and release notes

### 3. SalesforceTesting
Generate test classes with guaranteed 85%+ coverage.
- Apex test classes
- Test data builders
- LWC Jest tests
- Bulk testing included

### 4. SalesforceDevelopment
Generate production-ready Salesforce code.
- Lightning Web Components
- Apex classes (service, controller, batch)
- Flows and triggers
- Handler pattern included

### 5. SalesforceDataMigration
Generate data migration documentation and scripts.
- Field mappings
- Migration plans
- Bulk API scripts
- Data transformations

### 6. SalesforceUAT
Generate UAT test scripts for end users.
- Click-path instructions
- Persona-based testing
- Expected results defined
- Multi-scenario support

## Quick Install (All Skills)

```bash
# Download and extract
tar -xzf SalesforceSkillsSuite.tar.gz
cd SalesforceSkillsSuite

# Run master installer
./install-all.sh

# Or install individually
cp -r Salesforce* $PAI_DIR/Skills/
```

## Usage Examples

### Acceptance Criteria
```
"Create AC for territory-based lead assignment"
→ Generates 20+ acceptance criteria with edge cases, security, testing
```

### Documentation
```
"Create a job aid for the opportunity routing feature"
→ Generates user-friendly step-by-step guide with screenshot placeholders
```

### Testing
```
"Generate test class for OpportunityTriggerHandler"
→ Creates complete test class with 85%+ coverage guaranteed
```

### Development
```
"Create an LWC to display and edit opportunity products"
→ Generates complete component (HTML, JS, CSS, Apex controller, tests)
```

### Data Migration
```
"Create field mapping from legacy CRM to Salesforce Account"
→ Generates detailed mapping with transformations and edge cases
```

### UAT Testing
```
"Create UAT test script for lead disposition validation"
→ Generates end-user test with numbered steps, expected results, and persona
```

## Workflow

**Typical Project Workflow:**

1. **SalesforceAcceptanceCriteria** → Define requirements
2. **SalesforceDevelopment** → Build the solution
3. **SalesforceTesting** → Test thoroughly
4. **SalesforceDocumentation** → Document for users and ops
5. **SalesforceDataMigration** → Migrate data if needed

**Example: Complete Feature Build**

```
# Step 1: Requirements
"Create AC for TaxSlayer opportunity routing system"
"Create AC for multi-team opportunity routing system"

# Step 2: Code
"Generate Flow for opportunity territory assignment"
"Create Apex trigger handler for duplicate management"

# Step 3: Tests
"Generate test class for OpportunityTriggerHandler"
"Create test data builder for Opportunity and Territory"

# Step 4: Docs
"Create job aid for sales reps on the new routing"
"Generate technical spec for the routing system"
"Create runbook for deployment"

# Result: Complete, tested, documented feature in hours instead of days
```

## What Makes This Different

**Generic AI:** "Create acceptance criteria"
→ Gets 5 vague criteria, misses edge cases, no technical detail

**These Skills:** "Create acceptance criteria"  
→ Gets 20+ comprehensive criteria:
- All happy paths
- All edge cases (nulls, duplicates, bulk, permissions)
- Security requirements
- Error handling
- Testing requirements
- Technical implementation
- Performance considerations

**Why:** These skills encode YOUR actual patterns from real projects (TaxSlayer, Fibergrate, Digital Rupix).

## Customization

Each skill includes context files you can customize:

```
SalesforceAcceptanceCriteria/context/SalesforceStandards.md
SalesforceDocumentation/context/DocumentationStandards.md
SalesforceTesting/context/TestingPatterns.md
SalesforceDevelopment/context/CodingStandards.md
SalesforceDataMigration/context/MigrationPatterns.md
```

Add your:
- Company naming conventions
- Client-specific patterns
- Preferred coding styles
- Common edge cases from your domain

## Benefits

### Time Savings
- AC: 2-3 hours → 2 minutes
- Documentation: 1-2 hours → 5 minutes
- Test classes: 1 hour → 5 minutes
- Data migration docs: 4-8 hours → 10 minutes

### Quality Improvements
- Comprehensive edge case coverage
- Consistent format across projects
- No forgotten requirements
- Best practices baked in

### Knowledge Capture
- Your patterns encoded once, reused forever
- Team knowledge preserved
- New team members get up to speed faster
- Client patterns saved for next project

## Project Impact

**Before PAI Skills:**
- Write AC: 2 hours
- Develop feature: 8 hours
- Write tests: 2 hours
- Write docs: 2 hours
- **Total: ~14 hours**

**With PAI Skills:**
- Generate AC: 2 minutes
- Review/refine AC: 30 minutes
- Generate code: 5 minutes
- Customize code: 2 hours
- Generate tests: 2 minutes
- Review tests: 30 minutes
- Generate docs: 5 minutes
- Review docs: 30 minutes
- **Total: ~4 hours**

**Time saved: 10 hours per feature**

For 20 features/month: **200 hours saved**

## What to Build Next

After these 5 core skills, consider:

- **SalesforceIntegration** - REST API, Platform Events, middleware patterns
- **SalesforceReporting** - Dashboard, report, analytics requirements
- **SalesforcePerformance** - Performance optimization, governor limit analysis
- **SalesforceArchitecture** - Solution design, technology selection

## Community Contribution

These are the first Salesforce-specific PAI skills (that I know of, at least!). Consider:
- Sharing on GitHub
- Contributing to PAI repository
- Helping other Salesforce architects
- Building the Salesforce PAI ecosystem

## Support

- 📖 Each skill has detailed README
- 🚀 Each workflow has examples
- 💬 Ask Claude Code: "How do I use the Salesforce AC skill?"
- 🐛 Issues? Check individual skill READMEs

## License

MIT License - Use freely, modify as needed

## Credits

- **Based on**: Real projects at TaxSlayer, Fibergrate, Digital Rupix
- **Author**: Marc Swan
- **PAI Framework**: Daniel Miessler

---

**Version:** 1.0  
**Last Updated:** January 4, 2026
