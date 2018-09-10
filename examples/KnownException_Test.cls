@isTest
public class KnownException_Test {
	static testMethod void positiveTest() {
		Integer i = 10;

		Test.startTest();

		String result = KnownException.myMethod(i);

		Test.stopTest();

		String expectedResult = KnownException.RESULT_STRING + i;

		System.assertEquals(expectedResult, result, 'Wrong result');
	}

	static testMethod void negativeTest() {
		Integer i = 0;

		Test.startTest();

		try {
			String result = KnownException.myMethod(i);
			System.assert(false, 'We should have thrown an exception');
		} catch (KnownException.BadParameterException e) {
			System.assertEquals(
				KnownException.NONZERO_MSG, e.getMessage(),
				'Right exception type, wrong message'
			);
		}

		Test.stopTest();
	}
}