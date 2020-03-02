public with sharing class StudentFeeBarchartcls {
   
  @auraEnabled
  public static Map<string, integer> getBarChart(String recordId){
      system.debug('Record Id: '+ recordId);
      Map<string, integer> mp = new Map<string, integer>();  
      for(Information__c info:[select Student__r.Name,Student__r.Paid_Amount__c from Information__c 
                              where Batch__c =: recordId])
      {
        mp.put(info.Student__r.Name,integer.valueOf(info.Student__r.Paid_Amount__c));
      }
      return mp;
  }
   
}