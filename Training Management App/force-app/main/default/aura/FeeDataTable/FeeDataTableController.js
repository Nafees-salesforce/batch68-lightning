({
	init : function(cmp, event, helper) {
	  cmp.set('v.columns', [
            {label: 'Course Name', fieldName: 'Name', type: 'text'},
            {label: 'Amount', fieldName: 'Amount__c', type: 'currency'},
            
          ]);
      var action = cmp.get("c.getFee");
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state == 'SUCCESS') {
               var res = response.getReturnValue();
               cmp.set('v.data',res);
            }
          else{
           alert("Something went wrong");
          }
        });
        $A.enqueueAction(action);        
    	  
	}
})