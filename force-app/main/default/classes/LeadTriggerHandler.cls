/**
 * @author      : Varshith
 * @description : Trigger handler for Lead Trigger.
 * @created on  : 04/07/2024
 */
public class LeadTriggerHandler extends TriggerHandler{

    private List<Lead> newLeads;
    private Map<Id, Lead> newMap;
    private Map<Id, Lead> oldMap;

    public LeadTriggerHandler(){
        newLeads = (List<Lead>) Trigger.new;
        newMap = (Map<Id, Lead>) Trigger.newMap;
        oldMap = (Map<Id, Lead>) Trigger.oldMap;
    }

    /**executes when a Lead is committed to database */
    public override void afterInsert(){
        
    }

    /**executes when a Lead is updated and committed to database */
    public override void afterUpdate(){
        
    }
}