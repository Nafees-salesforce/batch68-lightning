public with sharing class OpportunityDataTableCls {
    @AuraEnabled
    public static list<Opportunity> getOpp(){
       list<Opportunity> opplst=new list<Opportunity>();
        for(Opportunity opp:[select Name,TotalOpportunityQuantity,CloseDate,Amount,StageName 
                             from Opportunity limit 10]){
            opplst.add(opp);
        }
        return opplst;
      } 
    
    @AuraEnabled
    public static list<Opportunity> getOppwithsearch(String nameSearchString){
        String SearchName = nameSearchString +'%';
        list<Opportunity> opplst=new list<Opportunity>();
        for(Opportunity opp:[select Name,TotalOpportunityQuantity,CloseDate,Amount,StageName 
                             from Opportunity where Name like:SearchName limit 10]){
            opplst.add(opp);
        }
        return opplst;
    }
}