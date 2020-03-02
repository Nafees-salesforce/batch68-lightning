public class Batchcls {
  public List<Information__c> Infolst {get;set;} 
  public string posId;
    public Batchcls() {
        posId = Apexpages.currentPage().getparameters().get('Id');
        system.debug('posId: '+posId);
    }
    public pagereference NewBatchPage(){
         PageReference p = new PageReference('/apex/NewBatchPage');
         p.setRedirect(true);
         return p;
    }
  public ApexPages.StandardSetController Info {
      get{
          if(Info==null){
             Info=new ApexPages.StandardSetController([SELECT Batch__r.Name,Batch__r.BatchName__c,Batch__r.Start_Date__c,
             Batch__r.End_Date__c,Batch__r.Timing__c,Batch__r.Duration__c from Information__c where Course__c =: posId]);
           }
          return Info;
        }
       set;
      }  
 public list<Information__c> getBatchdata()
 { 
    return  (list<Information__c>) Info.getRecords();    
 }                                          
  
}