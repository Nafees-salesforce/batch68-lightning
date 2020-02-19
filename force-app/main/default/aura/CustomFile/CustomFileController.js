({
    handleUploadFinished: function (cmp, event) {
        // This will contain the List of File uploaded data and status
        var uploadedFiles = event.getParam("files");
        alert("Files uploaded : " + uploadedFiles.length);
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
