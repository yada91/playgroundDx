/****************************************************************************************
  * File Name   : LT_CommonExtends
  * Description : Lightning Server Controller 상속받는 clss
  *             : 공통적인 Property, Method 구현
  * Copyright   : Copyright © 1995-2016 SAMSUNG All Rights Reserved
  * Author      : i2max
  * Modification Log
  * ===============================================================
  * Ver  Date        Author    Modification
  * ===============================================================
    1.0  2017.07.10  i2max     Create
****************************************************************************************/
public with sharing abstract class LT_CommonExtends {
    /**
     *  Context User 정보필드 : 필요시 필드를 추가하여 사용할 것
     */ 
    public User userSession {
        get {
            return (userSession == null) ? [SELECT  Id
                                                ,   Name
                                                ,   ProfileId 
                                                ,   Profile.Name
                                                ,   UserRoleId
                                                ,   UserRole.Name
                                              FROM  User
                                             WHERE  Id = :UserInfo.getUserId()] : userSession;
        }
        set;
    }

}