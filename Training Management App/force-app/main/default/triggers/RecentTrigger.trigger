trigger RecentTrigger on Opportunity (before update) {
Date recentdate;
    Opportunity opp=[select Id,CloseDate,RecentCreatedDate__c from Opportunity order by CloseDate desc limit 1];
    for(Opportunity opp : trigger.new) {

        if(opp.StageName == 'Closed Lost' && trigger.oldMap.get(opp.Id).StageName == 'Closed Won'){
            opp.RecentCreatedDate__c=opp.CloseDate;
                        
        }
       
            
    }
    update opp;

}