public with sharing class NewContactPageController {
	//http://www.sfdcpoint.com/salesforce/immediate-attribute-commandbutton-commandlink-visualforce/
    //https://developer.salesforce.com/forums/?id=906F0000000B5g4IAC
    public Contact newContact {get;set;}
    
    //--------------------------------------------------------------------------------------------------
    //Конструктор по умолчанию + Подключение контроллера
    public NewContactPageController(ApexPages.StandardController controller){
		newContact = (Contact)controller.getRecord();
    }
    //Конструктор по умолчанию + Подключение контроллера
    //--------------------------------------------------------------------------------------------------
    
    //--------------------------------------------------------------------------------------------------
    //Функция нажаитя кнопки Save
    public PageReference save() {
    	insert newContact;
        return Catalog();
    }
    //Функция нажаитя кнопки Save
    //--------------------------------------------------------------------------------------------------
    
    //--------------------------------------------------------------------------------------------------
    //Функция нажаитя кнопки Cancel
    public PageReference cancel() {
         return Catalog();
    }
    //Функция нажаитя кнопки Cancel
    //--------------------------------------------------------------------------------------------------
    
    //--------------------------------------------------------------------------------------------------
    //Функция возвращения на старницу Сatalog
   	public PageReference Catalog(){
     	PageReference backPage = new PageReference('/apex/Catalog');
        return backPage;
    }
    //Функция возвращения на старницу Сatalog
    //--------------------------------------------------------------------------------------------------

}