({
	init : function(cmp, event, helper) {
	/*  cmp.set('v.columns', [
            {label: 'Id', fieldName: 'Name', type: 'text'}, 
            {label: 'First Name', fieldName: 'Student__r.First_Name__c', type: 'text'},
            {label: 'Last Name', fieldName: 'Student__r.Last_Name__c', type: 'text'},
            {label: 'Email', fieldName: 'Student__r.Email__c', type: 'email'},
            {label: 'Mobile', fieldName: 'Student__r.Mobile__c', type: 'phone'},
            {label: 'City', fieldName: 'Student__r.City__c', type: 'text'},
            {label: 'Country', fieldName: 'Student__r.Country__c', type: 'text'}, 
        ]);  
    */
        cmp.set('v.columns', [
            {label: 'Id', fieldName: 'Name', type: 'text'}, 
            {label: 'First Name', fieldName: 'First_Name__c', type: 'text'},
            {label: 'Last Name', fieldName: 'Last_Name__c', type: 'text'},
            {label: 'Email', fieldName: 'Email__c', type: 'email'},
            {label: 'Mobile', fieldName: 'Mobile__c', type: 'phone'},
            {label: 'City', fieldName: 'City__c', type: 'text'},
            {label: 'Country', fieldName: 'Country__c', type: 'text'}, 
        ]);    
        var action = cmp.get("c.getStudent");
         action.setParams({"recId":component.get("v.recordId")});   
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state == 'SUCCESS') {
               var rows = response.getReturnValue();
               alert(state);
               alert(rows);
               for (var i = 0; i < rows.length; i++) {
                    var row = rows[i];
                    // checking if any Student related data in row
                    if (row.Student) {
                        row.FirstName = row.Student.FirstName;
                        alert(row.FirstName);
                        row.LastName = row.Student.LastName;
                        row.Email = row.Student.Email;
                        row.Mobile = row.Student.Mobile;
                        row.City = row.Student.City;
                        row.Country = row.Student.Country;
                  }   
                }
               cmp.set('v.data',rows);
            }
          else{
           alert("Something went wrong");
          }
        });
        $A.enqueueAction(action);        
    	
	}
})