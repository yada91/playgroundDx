/**
 * Created by ms on 2017-09-12.
 */
({
    fn_search : function(component, event, helper) {
        var getInputkeyWord = component.get("v.SearchKeyWord");
        var condition = ''
        var params = {
            'searchKeyWord': getInputkeyWord,
            'sobjectName' : component.get("v.objectAPIName"),
            'optionQuery' : '',
            'condition' : component.get('v.condition'),
            'limitSize' : component.get('v.limitSize'),
        };
        var callbacks = {
            "SUCCESS" : function(response) {
                var LT_DATA = helper.gfn_parseServerData(response);
                var LT_ERROR = helper.gfn_parseServerBizError(response);
                helper.getLogger().log('▶▶▶ Biz Log : 업무단에서 SUCCESS callback 정의 호출 ◀◀◀');
                helper.getLogger().dir(LT_DATA);
                helper.getLogger().dir(LT_ERROR);
                helper.getLogger().log('▶▶▶ Biz Log : 업무단에서 SUCCESS callback 정의 호출 ◀◀◀');

                //=====================================================================
                // 업무별 Biz Error 처리
                //=====================================================================
                if(helper.gfn_isBizError(response)) {
                    var bizErrorMessage = helper.gfn_bizErrorMessage(response);
                    component.set("v.Message", bizErrorMessage);
                    component.set('v.listOfSearchRecords', null);
                }
                else {
                    component.set("v.Message", null);
                    component.set('v.listOfSearchRecords', LT_DATA);
                }
            }
        };
        //=====================================================================
        // Server Controller 거래 호출방식 2 : recommand
        //=====================================================================
        helper.gfn_scServiceN(component, event, helper, "c.getLookupValues", params, callbacks);
    },
	fn_getLookupDefaultValue : function(component, event, helper) {
		var hasNoDefaultValue = $A.util.isEmpty(component.get("v.sobjectLookupField"));
		
		console.log('hasNoDefaultValue : ' + hasNoDefaultValue);
		
		if(hasNoDefaultValue === true) return;
		
		var params = {
			'sobjectName' : component.get("v.objectAPIName"),
			'defaultValue' : component.get("v.sobjectLookupField")
		};
		var callbacks = {
			"SUCCESS" : function(response) {
				var LT_DATA = helper.gfn_parseServerData(response);
				var LT_ERROR = helper.gfn_parseServerBizError(response);
				helper.getLogger().log('▶▶▶ Biz Log : 업무단에서 SUCCESS callback 정의 호출 ◀◀◀');
				helper.getLogger().dir(LT_DATA);
				helper.getLogger().dir(LT_ERROR);
				helper.getLogger().log('▶▶▶ Biz Log : 업무단에서 SUCCESS callback 정의 호출 ◀◀◀');
				
				//=====================================================================
				// 업무별 Biz Error 처리
				//=====================================================================
				if(helper.gfn_isBizError(response)) {
					var bizErrorMessage = helper.gfn_bizErrorMessage(response);
					console.error('Server Error : ' + bizErrorMessage);
				}
				else {
					component.set('v.selectedRecord', LT_DATA);
				}
				
			}
		};
		helper.gfn_scServiceN(component, event, helper, "c.getLookupDefaultValue", params, callbacks);
	}
})