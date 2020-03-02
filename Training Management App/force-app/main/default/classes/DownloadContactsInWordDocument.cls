public class DownloadContactsInWordDocument {
   public List<Contact> con{get;set;}
   public string renderAsdoc{get;set;}
   public boolean pb1{get;set;}
   public string renderAsWord{get;set;}
  
    public DownloadContactsInWordDocument(){
        con=[select Name,Phone,Email from Contact];
        pb1=true;
    } 
    //save As Word
    public PageReference SaveAsWord() {
        pb1=false;
        renderAsWord='application/vnd.ms-word#Contact Report.doc';
        return null;
    }

}