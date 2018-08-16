public class CodePrep_before {
	public static void beforeHandler(List<CustomObject__c> newObjs, Map<Id, CustomObject__c> oldMap) {
		List<CustomSurvey__c> surveyList = new List<CustomSurvey__c>();

		for (CustomObject__c obj : newObjs) {
			if (
				oldMap.containsKey(obj.Id) &&
				(
					oldMap.get(obj.Id).Status__c == 'Waiting on Support' &&
					obj.Status__c != oldMap.get(obj.Id).Status__c
				)
			) {
				obj.Internal_Status__c = 'Waiting on Support';
			} else if (
				oldMap.containsKey(obj.Id) &&
				(
					oldMap.get(obj.Id).Status__c == 'Waiting on Customer' &&
					obj.Status__c != oldMap.get(obj.Id).Status__c
				)
			) {
				obj.Internal_Status__c = 'Waiting on Customer';
			}

			if (obj.Status__c == 'Closed') {
				CustomSurvey__c survey = new CustomSurvey__c(
					Contact__c = obj.Contact__c
				);
				surveyList.add(survey);
			}
		}

		insert surveyList;
	}
}