trigger OrderTrigger on Order (before update) 
{
    Map<Id, Order> o = new Map<Id, Order>();
    List<Id> ordersIdToCheck = new List<Id>();
    o = trigger.oldMap;

    for(Order n : trigger.new)
    {
        Order old = new Order();
        old = o.get(n.Id);
        if(old.Status == 'Draft' && n.Status ==  'Active')
        {
            ordersIdToCheck.add(n.Id);
        }
    }
    SF_Order01.checkOrders(ordersIdToCheck);
}