trigger TestCaseTrigger on Case (before insert) {
    List<ID> AccIds = New List<ID>();
    List<Account> acclst = new List<Account>();
    list<Contact> contactlst=new list<Contact>();
    Case c=new Case();
    c=[select Id,ParentId,Account.BillingAddress,Contact.MailingAddress from Case];
    
    
}