/**
 * Created by i2max on 2017-09-19.
 */
({
    doInit : function(component, event, helper) {
        helper.fn_getPicklistValues(component, event, helper);
    },

    onSelectChange : function(component, event, helper) {
        var action = component.get('v.change');
        if(action) {
            action.setParam({});
            $A.enqueueAction(action);
        }

        // 1안
        var selected = component.find("multi").get("v.value");
        component.set('v.sobjectPickListField', selected);


        // 2안
        /*
        var evt = event.currentTarget;
        var selected = [];
        for(var i=0; i<evt.selectedOptions.length; i++){
            selected.push(evt.selectedOptions[i].value);
        }

        var result = selected.join(';');
        component.set('v.sobjectPickListField', result);
        */
    },

})