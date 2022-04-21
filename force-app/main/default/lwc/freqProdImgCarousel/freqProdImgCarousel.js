import { LightningElement, api } from 'lwc';
import getFrequentProducts from '@salesforce/apex/FreqProdImgCarouselController.getFrequentProducts';
import myContentAsset from '@salesforce/contentAssetUrl';

export default class FreqProdImgCarousel extends LightningElement {
    @api recordId;
    products;
    error;
    rendered = false;
    renderedCallback() {
 
        console.log('Hello');
        console.log(this.recordId);
        if(!this.rendered) {
            this.rendered = true;
            getFrequentProducts({product2Id: this.recordId})
            .then(
                result => {
                    console.log(result);
                    console.log(result.length);
                    let results = []; 
                    console.log(results);
                    for(let i = 0; i < result.length; i++) {
                        console.log(i);
                        results[i] = {...result[i], URLlink: window.location.origin + '/lightning/r/Product2/' + result[i].Id + '/view'};
                        results[i] = {...result[i], srcURL: myContentAsset + '/' + result[i].ProductCode + '.jpg'};
                        console.log(results);
                        console.log(result[i]);
                    }
                    this.products = results;
            })
            .catch(error => {
                this.error = error;
                console.log(error);
            });

        }
        
    };

}