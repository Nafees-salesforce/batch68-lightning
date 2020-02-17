({
    onClose : function(cmp, event, helper) {
        cmp.set("v.showExcelPopup",false);
    },
    handleChange : function(cmp, event, helper) {
        var selVals = event.getParam('value');
        if(selVals.includes('recentResults')) {
            cmp.set("v.isRecentResults",true);
        }
        else {
            cmp.set("v.isRecentResults",false);
        }

        if(selVals.includes('history')) {
            cmp.set("v.isHistoryResults",true);
        }
        else {
            cmp.set("v.isHistoryResults",false);
        }
    },
    onExport : function(cmp, event, helper) {
        console.log('recent: '+cmp.get("v.isRecentResults"));
        console.log('history: '+cmp.get("v.isHistoryResults"));
    }
})
