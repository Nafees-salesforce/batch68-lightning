@isTest(SeeAllData=true)
public class CourseDataclsTest {
  static testmethod void CourseData()
  {
       Information__c Info=new Information__c();
       Info.Student__c='';
       Info.Student__r.Name='Jhonsi Raju';
       Info.Course__r.CourseName__c='Salesforce';
       Info.Course__r.SubCourse__c='Admin';
       
       Test.startTest();
         CourseDatacls datatest=new CourseDatacls();
         datatest.getCourse();
       //  ApexPages.StandardSetController stdInfo=new ApexPages.StandardSetController();
       // String posId=stdInfo.getRecord().Id;
       Test.stopTest();
  }
}