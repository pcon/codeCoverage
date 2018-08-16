public class CodePrep_after {
	public static String WAITING_ON_SUPPORT = 'Waiting on Support';
	public static String WAITING_ON_CUSTOMER = 'Waiting on Customer';
	public static String CLOSED = 'Closed';

	public static Boolean isWoS(CustomObject__c obj) {
		return obj.Status__c == WAITING_ON_SUPPORT;
	}

	public static Boolean isWoC(CustomObject__c obj) {
		return obj.Status__c == WAITING_ON_CUSTOMER;
	}

	public static Boolean isClosed(CustomObject__c obj) {
		return obj.Status__c == CLOSED
	}

	public static Boolean hasStatusChanged(CustomObject__c obj, CustomObject__c oldObj) {
		return obj.Status__c != oldObj.Status__c;
	}

	public static void setInternalStatus(CustomObject__c obj, CustomObject__c oldObj) {
		if (oldObj == null) {
			return;
		}

		if (!hasStatusChanged(obj, oldObj)) {
			return;
		}

		String internalStatus = null;

		if (isWoS(obj)) {
			internalStatus = WAITING_ON_SUPPORT;
		}

		if (isWoC(obj)) {
			internalStatus = WAITING_ON_CUSTOMER;
		}

		if (internalStatus == null) {
			return;
		}

		obj.InternalStatus__c = internalStatus;
	}

	public static void addSurvey(CustomObject__c obj, List<CustomSurvey__c> surveyList) {
		if (!isClosed(obj)) {
			return;
		}

		surveyList.add(new CustomSurvey__c( Contact__c = obj.Contact__c ));
	}

	public static void beforeHandler(List<CustomObject__c> newObjs, Map<Id, CustomObject__c> oldMap) {
		List<CustomSurvey__c> surveyList = new List<CustomSurvey__c>();

		for (CustomObject__c obj : newObjs) {
			setInternalStatus(obj, oldMap.get(obj.Id));
			addSurvey(obj, surveyList);
		}

		insert surveyList;
	}
}