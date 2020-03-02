public with sharing class ContactListCtrl {

    @AuraEnabled
    public static List<Contact> getContactList()
    {
        List<Contact> ContactList= new List<contact>();
        for(contact c:[select id,Name,Email,phone from contact where email!=null]){
            ContactList.add(c);
        }
        return ContactList;
    }
    
    @AuraEnabled
    public static List<Contact> searchContact(String searchParam)
    {
        String likeParam =searchParam+'%';
        list<contact> clst=new list<contact>();
        for(Contact con : [Select Id,Name,Email,phone from contact where Name like:likeParam]){
            clst.add(con);
        }
        
        return clst ;
      }   
}