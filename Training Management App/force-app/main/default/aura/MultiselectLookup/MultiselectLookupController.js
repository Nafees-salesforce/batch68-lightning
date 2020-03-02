({
	selectRecord : function(cmp, event, helper){      
        var getSelectRecord = cmp.get("v.objRecord");
        // call the event   
        var compEvent = cmp.getEvent("selectedRecordsEvent");
        // set the Selected sObject Record to the event attribute.  
        compEvent.setParams({"recordByEvent" : getSelectRecord });  
        // fire the event  
        compEvent.fire();
    },
})