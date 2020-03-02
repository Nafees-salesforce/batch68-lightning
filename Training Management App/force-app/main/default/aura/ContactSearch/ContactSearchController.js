({
	doSearch : function(component, event, helper) {
		var componentEvent= component.getEvent('ContactEvent');
        var searchParam =component.find(searchInput).get('v.value');
        componentEvent.setParams({
            searchParam:searchParam
        });
        componentEvent.fire();
	}

})