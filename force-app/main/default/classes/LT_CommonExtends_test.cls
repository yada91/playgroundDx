/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class LT_CommonExtends_test extends LT_CommonExtends{
	@testSetup
    static void setData() {
    	User usr = new User();
		usr.Email = 'test@salesforce.com';
		usr.LastName = 'testEventRedirectUser';
		usr.FIRSTNAME = '0221';
		usr.profileid = UserInfo.getProfileId();
		usr.emailencodingkey='ks_c_5601-1987';
		usr.languagelocalekey='en_US';
		usr.IsActive = true;
		usr.Username = 'test123123@salesforce.com';
		usr.Alias = 'test001';
		usr.CommunityNickname = 'test';
		usr.TimeZoneSidKey = 'Asia/Seoul';
		usr.LocaleSidKey = 'ko_KR';
		insert usr;
    }
    static testMethod void myUnitTest() {
        LT_CommonExtends_test ts = new LT_CommonExtends_test();
        System.debug('userSession : ' + ts.userSession);
        
    }
}