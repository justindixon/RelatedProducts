/**
 * @author Justin Dixon
 * @date 22-04-2022
 * @description Holds the request and results format and invocable action
 * to return the top 5 related products
 */
@SuppressWarnings('PMD.ApexCRUDViolation')
public without sharing class FrequentlyBoughtTogether {
  /**
   * @description invokes the frequently bought together invocable action
   * @param choosenProducts the input Product2 Id
   * @return the top 5 results of Product records
   * @example
   * Product2 prod = new Product2(name='Product');
   * List<Request> requests = new List<Request>();
   * Request request = new Request();
   * requests.add(request);
   * List<Results> results = freqProds(requests);
   * List<Product2> prods = results[0].frequentProducts;
   */
  @SuppressWarnings('PMD.OperationWithLimitsInLoop')
  @InvocableMethod(
    label='Get Frequently Bought Together Products'
    description='Returns 5 Product2 Ids And Their Purchased Together Frequencies'
  )
  public static List<Result> freqProds(Request[] choosenProducts) {
    List<Result> results = new List<Result>();
    Integer limitCalculation = 49500 / choosenProducts.size();
    for (Request rqt : choosenProducts) {
      List<OrderItem> purchasedOrders = [
        SELECT OrderId
        FROM OrderItem
        WHERE Product2Id = :(Id) rqt.Product2Id AND Quantity > 0
        ORDER BY Order.EffectiveDate DESC
        LIMIT :limitCalculation
      ];
      Set<Id> uniOrders = new Set<Id>();
      for (OrderItem oi : purchasedOrders) {
        uniOrders.add(oi.OrderId);
      }
      AggregateResult[] aggresult = [
        SELECT Product2Id, Count(Id) countId
        FROM OrderItem
        WHERE
          Quantity > 0
          AND OrderId = :uniOrders
          AND Order.Status = 'Activated'
        GROUP BY Product2Id
        ORDER BY Count(Id) DESC
        LIMIT 5
      ];
      Set<Id> productIds = new Set<Id>();
      for (AggregateResult ar : aggresult) {
        productIds.add((Id) ar.get('Product2Id'));
      }
      List<Product2> frequencyProducts = [
        SELECT FIELDS(STANDARD), D_Brand2__c, D_Product_Image__c
        FROM Product2
        WHERE Id = :productIds
        LIMIT 5
      ];
      Result singleResult = new Result();
      singleResult.frequentProducts = frequencyProducts;
      results.add(singleResult);
    }
    return results;
  }

  /**
   * @author Justin Dixon
   * @date 22-04-2022
   * @description List of Products
   */
  public class Result {
    @InvocableVariable(
      label='Frequent Products'
      description='Products Bought Together'
    )
    public List<Product2> frequentProducts;
  }

  /**
   * @author Justin Dixon
   * @date 22-04-2022
   * @description Product2 Id for input
   */
  public class Request {
    @InvocableVariable(label='Product2Id' description='Input Product2 Id')
    public Id product2Id;
  }
}
