({
    storeColumnWidths: function (component, event, helper) {
        helper.storeColumnWidths(event.getParam('columnWidths'));
    },
    updateColumnSorting: function (component, event, helper) {
        var fieldName = event.getParam('fieldName');
        var sortedDirection = event.getParam('sortDirection');
        var columns = component.get('v.columns');
        var sortApiName;
        columns.forEach(function (column) {
            if (column.fieldName === fieldName) {
                sortApiName = column.sortApiName;
            }
        });
        if (!component.get('v.sortedDirection')) {
            if (component.get('v.defaultSortDirection') == 'desc') {
                sortedDirection = 'asc';
            } else {
                sortedDirection = 'desc';
            }
        }
        component.set("v.sortedBy", fieldName);
        component.set("v.sortedDirection", sortedDirection);
        component.set('v.sortApiName', sortApiName);
        component.set('v.mode', helper.g_sortMode);
        $A.enqueueAction(component.get('v.fetchAction'));
    },
    loadMoreDataTable: function (component, event, helper) {
        var dataLength = component.get('v.data') ? component.get('v.data').length : 0;
        component.set('v.tempEnableInfiniteLoading', component.get('v.enableInfiniteLoading'));
        component.set('v.enableInfiniteLoading', false);
        if (dataLength >= component.get('v.rowsToAdd')) {
            component.set('v.mode', helper.g_moreMode);
            $A.enqueueAction(component.get('v.fetchAction'));
        }
    },

    handleLocation: function (component, event, helper) {
        component.set('v.tempEnableInfiniteLoading', component.get('v.enableInfiniteLoading'));
        component.set('v.enableInfiniteLoading', false);
    }
})