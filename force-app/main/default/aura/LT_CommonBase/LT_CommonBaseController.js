/**
  * ===============================================================
  * File Name   : LT_CommonBaseController.js
  * Description : FrameWork 공통 controller javascript
				: 공통업무의 event handling controller
				: 기본적으로 object 안에서는 function만 설정가능, 변수설정 불가
  * Author      : i2max
  * Modification Log
  * ===============================================================
  * Ver  Date          Author         Modification
  * ===============================================================
  * 1.0  2016. 07. 01  i2max        Create
  * ===============================================================
*/
({
	/**
	 * <pre>
	 * 초기 거래 : 필요시 정의하여 사용
	 * </pre>
	 */
	doCommonInit : function(component, event, helper) {
        //=====================================================================
        // logging  적용
        //=====================================================================
        helper.g_isLogging = component.get('v.g_isLogging');
	},
})