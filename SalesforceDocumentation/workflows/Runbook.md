# Runbook Workflow

Generate operational runbooks for deployment, troubleshooting, and support procedures.

## Template

```markdown
# Runbook: [Feature/Process Name]

**Version:** 1.0  
**Last Updated:** [Date]  
**Owner:** [Team/Person]  
**On-Call Contact:** [Phone/Email]

---

## Purpose

This runbook provides step-by-step procedures for:
- Deploying [feature name]
- Monitoring [feature name]
- Troubleshooting common issues
- Rolling back if needed

---

## Prerequisites

**Required Access:**
- [ ] Production org system admin
- [ ] Deployment credentials
- [ ] Monitoring dashboard access
- [ ] Support ticket system

**Required Tools:**
- [ ] Salesforce CLI
- [ ] Git repository access
- [ ] Change set or package
- [ ] Rollback package (if applicable)

---

## Deployment Procedure

### Pre-Deployment Checklist

**24 Hours Before:**
- [ ] Announce maintenance window to users
- [ ] Verify sandbox testing complete (100% pass)
- [ ] Code review approved
- [ ] Security review complete
- [ ] Backup current production metadata
- [ ] Prepare rollback package

**1 Hour Before:**
- [ ] Verify change set/package ready
- [ ] Confirm deployment window with stakeholders
- [ ] Put monitoring in place
- [ ] Have rollback plan ready

### Deployment Steps

**Step 1: Create Backup**
```bash
# Backup current production config
sfdx force:source:retrieve -m ApexClass,Flow,CustomObject
zip -r backup-$(date +%Y%m%d).zip force-app/
```

**Step 2: Deploy to Production**
```bash
# Deploy using change set or CLI
sfdx force:source:deploy -p force-app/ --targetusername prod
```

**Expected Duration:** 10-15 minutes  
**Success Criteria:** All components deploy with no errors

**If Errors Occur:**
→ See Troubleshooting section below

**Step 3: Post-Deployment Validation**

Run these validation checks:

```bash
# 1. Verify Apex classes deployed
sfdx force:apex:class:list --targetusername prod | grep "ClassName"

# 2. Run smoke tests
sfdx force:apex:test:run --testlevel RunSpecifiedTests --tests "SmokeTest"

# 3. Check debug logs for errors
sfdx force:apex:log:list --targetusername prod
```

**Manual Checks:**
- [ ] Open Salesforce UI, navigate to feature
- [ ] Create test record
- [ ] Verify automation executes
- [ ] Check no error emails received
- [ ] Verify integrations still working

**Step 4: Enable for Users**

```bash
# Activate flows
# Enable validation rules
# Update permission sets
```

**Step 5: Monitor for Issues**

Monitor for 1 hour after deployment:
- [ ] Check error logs every 15 minutes
- [ ] Monitor support queue for issues
- [ ] Watch system health dashboard
- [ ] Verify batch jobs running

---

## Monitoring

### Real-Time Monitoring

**What to Monitor:**

1. **Error Logs**
   - Location: Setup → Environments → Logs → Debug Logs
   - Look for: ERROR, FATAL level messages
   - Alert if: More than 5 errors in 10 minutes

2. **Integration Logs**
   - Location: Custom Object → IntegrationLog__c
   - Look for: Failed API calls
   - Alert if: Success rate < 95%

3. **User Reports**
   - Location: Support ticket system
   - Look for: Keywords related to feature
   - Alert if: More than 3 tickets in 1 hour

4. **System Health**
   - Location: Setup → System Overview
   - Look for: API usage, storage limits
   - Alert if: API usage > 80%

### Monitoring Queries

```sql
-- Check for errors in last hour
SELECT Id, CreatedDate, Message 
FROM ErrorLog__c 
WHERE CreatedDate = LAST_N_HOURS:1

-- Check integration success rate
SELECT COUNT(Id), Status__c 
FROM IntegrationLog__c 
WHERE CreatedDate = TODAY 
GROUP BY Status__c

-- Check automation execution
SELECT COUNT(Id), Status__c 
FROM FlowExecution__c 
WHERE CreatedDate = LAST_N_HOURS:1 
GROUP BY Status__c
```

---

## Troubleshooting

### Issue 1: Deployment Failed - Component Errors

**Symptoms:**
- Deployment shows "Component Failures"
- Error: "Invalid field reference"

**Diagnosis:**
```bash
# Check deployment status
sfdx force:source:deploy:report --jobid XXXXXXXXXXXX
```

**Resolution:**
1. Review error messages in deployment report
2. Fix issues in source
3. Re-deploy specific components
4. If critical, rollback (see below)

**Time to Resolve:** 15-30 minutes

---

### Issue 2: Automation Not Triggering

**Symptoms:**
- Records created but flow didn't run
- No errors in logs

**Diagnosis:**
1. Check flow is Active: Setup → Flows → [Flow Name]
2. Check entry criteria met
3. Review debug logs for user

**Resolution:**
```apex
// Enable debug logging for user
Setup → Debug Logs → New
User: [Affected User]
Debug Level: FINEST
Duration: 1 hour
```

Create test record and review debug log

**Common Causes:**
- Flow not activated after deployment
- Entry criteria not met
- User lacks permission

**Time to Resolve:** 10-20 minutes

---

### Issue 3: Performance Degradation

**Symptoms:**
- Pages loading slowly
- Timeout errors
- API limits hit

**Diagnosis:**
```bash
# Check API usage
sfdx force:limits:api:display --targetusername prod

# Review slow queries
Setup → System Overview → Performance
```

**Resolution:**
1. Identify slow operations in logs
2. Add indexes if query-related
3. Optimize SOQL queries
4. Consider batch processing for large operations

**Time to Resolve:** 1-2 hours

---

### Issue 4: Integration Failures

**Symptoms:**
- External system not receiving data
- 401/500 errors in integration logs

**Diagnosis:**
```sql
SELECT Id, ErrorMessage, Request, Response 
FROM IntegrationLog__c 
WHERE Status__c = 'Failed' 
AND CreatedDate = TODAY
```

**Resolution:**

**For 401 Errors (Authentication):**
1. Check Named Credential still valid
2. Refresh OAuth token if needed
3. Verify external system credentials

**For 500 Errors (External System):**
1. Check external system status page
2. Retry with exponential backoff
3. Contact external system support if persists

**Time to Resolve:** 30-60 minutes

---

## Rollback Procedure

### When to Rollback

Rollback if any of these occur:
- Critical functionality broken
- Data corruption detected
- Security issue discovered
- Cannot resolve issue within 2 hours

### Rollback Steps

**Step 1: Disable New Functionality**
```bash
# Deactivate flows
# Disable triggers
# Remove permission sets
```

**Step 2: Deploy Backup Package**
```bash
# Deploy previous version
sfdx force:source:deploy -p backup-[date].zip --targetusername prod
```

**Step 3: Verify Rollback**
- [ ] Test previous functionality works
- [ ] Verify no new errors
- [ ] Check integrations restored

**Step 4: Communicate**
- Email stakeholders about rollback
- Update status page
- Schedule post-mortem

---

## Emergency Contacts

| Role | Name | Phone | Email |
|------|------|-------|-------|
| Salesforce Admin | [Name] | [Phone] | [Email] |
| Development Lead | [Name] | [Phone] | [Email] |
| Product Owner | [Name] | [Phone] | [Email] |
| On-Call Engineer | [Rotation] | [On-call line] | [Email] |

**Escalation Path:**
1. Level 1: Salesforce Admin (0-30 min)
2. Level 2: Development Lead (30-60 min)
3. Level 3: Product Owner (60+ min)

---

## Post-Deployment

### Success Criteria

Deployment is successful when:
- [ ] All components deployed without errors
- [ ] Smoke tests pass
- [ ] No errors in logs for 1 hour
- [ ] Users can access feature
- [ ] Integrations functioning normally
- [ ] No support tickets related to deployment

### Post-Deployment Tasks

**Within 24 Hours:**
- [ ] Review all logs for warnings
- [ ] Check performance metrics
- [ ] Gather user feedback
- [ ] Update documentation if needed

**Within 1 Week:**
- [ ] Review monitoring data
- [ ] Conduct retrospective
- [ ] Document lessons learned
- [ ] Update runbook with any new issues found

---

## Appendix

### Useful Commands

```bash
# Check org limits
sfdx force:limits:api:display

# View recent logs
sfdx force:apex:log:list

# Run specific test class
sfdx force:apex:test:run --tests "TestClassName"

# Query records
sfdx force:data:soql:query -q "SELECT Id FROM Account LIMIT 5"

# Export data
sfdx force:data:tree:export -q "SELECT Id, Name FROM Account"
```

### Log Locations

- Debug Logs: Setup → Environments → Logs → Debug Logs
- Login History: Setup → Users → Login History
- Setup Audit Trail: Setup → Security → View Setup Audit Trail
- Field History: Object detail page → History

---

**Document Version:** 1.0  
**Last Updated:** [Date]  
**Next Review:** [Date + 6 months]
```

## Runbook Best Practices

1. **Clear Steps**: Numbered, sequential, unambiguous
2. **Commands Ready**: Copy-paste ready, tested
3. **Expected Results**: Tell user what they should see
4. **Timeframes**: Estimate time for each step
5. **Emergency Contacts**: Always up to date
6. **Test Regularly**: Run through runbook quarterly
7. **Update After Issues**: Add new troubleshooting as discovered
