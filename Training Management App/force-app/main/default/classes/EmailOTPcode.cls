public with sharing class EmailOTPcode {
    public String Email { get;set; }
    public String otpcode { get;set; }
    Integer randomNumber;
    String code;
    public EmailOTPcode(){}
    
    public String OTPCode(){
            if(String.isBlank(Email)){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.ERROR,'Please enter Email.');
            ApexPages.addMessage(msg);
        }
        else{
            randomNumber = Integer.valueof((Math.random() * 1000000));
            code=string.valueof(randomNumber);
            system.debug('OTP Code------------'+code);
          /*  Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.toaddresses=new String[] {Email};
            message.optOutPolicy = 'FILTER';
            message.subject = ' OTP Verification Code';
            message.plainTextBody = 'This is Your Verification Code: '+code;
            Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};
            Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);*/
            
            //Construct the data
            String username = 'c50a40e3c35bc944ba6c7bdfec6bd1f9';
            String password='9fe9dcfc3c64d14b446031f513da2c52';
            String apiKey = 'apikey=' + 'c50a40e3c35bc944ba6c7bdfec6bd1f9';
            String message = '&message=' +'This is your verification code: '+code;
            String sender = '&sender=' + 'Mailjet';
            String mail = '&mail=' + Email;
            Blob headerValue = Blob.valueOf(userName + ':' + password);
            String authorizationHeader = 'BASIC ' + EncodingUtil.base64Encode(headerValue);
            
            //Request
            HttpRequest req = new HttpRequest();
            //req.setEndpoint('https://api.mailjet.com/v3.1/send/'+username+password);
            req.setEndpoint('https://api.mailjet.com/v3.1/send/?apikey=c50a40e3c35bc944ba6c7bdfec6bd1f9');
            req.setMethod('POST');
            req.setHeader('Authorization', authorizationHeader);
            req.setBody(sender+mail+message);
            system.debug('setbody----'+sender+mail+message);
            system.debug('Request: '+req);
            
            //Response
             Http http = new Http();
             HTTPResponse res = http.send(req);
            system.debug('Response:'+res);
            String response=res.getBody();
            System.debug(response); 
            if(res.getStatusCode() >= 200 && res.getStatusCode() < 300){
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Email Sent Successfully'));
               
            }   
             else{
               ApexPages.Message msg = new ApexPages.Message(ApexPages.severity.ERROR,'Email is failed to send');
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
                pr=new PageReference('https://batch65-dev-ed.my.salesforce.com/home/home.jsp');
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
        Pagereference pr = Page.EmailOTPcodePage;
        pr.setRedirect(true);
        return pr;
    }   
      
}