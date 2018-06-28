/****************************************************************************************
  * File Name   : LT_CommonPage
  * Description : Lightning page 처리용 DAO 클래스
  *             : 한 리스트 거래별로 page 관련 변수 및 데이터 저장
  *             : 업무 Controller 에서는 wrapper 클래스에서 Property로 설정하여 사용할 것
  * Author      : i2max
  * Modification Log
  * ===============================================================
  * Ver  Date        Author    Modification
  * ===============================================================
    1.0  2017.07.10  i2max     Create
    1.1  2017.11.06  i2max     OFFSET 2000 건 처리 로직 추가(2000건으로 한정)
****************************************************************************************/
public class LT_CommonPage {
    
    private static Integer OFFSET_MAX_RECORD = 2000;
    
    /**
     * 페이지 사이즈(한 페이지당 페이지 사이즈)
     */
    @AuraEnabled public Integer pageSize {
        get {
            return (this.pageSize == null || this.pageSize == 0) ? 5 : this.pageSize;
        }
        set;
    }
    /**
     * offset
     */
    @AuraEnabled public Integer offset {
        get {
            return (this.offset == null) ? (this.pageNumber - 1) * this.pageSize : this.offset;
        }
        set;
    }
    /**
     * 요청 pageNumber
     */
    @AuraEnabled public Integer pageNumber {
        get {
            return (this.pageNumber == null || this.pageNumber == 0) ? 1 : this.pageNumber;
        }
        set;
    }
    /**
     * 총 레코드수
     * offset 기반이므로 2000건까지 페이징 처리
     */
    @AuraEnabled public Integer totalCount {
        get {
            return this.totalCount > LT_CommonPage.OFFSET_MAX_RECORD ? LT_CommonPage.OFFSET_MAX_RECORD : this.totalCount;
        }
        set;
    }
    /**
     * 총 페이지수
     */
    @AuraEnabled public Integer totalPage {
        get {
            this.totalPage = (Integer)Math.ceil((Double)this.totalCount/(Double)this.pageSize);
            this.totalPage = this.totalPage == 0 ? 1 : this.totalPage;
            return this.totalpage;
        }
        set;
    }
    /**
     * next 여부
     */
    @AuraEnabled public Boolean hasNext {
        get {
            return (this.offset + this.pageSize < this.totalCount) ? true : false;
        }
        set;
    }
    /**
     * previous 여부
     */
    @AuraEnabled public Boolean hasPrevious {
        get {
            return (this.offset > 0) ? true : false;
        }
        set;
    }
    /**
     * 2000 Record over 여부
     */
    @AuraEnabled public Boolean hasMoreRecordsOver2000 {
        get {
            Integer loc = this.pageSize + this.offset;
            return (loc > this.totalCount && loc > LT_CommonPage.OFFSET_MAX_RECORD) ? true : false;
        }
        set;
    }
    /**
     * 데이터 리스트
     */
    @AuraEnabled public List<Object> objList  {get;set;}
 
}