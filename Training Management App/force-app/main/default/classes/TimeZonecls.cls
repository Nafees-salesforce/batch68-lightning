public class TimeZonecls {
   public List<TBatch__c> Infolst {get;set;} 
   public string posId;
    public TimeZonecls() {
        posId = Apexpages.currentPage().getparameters().get('Id');
        system.debug('posId: '+posId);
    }
    public ApexPages.StandardSetController Info {
      get{
          if(Info==null){
              system.debug('posId: '+posId);
              Info=new ApexPages.StandardSetController([SELECT Start_Date__c,End_Date__c,Start_Time__c,End_Time__c,Time_Zone__c 
                                                        from TBatch__c where RecordTypeId =: posId]); 
            }
          return Info;
        }
       set;
      }  
 public list<TBatch__c> getBatch()
 { 
   TBatch__c batch=new TBatch__c();
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
       
     
     if(batch.Time_Zone__c == 'EST'){

        DateTime dt1=DateTime.newInstanceGmt(syear, smonth, sday, shour, sminute, ssecond);
        String st1=dt1.format('MM/dd/yyyy hh:mm a zz', 'America/Chicago');
        DateTime dt2=dateTime.valueOf(st1);
        Integer tshour=dt2.hour();
        Integer tsminute=dt2.minute();
        String starttime1=String.valueof(tshour+':'+tsminute);
      
        DateTime dtz=DateTime.newInstanceGmt(syear, smonth, sday, ehour, eminute, esecond);
        String et=dtz.format('MM/dd/yyyy hh:mm a zz', 'America/Chicago');
        DateTime dt3=dateTime.valueOf(et);
        Integer tehour=dt3.hour();
        Integer teminute=dt3.minute();
        String endtime1=String.valueof(tehour+':'+teminute);
        
        system.debug(st1);
        //Date sdt = Date.newInstance(2019, 02, 10, 12, 0, 0);        
      
     }
     else{
        DateTime dt1=DateTime.newInstanceGmt(syear, smonth, sday, shour, sminute, ssecond);
        String st1=dt1.format('MM/dd/yyyy hh:mm a zz', 'America/New_York');
        DateTime dt2=dateTime.valueOf(st1);
        Integer tshour=dt2.hour();
        Integer tsminute=dt2.minute();
        String starttime1=String.valueof(tshour+':'+tsminute);
      
        DateTime dtz=DateTime.newInstanceGmt(syear, smonth, sday, ehour, eminute, esecond);
        String et=dtz.format('MM/dd/yyyy hh:mm a zz', 'America/New_York');
        DateTime dt3=dateTime.valueOf(et);
        Integer tehour=dt3.hour();
        Integer teminute=dt3.minute();
        String endtime1=String.valueof(tehour+':'+teminute);
         
     }
  return (list<TBatch__c>) Info.getRecords();
    
 }

    
}