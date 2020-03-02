public class TestController{

public String apiSessionId {get;set;}
public String apiServerURL {get;set;}

public TestController() {

}

  public pagereference GetSessionIdFromVF(){
  system.debug('%%%%'+apiSessionId );
  system.debug('%%%%'+apiServerURL );
  return null;
  }
}