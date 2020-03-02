public class FeeDataTable1 {
    @auraEnabled
    public static list<Fee__c> getFee(){
        return [select Name,Amount__c from Fee__c];
    }
     
}