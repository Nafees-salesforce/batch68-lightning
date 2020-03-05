import { LightningElement, wire, track } from 'lwc';
import getContacts from '@salesforce/apex/ContactsCtrl.getContacts';

export default class Contacts extends LightningElement {
    @track data;
    @track error;
    searchKey = 'T';
    /*@wire(getContacts)
    contactsLst;*/
    //contactsLst.data --> method returned data
    //contactsLst.error --> errror information    
    @wire(getContacts,{"fnFilter":"$searchKey"})
    contactsLst({
        data,
        error
    }) {
        if(data) {
            this.data = data;
        }
        else if(error) {
            this.error = error;
        }
    }
}