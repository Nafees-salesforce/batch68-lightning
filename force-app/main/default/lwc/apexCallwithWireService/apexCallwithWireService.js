import { LightningElement, wire, track } from 'lwc';
import getAccs from '@salesforce/apex/ApexCallwithWireServiceCtrl.getAccs';

const columns = [
    { label: 'Account Name', fieldName: 'Name' },
    { label: 'Industry', fieldName: 'Industry'},
    { label: 'Rating', fieldName: 'Rating'}
];
export default class ApexCallwithWireService extends LightningElement {
    @track columns = columns;
    @track data;
    rating = 'Hot';

    @wire(getAccs,{'rating':"$rating"})
    accounts({data,error}) {
        if(data) {
            //console.log('Data Result: '+JSON.stringify(data));
            console.log(`Data Result: $JSON.stringify(data)`);
            this.data = data;
        }
    }
}