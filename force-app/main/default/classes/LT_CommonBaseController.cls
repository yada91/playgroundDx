/****************************************************************************************
  * File Name   : LT_CommonBaseController
  * Description : 공통 컴포넌트 Controller
  * Copyright   : Copyright © 1995-2016 SAMSUNG All Rights Reserved
  * Author      : i2max
  * Modification Log
  * ===============================================================
  * Ver  Date        Author    Modification
  * ===============================================================
    1.0  2017.07.10  i2max     Create
****************************************************************************************/
public with sharing class LT_CommonBaseController extends LT_CommonExtends {
    /**
	 * <pre>
	 * 업무별 SObject의 Label을 처리하기 위한 함수
	 * </pre>
	 * @param Map<String, Object> pmap : pmap 명칭은 공통 사용(명칭 변경 불가)
	 * @return Map<String, Object>
	 */
    @AuraEnabled
    public static Map<String, Object> getLabels(Map<String, Object> pmap) {
        System.debug(System.loggingLevel.INFO, 'label request : ' + pmap);
        // sobject의 labels map 구성
        Map<String, Object> sobjectLabels = LT_CommonUtil.getLabels(pmap);
        // 최종 client에 전달할 map 구성
        Map<String, Object> rmap = LT_CommonUtil.makeLtData(sobjectLabels);
        return rmap;
    }
}