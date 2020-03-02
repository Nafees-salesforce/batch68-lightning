public class Loginbysessionid {
    public String apiServerURL {get;set;} 
    public String apiSessionId {get;set;}
    String ServerName;
          
    public PageReference doLogin(){ 
         Pagereference pr;
        ServerName='https://'+apiServerURL+'.lightning.force.com/secur/frontdoor.jsp?sid='+apiSessionId;
        system.debug(ServerName);
         pr=new PageReference(ServerName);
         return pr;
        }
    public Pagereference cancel(){
        Pagereference pr = Page.LoginbysessionidPage;
        pr.setRedirect(true);
        return pr;
    }
 }