@isTest
public class Test_triggerContact {

    @isTest
    public static void test_LargeContactList(){
        Account defaultAccount = new Account(name = 'Test Account'); 
        insert defaultAccount;
		List<Contact> contactList = new List<Contact>();
        
        for(Integer i=0; i<100; i++){
			contactList.add(new Contact(lastname='Lastname'+i, accountid = defaultAccount.id)); 
        }
        insert contactList;
    }
    
    @isTest 
    public static void test_Cases(){
        Account newAccount = new Account(name='Test Account', OwnerId=UserInfo.getUserId()); 
        insert newAccount;
        Contact newContact = new Contact(Lastname='lastname' , Email = 'bugfixes@mail.ru', Contact_Level__c = 'primary', OwnerId = UserInfo.getUserId(), AccountId = newAccount.Id);
        insert newContact;
        Contact newContact2 = new Contact(Lastname='lastname2' , Email = 'bugfixes2@mail.ru', Contact_Level__c = 'secondary');
        insert newContact2;
        Contact newContact3 = new Contact(Lastname='lastname3' , Email = 'bugfixes3@mail.ru', Contact_Level__c = 'tertiary');
        insert newContact3;
        Contact newContact4 = new Contact(Lastname='lastname4' , Email = 'bugfixes4@mail.ru', Contact_Level__c = '');
        insert newContact4;
        Case newCaseList = [SELECT Id, ContactId, AccountId, Status, Origin, OwnerId, Priority FROM Case WHERE ContactId =:newContact.Id];
        Case newCaseList2 = [SELECT Id, ContactId, AccountId, Status, Origin, OwnerId, Priority FROM Case WHERE ContactId =:newContact2.Id];
        Case newCaseList3 = [SELECT Id, ContactId, AccountId, Status, Origin, OwnerId, Priority FROM Case WHERE ContactId =:newContact3.Id];
        Case newCaseList4 = [SELECT Id, ContactId, AccountId, Status, Origin, OwnerId, Priority FROM Case WHERE ContactId =:newContact4.Id];
        System.assertEquals(newContact.Id, newCaseList.ContactId);
        System.assertEquals(newAccount.Id, newCaseList.AccountId);
        System.assertEquals('Working', newCaseList.Status);
        System.assertEquals('New Contact', newCaseList.Origin);
        System.assertEquals(newAccount.OwnerId, newCaseList.OwnerId);
        System.assertEquals('High', newCaseList.Priority);
        System.assertEquals('Medium', newCaseList2.Priority);
        System.assertEquals('Low', newCaseList3.Priority);
        System.assertEquals(null, newCaseList4.Priority);
    }
    
    @isTest
    public static void test_Delete(){
        Account newAccount = new Account(name='Test Account', OwnerId=UserInfo.getUserId()); 
        insert newAccount;
        Contact newContact = new Contact(Lastname='lastname' , Email = 'bugfixes@mail.ru', Contact_Level__c = 'primary', OwnerId = UserInfo.getUserId(), AccountId = newAccount.Id);
        insert newContact;
        List<Case> newCaseList = [SELECT Id, ContactId, AccountId, Status, Origin, OwnerId, Priority FROM Case WHERE ContactId =:newContact.Id];
        delete newContact;
        newCaseList = [SELECT Id, ContactId, AccountId, Status, Origin, OwnerId, Priority FROM Case WHERE ContactId =:newContact.Id];

        System.assertEquals(0, newCaseList.size());
    }
   
}