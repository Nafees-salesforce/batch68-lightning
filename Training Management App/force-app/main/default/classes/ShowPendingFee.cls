public class ShowPendingFee {
 public List<Information__c> Infolst {get;set;} 
      public ApexPages.StandardSetController Info {
      get{
          if(Info==null){
           Info=new ApexPages.StandardSetController([SELECT Student__r.Name,Student__r.Email__c,Student__r.Mobile__c,Student__r.Course_Name__c,
                                                     Fee__r.Amount__c,Pending_Fee__c
                                                     from Information__c]);
          }
          return Info;
        }
       set;
      }  
    
 public list<Information__c> getStudent()
 { 
  return (list<Information__c>) Info.getRecords();  
 }
}