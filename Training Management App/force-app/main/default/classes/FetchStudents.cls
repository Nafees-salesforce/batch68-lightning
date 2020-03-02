global with sharing class FetchStudents {
@auraEnabled
    public static List<Student__c> getAllstudents()
    {
     List<Student__c> std=new List<Student__c>();  
        std=[select id,First_Name__c, Last_Name__c, Email__c,Course_Name__c, City__c, Country__c, Trainer_Name__c from Student__c];
        return std;
    } 
    public Student__c getSelectedstudents(Id id)
    {    
      Student__c std=[select id,First_Name__c, Last_Name__c, Email__c,Course_Name__c, City__c, Country__c,Trainer_Name__c from Student__c Where Id=: id];
        return std;
    }
}