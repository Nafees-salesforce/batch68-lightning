public with sharing class FilesTableContrl {
    @AuraEnabled
    public static Map<String,Object> getData(Map<String,Object> inputMap){
        Map<String,Object> outputMap = new Map<String,Object>();
        String recordId = (String)inputMap.get('recordId'),
        description = (String)inputMap.get('category');    
        Integer size = Integer.valueOf((Decimal)inputMap.get('size'));    
        outputMap.put(
            'files',
            [SELECT ContentDocumentId, ContentDocument.Title, ContentDocument.LatestPublishedVersionId,  
            ContentDocument.ContentSize, ContentDocument.ContentModifiedDate, ContentDocument.FileType
            FROM ContentDocumentLink WHERE LinkedEntityId =: recordId and ContentDocument.Description =: description 
            order by ContentDocument.ContentModifiedDate desc
            limit: size ]
        );
        return outputMap;
    }
}
