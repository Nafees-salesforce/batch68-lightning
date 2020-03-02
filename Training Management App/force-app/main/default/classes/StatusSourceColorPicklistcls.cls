public with sharing class StatusSourceColorPicklistcls {
    @AuraEnabled
    public static list<Opportunity> getOpp(String recordId){
      list<Opportunity> opl =new list<Opportunity>();
        String status;
        for( Opportunity o:[select id,Name,Status__c from Opportunity where id =: recordId]) {
            opl.add(o);
        } 
       return opl;
    }
}