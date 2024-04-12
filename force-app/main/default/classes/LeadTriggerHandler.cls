/**
 * @author      : Varshith
 * @description : Trigger handler for Lead Trigger.
 * @created on  : 04/07/2024
 */
public with sharing class LeadTriggerHandler extends TriggerHandler{

    //trigger context variables
    private List<Lead> newLeads;
    private Map<Id, Lead> newMap;
    private Map<Id, Lead> oldMap;

    public LeadTriggerHandler(){
        newLeads = (List<Lead>) Trigger.new;
        newMap = (Map<Id, Lead>) Trigger.newMap;
        oldMap = (Map<Id, Lead>) Trigger.oldMap;
    }

    /**
     * @description    : executes when a Lead is committed to database 
     */
    public override void afterInsert(){
        Map<Id, Boolean> leadIdsToIsOppCreate = new Map<Id, Boolean>(); // Map of to be converted Lead Ids to flag option for creating an Opportunity
        for(Lead lead : newLeads){
            if(lead.Email <> null && lead.Phone <> null){               // verifying Lead to convert
                leadIdsToIsOppCreate.put(lead.Id, true);
            }
        }
        if(!leadIdsToIsOppCreate.isEmpty()){
            LeadUtility.convertLeadsToContacts(leadIdsToIsOppCreate);   // converts verified Leads to Contacts
        }
    }

    /**
     * @description     : executes when a Lead is updated and committed to database
     */
    public override void afterUpdate(){
        Map<Id, Boolean> leadIdsToIsOppCreate = new Map<Id, Boolean>();                             // Map of to be converted Lead Ids to flag option for creating an Opportunity
        for (Lead lead : newLeads) {
            if(LeadUtility.isChanged(lead, oldMap.get(lead.Id), 'Email') && lead.Email <> null 
            && LeadUtility.isChanged(lead, oldMap.get(lead.Id), 'Phone') && lead.Phone <> null){    // verifying Lead to convert
                leadIdsToIsOppCreate.put(lead.Id, true);
            }
        }
        if(!leadIdsToIsOppCreate.isEmpty()){
            LeadUtility.convertLeadsToContacts(leadIdsToIsOppCreate);                               // converts verified Leads to Contacts
        }
    }
}