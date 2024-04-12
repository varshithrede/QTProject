/**
 * @author      : Varshith
 * @description : Test class for LeadUtility class. 
 */
@isTest
private class LeadUtilityTest {

    @TestSetup
    static void makeData(){

        
        User sysAdmin = TestFactory.createUser('System Administrator'); //System Admin User

        System.runAs(sysAdmin){
            
            List<Lead> leadsToInsert = new List<Lead>();
            for(Integer i=0; i <= 10; i++){
                leadsToInsert.add(new Lead(FirstName = 'test', LastName = 'lead 20'+i, Company = 'Test Comms', Email = 'testLead20'+i+'@testdomain.com', Phone = '7412589637'));
            }
            TriggerHandler.bypass('LeadTriggerHandler');   //bypassing the trigger because we don't want trigger logic to convert Leads.
            insert leadsToInsert;
        }
    }

    @isTest
    static void convertLeadsToContactsTest() {
        
        Map<Id,Boolean> leadIdsToIsOppCreate = new Map<Id, Boolean>();
        for(Lead ld : [SELECT Id FROM Lead WHERE LastName LIKE '%lead 20%']){
            leadIdsToIsOppCreate.put(ld.Id, true);
        }
        User sysAdmin = [SELECT Id FROM User WHERE Profile.Name = 'System Administrator' LIMIT 1];
        System.runAs(sysAdmin){
            Test.startTest();
            LeadUtility.convertLeadsToContacts(leadIdsToIsOppCreate);       //Converting Leads to Contacts.
            Test.stopTest();
        }
        System.assertEquals(11, [SELECT Id FROM Contact WHERE LastName LIKE '%lead 20%'].size(), 'Contacts failed to insert');
        
    }

    @isTest
    static void convertLeadsToContactsExceptionTest(){
        Test.startTest();
        LeadUtility.convertLeadsToContacts(new Map<Id, Boolean>{null => true}); //passing null for an Id to throw Exception.
        Test.stopTest();
        Logger__c errorLog = [SELECT Id, Class_Name__c, Method_Name__c FROM Logger__c LIMIT 1];
        System.assertEquals('LeadUtility', errorLog.Class_Name__c, 'error creating Exception logs');
        System.assertEquals('convertLeadsToContacts', errorLog.Method_Name__c, 'error creating Exception logs');
    }
}