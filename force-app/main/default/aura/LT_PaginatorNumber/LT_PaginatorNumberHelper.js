/**
 * Created by ms on 2017-10-30.
 */
({
	/**
	 * 이벤트를 발생하여 파라미터로 거래 페이지번호를 세팅
	 * @param component
	 * @param event
	 * @param helper
	 * @param actionName
	 */
	fn_firePagingTrans : function(component, event, helper, actionName) {
		var compEvt = component.getEvent('pagingTransEvt');
		var pageNumber;
		
		switch (actionName) {
			case 'doPreviousPage' :
				pageNumber = (component.get('v.pageNumber') || 1)-1;
				break;
			case 'doNextPage' :
				pageNumber = (component.get('v.pageNumber') || 1)+1;
				break;
			case 'doFirstPage' :
				pageNumber = 1;
				break;
			case 'doLastPage' :
				pageNumber = component.get('v.totalPage');
				break;
			case 'doSelectPage' :
				pageNumber = event.getSource().get('v.value');
				break;
		}
		
		compEvt.setParams({'data' : {'pageNumber':pageNumber}});
		compEvt.fire();
	}
})