({
    
    loadListofopp : function(cmp,event){
      var action=cmp.get('c.getOpp');
      action.setCallback(this,function(response){
             var state=response.getState();
        if(state === "SUCCESS"){
            var res=response.getReturnValue();
            cmp.set('v.lstofOpportunity',res);
        }
      });
      $A.enqueueAction(action);
    },
	loadListofoppwithsearch : function(cmp,event) {
        
        var action=cmp.get('c.getOppwithsearch');
        var nameSearchString = cmp.find('nameSearch').get('v.value');
        action.setParams({
         nameSearchString: nameSearchString
        });
        action.setCallback(this,function(response){
             var state=response.getState();
            
        if(state === "SUCCESS"){
            var res=response.getReturnValue();
            cmp.set('v.lstofOpportunity',res);
        }
      });
      $A.enqueueAction(action);
	}
})