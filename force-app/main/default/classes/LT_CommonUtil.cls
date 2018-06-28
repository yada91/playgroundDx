/****************************************************************************************
  * File Name   : Util
  * Description : Utility
  * Copyright   : Copyright © 1995-2016 SAMSUNG All Rights Reserved
  * Author      : i2max
  * Modification Log
  * ===============================================================
  * Ver  Date        Author    Modification
  * ===============================================================
    1.0  2016.06.23  i2max     Create 
****************************************************************************************/
global without sharing class LT_CommonUtil extends LT_CommonExtends {
    /**
     * Return Server Data Key
     */
    global static String KEY_LT_DATA = 'LT_DATA';
    global static String KEY_LT_ERROR = 'LT_ERROR';
    global static String JOIN_CHAR_QUERY = '\n';     // CarriageReturn

    /**
     * Server Data Key 로 실제 리턴할 서버의 데이터를 생성
     */
    global static Map<String, Object> makeLtData(Object obj) {
        return new Map<String, Object>{LT_CommonUtil.KEY_LT_DATA => obj};
    }

    /**
     * Server Data Key 로 실제 리턴할 서버의 데이터를 생성
     */
    global static Map<String, Object> makeLtError(Object obj) {
        return new Map<String, Object>{LT_CommonUtil.KEY_LT_ERROR => obj};
    }

    /**
     * Convert Map<String, Object> to SObject
     */
    global static SObject convertMapToSObject(Object cmap) {
        Map<Object, Object> lcmap = (Map<Object, Object>)cmap;
        Id id = (Id)lcmap.get('Id');
        String sobjectType = (String)lcmap.get('sobjectType');
        String ltypeName = (id == null) ? sobjectType : String.valueOf(id.getSobjectType());
        System.debug(System.loggingLevel.INFO, '▶▶▶ id : ' + id + ', param sobjectType : ' + sobjectType + ', ltypeName : ' + ltypeName);

        //---------------------------------------------------------------
        // force:input 에서 불필요한 필드가 존재하여 삭제 로직 추가[시작]
        //---------------------------------------------------------------
        final Schema.SObjectType sobjType = Schema.getGlobalDescribe().get(ltypeName);
        final Schema.DescribeSObjectResult sObjResult = sobjType.getDescribe();
        final Map<String, Schema.SObjectField> fieldMap = sObjResult.fields.getMap();
        Set<String> fieldNamekeys = new Set<String>();

        for(Schema.SObjectField sfield : fieldMap.Values()){
            fieldNamekeys.add(sfield.getDescribe().getName());
        }

        for(Object key : lcmap.keySet()) {
            if(fieldNamekeys.contains((String)key) == false) {
                lcmap.remove(key);
            } 
        }
        //---------------------------------------------------------------
        // force:input 에서 불필요한 필드가 존재하여 삭제 로직 추가[종료]
        //---------------------------------------------------------------

        SObject sobj = (SObject)JSON.deserialize(JSON.serialize(cmap), Type.forName(ltypeName.trim()));
        System.debug(System.loggingLevel.INFO, '▶▶▶ sobj : ' + sobj);
        return sobj;
    }

    /**
     * Convert List<Object> to List<SObject>
     */
    global static List<SObject> convertListToSObjectList(List<Object> clist) {
        List<SObject> sobjList = new List<SObject>();
        SObject sobj;
        for(Object obj : clist) {
            sobj = (SObject)LT_CommonUtil.convertMapToSObject(obj);
            sobjList.add(sobj);
        }
        System.debug(System.loggingLevel.INFO, '▶▶▶ sobjList : ' + sobjList);
        return sobjList;
    }

    /**
     * Convert SObject to Map<Object, Object> For Test Case
     */
    global static Map<Object, Object> convertSObjectToMap(SObject sobj) {
        Map<String, Object> tmpMap = (Map<String, Object>)JSON.deserializeUntyped(JSON.serialize(sobj));
        Map<Object, Object> retMap = new Map<Object, Object>();
        for(String key : tmpMap.keySet()){
            retMap.put((Object)key, (Object)tmpMap.get(key));
        }
        return retMap;
    }

    /**
     * Convert List<SObject> to List<Map<Object, Object>> Fro Test Case
     */
    global static List<Map<Object, Object>> convertSObjectListToList(List<SObject> sobjs) {
        List<Map<Object, Object>> sobjList = new List<Map<Object, Object>>();
        for(SObject sobj : sobjs) {
            sobjList.add(LT_CommonUtil.convertSObjectToMap(sobj));
        }
        return sobjList;
    }

    /**
     * Convert List<Object> to List<SObject>
     */
    global static Map<String, Object> getLabels(Map<String, Object> pmap) {
        System.debug('getLables : ' + pmap);
        Boolean hasFieldResult = ((Boolean)pmap.get('hasFieldResult') == null) ? false : (Boolean)pmap.get('hasFieldResult');
        List<Object> sobjectTypeKeys = (List<Object>)pmap.get('sobjectKeys');
        String fieldName;
        Map<String, SObjectType> schemaMap = Schema.getGlobalDescribe();
        SObjectType sobjType;
        Map<String, SObjectField> fieldMap;
        Map<String, Object> fieldLabelMap;
        Map<String, Object> sobjectTypeLabelMap = new Map<String, Object>();
        Schema.DescribeFieldResult fieldResult;
        for(Object key : sobjectTypeKeys) {
            sobjType = schemaMap.get((String)key);
            fieldMap = sobjType.getDescribe().fields.getMap();
            fieldLabelMap = new Map<String, Object>();
            for (String fieldKey: fieldMap.keySet()) {
                fieldResult = fieldMap.get(fieldKey).getDescribe();
                if(hasFieldResult) {
                    //--------------------------------------------------------------------------
                    // 필드의 속성 결과를 map으로 담아서 처리
                    //--------------------------------------------------------------------------
                    fieldLabelMap.put(fieldResult.getName(), new Map<String, Object>{
                            'label'             => fieldResult.getLabel()
                            ,   'isNillable'        => fieldResult.isNillable()
                            ,   'isCreateable'      => fieldResult.isCreateable()
                            ,   'isCustom'          => fieldResult.isCustom()
                            ,   'isPermissionable'  => fieldResult.isPermissionable()
                            ,   'isUnique'          => fieldResult.isUnique()
                            ,   'isDefaultedOnCreate' => fieldResult.isDefaultedOnCreate()
                            //-------------------------------------------------------------------------------
                            // 향후 lightning:dataType을 활용할 경우 사용할 것
                            //-------------------------------------------------------------------------------
                            //,   'type'              => LT_CommonUtil.convertDisplayTypeToFormattedType(fieldResult.getType())
                            //,   'fieldName'         => fieldResult.getName()
                    });
                }
                else {
                    //--------------------------------------------------------------------------
                    // label 값만 담아서 처리
                    //--------------------------------------------------------------------------
                    fieldLabelMap.put(fieldResult.getName(), fieldResult.getLabel());
                }
            }
            sobjectTypeLabelMap.put((String)key, fieldLabelMap);
        }
        return sobjectTypeLabelMap;
    }
    
    /**
     * Lightning:dataTable 사용시 컬럼 필드의 formatted DataType 을 구함
     * DisplayType 과 상이한 관계로 별도 메소드를 구현
     * cf) DiaplayType 이 Location 인 필드의 DiaplayType의 형태를 알지 못해 로직에는 미반영 함
     *
     * @param displayType
     * @return
     */
/*
    global static String convertDisplayTypeToFormattedType(final Schema.DisplayType displayType) {
        String formattedType = '';
        final Set<Schema.DisplayType> sameType = new Set<Schema.DisplayType>{
                Schema.DisplayType.CURRENCY
            ,   Schema.DisplayType.DATE
            ,   Schema.DisplayType.EMAIL
            ,   Schema.DisplayType.PERCENT
            ,   Schema.DisplayType.PHONE
            ,   Schema.DisplayType.URL
        };
        
        if(sameType.contains(displayType) == true) {
            formattedType = String.valueOf(displayType).toLowerCase();
        }
        else {
            if(displayType == Schema.DisplayType.DATETIME) {
                formattedType = 'date';
            }
            else if(displayType == Schema.DisplayType.INTEGER
                ||  displayType == Schema.DisplayType.DOUBLE) {
                formattedType = 'number';
            }
            else {
                formattedType = 'text';
            }
        }
        return formattedType;
    }
    */
    
    /**
     * lightning Controller Exception
     * Controller 단에서 에러가 발생할 경우 try ~ catch 에서 잡을 경우 이 에러 객체를 사용할 것
     */
    global class LtControllerException extends Exception {}

   /**
    * this class의 name을 리턴
    * @param thisClass : String.valueOf(this) 의 full Name String
    */
    global static String getClassName(Object clazz) {
        return String.valueOf(clazz).substring(0, String.valueOf(clazz).indexOf(':'));
    }

   /**
    * picklist field의 values를 구함
    * @param sobjectApiName : SObject의 API 명
    * @param fieldApiName : SObject의 Field API 명
    * <example>
    * Map<String, Object> optionMap = LT_CommonUtil.getPicklistValues(sobjectApiName, fieldApiName);
    * System.debug(optionMap);
    */
    /*
    global static Map<String, Object> getPicklistValues(final String sobjectApiName, final String fieldApiName) {
        List<SelectOption> valueList = new List<SelectOption>();
        List<Schema.PicklistEntry> pickListValues = Schema.getGlobalDescribe().get(sobjectApiName).getDescribe().fields.getMap().get(fieldApiName).getDescribe().getPickListValues();
        for (Schema.PicklistEntry a : pickListValues) {
            if(a.isActive() == true) {
                valueList.add(new SelectOption(a.getValue(), a.getLabel()));
            }
        }
        return new Map<String, Object>{fieldApiName => valueList};
    }
    */

    /*
    global static Map<String, Object> getPicklistValues(final String sobjectApiName, final String fieldApiName) {
        List<SelectOption> valueList = new List<SelectOption>();
        List<Schema.PicklistEntry> pickListValues = Schema.getGlobalDescribe().get(sobjectApiName).getDescribe().fields.getMap().get(fieldApiName).getDescribe().getPickListValues();
        valueList.add(new SelectOption('', '--없음--'));
        for (Schema.PicklistEntry a : pickListValues) {
            if(a.isActive() == true) {
                if(!a.isDefaultValue()) valueList.add(new SelectOption(a.getValue(), a.getLabel()));
                else valueList.set(0, new SelectOption(a.getValue(), a.getLabel()));
            }
        }
        return new Map<String, Object>{fieldApiName => valueList};
    }
    */


    global static List<Map<String, String>> getPicklistValues(final String sobjectApiName, final String fieldApiName, final Boolean hasDefault, final String defaultValue, final Boolean isSingle) {
        List<Schema.PicklistEntry> pickListValues = Schema.getGlobalDescribe().get(sobjectApiName).getDescribe().fields.getMap().get(fieldApiName).getDescribe().getPickListValues();

        // SelectOption 리턴하면 에러떨어짐
        List<Map<String, String>> pickList = new List<Map<String, String>>();
        if(isSingle) {
            if(hasDefault){
                pickList.add(new Map<String, String>{
                    'label' => '--'+defaultValue+'--', 'value' => ''
                });
            }
            for (Schema.PicklistEntry a : pickListValues) {
                if (a.isActive() == true) {
                    if (!a.isDefaultValue()) pickList.add(new Map<String, String>{
                            'label' => a.getLabel(), 'value' => a.getValue()
                    }); else pickList.set(0, new Map<String, String>{
                            'label' => a.getLabel(), 'value' => a.getValue()
                    });
                }
            }
        }else{
            for (Schema.PicklistEntry a : pickListValues) {
                pickList.add(new Map<String, String>{'label' => a.getLabel(), 'value' => a.getValue()});
            }
        }
        return pickList;
    }
    
    /**
     * 페이지번호 넘버링 페이징 표현식을 위한 Block 요소를 구함
     */
    public static List<Integer> getPagingBlock(final LT_CommonPage page, final Integer pagingBlockSize) {
        List<Integer> pagingBlockItems = new List<Integer>();
        Integer shareVal = page.pageNumber/pagingBlockSize;
        Integer tmpVal = shareVal*pagingBlockSize;
        Integer remainVal = page.pageNumber-(tmpVal);
        Integer PageBlockStart;
        
        if(tmpVal == 0) {
            PageBlockStart = (shareVal*pagingBlockSize) + 1;
        }
        else {
            if(remainVal == 0) {
                PageBlockStart = (shareVal*pagingBlockSize) - (pagingBlockSize -1);
            }
            else {
                PageBlockStart = (shareVal*pagingBlockSize) + 1;
            }
        }
        
        Integer tint = 0;
        for (Integer i = 0; i < pagingBlockSize; i++) {
            tint = PageBlockStart+i;
            pagingBlockItems.add(tint);
            if (tint == page.totalPage) break;
        }
        
        System.debug('pagingBlockItems : ' + pagingBlockItems);
        
        return pagingBlockItems;
    }

}