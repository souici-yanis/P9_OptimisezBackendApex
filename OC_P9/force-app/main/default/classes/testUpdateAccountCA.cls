@isTest
private class testUpdateAccountCA {

    //TEST SETUP 
    @testSetup static void setup() {
        Account acc1 = new Account(Name = 'Test Account 1');
        insert acc1;

        Product2 pd1 = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
        insert pd1;
 
        //Create the PricebookEntry
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = pd1.Id,
            UnitPrice = 1020,
            IsActive = true
        );
        insert pbe;

        Date todayDate = Date.today(); 
        Order o1 = new Order(AccountId = acc1.Id, Pricebook2Id  = pbe.Pricebook2Id, Status='Draft', EffectiveDate=todayDate);
        insert o1;
        
        OrderItem oi1 = new OrderItem (OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 150);
        OrderItem oi2 = new OrderItem (OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=20, UnitPrice = 1000);
        insert oi1;   
        insert oi2;   
    }

    @isTest 
    static void testUpdateCA() {
        Account acc = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Name ='Test Account 1' LIMIT 1];
        System.assertNotEquals(acc.Chiffre_d_affaire__c, 21500, 'Chiffre affaire incorrecte');

        Order o1 = [SELECT Id, Status FROM Order WHERE AccountId = :acc.Id LIMIT 1];
        o1.Status = 'Ordered';
        update o1;
        
        Account accAfterOrder = [SELECT Id, (Select Status FROM Orders), Chiffre_d_affaire__c FROM Account WHERE Name ='Test Account 1' LIMIT 1];
        System.assertEquals(accAfterOrder.Chiffre_d_affaire__c, 21500, 'Chiffre affaire incorrecte');
    }
}

