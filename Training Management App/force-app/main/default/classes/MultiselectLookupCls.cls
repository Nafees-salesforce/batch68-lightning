public with sharing class MultiselectLookupCls {
     @AuraEnabled
     public static List < sObject > getLookUpValues(String searchName, String ObjName, List<sObject> ExcludeitemsList) {
        String searchKey = '%' + searchName + '%';
        List < sObject > objList = new List < sObject > ();
 
        List<string> lstExcludeitems = new List<string>();
        for(sObject item : ExcludeitemsList ){
            lstExcludeitems.add(item.id);
        }
        
        // Create a Dynamic SOQL Query For Fetch Record List with LIMIT 5 and exclude already selected records  
        String sQuery =  'select id, Name from ' +ObjName + ' where Name LIKE: searchName AND Id NOT IN : lstExcludeitems order by createdDate DESC limit 5';
        List < sObject > lstOfRecords = Database.query(sQuery);
        
        for (sObject obj: lstOfRecords) {
            objList.add(obj);
        }
        return objList;
    }
}