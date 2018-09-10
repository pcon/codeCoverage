public class Now_after {
	@TestVisible
	private static Datetime NOW {
		get {
			if (NOW == null) {
				NOW = Datetime.now();
			}

			return NOW;
		}
		private set;
	}

	public static void setLastPublicUpdateToNow(Case c) {
		c.LastPublicUpdate__c = NOW;
	}
}