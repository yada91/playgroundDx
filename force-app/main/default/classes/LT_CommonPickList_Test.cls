/****************************************************************************************
  * File Name   : LT_CommonPickList_Test
  * Description : LT_CommonPickList Test Case Class
  * Author      : i2max
  * Modification Log
  * ===============================================================
  * Ver  Date        Author    Modification
  * ===============================================================
    1.0  2017.11.13  i2max    Create
****************************************************************************************/

@IsTest
private class LT_CommonPickList_Test {

    static testMethod void testBehavior() {

        Test.startTest();

            Map<String, Object> pmap = new Map<String, Object>();
            pmap.put('field' , 'AccountSource');
            pmap.put('object' , 'Account');
            pmap.put('hasDefault' , false);
            pmap.put('defaultValue' , 'aa');


            LT_CommonPickList.getPicklistValues(pmap);

            LT_CommonPickList.getMultiPicklistValues(pmap);
        Test.stopTest();

    }
}