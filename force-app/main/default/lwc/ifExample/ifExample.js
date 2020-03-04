import { LightningElement, track } from 'lwc';

export default class IfExample extends LightningElement {

    isDisplay = false; //private property
    @track cities = ['Bangalore','Chennai','Pune','Hyderabad']; //private reactive property
    @track countries = ['India','USA','Australia'];

    handleCheckbox(event) {
        this.isDisplay = event.target.checked;
    }

}