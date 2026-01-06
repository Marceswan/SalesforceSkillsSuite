# Salesforce Acceptance Criteria Generator

> Comprehensive acceptance criteria generation for Salesforce implementations following enterprise patterns and best practices.

## Overview


- Multi-team opportunity routing
- Complex approval workflows
- Integration patterns
- Data migration scenarios
- B2B Commerce implementations
- Agentforce integrations

## What Makes This Different

Most acceptance criteria are vague ("System works correctly") or miss critical edge cases. This skill generates **comprehensive, testable AC** that includes:

- ✅ **All Edge Cases**: Missing data, duplicates, bulk operations, concurrent updates
- ✅ **Security Built-In**: Permissions, sharing rules, field-level security
- ✅ **Error Handling**: User-friendly messages for every failure scenario
- ✅ **Testing Requirements**: Specific unit, integration, and UAT scenarios
- ✅ **Technical Implementation**: Fields, flows, validation rules, formulas
- ✅ **Real-World Patterns**: Based on actual Salesforce implementations

## Installation

### Prerequisites

- Claude Code (or compatible AI agent system)
- PAI installed (see [PAI Installation](https://github.com/danielmiessler/Personal_AI_Infrastructure))

### Install This Skill

1. **Copy skill to your PAI directory:**
   ```bash
   cp -r SalesforceAcceptanceCriteria $PAI_DIR/Skills/
   ```

2. **Verify installation:**
   ```bash
   ls $PAI_DIR/Skills/SalesforceAcceptanceCriteria/
   # Should show: SKILL.md, workflows/, context/
   ```

3. **Test the skill:**
   Open Claude Code and say:
   ```
   Create acceptance criteria for a user story about lead assignment based on territory
   ```

   Claude should:
   - Recognize the intent (mentions "acceptance criteria")
   - Route to SalesforceAcceptanceCriteria skill
   - Execute StandardUserStory workflow
   - Generate comprehensive AC

## Usage

### Basic Usage

Simply mention acceptance criteria in your request:

```
"Create acceptance criteria for [your user story]"
"Generate AC for a feature that [description]"
"Write acceptance criteria for [requirement]"
```

### Workflow Selection

The skill automatically routes to the appropriate workflow:

**StandardUserStory** (Most common)
```
"Create AC for a user story about opportunity auto-closure"
```

**ComplexFeature** (Multi-component)
```
"Generate AC for the enterprise multi-team routing system"
```

**DataMigration** (Coming soon)
```
"Create AC for migrating contacts from legacy CRM"
```

**Integration** (Coming soon)
```
"Generate AC for Zoom Phone API integration"
```

**Automation** (Coming soon)
```
"Create AC for a scheduled job that archives old cases"
```

## Examples

### Example 1: Simple User Story

**Input:**
```
Create acceptance criteria for: 
"As a sales rep, I want leads to auto-assign based on my territory"
```

**Output:**
Complete AC including:
- Happy path assignment
- No territory match scenario
- Inactive rep handling
- Bulk import processing
- Territory overlap resolution
- Email notification requirements
- Fields needed (Territory__c, AssignmentReason__c, etc.)
- Flow logic outline
- Test scenarios

### Example 2: Complex Feature

**Input:**
```
Generate AC for the multi-team opportunity routing system that handles:
- Territory-based routing
- Team assignment (Enterprise, Mid-Market, SMB)
- Duplicate detection
- Approval workflows for exceptions
```

**Output:**
Complete multi-component AC including:
- Data model (TerritoryTeamMapping__c object)
- Routing logic flow with bulk handling
- Duplicate management flow
- Approval process configuration
- Queue dashboard component
- Integration testing scenarios
- Phase-based build order
- Security matrix
- Rollout plan

### Example 3: Integration

**Input:**
```
Create AC for integrating Salesforce with Zoom Phone API to log calls automatically
```

**Output:**
Integration AC including:
- API authentication (Named Credential)
- Inbound webhook handling
- Outbound API calls
- Error handling and retry logic
- Call logging to Activity object
- Integration monitoring
- Test scenarios (success, failure, timeout)

## Customization

### Add Your Own Patterns

Edit `context/SalesforceStandards.md` to include:
- Your company's naming conventions
- Your preferred field types
- Your flow naming patterns
- Your test class templates
- Your client-specific patterns

### Add New Workflows

Create new workflow files in `workflows/`:

```markdown
# MyCustomWorkflow.md

[Your workflow steps]
```

Then add routing in `SKILL.md`:

```markdown
- **Custom Scenario** → `workflows/MyCustomWorkflow.md`
  - When: [Description of when to use]
  - Use for: [Examples]
```

## What Gets Generated

### Standard User Story Output

```markdown
# User Story: [Title]

**As a** [role]
**I want** [capability]
**So that** [benefit]

## Acceptance Criteria

### Functional Requirements
[3-5 happy path scenarios]

### Edge Cases and Validation
[5-10 edge cases with specific handling]

### Security and Access
[Permission checks, sharing rules]

### Error Handling
[User-friendly error messages]

### Testing Requirements
Unit Tests Required: [specific scenarios]
Integration Tests Required: [specific scenarios]
UAT Scenarios: [specific scenarios]

## Technical Implementation Notes

### Fields Required
[Table with API names, types, descriptions]

### Automation
[Flow/Apex details, trigger logic]

### Validation Rules
[Apex formulas with error messages]

### Performance Considerations
[Volume estimates, governor limits]

## Definition of Done
[Checklist of completion criteria]
```

### Complex Feature Output

Includes all of the above PLUS:
- Component breakdown (Data Model, Automation, UI, Integration)
- Component dependencies and build order
- Cross-component integration testing
- Security matrix by component
- Phase-based rollout plan
- Success metrics (technical + business)

## Benefits

### For Product Owners
- Comprehensive requirements prevent scope creep
- Clear acceptance criteria reduce back-and-forth
- Testing requirements defined upfront

### For Developers
- Technical implementation guidance included
- All edge cases documented
- Test scenarios defined
- No ambiguity about requirements

### For QA
- Specific test scenarios to validate
- Edge cases explicitly listed
- UAT scenarios defined

### For Project Managers
- Clear definition of done
- Component dependencies documented
- Phased delivery plan included

## Integration with Other Tools

### Jira
Copy/paste generated AC directly into Jira user stories

### Azure DevOps
Format works with ADO work items

### Confluence
Save generated AC as documentation pages

### GitHub
Include AC in pull request descriptions

## Troubleshooting

**Skill not triggering:**
- Make sure you mention "acceptance criteria" or "AC" in your request
- Check that SKILL.md is in `$PAI_DIR/Skills/SalesforceAcceptanceCriteria/`

**Wrong workflow selected:**
- Be more specific about the type of feature
- Explicitly say "complex feature" or "simple user story"

**Too generic:**
- Provide more context about the feature
- Mention specific Salesforce objects involved
- Indicate data volume or complexity

**Need customization:**
- Edit `context/SalesforceStandards.md` with your patterns
- Add your client-specific patterns
- Create custom workflows as needed

## Contributing


1. Fork this skill
2. Add your patterns to `context/SalesforceStandards.md`
3. Create new workflows for scenarios you encounter
4. Share back with the community

## Related Skills

Works well with:
- **SalesforceDocumentation** - Generate job aids and technical specs
- **SalesforceTesting** - Generate test classes from AC
- **SalesforceDevelopment** - Implement the AC as working code

## Credits

- **Author**: Salesforce Architect
- **PAI Framework**: Daniel Miessler

## License

MIT License - Use freely, modify as needed, attribution appreciated

## Version History

- **v1.0.0** (2026-01-04)
  - Initial release
  - StandardUserStory workflow
  - ComplexFeature workflow  
  - Salesforce standards context
  - Real-world examples from real-world implementations
