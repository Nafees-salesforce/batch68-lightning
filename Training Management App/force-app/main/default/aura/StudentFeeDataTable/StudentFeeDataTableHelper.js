({
	handleDoInit : function(cmp,event) {
		var action = cmp.get("c.fetchData");
        var inputMap = {
            "recordId": cmp.get("v.recordId")
        };
        action.setParams({
            inputMap:inputMap //inputMap should not be enclosed in double quotes
        });        
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === "SUCCESS") {
                var res = response.getReturnValue();
                var records = res.records;
                if(records.length == 0) {
                    records.push({'Email__c':'','Mobile__c':'','Amount__c':'','Information__c':cmp.get("v.recordId")});
                }
                cmp.set("v.records",records);
               // cmp.set("v.resourcPickVals",res.resourcPickVals);
            }
            else {
                alert('Something went wrong...');
            }
        });
        $A.enqueueAction(action);
	},
    handleSubmit : function(cmp, event) {
        cmp.set("v.isSpinner",true);
        var action = cmp.get("c.upsertResources");
        var records = cmp.get("v.records");
        console.log(JSON.stringify(records));
        action.setParams({
            "records" : records,
        });
        action.setCallback(this,function(response){
            cmp.set("v.isSpinner",false);
            debugger;
            var state = response.getState();
            if(state == 'SUCCESS') {
                var res = response.getReturnValue();
                console.log('after save: '+res);
                this.handleDoInit(cmp, event);
            }
        });
        //To call the server method (Asynchronous)
        $A.enqueueAction(action);
    }
})