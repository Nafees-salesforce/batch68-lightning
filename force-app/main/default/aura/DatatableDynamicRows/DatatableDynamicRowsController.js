({
    remove : function(cmp, event, helper) {	
		helper.handleRemove(cmp, event);
    },
    onClose :  function(cmp, event, helper) {	
      helper.handleOnClose(cmp, event);
    },
    handleRecordUpdated: function(cmp, event, helper) {      
      debugger;      
      var isRepeated = cmp.get("v.isRepeated");
      if(!isRepeated) {
        cmp.set("v.isRepeated",true);
        if(confirm('Are you sure?')) {
            //Using Lightning Data Services to avoid writing server logic
            cmp.find("recordHandler").deleteRecord($A.getCallback(function(deleteResult) {
              // NOTE: If you want a specific behavior(an action or UI behavior) when this action is successful 
              // then handle that in a callback (generic logic when record is changed should be handled in recordUpdated event handler)
              if (deleteResult.state === "SUCCESS" || deleteResult.state === "DRAFT") {
                // record is deleted
                console.log("Record is deleted.");
                var results = cmp.get("v.results");
                results.splice(Number(cmp.get("v.currentIndex")),1);

                cmp.set("v.results",results);
                
                /*var res = response.getReturnValue();
                cmp.set("v.message",res.message);
                cmp.set("v.severity",res.severity);*/
              } else if (deleteResult.state === "INCOMPLETE") {
                console.log("User is offline, device doesn't support drafts.");
              } else if (deleteResult.state === "ERROR") {
                console.log('Problem deleting record, error: ' + JSON.stringify(deleteResult.error));
              } else {
                console.log('Unknown problem, state: ' + deleteResult.state + ', error: ' + JSON.stringify(deleteResult.error));
              }
            }));
          }
        }
   }
})