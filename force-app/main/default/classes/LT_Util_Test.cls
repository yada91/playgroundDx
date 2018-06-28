/****************************************************************************************
  * File Name   : RolloutUtil
  * Description : Rollout Utility
  * Copyright   : Copyright © 1995-2016 SAMSUNG All Rights Reserved
  * Author      : i2max
  * Modification Log
  * ===============================================================
  * Ver  Date        Author    Modification
  * ===============================================================
    1.0  2016.06.23  i2max     Create
    1.1  2016.07.11  i2max     Update
****************************************************************************************/
@isTest
private with sharing class LT_Util_Test {

    static testMethod void utilTest() {

        Test.startTest();

        system.assertEquals(LT_Util.getDateFormat('ko_KR'), 'yyyy. M. d a h:mm');

        system.assertEquals(LT_Util.isNull(null), true);

        system.assertEquals(LT_Util.nvlInt(null), 0);
        system.assertEquals(LT_Util.nvlDec(null), 0);
        system.assertEquals(LT_Util.nvlStr(null), '');
        system.assertEquals(LT_Util.nvlStr('s'), 's');
        system.assertEquals(LT_Util.nvlObj('s', 's'), 's');

        system.assertEquals(LT_Util.isNumber('123'), true);
        system.assertEquals(LT_Util.isNumber('12x'), false);

        system.assertEquals(LT_Util.lpad('123','0',5), '00123');
        system.assertEquals(LT_Util.lpad(123,'0',5), '00123');
        system.assertEquals(LT_Util.rpad('123','0',5), '12300');

        system.assertNotEquals(LT_Util.strDate(), '');
        system.assertNotEquals(LT_Util.strDate('-'), '');
        system.assertNotEquals(LT_Util.strYYMM(), '');
        system.assertNotEquals(LT_Util.strYYMM(Date.today()), '');
        system.assertNotEquals(LT_Util.strYYYYMMDD(Date.today()), '');
        system.assertNotEquals(LT_Util.strYYYYMMDD(Date.newInstance(2000, 1, 1)), '');
        system.assertEquals(LT_Util.strNextYYMM('201604'), '201605');
        system.assertEquals(LT_Util.strPreYYMM('201604'), '201603');
        system.assertNotEquals(LT_Util.dateFormat(Date.today(),'-'), '');
        system.assertNotEquals(LT_Util.dateFormat(Date.today()), '');

        system.assertEquals(LT_Util.getMax('Topic'), 1);
        system.assertEquals(LT_Util.getMaxMonth('Topic'), 1);
        system.assertNotEquals(LT_Util.getName(4,'AC'), '');
        system.assertNotEquals(LT_Util.getName('Topic','AC'), '');
        system.assertNotEquals(LT_Util.getNameOfMonth('Topic','AC'), '');
        system.assertNotEquals(LT_Util.getNameOfMonth(4,'AC'), '');

        insert new Topic(Name='ACC-001');
        system.assertEquals(LT_Util.getMax('Topic'), 2);
        system.assertEquals(LT_Util.getMaxMonth('Topic'), 2);
        system.assertNotEquals(LT_Util.getName(4,'AC'), '');
        system.assertNotEquals(LT_Util.getName('Topic','AC'), '');
        system.assertNotEquals(LT_Util.getNameOfMonth('Topic','AC'), '');
        system.assertNotEquals(LT_Util.getNameOfMonth(4,'AC'), '');
        system.assertEquals(LT_Util.str2Date('20150825'), Date.newInstance(2015,8,25));
        system.assertEquals(LT_Util.str2Date('2015-08-25'), Date.newInstance(2015,8,25));
        system.assertEquals(LT_Util.str2Dt('201508251137'), DateTime.newInstance(2015,08,25,11,37,0));
        system.assertEquals(LT_Util.str2Dt('20150825113723'), DateTime.newInstance(2015,08,25,11,37,23));

        system.assertEquals(LT_Util.byteSize('123가나다abc'), 12);
        system.assertEquals(LT_Util.round(3.141592), 3.14);
        system.assertEquals(LT_Util.ceil(3.141592), 3.15);
        system.assertEquals(LT_Util.floor(3.141592), 3.14);
        system.assertEquals(LT_Util.isSAPEmpty('00000'), true);

        system.assertEquals(LT_Util.formatDate('20160801', '-'), '2016-08-01');
        system.assertEquals(LT_Util.formatDate('20160801'), '2016-08-01');
        system.assertEquals(LT_Util.revertMinus('1000-'), -1000);
        system.assertEquals(LT_Util.substring('abc', 1, 3), 'bc');
        system.assertEquals(LT_Util.substring('abc', 1, 4), 'bc');
        system.assertEquals(LT_Util.isNotEmpty('object string'), true);

        Test.stopTest();
    }

}