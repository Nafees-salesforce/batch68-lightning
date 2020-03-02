public with sharing class NewCourse {
    Information__c info=new Information__c();
    public NewCourse(){}
    public NewCourse (ApexPages.StandardController controller) {
       info = (Information__c)controller.getRecord();
    }
    public Pagereference save() {
        Pagereference pr; 
             try {
                insert info;
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
        Pagereference pr = Page.NewCoursePage;
        pr.setRedirect(true);
        return pr;
    }

}