/**
  * ===============================================================
  * File Name   : LT_PaginatorController.js
  * Description : Lightning pagination event controller
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
	firePreviousPage : function(component) {
	    console.log('LT_PaginatorController - firePreviousPage');
        var pageChangeEvent = component.getEvent("pagePrevious");
        pageChangeEvent.fire();
	},

	fireNextPage : function(component) {
	    console.log('LT_PaginatorController - fireNextPage');
        var pageChangeEvent = component.getEvent("pageNext");
        pageChangeEvent.fire();
	}
})