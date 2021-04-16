trigger UpdateAccountCA on Order (after update) {
    Map<ID, Account> parentAccts = new Map<ID, Account>(); 
    List<Id> listAccIds = new List<Id>();

    for (Order oi : Trigger.new) {
        listAccIds.add(oi.AccountId);
    }

    parentAccts = new Map<Id, Account>([SELECT Id, Chiffre_d_affaire__c, (SELECT ID, TotalAmount FROM Orders) FROM Account WHERE ID IN :listAccIds]);

    for (Order con: Trigger.new){
        Account myParentAcc = parentAccts.get(con.AccountId);
        myParentAcc.Chiffre_d_affaire__c = myParentAcc.Chiffre_d_affaire__c + con.TotalAmount;
    }

    update parentAccts.values();
}