/**
 * Created by ms on 2017-09-12.
 */
({
	onInit : function(component, event, helper) {
		console.log('onInit...');
		helper.fn_getLookupDefaultValue(component, event, helper);
	},
	
    onSelectedSetting : function(component, event, helper) {
        var forclose = component.find("lookup-pill");
        $A.util.addClass(forclose, 'slds-show');
        $A.util.removeClass(forclose, 'slds-hide');
        var forclose = component.find("searchRes");
        $A.util.addClass(forclose, 'slds-is-close');
        $A.util.removeClass(forclose, 'slds-is-open');
        var lookUpTarget = component.find("lookupField");
        $A.util.addClass(lookUpTarget, 'slds-hide');
        $A.util.removeClass(lookUpTarget, 'slds-show');


        // 항목 선택시 수행 되는 액션
        var action = component.get('v.selectAction');
        if(action) {
            $A.enqueueAction(action);
        }
    },

    // 하단 리스트 창 오픈 + 리스트 조회
    onFocus : function(component, event, helper){
        console.log('--onfocus');
        var forOpen = component.find("searchRes");
        $A.util.addClass(forOpen, 'slds-is-open');
        $A.util.removeClass(forOpen, 'slds-is-close');
        helper.fn_search(component, event, helper);
    },

    // 키보드 입력
    onKeyPress : function(component, event, helper) {
        console.log('onkeypress');
        var getInputkeyWord = component.get("v.SearchKeyWord");

        if( getInputkeyWord.length > 0 ){
            console.log('getInputkeyWord', getInputkeyWord);
            var forOpen = component.find("searchRes");
            $A.util.addClass(forOpen, 'slds-is-open');
            $A.util.removeClass(forOpen, 'slds-is-close');
            helper.fn_search(component, event, helper);
        }
        else {
            // 값이 없는 경우 리스트를 지우고 창을 닫음
            component.set("v.listOfSearchRecords", null );
            var forclose = component.find("searchRes");
            $A.util.addClass(forclose, 'slds-is-close');
            $A.util.removeClass(forclose, 'slds-is-open');
        }
    },

    // 선택 후 취소
    onClear :function(component, event, heplper){
        var pillTarget = component.find("lookup-pill");
        var lookUpTarget = component.find("lookupField");
        $A.util.addClass(pillTarget, 'slds-hide');
        $A.util.removeClass(pillTarget, 'slds-show');
        $A.util.addClass(lookUpTarget, 'slds-show');
        $A.util.removeClass(lookUpTarget, 'slds-hide');
        component.set("v.SearchKeyWord",null);
        component.set("v.listOfSearchRecords", null );
        component.set("v.selectedRecord", {} );
//		component.set("v.selectedRecord", null);

        // 선택된 것이 없을 경우 지움
        component.set("v.sobjectLookupField", null);

        // 항목 선택해제시 수행 되는 액션
        var action = component.get('v.unselectAction');
        if(action) {
            $A.enqueueAction(action);
        }
    },

    // Lookup Result에서 값 선택
    handleComponentEvent : function(component, event, helper) {
        var selectedRecord = event.getParam("data");
        component.set("v.selectedRecord" , selectedRecord);


    },
	
	onSetRecord : function(component, event, helper) {
		var selectedRecord = component.get("v.selectedRecord");
		
		console.log('selectedRecord', selectedRecord);
		
		var isEmpty = Boolean(selectedRecord && typeof selectedRecord == 'object') && !Object.keys(selectedRecord).length;
		console.log('isEmpty', isEmpty);
		// Id와 Name 이 동시에 있어야 한다.
		var hasIdAndName = Boolean(selectedRecord.Id && selectedRecord.Name);
		console.log('hasIdAndName', hasIdAndName);
		
		var hasRecord = !isEmpty && hasIdAndName;
		
		console.log('hasRecord', hasRecord);
		
		if(hasRecord === true) {
			component.set('v.sobjectLookupField', selectedRecord.Id);
			var action = component.get('c.onSelectedSetting');
			$A.enqueueAction(action);
		}
		
	},
    hideSpinner : function (component, event, helper) {
        var spinner = component.find('spinner');
        var evt = spinner.get("e.toggle");
        evt.setParams({ isVisible : false });
        evt.fire();
    },
    showSpinner : function (component, event, helper) {
        var spinner = component.find('spinner');
        var evt = spinner.get("e.toggle");
        evt.setParams({ isVisible : true });
        evt.fire();
    },
})