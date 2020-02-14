({
	doInit : function(cmp, event, helper) {		
		helper.handleDoInit(cmp, event);
	},			
	onSave : function(cmp, event, helper) {	
		helper.handleOnSave(cmp, event);
	},
	onClear : function(cmp, event, helper) {	
		helper.handleOnClear(cmp, event);
	},
	onHistory : function(cmp, event, helper) {	
		helper.handleOnHistory(cmp, event);
	}
})