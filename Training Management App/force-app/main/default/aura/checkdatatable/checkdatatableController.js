({
	init : function(cmp, event, helper) {
		 cmp.set('v.columns', [
            {label: 'Opportunity name', fieldName: 'Name', type: 'text'},
            {label: 'Close date', fieldName: 'CloseDate', type: 'date'},
            {label: 'Amount', fieldName: 'Amount', type: 'currency', typeAttributes: { currencyCode: 'EUR', maximumSignificantDigits: 5}},
            {label: 'Stage', fieldName: 'StageName', type: 'text'},
        ]);

        var action = cmp.get("c.getOpportunities");
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state == 'SUCCESS') {
                var res = response.getReturnValue();
                cmp.set('v.data',res);
            }
        });
        $A.enqueueAction(action);        
    }
	
})