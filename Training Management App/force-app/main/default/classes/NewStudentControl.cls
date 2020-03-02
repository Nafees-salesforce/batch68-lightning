public with sharing class NewStudentControl {
    public String email { get;set; }
    public String Mobile { get;set; }
    Student__c Stud = new Student__c(); 
    public NewStudentControl(){}
    public NewStudentControl(ApexPages.StandardController controller){
        Stud = (Student__c)controller.getRecord();
    }
    public Pagereference validateLogin(){
        Pagereference pr;
        if(String.isBlank(email) || String.isBlank(Mobile)){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.ERROR,'Please enter Email and Mobile.');
            ApexPages.addMessage(msg);
        } else { List<Student__c> StudLst =  [Select Email__c from Student__c where Email__c =: email];      
            if( StudLst == null || StudLst.size() ==0 ){
                 ApexPages.message msg = new ApexPages.message(ApexPages.severity.ERROR,'User doesnot exists');
                  ApexPages.addMessage(msg);
                 pr = Page.NewStudentRegister;
               } 
              else {
                   pr = Page.NewStudentPage;                 
             }
        }
       return pr;
    }
    public Pagereference cancel(){
        Pagereference pr = Page.NewStudentHome;
        pr.setRedirect(true);
        return pr;
    }
}