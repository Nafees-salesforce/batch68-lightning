({
	handleDoInit : function(cmp, event) {
		debugger;
		var operatorMap = {
			"Add" : "+",
			"Substract" : "-",
			"Multiply" : "*",
			"Divide" : "/",
		};
		//To capture the event information for the standard components 
		var btnLabel = event.getSource().get("v.label");

		if(!operatorMap[btnLabel] ) {
			result = Number(num1) + Number(num2);
		}
		else {
			if(!cmp.find("num1").get("v.validity").valid) {
				cmp.find("num1").showHelpMessageIfInvalid();
			}
			else if(!cmp.find("num2").get("v.validity").valid) {
				cmp.find("num2").showHelpMessageIfInvalid();
			}
			else {
				this.jsBasics(cmp, event);
				debugger;
				//To get the value of the attribute 
				var num1 = cmp.get("v.num1");
				var num2 = cmp.get("v.num2");

				var result;		
				console.log('***event**'+btnLabel);		

				var resultsArray = cmp.get("v.results");	

				if(btnLabel === 'Substract') {
					result = Number(num1) - Number(num2);			
				}
				else if(btnLabel === 'Multiply') {
					result = Number(num1) * Number(num2);			
				}
				else if(btnLabel === 'Divide') {
					result = Number(num1) / Number(num2);			
				}
				else if(btnLabel === 'Add') {
					result = Number(num1) + Number(num2);			
				}		
				if(operatorMap[btnLabel]) {
					var order = cmp.get("v.selOrder");
					if(order === 'first') {
						resultsArray.unshift(
							{
							"Number_1__c":Number(num1),
							"Operator__c":operatorMap[btnLabel],
							"Number_2__c":Number(num2),
							"Result__c":result
							}
						)
					}
					else {
						resultsArray.push(
							{
							"Number_1__c":Number(num1),
							"Operator__c":operatorMap[btnLabel],
							"Number_2__c":Number(num2),
							"Result__c":result
							}
						)
					}
				}

				//To set the value to an attribute
				console.log('resultsArray: '+JSON.stringify(resultsArray));
				cmp.set("v.result",result);	
				if(resultsArray && resultsArray.length > 0)
					cmp.set("v.results",resultsArray);
			}
		}
	},	
	handleOnSave: function(cmp, event) {
		//Calling a server method 
		var action = cmp.get("c.save");

		console.log(JSON.stringify(	cmp.get("v.results")));

		var inputMap = {
			"results" : JSON.stringify(cmp.get("v.results"))
		};
		console.log('inputMap: '+JSON.stringify(inputMap));
		//To set the parameters for the method.
		action.setParams({
			inputMap : inputMap
		});
		cmp.set("v.showSpinner",true);
		action.setCallback(this,function(response){
			cmp.set("v.showSpinner",false);
			var state = response.getState();
			if(state === 'SUCCESS') {
				var res = response.getReturnValue();
				if(res.isSuccess) {
					cmp.set("v.severity","success");
					cmp.set("v.message","Records have been saved successfully.");
				}
				else {
					cmp.set("v.severity","error");
					cmp.set("v.message",res.message);
				}
			}
			else {
				console.log('Something went wrong.');
				cmp.set("v.severity","error");
				cmp.set("v.message","Something went wrong.");
			}
		});

		//To call the method (Which call asynchronoulsy)
		$A.enqueueAction(action);
	},
	handleOnClear : function(cmp,event) {
		cmp.set("v.results",[]);
	},
	handleOnHistory : function(cmp,event) {
		
		var action = cmp.get("c.getHistory");

		var inputMap = {};
		action.setParams({
			inputMap : inputMap
		});
		cmp.set("v.showSpinner",true);
		action.setCallback(this,function(response) {
			cmp.set("v.showSpinner",false);
			var state = response.getState();
			if(state === "SUCCESS") {
				var res = response.getReturnValue();
				console.log('res: '+JSON.stringify(res));
				cmp.set("v.historyRows",res.rows);
			}
			else {
				alert("Something Wrong!!!");
			}
		});

		$A.enqueueAction(action);
	},
	jsBasics : function(cmp,event) {
		/* javaScript Basics *

		var myArray = [10,20,30,40,50];

		//Adding a value to the array at last position
		myArray.push(500);
		console.log('*push: '+myArray);

		//Adding a value to the array at first position
		myArray.unshift(100);
		console.log('*unshift: '+myArray);

		//removing a value at the end of the array
		myArray.pop();
		console.log('*pop: '+myArray);

		//removing a value at the starting of the array
		myArray.shift();
		console.log('*shift: '+myArray);

		//removing a value at particular position
		myArray.splice(2,1);
		console.log('*splice remove: '+myArray);

		//adding values at a particular position
		myArray.splice(2,0,100,200,300);
		console.log('*splice add: '+myArray);

		//Object -
		var myObj = {"FirstName" : "Ram","LastName" : "Laxman","City" : "Bangalore"};
		
		//"FirstName" : "Ram" --> Property
		//"FirstName" --> name
		//"Ram" --> value

		//Add a value to the map
		myObj["Country"] = "India";

		//Value based on the key
		console.log('value based on the key: '+myObj["LastName"]);

		console.log('map: '+JSON.stringify(myObj));

		//index based for loop
		for(var i=0;i<myArray.length;i++) {
			console.log(myArray[i]);
		}

		//for in --> it gives the index of the array
		for(var i in myArray) {
			console.log(i);
		}

		console.log('**map iteration key starts');
		for(var i in myObj) {
			console.log(i);
		}
		console.log('**map iteration key ends');

		//for of --> it give the value of the array
		for(var i of myArray) {
			console.log(i);
		}
		console.log('**map iteration value starts');
		for(var i in myObj) {
			console.log(myObj[i]);
		}
		console.log('**map iteration value ends');

		var temp1 = 123;
		var temp2 = '123';

		console.log(temp1 == temp2); //true
		console.log(temp1 === temp2); //false

		************************/
	}
})