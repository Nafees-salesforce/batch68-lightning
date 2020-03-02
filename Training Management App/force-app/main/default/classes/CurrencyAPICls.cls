public with sharing class CurrencyAPICls {
   @AuraEnabled
    public static String calloutCurrency() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('http://api.currencylayer.com/live?access_key=26cf11608e139153106e8945290da626&format=1');
        req.setMethod('GET'); 
        Http http = new Http();
        HTTPResponse res = http.send(req);
        System.debug(res.getBody());
        return res.getBody();
    }
}