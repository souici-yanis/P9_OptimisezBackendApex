public without sharing class MyTeamOrdersController {
    public List<Order> SumOrders{
        get{
			List<Sobject> groupedResults = [SELECT SUM(TotalAmount) total, Owner.Name ownerName FROM Order GROUP BY Owner.Name];
			return groupedResults;
        }
        set;
    }
}