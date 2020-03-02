@isTest
public class NewStudentRegisterTest {
  static testmethod void NewStudentform()
  {
     Student__c Stud = new Student__c(); 
     
     Test.startTest();
       PageReference pageRef = Page.NewStudentRegister; // Add your VF page Name here
            pageRef.getParameters().put('Student Name:', 'Jaya Lakshmi');
            pageRef.getParameters().put('First Name:', 'Jaya');
            pageRef.getParameters().put('Last Name:', 'Lakshmi');
            pageRef.getParameters().put('email', 'Jaya.lakshmi@gmail.com');
            pageRef.getParameters().put('Mobile', '1232116576');
            pageRef.getParameters().put('City:', 'Bangalore');
            pageRef.getParameters().put('Country:', 'India');
            pageRef.getParameters().put('Course Name:', 'Salesforce');
            pageRef.getParameters().put('Trainer Name:', 'Srinu');
            Test.setCurrentPage(pageRef);
            ApexPages.StandardController StudLog = new ApexPages.StandardController(Stud);
            NewStudentRegister  newStud=new NewStudentRegister(StudLog);
            newStud.save();
            NewStudentRegister  newStud1=new NewStudentRegister();
            newStud1.cancel();
    Test.StopTest();       
      
  }
}