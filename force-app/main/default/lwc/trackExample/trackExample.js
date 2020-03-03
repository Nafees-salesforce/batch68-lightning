import { LightningElement, track } from 'lwc';

export default class TrackExample extends LightningElement {
    @track message = {
        title : 'Welcome to LWC Demo'
    };
 
    handleClick() {
        this.message.title = 'First Demo session';
        console.log(JSON.stringify(this.message));
    }

    handleChange(event) {
        this.message.title = event.target.value;
    }
}