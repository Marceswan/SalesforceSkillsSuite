# Job Aid Workflow

Generate user-friendly, step-by-step documentation for end users.

## Purpose

Job aids are for **non-technical users** who need to accomplish a specific task in Salesforce. They should be:
- Easy to follow
- Visual (screenshots, diagrams)
- Jargon-free
- Task-oriented

## Input Requirements

Gather from the user:
1. **Feature/Task**: What are users trying to do?
2. **Target Audience**: Who will use this? (Sales reps, managers, support agents)
3. **Prerequisites**: What setup must be done first?
4. **Common Scenarios**: Typical use cases
5. **Pain Points**: What confuses users?

## Execution Steps

### Step 1: Understand the Task

Extract:
- **Primary Goal**: What does the user want to accomplish?
- **Starting Point**: Where does the user begin?
- **Success Criteria**: How do they know they're done?
- **Common Mistakes**: What goes wrong?

### Step 2: Structure the Job Aid

Use this template:

```markdown
# [Task Name] - Job Aid

**For:** [Target Audience]  
**Purpose:** [What this helps you accomplish]  
**Time Required:** [Estimate]

---

## When to Use This

Use this job aid when you need to [scenario].

**Examples:**
- [Example scenario 1]
- [Example scenario 2]

---

## Before You Start

Make sure you have:
- [ ] [Prerequisite 1]
- [ ] [Prerequisite 2]
- [ ] [Required permission/access]

---

## Step-by-Step Instructions

### Step 1: [Action Title]

**What to do:**
[Clear, simple instruction]

**Where to find it:**
[Location in Salesforce: Tab → Section → Button]

**Screenshot:**
[SCREENSHOT: Description of what to capture]

**💡 Tip:** [Helpful hint]

---

### Step 2: [Action Title]

**What to do:**
[Clear, simple instruction]

**What you'll see:**
[Description of expected result]

**Screenshot:**
[SCREENSHOT: Description of what to capture]

⚠️ **Common Mistake:** [What NOT to do and why]

---

### Step 3: [Action Title]

[Continue pattern]

---

## You're Done! ✅

You should now see:
- [Expected result 1]
- [Expected result 2]

**Next Steps:**
- [What to do after completion]

---

## Troubleshooting

### Problem: [Common issue]
**Why this happens:** [Explanation]  
**How to fix it:** [Solution]

### Problem: [Another common issue]
**Why this happens:** [Explanation]  
**How to fix it:** [Solution]

---

## Tips & Best Practices

- ✅ **Do:** [Best practice]
- ✅ **Do:** [Best practice]
- ❌ **Don't:** [What to avoid]
- ❌ **Don't:** [What to avoid]

---

## Need Help?

**Questions?** Contact [support team/help desk]  
**Found an issue?** Report to [person/team]

---

**Last Updated:** [Date]  
**Version:** [Version number]
```

### Step 3: Write User-Friendly Content

Guidelines:
- **Short sentences**: Max 20 words per sentence
- **Active voice**: "Click the button" not "The button should be clicked"
- **Avoid jargon**: "Contract" not "SOBJECT"
- **Be specific**: "Click Save" not "Save your changes"
- **Use numbers**: "3 business days" not "a few days"

### Step 4: Add Visual Aids

For each major step, include:
- **Screenshot placeholder**: [SCREENSHOT: What to capture]
- **Annotations**: Point out specific buttons, fields
- **Before/After**: Show the change that happens

### Step 5: Include Real Examples

Use actual data examples:
- Account names: "Acme Corporation"
- Opportunity amounts: "$150,000"
- Dates: "March 15, 2026"

Not generic placeholders like "[Account Name]" in the instructions.

## Example Output: Lead Assignment Job Aid

```markdown
# How to Assign Leads to Your Territory - Job Aid

**For:** Sales Representatives  
**Purpose:** Quickly assign incoming leads to yourself or your team  
**Time Required:** 2 minutes per lead

---

## When to Use This

Use this job aid when you need to claim a new lead that matches your territory.

**Examples:**
- A new web lead came in from your state
- Marketing sent you a lead from a trade show
- An unassigned lead shows up in your queue

---

## Before You Start

Make sure you have:
- [ ] Access to the Leads tab
- [ ] Permission to edit leads
- [ ] You know your assigned territory (check with your manager if unsure)

---

## Step-by-Step Instructions

### Step 1: Find the Lead

**What to do:**
1. Click the **Leads** tab at the top of Salesforce
2. Select the **My Territory Queue** list view from the dropdown

**Where to find it:**
Top navigation → Leads tab → List View dropdown (next to "Recently Viewed")

**Screenshot:**
[SCREENSHOT: Leads tab with list view dropdown expanded showing "My Territory Queue"]

**💡 Tip:** Bookmark "My Territory Queue" to access it faster next time!

---

### Step 2: Open the Lead Record

**What to do:**
Click on the lead's **name** (the blue underlined text) to open the full record.

**What you'll see:**
The lead detail page with all information about the prospect.

**Screenshot:**
[SCREENSHOT: Lead list view with one lead name highlighted in blue]

⚠️ **Common Mistake:** Don't click the checkbox on the left - that selects the lead but doesn't open it.

---

### Step 3: Check Lead Information

**What to do:**
Review these key fields to confirm it's in your territory:
- **State** - Should be one of your assigned states
- **Company** - Verify it's a real company (not spam)
- **Lead Source** - How they found us

**Screenshot:**
[SCREENSHOT: Lead detail page with State, Company, and Lead Source fields highlighted]

**💡 Tip:** If State doesn't match your territory, this lead might be misrouted. Skip to Troubleshooting below.

---

### Step 4: Claim the Lead

**What to do:**
1. Click the **Change Owner** button (near the top right)
2. In the popup, select **your name** from the dropdown
3. Click **Save**

**Where to find it:**
Lead detail page → Top right section → "Change Owner" button

**Screenshot:**
[SCREENSHOT: Change Owner dialog box with user dropdown expanded]

**What happens next:**
- You become the lead owner
- The lead moves to your "My Leads" list
- You receive an email confirmation

---

### Step 5: Follow Up

**What to do:**
1. Click **Log a Call** to record your first contact attempt
2. Set a **Task** for follow-up (usually 2 business days)

**Screenshot:**
[SCREENSHOT: Activity section with "Log a Call" and "New Task" buttons]

---

## You're Done! ✅

You should now see:
- Your name in the "Lead Owner" field
- The lead in your "My Leads" list view
- An email notification about the assignment

**Next Steps:**
- Call the lead within 1 business day
- Log all contact attempts in Salesforce
- Convert to opportunity when qualified

---

## Troubleshooting

### Problem: "Change Owner" button is grayed out
**Why this happens:** You don't have permission to change this lead's owner  
**How to fix it:**
1. Check if the lead is locked (approval process)
2. Contact your Salesforce admin if issue persists

### Problem: Lead State doesn't match my territory
**Why this happens:** Lead might be misrouted or need manual review  
**How to fix it:**
1. Don't claim the lead
2. Email salesops@company.com with the lead name
3. They'll reassign to correct territory

### Problem: Lead looks like spam/duplicate
**Why this happens:** Web forms can capture junk leads  
**How to fix it:**
1. Check for duplicate leads (button at top of lead)
2. If duplicate, merge with existing lead
3. If spam, change Status to "Unqualified" and add note

---

## Tips & Best Practices

- ✅ **Do:** Claim leads within 1 hour of assignment
- ✅ **Do:** Check for duplicates before claiming
- ✅ **Do:** Add notes about why you're claiming it
- ❌ **Don't:** Claim leads outside your territory
- ❌ **Don't:** Let leads sit unclaimed for more than 24 hours
- ❌ **Don't:** Change ownership without logging why

---

## Need Help?

**Questions about territories?** Contact your Sales Manager  
**Technical issues?** Email salesforce-support@company.com  
**Found a bug?** Click "Help & Training" → "Report an Issue"

---

**Last Updated:** January 4, 2026  
**Version:** 1.0
```

## Tips for Great Job Aids

### Writing Style
1. **Be conversational**: Write like you're explaining to a colleague
2. **Use "you"**: "You should click..." not "The user should click..."
3. **Be positive**: Focus on what TO do, not just what NOT to do
4. **Use formatting**: Bold important buttons/fields

### Screenshots
1. **Annotate**: Use arrows, circles, highlights
2. **Crop**: Show only relevant parts of the screen
3. **Consistent**: Same zoom level, same theme
4. **Clear**: High resolution, readable text

### Structure
1. **Scannable**: Users should skim and find their step
2. **Sequential**: Step 1, Step 2, Step 3 - no branching
3. **Self-contained**: Each step makes sense on its own
4. **Tested**: Actually follow your own steps

### Common Mistakes to Avoid
- ❌ Too technical: "Navigate to the SOBJECT detail page"
- ✅ User-friendly: "Open the lead record"

- ❌ Vague: "Enter the information"
- ✅ Specific: "Type the company name in the 'Company' field"

- ❌ Assumes knowledge: "Use the standard process"
- ✅ Explicit: "Click the 'Change Owner' button"

- ❌ No visuals: All text, no screenshots
- ✅ Visual: Screenshot for each major step

## Document Maintenance

### Version Control
- Update "Last Updated" date when changed
- Increment version number for major changes
- Keep old versions archived

### Review Schedule
- Review quarterly for accuracy
- Update after any UI changes
- Gather user feedback regularly

### Distribution
- Store in shared drive (not email)
- Link from Salesforce page layouts
- Include in new hire training
