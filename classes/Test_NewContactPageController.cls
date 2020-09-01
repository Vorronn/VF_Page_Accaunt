@isTest
public class Test_NewContactPageController {
        
    @isTest
    static void NewContactSave(){

		Contact newContact = new Contact(Lastname='lastname' , Email = 'bugfixes@mail.ru');
        ApexPages.StandardController defaultStandardController = new ApexPages.StandardController(newContact);
        NewContactPageController control = new NewContactPageController(defaultStandardController);
        control.save();
        List<Contact> contactList = [Select id, lastname FROM Contact where Lastname=:newContact.LastName];
        System.assertEquals(1, contactList.size());
    }
    @isTest
    static void NewContactCancel(){

		Contact newContact = new Contact(Lastname='lastname' , Email = 'bugfixes@mail.ru');
        ApexPages.StandardController defaultStandardController = new ApexPages.StandardController(newContact);
        NewContactPageController control = new NewContactPageController(defaultStandardController);
        control.cancel();
        List<Contact> contactList = [Select id, lastname FROM Contact where Lastname=:newContact.LastName];
        System.assertEquals(0, contactList.size());
    }
        
}