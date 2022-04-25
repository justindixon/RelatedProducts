import { LightningElement, api } from "lwc";
import {NavigationMixin} from "lightning/navigation";
import getFrequentProducts from "@salesforce/apex/FreqProdImgCarouselController.getFrequentProducts";


export default class FreqProdImgCarousel extends NavigationMixin(LightningElement) {
  @api recordId;
  product;
  products;
  error;
  rendered = false;

  
  navigateToViewProductPage(event) {
    const product2Id = event.currentTarget.getAttribute("data-id");
    console.log(product2Id);
    this[NavigationMixin.Navigate]({
        type: 'standard__recordPage',
        attributes: {
            recordId: product2Id,
            objectApiName: 'Product2',
            actionName: 'view'
        },
    });
  }
  
  generateProductCode(productCode) {
    console.log(productCode);
    return isNaN(productCode) ? productCode : "X" + productCode;
  }

  renderedCallback() {
    if (!this.rendered) {
      this.rendered = true;
      getFrequentProducts({ product2Id: this.recordId })
        .then((result) => {
          let results = [];
          for (let i = 0; i < result.length; i++) {
            results[i] = {
              ...result[i],
              URLlink:
                window.location.origin +
                "/lightning/r/Product2/" +
                result[i].Id +
                "/view"
            };
            console.log(this.generateProductCode(result[i].ProductCode));
            results[i] = {
              ...result[i],
              srcURL: window.location.origin.replace(".lightning.force.com", "--c.documentforce.com/file-asset/")
               + this.generateProductCode(result[i].ProductCode)
            };
          }
          console.log(results);
          this.products = results;
        })
        .catch((error) => {
          this.error = error;
          console.log(error);
        });
    }
  }
}
