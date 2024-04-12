@isTest
public with sharing class LoggerTest {
    
    
    @isTest
    static void createExceptionLogTest(){

        UtilityWrapper.ExceptionWrapper testLog = new UtilityWrapper.ExceptionWrapper('LoggerTest', 'createExceptionLogTest', 'Test Exception Message', 'Test Exception Message', 00);
        Test.startTest();
        Logger.createExceptionLog(testLog);
        Test.stopTest();
        List<Exception_Log__c> errorLog = [SELECT Id, Class_Name__c, Method_Name__c FROM Exception_Log__c LIMIT 1];
        System.assertEquals(true, !errorLog.isEmpty(), 'Exception log is not created.');
    }
}