trigger ContactTrigger on Contact (before delete) {
    List<Contact> con=new List<Contact>();
    con=[select Id,Name,MailingCountry,Account.BillingCountry from Contact where MailingCountry='India' AND Account.BillingCountry='India'];
     
    for(Contact c:trigger.old){
        c.addError('You can not delete this contact');
        break;           
    }
    delete con;
      
}