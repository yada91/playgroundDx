/**
 * Created by i2max on 2017-09-19.
 */

public with sharing class LT_CommonPickList extends LT_CommonExtends{
    /**
     * <pre>
     * 단일 SObject 객체 리턴
     * </pre>
     * @param Map<String, Object> pmap : pmap 명칭은 공통 사용(명칭 변경 불가)
     * @return Map<String, Object>
     */
    @AuraEnabled
    public static Map<String, Object> getPicklistValues(Map<String, Object> pmap) {
        System.debug(System.loggingLevel.INFO, 'getPicklistValues : request : ' + pmap);

        //-------------------------------------------------------------
        // 최종 리턴 데이터 세팅
        //-------------------------------------------------------------
        String obj= (String)pmap.get('object');
        String fld= (String)pmap.get('field');
        Boolean hasDefault = (Boolean)pmap.get('hasDefault');
        String defaultValue = (String)pmap.get('defaultValue');
        
        List<Map<String, String>> target = LT_CommonUtil.getPicklistValues(obj, fld, hasDefault, defaultValue, true);
        Map<String, Object> rmap = LT_CommonUtil.makeLtData(target);

        system.debug(rmap);
        return rmap;
        //return null;
    }

    @AuraEnabled
    public static Map<String, Object> getMultiPicklistValues(Map<String, Object> pmap) {
        System.debug(System.loggingLevel.INFO, 'getPicklistValues : request : ' + pmap);

        //-------------------------------------------------------------
        // 최종 리턴 데이터 세팅
        //-------------------------------------------------------------

        List<Map<String, String>> target = LT_CommonUtil.getPicklistValues((String)pmap.get('object'), (String)pmap.get('field'), false, 'none', false);
        Map<String, Object> rmap = LT_CommonUtil.makeLtData(target);

        system.debug(rmap);
        return rmap;
    }
}