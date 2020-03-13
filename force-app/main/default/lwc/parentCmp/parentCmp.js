import { LightningElement, track, wire } from 'lwc';
import {registerListener,unregisterAllListeners} from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation';
import {add,substract,multiply,divide} from 'c/utility';

export default class Parent extends LightningElement {
    @wire(CurrentPageReference)
    pageRef;

    @track value = 'hyderabad';
    onInput(event) {
        this.value = event.target.value;
    }

    handleClick() {
        debugger;
        const childCmp = this.template.querySelector('c-child');
        childCmp.childMethod(this.value);
    }

    handleChildEvent(event) {
        console.log(event.detail);
    }
    handleChildEvent2(payload) {
        console.log('***payload: '+payload);
    }

    constructor() {
        super();
        console.log('add: ',add(200,100));
        console.log('sub: ',substract(200,100));
        console.log('mul: ',multiply(200,100));
        console.log('div: ',divide(200,100));
        console.log('constructor');
        this.template.addEventListener('mychildevent',this.handleChildEvent.bind(this));
    }
    connectedCallback() {
        console.log('connectedCallback');
        registerListener('parent2event',this.handleChildEvent2,this);
    }
    disconnectedCallback() {
        console.log('disconnectedCallback');
    }
    renderedCallback() {
        console.log('renderedCallback');
    }
}