public class KnownException {
	public static String RESULT_STRING = 'Result data: ';
	public static String NONZERO_MSG = 'Parameter must be non-zero';
	public class BadParameterException extends Exception {}

	public static String myMethod(Integer i) {
		if (i == 0) {
			throw new BadParameterException(NONZERO_MSG);
		}

		return RESULT_STRING + i;
	}
}