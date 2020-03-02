public with sharing class RandomNoCode {
   /* StaticResource static_resource = [SELECT Id,Body
                                  FROM StaticResource 
                                  WHERE Name = 'JavaLibraryfiles'
                                  LIMIT 1];*/
    public String Mobile { get;set; }
    public String otpcode { get;set; }
    Integer randomNumber;
    String code;
    public RandomNoCode(){}
    
    public String OTPCode(){
            if(String.isBlank(Mobile)){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.ERROR,'Please enter Mobile.');
            ApexPages.addMessage(msg);
        }
        else{
            randomNumber = Integer.valueof((Math.random() * 1000000));
            code=string.valueof(randomNumber);
            system.debug('OTP Code------------'+code);
            // Construct data
            String apiKey = 'apikey=' + 'Sgviv3OKno8-6BX3hFyx5tLvyjG1L3SMF5ARwWXWxW';
            String message = '&message=' +'This is your verification code: '+code;
            String sender = '&sender=' + 'TXTLCL';
            String numbers = '&numbers=' + '8008812095';
            // Send data
			 HttpRequest req = new HttpRequest();
             req.setEndpoint('https://api.textlocal.in/send/?apikey=Sgviv3OKno8-6BX3hFyx5tLvyjG1L3SMF5ARwWXWxW');
             req.setMethod('POST');
             req.setHeader('apikey','Sgviv3OKno8-6BX3hFyx5tLvyjG1L3SMF5ARwWXWxW');
             req.setHeader('&sender','TXTLCL');
            // req.setBody('To='+EncodingUtil.urlEncode('8008812095','UTF-8')+'&From='+EncodingUtil.urlEncode('TXTLCL','UTF-8')+message);
             req.setBody(sender+numbers+message);
             Http http = new Http();
             HTTPResponse res = http.send(req);
            String response=res.getBody();
            System.debug(response); 
             if(res.getStatusCode() >= 200 && res.getStatusCode() < 300){
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'SMS Sent Successfully'));
               
            }   
             else{
               ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.ERROR,'It is failed');
               System.debug(response);  
             } 
        }
        return null;
    }
     public Pagereference CheckOTPCode(){
         Pagereference pr;
         if(String.isBlank(otpcode)){
            ApexPages.Message msg1 = new ApexPages.Message(ApexPages.severity.ERROR,'Please enter Verification Code.');
            ApexPages.addMessage(msg1);
        }
        else{
            if(otpcode==code){
                pr=Page.ShowPendingFeePage;
                pr.setRedirect(true);
               
            }
            else{
                ApexPages.Message msg1 = new ApexPages.Message(ApexPages.severity.ERROR,'Your have entered wrong OTP Code.');
                ApexPages.addMessage(msg1);
            }
        }
          return pr;
     }
    public Pagereference cancel(){
        Pagereference pr = Page.RandomNoPage;
        pr.setRedirect(true);
        return pr;
    }
}