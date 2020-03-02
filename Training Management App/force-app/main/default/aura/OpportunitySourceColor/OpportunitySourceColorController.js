({
	doInit : function(cmp, event, helper) {
		var Name=cmp.get("v.oppSource");
        
        if(Name!= undefined){
            //write picklist value to lower case
            var tempLowerCase = Name.toLowerCase();
            var Red="closed won";
            var Yellow="closed lost";
            var Green="qualification";
            var Orange="negotiation/review";
            //set the color based on picklist values
            if (Red.indexOf(tempLowerCase) != -1) {
               cmp.set("v.color", 'red');
            } 
            else if (Yellow.indexOf(tempLowerCase) != -1) {
               cmp.set("v.color", 'Yellow');
            } 
            else if (Green.indexOf(tempLowerCase) != -1) {
               cmp.set("v.color", 'green');
            }
            else if (Orange.indexOf(tempLowerCase) != -1) {
               cmp.set("v.color", 'orange');
            }
        }
	}
})