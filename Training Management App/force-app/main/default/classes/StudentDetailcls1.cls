public class StudentDetailcls1 {
  public List<Information__c> Infolst {get;set;} 
  public Id posId {get;set;}   
  public ApexPages.StandardSetController Info {
      get{
          if(Info==null){
              Info=new ApexPages.StandardSetController([SELECT Name,Student__r.Name,Student__r.Email__c,Student__r.Mobile__c,Student__r.City__c,Student__r.Country__c
             from Information__c where Name =: posId]);
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