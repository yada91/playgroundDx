/**
 * Created by i2max on 2018-06-11.
 */

@IsTest
private class LT_DataTableCommon_Test {
    static testMethod void testBehavior() {
        Map<String, Object> pmap = new Map<String, Object>();
        pmap.put('objectName', 'PromotionalTracking__c');
        pmap.put('fieldSetName', 'Promotional_Field');

        List<String> condition = new List<String>();
        condition.add('WHERE name != null');
        LT_DataTableCommon dtCommon = new LT_DataTableCommon();
        dtCommon.getDataTableRecords(pmap,condition,true);
    }
}