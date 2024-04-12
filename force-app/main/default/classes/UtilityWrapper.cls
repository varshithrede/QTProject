/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 04-12-2024
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class UtilityWrapper {
    
    public class LoggerWrapper{
        public String className;
        public String methodName;
        public String errorMessage;
        public String description;
        public Integer lineNumber;
        public String type;
        public LoggerWrapper(String className, String methodName, String errorMsg, String description, Integer line, String type){
            this.className = className;
            this.methodName = methodName;
            this.errorMessage = errorMsg;
            this.description = description;
            this.lineNumber = line;
            this.type = type;
        }
    }
}