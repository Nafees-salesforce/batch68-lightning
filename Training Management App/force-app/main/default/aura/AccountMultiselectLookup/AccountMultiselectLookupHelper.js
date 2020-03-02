({
	 searchHelper : function(cmp,event,getInputkeyWord) {
         debugger;
        var action = cmp.get("c.getLookUpValues");
        action.setParams({
            'searchName': getInputkeyWord,
            'ObjName' : cmp.get("v.objectAPIName"),
            'ExcludeitemsList' : cmp.get("v.listSelectedRecords")
        });
          
        action.setCallback(this, function(response) {
            $A.util.removeClass(cmp.find("mySpinner"), "slds-show");
            var state = response.getState();
            if (state === "SUCCESS") {
                var res = response.getReturnValue();
                console.log(res);
                if (res.length == 0) {
                    cmp.set("v.Message", 'No Records Found...');
                }
                else {
                    cmp.set("v.Message", '');
                }
                cmp.set("v.listSearchRecords", res); 
            }
        });
          $A.enqueueAction(action);
    },
})