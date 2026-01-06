---
name: SalesforceDevelopment
description: Generate Salesforce code including LWC components, Apex classes, Flows, and validation rules. USE WHEN user mentions LWC, lightning component, apex class, flow, trigger, validation rule, OR says generate, create, build followed by component, code, class, or flow.
---

# Salesforce Development

Generate production-ready Salesforce code following best practices and development best practices.

## Workflow Routing

- **LWC Component** → `workflows/LWCComponent.md`
  - When: Creating Lightning Web Component
  - Use for: UI components, record forms, custom actions
  
- **Apex Class** → `workflows/ApexClass.md`
  - When: Creating Apex controller or service class
  - Use for: Business logic, API integrations, batch jobs
  
- **Flow** → `workflows/Flow.md`
  - When: Creating Flow automation
  - Use for: Record-triggered flows, screen flows
  
- **Trigger** → `workflows/ApexTrigger.md`
  - When: Creating Apex trigger
  - Use for: Complex automation, bulk processing

## Key Patterns

**Development Standards:**
- **LWC over Aura**: Always use Lightning Web Components
- **Handler Pattern**: Triggers call handler classes
- **Bulkification**: All code handles 200 records
- **Error Handling**: User-friendly messages
- **Test Coverage**: 85%+ minimum
- **Documentation**: JSDoc for all methods

## Examples

**Example 1: LWC Component**
```
User: "Create an LWC to display opportunity products with edit capability"
→ Generates complete component:
  - HTML template with data table
  - JS controller with wire services
  - Apex controller for DML
  - CSS styling
  - Test file
  - Meta XML configuration
```

**Example 2: Apex Class**
```
User: "Generate an Apex class to calculate territory commission"
→ Creates complete class:
  - Service class pattern
  - Bulkified methods
  - Error handling
  - JSDoc comments
  - Test class outline
```
