trigger Contact on Contact (after insert, before delete ) {
    if (trigger.isInsert){
        
        List<Case> newCase = new List<Case>();
        Set<Id> acc = new Set<Id>();
        for(Contact cnt : trigger.new){
            if(cnt.AccountId != null){
                acc.add(cnt.AccountId);
                }
        }
        
        Map<Id,Account> mapAccountId = new Map<Id,Account>([SELECT Id, OwnerId FROM Account WHERE Id IN :acc]);
        
        for(Contact cnt : trigger.new){
            string prior;
            if(cnt.Contact_Level__c == 'primary') {
                prior = 'High';
            } else if (cnt.Contact_Level__c == 'secondary') {
                prior = 'Medium';
            } else if (cnt.Contact_Level__c == 'tertiary') {
                prior = 'Low';
            } else if (cnt.Contact_Level__c == null) {
                prior = '';
            } 
            newCase.add(new Case(ContactId = cnt.Id, OwnerId = (cnt.AccountId!=null)? mapAccountId.get(cnt.AccountId).OwnerId : cnt.OwnerId, Status = 'Working', Origin = 'New Contact', Priority = prior));
        }
        if(newCase != null){   
        insert newCase;
        }    
        
    } else if (trigger.isDelete) {
       	List<Case> deleteCase = new List<Case>();
        for(Contact cnt: trigger.old){
            deleteCase= [SELECT Id, ContactId FROM Case]; 
        }
        if(deleteCase != null){
     		delete deleteCase;  
        }
    }
}