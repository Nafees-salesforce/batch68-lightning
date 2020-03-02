@isTest(SeeAlldata=True)
public class NewStudentControlTest {
   static testmethod void loginwithexistemail()
   {
     Student__c Stud = new Student__c(); 
     Stud.Email__c='sairam@gmail.com';
     Stud.Mobile__c='1232456576';  
       
     Test.startTest();
       PageReference pageRef = Page.NewStudentHome; // Add your VF page Name here
            pageRef.getParameters().put('email', 'sairam@gmail.com');
            pageRef.getParameters().put('Mobile', '1232456576');
            Test.setCurrentPage(pageRef);
            ApexPages.StandardController StudLog = new ApexPages.StandardController(Stud);
            NewStudentControl newStud=new NewStudentControl(StudLog);
            newStud.validateLogin();
            NewStudentControl newStud1=new NewStudentControl();
            newStud1.cancel();
    Test.StopTest();      
   }
    
   static testmethod void loginwithoutexistemail()
   {
     Student__c Stud = new Student__c(); 
     Stud.Email__c='Raji.ram@gmail.com';
     Stud.Mobile__c='2332456576';  
       
     Test.startTest();
       PageReference pageRef = Page.NewStudentHome; // Add your VF page Name here
            pageRef.getParameters().put('email', 'Raji.ram@gmail.com');
            pageRef.getParameters().put('Mobile', '2332456576');
            Test.setCurrentPage(pageRef);
            NewStudentControl newStud=new NewStudentControl();
            newStud.validateLogin();
            NewStudentControl newStud1=new NewStudentControl();
            newStud.cancel();
    Test.StopTest();        
   } 
}