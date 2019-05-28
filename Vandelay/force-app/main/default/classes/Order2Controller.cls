public class Order2Controller {
    public OpportunityLineItem Row1 = new OpportunityLineItem();
    public OpportunityLineItem Row2 = new OpportunityLineItem();
    public Opportunity Opp {get; set;}
    public Boolean ready {get; set;}
    public Contact Contact { 
        get {
        return [SELECT id, Name, Academic_User__c, AccountId 
                  FROM Contact
                 WHERE id = :ApexPages.currentPage().getParameters().get('conId')];
    }
    Set;
    }

    public Order2Controller(ApexPages.StandardController stdController) {
        ready = false;
        if (Contact.Academic_User__c = true) {
            
           
        }
    }

    public PageReference cancel() {
        
        return Page.order; 
    } 

    public PageReference start() {
        Opportunity Opp = new Opportunity();
        Opp.Name = Contact.Name + '-' + date.today().format();
        Opp.Contact__c = Contact.Id;
        Opp.StageName = 'Closed Won';
        Opp.CloseDate = date.today();
        Opp.AccountId = Contact.AccountId;
        try {insert Opp;}
        catch(DmlException e){
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
        System.debug(Opp.Name);
        ready = true;
        return null;
    } 
    
}