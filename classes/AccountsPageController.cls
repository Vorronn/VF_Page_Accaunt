public class AccountsPageController {
    public List<Contact> contactList {get;set;} 					//База данных контактов
    public String valueSearchString {get;set;}						//Значение строки поиска
    public Integer currentPageNumber {get;set;}						//Номер текущей страницы
    public Integer totalNumberPages {get;set;}						//Общее количество страниц
    public Integer numberRowsPerPageFromSelect {get;set;}			//Количество значений на странице получение из Select
    public List<SelectOption> selectNumberRowsPerPage {get;set;}	//Выпадающий список количества записей на странице
    public String typeSorting {get;set;}							//Начальный тип сортировки
    public String columnName {get;set;} 							//Значение имени колонки для сортировки
    public String currentNameColumn {get;set;}						//Текущее значение колонки
    public String contactId {get;set;} 								//id контакта для удаления
    
    //--------------------------------------------------------------------------------------------------
    //Конструктор по умолчанию
    public AccountsPageController () {
    	
      	columnName = 'Name';
        typeSorting = 'ASC';
        currentNameColumn = columnName;
        valueSearchString = '';
        currentPageNumber = 1;
        selectNumberRowsPerPage = new List<SelectOption>{
            new SelectOption('10','10'),
            new SelectOption('25','25'),
            new SelectOption('50','50')
        };
        
    	numberRowsPerPageFromSelect = Integer.valueOf(selectNumberRowsPerPage.get(0).getValue());
        getNumberOfPage();
        getContactList();
        
    }
    //Конструктор по умолчанию
    //--------------------------------------------------------------------------------------------------
 
    //--------------------------------------------------------------------------------------------------
    //Функция получения списка
    public void getContactList(){
        contactList = new List<Contact>();
        // если ввели неподходящее имя добавлено во время тестов
        if(totalNumberPages==0){
            contactList =Database.query('SELECT Id, Name, Email, Contact_Level__c, AccountId, OwnerId, CreatedById, CreatedDate' + 
                                     ' FROM Contact'+
                                     ' WHERE firstName like \'%'+valueSearchString+'%\' OR lastName like \'%'+valueSearchString+'%\' '+ 
                                     ' ORDER BY '+ columnName + ' ' + typeSorting +
                                     ' LIMIT ' + numberRowsPerPageFromSelect +
                                     ' OFFSET '+ 0);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING,'No records found'));
            
        } else{
        	contactList = Database.query('SELECT Id, Name, Email, Contact_Level__c, AccountId, OwnerId, CreatedById, CreatedDate' + 
                                     ' FROM Contact'+
                                     ' WHERE firstName like \'%'+valueSearchString+'%\' OR lastName like \'%'+valueSearchString+'%\' '+ 
                                     ' ORDER BY '+ columnName + ' ' + typeSorting +
                                     ' LIMIT ' + numberRowsPerPageFromSelect +
                                     ' OFFSET '+ numberRowsPerPageFromSelect*(currentPageNumber - 1));
            }
    }
    //Функция получения списка
    //--------------------------------------------------------------------------------------------------
      
    //--------------------------------------------------------------------------------------------------
    //Определение количества страниц в соотвествии с пагинацией
    public void getNumberOfPage() {
        contactList = new List<Contact>();
        Integer contactList = Database.countquery('SELECT count() '+ 'FROM Contact'+
                                     ' WHERE firstName like \'%'+valueSearchString+'%\' OR lastName like \'%'+valueSearchString+'%\' ');
        if(((contactList/numberRowsPerPageFromSelect)*numberRowsPerPageFromSelect) == contactList){
            totalNumberPages = contactList/numberRowsPerPageFromSelect;
        } else {
            totalNumberPages = contactList/numberRowsPerPageFromSelect + 1;
        }    
        if(currentPageNumber>totalNumberPages){currentPageNumber=totalNumberPages;}
    }
    //Определение количества страниц в соотвествии с пагинацией
    //--------------------------------------------------------------------------------------------------
    
    //--------------------------------------------------------------------------------------------------
    //Пагинация
    public void pagination(){
        currentPageNumber = 1;
        getNumberOfPage();
        getContactList();
    }
    //Пагинация
    //--------------------------------------------------------------------------------------------------
    
   	//--------------------------------------------------------------------------------------------------
    //Сортировка
    public void sortListName(){
            columnName = 'Name';
            sortList();
    }    
    
    public void sortListEmail(){
        columnName = 'Email';
        sortList();
    }
    
    public void sortListContactLevel(){
        columnName = 'Contact_Level__c';
        sortList();
    }
    
    public void sortListAccountId(){
        columnName = 'AccountId';
        sortList();
    }
    
    public void sortListOwnerId(){
        columnName = 'OwnerId';
        sortList();
    }
    
    public void sortListCreatedById(){
        columnName = 'CreatedById';
        sortList();
    }
    
    public void sortListCreatedDate(){
        columnName = 'CreatedDate';
        sortList();
    }
       
    public void sortList(){
        if(currentNameColumn == columnName){
            if(typeSorting == 'ASC'){
                typeSorting = 'DESC';
            } else {
                typeSorting = 'ASC';
            }
        } else {
            currentNameColumn = columnName;
           	typeSorting = 'ASC';
        }
        currentPageNumber = 1;
        getContactList();  	 
    }
    
    //Сортировка
    //--------------------------------------------------------------------------------------------------
    
    //--------------------------------------------------------------------------------------------------
    //Навигация по странице 
    public void firstButton() {
        if(currentPageNumber > 1){
            currentPageNumber = 1;
            getContactList();
        } else return;
    }
    
    public void previousButton() {
        if(currentPageNumber > 1){
            currentPageNumber -= 1;
            getContactList();
        } else return;
    }
    
    public void nextButton() {
        if(currentPageNumber < totalNumberPages){
            currentPageNumber +=1;
            getContactList();
        } else return;
     }
    
    public void pastButton() {
        if(currentPageNumber < totalNumberPages){
            currentPageNumber = totalNumberPages;
            getContactList();
        } else return;
    }
    //Навигация по странице
    //--------------------------------------------------------------------------------------------------
    
    //--------------------------------------------------------------------------------------------------
    //Удаление контакта 
    public void deleteContact() {
        if(contactId == null){
            return;
        } 
        Contact contactDelete = [SELECT Id FROM contact WHERE Id = :contactId];
        delete contactDelete;
        if(ApexPages.currentPage()!=null){
            	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Contact #'+contactId+' was deleted'));
        }
        getNumberOfPage();
        getContactList();
    }  
    //Удаление контакта 
    //--------------------------------------------------------------------------------------------------
    
    //--------------------------------------------------------------------------------------------------
    //Поиск контакта
    public void searchButton() {
        currentPageNumber = 1;
        getNumberOfPage();
		getContactList();
    }
    //Поиск контакта
    //--------------------------------------------------------------------------------------------------

    //--------------------------------------------------------------------------------------------------
    //Открытие новой страницы
   	public PageReference newContactPage(){
     	PageReference newContact = new PageReference('/apex/NewContactPage');
        return newContact;
    }
    //Открыте новой страницы 
  	//--------------------------------------------------------------------------------------------------           
}