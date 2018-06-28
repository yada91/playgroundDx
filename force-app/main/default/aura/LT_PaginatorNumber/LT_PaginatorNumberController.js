/**
 * ===============================================================
 * File Name   : LT_PaginatorController.js
 * Description : Lightning pagination event controller
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
	 * 이전페이지 action
	 */
	doPreviousPage : function(component, event, helper) {
		helper.fn_firePagingTrans(component, event, helper, 'doPreviousPage');
	},
	
	/**
	 * 다음페이지 action
	 */
	doNextPage : function(component, event, helper) {
		console.log('doNextPage');
		helper.fn_firePagingTrans(component, event, helper, 'doNextPage');
	},
	
	/**
	 * 처음페이지 action
	 */
	doFirstPage : function(component, event, helper) {
		console.log('doFirstPage');
		helper.fn_firePagingTrans(component, event, helper, 'doFirstPage');
	},
	
	/**
	 * 마지막페이지 action
	 */
	doLastPage : function(component, event, helper) {
		console.log('doLastPage');
		helper.fn_firePagingTrans(component, event, helper, 'doLastPage');
	},
	
	/**
	 * 선택페이지 action
	 */
    doSelectPage : function(component, event, helper) {
		console.log('doSelectPage');
		helper.fn_firePagingTrans(component, event, helper, 'doSelectPage');
    },
	
})