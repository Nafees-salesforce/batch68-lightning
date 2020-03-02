public class FeeDetailcls {
 public List<Information__c> Infolst {get;set;} 
 public string posId;
    public FeeDetailcls() {
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
                                                        from Information__c where Course__c =: posId]);
           }
          return Info;
        }
       set;
      }  
 public list<Information__c> getValue()
 { 
    return  (list<Information__c>) Info.getRecords();    
 }                                          
  
}