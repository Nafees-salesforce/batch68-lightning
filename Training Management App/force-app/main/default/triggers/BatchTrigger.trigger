trigger BatchTrigger on TBatch__c (before insert) { 
    
    //Collecting the record type ids of the batches to only query those related batches   
    Set<Id> recordTypeIds = new Set<Id>();
    TBatch__c batch=new TBatch__c();
    for(TBatch__c batch : trigger.new) {
        recordTypeIds.add(batch.RecordTypeId);
    }
    
    //Fetching the batches related to the inserted batch record types in desc order
    List<TBatch__c> existingBatches = new List<TBatch__c>(
        [Select Id, RecordTypeId, RecordType.Name from TBatch__c where 
        RecordTypeId in: recordTypeIds order by RecordTypeId, CreatedDate desc]
    );
    
    //Preparing each technology and related batches map
    Map<Id,List<TBatch__c>> techRelBatchesMap = new Map<Id,List<TBatch__c>>();
    
    for(TBatch__c batch : existingBatches) {
        if(techRelBatchesMap.containsKey(batch.RecordTypeId)) {
            techRelBatchesMap.get(batch.RecordTypeId).add(batch);
        }
        else {
            techRelBatchesMap.put(batch.RecordTypeId,new List<TBatch__c>{batch});
        }
    }
    
    //Applying the logic to automatically update the Batch Number and Batch.
    for(TBatch__c batch : trigger.new) {
        List<TBatch__c> batchLst = techRelBatchesMap.get(batch.RecordTypeId);
        if(batchLst != null && batchLst.size() > 0) {
            batch.Batch_Number__c = batchLst[0].Batch_Number__c + 1;            
        }
        else {
            batch.Batch_Number__c = 1;
        }
        
        String batchNum = '';
        if(String.valueOf(batch.Batch_Number__c).length() == 1) {
            batchNum = '000'+batch.Batch_Number__c;
        }
        else if(String.valueOf(batch.Batch_Number__c).length() == 2) {
            batchNum = '00'+batch.Batch_Number__c;
        }
        else if(String.valueOf(batch.Batch_Number__c).length() == 3) {
            batchNum = '0'+batch.Batch_Number__c;
        }
        else {
            batchNum = String.valueOf(batch.Batch_Number__c);
        }    
        Time stime=batch.Start_Time__c;
        Integer shour=stime.hour();
        Integer sminute=stime.minute();
        Integer ssecond=stime.second();
        String starttime=shour+':'+sminute;
               
        Time etime=batch.End_Time__c;
        Integer ehour=etime.hour();
        Integer eminute=etime.minute();
        Integer esecond=etime.second();
        String endtime=ehour+':'+eminute;
        
        Date sdate=batch.Start_Date__c;
        Integer syear=sdate.year();
        Integer smonth=sdate.month();
        Integer sday=sdate.day();
        String startdate=String.valueOf(sday+':'+smonth+':'+syear);
        
        DateTime dt1=DateTime.newInstance(syear, smonth, sday, shour, sminute, ssecond);
        String myDatetimeStr = dt1.format('dd MMM yyyy ');
        String mystarttime = dt1.format('hh:mm a');
        DateTime dt2=DateTime.newInstance(syear, smonth, sday, ehour, eminute, esecond);
        String myendtime = dt2.format('hh:mm a');
            
        batch.Name = 'Batch-'+batchNum+'-'+mystarttime+'-'+myendtime+'-'+myDatetimeStr;
    }
    
}