public with sharing class ContactsCtrl {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String fnFilter){
        String filterKey = fnFilter+'%';
        return [select Id, FirstName, LastName, Email from Contact where (Not FirstName like : filterKey)];
    }
}
