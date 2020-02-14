public with sharing class CalcuatorContrl {
    
    @AuraEnabled
    public static Map<String,Object> save(Map<String,Object> inputMap){
        system.debug('inputMap: '+inputMap);
        //It gets the json in the string format
        String jsonString = (String)inputMap.get('results');

        List<Calculator_Result__c> calcResults = (List<Calculator_Result__c>)JSON.deserialize(jsonString, List<Calculator_Result__c>.class);
        system.debug('calcResults: '+calcResults);

        Map<String,Object> outputMap = new Map<String,Object>{
            'isSuccess' => false,
            'message' => ''
        };
        try {
            insert calcResults;
            outputMap.put('isSuccess', true);
        }
        catch(Exception e) {
            outputMap.put('isSuccess', false);
            outputMap.put('message', 'Exception Message: '+e.getMessage());
        }
        return outputMap;
    }

    //To bring history calucluated results
    @AuraEnabled
    public static Map<String,Object> getHistory(Map<String,Object> inputMap){
        Map<String,Object> outputMap = new Map<String,Object>();
        outputMap.put('rows',[Select Id, Number_1__c, Operator__c, Number_2__c, Result__c from Calculator_Result__c]);
        return outputMap;        
    }

    @AuraEnabled
    public static Map<String,Object> deleteRec(Map<String,Object> inputMap){
        Map<String,Object> outputMap = new Map<String,Object>();

        String recId = (String)inputMap.get('recId');

        List<Calculator_Result__c> calcResult = [Select Id from Calculator_Result__c where Id =: recId];

        if(calcResult != null && calcResult.size() > 0) {
            try {
                delete calcResult;
                outputMap.put('isSuccess',true);
                outputMap.put('message','Record has been deleted successfully.');
                outputMap.put('severity', 'success');
            }
            catch(Exception e) {
                outputMap.put('isSuccess',false);
                outputMap.put('message',e.getMessage());
                outputMap.put('severity', 'error');
            }
        }
        else {
            outputMap.put('isSuccess',false);
            outputMap.put('message','Record Id doesn\'t exists');
            outputMap.put('severity', 'warning');
        }

        return outputMap;
    }
}
