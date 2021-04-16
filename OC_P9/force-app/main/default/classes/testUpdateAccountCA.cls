@isTest
private class testUpdateAccountCA {

    @isTest 
    static void testUpdateCA() {
        Account acc1 = new Account(Name = 'Test Account 1');
        insert acc1;

        Product2 pd1 = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
        Insert pd1;
 
        //Create the PricebookEntry
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = pd1.Id,
            UnitPrice = 1020,
            IsActive = true
        );
        Insert pbe;

        Order o1 = new Order(AccountId = acc1.Id);
        insert o1;

        OrderItem oi1 = new OrderItemItem (OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 150);
        OrderItem oi2 = new OrderItemItem (OrderId = o1.Id, PricebookEntryId = pbe.Id, Quantity=20, UnitPrice = 1000);
        List<OrderItem> orderItems = {oi1, oi2};
        insert orderItems;   

        Account acc = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Name ='Test Account 1' LIMIT 1];
        System.assertEquals(acc.Chiffre_d_affaire__c, 21500);
    }

}
