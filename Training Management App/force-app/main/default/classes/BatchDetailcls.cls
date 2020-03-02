public class BatchDetailcls {
  public List<Information__c> Infolst {get;set;} 
  public string posId;
    public BatchDetailcls() {
        posId = Apexpages.currentPage().getparameters().get('Id');
        system.debug('posId: '+posId);
    }
    
  public ApexPages.StandardSetController Info {
      get{
          if(Info==null){
              system.debug('posId: '+posId);
              Info=new ApexPages.StandardSetController([SELECT Batch__r.Name,Batch__r.BatchName__c,Batch__r.Start_Date__c,
             Batch__r.End_Date__c,Batch__r.Duration__c from Information__c where Course__c =: posId]);
           }
          return Info;
        }
       set;
      }  
 public list<Information__c> getStudent()
 { 
    return  (list<Information__c>) Info.getRecords();    
 }                                          
  
}