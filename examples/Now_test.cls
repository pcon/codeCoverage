@IsTest
public class Now_test {
	static testMethod void setLastPublicUpdateToNow_valid() {
		Datetime NOW = Datetime.newInstance(2018, 7, 29, 7, 28, 0);
		Now_after.NOW = NOW;

		Case testCase = TestUtils.getCase();

		Test.startTest();

		Now_after.setLastPublicUpdateToNow(testCase);

		Test.stopTest();

		System.assertEquals(NOW, testCase.LastPublicUpdate__c, 'Did not get the expected date');
	}
}