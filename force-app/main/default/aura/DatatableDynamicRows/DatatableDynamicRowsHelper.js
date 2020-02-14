({
    handleRemove : function(cmp,event) {
		var btnLabel = event.getSource().get("v.label");
		var resultArray = cmp.get("v.results");
		if(btnLabel === 'Remove Row from Last') {			
			resultArray.pop();
		}
		else if(btnLabel === 'Remove Row from First') {
			resultArray.shift();			
		}
		cmp.set("v.results",resultArray);
    },
    handleOnClose: function(cmp,event) {

		cmp.set("v.show",true);
		var selIcnVal = event.getSource().get("v.alternativeText");

		var spStr = selIcnVal.split(":");
		console.log('spStr: '+spStr);
		var index = spStr[0];

		var recId = spStr[1];

		if(!recId) {
			console.log('recId: '+recId);

			var results = cmp.get("v.results");
			results.splice(Number(index),1);

			cmp.set("v.results",results);
		}
		else {
			if(confirm('Are you sure?')) {
				var action = cmp.get("c.deleteRec");

				var inputMap = {
					'recId' : recId
				};

				action.setParams({
					inputMap : inputMap
				});

				action.setCallback(this,function(response) {
					var state = response.getState();
					if(state === 'SUCCESS') {
						var results = cmp.get("v.results");
						results.splice(Number(index),1);

						cmp.set("v.results",results);
						
						var res = response.getReturnValue();
						cmp.set("v.message",res.message);
						cmp.set("v.severity",res.severity);
					}
					else {
						alert('Something went wrong!!!');
					}
				});

				$A.enqueueAction(action);
			}
		}
	},
})
