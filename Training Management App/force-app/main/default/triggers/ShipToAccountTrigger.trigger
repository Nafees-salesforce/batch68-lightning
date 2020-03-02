/*Requirement:
  On account create a field “ship to account” which should be look up to account.
  Create one more checkbox field active.When there is a change in the ship to account field and active 
  check box is unchecked, transfer all the related contacts to ship to account.*/

trigger ShipToAccountTrigger on Account (before update) {
    List<ID> AccIds = New List<ID>();
    List<Account> acclst = new List<Account>();
    list<Contact> contactlst=new list<Contact>();
    acclst=[select Id,ParentId,Name,Ship_to_account__c,CheckShiptoAccount__c from Account];
    system.debug('Account List------'+acclst);    
    for(Account acc:trigger.new){
        AccIds.add(acc.Id);
        system.debug('New Account Id----------'+AccIds);
    }
    /*for(Account acc:trigger.old){
        AccIds.add(acc.Id);
    }*/
    contactlst =[select Id,AccountId,Name from Contact where AccountId in : AccIds];
    system.debug('Contact List------'+contactlst);
    for(Account a : Trigger.new){
      if(a.Ship_to_account__c != trigger.oldMap.get(a.Id).Ship_to_account__c){
            system.debug(a.Ship_to_account__c);
          if(!a.CheckShiptoAccount__c){
              system.debug(a.CheckShiptoAccount__c);
            for(Contact c:contactlst){
                 c.AccountId=a.ship_to_account__c;//insert
                 system.debug(a.Ship_to_account__c);
                 
                }                 
            }
         }
     }
    system.debug('NewContactLst------------'+contactlst);
    update contactlst;   
              
}