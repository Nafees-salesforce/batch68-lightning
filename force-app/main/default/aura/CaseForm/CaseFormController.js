({

    handleLoad: function(cmp, event, helper) {
        cmp.set('v.showSpinner', false);
    },

    handleSubmit: function(cmp, event, helper) {
        debugger;
        cmp.set('v.disabled', true);
        cmp.set('v.showSpinner', true);
        event.preventDefault();       // stop the form from submitting
        var fields = event.getParam('fields');        
        //fields.AccountId = cmp.get("v.recordId");
        //As the above field is not on the UI we cannot use as above
        fields['AccountId'] = cmp.get("v.recordId");
        cmp.find('myRecordForm').submit(fields);        
    },

    handleError: function(cmp, event, helper) {
        // errors are handled by lightning:inputField and lightning:messages
        // so this just hides the spinner
        cmp.set('v.showSpinner', false);
    },

    handleSuccess: function(cmp, event, helper) {
        var params = event.getParams();
        cmp.set('v.recordId', params.response.id);
        cmp.set('v.showSpinner', false);
        cmp.set('v.saved', true);
    }
});