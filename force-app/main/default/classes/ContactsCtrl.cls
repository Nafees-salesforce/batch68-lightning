public with sharing class ContactsCtrl {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(){
        return [select Id, FirstName, LastName, Email from Contact];
    }
}
