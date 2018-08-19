@isTest
public class UnknownException_Test {
	static testMethod void riskyBusiness_negative() {
		Exception_after.THROW_EXCEPTION = true;

		Test.startTest();

		Exception_after.riskyBusiness(new List<CustomObject__c>());

		Test.stopTest();

		System.assertEquals(1, ApexPages.Messages.size(), 'Should have an error message');
		String expectedMessage = Exception_after.UNHANDLED_PREFIX + Exception_after.TEST_EXCEPTION;
		System.assertEquals(expectedMessage, ApexPages.Messages.get(0).getSummary(), 'Did not get the expected summary');
	}
}