({
	onblur : function(cmp,event,helper){
        // on mouse leave clear the listSearchRecords & hide the search result component 
        cmp.set("v.listSearchRecords", null );
        cmp.set("v.SearchKeyWord", '');
        var forclose = cmp.find("searchRes");
        $A.util.addClass(forclose, 'slds-is-close');
        $A.util.removeClass(forclose, 'slds-is-open');
    },
    onfocus : function(cmp,event,helper){
        // show the spinner,show child search result component and call helper function
        $A.util.addClass(cmp.find("mySpinner"), "slds-show");
        cmp.set("v.listSearchRecords", null ); 
        var forOpen = cmp.find("searchRes");
        $A.util.addClass(forOpen, 'slds-is-open');
        $A.util.removeClass(forOpen, 'slds-is-close');
        var getInputkeyWord = '';
        helper.searchHelper(cmp,event,getInputkeyWord);
    },
    
    keyPressController : function(cmp, event, helper) {
        $A.util.addClass(cmp.find("mySpinner"), "slds-show");
        var getInputkeyWord = cmp.get("v.SearchKeyWord");
        if(getInputkeyWord.length > 0){
            var forOpen = cmp.find("searchRes");
            $A.util.addClass(forOpen, 'slds-is-open');
            $A.util.removeClass(forOpen, 'slds-is-close');
            helper.searchHelper(cmp,event,getInputkeyWord);
        }
        else{  
            cmp.set("v.listSearchRecords", null ); 
            var forclose = cmp.find("searchRes");
            $A.util.addClass(forclose, 'slds-is-close');
            $A.util.removeClass(forclose, 'slds-is-open');
        }
    },
    
    clear :function(cmp,event,heplper){
        var selectedPillId = event.getSource().get("v.name");
        var AllPillsList = component.get("v.listSelectedRecords"); 
        
        for(var i = 0; i < AllPillsList.length; i++){
            if(AllPillsList[i].Id == selectedPillId){
                AllPillsList.splice(i, 1);
                component.set("v.listSelectedRecords", AllPillsList);
            }  
        }
        cmp.set("v.SearchKeyWord",null);
        cmp.set("v.listSearchRecords", null );      
    },
    
    handleComponentEvent : function(cmp, event, helper) {
        cmp.set("v.SearchKeyWord",null);
        var listSelectedItems =  cmp.get("v.listSelectedRecords");
        var selectedAccountFromEvent = event.getParam("recordByEvent");
        listSelectedItems.push(selectedAccountFromEvent);
        cmp.set("v.listSelectedRecords" , listSelectedItems); 
        
        var forclose = cmp.find("lookup-pill");
        $A.util.addClass(forclose, 'slds-show');
        $A.util.removeClass(forclose, 'slds-hide');
        
        var forclose = cmp.find("searchRes");
        $A.util.addClass(forclose, 'slds-is-close');
        $A.util.removeClass(forclose, 'slds-is-open'); 
    },
})