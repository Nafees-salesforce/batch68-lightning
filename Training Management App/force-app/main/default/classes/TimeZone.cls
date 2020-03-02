public class TimeZone {
   public List<TBatch__c> Infolst {get;set;} 
 //  public boolean isShowValue{get;set;} 
   public Time StartTime{get;set;} 
   public Time EndTime{get;set;}  
   public Date StartDate{get;set;} 
   public Date EndDate{get;set;}  
   public Id currentRecordType{get;set;}  
   TBatch__c batch=new TBatch__c(); 
   public string posId;
   public string recTypeID; 
   public ApexPages.StandardController Info {get;set;}
   public TimeZone(){}
        
    public TimeZone(ApexPages.StandardController con) {
        posId = Apexpages.currentPage().getparameters().get('Id');
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        DescribeSObjectResult result = gd.get('TBatch__c').getDescribe();
        Map<String,Schema.RecordTypeInfo> recordTypeInfo = result.getRecordTypeInfosByName();
        Id rtId = RecordTypeInfo.get('batch.RecordType').getRecordTypeId();
        system.debug('RECORD TYPES:' + recordTypeInfo);
      
        //string recTypeID = Schema.SobjectType.TBatch__c.getRecordTypeInfosByName().getRecordTypeId();
        system.debug('posId: '+posId);
        Infolst= [SELECT Start_Date__c,End_Date__c,Start_Time__c,End_Time__c,Time_Zone__c from TBatch__c
                           where Name =: posId AND RecordTypeId =: rtId];
       system.debug(Infolst);
        getBatch();
    }
                 
 public void getBatch()
 { 
     for(TBatch__c batch:Infolst){               
        Time stime=batch.Start_Time__c;
        system.debug('start time(input)'+stime);
        Integer shour=stime.hour();
        Integer sminute=stime.minute();
        Integer ssecond=stime.second();
        String starttime=shour+':'+sminute;
       // system.debug('starttime(output)'+starttime);
             
        Time etime=batch.End_Time__c;
        system.debug('end time(input)'+etime);
        Integer ehour=etime.hour();
        Integer eminute=etime.minute();
        Integer esecond=etime.second();
        String endtime=ehour+':'+eminute;
        //system.debug('endtime(output)'+endtime); 
      
        Date sdate=batch.Start_Date__c;
        Integer syear=sdate.year();
        Integer smonth=sdate.month();
        Integer sday=sdate.day();
        String startdate=String.valueOf(sday+'/'+smonth+'/'+syear);
        system.debug('Start date(output)'+startdate);  
        //date mystartdate = date.parse(startdate);
        
         
        Date edate=batch.End_Date__c;
        Integer eyear=edate.year();
        Integer emonth=edate.month();
        Integer eday=edate.day();
        String enddate=String.valueOf(eday+'/'+emonth+'/'+eyear);
        system.debug('End date(output)'+edate); 
        system.debug('Time Zone'+batch.Time_Zone__c);
     
     if(batch.Time_Zone__c == 'EST'){
        StartDate=startdate;
        EndDate=enddate; 
        system.debug('StartDate'+StartDate);
        system.debug('EndDate'+EndDate);
       
        DateTime dt1=DateTime.newInstanceGmt(syear, smonth, sday, shour, sminute, ssecond);
        system.debug('DATETime'+dt1);
        String mytime = dt1.format('hh:mm a');
        system.debug('Mytime: '+mytime);
        String st1=dt1.format('MM/dd/yyyy hh:mm a zz', '(America/New_York');
        system.debug('st1'+st1);
        DateTime dt2=dateTime.valueOf(st1);
        system.debug('DATETime2'+dt2);
        Integer tshour=dt2.hour();
        Integer tsminute=dt2.minute();
        String starttime1=String.valueof(tshour+':'+tsminute);
        system.debug('StartTime EST'+startTime1); 
        StartTime=starttime1; 
        system.debug('StartTime EST'+StartTime); 
      
        DateTime dtz=DateTime.newInstanceGmt(syear, smonth, sday, ehour, eminute, esecond);
        String et=dtz.format('MM/dd/yyyy hh:mm a zz', '(America/New_York');
        DateTime dt3=dateTime.valueOf(et);
        Integer tehour=dt3.hour();
        Integer teminute=dt3.minute();
        String endtime1=String.valueof(tehour+':'+teminute);
         EndTime=endtime1;
        system.debug('EndTime EST'+EndTime); 
          
     }
     else{
        StartDate=startdate;
        EndDate=enddate; 
        DateTime dt1=DateTime.newInstanceGmt(syear, smonth, sday, shour, sminute, ssecond);
        String st1=dt1.format('MM/dd/yyyy hh:mm a zz', 'America/Chicago');
        DateTime dt2=dateTime.valueOf(st1);
        Integer tshour=dt2.hour();
        Integer tsminute=dt2.minute();
        String starttime1=String.valueof(tshour+':'+tsminute);
        StartTime=starttime1;  
      
        DateTime dtz=DateTime.newInstanceGmt(syear, smonth, sday, ehour, eminute, esecond);
        String et=dtz.format('MM/dd/yyyy hh:mm a zz', 'America/Chicago');
        DateTime dt3=dateTime.valueOf(et);
        Integer tehour=dt3.hour();
        Integer teminute=dt3.minute();
        String endtime1=String.valueof(tehour+':'+teminute);
        EndTime=endtime1; 
         
     }
   }   
 }
    
}