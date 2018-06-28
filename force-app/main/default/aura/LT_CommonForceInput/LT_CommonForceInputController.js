/**
  * ===============================================================
  * File Name   : LT_CommonForceInputController.js
  * Description : FrameWork 공통 controller javascript
				: force:input 사용을 위한 기본 처리
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
	 * 임의 사용 force:input 을 hidden 처리
	 * class 처리가 아닌 destroy 처리
	 */
	doInit: function( component, event, helper ) {
	    /*
	     * 네임스페이스가 다르기 때문에 force:input을 바로 destroy 하지 못함
	     * 자신의 컴포넌트를 바로 destroy 하여 처리
	    */
	    //var cmp = component.find( 'accountLookup' );
	    //console.dir(cmp);
		//component.find( 'accountLookup' ).destroy();
		component.destroy();
	}
})