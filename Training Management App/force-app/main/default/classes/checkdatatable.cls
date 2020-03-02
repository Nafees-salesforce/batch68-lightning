public class checkdatatable {

     @AuraEnabled    
    public static List<Opportunity> getOpportunities() {
        return [Select Id, Name, Amount, StageName, CloseDate from Opportunity];
    }
}