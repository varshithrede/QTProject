/**
 * @author      : Varshith
 * @description : Class to log exceptions and other info
 */
public class Logger {

    /**
     * @author      : Varshith
     * @description : method to log exceptions occurred in Apex transactions. Logger__c is used to log records.
     * @param       : LoggerWrapper
     */
    public static void createExceptionLog(UtilityWrapper.LoggerWrapper data){
        if(data == null){
            return;
        }
        
        if(Schema.SobjectType.Logger__c.isCreateable()){
            insert new Logger__c(
                Type__c = data.type,
                Class_Name__c = data.className,
                Method_Name__c = data.methodName,
                Error_Message__c = data.errorMessage,
                Description__c = data.description,
                Line_Number__c = data.lineNumber
            );
        }
    }
}