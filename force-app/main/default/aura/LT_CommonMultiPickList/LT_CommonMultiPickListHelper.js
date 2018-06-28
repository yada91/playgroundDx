/**
 * Created by i2max on 2017-09-19.
 */
({
    fn_getPicklistValues : function(component, event, helper) {
            var object = component.get('v.objectAPIName');
            var field = component.get('v.fieldAPIName');
            var params = {'object' : object, 'field' : field};
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
                        var selectedValue = component.get('v.selectedValue');

                        // 기선택된 항목이 존재하는 경우
                        if(selectedValue !== 'none'){
                            var arr = {};
                            for(var i=0; i<LT_DATA.length; i++){
                                arr[LT_DATA[i].label] = LT_DATA[i];
                            }

                            // 항목에 없는 파라미터가 넘어오는 경우를 대비하여 따로 변수처리
                            var selectedArr = selectedValue.split(';');
                            var selectedStr = '';
                            for(var j=0; j<selectedArr.length; j++){
                                if(arr[selectedArr[j]]){
                                    arr[selectedArr[j]]['selected'] = 'true';
                                    selectedStr += arr[selectedArr[j]].label +';';
                                }
                            }

                            component.set('v.sobjectPickListField', selectedStr.substring(0,selectedStr.length-1));
                        }

                        component.find("multi").set("v.options", LT_DATA);

                    }
                }
            }
            helper.gfn_scServiceN(component, event, helper, "c.getMultiPicklistValues", params, callbacks);
        },
})