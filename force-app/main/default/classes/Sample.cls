public class AllInvoiceExcelReport {
    
    static List<RSM__mdt> rsmAllLst = [Select Id, Tier__c, Annual_Cost__c from RSM__mdt order by Tier__c];
    static List<Ecommerce__mdt> ecmAllLst = [Select Id, Tier__c, Annual_Cost__c from Ecommerce__mdt order by Tier__c];
    static List<MCS__mdt> mcsAllLst = [Select Id, Tier__c, Revenue_Target__c, Base_Price__c, Total_Tier_Volume__c, Wslrs_in_Tier__c 
    from MCS__mdt order by Tier__c];
    static Map<Id,List<OpportunityLineItem>> oppIdOliMap = new Map<Id,List<OpportunityLineItem>>();  
    static List<Opportunity> oppLst;
    
    @AuraEnabled
    public static Map<String,Object> makeData(Map<String,Object> inputMap) {
        Map<String,Object> outputMap = new Map<String,Object>();
        //All the wins opportunities to generate the report
        oppLst = [Select Id, Service_Group__c, AccountId, Account.RSM__c, Account.MCS__c, Account.E_commerce__c, 
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
                                    Cloud_Account__r.WINS_Team_Leader_Licenses__c,
                                    Account.Cloud_Invoice_To__c
                                    from Opportunity where RecordType.DeveloperName = 'WINS_Opportunity'];
        
        //Holds all the data to export
        List<InvoiceData> resultData = new List<InvoiceData>();
        
        //Paying for other whole saler opportunities
        List<Opportunity> cloudOpps = new List<Opportunity>();
        
        //Paying for same whole saler opportunities
        List<Opportunity> mainOpps = new List<Opportunity>();
        
        if(oppLst != null && oppLst.size() > 0) {
            
            //To hold Opportunity Line Items related to all the opportunities
            for(OpportunityLineItem oli : [Select Id, OpportunityId, Quantity, Product2.Name, UnitPrice, Description from OpportunityLineItem 
            where OpportunityId in: oppLst]) {
                if(oppIdOliMap.containsKey(oli.OpportunityId)) {
                    oppIdOliMap.get(oli.OpportunityId).add(oli);
                }
                else {
                    oppIdOliMap.put(oli.OpportunityId,new List<OpportunityLineItem>{oli});
                }
            }
            
            for(Integer i = 0; i < oppLst.size();i++) {
                //Identifying other whole saler opportunities
                if(oppLst[i].Cloud_Account__c != null && oppLst[i].Cloud_Account__c != oppLst[i].AccountId) {
                    cloudOpps.add(oppLst[i]);
                }
                //Identifying own whole saler opportunities
                else {
                    mainOpps.add(oppLst[i]);
                }
            }
            resultData.addAll(processCloudOpps(cloudOpps));
            List<InvoiceData> processMainOppsData = processMainOpps(mainOpps);
            if(processMainOppsData != null && processMainOppsData.size() > 0) {
                resultData.addAll(processMainOppsData);
            }
        }
        outputMap.put('data',resultData);        
        return outputMap;
    }
    public static List<InvoiceData> processCloudOpps(List<Opportunity> cloudOpps) {
        List<InvoiceData> data = new List<InvoiceData>();
        for(Opportunity cloudOpp : cloudOpps) {
            List<InvoiceData> currentData = new List<InvoiceData>();
            String item, description;
            if(cloudOpp.Service_Group__c == '1') {
                item = 'MAN-MOB-SG1';
                description = 'ALLCONNECT Service Group1';
                currentData.addAll(handleSg1CloudAcc(cloudOpp));
            }
            else if(cloudOpp.Service_Group__c == '2' || cloudOpp.Service_Group__c == '3') {
                if(mainOpp.Service_Group__c == '2') {
                    item = 'MAN-MOB-SG2';
                    description = 'ALLCONNECT Service Group2';
                }
                else {
                    item = 'RETAIL CONNECT';
                    description = 'RETAIL CONNECT';
                }
                List<InvoiceData> handleSg2N3CloudAccData = handleSg2N3CloudAcc(cloudOpp);
                if(handleSg2N3CloudAccData != null && handleSg2N3CloudAccData.size() > 0) {
                    currentData.addAll(handleSg2N3CloudAccData);
                }
            }
            Decimal finalUnitPrice = 0, finalExtendedPrice = 0;
            for(InvoiceData row : currentData) {
                finalUnitPrice += row.unitPrice;
                finalExtendedPrice += row.extendedPrice;
            }
            data.add(
                new InvoiceData(
                    wslr, 1, item, finalUnitPrice, finalExtendedPrice, description
                ) 
            );
        }        
        return data;
    }
    public static List<InvoiceData> processMainOpps(List<Opportunity> mainOpps) {
        List<InvoiceData> data = new List<InvoiceData>();        
        for(Opportunity mainOpp : mainOpps) {
            List<InvoiceData> currentData = new List<InvoiceData>();
            String item, description;
            if(mainOpp.Service_Group__c == '1') {
                item = 'MAN-MOB-SG1';
                description = 'ALLCONNECT Service Group1';
                currentData.addAll(handleSg1Acc(mainOpp));
            }
            else if(mainOpp.Service_Group__c == '2' || mainOpp.Service_Group__c == '3') {
                if(mainOpp.Service_Group__c == '2') {
                    item = 'MAN-MOB-SG2';
                    description = 'ALLCONNECT Service Group2';
                }
                else {
                    item = 'RETAIL CONNECT';
                    description = 'RETAIL CONNECT';
                }
                List<InvoiceData> handleSg2N3AccData = handleSg2N3Acc(mainOpp);
                if(handleSg2N3AccData != null && handleSg2N3AccData.size() > 0) {
                    currentData.addAll(handleSg2N3AccData);
                }
            }
            Decimal finalUnitPrice = 0, finalExtendedPrice = 0;
            for(InvoiceData row : currentData) {
                finalUnitPrice += row.unitPrice;
                finalExtendedPrice += row.extendedPrice;
            }
            data.add(
                new InvoiceData(
                    wslr, 1, item, finalUnitPrice, finalExtendedPrice, description
                ) 
            );
        }
        return data;
    }
    //To handle SG1 Cloud Account
    public static List<InvoiceData> handleSg1CloudAcc(Opportunity opp) {
        List<InvoiceData> data = new List<InvoiceData>();
        if(opp.Cloud_Account__r.RSM__c) {
            if(opp.Cloud_Account__r.RSM_INVOICE_VOLUME__c == null) opp.Cloud_Account__r.RSM_INVOICE_VOLUME__c = 0;
            List<RSM__mdt> rsmLst = new List<RSM__mdt>();
            for(RSM__mdt rsm : rsmAllLst) {
                if( rsm.Tier__c >= opp.Cloud_Account__r.WINS_AB_Invoicing_Volume__c + opp.Cloud_Account__r.RSM_INVOICE_VOLUME__c) {
                    rsmLst.add(rsm);
                }
            }
            if(rsmLst != null && rsmLst.size() > 0) {
                InvoiceData inData = new InvoiceData(
                    opp.Cloud_Account__r.WINS_Wholesaler_Number__c, 1, 'RSM', rsmLst[0].Annual_Cost__c, rsmLst[0].Annual_Cost__c, 'RSM Single Location Business enitity'
                );
                data.add(inData);
            }                
        }
        if(opp.Cloud_Account__r.E_commerce__c) {
            if(opp.Cloud_Account__r.EC_INVOICE_VOLUME__c ==  null) opp.Cloud_Account__r.EC_INVOICE_VOLUME__c = 0;
            List<Ecommerce__mdt> ecmLst = new List<Ecommerce__mdt>();
            for(Ecommerce__mdt ecm : ecmAllLst) {
                if(ecm.Tier__c >= opp.Cloud_Account__r.WINS_AB_Invoicing_Volume__c + opp.Cloud_Account__r.EC_INVOICE_VOLUME__c) {
                    ecmLst.add(ecm);
                }
            }
            if(ecmLst != null && ecmLst.size() > 0) {
                InvoiceData inData = new InvoiceData(
                    opp.Cloud_Account__r.WINS_Wholesaler_Number__c, 1, 'Ecommerce', ecmLst[0].Annual_Cost__c, ecmLst[0].Annual_Cost__c, 'EC Single Location Business enitity'
                );
                data.add(inData);
            }
        }
        //Logic for MCS 
        if(opp.Cloud_Account__r.MCS__c) {
            
            List<MCS__mdt> mcsLst = new List<MCS__mdt>();
            for(MCS__mdt mcs : mcsAllLst) {
                if(mcs.Tier__c >= opp.Cloud_Account__r.WINS_AB_Invoicing_Volume__c) {
                    mcsLst.add(mcs);
                }
            }

            if(mcsLst != null && mcsLst.size() > 0) {
                Integer wslrsInTier = Integer.valueOf(mcsLst[0].Wslrs_in_Tier__c);
                Decimal totalTierVol = mcsLst[0].Total_Tier_Volume__c;
                Decimal fee_cloud1 = 0;
                Decimal fee_cloud2 = 0;
                Decimal fee_cloud3 = 0;
                Decimal wslrCargeAboveBase = 0;
                Decimal revenueNeedAboveBase = 0;
                Decimal tierTotalBaseRevenue = 0;
                Decimal wslrTierPercentage = 0;                   
                tierTotalBaseRevenue = wslrsInTier * mcsLst[0].Base_Price__c;
                revenueNeedAboveBase = mcsLst[0].Revenue_Target__c - tierTotalBaseRevenue;                        
                wslrTierPercentage = opp.Cloud_Account__r.WINS_Total_Invoicing_Volume__c / totalTierVol;
                wslrCargeAboveBase = revenueNeedAboveBase * wslrTierPercentage;
                //fee_cloud1 = (mcsLst[0].Base_Price__c + wslrCargeAboveBase) * (1 + (1.92/100)).round(System.RoundingMode.FLOOR);
                fee_cloud1 = ((mcsLst[0].Base_Price__c + wslrCargeAboveBase) * (1 + (1.92/100))).round(System.RoundingMode.CEILING);
                //fee_cloud2 = fee_cloud1 * 12 * (1 + (1.70/100)).round(System.RoundingMode.FLOOR);
                    fee_cloud2 = 12*(fee_cloud1*(1 + (1.70/100))).round(System.RoundingMode.CEILING);
                //The final value
                //fee_cloud3 = fee_cloud2 *(1 + (1.30/100)).round(System.RoundingMode.FLOOR);
                fee_cloud3 =(fee_cloud2*(1 + (1.30/100))).round(System.RoundingMode.CEILING);
                system.debug('mcsLst[0].Base_Price__c: '+mcsLst[0].Base_Price__c);
                system.debug('mcsLst[0].Revenue_Target__c: '+mcsLst[0].Revenue_Target__c);
                system.debug('wslrsInTier: '+wslrsInTier);
                system.debug('totalTierVol: '+totalTierVol);
                system.debug('opp.Account.WINS_Total_Invoicing_Volume__c: '+opp.Cloud_Account__r.WINS_Total_Invoicing_Volume__c);
                system.debug('tierTotalBaseRevenue: '+tierTotalBaseRevenue);
                system.debug('revenueNeedAboveBase: '+revenueNeedAboveBase);
                system.debug('wslrTierPercentage: '+wslrTierPercentage);
                system.debug('wslrCargeAboveBase: '+wslrCargeAboveBase);
                system.debug('fee_cloud1: '+fee_cloud1);
                system.debug('fee_cloud1: '+fee_cloud2);
                system.debug('fee_cloud3: '+fee_cloud3);
                InvoiceData inData = new InvoiceData(
                    opp.Cloud_Account__r.WINS_Wholesaler_Number__c, 1, 'AB-MCS', fee_cloud3, fee_cloud3, '1 Single Location Business enitity'
                );
                data.add(inData);
            }                   
        }
        if(oppIdOliMap.containsKey(opp.Id)) {
            for(OpportunityLineItem oli : oppIdOliMap.get(opp.Id)) {
                InvoiceData inData = new InvoiceData(
                    opp.Cloud_Account__r.WINS_Wholesaler_Number__c, oli.Quantity, oli.Product2.Name, oli.UnitPrice, oli.UnitPrice, oli.Description
                );
                data.add(inData);
            }
        }
        return data;
    }
    //To handle SG2 and SG3 Cloud Account
    public static List<InvoiceData> handleSg2N3CloudAcc(Opportunity cloudOpp) {
        List<InvoiceData> data = new List<InvoiceData>();
        List<Opportunity> opp4UpdLst = new List<Opportunity>();
        for(Opportunity oppRec : oppLst) {
            if(oppRec.Account.Cloud_Invoice_To__c == cloudOpp.Account.WINS_Wholesaler_Number__c) {
                opp4UpdLst.add(oppRec);
            }
        }
        if(opp4UpdLst.size() > 0) {
            system.debug('Cloud_Account__r for sg2 or sg3');
            Decimal wslr_totalVolume = 0;
            Decimal wlsr_selling_licenses = 0;
            List<Opportunity> oppCloudToLst = new List<Opportunity>();
            for(Opportunity oppRec : oppLst) {
                if(oppRec.Account.Cloud_Invoice_To__c == cloudOpp.Cloud_Account__r.WINS_Wholesaler_Number__c) {
                    oppCloudToLst.add(oppRec);
                }
            }
            for(Opportunity opp : oppCloudToLst) {
                if(wslr_totalVolume ==  null) wslr_totalVolume = 0;
                wslr_totalVolume += opp.Cloud_Account__r.WINS_Total_Invoicing_Volume__c;
                
                if(opp.Cloud_Account__r.WINS_DriverSell_Licenses__c == 0) opp.Cloud_Account__r.WINS_DriverSell_Licenses__c = 0;
                if(opp.Cloud_Account__r.WINS_Presell_Licenses__c == 0) opp.Cloud_Account__r.WINS_Presell_Licenses__c = 0;
                if(opp.Cloud_Account__r.WINS_Team_Leader_Licenses__c == 0) opp.Cloud_Account__r.WINS_Team_Leader_Licenses__c = 0;
                wlsr_selling_licenses += opp.Cloud_Account__r.WINS_DriverSell_Licenses__c + opp.Cloud_Account__r.WINS_Presell_Licenses__c + opp.Cloud_Account__r.WINS_Team_Leader_Licenses__c;
            }
            
            Decimal sg2Price = 0, SG3_price = 0;
            sg2Price = (6525 + 0.5 * wslr_totalVolume/100 + -0.00000000005 * wslr_totalVolume * wslr_totalVolume + (wlsr_selling_licenses-(3.2482 + 0.000006* wslr_totalVolume))*341)*(1+0.23);
            sg2Price = (sg2Price * 1.0192);//2014 increase Roundup
            sg2Price = (sg2Price * 1.017);//2015 increase Roundup
            sg2Price = (sg2Price * 1.013);  
            if(cloudOpp.Service_Group__c == '2') {
                InvoiceData inData1 = new InvoiceData(
                    cloudOpp.Account.WINS_Wholesaler_Number__c, 1, 'MAN-MOB-SG2', sg2Price, sg2Price, 'SG2'
                );
                data.add(inData1);
            }
            if(cloudOpp.Service_Group__c == '3') {
                //for sg3
                SG3_price = sg2Price * 1.25;
                InvoiceData inData2 = new InvoiceData(
                    cloudOpp.Account.WINS_Wholesaler_Number__c, 1, 'Retail Connect', SG3_price, SG3_price, 'SG3'
                );
                data.add(inData2);
            }
        }
        return data;
    }
    //To handle SG1 Main Account
    public static List<InvoiceData> handleSg1Acc(Opportunity mainOpp) {
        List<InvoiceData> data = new List<InvoiceData>();
        if(mainOpp.Account.RSM__c) {
            if(mainOpp.Account.RSM_INVOICE_VOLUME__c == null) mainOpp.Account.RSM_INVOICE_VOLUME__c = 0;
            List<RSM__mdt> rsmLst = new List<RSM__mdt>();
            for(RSM__mdt rsm : rsmAllLst) {
                if(rsm.Tier__c >= mainOpp.Account.WINS_AB_Invoicing_Volume__c + mainOpp.Account.RSM_INVOICE_VOLUME__c) {
                    rsmLst.add(rsm);
                }
            }
            if(rsmLst != null && rsmLst.size() > 0) {
                InvoiceData inData = new InvoiceData(
                    mainOpp.Account.WINS_Wholesaler_Number__c, 1, 'RSM', rsmLst[0].Annual_Cost__c, rsmLst[0].Annual_Cost__c, 'RSM Single Location Business enitity'
                );
                data.add(inData);
            }                
        }
        if(mainOpp.Account.E_commerce__c) {
            if(mainOpp.Account.EC_INVOICE_VOLUME__c ==  null) mainOpp.Account.EC_INVOICE_VOLUME__c = 0;
            List<Ecommerce__mdt> ecmLst = new List<Ecommerce__mdt>();
            for(Ecommerce__mdt ecm : ecmAllLst) {
                if(ecm.Tier__c >= mainOpp.Account.WINS_AB_Invoicing_Volume__c + mainOpp.Account.EC_INVOICE_VOLUME__c) {
                    ecmLst.add(ecm);
                }
            }
            if(ecmLst != null && ecmLst.size() > 0) {
                InvoiceData inData = new InvoiceData(
                    mainOpp.Account.WINS_Wholesaler_Number__c, 1, 'Ecommerce', ecmLst[0].Annual_Cost__c, ecmLst[0].Annual_Cost__c, 'EC Single Location Business enitity'
                );
                data.add(inData);
            }
        }
        //Logic for MCS 
        if(mainOpp.Account.MCS__c) {
            
            List<MCS__mdt> mcsLst = new List<MCS__mdt>();
            for(MCS__mdt mcs : mcsAllLst) {
                if(mcs.Tier__c >= mainOpp.Account.WINS_Total_Invoicing_Volume__c) {
                    mcsLst.add(mcs);
                }
            }
            if(mcsLst != null && mcsLst.size() > 0) {
                Integer wslrsInTier = Integer.valueOf(mcsLst[0].Wslrs_in_Tier__c);
                Decimal totalTierVol = mcsLst[0].Total_Tier_Volume__c;
                Decimal fee_cloud1 = 0;
                Decimal fee_cloud2 = 0;
                Decimal fee_cloud3 = 0;
                Decimal wslrCargeAboveBase = 0;
                Decimal revenueNeedAboveBase = 0;
                Decimal tierTotalBaseRevenue = 0;
                Decimal wslrTierPercentage = 0;                                    
                tierTotalBaseRevenue = wslrsInTier * mcsLst[0].Base_Price__c;
                revenueNeedAboveBase = mcsLst[0].Revenue_Target__c - tierTotalBaseRevenue;                        
                wslrTierPercentage = oppLst[0].Account.WINS_Total_Invoicing_Volume__c / totalTierVol;
                wslrCargeAboveBase = revenueNeedAboveBase * wslrTierPercentage;
                fee_cloud1 = ((mcsLst[0].Base_Price__c + wslrCargeAboveBase) * (1 + (1.92/100))).round(System.RoundingMode.CEILING);
                fee_cloud2 = (fee_cloud1 * 12 * (1 + (1.70/100))).round(System.RoundingMode.CEILING);
                //The final value
                fee_cloud3 = (fee_cloud2 *(1 + (1.30/100))).round(System.RoundingMode.CEILING);
                system.debug('mcsLst[0].Base_Price__c: '+mcsLst[0].Base_Price__c);
                system.debug('mcsLst[0].Revenue_Target__c: '+mcsLst[0].Revenue_Target__c);
                system.debug('wslrsInTier: '+wslrsInTier);
                system.debug('totalTierVol: '+totalTierVol);
                system.debug('mainOpp.Account.WINS_AB_Invoicing_Volume__c: '+mainOpp.Account.WINS_Total_Invoicing_Volume__c);
                system.debug('tierTotalBaseRevenue: '+tierTotalBaseRevenue);
                system.debug('revenueNeedAboveBase: '+revenueNeedAboveBase);
                system.debug('wslrTierPercentage: '+wslrTierPercentage);
                system.debug('wslrCargeAboveBase: '+wslrCargeAboveBase);
                system.debug('fee_cloud1: '+fee_cloud1);
                system.debug('fee_cloud1: '+fee_cloud2);
                system.debug('fee_cloud3: '+fee_cloud3);
                InvoiceData inData = new InvoiceData(
                    mainOpp.Account.WINS_Wholesaler_Number__c, 1, 'AB-MCS', fee_cloud3, fee_cloud3, '1 Single Location Business enitity'
                );
                data.add(inData);
            }
        }
        if(oppIdOliMap.containsKey(mainOpp.Id)) {
            for(OpportunityLineItem oli : oppIdOliMap.get(mainOpp.Id)) {
                InvoiceData inData = new InvoiceData(
                    mainOpp.Account.WINS_Wholesaler_Number__c, oli.Quantity, oli.Product2.Name, oli.UnitPrice, oli.UnitPrice, oli.Description
                );
                data.add(inData);
            }
        }
        return data;
    }
    //To handle SG2 and SG3 Main Account
    public static List<InvoiceData> handleSg2N3Acc(Opportunity mainOpp) {
        List<InvoiceData> data = new List<InvoiceData>();
         List<Opportunity> opp4UpdLst = new List<Opportunity>();
        for(Opportunity oppRec : oppLst) {
            if(mainOpp.Account.Cloud_Invoice_To__c == mainOpp.Account.WINS_Wholesaler_Number__c) {
                opp4UpdLst.add(oppRec);
            }
        }
        if(opp4UpdLst.size() > 0) {
            system.debug('for sg2 or sg3');
            Decimal wslr_totalVolume = 0;
            Decimal wlsr_selling_licenses = 0;            
            for(Opportunity opp : opp4UpdLst) {
                if(wslr_totalVolume ==  null) wslr_totalVolume = 0;
                wslr_totalVolume += opp.Account.WINS_Total_Invoicing_Volume__c;
                
                if(opp.Account.WINS_DriverSell_Licenses__c == null) opp.Account.WINS_DriverSell_Licenses__c = 0;
                if(opp.Account.WINS_Presell_Licenses__c == null) opp.Account.WINS_Presell_Licenses__c = 0;
                if(opp.Account.WINS_Team_Leader_Licenses__c == null) opp.Account.WINS_Team_Leader_Licenses__c = 0;
                wlsr_selling_licenses += opp.Account.WINS_DriverSell_Licenses__c + opp.Account.WINS_Presell_Licenses__c + opp.Account.WINS_Team_Leader_Licenses__c;
            }
            
            Decimal sg2Price = 0, SG3_price = 0;
            sg2Price = (6525 + 0.5 * wslr_totalVolume/100 + -0.00000000005 * wslr_totalVolume * wslr_totalVolume + (wlsr_selling_licenses-(3.2482 + 0.000006* wslr_totalVolume))*341)*(1+0.23);
            sg2Price = (sg2Price * 1.0192);//2014 increase Roundup
            sg2Price = (sg2Price * 1.017);//2015 increase Roundup
            sg2Price =  (sg2Price * 1.013);  
            InvoiceData inData1 = new InvoiceData(
                mainOpp.Account.WINS_Wholesaler_Number__c, 1, 'MAN-MOB-SG2', sg2Price, sg2Price, 'SG2'
            );
            data.add(inData1);
            if(mainOpp.Service_Group__c == '3') {
                //for sg3
                SG3_price = sg2Price * 1.25;
                InvoiceData inData2 = new InvoiceData(
                    mainOpp.Account.WINS_Wholesaler_Number__c, 1, 'Retail Connect', SG3_price, SG3_price, 'SG3'
                );
                data.add(inData2);
            }
        }
        return data;
    }
    public class InvoiceData {
        @AuraEnabled
        public String wslr;
        @AuraEnabled
        public Decimal qty;
        @AuraEnabled
        public String item;
        @AuraEnabled
        public Decimal unitPrice;
        @AuraEnabled
        public Decimal extendedPrice;
        @AuraEnabled
        public String note;
        
        public InvoiceData(String wslr, Decimal qty, String item, Decimal unitPrice, Decimal extendedPrice, String note) {
            this.wslr = wslr;
            this.qty = qty;
            this.item = item;
            this.unitPrice = unitPrice;
            this.extendedPrice = extendedPrice;
            this.note = note;
        }
    }
}