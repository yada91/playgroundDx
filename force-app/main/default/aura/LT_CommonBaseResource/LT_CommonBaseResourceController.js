/**
 * ===============================================================
 * File Name   : LT_CommonbaseResourceController.js
 * Description : client controller
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
     * Resource 모두 로딩이전 호출
     * </pre>
     */
    doBeforeResourceLoaded : function(component, event, helper) {
        //----------------------------------------------------
        // Resource Component 사용시 넘어오는 Action 수행
        //----------------------------------------------------
        var action = component.get('v.beforeAction');
        if(action) {
            $A.enqueueAction(action);
        }
    },
    /**
     * <pre>
     * 리소스 자원 로딩후 호출<br/>
     * jQuery 가 로딩이후 이므로 사용가능
     * </pre>
     */
    doAfterResourceLoaded : function(component, event, helper) {
        component.set('v.isResourceLoaded',true);
        //----------------------------------------------------
        // Resource Component 사용시 넘어오는 Action 수행
        //----------------------------------------------------
        var action = component.get('v.afterAction');
        if(action) {
            $A.enqueueAction(action);
        }
    },
})