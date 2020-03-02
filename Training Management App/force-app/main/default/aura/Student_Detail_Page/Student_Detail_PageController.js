({
   myAction : function(component, event, helper) {
        var action = component.get("c.getAllstudents");
        action.setCallback(this, function(response){
            var name = response.getState();
            if (name === "SUCCESS") {
                component.set("v.std", response.getReturnValue());
            }
        });
     $A.enqueueAction(action);
    }
})