public with sharing class LeadUtility {
    
    /**
     * @author      : Varshith
     * @description : Converts verified Leads to Contacts
     * @create on   : 04/10/20240
     * @param       : List of Lead Ids.
     * @param       : Boolean - sets whether to create an Opportunity while Lead conversion
    */
    public static void convertLeadsToContacts(List<Id> leadIds, Boolean isOppCreate){
        try {
            List<Database.leadConvert> convertLeads = new List<Database.leadConvert>();
            for(Id leadId : leadIds){
                Database.leadConvert leadConvert = new Database.leadConvert();
                leadConvert.setLeadId ( leadId );                
                leadConvert.setConvertedStatus('Closed - Converted');
                leadConvert.setDoNotCreateOpportunity(isOppCreate); 
                convertLeads.add(leadConvert);
            }
            if (!convertLeads.isEmpty()) {
                List<Database.LeadConvertResult> leadConvRes = Database.convertLead(convertLeads);
            }
        } catch (Exception ex) {
            System.debug('convertLeadsToContacts ERROR: '+ ex.getMessage() + ' at line: '+ex.getLineNumber());
            //can log to an error object.
        }
    }

    public static Boolean isChanged(SObject newRecord, SObject oldRecord, String fieldApiName){
        return newRecord <> null && oldRecord <> null && String.isNotBlank(fieldApiName) && newRecord.get(fieldApiName) <> oldRecord.get(fieldApiName);
    }
}