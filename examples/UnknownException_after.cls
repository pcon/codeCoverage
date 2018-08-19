public class UnknownException_after {
	public static String UNHANDLED_PREFIX = 'OH NOES ';
	public static String TEST_EXCEPTION = 'Exception for testing';
	public static Boolean THROW_EXCEPTION = false;
	public class UnhandledException extends Exception {}

	public static void generateExceptionForTesting() {
		if (Test.isRunningTest() && THROW_EXCEPTION) {
			throw new UnhandledException(TEST_EXCEPTION);
		}
	}

	public static void riskyBusiness(List<CustomObject__c> objs) {
		try {
			doRiskyOperation(objs);
		} catch (Exception e) {
			ApexPages.Message.addMessage(new ApexPages.Message(UNHANDLED_PREFIX + e.getMessage()));
		}
	}
}