/**
  * ===============================================================
  * File Name   : LT_DataTableCommon
  * Description : Lightning DataTable component with FieldSet
  * Author      : i2max
  * Modification Log
  * ===============================================================
  * Ver  Date          Author         Modification
  * ===============================================================
  * 1.0  2018. 05. 18  Donghu        Create
  * ===============================================================
 */

public with sharing class LT_DataTableCommon {
    public DataTableWrapper getDataTableRecords(Map<String, Object> pmap, List<String> condition, Boolean editable) {
        Schema.SObjectType SObjectTypeObj = Schema.getGlobalDescribe().get((String) pmap.get('objectName'));
        Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();
        Schema.FieldSet fieldSet = DescribeSObjectResultObj.FieldSets.getMap().get((String) pmap.get('fieldSetName'));

        List<DataTableColumns> dataColumns = new List<DataTableColumns>();
        List<String> queryList = new List<String>();

        DataTableWrapper dw = new DataTableWrapper();

        for (Schema.FieldSetMember eachFieldSetMember : fieldSet.getFields()) {
            String dataType = String.valueOf(eachFieldSetMember.getType()).toLowerCase();
            String apiName = String.valueOf(eachFieldSetMember.getFieldPath());
            String label = String.valueOf(eachFieldSetMember.getLabel());
            String sortApiName = apiName;
            integer initialWidth = 100;
            Map<String, Object> typeAttributes;
            //Data Type 'reference' 인 값들 url 처리
            if ('dataTime'.equals(dataType) || 'date'.equals(dataType)) dataType = 'date-local';
            if ('double'.equals(dataType)) dataType = 'number';
            if ('Name'.equals(apiName) || apiName.contains('.Name')) {
                String tempApi;
                if ('Name'.equals(apiName)) {
                    tempApi = apiName;
                    apiName = 'Name__c';
                } else {
                    tempApi = apiName.remove('.');
                    if (apiName.contains('.'))apiName = apiName.substring(0, apiName.indexOf('.')) + 'Id';
                }
                dataType = 'url';
                typeAttributes = new Map<String, Object>{
                        'label' => new Map<String, Object>{
                                'fieldName' => tempApi
                        }, 'target' => '_blank'
                };
                initialWidth = 150;
            } else if (apiName.contains('.')) {
                apiName = apiName.remove('.');
            } else if ('currency'.equals(dataType)) {
                dataType = 'number';
            }

            Map<String, Object> cellAttributes;
            DataTableColumns dataColumn = new DataTableColumns(label, apiName, dataType, typeAttributes, cellAttributes, initialWidth, editable, sortApiName);
            dataColumns.add(dataColumn);
            queryList.add(String.valueOf(eachFieldSetMember.getFieldPath()));
        }

        if (LT_Util.isNotEmpty(pmap.get('actions'))) {
            dataColumns.add(new DataTableColumns(null, null, 'action', new Map<String, Object>{
                    'rowActions' => pmap.get('actions')
            }, null, null, false, null));
        }

        if (!dataColumns.isEmpty()) {
            //마지막에 한칸 추가 스크롤바 땜에 안보임
            DataTableColumns dataColumn = new DataTableColumns(' ', ' ', 'text', null, null, 10, false, null);
            dataColumn.sortable = false;
            dataColumns.add(dataColumn);
            dw.dataColumns = dataColumns;
            if (queryList.size() == 0) queryList.add('Id');
            //Column
            String query = 'SELECT ' + String.join(queryList, ',') + ' FROM ' + (String) pmap.get('objectName');
            //Condition
            if (condition != null && !condition.isEmpty()) query += ' ' + String.join(condition, LT_CommonUtil.JOIN_CHAR_QUERY);
            //Sort
            if (LT_Util.isNotEmpty(pmap.get('sortApiName'))) {
                query += ' ORDER BY ' + pmap.get('sortApiName');
                if (LT_Util.isNotEmpty(pmap.get('sortedDirection'))) {
                    query += ' ' + pmap.get('sortedDirection');
                    if (pmap.get('sortedDirection') == 'desc')query += ' NULLS LAST';
                }
            } else {
                query += ' ORDER BY Name ' + pmap.get('defaultSortDirection');
            }
            if (LT_Util.isNotEmpty(pmap.get('rowsToAdd'))) query += ' LIMIT ' + pmap.get('rowsToAdd');
            if (LT_Util.isNotEmpty(pmap.get('offset'))) query += ' OFFSET ' + pmap.get('offset');
            dw.query = query;
        }
        return dw;
    }

    public class DataTableColumns {
        @AuraEnabled
        public String label { get; set; }
        @AuraEnabled
        public String fieldName { get; set; }
        @AuraEnabled
        public String type { get; set; }
        @AuraEnabled
        public Map<String, Object> typeAttributes { get; set; }
        @AuraEnabled
        public Map<String, Object> cellAttributes { get; set; }
        @AuraEnabled
        public Integer initialWidth { get; set; }
        @AuraEnabled
        public Boolean sortable { get; set; }
        @AuraEnabled
        public Boolean editable { get; set; }
        @AuraEnabled
        public String sortApiName { get; set; }

        public DataTableColumns(String label, String fieldName, String type, Map<String, Object> typeAttributes, Map<String, Object> cellAttributes, Integer initialWidth, Boolean editable, String sortApiName) {
            this.label = label;
            this.fieldName = fieldName;
            this.type = type;
            this.typeAttributes = typeAttributes;
            this.cellAttributes = cellAttributes;
            this.initialWidth = initialWidth;
            this.sortable = true;
            this.editable = editable;
            this.sortApiName = sortApiName;
        }
    }

    public class DataTableWrapper {
        @AuraEnabled
        public List<DataTableColumns> dataColumns { get; set; }
        @AuraEnabled
        public String query { get; set; }

        public DataTableWrapper() {
        }
    }
}