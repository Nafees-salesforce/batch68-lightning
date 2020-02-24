({
    handleDoInit : function(cmp,event) {
        var action = cmp.get("c.getData");
        var inputMap = {
            'recordId' : '0062v00001M3zvKAAR'
        };//cmp.get("v.recordId")
        action.setParams({
            inputMap : inputMap
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === 'SUCCESS') {
                var res = response.getReturnValue();
                cmp.set("v.data",res.files);
            }
            else {
                alert('Something went wrong.');
            }
        });
        $A.enqueueAction(action);
    }
})
