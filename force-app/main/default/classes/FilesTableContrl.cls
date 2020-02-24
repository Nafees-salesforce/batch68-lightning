public with sharing class FilesTableContrl {
    @AuraEnabled
    public static Map<String,Object> getData(Map<String,Object> inputMap){
        Map<String,Object> outputMap = new Map<String,Object>();
        String recordId = (String)inputMap.get('recordId');
        outputMap.put(
            'files',
            [Select Id, ContentDocumentId, ContentDocument.ParentId, ContentUrl from ContentVersion 
            where ContentDocument.ParentId =: recordId and IsLatest = true]
        );
        return outputMap;
    }
}
