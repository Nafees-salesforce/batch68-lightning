public class Studentcls {
 public List<Information__c> Infolst {get;set;} 
  public string posId;
    public Studentcls() {
        posId = Apexpages.currentPage().getparameters().get('Id');
        system.debug('posId: '+posId);
     //   LoadStudentsAmount();
     }
  /*  public void LoadStudentsAmount(){
        AggregateResult[] groupedResults=[select Student__r.Name,SUM(Student__r.Paid_Amount__c) from Information__c where Batch__c in : posId group by Student__r.Name];
       // Object sumAmount = groupedResults[0].get('TotalPaidAmount');
        for (AggregateResult ar : groupedResults){
           // integer value=Integer.valueOf(sumAmount);
        system.debug('Total Paid Amount:'+ 'expr0');
        }       
      }*/
    public pagereference NewStudentPage(){
        pagereference p=new pagereference('/apex/NewStudentHome');
        p.setRedirect(true);
        return p;        
    }
  public ApexPages.StandardSetController Info {
      get{
          if(Info==null){
              system.debug('posId: '+posId);
              Info=new ApexPages.StandardSetController([SELECT Student__r.Name,Student__r.Email__c,Student__r.Mobile__c,Student__r.Whatsapp_No__c,
                                                        Student__r.Paid_Amount__c,Student__r.City__c,Student__r.Country__c
                                                        from Information__c where Batch__c =: posId]);
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