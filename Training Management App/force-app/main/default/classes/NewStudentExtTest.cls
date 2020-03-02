@isTest
public class NewStudentExtTest {
  static testmethod void ExistStudent()
  {
      Information__c studreg = new Information__c();
      Test.startTest();
        PageReference pageRef = Page.NewStudentPage;
        pageRef.getParameters().put('Batch:', 'BT-0004');
        pageRef.getParameters().put('Student Name:', 'Balaji Jay');
        pageRef.getParameters().put('Course Name:', 'Java');
        pageRef.getParameters().put('Trainer Name:', 'Krishna');
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController StudLog = new ApexPages.StandardController(studreg);
        NewStudentExt existStud=new NewStudentExt(StudLog);
        existStud.save();
         NewStudentExt existStud1=new NewStudentExt();
        existStud1.cancel();
      Test.stopTest();
   }
}