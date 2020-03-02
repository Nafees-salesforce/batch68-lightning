({
	doInit : function(cmp, event, helper) {
//		helper.handleDoInit(cmp,event);
    },
    NewStudentForm : function(cmp, event, helper) {
		helper.SaveStudentInfo(cmp,event);
        helper.SaveNewStudentInfo(cmp,event);
        
	},
    SearchStudent : function(cmp, event,helper) {
        var action = cmp.get("c.doSearch");
        action.setParams({
         searchemail :cmp.get("v.email")        
        });
         
        action.setCallback(this,function(response){

            var state = response.getState();
            alert(state);
            if(state === "SUCCESS") {
                alert(state);
                var res = response.getReturnValue();             
                console.log(res);               
                cmp.set("v.student",res);                
            }
            else {
                alert('Something went wrong...');
            }
        });
        $A.enqueueAction(action);
          
    },
    SaveStudentInfo:function(cmp, event, helper) {
        
        var cn=cmp.get("v.CourseName");
        var tn=cmp.get("v.TrainerName");
        var input={"CourseName":cn,
                   "TrainerName":tn
                  };
        var action = cmp.get("c.upsertResources");
        action.setParams({
            "records" : input
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state == 'SUCCESS') {
                var res = response.getReturnValue();
                console.log('after save: '+res);
                this.handleDoInit(cmp, event);
                
            }
        });
       $A.enqueueAction(action);
    },
     SaveNewStudentInfo:function(cmp, event, helper) {
        var newRecords=cmp.get("v.newStudent");
        var action = cmp.get("c.insertRecords");
        action.setParams({
            "newStudent" : newRecords
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state == 'SUCCESS') {
                var res = response.getReturnValue();
                console.log('after save: '+res);
                this.handleDoInit(cmp, event);
                
            }
        });
        $A.enqueueAction(action);
    }
})