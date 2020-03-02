public class FeeData {
   @AuraEnabled    
    public static List<Information__c> getFee(Id recId) {
       
       return [SELECT  Batch__c,Fee__r.Name,Fee__r.Amount__c from Information__c where Batch__c =: recId ];
    }  
}