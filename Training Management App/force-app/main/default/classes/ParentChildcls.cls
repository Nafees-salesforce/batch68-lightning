public with sharing class ParentChildcls {
    public List<AccountWrapperCls> acctList {get;set;}
    AccountWrapperCls cWrapper;
    list<Contact> contactlst=new list<Contact>();
    List<Account> AccsLst = new List<Account>();
    List<Account> MergeAccs = new List<Account>();
    public string posId;
    public ParentChildcls(ApexPages.StandardController con){}
    public ParentChildcls() {
        posId = Apexpages.currentPage().getparameters().get('Id');
        system.debug(posId);
    }
    Public List<AccountWrapperCls> getWrapperList(){
        acctList = new List<AccountWrapperCls>(); 
        AccsLst=[SELECT Id, ParentId,Name from Account where Id !=:posId];
        for(Account acc:AccsLst){
            acctList.add(New AccountWrapperCls(acc));
        }
       
        return acctList;
    }
    
    public pagereference MergeAction(){
      //  posId='0012w000003lKvmAAE';
        MergeAccs=[SELECT Id, ParentId,Name from Account where Id =:posId];
         system.debug(MergeAccs);
       contactlst =[select Id,Name from Contact where AccountId =: posId];
        for(AccountWrapperCls obj:acctList){
            if(obj.isSelected){
                for(Contact c:contactlst){
                 c.AccountId=obj.cAccount.Id;
                     system.debug(obj.cAccount.Id);
                } 
            }
        }
         update contactlst;
        
        system.debug(contactlst);
        //system.debug();
         return null; 
    }                  
    
}