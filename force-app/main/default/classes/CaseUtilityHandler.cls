public class CaseUtilityHandler {
    
   public static void UpdateEmailOnCase(List<Case>caseList) {
        Set<Id>accIds = new Set<Id>();
        Set<String>accqueue = new Set<String>();
        for(Case cs:caseList){ 
            if(cs.AccountId != null){
                accIds.add(cs.AccountId);  
            }
        }
        List<Account> acclist = [Select Id, Corporate_Route__c FROM Account WHERE Id IN: accIds AND Corporate_Route__c != null];
        for(Account acc:acclist){
            if(acc.Corporate_Route__c != null){
                accqueue.add(acc.Corporate_Route__c);
                System.debug('======== '+acc.Corporate_Route__c);
            }
        }
        if(acclist.size()>0){
            List<Account_Clarification_Team__c>actlist = [Select Id, Name, From_Email__c FROM Account_Clarification_Team__c WHERE Name IN:accqueue];
            if(actlist.size()>0){
                for(Account_Clarification_Team__c act:actlist){
                    for(Case c:caseList){
                        if(c.AccountId != null && c.RecordTypeId == Schema.SObjectType.Case.getRecordTypeInfosByName().get('Case').getRecordTypeId()){
                            c.Customer_To_Email__c = act.From_Email__c;
                            System.debug('============== '+c.Customer_To_Email__c);
                        }
                    } 
                }
            }
        }
    }

}