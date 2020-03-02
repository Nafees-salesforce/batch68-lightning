public class Coursecls {
   public List<Information__c> Infolst {get;set;} 
  public string posId;
    public Coursecls() {
        posId = Apexpages.currentPage().getparameters().get('Id');
        system.debug('posId: '+posId);
    }
    
    public pagereference NewCoursePage(){
         PageReference p = new PageReference('/apex/NewCoursePage');
         p.setRedirect(true);
         return p;
    }
  public ApexPages.StandardSetController Info {
      get{
          if(Info==null){
              system.debug('posId: '+posId);
              Info=new ApexPages.StandardSetController([SELECT Course__r.CourseName__c,Course__r.SubCourse__c 
                                                        from Information__c where Batch__c =: posId]);
           }
          return Info;
        }
       set;
      }  
 public list<Information__c> getCourse()
 { 
    return  (list<Information__c>) Info.getRecords();    
 }                                           
}