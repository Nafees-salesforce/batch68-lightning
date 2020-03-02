public class FeeInfocls {
  public List<Information__c> Infolst {get;set;} 
  public string posId;
    public FeeInfocls() {
        posId = Apexpages.currentPage().getparameters().get('Id');
        
    }
    public pagereference NewFeePage(){
        pagereference p=new pagereference('/apex/NewFeePage');
        p.setRedirect(true);
        return p;
    } 
  public ApexPages.StandardSetController Info {
      get{
          if(Info==null){
               Info=new ApexPages.StandardSetController([SELECT Fee__r.Amount__c,Fee__r.Payment_Mode__c 
                                                        from Information__c where Batch__c =: posId]);
           }
          return Info;
        }
       set;
      }  
 public list<Information__c> getFee1()
 { 
    return  (list<Information__c>) Info.getRecords();    
 }                                          
  
}