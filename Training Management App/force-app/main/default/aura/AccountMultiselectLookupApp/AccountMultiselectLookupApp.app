<aura:application extends="force:slds">
  <aura:attribute name="selectedLookUpRecords" type="sObject[]" default="[]"/>
   <c:AccountMultiselectLookup objectAPIName="Account"
                               IconName="standard:Account"
                               listSelectedRecords="{!v.selectedLookUpRecords}"
                               label="Account Name"/>
   
</aura:application>