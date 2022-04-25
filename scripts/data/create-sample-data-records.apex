DELETE [SELECT ID FROM ACCOUNT WHERE Name='Acct'];
DELETE [SELECT ID FROM CONTACT WHERE LastName='contact1'];
DELETE [SELECT ID FROM PRODUCT2];
DELETE [SELECT ID FROM PRICEBOOKENTRY];
DELETE [SELECT ID FROM ORDER];

//For Creating Account Record.
Account newAcct = new Account();
newAcct.BillingCity = 'THOMASTOWN';
newAcct.BillingStreet = '241-243 High Street';
newAcct.BillingState = 'VIC';
newAcct.BillingPostalCode = '3074';
newAcct.Phone='9876543210';
newAcct.Name = 'Acct';
Insert newAcct;
        
//For Creating Contact Record.
Contact cont = new Contact();
cont.AccountId = newAcct.Id;
cont.LastName ='contact1';
Insert cont;
        
//For Creating Product Records.
List<Product2> productsList = new List<Product2>();
for(Integer i=0;i<=100;i++){
Product2 prod = new Product2();
    prod.Name = 'Product'+i;
    prod.ProductCode = String.valueof(i);
    prod.Family = 'Test Practices';
    prod.IsActive = true;
    productsList.add(prod);
}
Insert productsList;
        
// Standard PriceBook.
Pricebook2 standardPricebook = [SELECT ID FROM Pricebook2 WHERE ISSTANDARD = True LIMIT 1];
        
//For Creating PriceBookEntries.
List<PricebookEntry> pbeList = new List<PricebookEntry>();
for(Integer i=0;i<=100;i++){
    PricebookEntry pbe = new PricebookEntry();
    pbe.Pricebook2Id = standardPricebook.Id;
    pbe.Product2Id = productsList[i].Id;
    pbe.UnitPrice = 10;
    pbe.IsActive = true;
    pbeList.add(pbe);
}
Insert pbeList;
        
//For Creating Order.
List<Order> orderList = new List<Order>();
for(Integer i=0;i<=1000;i++) {
    Order o = new Order();
    o.AccountId = newAcct.Id;
    o.Status = 'Draft';
    o.Pricebook2Id = standardPricebook.Id;
    o.EffectiveDate = Date.newInstance(2016, 12, 9);
    orderList.add(o);
}
Insert orderList;

//For Creating OrderItems.
List<Order> activateOrders = new List<Order>();
List<OrderItem> orderItemList = new List<OrderItem>();
for(Order o : orderList) {
    o.Status = 'Activated';
    for(Integer i=0;i<math.roundToLong(math.random()*10)+1;i++) {
        Integer productIndex = (Integer)math.roundToLong(math.random()*100);
        OrderItem oItem = new OrderItem();
        oItem.OrderId = o.Id;
        oItem.UnitPrice = pbeList[productIndex].UnitPrice;
        oItem.Quantity = math.roundToLong(math.random()*10)+1;
        oItem.PricebookEntryId = pbeList[productIndex].Id;
        oItem.Product2Id = pbeList[productIndex].Product2Id;
        orderItemList.add(oItem);

    }
    activateOrders.add(o);

}

insert orderItemList;
update activateOrders;