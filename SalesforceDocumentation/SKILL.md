---
name: SalesforceDocumentation
description: Generate comprehensive Salesforce documentation including job aids, technical specifications, runbooks, and user guides. USE WHEN user mentions documentation, job aid, user guide, technical spec, runbook, how-to, OR says create, generate, write followed by documentation, guide, spec, or runbook.
---

# Salesforce Documentation

Complete documentation generation for Salesforce implementations following enterprise standards.

## Workflow Routing

**When executing a workflow, do BOTH of these:**

1. **Call the notification script** (for observability tracking):
   ```bash
   ~/.claude/Tools/SkillWorkflowNotification WORKFLOWNAME SalesforceDocumentation
   ```

2. **Output the text notification** (for user visibility):
   ```
   Running the **WorkflowName** workflow from the **SalesforceDocumentation** skill...
   ```

### Workflow Selection

- **Job Aid** → `workflows/JobAid.md`
  - When: Creating end-user documentation
  - Use for: Step-by-step guides with screenshots
  - Audience: Non-technical users
  
- **Technical Spec** → `workflows/TechnicalSpec.md`
  - When: Creating developer/admin documentation
  - Use for: Architecture, data model, implementation details
  - Audience: Developers, admins, architects
  
- **Runbook** → `workflows/Runbook.md`
  - When: Creating operational procedures
  - Use for: Deployment, troubleshooting, support procedures
  - Audience: Support teams, admins
  
- **User Guide** → `workflows/UserGuide.md`
  - When: Creating comprehensive feature documentation
  - Use for: Feature overviews, best practices, FAQs
  - Audience: End users, managers
  
- **Release Notes** → `workflows/ReleaseNotes.md`
  - When: Documenting changes in a release
  - Use for: What's new, what changed, impact analysis
  - Audience: All stakeholders

## Examples

**Example 1: Job Aid**
```
User: "Create a job aid for sales reps on how to use the new territory assignment feature"
→ Invokes JobAid workflow
→ Generates step-by-step guide with screenshots placeholders
→ Returns user-friendly, non-technical documentation
```

**Example 2: Technical Spec**
```
User: "Generate technical documentation for the multi-team opportunity routing system"
→ Invokes TechnicalSpec workflow
→ Creates architecture diagram, data model, integration points
→ Returns comprehensive technical documentation
```

**Example 3: Runbook**
```
User: "Create a runbook for deploying the commerce PDF generation feature"
→ Invokes Runbook workflow
→ Documents deployment steps, validation, rollback procedures
→ Returns operational guide for deployment team
```

## Key Patterns

This skill incorporates enterprise documentation standards:

- **Job Aids**: Friendly tone, screenshots, tips and tricks
- **Technical Specs**: Detailed architecture, code examples, integration points
- **Runbooks**: Clear procedures, decision trees, troubleshooting
- **Consistency**: Same structure across similar doc types
- **Accessibility**: Written for the target audience

## Context Files

- `DocumentationStandards.md` - enterprise documentation templates and style guide
- `ScreenshotGuidelines.md` - How to capture and annotate screenshots
- `CommonProcedures.md` - Reusable procedure templates

## Success Criteria

Good documentation from this skill should:
1. Be appropriate for the target audience
2. Include all necessary context
3. Have clear, actionable steps
4. Include troubleshooting information
5. Be maintainable and updateable
6. Follow consistent formatting
