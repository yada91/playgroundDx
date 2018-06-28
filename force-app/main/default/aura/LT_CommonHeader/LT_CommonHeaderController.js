({ 
    doInit: function(component, event, helper) {
    	var cb = component.get('v.in_body');
    		
    	var ct = component.find('inner_content_body');
    	
    	if(cb) { $A.util.addClass(ct, "inner"); };
    } 
})