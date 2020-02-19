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
	},
	onExport : function(cmp, event) {
		cmp.set("v.showExcelPopup",true);
	},
	handleCmpEvent : function(cmp, event,helper) {
		var isRecentResults = event.getParam("isRecentResults");
		var isHistoryResults = event.getParam("isHistoryResults");
		console.log('isRecentResults===== '+isRecentResults);
		console.log('isHistoryResults===== '+isHistoryResults);
		debugger;
		var records = [];
		if(isRecentResults) {
			var results = cmp.get("v.results");
			if(results.length > 0) {
				records.push.apply(records, results);
			}
		}
		if(isHistoryResults) {
			var historyRows = cmp.get("v.historyRows");
			if(historyRows.length > 0) {
				records.push.apply(records, historyRows);
			}
		}

		if(records.length > 0) {
			var csv = helper.generateData(cmp, records, event);
			console.log('dataResult: '+csv);
			if (csv == null){return;} 
				
			// ####--code for create a temp. <a> html tag [link tag] for download the CSV file--####     
			var hiddenElement = document.createElement('a');
			hiddenElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csv);
			hiddenElement.target = '_self'; // 
			hiddenElement.download = 'ExportData.csv';  // CSV file Name* you can change it.[only name not .csv] 
			document.body.appendChild(hiddenElement); // Required for FireFox browser
			hiddenElement.click(); // using click() js function to download csv file
		}
}
})