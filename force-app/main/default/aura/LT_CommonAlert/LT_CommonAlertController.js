/**
 * Created by ms on 2017-09-26.
 */
({
    doClose : function(component, event, helper) {
        $A.util.toggleClass(component.find('modalContainer'), 'slds-hide');
        //-----------------------------------------------------------
        // 확인후 추가 Action이 존재할 경우 수행
        //-----------------------------------------------------------
        var action = component.get('v.action');
        if(action) {
           $A.enqueueAction(action);
        }
    },
})