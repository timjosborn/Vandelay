public class OrderController {
    public ApexPages.StandardController CC {get; set;}
    public String newLast {get; set;}
    public String newFirst {get; set;} 
    public List<WrapContact> wrapContactList { get; set;}
    public List<Contact> selectedContacts { get; set;}        
           
    public OrderController() {                              
        selectedContacts = new List<Contact>();         
    }

    public void Wrap() {
        wrapContactList =new list<WrapContact>();
        if (con != null) {
            for(Contact c:con) {
                wrapContactList.add(new WrapContact(c));          
            }
        }                           
    }

    public PageReference step1() {
        return Page.order;
    }

    public PageReference step2() {
        selectedRecords();               
        return Page.orderPage2;
    }
    
    public void selectedRecords(){
        selectedContacts =new List<Contact>();     
        for(WrapContact wra : wrapContactList){
            if(wra.isSelected == true){
            selectedContacts.add(wra.wcn);
            }                 
        }
    }
    public PageReference create() {
        return Page.orderPage3; 
    } 
    public PageReference cancel() {
        searchKey = null;
        wrapContactList = null;
        return Page.order; 
    } 

    public Pagereference saveAndNew() {  
        upsert selectedContacts;
        return Page.orderPage4;
        //Save();
        //String str = ApexPages.currentPage().getUrl().subStringAfter('/');
        //return new PageReference('/apex/' + str).setRedirect(true);
        }

    public PageReference saveCon() { 
        Contact nc = new Contact();
        nc.FirstName = newFirst;
        nc.LastName = newLast;    
        try {
            insert(nc);
            } catch(System.DMLException e) {
            ApexPages.addMessages(e);
            return null;
        }
        return Page.orderPage4;   
    }

    public class WrapContact {    
        public Contact wcn {get;set;}
        public boolean isSelected {get;set;}
        public WrapContact(Contact b){     
            wcn=b;
            isselected=false;
        }
    }
    public list <Contact> con {get;set;}
    public String searchKey {get;set;}
    public void search(){
        string searchquery = 'SELECT FirstName, LastName, Account.Name, MailingStreet, MailingCity, MailingState, MailingPostalCode, Email, Phone, id FROM Contact WHERE Name LIKE \'%'+searchKey+'%\' ';
        con= Database.query(searchquery);
        Wrap();
    } 
}