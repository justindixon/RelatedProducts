public with sharing class productCorrelationBatchCalculation {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Id, ProductCode From Product2 LIMIT 1'
        );
    }
    public void execute(Database.BatchableContext bc, List<Product2> scope){
        Product2 prod = scope[0];
        List<frequentlyBoughtTogether.request> rqts = new List<frequentlyBoughtTogether.request>();
        frequentlyBoughtTogether.request rqt = new frequentlyBoughtTogether.request();
        rqt.Product2Id = prod.Id;
        rqts.add(rqt);
        List<frequentlyBoughtTogether.Result> rslts =frequentlyBoughtTogether.frequentlyBoughtTogether(rqts);
        List<Product2> relProds = rslts[0].frequentProducts;

        update prod;
    }

    public void finish(Database.BatchableContext bc){
        System.debug('Batch Product Correlation Finished');
    }
}
