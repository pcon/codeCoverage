public class Now_before {
	public static void setLastPublicUpdateToNow(Case c) {
		c.LastPublicUpdate__c = Datetime.now();
	}
}