/****************************************************************************************
  * File Name   : LT_Util
  * Description : Lightning Util
  * Copyright   : Copyright © 1995-2016 SAMSUNG All Rights Reserved
  * Author      : i2max
  * Modification Log
  * ===============================================================
  * Ver  Date        Author    Modification
  * ===============================================================
    1.0  2017.08.23  i2max     Create
****************************************************************************************/
global with sharing class LT_Util {
    //Locale Date Format
    private static Map<String, String> localeMap = new Map<String, String>
    {'ar' => 'dd/MM/yyyy hh:mm a',
    'ar_AE' => 'dd/MM/yyyy hh:mm a',
    'ar_BH' => 'dd/MM/yyyy hh:mm a',
    'ar_JO' => 'dd/MM/yyyy hh:mm a',
    'ar_KW' => 'dd/MM/yyyy hh:mm a',
    'ar_LB' => 'dd/MM/yyyy hh:mm a',
    'ar_SA' => 'dd/MM/yyyy hh:mm a',
    'bg_BG' => 'yyyy-M-d H:mm',
    'ca' => 'dd/MM/yyyy HH:mm',
    'ca_ES' => 'dd/MM/yyyy HH:mm',
    'ca_ES_EURO' => 'dd/MM/yyyy HH:mm',
    'cs' => 'd.M.yyyy H:mm',
    'cs_CZ' => 'd.M.yyyy H:mm',
    'da' => 'dd-MM-yyyy HH:mm',
    'da_DK' => 'dd-MM-yyyy HH:mm',
    'de' => 'dd.MM.yyyy HH:mm',
    'de_AT' => 'dd.MM.yyyy HH:mm',
    'de_AT_EURO' => 'dd.MM.yyyy HH:mm',
    'de_CH' => 'dd.MM.yyyy HH:mm',
    'de_DE' => 'dd.MM.yyyy HH:mm',
    'de_DE_EURO' => 'dd.MM.yyyy HH:mm',
    'de_LU' => 'dd.MM.yyyy HH:mm',
    'de_LU_EURO' => 'dd.MM.yyyy HH:mm',
    'el_GR' => 'd/M/yyyy h:mm a',
    'en_AU' => 'd/MM/yyyy HH:mm',
    'en_B' => 'M/d/yyyy h:mm a',
    'en_BM' => 'M/d/yyyy h:mm a',
    'en_CA' => 'dd/MM/yyyy h:mm a',
    'en_GB' => 'dd/MM/yyyy HH:mm',
    'en_GH' => 'M/d/yyyy h:mm a',
    'en_ID' => 'M/d/yyyy h:mm a',
    'en_IE' => 'dd/MM/yyyy HH:mm',
    'en_IE_EURO' => 'dd/MM/yyyy HH:mm',
    'en_NZ' => 'd/MM/yyyy HH:mm',
    'en_SG' => 'M/d/yyyy h:mm a',
    'en_US' => 'M/d/yyyy h:mm a',
    'en_ZA' => 'yyyy/MM/dd hh:mm a',
    'es' => 'd/MM/yyyy H:mm',
    'es_AR' => 'dd/MM/yyyy HH:mm',
    'es_BO' => 'dd-MM-yyyy hh:mm a',
    'es_CL' => 'dd-MM-yyyy hh:mm a',
    'es_CO' => 'd/MM/yyyy hh:mm a',
    'es_CR' => 'dd/MM/yyyy hh:mm a',
    'es_EC' => 'dd/MM/yyyy hh:mm a',
    'es_ES' => 'd/MM/yyyy H:mm',
    'es_ES_EURO' => 'd/MM/yyyy H:mm',
    'es_GT' => 'd/MM/yyyy hh:mm a',
    'es_HN' => 'MM-dd-yyyy hh:mm a',
    'es_MX' => 'd/MM/yyyy hh:mm a',
    'es_PE' => 'dd/MM/yyyy hh:mm a',
    'es_PR' => 'MM-dd-yyyy hh:mm a',
    'es_PY' => 'dd/MM/yyyy hh:mm a',
    'es_SV' => 'MM-dd-yyyy hh:mm a',
    'es_UY' => 'dd/MM/yyyy hh:mm a',
    'es_VE' => 'dd/MM/yyyy hh:mm a',
    'et_EE' => 'd.MM.yyyy H:mm',
    'fi' => 'd.M.yyyy H:mm',
    'fi_FI' => 'd.M.yyyy H:mm',
    'fi_FI_EURO' => 'd.M.yyyy H:mm',
    'fr' => 'dd/MM/yyyy HH:mm',
    'fr_BE' => 'd/MM/yyyy H:mm',
    'fr_CA' => 'yyyy-MM-dd HH:mm',
    'fr_CH' => 'dd.MM.yyyy HH:mm',
    'fr_FR' => 'dd/MM/yyyy HH:mm',
    'fr_FR_EURO' => 'dd/MM/yyyy HH:mm',
    'fr_LU' => 'dd/MM/yyyy HH:mm',
    'fr_MC' => 'dd/MM/yyyy HH:mm',
    'hr_HR' => 'yyyy.MM.dd HH:mm',
    'hu' => 'yyyy.MM.dd. H:mm',
    'hy_AM' => 'M/d/yyyy h:mm a',
    'is_IS' => 'd.M.yyyy HH:mm',
    'it' => 'dd/MM/yyyy H.mm',
    'it_CH' => 'dd.MM.yyyy HH:mm',
    'it_IT' => 'dd/MM/yyyy H.mm',
    'iw' => 'HH:mm dd/MM/yyyy',
    'iw_IL' => 'HH:mm dd/MM/yyyy',
    'ja' => 'yyyy/MM/dd H:mm',
    'ja_JP' => 'yyyy/MM/dd H:mm',
    'kk_KZ' => 'M/d/yyyy h:mm a',
    'km_KH' => 'M/d/yyyy h:mm a',
    'ko' => 'yyyy. M. d a h:mm',
    'ko_KR' => 'yyyy. M. d a h:mm',
    'lt_LT' => 'yyyy.M.d HH.mm',
    'lv_LV' => 'yyyy.d.M HH:mm',
    'ms_MY' => 'dd/MM/yyyy h:mm a',
    'nl' => 'd-M-yyyy H:mm',
    'nl_BE' => 'd/MM/yyyy H:mm',
    'nl_NL' => 'd-M-yyyy H:mm',
    'nl_SR' => 'd-M-yyyy H:mm',
    'no' => 'dd.MM.yyyy HH:mm',
    'no_NO' => 'dd.MM.yyyy HH:mm',
    'pl' => 'yyyy-MM-dd HH:mm',
    'pt' => 'dd-MM-yyyy H:mm',
    'pt_AO' => 'dd-MM-yyyy H:mm',
    'pt_BR' => 'dd/MM/yyyy HH:mm',
    'pt_PT' => 'dd-MM-yyyy H:mm',
    'ro_RO' => 'dd.MM.yyyy HH:mm',
    'ru' => 'dd.MM.yyyy H:mm',
    'sk_SK' => 'd.M.yyyy H:mm',
    'sl_SI' => 'd.M.y H:mm',
    'sv' => 'yyyy-MM-dd HH:mm',
    'sv_SE' => 'yyyy-MM-dd HH:mm',
    'th' => 'M/d/yyyy h:mm a',
    'th_TH' => 'd/M/yyyy => H:mm ?.',
    'tr' => 'dd.MM.yyyy HH:mm',
    'ur_PK' => 'M/d/yyyy h:mm a',
    'vi_VN' => 'HH:mm dd/MM/yyyy',
    'zh' => 'yyyy-M-d ah:mm',
    'zh_CN' => 'yyyy-M-d ah:mm',
    'zh_HK' => 'yyyy-M-d ah:mm',
    'zh_TW' => 'yyyy/M/d a h:mm'};

    global static String getDateFormat(String localeKey) {
        String f = localeMap.get(localeKey);
        return f==null?localeMap.get('ko_KR'):f;
    }

    /**
     * Null Check
     * @param o     Object
     * @return      o가 null 이면 true, null이 아니면 false 를 return.
     * @Author      snowChoi
     * e.g.) Util.isNull(null) --> true
     **/
    global static Boolean isNull(Object o) {
        return o==null?true:false;
    }

    /**
     * Empty Check
     * @param o     Object
     * @return      o가 null 혹은 '' 이면 true, 아니면 false 를 return.
     * @Author      김성일
     * e.g.) Util.isEmpty(' ') --> true
     **/
    global static Boolean isEmpty(Object o) {
        if (o == null) return true;

        if (o instanceOf String) {
            if (''.equals(o)) return true;
            if (''.equals(String.valueOf(o).trim())) return true; // SPACE도 empty로 본다.
        } // type 별 null 기준 정의 필요. Number일 경우 등.

        return false;
    }
    /**
     * SAP의 숫자형 문자 비교.
     * @param s     String
     * @return      o가 null, '', '00000' 이면 true, 아니면 false 를 return.
     * @Author      김성일
     * e.g.) Util.isSAPEmpty('000000') --> true
     **/
    global static Boolean isSAPEmpty(String s) {
        if (s == null) return true;

        if (''.equals(s)) return true;
        if (''.equals(String.valueOf(s).trim())) return true; // SPACE도 empty로 본다.

        String b = s.replaceAll('[0]', ''); // 0으로 채워져 있는 지 판단한다.
        return (b.length() == 0);
    }
    /**
     * Not Empty Check
     * @param o     Object
     * @return      o가 null 혹은 '' 이면 true, 아니면 false 를 return.
     * @Author      김성일
     * e.g.) Util.isNotEmpty('a') --> true
     **/
    global static Boolean isNotEmpty(Object o) {
        return !isEmpty(o);
    }

    /**
     * Integer NVL
     * @param o     Integer
     * @return      o가 null 이면 0을 return. null이 아니면 o 를 return.
     * @Author      snowChoi
     * e.g.) Util.nvlInt(null) --> 0
     **/
    global static Integer nvlInt(Integer o) {
        return nvlInt(o, 0);
    }
    global static Integer nvlInt(Integer o, Integer r) {
        return o==null?r:o;
    }

    global static Decimal nvlDec(Decimal o) {
        return nvlDec(o, 0);
    }
    global static Decimal nvlDec(Decimal o, Decimal r) {
        return o==null?r:o;
    }

    global static String nvlStr(String o) {
        return nvlStr(o, '');
    }
    global static String nvlStr(String o, String r) {
        String tmp = '';
        if( o == null || ''.equals(o) || o == 'null'){
            tmp = r;
        }else {
            tmp = o;
        }
        return tmp;
    }

    global static String nvlObj( Object o, String r){
        return nvlStr( o + '', r);
    }

    /**
     * 숫자여부
     * @param str   문자열
     * @return      str 이 숫자형 문자이면 true, 그렇지 않으면 false
     * @Author      snowChoi
     * e.g.) Util.isNumber('123') --> true
     **/
    global static Boolean isNumber(String str) {
        return Pattern.Matches('[0-9]+', str);
    }

    /**
     * Padding Left
     * @param s     원본 문자열
     * @param p     추가할 문자
     * @param l     길이
     * @return      l만큼 s의 왼쪽에 p를 추가한 문자열
     * @Author      snowChoi
     * e.g.) lpad('123', '0', 5) --> '00123'
     **/
    global static String lpad(String s, String p, Integer l) {
        if (s == null) return null;

        while(s.length() < l) {
            s = p + s;
        }
        return s;
    }
    global static String lpad(Integer i, String p, Integer l) {
        return lpad(i+'', p, l);
    }

    /**
     * Padding Right
     * @param s     원본 문자열
     * @param p     추가할 문자
     * @param l     길이
     * @return      l만큼 s의 오른쪽에 p를 추가한 문자열
     * @Author      snowChoi
     * e.g.) rpad('123', '0', 5) --> '12300'
     **/
    global static String rpad(String s, String p, Integer l) {
        while(s.length() < l) {
            s += p;
        }
        return s;
    }
    /*
     * substring
     * @param s     원본 문자열
     * @param startIndex        substring 시작 위치.
     * @param endIndex      substring 종료 위치.
     * @return       substring 된 문자열.
     * @Author      김성일
     * e.g.) Utiil.substring('123', 1, 2) --> '12300'
     * 정확히 짜르지 않으면 "Ending position out of bounds" 에러가 발생하여 정확히 짜르기 위함.
     */
    global static String substring(String s, Integer startIndex, Integer endIndex) {
        if (isEmpty(s)) return null;

        if (startIndex > s.length()) return '';

        if (endIndex > s.length()) {
            endIndex = s.length();
        }
        return s.substring(startIndex, endIndex);
    }

    /**
     * Date to String
     * @return      오늘 날짜의 문자열을 return.
     * @Author      snowChoi
     * e.g.) Util.strDate() --> '20150421'
     **/
    global static String strDate() {
        return dateFormat(Date.today(), '');
    }
    global static String strDate(String delimiter) {
        return dateFormat(Date.today(), delimiter);
    }
    global static String strYYMM() {
        return String.valueOf(Date.today().year()) + lpad(String.valueOf(Date.today().month()), '0', 2);
    }

    global static String strYYMM(Date d) {
        return String.valueOf(d.year()) + lpad(String.valueOf(d.month()), '0', 2);
    }
    global static String strYYYYMMDD(Date d) {
        if (isEmpty(d)) return null;

        String sMonth = String.valueof(d.month());
        String sDay = String.valueof(d.day());
        if(sMonth.length()==1){
            sMonth = '0' + sMonth;
        }
        if(sDay.length()==1){
            sDay = '0' + sDay;
        }
        return String.valueof(d.year()) + sMonth + sDay ;
    }


    /**
     * Date format
     * @param i     '-'가 뒤에 붙은 문자열
     * @return      '-' 기호를 앞에 붙힌 숫자
     * @Author      김성일
     * e.g.) Util.revertMinus('1000-') --> -1000
     **/
    global static Decimal revertMinus(String i) {
        String a = i.trim();
        if (a.endsWith('-')) { // GERP는 '-' 가 뒤에 붙어서 옴.
            a = a.replace('-', '');
            a = '-' + a;
        }
        return Decimal.valueOf(a);
    }
    /**
     * Date format
     * @param d     Date형 문자열
     * @return      yyyymmdd 를 yyyy-mm-dd 로 변경.
     * @Author      snowChoi
     * e.g.) Util.formatDate('20160816') --> '2016-08-16'
     **/
    global static String formatDate(String d) {
        return formatDate(d, '-');
    }
    /**
     * Date format
     * @param d         Date형 문자열
     * @param delimiter 구분자
     * @return          delimiter 를 구분자로 포맷을 변경함.
     * @Author          snowChoi
     * e.g.) 20160708 -> 2016/07/08, 2016-07-08, 2016.07.08
     **/
    global static String formatDate(String d, String delimiter) {
        if (d == null || d.length() != 8) return d; // 8 자리일 경우에만 해당

        String yyyy = d.substring(0, 4);
        String mm = d.substring(4, 6);
        String dd = d.substring(6, 8);
        return yyyy + delimiter + mm + delimiter + dd;
    }

    /**
     * Next Month
     * @param dt_work   년월 형식의 문자열
     * @return          dt_work 의 다음 달에 해당하는 문자열을 return.
     * @Author          snowChoi
     * e.g.) Util.strNextYYMM('201601') --> '201602'
     **/
    global static String strNextYYMM(String dt_work) {

        Integer y = Integer.valueOf(dt_work.left(4));
        Integer m = Integer.valueOf(dt_work.right(2));

        Date dt = Date.newInstance(y, m, 1);
        Date ndt1 = dt.addMonths(1);

        return strYYMM(ndt1);
    }

    /**
     * Previous Month
     * @param dt_work   년월 형식의 문자열
     * @return          dt_work 의 이전 달에 해당하는 문자열을 return.
     * @Author          snowChoi
     * e.g.) Util.strPreYYMM('201601') --> '201512'
     **/
    global static String strPreYYMM(String dt_work) {

        Integer y = Integer.valueOf(dt_work.left(4));
        Integer m = Integer.valueOf(dt_work.right(2));

        Date dt = Date.newInstance(y, m, 1);
        Date pdt1 = dt.addMonths(-1);

        return strYYMM(pdt1);
    }

    /**
     * Date Format
     * @param d         Date
     * @param delimiter 구분자
     * @return          d 날짜의 문자열을 구분자를 포함하는 형태의 문자열로 return
     * @Author          snowChoi
     * e.g.) Util.dateFormat(Date.today()) --> '2015-04-21'
     **/
    global static String dateFormat(Date d) {
        return dateFormat(d, '-');
    }

    /**
     * Date Format
     * @param d         Date
     * @param delimiter 구분자
     * @return          d 날짜의 문자열을 구분자를 포함하는 형태의 문자열로 return
     * @Author          snowChoi
     * e.g.) Util.dateFormat(Date.today(), '-') --> '2015-04-21'
     **/
    global static String dateFormat(Date d, String delimiter) {
        if (d == null) return null;
        return String.valueOf(d.year()) + delimiter + lpad(String.valueOf(d.month()), '0', 2) + delimiter + lpad(String.valueOf(d.day()), '0', 2);
    }

    /**
     * 일별 일련번호 생성
     * @param objName   sObject API Name
     * @return          sObject 의 오늘의 Max 값 + 1 리턴
     * @Author          snowChoi
     * e.g.) Util.getMax('Account') --> 4
     **/
    global static Decimal getMax(String objName) {
        List<AggregateResult> arList = database.query('SELECT MAX(Name) nm FROM '+String.escapeSingleQuotes(objName)+' WHERE CreatedDate = TODAY');

        if(arList.size()==0 || isNull(arList.get(0).get('nm'))) {
            return 1;
        } else {
            String name = (String)arList.get(0).get('nm');
            return name.right(3).isNumeric()?Decimal.valueOf(name.right(3))+1:1;
        }
    }

    /**
     * 월별 일련번호 생성
     * @param objName   sObject API Name
     * @return          sObject 의 월별 Max 값 + 1 리턴
     * @Author          snowChoi
     * e.g.) Util.getMax('Account') --> 4
     **/
    global static Decimal getMaxMonth(String objName) {
        List<AggregateResult> arList = database.query('SELECT MAX(Name) nm FROM '+String.escapeSingleQuotes(objName)+' WHERE CreatedDate = THIS_MONTH');

        if(arList.size()==0 || isNull(arList.get(0).get('nm'))) {
            return 1;
        } else {
            String name = (String)arList.get(0).get('nm');
            return name.right(3).isNumeric()?Decimal.valueOf(name.right(3))+1:1;
        }
    }

    /**
     * 일련번호 생성
     * @param idx       Index Number
     * @param prefix    일련 번호의 Prefix 문자열
     * @return          prefix + 오늘날짜 + 순번.
     * @Author          snowChoi
     * e.g.) Util.getName(4, 'SO') --> SO-20150428-004
     **/
    global static String getName(Decimal idx, String prefix) {
        return prefix + '-' + strDate() + '-' + lpad(idx+'', '0', 3);
    }

    /**
     * 일련번호 생성
     * @param objName   sObject API Name
     * @param prefix    일련 번호의 Prefix 문자열
     * @return          prefix + 오늘날짜 + 순번(sObject의 오늘의 Max).
     * @Author          snowChoi
     * e.g.) Util.getName('Account', 'SO') --> SO-20150428-004
     **/
    global static String getName(String objName, String prefix) {
        List<AggregateResult> arList = database.query('SELECT MAX(Name) nm FROM '+String.escapeSingleQuotes(objName)+' WHERE CreatedDate = TODAY');

        if(arList.size()==0 || isNull(arList.get(0).get('nm'))) {
            return prefix + '-' + strDate() + '-001';
        } else {
            String name = (String)arList.get(0).get('nm');
            Integer idx = name.right(3).isNumeric()?Integer.valueOf(name.right(3)):0;
            return prefix + '-' + strDate() + '-' + lpad(idx+1+'', '0', 3);
        }
    }

    /**
     * 일련번호 생성
     * @param objName   sObject API Name
     * @param prefix    일련 번호의 Prefix 문자열
     * @return          prefix + 이번달 + 순번(sObject의 당월의 Max).
     * @Author          snowChoi
     * e.g.) Util.getNameOfMonth('Account', 'SO') --> SO-201504-004
     **/
    global static String getNameOfMonth(String objName, String prefix) {
        List<AggregateResult> arList = database.query('SELECT MAX(ID) nm FROM '+String.escapeSingleQuotes(objName)+' WHERE CreatedDate = THIS_MONTH');
        if(arList.size()==0 || isNull(arList.get(0).get('nm'))) {
            return prefix + '-' + strYYMM() + '-001';
        } else {
            String name = (String)arList.get(0).get('nm');
            Integer idx = name.right(3).isNumeric()?Integer.valueOf(name.right(3)):0;
            return prefix + '-' + strYYMM() + '-' + lpad(idx+1+'', '0', 3);
        }
    }

    /**
     * 일련번호 생성
     * @param idx       순번
     * @param prefix    일련 번호의 Prefix 문자열
     * @return          prefix + 이번달 + 순번(idx).
     * @Author          snowChoi
     * e.g.) Util.getNameOfMonth('Account', 'SO') --> SO-201504-004
     **/
    global static String getNameOfMonth(Decimal idx, String prefix) {
        return prefix + '-' + strYYMM() + '-' + lpad(idx+'', '0', 3);
    }

    /**
     * 문자열을 Date 로 변환
     * @param str       Date 형식의 문자열
     * @return          String Type 일자를 Date 으로 변환하여 리턴.
     * @Author          snowChoi
     * e.g.) Util.str2Dt('20150825') -->
     * e.g.) Util.str2Dt('2015-08-25') -->
     **/
    global static Date str2Date(String str) {
        Date d;
        if(str!=null) {
            try{
                d = Date.parse(str);
            }catch(System.TypeException te) {
                if(str.length()==8) {
                    d = Date.newInstance(Integer.valueOf(str.left(4)), Integer.valueOf(str.substring(4,6)), Integer.valueOf(str.right(2)));
                } else if(str.length()==10) {
                    d = Date.newInstance(Integer.valueOf(str.left(4)), Integer.valueOf(str.substring(5,7)), Integer.valueOf(str.right(2)));
                }
            }
        }
        return d;
    }

    /**
     * 문자열을 DateTime 으로 변환
     * @param str       DateTime 형식의 문자열
     * @return          String Type 일자를 DateTime 으로 변환한다.
     * @Author          snowChoi
     * e.g.) Util.str2Dt('201508251137') -->
     * e.g.) Util.str2Dt('20150825113723') -->
     **/
    global static DateTime str2Dt(String str) {
        DateTime dt;
        if(str!=null) {
            if(str.length()==12) {
                dt = DateTime.newInstance(Integer.valueOf(str.left(4)), Integer.valueOf(str.substring(4,6)), Integer.valueOf(str.substring(6,8))
                        , Integer.valueOf(str.substring(8,10)), Integer.valueOf(str.right(2)), 0);
            } else if(str.length()==14) {
                dt = DateTime.newInstance(Integer.valueOf(str.left(4)), Integer.valueOf(str.substring(4,6)), Integer.valueOf(str.substring(6,8))
                        , Integer.valueOf(str.substring(8,10)), Integer.valueOf(str.substring(10,12)), Integer.valueOf(str.right(2)));
            }
        }
        return dt;
    }

    /**
     * Byte Size
     * @param s     문자열
     * @return      문자열의 Byte 수
     * @Author      snowChoi
     * e.g.) Util.byteSize('123가나다abc') --> 12
     **/
    global static Integer byteSize(String s) {
        Integer b=0;
        for(Integer i=0; i<s.length(); i++) {
            b += s.charAt(i)<128?1:2;
        }
        return b;
    }


    /**
     * 반올림
     * @param d     숫자
     * @return      소수점 2째자리 반올림
     * @Author      snowChoi
     * e.g.) Util.round(3.141592) --> 3.14
     **/
    global static Decimal round(Decimal d) {
        return round(d, 2);
    }
    global static Decimal round(Decimal d, Integer dp) {
        return Math.round(d*Math.pow(10,dp))/Math.pow(10,dp);
    }

    /**
     * 절상
     * @param d     숫자
     * @return      소수점 2째자리 올림
     * @Author      snowChoi
     * e.g.) Util.ceil(3.141592) --> 3.15
     **/
    global static Decimal ceil(Decimal d) {
        return ceil(d, 2);
    }
    /**
     * 절상
     * @param d     숫자
     * @return      소수점 2째자리 올림
     * @Author      snowChoi
     * e.g.) Util.ceil(3.141592, 2) --> 3.15
     **/
    global static Decimal ceil(Decimal d, Integer dp) {
        return Math.ceil(d*Math.pow(10,dp))/Math.pow(10,dp);
    }

    /**
     * 절삭
     * @param d     숫자
     * @return      소수점 2째자리 내림
     * @Author      snowChoi
     * e.g.) Util.floor(3.141592) --> 3.14
     **/
    global static Decimal floor(Decimal d) {
        return floor(d, 2);
    }
    /*
     * 절삭
     * @param d     숫자
     * @return      소수점 2째자리 내림
     * @Author      snowChoi
     * e.g.) Util.floor(3.141592, 2) --> 3.14
     */
    global static Decimal floor(Decimal d, Integer dp) {
        return Math.floor(d*Math.pow(10,dp))/Math.pow(10,dp);
    }

}