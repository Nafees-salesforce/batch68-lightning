public  with sharing class StudentDetailcls {
  public List<Information__c> Infolst {get;set;} 
  public string posId;
    public StudentDetailcls() {
        posId = Apexpages.currentPage().getparameters().get('Id');
    }
    public pagereference NewStupage(){
        pagereference p=new pagereference('/apex/NewStudentHome');
        p.setRedirect(true);
        return p;
    }
  public ApexPages.StandardSetController Info {
      get{
          if(Info==null){
           Info=new ApexPages.StandardSetController([SELECT Student__r.Name,Student__r.Email__c,Student__r.Mobile__c,Student__r.Whatsapp_No__c,
                                                     Student__r.Paid_Amount__c,Student__r.City__c,Student__r.Country__c
                                                     from Information__c where Course__c =: posId]);
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