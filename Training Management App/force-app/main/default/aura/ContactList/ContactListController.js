({
	doInit : function(component, event, helper) {
		
        var action= component.get('c.getContactList');
        action.setCallback(this,function(response){
                               var state = response.getState();
                               if(state==='SUCCESS')
                               {
                               var responsevalue=response.getReturnValue();
                               console.log('responseValue', responsevalue);
                               component.set('v.Contactlst', responsevalue);
                               }
        });
        $A.enqueueAction(action,false);
	},
    
    handlecompEvent: function(component, event, helper) {
        
        var searchParam= event.getParam('searchParam');
        var action =component.get('c.searchContact');
        action.setParams({
            
            searchParam :searchParam
                });
        
         action.setCallback(this,function(response)
                           {
                               var state = response.getState();
                               if(state==='SUCCESS')
                               {
                                   alert(state);
                               var responsevalue=response.getReturnValue();
                               console.log('responseValue', responsevalue);
                               cmp.set('v.Contactlst',responsevalue);
                               }
                               else
                               {
                                   console.log(response.getError);
                               }
        
                           });
        
        
        $A.enqueueAction(action);
    }
    

})