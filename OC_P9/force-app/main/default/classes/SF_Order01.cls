public with sharing class SF_Order01 {
    public static void checkOrders(List<Id> ordersId){   
        List<Order> orders = [SELECT Id, (SELECT Id, OrderItemNumber FROM OrderItems) FROM Order WHERE ID in :ordersId];

        for (Order o : orders) {
            if(o.orderItems.size() == 0) {
                o.addError('An order must have at least one product.');
            }
        }
    }
}
