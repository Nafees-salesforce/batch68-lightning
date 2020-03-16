public with sharing class ApexCallwithWireServiceCtrl {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccs(String rating){
        return [select Id, Name, Industry, Rating from Account where Rating =: rating];
    }
    @AuraEnabled
    public static List<Contact> getCons(){
        return [select Id, FirstName, LastName, Email from Contact];
    }
}
