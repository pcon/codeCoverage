public class UnknownException_before {
	public void insertObjects(List<CustomObject__c> objs) {
		try {
			insert objs;
		} catch (Exception e) {
			ApexPages.Message.addMessage(new ApexPages.Message('OH NOES'));
		}
	}
}