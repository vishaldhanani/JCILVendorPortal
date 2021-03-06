//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace JCILVendorPortal
{
    using System;
    using System.Collections.Generic;
    
    public partial class VendorRegistration
    {
        public VendorRegistration()
        {
            this.Busi_Annul_Turnover = new HashSet<Busi_Annul_Turnover>();
            this.Busi_Annul_Turnover1 = new HashSet<Busi_Annul_Turnover>();
            this.Busi_Cust_Ref = new HashSet<Busi_Cust_Ref>();
        }
    
        public int ID { get; set; }
        public Nullable<int> SourceRef { get; set; }
        public Nullable<int> TypeofBusi { get; set; }
        public string SourceRefInquiryBy { get; set; }
        public string SourceRefExternal { get; set; }
        public string SourceRefExternalOrgName { get; set; }
        public string SourceRefExternalContNo { get; set; }
        public string TypeofBusiForServiceProvider { get; set; }
        public Nullable<int> Title { get; set; }
        public string VendorName_HO { get; set; }
        public string PremisesNo_HO { get; set; }
        public string Address_1_HO { get; set; }
        public string Address_2_HO { get; set; }
        public string Country_HO { get; set; }
        public string StateRegion_HO { get; set; }
        public Nullable<int> PinCode_HO { get; set; }
        public string VendorName_WS { get; set; }
        public string PremisesNo_WS { get; set; }
        public string Address_1_WS { get; set; }
        public string Address_2_WS { get; set; }
        public string City_WS { get; set; }
        public string StateRegion_WS { get; set; }
        public Nullable<int> PinCode_WS { get; set; }
        public string WebSite { get; set; }
        public string Con_PropDirPar_Name { get; set; }
        public string Con_PropDirPar_PhoneNo { get; set; }
        public string Con_PropDirPar_MobileNo { get; set; }
        public string Con_PropDirPar_EmailID { get; set; }
        public string Con_SalesDep_Name { get; set; }
        public string Con_SalesDep_PhoneNo { get; set; }
        public string Con_SalesDep_MobileNo { get; set; }
        public string Con_SalesDep_EmailID { get; set; }
        public string Con_AccDep_Name { get; set; }
        public string Con_AccDep_PhoneNo { get; set; }
        public string Con_AccDep_MobileNo { get; set; }
        public string Con_AccDep_EmailID { get; set; }
        public string PaymentTerm { get; set; }
        public Nullable<int> TotalStrengthOfManPower { get; set; }
        public Nullable<int> ShipmentTerm { get; set; }
        public string For_SOM_CSTNo { get; set; }
        public string For_SOM_VatNo { get; set; }
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
        public Nullable<int> For_Others_TDS_Applicability { get; set; }
        public string For_Others_LowerDeductionCertiNo { get; set; }
        public string BankName { get; set; }
        public string BankBrachName { get; set; }
        public string BankAccNo { get; set; }
        public Nullable<int> TypeofAcc { get; set; }
        public string IFSCode { get; set; }
        public string MICRCODE { get; set; }
        public string Bank_EmailID_UTR { get; set; }
        public string BankingMobileNo { get; set; }
        public Nullable<bool> ApprovedVendor { get; set; }
        public string VendorCode { get; set; }
        public Nullable<bool> Imported { get; set; }
        public string Phone_HO { get; set; }
        public string FAX_HO { get; set; }
        public string Vendor_No_Series { get; set; }
        public string Gen_Posting_Group { get; set; }
        public string VAT_Posting_Group { get; set; }
        public string Service_Entity_Type { get; set; }
        public string Excise_Posting_Group { get; set; }
        public string Tax_Liable { get; set; }
        public string Vendor_Posting_Group { get; set; }
        public string Currency_Code { get; set; }
        public string Authorised_by { get; set; }
        public string Shipment_Term { get; set; }
        public string Mobile_HO { get; set; }
        public string Email_HO { get; set; }
        public Nullable<System.DateTime> Last_date_modified { get; set; }
    
        public virtual ICollection<Busi_Annul_Turnover> Busi_Annul_Turnover { get; set; }
        public virtual ICollection<Busi_Annul_Turnover> Busi_Annul_Turnover1 { get; set; }
        public virtual ICollection<Busi_Cust_Ref> Busi_Cust_Ref { get; set; }
    }
}
