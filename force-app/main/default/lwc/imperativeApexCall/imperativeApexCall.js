import { LightningElement, track } from 'lwc';
import getCons from '@salesforce/apex/ApexCallwithWireServiceCtrl.getCons';
import deleteRow from '@salesforce/apex/ApexCallwithWireServiceCtrl.deleteRow';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import Srinusfdc_Logo from '@salesforce/resourceUrl/Srinusfdc_Logo';

const columns = [
    { label: 'First Name', fieldName: 'FirstName' },
    { label: 'Last Name', fieldName: 'LastName'},
    { label: 'Email', fieldName: 'Email'}
];
export default class ImperativeApexCall extends NavigationMixin(LightningElement) {
    @track data;
    @track columns = columns;
    @track error;
    @track recordPageUrl;
    @track url = Srinusfdc_Logo;

    constructor() {
        super();
        this.getData();
    }

    getData() {
        const inputMap = {};
        getCons({inputMap : inputMap}).then(data => {
            console.log('data: '+JSON.stringify(data));
            this.data = data.contacts;
        }).catch(error => {
            error = this.error;
        });
    }

    navigateToObjectHome() {
        // Navigate to the Account home page
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Contact',
                actionName: 'home',
            },
        });
    }

    navigateToRecordPage(event) {
        debugger;
        const recId = event.target.id;
        const paramArray = recId.split("-");
        this[NavigationMixin.GenerateUrl]({
            type: 'standard__recordPage',
            attributes: {
                recordId: paramArray[0],
                actionName: 'view',
            },
        }).then(url => {
            this.recordPageUrl = url;
        });
    }

    handleDelete(event) {
        const recId = event.target.title;
        deleteRow({recordId:recId}).then(result => {
            console.log(`Success Msg form Server: ${result}`);
            this.getData();
            const evt = new ShowToastEvent({
                title: 'Delete Success.',
                message: result,
                variant: 'success',
            });
            this.dispatchEvent(evt);     
            this.navigateToObjectHome();       
        }).catch(error => {
            console.log(`Error Msg form Server: ${error}`);
            const evt = new ShowToastEvent({
                title: 'Delete Success.',
                message: error,
                variant: 'success',
            });
            this.dispatchEvent(evt);
        });
    }
}