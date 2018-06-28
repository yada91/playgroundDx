/****************************************************************************************
  * File Name   : LT_CommonUtil_Test
  * Description : LT_CommonUtil Test Case Class
  * Author      : i2max
  * Modification Log
  * ===============================================================
  * Ver  Date        Author    Modification
  * ===============================================================
    1.0  2017.08.08  i2max    Create
****************************************************************************************/
@IsTest
private class LT_CommonUtil_Test {

    static User commonUtilTestUser {
        get {
            if (commonUtilTestUser == null) {
                commonUtilTestUser = new User(ID = UserInfo.getUserId());
            }
            return commonUtilTestUser;
        }
        set;
    }

    static testMethod void testBehavior() {

        System.runAs(commonUtilTestUser) {

            Test.startTest();

            LT_CommonUtil ctrl = new LT_CommonUtil();
            System.assertNotEquals(ctrl.userSession, null);

            List<Object> objList = new List<Object>();
            objList.add(new Map<Object, Object>{
                    'Id' => commonUtilTestUser.Id, 'sobjectType' => 'User'
            });

            Map<String, Object> objMap = LT_CommonUtil.makeLtData(commonUtilTestUser);
            Map<String, Object> objMap1 = LT_CommonUtil.makeLtError(commonUtilTestUser);

            LT_CommonUtil.convertListToSObjectList(objList);

            Map<String, Object> pmap = new Map<String, Object>{
                    'sobjectKeys' => new List<String>{
                            'User'
                    }
            };
            Map<String, Object> labelsMap = LT_CommonUtil.getLabels(pmap);

            pmap.put('hasFieldResult', true);
            labelsMap = LT_CommonUtil.getLabels(pmap);

            //---------------------------------------------------------
            // Test Case Data를 생성할 경우 converSObjectToMap 을 사용할 것
            //---------------------------------------------------------
            // 쿼리 조회가 되었던 기본 SObject 의 List Data
            List<User> tmpUserList = new List<User>{
                    commonUtilTestUser
            };
            Map<Object, Object> SObj = (Map<Object, Object>) LT_CommonUtil.convertSObjectToMap((SObject) tmpUserList.get(0));
            List<Map<Object, Object>> SObjList = (List<Map<Object, Object>>) LT_CommonUtil.convertSObjectListToList(tmpUserList);

            String className = LT_CommonUtil.getClassName(new LT_CommonUtil());
            System.debug(className);
            System.assert(className == 'LT_CommonUtil');

            LT_CommonUtil.getPicklistValues('User', 'LanguageLocaleKey', true, 'en_US', true);
            LT_CommonUtil.getPicklistValues('User', 'LanguageLocaleKey', false, 'en_US', false);

            LT_CommonPage page = new LT_CommonPage();
            page.pageSize = 5;
            page.pageNumber = 1;
            page.totalCount = 10;
            List<Integer> tmpList = LT_CommonUtil.getPagingBlock(page, 10);

            Test.stopTest();
        }

    }
}