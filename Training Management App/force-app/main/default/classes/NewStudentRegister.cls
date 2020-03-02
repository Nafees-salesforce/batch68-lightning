public with sharing class NewStudentRegister {
     Student__c stureg=new Student__c();
     public NewStudentRegister(){}
     public NewStudentRegister (ApexPages.StandardController controller) {
       stureg = (Student__c)controller.getRecord();
    }
    
    public Pagereference save() {
        Pagereference pr; 
        
             try {
                insert stureg;
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.CONFIRM,'It has been saved successfully.');
                ApexPages.addMessage(msg);
              }
            catch(Exception e) {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.ERROR,e.getMessage());
                ApexPages.addMessage(msg);
            }
          return pr;
    }

    public Pagereference cancel() {
        Pagereference pr = Page.NewStudentRegister;
        pr.setRedirect(true);
        return pr;
    }

}