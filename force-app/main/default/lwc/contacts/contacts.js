import { LightningElement, wire } from 'lwc';
import getContacts from '@salesforce/apex/ContactsCtrl.getContacts';

export default class Contacts extends LightningElement {
    @wire(getContacts)
    contactsLst;
    //contactsLst.data --> method returned data
    //contactsLst.error --> errror information    
}