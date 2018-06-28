/**
 * Created by ms on 2017-09-12.
 */

public with sharing class LT_CommonLookupController extends LT_CommonExtends {
    /**
     * <pre>
     * Lookup Field의 Id, Name을 가지고 온다.
     * </pre>
     * @param Map<String, Object> pmap : pmap 명칭은 공통 사용(명칭 변경 불가)
     * @return Map<String, Object>
     */
    @AuraEnabled
    public static Map<String, Object> getLookupValues(Map<String, Object> pmap) {
        System.debug(System.loggingLevel.INFO, 'request : ' + pmap);
        String searchKey = String.valueOf(pmap.get('searchKeyWord'));
        String sobjectName = String.valueOf(pmap.get('sobjectName'));
        String optionQuery = String.valueOf(pmap.get('optionQuery'));
        String condition = String.valueOf(pmap.get('condition'));
        String limitSize = pmap.get('limitSize') == null ? '5' : String.valueOf(pmap.get('limitSize'));
        // Create a Dynamic SOQL Query For Fetch Record List with LIMIT 5
        String query = String.join(new List<String>{
                ' Select Id, Name '
           ,    '   From ' + sobjectName
           ,    '   WHERE id != null'
           //,    String.isEmpty(searchKey) ? ' ' : ('  Where Name LIKE \'%' + searchKey + '%\'')
//           ,    String.isEmpty(searchKey) ? ' ' : ('  Where 1=1 ')
           ,    String.isEmpty(searchKey) ? ' ' : ('  AND Name LIKE \'%' + searchKey+'%\'')
           ,    String.isEmpty(condition) ? ' ' : (' ' + condition)
	        //,    String.isEmpty(optionQuery) ? ' Order by createdDate DESC limit ' + limitSize : optionQuery
	        ,    String.isEmpty(optionQuery) ? ' Order by Name ASC limit ' + limitSize : optionQuery
        }, LT_CommonUtil.JOIN_CHAR_QUERY);

        System.debug(System.loggingLevel.INFO, 'query : ' + query);

        List<SObject> returnList = Database.query(query);
        Map<String, Object> rmap = LT_CommonUtil.makeLtData(returnList);
        if(returnList.size() == 0) {
            Map<String, Object> emap = LT_CommonUtil.makeLtError(new LT_CommonBizMessage('No Result Found...'));
            rmap.putAll(emap);
        }
        return rmap;
    }
	
	/**
     * Lookup의 DefaultValue 값을 조회
     *
     * @param pmap
     *
     * @return
     */
	@AuraEnabled
	public static Map<String, Object> getLookupDefaultValue(Map<String, Object> pmap) {
		System.debug(System.loggingLevel.INFO, 'request : ' + pmap);
		
		Map<String, Object> rmap = new Map<String, Object>();
		try {
			String sobjectName = String.valueOf(pmap.get('sobjectName'));
			String defaultValue = String.valueOf(pmap.get('defaultValue'));
			String query = String.join(new List<String>{
				' Select Id, Name '
				,    '   From ' + sobjectName
				,    '   WHERE Id = :defaultValue'
			}, LT_CommonUtil.JOIN_CHAR_QUERY);
			
			SObject returnSObject = Database.query(query);
			rmap = LT_CommonUtil.makeLtData(returnSObject);
		}
		catch(Exception e) {
			System.debug(loggingLevel.ERROR, e);
			Map<String, Object> emap = LT_CommonUtil.makeLtError(new LT_CommonBizMessage(e.getMessage()));
			rmap.putAll(emap);
		}
		
		return rmap;
	}
}