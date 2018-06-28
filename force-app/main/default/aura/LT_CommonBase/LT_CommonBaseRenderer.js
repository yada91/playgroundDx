/**
	* ===============================================================
	* File Name   : LT_CommonBaseRenderer.js
	* Description : FrameWork 공통 renderer javascript
	* Author      : i2max
	* Modification Log
	* ===============================================================
	* Ver  Date          Author         Modification
	* ===============================================================
	* 1.0  2016. 07. 10  i2max        Create
	* 1.0  2016. 08. 01  i2max        afterRender 이후 rsdl css 세팅 추가
	* ===============================================================
	*/
({
	render: function( cmp, helper ) {
		var renderObj = this.superRender();
		return renderObj;
	},
	rerender: function( cmp, helper ) {
		this.superRerender();
	},
	afterRender: function( cmp, helper ) {
		this.superAfterRender();
		//=====================================================================
		// slds 적용 - 40 버전에서는 서로 다른 Namespace간 DOM 핸들링이 안되므로 사용하지 않음
		//=====================================================================
		//helper.gfnUtil.setSldsClass(cmp, helper);
	},
	unrender: function( cmp, helper ) {
		this.superUnrender();
	}
})