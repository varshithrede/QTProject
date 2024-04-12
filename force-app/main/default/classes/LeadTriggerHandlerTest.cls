/**
 * @author      : Varshith
 * @description : Test class for LeadTriggerHandler class. 
 */
@isTest
private class LeadTriggerHandlerTest {

    @TestSetup
    static void makeData(){
        List<Profile> profiles = [SELECT Id FROM Profile WHERE Name IN ('System Administrator')]; 
        List<User> users = new List<User>();
        
        Blob b = Crypto.GenerateAESKey(128);
        String h = EncodingUtil.ConvertTohex(b);
        String uid = h.SubString(0,8);
        insert new List<User>{
            new User(Alias = uid, Email= uid + '@testdomain.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = profiles[0].Id, 
            TimeZoneSidKey='America/New_York', UserName= uid + '@testdomain.com')
        };  
    }
    
    @isTest
    static void insertLeadsTest() {
        User sysAdmin = [SELECT Id FROM User WHERE Profile.Name = 'System Administrator' LIMIT 1];
        System.runAs(sysAdmin){
            Test.startTest();
            List<Lead> leadsToInsert = new List<Lead>();
            for(Integer i=0; i <= 100; i++){
                leadsToInsert.add(new Lead(FirstName = 'test', LastName = 'lead 10'+i, Company = 'Test Comms', Email = 'testLead@testdomain.com', Phone = '7412589637'));
            }
            insert leadsToInsert;
            Test.stopTest();
        }

        System.assertEquals(101, [SELECT Id FROM Contact WHERE LastName LIKE '%lead 10%'].size(), 'Leads failed to convert.');
    }
    
    @isTest
    static void updateLeadsTest(){
        User sysAdmin = [SELECT Id FROM User WHERE Profile.Name = 'System Administrator' LIMIT 1];
        System.runAs(sysAdmin){
            List<Lead> leadsToInsert = new List<Lead>();
            for(Integer i=0; i <= 50; i++){
                leadsToInsert.add(new Lead(FirstName = 'test', LastName = 'lead 10'+i, Company = 'Test Comms'));
            }
            insert leadsToInsert;

            Test.startTest();
            for(Lead ld : leadsToInsert){
                ld.Email = 'testLead@testdomain.com';
                ld.Phone = '789456123';
            }
            update leadsToInsert;
            Test.stopTest();
        }
        System.assertEquals(51, [SELECT Id FROM Contact WHERE LastName LIKE '%lead 10%'].size(), 'Leads failed to convert');
    }
}