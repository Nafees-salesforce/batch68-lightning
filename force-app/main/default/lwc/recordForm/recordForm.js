import { LightningElement, track } from 'lwc';
import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import MOBILEPHONE_FIELD from '@salesforce/schema/Contact.MobilePhone';

export default class RecordForm extends LightningElement {
    //@track fieldArray = ['FirstName','LastName','Email','MobilePhone'];
    @track fieldArray = [FIRSTNAME_FIELD,LASTNAME_FIELD,EMAIL_FIELD,MOBILEPHONE_FIELD];
    @track recordId;

    handleSuccess(event) {
        this.recordId = event.detail.id;
    }

}