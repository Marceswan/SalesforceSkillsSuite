# Salesforce Development Generator

Generate production-ready Salesforce code including LWC, Apex, Flows, and triggers.

## What It Generates

- **Lightning Web Components**: Complete HTML/JS/CSS/meta.xml
- **Apex Classes**: Service classes, controllers, batch jobs
- **Flows**: Record-triggered and screen flows
- **Triggers**: Handler pattern with bulkification

## Installation

```bash
cp -r SalesforceDevelopment $PAI_DIR/Skills/
```

## Usage

```
"Create an LWC to display opportunity products with edit capability"
"Generate an Apex service class for territory commission calculation"
"Build a Flow to auto-assign leads based on territory"
```

## Code Standards

- ✅ LWC over Aura
- ✅ Handler pattern for triggers
- ✅ Bulkified (handles 200+ records)
- ✅ Error handling with user-friendly messages
- ✅ JSDoc comments
- ✅ Test-ready code

## Workflows

- **LWCComponent.md** - Lightning Web Component generation
- **ApexClass.md** - Apex service/controller/batch classes
- **Flow.md** - Flow automation
- **ApexTrigger.md** - Trigger and handler classes
