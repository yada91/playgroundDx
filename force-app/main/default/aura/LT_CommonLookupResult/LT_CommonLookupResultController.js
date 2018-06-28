/**
 * Created by ms on 2017-09-12.
 */
({
    fireSelectRecord : function(component, event, helper){
        // get the selected record from list
        var getSelectRecord = component.get("v.oRecord");
        // call the event
        var compEvent = component.getEvent("oSelectedRecordEvent");
        // set the Selected sObject Record to the event attribute.
        compEvent.setParams({"data" : getSelectRecord });
        // fire the event
        compEvent.fire();
    },
})