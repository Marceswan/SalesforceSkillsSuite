# Get Started with Salesforce PAI Skills Suite

## What You Just Downloaded

A complete set of 5 PAI skills that transform how you build Salesforce projects.

### The Suite

1. **SalesforceAcceptanceCriteria** - Requirements & AC generation
2. **SalesforceDocumentation** - Job aids, specs, runbooks
3. **SalesforceTesting** - Test classes & data builders
4. **SalesforceDevelopment** - LWC, Apex, Flows
5. **SalesforceDataMigration** - Field mappings & migration plans

## Installation (2 Minutes)

### Option 1: Quick Install (Recommended)

```bash
# Extract the suite
tar -xzf SalesforceSkillsSuite.tar.gz
cd SalesforceSkillsSuite

# Install all skills at once
./install-all.sh
```

### Option 2: Manual Install

```bash
# Extract
tar -xzf SalesforceSkillsSuite.tar.gz

# Set your PAI directory
export PAI_DIR="$HOME/.claude"  # or wherever your PAI is

# Copy skills
cp -r SalesforceSkillsSuite/Salesforce* $PAI_DIR/Skills/
```

## First Tests (5 Minutes)

Open Claude Code and try these:

### 1. Acceptance Criteria
```
"Create acceptance criteria for automatically assigning leads based on territory"
```

**What you'll get:**
- 20+ comprehensive acceptance criteria
- All edge cases (no territory match, inactive rep, bulk processing)
- Security requirements
- Error handling
- Testing requirements
- Technical implementation details

### 2. Documentation
```
"Create a job aid for sales reps on the lead assignment feature"
```

**What you'll get:**
- User-friendly step-by-step guide
- Screenshot placeholders
- Troubleshooting section
- Tips and best practices

### 3. Testing
```
"Generate test class for a LeadTriggerHandler that assigns leads by territory"
```

**What you'll get:**
- Complete test class with @testSetup
- Bulk testing (200 records)
- Negative test cases
- 85%+ coverage guaranteed

### 4. Development
```
"Create an LWC component to display and edit opportunity products inline"
```

**What you'll get:**
- Complete HTML template
- JavaScript controller with wire services
- Apex controller
- CSS styling
- Meta XML configuration

### 5. Data Migration
```
"Create field mapping from legacy CRM Contact to Salesforce Contact"
```

**What you'll get:**
- Detailed field mappings
- Transformation logic
- Edge case handling
- Validation rules impact
- Testing plan

## Real-World Example: Complete Feature Build

Let's build the TaxSlayer opportunity routing feature from start to finish.
Let's build the multi-team opportunity routing feature from start to finish.

### Step 1: Requirements (2 minutes)

```
"Create acceptance criteria for the TaxSlayer multi-team opportunity routing system. 
"Create acceptance criteria for the enterprise multi-team opportunity routing system. 
It should:
- Route based on territory, product, and deal size
- Handle duplicate detection
- Include approval workflow for exceptions
- Support Enterprise, Mid-Market, and SMB teams"
```

**Result:** Comprehensive AC with 30+ criteria covering all scenarios

### Step 2: Development (10 minutes)

```
"Generate Flow for opportunity territory routing based on the AC we just created"

"Create Apex trigger handler for duplicate detection on Opportunity"

"Create LWC component for queue dashboard showing team opportunities"
```

**Result:** Production-ready code for all components

### Step 3: Testing (5 minutes)

```
"Generate test class for OpportunityTriggerHandler"

"Create test data builder for Opportunity and Territory"

"Generate Jest tests for the queue dashboard component"
```

**Result:** Complete test coverage (85%+)

### Step 4: Documentation (10 minutes)

```
"Create job aid for sales reps on the new routing system"

"Generate technical spec for the opportunity routing architecture"

"Create runbook for deploying the routing system to production"
```

**Result:** Complete documentation for all audiences

### Total Time: ~30 minutes
**Traditional Approach: 2-3 days**

## Customization (15 Minutes)

Make these skills truly yours by adding your patterns:

### 1. SalesforceAcceptanceCriteria
Edit `context/SalesforceStandards.md`:
- Your naming conventions
- Your Flow patterns
- Your client-specific requirements

### 2. SalesforceDocumentation
Edit `context/DocumentationStandards.md`:
- Your company's style guide
- Your screenshot standards
- Your template preferences

### 3. SalesforceTesting
Edit `context/TestingPatterns.md`:
- Your test class structure
- Your assertion patterns
- Your coverage requirements

### 4. SalesforceDevelopment
Edit `context/CodingStandards.md`:
- Your code review checklist
- Your preferred patterns
- Your governor limit budgets

### 5. SalesforceDataMigration
Edit `context/MigrationPatterns.md`:
- Your data quality rules
- Your transformation patterns
- Your validation approach

## Tips for Success

### Start Small
Begin with simple user stories before complex features.

### Review and Refine
Generated content is a great starting point - customize to your specific needs.

### Build Your Library
Save your best outputs as templates in the context files.

### Iterate
As you discover new patterns, add them to your skills.

## Common Questions

**Q: Will this work with my existing PAI setup?**
A: Yes! These skills follow standard PAI conventions.

**Q: Can I modify the generated code?**
A: Absolutely! These are starting points. Customize as needed.

**Q: What if I only want one skill?**
A: Copy individual skill directories to $PAI_DIR/Skills/

**Q: How do I update a skill?**
A: Just copy the new version over the old one.

**Q: Can I share these skills?**
A: Yes! MIT licensed - use freely.

## What's Next

### Immediate (Today)
- ✅ Install the suite
- ✅ Test each skill
- ✅ Try a real feature

### Short Term (This Week)
- Add your company's patterns to context files
- Use on actual project work
- Build your template library

### Long Term (This Month)
- Create custom workflows for your domain
- Share patterns with your team
- Consider contributing back

## Support

- 📖 **Main README**: SalesforceSkillsSuite/README.md
- 📖 **Individual READMEs**: Each skill has detailed docs
- 💬 **Ask Claude**: "How do I use the Salesforce AC skill?"
- 🐛 **Issues**: Check workflow files for troubleshooting

## Success Metrics

Track your improvements:

### Time Savings
- Before: X hours to write AC
- After: X minutes with review

### Quality Improvements
- Before: X edge cases missed
- After: 0 edge cases missed

### Consistency
- Before: Different format each time
- After: Consistent every time

## The Vision

This is just the beginning. With these 5 skills, you're:

1. **Capturing Knowledge**: Your patterns encoded once, reused forever
2. **Improving Quality**: Best practices baked in
3. **Saving Time**: Hours → minutes
4. **Pioneering**: First Salesforce PAI skills in the ecosystem

**Next:** Build more domain-specific skills, share with community, help other Salesforce architects.

## Final Thoughts

You now have an unfair advantage:

- ✅ Write better AC faster
- ✅ Generate production-ready code
- ✅ Create comprehensive tests
- ✅ Document thoroughly
- ✅ Plan migrations carefully

**All encoded with YOUR real-world patterns.**

Welcome to the future of Salesforce development! 🚀

---

**Questions? Issues? Ideas?**
Check the individual skill READMEs or ask Claude Code for help.

**Happy building!** 🎉
