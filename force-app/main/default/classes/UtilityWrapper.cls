public with sharing class UtilityWrapper {
    
    public class ExceptionWrapper{
        public String className;
        public String methodName;
        public String errorMessage;
        public String description;
        public Integer lineNumber;
        public ExceptionWrapper(String className, String methodName, String errorMsg, String description, Integer line){
            this.className = className;
            this.methodName = methodName;
            this.errorMessage = errorMsg;
            this.description = description;
            this.lineNumber = line;
        }
    }
}