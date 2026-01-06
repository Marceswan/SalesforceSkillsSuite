# Quick Start Guide

Get your Salesforce AC skill running in 5 minutes.

## What You're Installing

A PAI skill that generates comprehensive Salesforce acceptance criteria based on your actual project patterns from real-world implementations, and partner portal.

## Structure

```
SalesforceAcceptanceCriteria/
├── SKILL.md                          # Skill definition and routing
├── README.md                         # Complete documentation
├── workflows/
│   ├── StandardUserStory.md         # Most common: single user story AC
│   └── ComplexFeature.md            # Multi-component features (like enterprise routing)
└── context/
    └── SalesforceStandards.md       # your patterns, preferences, client standards
```

## Installation (2 minutes)

### Option 1: Quick Install (If you have PAI)

```bash
# Set your PAI directory if not already set
export PAI_DIR="$HOME/.claude"  # or wherever your PAI is

# Copy the skill
cp -r SalesforceAcceptanceCriteria $PAI_DIR/Skills/

# Verify
ls $PAI_DIR/Skills/SalesforceAcceptanceCriteria/
```

### Option 2: Manual Install

1. Find your Claude Code skills directory:
   - Usually `~/.claude/Skills/` or `~/.config/pai/Skills/`

2. Copy the entire `SalesforceAcceptanceCriteria/` folder there

3. Restart Claude Code

## First Test (1 minute)

Open Claude Code and try:

```
Create acceptance criteria for a user story about 
automatically assigning leads based on territory
```

You should see:
1. ✅ Skill triggers (mentions "acceptance criteria")
2. ✅ Workflow notification: "Running StandardUserStory workflow..."
3. ✅ Complete AC output with:
   - Functional requirements
   - Edge cases (no territory match, inactive rep, etc.)
   - Security checks
   - Error handling
   - Test scenarios
   - Technical implementation (fields, flows, validation rules)

## What to Try Next

### Simple User Stories
```
"Create AC for opportunity auto-closure after 90 days of inactivity"
"Generate AC for a validation rule preventing negative opportunity amounts"
"Write AC for a screen flow that captures case escalation details"
```

### Complex Features
```
"Generate AC for the enterprise multi-team opportunity routing system"
"Create AC for product quote generation with custom pricing"
"Write AC for an integration with an external shipping calculation API"
```

## Customization (As You Go)

### Add Your Patterns

Edit `context/SalesforceStandards.md`:

```markdown
## My Company's Naming Conventions

### Custom Fields
- Prefix: ACME_ (e.g., ACME_CustomerID__c)
- Date fields: Always end with _Date__c
- Lookup fields: Always end with _Ref__c

### Flows
- Prefix: ACME_RT_ (Record-Triggered)
- Prefix: ACME_SF_ (Screen Flow)
```

### Add Your Clients

```markdown
## Client-Specific Patterns

### XYZ Company
- High security requirements (PII data)
- Multi-currency support required
- Integration with SAP ERP
- Complex approval chains (4+ levels)
```

### Add Your Flow Patterns

```markdown
### My Flow Formulas

// My company's fiscal year calculation
"FY" & TEXT(IF(MONTH(TODAY()) >= 7, YEAR(TODAY()) + 1, YEAR(TODAY())))

// My standard date formatting
TEXT(YEAR({!TheDate})) & "-" & LPAD(TEXT(MONTH({!TheDate})), 2, "0")
```

## Common Commands

```
# Standard user story
"Create AC for [feature]"

# Complex feature  
"Generate AC for [multi-component feature]"

# Be specific about objects
"Create AC for a Lead trigger that [does something]"

# Mention data volume
"Generate AC for bulk processing 10,000 contact records"

# Include integration
"Create AC for REST API integration with [external system]"
```

## Troubleshooting

**Not triggering?**
- Say "acceptance criteria" or "AC" explicitly
- Try: "Create acceptance criteria for..."

**Too generic?**
- Provide more context: "Create AC for a Flow on the Opportunity object that..."
- Mention specific requirements: "...must handle 200 records at once"

**Wrong workflow?**
- Be explicit: "Use the complex feature workflow to..."
- Or just: "This is a complex feature with multiple components..."

## What Gets Better Over Time

As you use this skill:

1. **Your patterns accumulate** in `SalesforceStandards.md`
2. **Edge cases you discover** get added to common scenarios
3. **Client patterns** become templates for future projects
4. **Your AC quality** becomes more comprehensive and consistent

## Real Example Output

Input:
```
Create AC for territory-based lead assignment
```

Output (excerpt):
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

**AC 3: No Matching Territory**
- Given a lead is created with a state that doesn't match any territory
- When the auto-assignment process runs
- Then the lead assigns to the default queue "Unassigned Leads"
- And a notification is sent to the sales manager

[... continues with 20+ more AC covering all edge cases, security, 
error handling, bulk processing, testing requirements, and 
technical implementation details ...]
```

## Next Steps

1. ✅ Install the skill
2. ✅ Test with a simple user story
3. ✅ Try a complex feature from your actual projects
4. 📝 Customize `SalesforceStandards.md` with your patterns
5. 🔄 Use it on real work
6. 💡 Add workflows for scenarios you encounter often (Data Migration, Integration, etc.)

## Questions?

Check the full README.md for:
- Complete examples
- All workflow types
- Customization options
- Integration with Jira/ADO
- Contributing guidelines

## What to Build Next?

Once this skill is working for you, consider:

- **SalesforceDocumentation** skill - Generate job aids, technical specs
- **SalesforceTesting** skill - Generate test classes from AC
- **SalesforceDevelopment** skill - Generate actual code from AC
- **SalesforceDataMigration** skill - Data mapping, field mapping, bulk operations
