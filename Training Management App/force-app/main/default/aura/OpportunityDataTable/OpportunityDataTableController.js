({
	doInit : function(cmp, event, helper) {
        helper.loadListofopp(cmp,event);
	},
    handleNameSearchChange : function(cmp, event, helper) {
        helper.loadListofoppwithsearch(cmp,event);
    }
})