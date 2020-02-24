public with sharing class CustomFileContrl {
    public CustomFileContrl() {

    }
    //select id, Description, Title, (Select Id, Title, VersionNumber, Description, IsLatest from ContentVersions) 
        //from ContentDocument where id = '0692v00000EDFHLAA5'
    @AuraEnabled
    public static Map<String,Object> updateOpp(Map<String,Object> inputMap){
        
        Map<String,Object> outputMap = new Map<String,Object>{
            'isSuccess' => false, 'isContentSuccess' => false
        };

        String oppId = (String)inputMap.get('recordId'), description =  (String)inputMap.get('description'),
        category = (String)inputMap.get('category'), fileIdStr = (String)inputMap.get('fileString');
        List<String> fileIds = new List<String>();
        fileIds.addAll(fileIdStr.split(','));

        List<ContentVersion> csLst = [Select Id, Title, VersionNumber, Description, IsLatest, ContentDocumentId from ContentVersion 
        where ContentDocumentId in: fileIds and IsLatest = true];
        if(csLst != null && csLst.size() > 0) {
            for(ContentVersion cv : csLst) {
                cv.Description = category;
            }
            try {
                update csLst;
                outputMap.put('isContentSuccess',true);
            }
            catch(Exception e) {
                outputMap.put('contentMessage','Error: '+e.getMessage()+' in Line Number: '+e.getLineNumber());
            }
        }

        Opportunity opp = new Opportunity(
            Id = oppId,
            Description = description
        );

        String msg = '';
        try {
            update opp;
            msg = 'Opportunity has been addated successfully.';
            outputMap.put('isSuccess', true);
        }
        catch(Exception e) {
            msg = 'Exception while updating the opportunity: '+e.getMessage()+' in Line Number: '+e.getLineNumber();
        }
        outputMap.put('message', msg);

        return outputMap;
    }
}
