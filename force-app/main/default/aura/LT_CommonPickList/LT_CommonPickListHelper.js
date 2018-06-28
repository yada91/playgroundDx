/**
 * Created by i2max on 2017-09-19.
 */
({
    fn_getPicklistValues : function(component, event, helper) {
        var object = component.get('v.objectAPIName');
        var field = component.get('v.fieldAPIName');
        var hasDefault = component.get('v.hasDefault');
        var defaultValue = component.get('v.defaultValue');

        var params = {'object' : object, 
                      'field' : field,
                      'hasDefault':hasDefault,
                      'defaultValue':defaultValue};
        var callbacks = {
            "SUCCESS" : function(response) {
                var LT_DATA = helper.gfn_parseServerData(response);
                var LT_ERROR = helper.gfn_parseServerBizError(response);

                helper.getLogger().log('▶▶▶ Biz Log : 업무단에서 SUCCESS callback 정의 호출 ◀◀◀');
                helper.getLogger().dir(LT_DATA);
                helper.getLogger().dir(LT_ERROR);
                helper.getLogger().log('▶▶▶ Biz Log : 업무단에서 SUCCESS callback 정의 호출 ◀◀◀');

                console.log(LT_DATA);
                //=====================================================================
                // 업무별 Biz Error 처리
                //=====================================================================
                if(helper.gfn_isBizError(response)) {
                    var bizErrorMessage = helper.gfn_bizErrorMessage(response);
                    helper.gfnForceEventUtil.showToast(helper, { 
                       message: 'There was an error.'
                    });
                } 
                else {
                    component.set('v.pickList', LT_DATA);
                    component.set('v.sobjectPickListField', LT_DATA[0].value);
                }
            }
        }
        helper.gfn_scServiceN(component, event, helper, "c.getPicklistValues", params, callbacks);

    },

})