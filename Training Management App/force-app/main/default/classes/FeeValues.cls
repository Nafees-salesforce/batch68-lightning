public class FeeValues {
   public List<Information__c> Infolst {get;set;} 
  public string posId;
    public FeeValues() {
        posId = Apexpages.currentPage().getparameters().get('Id');
        system.debug('posId: '+posId);
    }
    
  public ApexPages.StandardSetController Info {
      get{
          if(Info==null){
              system.debug('posId: '+posId);
              Info=new ApexPages.StandardSetController([SELECT Student__r.Name,Fee__r.Name,Fee__r.Amount__c 
                                                        from Information__c where Batch__c =: posId]);
           }
          return Info;
        }
       set;
      }  
 public list<Information__c> getFvalue()
 { 
    return  (list<Information__c>) Info.getRecords();    
 }                                          
  
}