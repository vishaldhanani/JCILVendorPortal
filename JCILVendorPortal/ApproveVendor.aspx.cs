using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using VendorLib;
using JCILVendorPortal.Serv_Vendor;
using System.Net;
using System.Text;
using System.Web.Script.Serialization;
using JCILVendorPortal.CodeUnit_AllFuncs;
using System.Data;

namespace JCILVendorPortal
{
    public partial class ApproveVendor : System.Web.UI.Page
    {
        string no = "";
        string venrID = "", venrcode = "";
        protected void Page_Init(object sender, EventArgs e)
        {
            try
            {
                SessionManager.CheckUserSession(HttpContext.Current, ConfigurationManager.AppSettings["DefaultLoginPage"]);
            }
            catch (Exception ex)
            {

            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["VendorName"] == null)
                {
                    Response.Redirect(ConfigurationManager.AppSettings["DefaultLoginPage"]);
                }
                else
                {

                    SetInitialRow();
                    lblSoRef.Visible = false;
                    lblBusiness.Visible = false;
                    lblTitle.Visible = false;
                    MaintainLogHistory();
                    CallAlldropdown();
                    // MAIN USER LOG SUMMARY
                    if (Request.QueryString["ID"] != "" && Request.QueryString["VendorCode"] != "" && Request.QueryString["VendorCode"] != null && Request.QueryString["ID"] != null)
                    {
                        GetFullRecord(Request.QueryString["VendorCode"], Request.QueryString["ID"]);
                    }
                }
            }
            venrID = Request.QueryString["ID"];
            venrcode = Request.QueryString["VendorCode"];
        }

        public void CallAlldropdown()
        {
            // GetCityoffice();
            // GetCityWorkoffice();
            GetStateoffice();
            //GetStateworkshop();
            BindVendorNoSeries();
            GetPaymenttemrs();
            GetCountryOffice();
            // GetCountryWorkShop();
            AuthorisedUser();
            CurrencyCode();
            ExciseBusinessPostingGroup();
            GeneralBusinessPostingGroup();
            ServiceEntityType();
            VATbusinessPostingGroup();
            ShipmentMethod();
            GetYearList1();
            GetYearList2();
            GetYearList3();
            VendorPostingGroup();
            GetPinCodeoffice();
        }

        public void GetPinCodeoffice()
        {
            using (EDMXConnectionString context = new EDMXConnectionString())
            {
                IEnumerable<GetCity_Result> Details = context.Database.SqlQuery
                                                                  <GetCity_Result>("exec NAV_PINCode ").ToList();

                drpPinCode.DataValueField = "Code";
                drpPinCode.DataTextField = "Code";
                drpPinCode.DataSource = Details;
                drpPinCode.DataBind();
            }
            drpPinCode.Items.Insert(0, new ListItem("-Select-", "0"));
        }

        public void BindVendorNoSeries()
        {
            using (EDMXConnectionString context = new EDMXConnectionString())
            {
                IEnumerable<Vendor_NoSeries_Result3> empDetails = context.Database.SqlQuery
                                                                  <Vendor_NoSeries_Result3>("exec Vendor_NoSeries ").ToList();

                VendorNoSeries.DataValueField = "Series_Code";
                VendorNoSeries.DataTextField = "Description";
                VendorNoSeries.DataSource = empDetails;
                VendorNoSeries.DataBind();
            }
            VendorNoSeries.Items.Insert(0, new ListItem("-Select-", "0"));
        }

        public void GetCountryOffice()
        {
            using (EDMXConnectionString context = new EDMXConnectionString())
            {
                IEnumerable<GetCountry_Result> Details = context.Database.SqlQuery
                                                                  <GetCountry_Result>("exec GetCountry ").ToList();

                drpCountryOffice.DataValueField = "Code";
                drpCountryOffice.DataTextField = "Name";
                drpCountryOffice.DataSource = Details;
                drpCountryOffice.DataBind();
            }
            drpCountryOffice.Items.Insert(0, new ListItem("-Select-", "0"));
        }

        public void AuthorisedUser()
        {
            using (EDMXConnectionString context = new EDMXConnectionString())
            {
                IEnumerable<NAV_AuthorisedBy_Result> Details = context.Database.SqlQuery
                                                                  <NAV_AuthorisedBy_Result>("exec NAV_AuthorisedBy ").ToList();

                drpAuthorisedby.DataValueField = "Code";
                drpAuthorisedby.DataTextField = "Name";
                drpAuthorisedby.DataSource = Details;
                drpAuthorisedby.DataBind();
            }
            drpAuthorisedby.Items.Insert(0, new ListItem("-Select-", "0"));
        }

        public void CurrencyCode()
        {
            using (EDMXConnectionString context = new EDMXConnectionString())
            {
                IEnumerable<NAV_CurrencyCode_Result> Details = context.Database.SqlQuery
                                                                  <NAV_CurrencyCode_Result>("exec NAV_CurrencyCode ").ToList();

                drpCurrencyCode.DataValueField = "Code";
                drpCurrencyCode.DataTextField = "Description";
                drpCurrencyCode.DataSource = Details;
                drpCurrencyCode.DataBind();
            }
            drpCurrencyCode.Items.Insert(0, new ListItem("-Select-", "0"));
        }

        public void GetFullRecord(string Vendorcode, string vendorid)
        {
            int venid = Convert.ToInt32(vendorid);
            using (var context = new EDMXConnectionString())
            {
                VendorRegistration v = new VendorRegistration();// make object of table
                v = context.VendorRegistrations.First(a => a.VendorCode == Vendorcode && a.ID == venid);
                //General Details TAB Fill
                if (v.VendorName_HO != "" && v.VendorName_HO != null)
                {
                    txtNameOffice.Text = v.VendorName_HO;
                }
                if (v.SourceRef == 1)
                {
                    chk_Self.Checked = true;
                }
                if (v.SourceRef == 2)
                {
                    txtInquiry.Text = v.SourceRefInquiryBy;
                    chk_InquiryByJCIL.Checked = true;
                }
                if (v.SourceRef == 3)
                {
                    txtExtrnCnct.Text = v.SourceRefExternalContNo;
                    chk_AnRef.Checked = true;
                    txtExtrnName.Text = v.SourceRefExternal;
                    txtExtrnOrg.Text = v.SourceRefExternalOrgName;
                }

                chk_Manufac.Checked = v.TypeofBusi == 1 ? true : false;
                chk_AgentDT.Checked = v.TypeofBusi == 2 ? true : false;
                chk_Stockist.Checked = v.TypeofBusi == 3 ? true : false;
                chk_ServiceProvider.Checked = v.TypeofBusi == 4 ? true : false;
                chk_Supply.Checked = v.TypeofBusi == 5 ? true : false;

                chk_Public.Checked = v.Title == 1 ? true : false;
                chk_Part.Checked = v.Title == 2 ? true : false;
                chk_Prop.Checked = v.Title == 3 ? true : false;
                chk_LLP.Checked = v.Title == 4 ? true : false;

                //if (!string.IsNullOrEmpty(v.PremisesNo_HO))
                //{
                //    txtPremiseOffice.Text = v.PremisesNo_HO;
                //}
                if (v.Address_1_HO != "" && v.Address_1_HO != null)
                {
                    txtLine1Office.Text = v.Address_1_HO;
                }
                if (v.Address_2_HO != "" && v.Address_2_HO != null)
                {
                    txtLine2Office.Text = v.Address_2_HO;
                }
                //if (!string.IsNullOrEmpty(v.City_HO))
                //{
                //    drpCityOffice.SelectedItem.Text = v.City_HO;
                //}
                if (!string.IsNullOrEmpty(v.StateRegion_HO))
                {
                    drpStateOffice.SelectedItem.Text = v.StateRegion_HO;
                }
                if (v.PinCode_HO != null)
                {
                    drpPinCode.SelectedValue = v.PinCode_HO.ToString();
                }
                if (v.Country_HO != null)
                {
                    drpCountryOffice.SelectedValue = v.Country_HO.ToString();
                }

                //ADDRESS OF WORKSHOP* Filled from DB
                //if (!string.IsNullOrEmpty(v.VendorName_WS))
                //{
                //    txtNameWorkshop.Text = v.VendorName_WS;
                //}
                //if (!string.IsNullOrEmpty(v.PremisesNo_WS))
                //{
                //    txtPremiseWorkshop.Text = v.PremisesNo_WS;
                //}
                //if (!string.IsNullOrEmpty(v.Address_1_WS))
                //{
                //    txtLine1Workshop.Text = v.Address_1_WS;
                //}
                //if (!string.IsNullOrEmpty(v.Address_2_WS))
                //{
                //    txtLine2Workshop.Text = v.Address_2_WS;
                //}
                //if (!string.IsNullOrEmpty(v.City_WS))
                //{
                //    drpCityWorkshop.SelectedItem.Text = v.City_WS;
                //}
                //if (!string.IsNullOrEmpty(v.StateRegion_WS))
                //{
                //    drpStateWorkshop.SelectedItem.Text = v.StateRegion_WS;
                //}
                //General Details TAB Fill

                //Contact Details TAB Fill

                if (!string.IsNullOrEmpty(v.WebSite))
                {
                    txtURL.Text = v.WebSite;
                }
                if (!string.IsNullOrEmpty(v.PaymentTerm))
                {
                    drp_PaymentTerm.SelectedItem.Text = v.PaymentTerm;
                }
                if (!string.IsNullOrEmpty(Convert.ToString(v.TotalStrengthOfManPower)))
                {
                    txt_TotalStrengthofManpower.Text = Convert.ToString(v.TotalStrengthOfManPower);
                }

                //if (!string.IsNullOrEmpty(Convert.ToString(v.ShipmentTerm)))
                //{
                //    if (v.ShipmentTerm == 1)
                //    {
                //        chk_CIF.Checked = true;
                //    }
                //    else if(v.ShipmentTerm == 2)
                //    {
                //        chk_CNF.Checked = true; ;
                //    }
                //    else if (v.ShipmentTerm == 3)
                //    {
                //        chk_FOB.Checked = true; ;
                //    }
                //    else if (v.ShipmentTerm == 4)
                //    {
                //        chk_FOR.Checked = true; ;
                //    }
                //    else if (v.ShipmentTerm == 5)
                //    {
                //        chk_Exworks.Checked = true; ;
                //    }
                //}

                if (!string.IsNullOrEmpty(v.Con_PropDirPar_Name))
                {
                    txtDirectName.Text = v.Con_PropDirPar_Name;
                }
                if (!string.IsNullOrEmpty(v.Con_PropDirPar_PhoneNo))
                {
                    txtDirectPhone.Text = v.Con_PropDirPar_PhoneNo;
                }
                if (!string.IsNullOrEmpty(v.Con_PropDirPar_PhoneNo))
                {
                    txtDirectMobile.Text = v.Con_PropDirPar_PhoneNo;
                }
                if (!string.IsNullOrEmpty(v.Con_PropDirPar_EmailID))
                {
                    txtDirectEmail.Text = v.Con_PropDirPar_EmailID;
                }

                if (!string.IsNullOrEmpty(v.Con_SalesDep_Name))
                {
                    txtSaleName.Text = v.Con_SalesDep_Name;
                }
                if (!string.IsNullOrEmpty(v.Con_SalesDep_PhoneNo))
                {
                    txtSalePhone.Text = v.Con_SalesDep_PhoneNo;
                }
                if (!string.IsNullOrEmpty(v.Con_SalesDep_MobileNo))
                {
                    txtSaleMobile.Text = v.Con_SalesDep_MobileNo;
                }
                if (!string.IsNullOrEmpty(v.Con_SalesDep_EmailID))
                {
                    txtSaleEmail.Text = v.Con_SalesDep_EmailID;
                }

                if (!string.IsNullOrEmpty(v.Con_AccDep_Name))
                {
                    txtAccountName.Text = v.Con_AccDep_Name;
                }
                if (!string.IsNullOrEmpty(v.Con_AccDep_PhoneNo))
                {
                    txtAccountPhone.Text = v.Con_AccDep_PhoneNo;
                }
                if (!string.IsNullOrEmpty(v.Con_AccDep_MobileNo))
                {
                    txtAccountMobile.Text = v.Con_AccDep_MobileNo;
                }
                if (!string.IsNullOrEmpty(v.Con_AccDep_EmailID))
                {
                    txtAccountEmail.Text = v.Con_AccDep_EmailID;
                }


                //Tax Details Fill for For Supplier of Material
                if (!string.IsNullOrEmpty(v.For_SOM_CSTNo))
                {
                    txtCST.Text = v.For_SOM_CSTNo;
                }
                if (!string.IsNullOrEmpty(v.For_SOM_VatNo))
                {
                    txtVAT.Text = v.For_SOM_VatNo;
                }
                if (!string.IsNullOrEmpty(v.For_SOM_PanNo))
                {
                    txtPAN.Text = v.For_SOM_PanNo;
                }
                if (!string.IsNullOrEmpty(v.For_SOM_TanNo))
                {
                    txtTAN.Text = v.For_SOM_TanNo;
                }
                if (v.For_SOM_MicroSmallMediumEnterprise != null)
                {
                    if (Convert.ToBoolean(v.For_SOM_MicroSmallMediumEnterprise) == true)
                    {
                        chk_Yes.Checked = true;
                    }
                    else if (Convert.ToBoolean(v.For_SOM_MicroSmallMediumEnterprise) == false)
                    {
                        chk_No.Checked = true;
                    }
                    else
                    {
                        chk_Yes.Checked = false;
                        chk_No.Checked = false;
                    }
                }
                //if (!string.IsNullOrEmpty(v.For_SOM_MSMERegNo))
                //{
                //    txtMSMERegNo.Text = v.For_SOM_MSMERegNo;
                //}
                if (v.For_SOM_RegisteredwithExcise != null)
                {
                    if (Convert.ToString(v.For_SOM_RegisteredwithExcise) == "Yes")
                    {
                        chk_reg_Yes.Checked = true;
                    }
                    else if (Convert.ToString(v.For_SOM_RegisteredwithExcise) == "No")
                    {
                        chk_reg_No.Checked = true;
                    }
                    else
                    {
                        chk_reg_Yes.Checked = false;
                        chk_reg_No.Checked = false;
                    }
                }

                if (!string.IsNullOrEmpty(v.For_SOM_ECCNo))
                {
                    txt_ECCNo.Text = v.For_SOM_ECCNo;
                }
                if (!string.IsNullOrEmpty(v.For_SOM_ExciseRange))
                {
                    txt_ExciseRange.Text = v.For_SOM_ExciseRange;
                }
                if (!string.IsNullOrEmpty(v.For_SOM_ExciseDivision))
                {
                    txt_ExciseDivision.Text = v.For_SOM_ExciseDivision;
                }
                if (!string.IsNullOrEmpty(v.For_SOM_ExciseCollectorate))
                {
                    txt_ExciseCollectorate.Text = v.For_SOM_ExciseCollectorate;
                }
                //Tax Details Fill for For Supplier of Material

                //Tax Details Fill for For Others
                //if (!string.IsNullOrEmpty(v.For_Others_PanNo))
                //{
                //    txtPANOthr.Text = v.For_Others_PanNo;
                //}
                if (!string.IsNullOrEmpty(v.For_Others_ServcieTaxRegNo))
                {
                    txt_ServiceTaxRegNo.Text = v.For_Others_ServcieTaxRegNo;
                }
                if (!string.IsNullOrEmpty(v.For_Others_PFRegNo))
                {
                    txt_PFRegNo.Text = v.For_Others_PFRegNo;
                }
                if (!string.IsNullOrEmpty(v.For_Others_ESIRegNo))
                {
                    txt_ESIRegNo.Text = v.For_Others_ESIRegNo;
                }
                if (!string.IsNullOrEmpty(v.For_Others_ContractLicenseNo))
                {
                    txtContractLicenseNo.Text = v.For_Others_ContractLicenseNo;
                }

                if (!string.IsNullOrEmpty(Convert.ToString(v.For_Others_TDS_Applicability)))
                {
                    if (v.For_Others_TDS_Applicability == 1)
                    {
                        chk_TDS_yes.Checked = true;
                    }
                    else if (v.For_Others_TDS_Applicability == 2)
                    {
                        chk_TDS_No.Checked = true;
                    }
                    else if (v.For_Others_TDS_Applicability == 3)
                    {
                        chk_TDS_Lower.Checked = true;
                    }
                    else
                    {
                        chk_TDS_yes.Checked = false;
                        chk_TDS_No.Checked = false;
                        chk_TDS_Lower.Checked = false;
                    }
                }

                if (!string.IsNullOrEmpty(v.For_Others_LowerDeductionCertiNo))
                {
                    txt_LowerDeductionCertiNo.Text = v.For_Others_LowerDeductionCertiNo;
                }
                //Tax Details Fill for For Others

                //Bank Details Fill
                if (!string.IsNullOrEmpty(v.BankName))
                {
                    txtBankName.Text = v.BankName;
                }
                if (!string.IsNullOrEmpty(v.BankBrachName))
                {
                    txtBAnkBrnch.Text = v.BankBrachName;
                }
                if (!string.IsNullOrEmpty(v.BankAccNo))
                {
                    txtAcntNo.Text = v.BankAccNo;
                }
                if (!string.IsNullOrEmpty(Convert.ToString(v.TypeofAcc)))
                {
                    if (v.TypeofAcc == 1)
                    {
                        chk_TypeofSa.Checked = true;
                    }
                    else if (v.TypeofAcc == 2)
                    {
                        chk_TypeofCur.Checked = true;
                    }
                    else if (v.TypeofAcc == 3)
                    {
                        chk_TypeofCC.Checked = true;
                    }
                    else
                    {
                        chk_TypeofSa.Checked = false;
                        chk_TypeofCur.Checked = false;
                        chk_TypeofCC.Checked = false;
                    }
                }

                if (!string.IsNullOrEmpty(v.IFSCode))
                {
                    txtIFSC.Text = v.IFSCode;
                }
                //if (!string.IsNullOrEmpty(v.MICRCODE))
                //{
                //    txtMICR.Text = v.MICRCODE;
                //}
                if (!string.IsNullOrEmpty(v.Bank_EmailID_UTR))
                {
                    txtEmailUTR.Text = v.Bank_EmailID_UTR;
                }
                if (!string.IsNullOrEmpty(v.BankingMobileNo))
                {
                    txtMobileUTR.Text = v.BankingMobileNo;
                }
                TextBox100.Text = v.For_SOM_MSMERegNo;
                txtFaxNoOffice.Text = v.FAX_HO != "" ? v.FAX_HO : "";
                txtLine3Office.Text = v.Phone_HO != "" ? v.Phone_HO : "";
                txtMobileNoOffice.Text = v.Mobile_HO != "" ? v.Mobile_HO : "";
                txtEmailIDOffice.Text = v.Email_HO != "" ? v.Email_HO : "";
                drpShipmentTerm.SelectedValue = v.Shipment_Term != "" ? v.Shipment_Term : "";
                VendorNoSeries.SelectedValue = v.Vendor_No_Series != "" ? v.Vendor_No_Series : "";
                drpGenBusPostingGroup.SelectedValue = v.Gen_Posting_Group != "" ? v.Gen_Posting_Group : "";
                drpVATBusPostingGroup.SelectedValue = v.VAT_Posting_Group != "" ? v.VAT_Posting_Group : "";
                drpServiceEntityType.SelectedValue = v.Service_Entity_Type != "" ? v.Service_Entity_Type : "";
                drpExcisePostingGroup.SelectedValue = v.Excise_Posting_Group != "" ? v.Excise_Posting_Group : "";
                drpVendorPostingGroup.SelectedValue = v.Vendor_Posting_Group != "" ? v.Vendor_Posting_Group : "";
                drpCurrencyCode.SelectedValue = v.Currency_Code != "" ? v.Currency_Code : "";
                drpAuthorisedby.SelectedValue = v.Authorised_by != "" ? v.Authorised_by : "";
                chk_TaxLiable.Checked = v.Tax_Liable == "Yes" ? true : false;

                //Bank Details Fill

            }
            using (var context = new EDMXConnectionString())
            {

                var business = context.Busi_Annul_Turnover.SingleOrDefault(a => a.VendorId == venid);
                if (business != null)
                {
                    drpYear1.SelectedValue = business.YearFirst != null ? Convert.ToString(business.YearFirst) : "";
                    drpYear2.SelectedValue = business.YearSecond != null ? Convert.ToString(business.YearSecond) : "";
                    drpYear3.SelectedValue = business.YearThird != null ? Convert.ToString(business.YearThird) : "";

                    txtAmount1.Text = business.YearFirstTurnOver != 0.00m ? Convert.ToString(business.YearFirstTurnOver) : "";
                    txtAmount2.Text = business.YearSecondTurnOver != 0.00m ? Convert.ToString(business.YearSecondTurnOver) : "";
                    txtAmount3.Text = business.YearThirdTurnOver != 0.00m ? Convert.ToString(business.YearThirdTurnOver) : "";
                }
            }
            using (var context = new EDMXConnectionString())
            {
                // Busi_Cust_Ref business_ref = new Busi_Cust_Ref();
                var business_ref = context.Busi_Cust_Ref.Where(a => a.VendorID == venid).ToList();
                var recordCount = context.Busi_Cust_Ref.Where(a => a.VendorID == venid).Count();
                if (business_ref != null)
                {
                    for (int i = 0; i <= recordCount - 1; i++)
                    {
                        TextBox box1 = (TextBox)grd_CustomerDetails.Rows[i].Cells[1].FindControl("txtCustomerName");
                        TextBox box2 = (TextBox)grd_CustomerDetails.Rows[i].Cells[2].FindControl("txtLocationName");
                        TextBox box3 = (TextBox)grd_CustomerDetails.Rows[i].Cells[3].FindControl("txtContactPersonName");
                        TextBox box4 = (TextBox)grd_CustomerDetails.Rows[i].Cells[3].FindControl("txtContactPersonNumber");

                        box1.Text = business_ref[i].Customer_Name;
                        box2.Text = business_ref[i].Location;
                        box3.Text = business_ref[i].Contact_Person;
                        box4.Text = Convert.ToString(business_ref[i].Contact_Number);
                    }
                }
            }

        }

        public void ExciseBusinessPostingGroup()
        {
            using (EDMXConnectionString context = new EDMXConnectionString())
            {
                IEnumerable<NAV_ExciseBusPostingGroup_Result> Details = context.Database.SqlQuery
                                                                  <NAV_ExciseBusPostingGroup_Result>("exec NAV_ExciseBusPostingGroup ").ToList();

                drpExcisePostingGroup.DataValueField = "Code";
                drpExcisePostingGroup.DataTextField = "Description";
                drpExcisePostingGroup.DataSource = Details;
                drpExcisePostingGroup.DataBind();
            }
            drpExcisePostingGroup.Items.Insert(0, new ListItem("-Select-", "0"));
        }

        public void GeneralBusinessPostingGroup()
        {
            using (EDMXConnectionString context = new EDMXConnectionString())
            {
                IEnumerable<NAV_GeneralBusinessPostingGroup_Result> Details = context.Database.SqlQuery
                                                                  <NAV_GeneralBusinessPostingGroup_Result>("exec NAV_GeneralBusinessPostingGroup ").ToList();

                drpGenBusPostingGroup.DataValueField = "Code";
                drpGenBusPostingGroup.DataTextField = "Description";
                drpGenBusPostingGroup.DataSource = Details;
                drpGenBusPostingGroup.DataBind();
            }
            drpGenBusPostingGroup.Items.Insert(0, new ListItem("-Select-", "0"));
        }

        public void ServiceEntityType()
        {
            using (EDMXConnectionString context = new EDMXConnectionString())
            {
                IEnumerable<NAV_ServiceEntityType_Result> Details = context.Database.SqlQuery
                                                                  <NAV_ServiceEntityType_Result>("exec NAV_ServiceEntityType ").ToList();

                drpServiceEntityType.DataValueField = "Code";
                drpServiceEntityType.DataTextField = "Description";
                drpServiceEntityType.DataSource = Details;
                drpServiceEntityType.DataBind();
            }
            drpServiceEntityType.Items.Insert(0, new ListItem("-Select-", "0"));
        }

        public void ShipmentMethod()
        {
            using (EDMXConnectionString context = new EDMXConnectionString())
            {
                IEnumerable<NAV_ShipmentMethod_Result> Details = context.Database.SqlQuery
                                                                  <NAV_ShipmentMethod_Result>("exec NAV_ShipmentMethod ").ToList();

                drpShipmentTerm.DataValueField = "Code";
                drpShipmentTerm.DataTextField = "Description";
                drpShipmentTerm.DataSource = Details;
                drpShipmentTerm.DataBind();
            }
            drpShipmentTerm.Items.Insert(0, new ListItem("-Select-", "0"));
        }

        public void VATbusinessPostingGroup()
        {
            using (EDMXConnectionString context = new EDMXConnectionString())
            {
                IEnumerable<NAV_VatBusinessPostingGroup_Result> Details = context.Database.SqlQuery
                                                                  <NAV_VatBusinessPostingGroup_Result>("exec NAV_VatBusinessPostingGroup").ToList();

                drpVATBusPostingGroup.DataValueField = "Code";
                drpVATBusPostingGroup.DataTextField = "Description";
                drpVATBusPostingGroup.DataSource = Details;
                drpVATBusPostingGroup.DataBind();
            }
            drpVATBusPostingGroup.Items.Insert(0, new ListItem("-Select-", "0"));
        }

        public void VendorPostingGroup()
        {
            using (EDMXConnectionString context = new EDMXConnectionString())
            {
                IEnumerable<NAV_VendorPostingGroup_Result> Details = context.Database.SqlQuery
                                                                  <NAV_VendorPostingGroup_Result>("exec NAV_VendorPostingGroup").ToList();

                drpVendorPostingGroup.DataValueField = "Code";
                drpVendorPostingGroup.DataTextField = "Code";
                drpVendorPostingGroup.DataSource = Details;
                drpVendorPostingGroup.DataBind();
            }
            drpVendorPostingGroup.Items.Insert(0, new ListItem("-Select-", "0"));
        }

        public void GetYearList1()
        {
            using (EDMXConnectionString context = new EDMXConnectionString())
            {
                IEnumerable<GetYearList_Result> Details = context.Database.SqlQuery
                                                                  <GetYearList_Result>("exec GetYearList").ToList();

                drpYear1.DataValueField = "YearNo";
                drpYear1.DataTextField = "YearNo";
                drpYear1.DataSource = Details;
                drpYear1.DataBind();
            }
            drpYear1.Items.Insert(0, new ListItem("-Select-", "0"));
        }

        public void GetYearList2()
        {
            using (EDMXConnectionString context = new EDMXConnectionString())
            {
                IEnumerable<GetYearList_Result> Details = context.Database.SqlQuery
                                                                  <GetYearList_Result>("exec GetYearList").ToList();

                drpYear2.DataValueField = "YearNo";
                drpYear2.DataTextField = "YearNo";
                drpYear2.DataSource = Details;
                drpYear2.DataBind();
            }
            drpYear2.Items.Insert(0, new ListItem("-Select-", "0"));
        }

        public void GetYearList3()
        {
            using (EDMXConnectionString context = new EDMXConnectionString())
            {
                IEnumerable<GetYearList_Result> Details = context.Database.SqlQuery
                                                                  <GetYearList_Result>("exec GetYearList").ToList();

                drpYear3.DataValueField = "YearNo";
                drpYear3.DataTextField = "YearNo";
                drpYear3.DataSource = Details;
                drpYear3.DataBind();
            }
            drpYear3.Items.Insert(0, new ListItem("-Select-", "0"));
        }

        public void MaintainLogHistory()
        {
            // LOG ALL THE ENTRIES OF THE USER 
            DataLogHistory loghi = new DataLogHistory();
            loghi.LoginUserID = Convert.ToInt32(SessionManager.GetUserID(HttpContext.Current));
            loghi.LoginInTime = System.DateTime.Now;
            loghi.AccessActivity = 2; // Vendor Registion Page access
            int result = DataLogHistory.InsertLogHistory(loghi);
            // dont close the when page is not accessed.
            //SessionManager.AddToUserLogID(HttpContext.Current, result);
        }

        public void GetPaymenttemrs()
        {
            using (EDMXConnectionString context = new EDMXConnectionString())
            {
                IEnumerable<GetPaymentTerms_Result> Details = context.Database.SqlQuery
                                                                  <GetPaymentTerms_Result>("exec GetPaymentTerms ").ToList();

                drp_PaymentTerm.DataValueField = "Code";
                drp_PaymentTerm.DataTextField = "Description";
                drp_PaymentTerm.DataSource = Details;
                drp_PaymentTerm.DataBind();
            }

        }

        public void GetStateoffice()
        {
            using (EDMXConnectionString context = new EDMXConnectionString())
            {
                IEnumerable<GetState_Result> Details = context.Database.SqlQuery
                                                                  <GetState_Result>("exec GetState ").ToList();

                drpStateOffice.DataValueField = "Code";
                drpStateOffice.DataTextField = "Description";
                drpStateOffice.DataSource = Details;
                drpStateOffice.DataBind();
            }
        }

        private void SetInitialRow()
        {
            DataTable dt = new DataTable();
            DataRow dr = null;
            for (int i = 0; i < Convert.ToInt16(ConfigurationManager.AppSettings["CustomerRefDataLoad"]); i++)
            {
                if (i == 0)
                {
                    dt.Columns.Add(new DataColumn("RowNumber", typeof(string)));
                    dt.Columns.Add(new DataColumn("Column1", typeof(string)));
                    dt.Columns.Add(new DataColumn("Column2", typeof(string)));
                    dt.Columns.Add(new DataColumn("Column3", typeof(string)));
                    dt.Columns.Add(new DataColumn("Column4", typeof(string)));
                }
                dr = dt.NewRow();
                dr["RowNumber"] = i + 1;
                dr["Column1"] = string.Empty;
                dr["Column2"] = string.Empty;
                dr["Column3"] = string.Empty;
                dr["Column4"] = string.Empty;
                dt.Rows.Add(dr);
                //dr = dt.NewRow();
            }
            //Store the DataTable in ViewState
            ViewState["CurrentTable"] = dt;

            grd_CustomerDetails.DataSource = dt;
            grd_CustomerDetails.DataBind();
        }

        private void AddNewRowToGrid()
        {
            int rowIndex = 0;

            if (ViewState["CurrentTable"] != null)
            {
                DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable"];
                DataRow drCurrentRow = null;
                if (dtCurrentTable.Rows.Count > 0)
                {
                    for (int i = 1; i <= dtCurrentTable.Rows.Count; i++)
                    {
                        //extract the TextBox values
                        TextBox box1 = (TextBox)grd_CustomerDetails.Rows[rowIndex].Cells[1].FindControl("txtCustomerName");
                        TextBox box2 = (TextBox)grd_CustomerDetails.Rows[rowIndex].Cells[2].FindControl("txtLocationName");
                        TextBox box3 = (TextBox)grd_CustomerDetails.Rows[rowIndex].Cells[3].FindControl("txtContactPersonName");
                        TextBox box4 = (TextBox)grd_CustomerDetails.Rows[rowIndex].Cells[4].FindControl("txtContactPersonNumber");

                        drCurrentRow = dtCurrentTable.NewRow();
                        drCurrentRow["RowNumber"] = i + 1;

                        dtCurrentTable.Rows[i - 1]["Column1"] = box1.Text;
                        dtCurrentTable.Rows[i - 1]["Column2"] = box2.Text;
                        dtCurrentTable.Rows[i - 1]["Column3"] = box3.Text;
                        dtCurrentTable.Rows[i - 1]["Column4"] = box4.Text;

                        rowIndex++;
                    }
                    dtCurrentTable.Rows.Add(drCurrentRow);
                    ViewState["CurrentTable"] = dtCurrentTable;

                    grd_CustomerDetails.DataSource = dtCurrentTable;
                    grd_CustomerDetails.DataBind();
                }
            }
            else
            {
                Response.Write("ViewState is null");
            }

            //Set Previous Data on Postbacks
            SetPreviousData();
        }

        private void SetPreviousData()
        {
            int rowIndex = 0;
            if (ViewState["CurrentTable"] != null)
            {
                DataTable dt = (DataTable)ViewState["CurrentTable"];
                if (dt.Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        TextBox box1 = (TextBox)grd_CustomerDetails.Rows[rowIndex].Cells[1].FindControl("txtCustomerName");
                        TextBox box2 = (TextBox)grd_CustomerDetails.Rows[rowIndex].Cells[2].FindControl("txtLocationName");
                        TextBox box3 = (TextBox)grd_CustomerDetails.Rows[rowIndex].Cells[3].FindControl("txtContactPersonName");
                        TextBox box4 = (TextBox)grd_CustomerDetails.Rows[rowIndex].Cells[4].FindControl("txtContactPersonNumber");

                        box1.Text = dt.Rows[i]["Column1"].ToString();
                        box2.Text = dt.Rows[i]["Column2"].ToString();
                        box3.Text = dt.Rows[i]["Column3"].ToString();
                        box4.Text = dt.Rows[i]["Column4"].ToString();

                        rowIndex++;
                    }
                }
            }
        }

        protected void btnapprv_Click(object sender, EventArgs e)
        {
            try
            {
                if (hf1.Value == "1" && hf2.Value == "1" && hf3.Value == "1" && hf4.Value == "1" && hf5.Value == "1")
                {
                    int venid = Convert.ToInt32(venrID);
                    using (var context = new EDMXConnectionString())
                    {
                        var v = context.VendorRegistrations.SingleOrDefault(a => a.ID == venid);
                        if (v != null)
                        {
                            v.ApprovedVendor = true;
                            context.SaveChanges();
                        }
                    }
                    NetworkCredential NetCredential = new NetworkCredential();
                    NetCredential.UserName = SessionManager.GetNAVUserName(HttpContext.Current);
                    NetCredential.Password = SessionManager.GetNAVUserPassword(HttpContext.Current);

                    WS_NAV_Vendor_Service objservend = new WS_NAV_Vendor_Service();
                    objservend.UseDefaultCredentials = true;
                    objservend.Credentials = NetCredential;
                    List<WS_NAV_Vendor_Filter> WList = new List<WS_NAV_Vendor_Filter>();
                    WS_NAV_Vendor_Filter wField = new WS_NAV_Vendor_Filter();
                    WList.Add(new WS_NAV_Vendor_Filter() { Field = WS_NAV_Vendor_Fields.No, Criteria = venrcode });
                    WS_NAV_Vendor[] vendList = objservend.ReadMultiple(WList.ToArray(), null, 1);
                    if (vendList.Length > 0)
                    {
                        WS_NAV_Vendor vendnew = new WS_NAV_Vendor();
                        string key = vendList[0].Key;
                        string recid = objservend.GetRecIdFromKey(key);
                        vendnew = objservend.ReadByRecId(recid);
                        vendnew.Blocked = 0;
                        objservend.Update(ref vendnew);
                    }
                    var message1 = new JavaScriptSerializer().Serialize(venrcode + " has been Approved.!!!");
                    var script1 = string.Format("alert({0});window.location='RegisteredVendorList.aspx';", message1);
                    ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "", script1, true);
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "", "alert('Please check all detailed information!!!');", true);
                }

            }
            catch (Exception ex)
            {
                var message1 = new JavaScriptSerializer().Serialize(ex.Message.ToString());
                var script1 = string.Format("alert({0});", message1);
                ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "", script1, true);
            }
        }

        protected void btnFeedback_Click(object sender, EventArgs e)
        {
            //try
            //{
            //    int venid = Convert.ToInt32(venrID);
            //    using (var context = new EDMXConnectionString())
            //    {
            //        var v = context.VendorRegistrations.SingleOrDefault(a => a.ID == venid);
            //        if (v != null)
            //        {
            //            v.FeedBack = true;
            //            context.SaveChanges();
            //        }
            //    }
            //    var script1 = string.Format("window.location='RegisteredVendorList.aspx';");
            //    ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "", script1, true);
            //}
            //catch (Exception ex)
            //{
            //    var message1 = new JavaScriptSerializer().Serialize(ex.Message.ToString());
            //    var script1 = string.Format("alert({0});", message1);
            //    ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "", script1, true);
            //}
        }

    }
}