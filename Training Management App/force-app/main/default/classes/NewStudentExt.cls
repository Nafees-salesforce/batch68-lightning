public with sharing class NewStudentExt {
       Information__c stureg = new Information__c();
       public NewStudentExt(){}
       public NewStudentExt(ApexPages.StandardController controller) {
       stureg = (Information__c)controller.getRecord();
    }
    
    public Pagereference save() {
        Pagereference pr; //Default value is null
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