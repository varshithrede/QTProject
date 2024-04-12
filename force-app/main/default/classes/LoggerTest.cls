/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-12-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public with sharing class LoggerTest {
    
    
    @isTest
    static void createExceptionLogTest(){

        UtilityWrapper.LoggerWrapper testLog = new UtilityWrapper.LoggerWrapper('LoggerTest', 'createExceptionLogTest', 'Test Exception Message', 'Test Exception Message', 00,'Error');
        Test.startTest();
        Logger.createExceptionLog(testLog);
        Test.stopTest();
        List<Logger__c> errorLog = [SELECT Id, Class_Name__c, Method_Name__c FROM Logger__c LIMIT 1];
        System.assertEquals(true, !errorLog.isEmpty(), 'Exception log is not created.');
    }
}