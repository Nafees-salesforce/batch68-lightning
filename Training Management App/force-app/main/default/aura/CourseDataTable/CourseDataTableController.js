({
      init : function(cmp, event, helper) {
      cmp.set('v.columns', [
              {label: 'Id', fieldName: 'Name', type: 'text'},
              {label: 'Student Name', fieldName: 'Student__r.Name', type: 'text'},
              {label: 'Course Name', fieldName: 'Course__r.CourseName__c', type: 'text'},
              {label: 'Sub Course', fieldName: 'Course__r.SubCourse__c', type: 'text'},
       
            ]);
        var action = cmp.get("c.getCourse");
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state == 'SUCCESS') {
             var rows = response.getReturnValue();
              alert(rows);
              alert(state);
             for (var i = 0; i < rows.length; i++) {
                    var row = rows[i];
                    alert(row);
                    // checking if any Course related data in row
                    if (row.Student) {
                        row.StudentsName = row.Student.Name;
                    alert(row.Name);
                    }
                 /*   if (row.Course) {
                        row.Courses = row.Course.Course;
                        row.SubCourse = row.Course.SubCourse;
                    }*/
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