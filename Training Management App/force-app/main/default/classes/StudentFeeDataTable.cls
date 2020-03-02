public with sharing class StudentFeeDataTable {
    String recordId;
    public String posId;
    public StudentFeeDataTable (){
      posId=ApexPages.currentPage().getParameters().get('Id');
         system.debug('Current Id--------'+posId);        
    }
    @AuraEnabled
    public static Map<String,Object> fetchData(Map<String,Object> inputMap) {
        String recordId = (String)inputMap.get('recordId');
        Map<String,Object> contrlRes = new Map<String,Object>();
        contrlRes.put('records',[SELECT Student__r.Email__c,Student__r.Mobile__c,
                                        Student__r.Paid_Amount__c
                                  from Information__c 
                                     where Student__r.Email__c =: recordId]);
        system.debug('Record Id--------'+recordId);
        system.debug('Control Response------'+ contrlRes);
        List<String> options = new List<String>();
        return contrlRes;
    }
    @AuraEnabled
    public static String upsertResources(List<Information__c> records) {
         Information__c Info=new Information__c();
        // Create an approval request for the Information
         Approval.ProcessSubmitRequest req1 =new Approval.ProcessSubmitRequest();
         req1.setComments('Submitting request for approval.');
        // req1.setObjectId(posId);
        system.debug('Info name--------'+Info.Name);
        // Submit the record to specific process and skip the criteria evaluation
         req1.setProcessDefinitionNameOrId('Submit_for_Approval');  
         req1.setSkipEntryCriteria(true);
         // Submit the approval request for the Information
        Approval.ProcessResult result = Approval.process(req1);
         // Verify the result
        System.assert(result.isSuccess());
        System.assertEquals(
            'Pending', result.getInstanceStatus(),
            'Instance Status'+result.getInstanceStatus());

        // Approve the submitted request
        // First, get the ID of the newly created item
        List<Id> newWorkItemIds = result.getNewWorkitemIds();
        // Instantiate the new ProcessWorkitemRequest object and populate it
         Approval.ProcessWorkitemRequest req2 =new Approval.ProcessWorkitemRequest();
         req2.setComments('Approving request for Information.');
         req2.setAction('Approve');
         req2.setNextApproverIds(new Id[] {UserInfo.getUserId()});
         // Use the ID from the newly created item to specify the item to be worked
         req2.setWorkitemId(newWorkItemIds.get(0));
        // Submit the request for approval
        Approval.ProcessResult result2 =  Approval.process(req2);
        // Verify the results
        System.assert(result2.isSuccess(), 'Result Status:'+result2.isSuccess());
        System.assertEquals(
            'Approved', result2.getInstanceStatus(),
            'Instance Status'+result2.getInstanceStatus());

        system.debug('records: '+records);
        String msg = '';
        try {       
            system.debug('records: '+records);
            List<Information__c> insertResLst = new List<Information__c>();
            List<Information__c> updateResLst = new List<Information__c>();
            if(records != null && records.size() > 0) {
                for(Information__c res : records) {
                    if(res.Id != null) {
                        updateResLst.add(res);
                    }
                    else {
                    	insertResLst.add(res);
                    }
                }
            }
        	if(insertResLst.size() > 0) insert insertResLst;
        	if(updateResLst.size() > 0) update updateResLst;
            system.debug('insertResLst: '+insertResLst);
            system.debug('updateResLst: '+updateResLst);
            msg = 'Success';
        }
        catch(Exception e) {
            msg = 'Error: '+e.getMessage();
        }
        return msg;
    }
    @AuraEnabled
    public static String deleteRec(String recId) {
        String msg;
        Information__c resource = new Information__c(Id = recid);
        try {
        	delete resource;
            msg = 'Success';
        }
        catch(Exception e) {
            msg = 'Error: '+e.getMessage();
        }
        return msg;
    }
}