# Frequently Bought Together Products for Salesforce

[![Build](https://github.com/justindixon/RelatedProducts/actions/workflows/build.yml/badge.svg)](https://github.com/jongpie/NebulaLogger/actions/workflows/build.yml)
[![codecov](https://codecov.io/gh/justindixon/RelatedProducts/branch/main/graph/badge.svg?token=ERQTH8T0N7)](https://codecov.io/gh/justindixon/RelatedProducts)

Top 5 Products Frequently Bought Together

## Unlocked Package - v1.0.0

[![Install Unlocked Package in a Sandbox](./images/btn-install-unlocked-package-sandbox.png)](https://test.salesforce.com/packaging/installPackage.apexp?p0=04t5i000000cIlvAAE)
[![Install Unlocked Package in Production](./images/btn-install-unlocked-package-production.png)](https://login.salesforce.com/packaging/installPackage.apexp?p0=04t5i000000cIlvAAE)

<!--[![View Documentation](./images/btn-view-documentation.png)](https://justindixon.github.io/RelatedProducts/)-->

<!--
## Managed Package - v1.0.0

[![Install Managed Package in a Sandbox](./images/btn-install-managed-package-sandbox.png)](https://test.salesforce.com/packaging/installPackage.apexp?mgd=true&p0=)
[![Install Managed Package in Production](./images/btn-install-managed-package-production.png)](https://login.salesforce.com/packaging/installPackage.apexp?mgd=true&p0=)
-->
<!--[![View Milestone](./images/btn-view-managed-package-milestone.png)](https://github.com/justindixon/RelatedProducts/milestone/1)-->

---

## Features

1. Lightning Web Component showing frequently bought together products.
2. Flow Action available to return the top 5 frequently bought products.
3. Works only with Order Products for now.

## Road Map

1. Enable For Opportunity Products.
2. Enable for CPQ Quote Line Products.
3. Units Tests for LWC.
4. Enable additional file types (other than .jpq).
5. Custom Object to hold the top 5 related products.
6. Scheduled Batch Job to maintain the top 5 related products every night.
7. Image resizing functionality.
8. Completely custom build the carousel component. (Salesforce's is a bit limited, and hard to change).

---

## Getting Started

After deployment, assign permission set `Related Products Viewer` to users. Provides access to view the lightning component.

### Image Upload

Images need to be sized into the dimensions you require. Recommended is 240x320.

Images need to be uploaded as Content Assets.

![Content Assets File Library](./images/content-assets-location.png)
![Upload Button](./images/upload-content-asset-button-location.png)

The name of the Content Asset must match the Product Code that you want the image to display for.

![File Details](./images/upload-content-asset-screen.png)

---

### Related Products Lightning Components: Quick Start

---

### Related Products Flow Action: Quick Start

![Flow Action](./images/flow-action.png)

In your Flow you must input a single Product2 record Id. The top 5 most frequently bought products to the input Product will be returned as a list of Products.

---

### Related Products Apex Class: Quick Start

You can call the class through Apex:

```
List<FrequentlyBoughtTogether.request> rqts = new List<FrequentlyBoughtTogether.request>();FrequentlyBoughtTogether.request rqt = new FrequentlyBoughtTogether.request();
rqt.Product2Id = product2Id;
rqts.add(rqt);
List<FrequentlyBoughtTogether.Result> rslts = FrequentlyBoughtTogether.freqProds(rqts);
List<Product2> rsltsProducts = rslts[0].frequentProducts;
```

---
