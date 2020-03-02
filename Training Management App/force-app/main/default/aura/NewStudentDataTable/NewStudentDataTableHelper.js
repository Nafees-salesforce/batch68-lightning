({
    handleDoInit : function(cmp,event) {
         
		var action = cmp.get("c.fetchData");
        var inputMap = {
            "email": cmp.get("v.newStudent.email")
        };
        
        action.setParams({
            inputMap:inputMap //inputMap should not be enclosed in double quotes
        });        
        action.setCallback(this,function(response){

            var state = response.getState();
            if(state === "SUCCESS") {
                var res = response.getReturnValue();             
                cmp.set("v.studentName",res.studentName);     
            }
            else {
                alert('Something went wrong...');
            }
        });
        $A.enqueueAction(action);
    },  
	   
})