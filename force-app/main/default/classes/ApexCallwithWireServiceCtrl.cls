public with sharing class ApexCallwithWireServiceCtrl {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccs(String rating){
        return [select Id, Name, Industry, Rating from Account where Rating =: rating];
    }
    @AuraEnabled
    public static Map<String,Object> getCons(Map<String,Object> inputMap){
        Map<String,Object> outputMap = new Map<String,Object>();
        outputMap.put('contacts',[select Id, FirstName, LastName, Email from Contact]);
        return outputMap;
    }
    @AuraEnabled
    public static string deleteRow(String recordId){
        system.debug('recordId: '+recordId);
        String msg;
        try {
            delete [select Id from Contact where Id =: recordId];
            msg = 'Record has been deleted';
        }
        catch(Exception e) {
            msg = 'Exception: '+e.getMessage();
        }
        return msg;
    }
}
