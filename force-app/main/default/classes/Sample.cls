public class Sample {
    public static void exportToExcel() {
        List<Opportunity> oppLst = [Select Id, Service_Group__c, AccountId, Account.RSM__c, Account.MCS__c, Account.E_commerce__c, 
                                    Account.WINS_Wholesaler_Number__c, Account.WINS_AB_Invoicing_Volume__c,
                                    Account.WINS_Total_Invoicing_Volume__c,
                                    Account.RSM_INVOICE_VOLUME__c, Account.EC_INVOICE_VOLUME__c, 
									Account.WINS_DriverSell_Licenses__c,
									Account.WINS_Presell_Licenses__c,
									Account.WINS_Team_Leader_Licenses__c,
                                    Cloud_Account__c,Cloud_Account__r.RSM__c, Cloud_Account__r.MCS__c, Cloud_Account__r.E_commerce__c, 
                                    Cloud_Account__r.WINS_Wholesaler_Number__c, Cloud_Account__r.WINS_AB_Invoicing_Volume__c,
                                    Cloud_Account__r.WINS_Total_Invoicing_Volume__c,
                                    Cloud_Account__r.RSM_INVOICE_VOLUME__c, Cloud_Account__r.EC_INVOICE_VOLUME__c,
									Cloud_Account__r.WINS_DriverSell_Licenses__c,
									Cloud_Account__r.WINS_Presell_Licenses__c,
									Cloud_Account__r.WINS_Team_Leader_Licenses__c
                                    from Opportunity where RecordType.DeveloperName = 'WINS_Opportunity'];
        List<InvoiceData> resultData = new List<InvoiceData>();
        List<Opportunity> cloudOpps = new List<Opportunity>();
        List<Opportunity> mainOpps = new List<Opportunity>();
        if(oppLst != null && oppLst.size() > 0) {
            for(Integer i = 0; i < oppLst.size();i++) {
                if(oppLst[i].Cloud_Account__c != null && oppLst[i].Cloud_Account__c != oppLst[i].AccountId) {
                    cloudOpps.add(oppLst[i]);
                }
                else {
                    mainOpps.add(oppLst[i]);
                }
            }
        }
    }
    public class OppInfo {
        public String oppId, accName;
        public OppInfo(String oppId, String accName) {
            this.oppId = oppId;
            this.accName = accName;
        }
    }
}