@isTest
public class Test_AccountsPageController {
	
    @isTest
    public static void test_Concstructor(){
        Account defaultAccount = new Account(name = 'Test Account'); 
        insert defaultAccount;
		List<Contact> contactList = new List<Contact>();
        
        for(Integer i=0; i<25; i++){
			contactList.add(new Contact(lastname='Lastname'+i, accountid = defaultAccount.id)); 
        }
        insert contactList;
   
        AccountsPageController control = new AccountsPageController();
       
    }
    @testSetup
    public static void setup(){
        Account defaultAccount = new Account(name = 'Test Account'); 
        insert defaultAccount;
        List<Contact> contactList = new List<Contact>();
        
        for(Integer i=0; i<30; i++){
			contactList.add(new Contact(lastname='Lastname'+i, accountid = defaultAccount.id)); 
        }
        insert contactList;       
    }
    
    @isTest
    public static void test_Paginator(){
        AccountsPageController control = new AccountsPageController();
        control.searchButton();
        control.pagination();
        System.assertEquals(3, control.totalNumberPages);
      	}
    
    @isTest
    public static void test_Sorting(){
        AccountsPageController control = new AccountsPageController();
       	control.sortListName();
        System.assertEquals('DESC', control.typeSorting);
        control.sortListName();
        System.assertEquals('ASC', control.typeSorting);
        control.sortListEmail();
        System.assertEquals('ASC', control.typeSorting);
        control.sortListContactLevel();
        System.assertEquals('ASC', control.typeSorting);
        control.sortListAccountId();
        System.assertEquals('ASC', control.typeSorting);
        control.sortListOwnerId();
        System.assertEquals('ASC', control.typeSorting);
        control.sortListCreatedById();
        System.assertEquals('ASC', control.typeSorting);
        control.sortListCreatedDate();
        System.assertEquals('ASC', control.typeSorting); 
    }
    
    @isTest
    public static void test_Navigation(){
        AccountsPageController control = new AccountsPageController();
        control.nextButton();
        System.assertEquals(2, control.currentPageNumber);
        control.nextButton();
        System.assertEquals(3, control.currentPageNumber);
        control.nextButton();
        System.assertEquals(3, control.currentPageNumber);
        control.previousButton();
        System.assertEquals(2, control.currentPageNumber);
        control.firstButton();
        System.assertEquals(1, control.currentPageNumber);
        control.firstButton();
        System.assertEquals(1, control.currentPageNumber);
        control.previousButton();
        System.assertEquals(1, control.currentPageNumber);
        control.pastButton();
        System.assertEquals(control.totalNumberPages, control.currentPageNumber);
        control.pastButton();
        System.assertEquals(control.totalNumberPages, control.currentPageNumber);
    }
    
    @isTest
   		public static void test_searchButton(){
        AccountsPageController control = new AccountsPageController();
        control.valueSearchString = 'Lastname10';
        control.searchButton();
        List<Contact> newList = control.contactList;
        System.assertEquals(1,newList.size());
            
        control.valueSearchString = 'Pupkin';
        control.searchButton();
        newList = control.contactList;
        System.assertEquals(0,newList.size());
    } 
    
    @isTest
    public static void test_delete(){
    	AccountsPageController control = new AccountsPageController();  
        List<Contact> cnt = control.contactList;
        control.contactId = cnt[0].Id;
        control.deleteContact();
        List<Contact> newList = control.contactList;
        System.assertNotEquals(cnt[0], newList[0]);
    }
    
    @isTest
    public static void test_delete2(){
    	AccountsPageController control = new AccountsPageController();  
        List<Contact> cnt = control.contactList;
        control.contactId = null;
        control.deleteContact();
        List<Contact> newList = control.contactList;
        System.assertEquals(cnt[0], newList[0]);    
    }
    
    @isTest
    public static void test_newPage(){
    	AccountsPageController control = new AccountsPageController();
        PageReference page = control.newContactPage();
        System.assertEquals(new PageReference('/apex/NewContactPage').getUrl(), page.getUrl());
    }
   
}