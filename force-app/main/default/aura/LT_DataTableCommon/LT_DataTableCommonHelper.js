({
    g_sortMode: 'sort',
    g_searchMode: 'search',
    g_moreMode: 'more',
    g_location: '',
    setDataTableAttr: function (component, LT_DATA, mode, dataLength) {
        var location = window.location.pathname.split('/')[1];
        var columns = LT_DATA.columns;
        if (dataLength >= component.get('v.totalNumberOfRows')) {
            component.set('v.enableInfiniteLoading', false);
        } else if (component.get('v.tempEnableInfiniteLoading')) {
            component.set('v.enableInfiniteLoading', true);
        }
        var percentField = [];
        columns.forEach(function (column) {
            if (!component.get('v.IsDesktop')) column.initialWidth = 150;
            if (column.type === 'percent') {
                percentField.push(column.fieldName);
            }
        });
        var formattedData = LT_DATA.data.map(function (record) {
            record.Name__c = location == 'lightning' ? '/' + record.Id : '/' + location + '/' + record.Id;
            Object.keys(record).forEach(function (keys) {
                var child = record[keys];
                if (percentField.indexOf(keys) >= 0) {
                    record[keys] = record[keys] / 100;
                }
                if (child instanceof Object) {
                    Object.keys(child).forEach(function (childKeys) {
                        var fieldName = keys + childKeys;
                        if (childKeys === 'Id') {
                            record[keys + 'Id'] = location == 'lightning' ? '/' + child['Id'] : '/' + location + '/' + child['Id'];
                        } else {
                            record[fieldName] = child[childKeys];
                        }
                    });
                }
            });
            return record;
        });
        if (mode === this.g_moreMode) {
            var currentData = component.get('v.data');
            var newData = currentData.concat(formattedData);
            component.set('v.data', newData);
        } else if (mode === this.g_sortMode || mode === this.g_searchMode) {
            component.set('v.data', formattedData);
        } else {
            component.set('v.columns', columns);
            component.set('v.data', formattedData);
        }

    },
    storeColumnWidths: function (widths) {
        localStorage.setItem('datatable-in-action', JSON.stringify(widths));
    },
    resetLocalStorage: function () {
        localStorage.setItem('datatable-in-action', null);
    },
    getColumnWidths: function () {
        var widths = localStorage.getItem('datatable-in-action');

        try {
            widths = JSON.parse(widths);
        } catch (e) {
            return [];
        }
        return Array.isArray(widths) ? widths : [];
    }
});