import { LightningElement, api, track} from 'lwc';

export default class Child extends LightningElement {
    @api isDisplay = false;
    @track value = ['chennai'];
    options = [
        {
            "label" : "Bangalore", 
            "value" : "bangalore"
        },
        {
            "label" : "Chennai", 
            "value" : "chennai"
        },
        {
            "label" : "Hyderabad", 
            "value" : "hyderabad"
        },
        {
            "label" : "Pune", 
            "value" : "pune"
        },
    ];


    @api
    childMethod(city) {
        debugger;
        const selCity = this.options.find(cityInfo => {
            return city === cityInfo.value;
        });
        this.value = selCity.value;
    }

    handleChange() {
        debugger;
        //Firing the event from the child component 
        var cusEvt = new CustomEvent('mychildevent',{detail:'I am the message from child to parent.',bubbles:true});
        this.dispatchEvent(cusEvt);
    }
}