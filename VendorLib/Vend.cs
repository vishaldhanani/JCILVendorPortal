using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VendorLib
{
    public class Vend
    {
        public int SourceRef { get; set; }
        public int TypeofBusi { get; set; }
        public string SourceRefInquiryBy { get; set; }
        public string SourceRefExternal { get; set; }
        public string SourceRefExternalOrgName { get; set; }
        public string SourceRefExternalContNo { get; set; }
        public string TypeofBusiForServiceProvider { get; set; }
        public int Title { get; set; }
        public string VendorName_HO { get; set; }
        public string PremisesNo_HO { get; set; }
        public string Address_1_HO { get; set; }
        public string Address_2_HO { get; set; }
        public string Address_3_HO { get; set; }
        public string City_HO { get; set; }
        public string StateRegion_HO { get; set; }
        public Nullable<int> PinCode_HO { get; set; }
        public string VendorName_WS { get; set; }
        public string PremisesNo_WS { get; set; }
        public string Address_1_WS { get; set; }
        public string Address_2_WS { get; set; }
        public string Address_3_WS { get; set; }
        public string City_WS { get; set; }
        public string StateRegion_WS { get; set; }
        public Nullable<int> PinCode_WS { get; set; }
        public string WebSite { get; set; }
        public string Con_PropDirPar_Name { get; set; }
        public Nullable<int> Con_PropDirPar_PhoneNo { get; set; }
        public Nullable<int> Con_PropDirPar_MobileNo { get; set; }
        public string Con_PropDirPar_EmailID { get; set; }
        public string Con_SalesDep_Name { get; set; }
        public Nullable<int> Con_SalesDep_PhoneNo { get; set; }
        public Nullable<int> Con_SalesDep_MobileNo { get; set; }
        public string Con_SalesDep_EmailID { get; set; }
        public string Con_AccDep_Name { get; set; }
        public Nullable<int> Con_AccDep_PhoneNo { get; set; }
        public Nullable<int> Con_AccDep_MobileNo { get; set; }
        public string Con_AccDep_EmailID { get; set; }
        public string PaymentTerm { get; set; }
        public Nullable<int> TotalStrengthOfManPower { get; set; }
        public Nullable<int> ShipmentTerm { get; set; }
        public Nullable<int> For_SOM_CSTNo { get; set; }
        public Nullable<int> For_SOM_VatNo { get; set; }
        public string For_SOM_PanNo { get; set; }
        public string For_SOM_TanNo { get; set; }
        public Nullable<bool> For_SOM_MicroSmallMediumEnterprise { get; set; }
        public string For_SOM_MSMERegNo { get; set; }
        public string For_SOM_RegisteredwithExcise { get; set; }
        public string For_SOM_ECCNo { get; set; }
        public string For_SOM_ExciseRange { get; set; }
        public string For_SOM_ExciseDivision { get; set; }
        public string For_SOM_ExciseCollectorate { get; set; }
        public string For_Others_PanNo { get; set; }
        public string For_Others_ServcieTaxRegNo { get; set; }
        public string For_Others_PFRegNo { get; set; }
        public string For_Others_ESIRegNo { get; set; }
        public string For_Others_ContractLicenseNo { get; set; }
        public Nullable<bool> For_Others_TDS_Applicability { get; set; }
        public string For_Others_LowerDeductionCertiNo { get; set; }
        public string BankName { get; set; }
        public string BankBrachName { get; set; }
        public string BankAccNo { get; set; }
        public string TypeofAcc { get; set; }
        public string IFSCode { get; set; }
        public string MICRCODE { get; set; }
        public string Bank_EmailID_UTR { get; set; }
        public Nullable<int> BankingMobileNo { get; set; }
    }
}
