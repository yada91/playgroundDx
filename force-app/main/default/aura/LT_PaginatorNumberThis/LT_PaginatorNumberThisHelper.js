/**
 * Created by ms on 2017-10-30.
 */
({
	/**
	 * 해당 페이지 리스트 거래 함수
	 * @param component
	 * @param event
	 * @param helper
	 * @param actionName
	 */
	fn_trans : function(component, event, helper, actionName) {
		var parent = component.get('v.parent');
		var parentPageNumberVarName = component.get('v.parentPageNumberVarName');
		var _parentPageNumberVarName = 'v.'+parentPageNumberVarName;
		var parentDoPagingTransName = component.get('v.parentDoPagingTransName');
		var pageNumber;
		var parent_action = parent.get('c.' + parentDoPagingTransName);

		switch (actionName) {
			case 'doPreviousPage' :
				pageNumber = (parent.get(_parentPageNumberVarName) || 1)-1;
				break;
			case 'doNextPage' :
				pageNumber = (parent.get(_parentPageNumberVarName) || 1)+1;
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
		
		parent.set(_parentPageNumberVarName, pageNumber);

		if($A.util.isEmpty(parent_action) === false) {
			$A.enqueueAction(parent_action);
		}
	}
})