({
    handleDoInit : function(cmp,event) {
        debugger;
        var action = cmp.get("c.getData");
        var recordId = cmp.get("v.recordId");
        if(recordId) recordId = '0062v00001M3zvKAAR';
        var inputMap = {
            'recordId' : '0062v00001M3zvKAAR'
        };
        action.setParams({
            inputMap : inputMap
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state === 'SUCCESS') {
                var res = response.getReturnValue();                
                var files = res.files;
                for(var i=0;i<files.length;i++) {
                    files[i]['Date'] = files[i].ContentDocument.ContentModifiedDate.toString().substring(0,10);
                    files[i]['ContentSize'] = Number(files[i].ContentDocument.ContentSize)/1024;
                }
                console.log('res.files: '+JSON.stringify(res.files));
                cmp.set("v.data",res.files);
            }
            else {
                alert('Something went wrong.');
            }
        });
        $A.enqueueAction(action);
    }
})