/****************************************************************************************
  * File Name   : LT_CommonBizMessage
  * Description : Lightning Biz Error Class
  *             : 모든 거래는 정상적이지만 별도 에러 메시지를 전달할 경우 사용
  * Author      : i2max
  * Modification Log
  * ===============================================================
  * Ver  Date        Author    Modification
  * ===============================================================
    1.0  2017.07.10  i2max     Create
****************************************************************************************/
public class LT_CommonBizMessage {
    // Biz Error 여부
    @AuraEnabled public Boolean isBizError {
        get {
            return String.isEmpty(this.bizErrorMessage) ? false : true;
        }
        private set;
    }
    // Biz Error 메시지
    @AuraEnabled public String bizErrorMessage {get;set;}

    public LT_CommonBizMessage(){
        this(null);
    }
    
    public LT_CommonBizMessage(String bizErrorMessge) {
        this.bizErrorMessage = bizErrorMessge;
    }
}