public class NewStudentDataTable {
   @auraEnabled
   public static list<Student__c> fetchData(String inputMap)
   {
      return [select Name,Email__c from Student__c]; 
   }
   @auraEnabled
    public static list<Student__c> doSearch(String searchemail){
       string SearchKey = '%' + searchemail + '%';
       list<Student__c> Returnlst = new list<Student__c>();
       list<Student__c> lstStudent =[Select id,Email__c From Student__c WHERE Email__c LIKE: SearchKey limit 1];
       for(Student__c stu: lstStudent)
        {
           ReturnLst.add(stu);
        }
        return Returnlst;
    } 
    @AuraEnabled
    public static String upsertResources(List<Student__c> input) {
        system.debug('Records: '+input);
        String msg = '';
        try {       
            system.debug('Records: '+input);
            List<Student__c> insertResLst = new List<Student__c>();
            List<Student__c> updateResLst = new List<Student__c>();
          
            if(input != null && input.size() > 0) {
                for(Student__c res : input) {
                    if(res.Id != null) {
                        updateResLst.add(res);
                    }
                    
                    else {
                      insertResLst.add(res);
                    }
                }
            }
          if(insertResLst.size() > 0) insert insertResLst;
          if(updateResLst.size() > 0) update updateResLst;
            system.debug('insertResLst: '+insertResLst);
            system.debug('updateResLst: '+updateResLst);
            msg = 'Success';
        }
        catch(Exception e) {
            msg = 'Error: '+e.getMessage();
        }
        return msg;
    }
     @AuraEnabled
    public static String insertRecords(List<Student__c> newRecords) {
        system.debug('Records: '+newRecords);
        String msg=' ';
        try {       
            system.debug('Records: '+newRecords);
            List<Student__c> insertStuLst = new List<Student__c>();
          
            if(newRecords != null && newRecords.size() > 0) {
                for(Student__c res : newRecords) {
                      insertStuLst.add(res);
                    }
                }
            
          if(insertStuLst.size() > 0) insert insertStuLst;
          system.debug('insertStuLst: '+insertStuLst);
            
         }
        catch(Exception e) {
            system.debug('Error: '+e.getMessage());
            msg=e.getMessage();
        }
        return msg;
    }    
}