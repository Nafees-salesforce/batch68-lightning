import { LightningElement, track, wire } from 'lwc';
import {createRecord,getRecord} from 'lightning/uiRecordApi'

const fieldsArray = ['Contact.FirstName','Contact.LastName','Contact.Email','Contact.MobilePhone'];
export default class ContactForm extends LightningElement {   

    @track recordId;

    @wire(getRecord,{recordId:"$recordId", fields: fieldsArray})
    contact;


    firstNameChangeHandler(event) {
        this.firstName = event.target.value;
    }
    lastNameChangeHandler(event) {
        this.lastName = event.target.value;
    }
    emailChangeHandler(event) {
        this.email = event.target.value;
    }
    mobileChangeHandler(event) {
        this.mobile = event.target.value;
    }
    
    createContact() {
        debugger;
        //Field API Names along with the data
        const fields = {
            "FirstName" : this.firstName,
            "LastName" : this.lastName,
            "Email" : this.email,
            "MobilePhone" : this.mobile
        };

        var recordInput = {
            apiName : "Contact", fields
        };
         
        //Using javaScript promise concept
        createRecord(recordInput).then(response => {
            console.log('Record Id: '+response.id);
            this.recordId = response.id;
        }).catch(error => {
            console.log('Error Object: '+JSON.stringify(error));
            console.log('Error Message: '+error.body.message);
        });

    }

    get retFirstName() {
        debugger;
        console.log('contact: '+JSON.stringify(this.contact));
        if(this.contact.data) {
            return this.contact.data.fields.FirstName.value;
        }
        return undefined;
    }

    get retLastName() {
        debugger;
        if(this.contact.data) {
            return this.contact.data.fields.LastName.value;
        }
        return undefined;
    }

    get retEmail() {
        debugger;
        if(this.contact.data) {
            return this.contact.data.fields.Email.value;
        }
        return undefined;
    }

    get retMobile() {
        debugger;
        if(this.contact.data) {
            return this.contact.data.fields.MobilePhone.value;
        }
        return undefined;
    }
    
    
}