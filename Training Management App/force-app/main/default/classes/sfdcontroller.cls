public with sharing class sfdcontroller {

    @AuraEnabled
    public static List<Information__c> getinformation(){
        
        List<Information__c> obj = [SELECT Student__r.Name,Student__r.Email__c,Student__r.Mobile__c,Student__r.Course_Name__c,
                                                     Fee__r.Amount__c,Pending_Fee__c
                                                     from Information__c limit 50000];
        return obj;
    }
}