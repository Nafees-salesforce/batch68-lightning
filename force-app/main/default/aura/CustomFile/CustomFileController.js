({
    handleUploadFinished: function (cmp, event, helper) {
        // This will contain the List of File uploaded data and status
        var uploadedFiles = event.getParam("files");
        debugger;
        var documentId = uploadedFiles[0].documentId;
        var fileName = uploadedFiles[0].name;
        console.log('documentId: '+documentId);
        console.log('fileName: '+fileName);
        console.log("Files uploaded : " + uploadedFiles.length);

        var action = cmp.get("c.updateOpp");
        //select id, Description, Title, (Select Id, Title, VersionNumber, Description, IsLatest from ContentVersions) 
        //from ContentDocument where id = '0692v00000EDFHLAA5'

        var fileIds = '';
        for(var i = 0; i<uploadedFiles.length;i++) {
            if(fileIds) {
                fileIds += ','+uploadedFiles[i].documentId;
            }
            else {
                fileIds = uploadedFiles[i].documentId;
            }
        }
        var inputMap = {
            "recordId" : cmp.get("v.recordId"),
            "description" : cmp.get("v.description"),
            "fileString" : fileIds,
            "category" : cmp.get("v.category")
        };

        action.setParams({
            inputMap : inputMap
        });

        action.setCallback(this,function(response){
            
            var state = response.getState();
            if(state === 'SUCCESS') {
                var fileUploadEvent = $A.get("e.c:fileUploadEvent");
                // Optional: set some data for the event (also known as event shape)
                // A parameter’s name must match the name attribute
                // of one of the event’s <aura:attribute> tags
                //fileUploadEvent.setParams({ "myParam" : myValue });
                fileUploadEvent.fire();
                debugger;
                var res = response.getReturnValue();
                if(res.isSuccess && res.isContentSuccess) {
                    helper.showToast(cmp, event,'Success!!!',res.message);
                }
                else {
                    var finalMsg = '';
                    if(res.message)
                        finalMsg = res.message;
                    if(res.contentMessage)
                        finalMsg += ' '+res.contentMessage
                    helper.showToast(cmp, event,'Error',res.message);                    
                }                
            }
            else {
                alert('Something went wrong.');
            }
        });

        $A.enqueueAction(action);
    },    
    onDescription: function (cmp, event) {
        var description = cmp.get("v.description");
        if(description) {
            cmp.set("v.disabled",false);
        }
        else {
            cmp.set("v.disabled",true);
        }
    }
})