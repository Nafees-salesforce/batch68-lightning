({
	init : function(cmp, event, helper) {
       
	  cmp.set('v.columns', [
            {label: 'batch', fieldName: 'Batch__c', type: 'text'},
            {label: 'Course Name', fieldName: 'Fee__r.Name', type: 'text'},
            {label: 'Amount', fieldName: 'Fee__r.Amount__c', type: 'text'},
         ]);
     
    
        var action = cmp.get("c.getFee");
        action.setParams({"recId":component.get("v.recordId")});    
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state == 'SUCCESS') {
               var rows = response.getReturnValue();
                for (var i = 0; i < rows.length; i++) {
                    var row = rows[i];
                    // checking if any Fee related data in row
                  /*  if(row.Student){
                        row.StudentsName=row.Student.Name;
                    }*/
                    if (row.Fee) {
                        row.CourseName = row.Fee.Name;
                        row.Amount = row.Fee.Amount;
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