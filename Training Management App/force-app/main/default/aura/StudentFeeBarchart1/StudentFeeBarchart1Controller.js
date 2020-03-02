({
	ctr : function(cmp, event, helper) {
        var temp = [];
        var action=cmp.get("c.getBarChart");
        var recId= cmp.get("v.recordId");
        console.log(recId);
        action.setParams({
            recId : recId
        });
        action.setCallback(this,function(response){
            var state= response.getState();
            if(state==='SUCCESS'&& response.getReturnValue()){
              var temp= response.getReturnValue();
              helper.createBarChart(cmp, temp);  
            }
        });
	 $A.enqueueAction(action);		 
    }
})