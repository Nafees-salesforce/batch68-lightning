public class StudentDatatable{
    @AuraEnabled    
    public static List<Information__c> getStudent(Id recId) {
       
     /*  return [SELECT Name,Student__r.First_Name__c,Student__r.Last_Name__c,Student__r.Email__c,Student__r.Mobile__c,Student__r.City__c,
              Student__r.Country__c FROM Information__c];*/
        return [SELECT Name,Student__r.First_Name__c,Student__r.Last_Name__c,Student__r.Email__c,Student__r.Mobile__c,Student__r.City__c,
              Student__r.Country__c FROM Information__c where Batch__c =: recId];
   }
}