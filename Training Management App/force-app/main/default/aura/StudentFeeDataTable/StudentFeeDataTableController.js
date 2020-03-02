({
	doInit : function(cmp, event, helper) {
		helper.handleDoInit(cmp,event);
	},
    add : function(cmp, event, helper) {
		var records = cmp.get("v.records");
        records.push({'Email__c':'','Mobile__c':'','Amount__c': '','Information__c':cmp.get("v.recordId")});
        cmp.set("v.records",records);
	},
    delete : function(cmp, event, helper) {
    	cmp.set("v.isSpinner",true);
        if(event.target) {
            var elmtId = event.target.id;
            console.log(elmtId);
    		var ids = elmtId.split(":");
    		var records = cmp.get("v.records");
            records.splice(ids[0],1);
            cmp.set("v.records",records);
    
    		//Deleting form server
            if(ids.length > 1 && ids[1]) {
    			var recId = ids[1];
            	console.log(recId);
    			var action = cmp.get("c.deleteRec");
                action.setParams({
    				recId : recId
            	});
                action.setCallback(this,function(response){
                    cmp.set("v.isSpinner",false);
                    var state = response.getState();
                    if(state === 'SUCCESS') {
                        console.log(response.getReturnValue());
                    }
                });
    			$A.enqueueAction(action);
        	}
            else {
                cmp.set("v.isSpinner",false);
            }
        }
    },
 	submit: function(cmp, event, helper) {
        helper.handleSubmit(cmp, event)
    }
})