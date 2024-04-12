/**
 * @description       : Utility class for Lead Object.
 * @author            : Varshith
 * @modification log
 */
public with sharing class LeadUtility {
    
    public final static String CLOSED_CONVERTED = 'Closed - Converted';

    /**
     * @author      : Varshith
     * @description : Converts verified Leads to Contacts
     * @info        : Standard duplicate rule on Contact will take care of duplicates while Lead insertion and update.
     * @create on   : 04/10/20240
     * @param       : Map<Id, Boolean> -  Map of Lead Ids to Boolean flag to create an Opportunity while Lead conversion.
    */
    public static void convertLeadsToContacts(Map<Id, Boolean> leadIdsToIsOppCreate){
        try {
            List<Database.leadConvert> convertLeads = new List<Database.leadConvert>();
            for(Id leadId : leadIdsToIsOppCreate.keySet()){
                Database.leadConvert leadConvert = new Database.leadConvert();
                leadConvert.setLeadId (leadId);                
                leadConvert.setConvertedStatus(CLOSED_CONVERTED);
                leadConvert.setDoNotCreateOpportunity(leadIdsToIsOppCreate.get(leadId)); 
                convertLeads.add(leadConvert);
            }
            if (!convertLeads.isEmpty()) {
                List<Database.LeadConvertResult> leadConvRes = Database.convertLead(convertLeads);  //converting Leads
            }
        } catch (Exception ex) {
            System.debug('convertLeadsToContacts ERROR: '+ ex.getMessage() + ' at line: '+ex.getLineNumber());
            //logging exception to Logger__c object.
            UtilityWrapper.LoggerWrapper errorLog = new UtilityWrapper.LoggerWrapper('LeadUtility', 'convertLeadsToContacts', ex.getMessage(), 'Lead conversion failed, please check error message.', ex.getLineNumber(), 'Error');
            Logger.createExceptionLog(errorLog);
        }
    }

    /**
     * method to check and return True/False if a field value is udpated 
     * @param   : SObject - updated new SObject record
     * @param   : SObject - updated old SObject record
     * @param   : String - FieldApiName of field.
     * @return  : Boolean  - returns true if passed param field is udpated
     */
    public static Boolean isChanged(SObject newRecord, SObject oldRecord, String fieldApiName){
        return newRecord <> null && oldRecord <> null && String.isNotBlank(fieldApiName) && newRecord.get(fieldApiName) <> oldRecord.get(fieldApiName);
    }
}