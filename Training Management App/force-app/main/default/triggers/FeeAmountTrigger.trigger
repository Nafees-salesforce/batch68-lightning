trigger FeeAmountTrigger on Information__c (after insert, after update, after delete, after undelete) {
   Set<Id> studentIds = new Set<Id>();

    for(Information__c Information : trigger.isDelete ? trigger.old : trigger.new) {
        //When there is a change in the Fee Amount for the Student
        if(trigger.isUpdate && Information.Student__c != trigger.oldMap.get(Information.Id).Student__c) {
            if(Information.Student__c != null)
                studentIds.add(Information.Student__c);
            if(trigger.oldMap.get(Information.Id).Student__c != null)
                studentIds.add(trigger.oldMap.get(Information.Id).Student__c);
        }
        //If the Fee Amount is not changed for the Student
        else {
            if(Information.Student__c != null)
               studentIds.add(Information.Student__c);
        }
      }

    List<AggregateResult> aggResult = [select Student__c, SUM(Total_Paid_Amount__c) from Information__c Group By Student__c having Student__c in: studentIds];

    List<Student__c> studentLst = new List<Student__c>();
    for(AggregateResult aggr : aggResult) {
        Student__c student = new Student__c(
            Id = (Id)aggr.get('Student__c'),Paid_Amount__c = (Decimal)aggr.get('expr0')
        );
        studentLst.add(student);
    }
    if(studentLst.size() > 0) {
        try {
               update studentLst;
        }
        catch(Exception e) {
            system.debug('studentLst update exception: '+e.getMessage());
        }
    }
}