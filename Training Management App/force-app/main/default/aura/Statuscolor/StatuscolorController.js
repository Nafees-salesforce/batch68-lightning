({
	doInit : function(cmp, event, helper) {
		var action=cmp.get('c.getOpp');
         action.setParams({
         recordId: cmp.get('v.recordId')
        });
      action.setCallback(this,function(response){
             var state=response.getState();
        if(state === "SUCCESS"){
            var res=response.getReturnValue();
            cmp.set('v.lstofOpportunity',res);
        }
      });
      $A.enqueueAction(action);
	}
})