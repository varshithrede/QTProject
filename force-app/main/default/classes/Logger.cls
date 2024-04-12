/**
 * @author      : Varshith
 * @description : Class to log exceptions and other info
 */
public with sharing class Logger {

    /**
     * @author      : Varshith
     * @description : method to log exceptions occurred in Apex transactions. Exception_Log__c is used to log records.
     * @param       : ExceptionWrapper
     */
    public static void createExceptionLog(UtilityWrapper.ExceptionWrapper data){
        if(data == null){
            return;
        }

        if(Schema.SobjectType.Exception_Log__c.isCreateable()){
            insert new Exception_Log__c(
                Class_Name__c = data.className,
                Method_Name__c = data.methodName,
                Error_Message__c = data.errorMessage,
                Description__c = data.description,
                Line_Number__c = data.lineNumber
            );
        }
    }
}