public class PdfFormat {
    public List<Contact> con{get;set;}
    public boolean pb1{get;set;}
    public string renderAsPdf{get;set;}
   
     public PdfFormat(){
         con=[select Name,Phone,Email from Contact];
         pb1=true;
     } 
     //save As pdf
     public PageReference SaveAsPdf() {
         pb1=false;
         renderAsPdf='Advanced_pdf';
         return null;
     }
 }