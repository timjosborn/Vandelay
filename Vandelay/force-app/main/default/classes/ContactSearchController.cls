public class ContactSearchController {
public list <Contact> con {get;set;}
    public String searchKey {get;set;}
    public ContactSearchController( ) {
    }

    public void search(){
        string searchquery='select FirstName, LastName, Account.Name, MailingStreet, MailingCity, MailingState, MailingPostalCode, Email, Phone, id from Contact where name like \'%'+searchKey+'%\' Limit 10';
        con= Database.query(searchquery);
    }

    public void clear(){
        con.clear();
    }
}