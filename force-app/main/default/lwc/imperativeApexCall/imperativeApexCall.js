import { LightningElement, track } from 'lwc';
import getCons from '@salesforce/apex/ApexCallwithWireServiceCtrl.getCons';

const columns = [
    { label: 'First Name', fieldName: 'FirstName' },
    { label: 'Last Name', fieldName: 'LastName'},
    { label: 'Email', fieldName: 'Email'}
];
export default class ImperativeApexCall extends LightningElement {
    @track data;
    @track columns = columns;
    @track error;
    constructor() {
        super();
        getCons().then(data => {
            console.log('data: '+JSON.stringify(data));
            this.data = data;
        }).catch(error => {
            error = this.error;
        });
    }
}