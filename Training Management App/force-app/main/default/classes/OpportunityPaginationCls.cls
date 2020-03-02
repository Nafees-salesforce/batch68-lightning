public with sharing class OpportunityPaginationCls {
   @auraEnabled
    public static list<Opportunity> getOpp(){
        list<Opportunity> oplst=[select Name,CloseDate,Amount,StageName from Opportunity];
        return oplst;
    }
}