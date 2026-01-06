---
name: SalesforceAcceptanceCriteria
description: Generate comprehensive acceptance criteria for Salesforce user stories and features. USE WHEN user mentions acceptance criteria, user stories, AC, requirements, feature specs, story writing, OR says generate, create, write followed by acceptance criteria, requirements, or user stories.
---

# Salesforce Acceptance Criteria

Complete acceptance criteria generation for Salesforce implementations following enterprise patterns and best practices.

## Workflow Routing

**When executing a workflow, do BOTH of these:**

1. **Call the notification script** (for observability tracking):
   ```bash
   ~/.claude/Tools/SkillWorkflowNotification WORKFLOWNAME SalesforceAcceptanceCriteria
   ```

2. **Output the text notification** (for user visibility):
   ```
   Running the **WorkflowName** workflow from the **SalesforceAcceptanceCriteria** skill...
   ```

### Workflow Selection

- **Standard User Story** → `workflows/StandardUserStory.md`
  - When: Creating acceptance criteria for a single user story
  - Use for: Feature requests, enhancements, bug fixes
  
- **Complex Feature** → `workflows/ComplexFeature.md`
  - When: Multi-component feature spanning multiple objects/systems
  - Use for: Major integrations, multi-step processes, complex automation
  
- **Data Migration** → `workflows/DataMigration.md`
  - When: Data import, export, or transformation requirements
  - Use for: Field mappings, bulk operations, data quality rules
  
- **Integration** → `workflows/Integration.md`
  - When: External system integration or API work
  - Use for: REST/SOAP APIs, middleware, external data sources
  
- **Automation** → `workflows/Automation.md`
  - When: Flows, Process Builder, Apex automation
  - Use for: Triggers, scheduled jobs, batch processes

## Examples

**Example 1: Standard User Story**
```
User: "Create acceptance criteria for a user story about lead assignment based on territory"
→ Invokes StandardUserStory workflow
→ Generates comprehensive AC with functional requirements, edge cases, validation rules
→ Returns formatted markdown ready for Jira/ADO
```

**Example 2: Complex Feature**
```
User: "I need acceptance criteria for the enterprise multi-team opportunity routing system"
→ Invokes ComplexFeature workflow
→ Breaks down into components: role hierarchies, duplicate management, automation flows
→ Returns detailed AC for each component with dependencies
```

**Example 3: Integration**
```
User: "Write acceptance criteria for Zoom Phone API integration"
→ Invokes Integration workflow
→ Includes API endpoints, authentication, error handling, data mapping
→ Returns technical AC with security and performance requirements
```

## Key Patterns

This skill incorporates established patterns:

- **User Story Format**: "As a [role], I want [capability] so that [benefit]"
- **Comprehensive Coverage**: Functional requirements, edge cases, validation, security, testing
- **Technical Depth**: Implementation details, field requirements, automation logic
- **Real-World Edge Cases**: Based on actual project experience
- **Testing Requirements**: Unit tests, integration tests, user acceptance testing

## Context Files

- `SalesforceStandards.md` - Salesforce architecture patterns
- `AcceptanceCriteriaTemplate.md` - Standard AC template structure
- `CommonEdgeCases.md` - Library of common edge cases by feature type

## Success Criteria

Good acceptance criteria from this skill should:
1. Be testable and verifiable
2. Include all edge cases and error scenarios
3. Specify validation rules and security requirements
4. Define clear success/failure conditions
5. Include technical implementation guidance
6. Be comprehensive enough for handoff to another team
