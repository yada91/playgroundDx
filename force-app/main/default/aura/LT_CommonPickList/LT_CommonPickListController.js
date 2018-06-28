/**
 * Created by i2max on 2017-09-19.
 */
({
    doInit : function(component, event, helper) {
        helper.fn_getPicklistValues(component, event, helper);
    },

    doChange : function(component, event, helper) {
	     
	    var selectedValue = component.get("v.selectedValue");
	    component.set('v.sobjectPickListField', selectedValue);

	    var action = component.get('v.change');
	    if(action) {
	        $A.enqueueAction(action);
        }
    },
})