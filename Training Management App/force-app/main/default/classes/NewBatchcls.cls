public with sharing class NewBatchcls {
  Information__c info=new Information__c();
    public string posId;
    public NewBatchcls(){
         posId = Apexpages.currentPage().getparameters().get('Id');
    }
    public NewBatchcls (ApexPages.StandardController controller) {
       info = (Information__c)controller.getRecord();
    }
    public Pagereference save() {
        Pagereference pr; 
             try {
                 if(info.Course__c == posId){
                   insert info;
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.CONFIRM,'It has been saved successfully.');
                ApexPages.addMessage(msg);
                 }    
              }
            catch(Exception e) {
                ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.ERROR,e.getMessage());
                ApexPages.addMessage(msg);
            }
          return pr;
    }

    public Pagereference cancel() {
        Pagereference pr = Page.NewBatchPage;
        pr.setRedirect(true);
        return pr;
    }

}