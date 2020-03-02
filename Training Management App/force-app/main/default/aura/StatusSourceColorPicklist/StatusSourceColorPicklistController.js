({
	doInit : function(cmp, event, helper) {   
                var Name=cmp.get("v.Selectedvalue");  
            if(Name!= undefined){
            //write picklist value to lower case
            var tempLowerCase = Name.toLowerCase();
            var Red="red";
            var Yellow="yellow";
            var Green="green";
            
            //set the color based on picklist values
            if (Red.indexOf(tempLowerCase) != -1) {
               cmp.set("v.Color", 'red');
            } 
            else if (Yellow.indexOf(tempLowerCase) != -1) {
               cmp.set("v.Color", 'Yellow');
            } 
            else if (Green.indexOf(tempLowerCase) != -1)  {
               cmp.set("v.Color", 'green');
            }
            
        }
	}
})