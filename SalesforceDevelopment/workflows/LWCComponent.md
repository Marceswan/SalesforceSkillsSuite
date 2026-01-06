# LWC Component Workflow

Generate production-ready Lightning Web Components.

## Complete LWC Example

### Component: opportunityProductList

**Purpose:** Display and edit opportunity products inline

#### opportunityProductList.html
```html
<template>
    <lightning-card title="Products" icon-name="standard:product">
        <!-- Error handling -->
        <template if:true={error}>
            <div class="slds-m-around_medium">
                <c-error-panel errors={error}></c-error-panel>
            </div>
        </template>

        <!-- Loading spinner -->
        <template if:true={isLoading}>
            <lightning-spinner alternative-text="Loading" size="small"></lightning-spinner>
        </template>

        <!-- Data table -->
        <template if:true={products}>
            <lightning-datatable
                key-field="Id"
                data={products}
                columns={columns}
                onsave={handleSave}
                draft-values={draftValues}
                hide-checkbox-column
                onrowaction={handleRowAction}>
            </lightning-datatable>
        </template>

        <!-- Actions -->
        <div slot="actions">
            <lightning-button
                label="Add Product"
                onclick={handleAddProduct}
                variant="brand">
            </lightning-button>
        </div>
    </lightning-card>
</template>
```

#### opportunityProductList.js
```javascript
import { LightningElement, api, wire } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { updateRecord } from 'lightning/uiRecordApi';
import getProducts from '@salesforce/apex/OpportunityProductController.getProducts';
import saveProducts from '@salesforce/apex/OpportunityProductController.saveProducts';

const COLUMNS = [
    { label: 'Product', fieldName: 'ProductName', type: 'text' },
    { label: 'Quantity', fieldName: 'Quantity', type: 'number', editable: true },
    { label: 'Unit Price', fieldName: 'UnitPrice', type: 'currency', editable: true },
    { label: 'Total', fieldName: 'TotalPrice', type: 'currency' },
    {
        type: 'action',
        typeAttributes: {
            rowActions: [
                { label: 'Delete', name: 'delete' }
            ]
        }
    }
];

export default class OpportunityProductList extends LightningElement {
    // Public properties
    @api recordId;

    // Private properties
    products;
    error;
    columns = COLUMNS;
    draftValues = [];
    isLoading = false;
    _wiredProducts;

    // Wire service to get products
    @wire(getProducts, { opportunityId: '$recordId' })
    wiredProducts(result) {
        this._wiredProducts = result;
        const { data, error } = result;

        if (data) {
            this.products = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.products = undefined;
            this.showToast('Error', 'Failed to load products', 'error');
        }
    }

    // Handle inline editing save
    handleSave(event) {
        this.isLoading = true;
        const recordInputs = event.detail.draftValues.map(draft => ({
            fields: {
                Id: draft.Id,
                Quantity: draft.Quantity,
                UnitPrice: draft.UnitPrice
            }
        }));

        const promises = recordInputs.map(recordInput => 
            updateRecord(recordInput)
        );

        Promise.all(promises)
            .then(() => {
                this.showToast('Success', 'Products updated', 'success');
                this.draftValues = [];
                return refreshApex(this._wiredProducts);
            })
            .catch(error => {
                this.showToast('Error', error.body.message, 'error');
            })
            .finally(() => {
                this.isLoading = false;
            });
    }

    // Handle row actions
    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;

        switch (actionName) {
            case 'delete':
                this.handleDelete(row);
                break;
            default:
        }
    }

    // Delete product
    handleDelete(row) {
        if (!confirm('Delete this product?')) {
            return;
        }

        this.isLoading = true;
        // Call apex to delete
        // Then refresh
    }

    // Add new product
    handleAddProduct() {
        // Open modal or navigate to new record page
    }

    // Show toast notification
    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(event);
    }
}
```

#### opportunityProductList.css
```css
:host {
    display: block;
}

.slds-m-around_medium {
    margin: 1rem;
}
```

#### opportunityProductList.js-meta.xml
```xml
<?xml version="1.0" encoding="UTF-8"?>
<LightningComponentBundle xmlns="http://soap.sforce.com/2006/04/metadata">
    <apiVersion>59.0</apiVersion>
    <isExposed>true</isExposed>
    <targets>
        <target>lightning__RecordPage</target>
        <target>lightning__AppPage</target>
        <target>lightning__HomePage</target>
    </targets>
    <targetConfigs>
        <targetConfig targets="lightning__RecordPage">
            <property name="recordId" type="String" />
            <objects>
                <object>Opportunity</object>
            </objects>
        </targetConfig>
    </targetConfigs>
</LightningComponentBundle>
```

## LWC Best Practices

1. **Error Handling**: Always handle wire service errors
2. **Loading States**: Show spinner during async operations
3. **Toast Messages**: Provide user feedback
4. **Refresh Data**: Use refreshApex after updates
5. **JSDoc Comments**: Document all public methods
6. **Consistent Naming**: camelCase for properties
7. **Accessibility**: Include aria labels
8. **Test Coverage**: Jest tests for all logic
