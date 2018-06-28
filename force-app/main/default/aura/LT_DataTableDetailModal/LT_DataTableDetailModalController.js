({
    destroyModal: function (component, event, helper) {
        component.destroy();
    },
    doSave: function (component, event, helper) {
        component.find("edit").get("e.recordSave").fire();
    },
    handleSaveSuccess: function (component, event, helper) {
        var compEvent = component.getEvent("fetchEvent");
        compEvent.fire();
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "mode": 'fetch',
            "message": component.get('v.sobjName') + ' "' + component.get('v.name') + '" was saved.',
            "type": 'success'
        });
        toastEvent.fire();
    }
})