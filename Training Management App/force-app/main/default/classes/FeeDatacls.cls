public class FeeDatacls {
  public List<Information__c> Infolst {get;set;} 
  public string posId;
    public FeeDatacls() {
        posId = Apexpages.currentPage().getparameters().get('Id');
        system.debug('posId: '+posId);
    }
    public pagereference NewFeePage(){
         PageReference p = new PageReference('/apex/NewFeePage');
         p.setRedirect(true);
         return p;
    }    
  public ApexPages.StandardSetController Info {
      get{
          if(Info==null){
              system.debug('posId: '+posId);
              Info=new ApexPages.StandardSetController([SELECT Fee__r.Amount__c,Fee__r.Payment_Mode__c 
                                                        from Information__c where Student__c =: posId]);
           }
          return Info;
        }
       set;
      }  
 public list<Information__c> getFee()
 { 
    return  (list<Information__c>) Info.getRecords();    
 }                                          
  
}