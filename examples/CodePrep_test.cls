@isTest
public class CodePrep_test {
	static testMethod void isWoS_true() {
		CustomObject__c testObj = TestUtils.getWoSObj();

		Test.startTest();

		System.assert(CodePrep_after.isWoS(testObj), 'Should be waiting on support')

		Test.stopTest();
	}

	static testMethod void isWoS_false() {
		CustomObject__c testObj = TestUtils.getClosedObj();

		Test.startTest();

		System.assert(!CodePrep_after.isWoS(testObj), 'Should not be waiting on support')

		Test.stopTest();
	}

	static testMethod void isWoC_true() {
		CustomObject__c testObj = TestUtils.getWoCObj();

		Test.startTest();

		System.assert(CodePrep_after.isWoC(testObj), 'Should be waiting on customer');

		Test.stopTest();
	}

	static testMethod void isWoC_false() {
		CustomObject__c testObj = TestUtils.getWoSObj();

		Test.startTest();

		System.assert(!CodePrep_after.isWoC(testObj), 'Should not be waiting on customer');

		Test.stopTest();
	}

	static testMethod void isClosed_true() {
		CustomObject__c testObj = TestUtils.getClosedObj();

		Test.startTest();

		System.assert(CodePrep_after.isClosed(testObj), 'Should be closed');

		Test.stopTest();
	}

	static testMethod void isClosed_false() {
		CustomObject__c testObj = TestUtils.getWoCObj();

		Test.startTest();

		System.assert(!CodePrep_after.isClosed(testObj), 'Should not be closed');

		Test.stopTest();
	}

	static testMethod void hasStatusChanged_true() {
		CustomObject__c testObj1 = TestUtils.getWoCObj();
		CustomObject__c testObj2 = TestUtils.getClosedObj();

		Test.startTest();

		System.assert(!CodePrep_after.hasStatusChanged(testObj1, testObj2), 'Status has changed');

		Test.stopTest();
	}

	static testMethod void hasStatusChanged_false() {
		CustomObject__c testObj1 = TestUtils.getWoCObj();
		CustomObject__c testObj2 = TestUtils.getWoCObj();

		Test.startTest();

		System.assert(!CodePrep_after.hasStatusChanged(testObj1, testObj2), 'Status has not changed');

		Test.stopTest();
	}

	static testMethod void setInternalStatus_WoS() {
		CustomObject__c newObj = TestUtils.getWoSObj();
		CustomObject__c oldObj = TestUtils.getWoCObj();

		Test.startTest();

		CodePrep_after.setInternalStatus(newObj, oldObj);

		Test.stopTest();

		System.assertEquals(CodePrep_after.WAITING_ON_SUPPORT, newObj.InternalStatus__c, 'Did not get the expected status');
	}

	static testMethod void setInternalStatus_WoC() {
		CustomObject__c newObj = TestUtils.getWoCObj();
		CustomObject__c oldObj = TestUtils.getWoSObj();

		Test.startTest();

		CodePrep_after.setInternalStatus(newObj, oldObj);

		Test.stopTest();

		System.assertEquals(CodePrep_after.WAITING_ON_CUSTOMER, newObj.InternalStatus__c, 'Did not get the expected status');
	}

	static testMethod void setInternalStatus_closed() {
		CustomObject__c newObj = TestUtils.getClosedObj();
		CustomObject__c oldObj = TestUtils.getWoSObj();

		Test.startTest();

		CodePrep_after.setInternalStatus(newObj, oldObj);

		Test.stopTest();

		System.assertEquals(null, newObj.InternalStatus__c, 'Did not get the expected status');
	}

	static testMethod void setInternalStatus_nullOld() {
		CustomObject__c newObj = TestUtils.getWoSObj();
		CustomObject__c oldObj = null;

		Test.startTest();

		CodePrep_after.setInternalStatus(newObj, oldObj);

		Test.stopTest();

		System.assertEquals(null, newObj.InternalStatus__c, 'Did not get the expected status');
	}

	static testMethod void setInternalStatus_noStatusChange() {
		CustomObject__c newObj = TestUtils.getWoSObj();
		CustomObject__c oldObj = TestUtils.getWoSObj();

		Test.startTest();

		CodePrep_after.setInternalStatus(newObj, oldObj);

		Test.stopTest();

		System.assertEquals(null, newObj.InternalStatus__c, 'Did not get the expected status');
	}

	static testMethod void addSurvey_closed() {
		Contact testContact = TestUtils.getContact();
		insert testContact;

		CustomObject__c newObj = TestUtils.getClosedObj(testContact);
		List<CustomSurvey__c> surveyList = new List<CustomSurvey__c>();

		Test.startTest();

		CodePrep_after.addSurvey(newObj, surveyList);

		Test.stopTest();

		System.assertEquals(1, surveyList.size(), 'There should be no survey records added');
		System.assertEquals(testContact.Id, surveyList.get(0).Contact__c, 'Did not get the expected contact');
	}

	static testMethod void addSurvey_notClosed() {
		Contact testContact = TestUtils.getContact();
		CustomObject__c newObj = TestUtils.getWoSObj(testContact);
		List<CustomSurvey__c> surveyList = new List<CustomSurvey__c>();

		Test.startTest();

		CodePrep_after.addSurvey(newObj, surveyList);

		Test.stopTest();

		System.assertEquals(0, surveyList.size(), 'There should be no survey records added');
	}

	static testMethod void beforeHandler_WoS() {
		CustomObject__c testObj = TestUtils.getWoCObj();
		insert testObj;

		CustomObject__c oldObj = testObj.clone(true, false, true, true);

		testObj.Status__c = CodePrep_after.WAITING_ON_SUPPORT;

		List<CustomObject__c> newObjs = new List<CustomObject__c> { testObj };
		Map<Id, CustomObject__c> oldMap = new Map<Id, CustomObject__c> { oldObj.Id => oldObj };

		System.assertEquals(null, newObj.InternalStatus__c, 'The internal status should not be set');

		Test.startTest();

		CodePrep_after.beforeHandler(newObjs, oldMap);

		Test.stopTest();

		System.assertEquals(CodePrep_after.WAITING_ON_SUPPORT, testObj.InternalStatus__c, 'The internal status should have changed');
	}

	static testMethod void beforeHandler_WoC() {
		CustomObject__c testObj = TestUtils.getWoSObj();
		insert testObj;

		CustomObject__c oldObj = testObj.clone(true, false, true, true);

		testObj.Status__c = CodePrep_after.WAITING_ON_CUSTOMER;

		List<CustomObject__c> newObjs = new List<CustomObject__c> { testObj };
		Map<Id, CustomObject__c> oldMap = new Map<Id, CustomObject__c> { oldObj.Id => oldObj };

		System.assertEquals(null, newObj.InternalStatus__c, 'The internal status should not be set');

		Test.startTest();

		CodePrep_after.beforeHandler(newObjs, oldMap);

		Test.stopTest();

		System.assertEquals(CodePrep_after.WAITING_ON_CUSTOMER, testObj.InternalStatus__c, 'The internal status should have changed');
	}

	static testMethod void beforeHandler_survey() {
		Contact testContact = TestUtils.getContact();
		insert testContact;

		CustomObject__c testObj = TestUtils.getClosedObj(testContact);

		List<CustomObject__c> newObjs = new List<CustomObject__c> { testObj };
		Map<Id, CustomObject__c> oldMap = new Map<Id, CustomObject__c>();

		List<CustomSurvey__c> results = TestUtils.fetchAllSurveys();

		System.assertEquals(null, newObj.InternalStatus__c, 'The internal status should not be set');
		System.assertEquals(0, results.size(), 'There should be no surveys yet');

		Test.startTest();

		CodePrep_after.beforeHandler(newObjs, oldMap);

		Test.stopTest();

		List<CustomSurvey__c> results = TestUtils.fetchAllSurveys();

		System.assertEquals(null, newObj.InternalStatus__c, 'The internal status should not be set');
		System.assertEquals(1, results.size(), 'There should be a survey');
		System.assertEquals(testContact.Id, results.get(0).Contact__c, 'The contact was not set correctly');
	}
}