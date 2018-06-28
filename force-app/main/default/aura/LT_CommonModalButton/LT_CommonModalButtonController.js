/**
  * ===============================================================
  * File Name   : LT_CommonModelButtonController.js
  * Description : 공통 Modal Component
  * Copyright   : Copyright © 1995-2016 SAMSUNG All Rights Reserved
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
     * Create Component handler
     * </pre>
     */
    onCreateComponent : function(component, event, helper) {
		var compName = component.get('v.compName');
		var compAttributes = component.get('v.compAttributes');
        $A.createComponent(
                compName
            ,   compAttributes
            ,   function(newComponent, status, errorMessage){
                    if (component.isValid()) {
                        if(status ==="SUCCESS") {
	                        //-------------------------------------------------------------------
	                        // ModalButton 안에 v.body가 계속적으로 중복이 되니 초기화를 한다.
	                        // 그리고 팝업 내용을 추가한다.
	                        // v.body 안에 아무것도 존재하면 안된다.
	                        //-------------------------------------------------------------------
							component.set("v.modalContent", []);
	                        var body = component.get("v.modalContent");
	                        body.push(newComponent);
	                        component.set("v.modalContent", body);
                        } else if(status ==="INCOMPLETE"){
                            console.log('No response from server or client is offline.');
                        } else if(status ==="ERROR") {
                            console.log('Error :' + errorMessage);
                        }
                    }
            }
        );
    },
})