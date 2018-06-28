/**
  * ===============================================================
  * File Name   : LT_CommonModalTemplateController.js
  * Description : 공통 Modal Component Client-Side Controller
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
     * ModalTemplate 컴포넌트를 destory
     * </pre>
     */
    onRemoveComponent:function(component, event){
        //---------------------------------------------
        // Close시 추가적인 Action을 수행
        //---------------------------------------------
		var action = component.get('v.onCloseAction');
        if(action) {
            action.setParam({});
            $A.enqueueAction(action);
        }
        // 하단 script error
        // "Uncaught TypeError: a.getAttribute is not a function" error message as well.
        // This is a locker service issue since turning it off removes the error.
        try {
            component.destroy();
        } catch(e) {
            console.log('error ', e);
        };
    }
})