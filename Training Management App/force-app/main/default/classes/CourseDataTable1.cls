public class CourseDataTable1 {
    @auraEnabled
    public static list<Information__c> getCourse(){
        return [SELECT Name,Student__r.Name,Course__r.CourseName__c,Course__r.SubCourse__c
                FROM Information__c ];
    }
}