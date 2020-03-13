import { LightningElement, wire } from 'lwc';
import {fireEvent} from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation';

export default class Parent2Cmp extends LightningElement {

    @wire(CurrentPageReference)
    pageRef;

    handleClick() {
        debugger;
        fireEvent(this.pageRef,'parent2event','I am the event firnig from parent2 component.');
    }
}