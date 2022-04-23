/**
 * @author Justin Dixon
 * @date 22-04-2022
 * @description Accepts a single Id, which should be Product2 Id. Invokes the
 * frequentlyBoughtTogether Invocable Action and returns a list of Products frequently
 * bought with the input Product2 Id.
 */
public with sharing class FreqProdImgCarouselController {
  /**
   * @description invokes the frequently bought together invocable action
   * @param product2Id the input Product2 Id
   * @return the top 5 results of Product records
   * @example
   * Product2 prod = new Product2(name='ProductA');
   * List<Product2> relProds = getFrequentProducts(prod.Id);
   */
  @AuraEnabled(cacheable=true)
  public static List<Product2> getFrequentProducts(Id product2Id) {
    List<FrequentlyBoughtTogether.request> rqts = new List<FrequentlyBoughtTogether.request>();
    FrequentlyBoughtTogether.request rqt = new FrequentlyBoughtTogether.request();
    rqt.Product2Id = product2Id;
    rqts.add(rqt);
    List<FrequentlyBoughtTogether.Result> rslts = FrequentlyBoughtTogether.freqProds(
      rqts
    );
    List<Product2> rsltsProducts = rslts[0].frequentProducts;
    return rsltsProducts;
  }
}
