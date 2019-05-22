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
using System.Web.Services;

namespace JCILVendorPortal
{
    public partial class VendorRegiProcess : System.Web.UI.Page
    {
        string no = "";
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
                    Label mpLabel = (Label)Page.Master.FindControl("lblPageCenterHeader");

                    if (mpLabel != null)
                    {
                        mpLabel.Text = "Vendor Registration";
                    }
                    SetInitialRow();
                    lblSoRef.Visible = false;
                    lblBusiness.Visible = false;
                    lblTitle.Visible = false;
                    MaintainLogHistory();
                    CallAlldropdown();
                    // MAIN USER LOG SUMMARY

                }

            }

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

        public void GetPaymenttemrs()
        {
            using (EDMXConnectionString context = new EDMXConnectionString())
            {
                IEnumerable<GetPaymentTerms_Result> Details = context.Database.SqlQuery
                                                                  <GetPaymentTerms_Result>("exec GetPaymentTerms ").ToList();

                drp_PaymentTerm.DataValueField = "Code";
                drp_PaymentTerm.DataTextField = "Code";
                drp_PaymentTerm.DataSource = Details;
                drp_PaymentTerm.DataBind();
            }
            drp_PaymentTerm.Items.Insert(0, new ListItem("-Select-", "0"));

        }
        //public void GetCityoffice()
        //{
        //    using (EDMXConnectionString context = new EDMXConnectionString())
        //    {
        //        IEnumerable<GetCity_Result> Details = context.Database.SqlQuery
        //                                                          <GetCity_Result>("exec GetCity ").ToList();

        //        drpCityOffice.DataValueField = "Code";
        //        drpCityOffice.DataTextField = "City";
        //        drpCityOffice.DataSource = Details;
        //        drpCityOffice.DataBind();
        //    }
        //    drpCityOffice.Items.Insert(0, new ListItem("-Select-", "0"));
        //}
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
        //public void GetCityWorkoffice()
        //{
        //    using (EDMXConnectionString context = new EDMXConnectionString())
        //    {
        //        IEnumerable<GetCity_Result> Details = context.Database.SqlQuery
        //                                                          <GetCity_Result>("exec GetCity ").ToList();

        //        drpCityWorkshop.DataValueField = "Code";
        //        drpCityWorkshop.DataTextField = "City";
        //        drpCityWorkshop.DataSource = Details;
        //        drpCityWorkshop.DataBind();
        //    }
        //    drpCityWorkshop.Items.Insert(0, new ListItem("-Select-", "0"));
        //}
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
            drpStateOffice.Items.Insert(0, new ListItem("-Select-", "0"));
        }
        //public void GetStateworkshop()
        //{
        //    using (EDMXConnectionString context = new EDMXConnectionString())
        //    {
        //        IEnumerable<GetState_Result> Details = context.Database.SqlQuery
        //                                                          <GetState_Result>("exec GetState ").ToList();

        //        drpStateWorkshop.DataValueField = "Code";
        //        drpStateWorkshop.DataTextField = "Description";
        //        drpStateWorkshop.DataSource = Details;
        //        drpStateWorkshop.DataBind();
        //    }
        //    drpStateWorkshop.Items.Insert(0, new ListItem("-Select-", "0"));
        //}

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
        //public void GetCountryWorkShop()
        //{
        //    using (EDMXConnectionString context = new EDMXConnectionString())
        //    {
        //        IEnumerable<GetCountry_Result> Details = context.Database.SqlQuery
        //                                                          <GetCountry_Result>("exec GetCountry ").ToList();

        //        drpCountryWorkshop.DataValueField = "Code";
        //        drpCountryWorkshop.DataTextField = "Name";
        //        drpCountryWorkshop.DataSource = Details;
        //        drpCountryWorkshop.DataBind();
        //    }
        //    drpCountryWorkshop.Items.Insert(0, new ListItem("-Select-", "0"));
        //}
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
        //public void VendorPostingGroup()
        //{
        //    using (EDMXConnectionString context = new EDMXConnectionString())
        //    {
        //        IEnumerable<nav> Details = context.Database.SqlQuery
        //                                                          <GetYearList_Result>("exec GetYearList").ToList();

        //        drpYear3.DataValueField = "YearNo";
        //        drpYear3.DataTextField = "YearNo";
        //        drpYear3.DataSource = Details;
        //        drpYear3.DataBind();
        //    }
        //}

        protected void btnSave_Click(object sender, EventArgs e)
        {

            bool Completeprocess = true;
            if (chk_Self.Checked != true && chk_InquiryByJCIL.Checked != true && chk_AnRef.Checked != true)
            {
                lblSoRef.Visible = true;
                Completeprocess = false;
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "", "alert('Please select any Source Refrence!!');", true);
            }
            else if (chk_Manufac.Checked != true && chk_AgentDT.Checked != true && chk_Stockist.Checked != true && chk_ServiceProvider.Checked != true && chk_Supply.Checked != true)
            {
                lblBusiness.Visible = true;
                Completeprocess = false;
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "", "alert('Please select any Type of Business!!');", true);
            }
            else if (VendorNoSeries.SelectedItem.Value == "0")
            {
                lblBusiness.Visible = true;
                Completeprocess = false;
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "", "alert('Please select Vendor No. Series.!!');", true);
            }
            else if (chk_Public.Checked != true && chk_Part.Checked != true && chk_Prop.Checked != true && chk_LLP.Checked != true)
            {
                lblTitle.Visible = true;
                Completeprocess = false;
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "", "alert('Please select any Title!!');", true);
            }


            int sourceref = 0;
            if (chk_Self.Checked)
            {
                sourceref = 1;  // Self Introduction
            }
            if (chk_InquiryByJCIL.Checked)
            {
                sourceref = 2; //Inquiry By JCIL

            }
            if (chk_AnRef.Checked)
            {
                sourceref = 3; //Any External Reference
            }
            int typeofbusi = 0;
            if (chk_Manufac.Checked)
            {
                typeofbusi = 1; // Manufacturer
            }
            if (chk_AgentDT.Checked)
            {
                typeofbusi = 2; //Agent/Dealer/Trader
            }
            if (chk_Stockist.Checked)
            {
                typeofbusi = 3; //Stockist
            }
            if (chk_ServiceProvider.Checked)
            {
                typeofbusi = 4; //Service Provider
            }
            if (chk_Supply.Checked)
            {
                typeofbusi = 5;  //Supply & Service Provider
            }
            int tit = 0;
            if (chk_Public.Checked)
            {
                tit = 1; //Public Ltd. Co.

            }

            if (chk_Part.Checked)
            {
                tit = 2; //Partnership Firm

            }
            if (chk_Prop.Checked)
            {
                tit = 3; //Proprietorship Firm

            }
            if (chk_LLP.Checked)
            {
                tit = 4; // LLP
            }
            bool microsmallmed = false;
            if (chk_Yes.Checked)
            {
                microsmallmed = true;
            }
            string regyes = "No";
            if (chk_reg_Yes.Checked)
            {
                regyes = "Yes";
            }
            int typeofAccount = 0;
            if (chk_TypeofSa.Checked)
            {
                typeofAccount = 1;
            }
            if (chk_TypeofCur.Checked)
            {
                typeofAccount = 2;

            }
            if (chk_TypeofCC.Checked)
            {
                typeofAccount = 3;
            }
            bool tdsapplicability = false;
            if (chk_TDS_yes.Checked)
            {
                tdsapplicability = true;
            }

            if (Completeprocess == true)
            {
                bool finalprocesscompleted = false;
                int vendcreatedid;
                try
                {
                    if (finalprocesscompleted == false)
                    {
                        NetworkCredential NetCredentials = new NetworkCredential();
                        NetCredentials.UserName = SessionManager.GetNAVUserName(HttpContext.Current);
                        NetCredentials.Password = SessionManager.GetNAVUserPassword(HttpContext.Current);
                        string KEY = string.Empty;
                        KEY = Convert.ToString(ViewState["Key"]);
                        if (KEY == "")
                        {
                            Web_Order_Mail objser = new Web_Order_Mail();
                            objser.UseDefaultCredentials = true;
                            objser.Credentials = NetCredentials;
                            no = objser.GetVendorNoSeries(VendorNoSeries.SelectedValue);
                            objser = null;

                            //  Vendor Creation For Nav.
                            WS_NAV_Vendor vend = new WS_NAV_Vendor();
                            vend.No = no;

                            WS_NAV_Vendor_Service objvend = new WS_NAV_Vendor_Service();
                            objvend.UseDefaultCredentials = true;
                            objvend.Credentials = NetCredentials;
                            objvend.Create(ref vend);
                            KEY = vend.Key;
                            ViewState["Key"] = KEY;
                            ViewState["No"] = no;
                            objvend = null;
                            vend = null;
                        }
                        else
                        {
                            no = Convert.ToString(ViewState["No"]);
                        }
                        WS_NAV_Vendor vendnew = new WS_NAV_Vendor();
                        WS_NAV_Vendor_Service objservend = new WS_NAV_Vendor_Service();
                        objservend.UseDefaultCredentials = true;
                        objservend.Credentials = NetCredentials;
                        string recid = objservend.GetRecIdFromKey(KEY);
                        vendnew = objservend.ReadByRecId(recid);

                        // Name & Address
                        vendnew.Name = txtNameOffice.Text;
                        vendnew.Address = txtLine1Office.Text;
                        vendnew.Address_2 = txtLine2Office.Text;

                        // phone number and mail id store
                        vendnew.Phone_No = txtLine3Office.Text;
                        vendnew.Mobile_No = txtMobileNoOffice.Text;
                        vendnew.Fax_No = txtFaxNoOffice.Text;
                        vendnew.E_Mail = txtEmailIDOffice.Text;

                        // EXTERNAL 
                        // vendnew.Contact = txtInquiry.Text;
                        vendnew.Reference_Code_Internal = txtInquiry.Text;
                        if (txtExtrnOrg.Text != "" && txtExtrnName.Text != "")
                        {
                            vendnew.Reference_Code_External = txtExtrnName.Text + "," + txtExtrnOrg.Text;
                        }
                        else
                        {
                            vendnew.Reference_Code_External = txtExtrnName.Text;
                        }
                        vendnew.Ex_Reference_Mobile_No = txtExtrnCnct.Text;


                        // pin code
                        if (drpPinCode.SelectedItem.Value != "0")
                        {
                            vendnew.Post_Code = drpPinCode.SelectedItem.Value;
                        }

                        if (drpStateOffice.SelectedValue != "0")
                        {
                            vendnew.State_Code = drpStateOffice.SelectedValue;
                        }
                        if (drpCountryOffice.SelectedValue != "0")
                        {
                            vendnew.Country_Region_Code = drpCountryOffice.SelectedValue;
                        }
                        if (drp_PaymentTerm.SelectedValue != "0")
                        {
                            vendnew.Payment_Terms_Code = drp_PaymentTerm.SelectedValue;
                        }
                        if (drpShipmentTerm.SelectedValue != "0")
                        {
                            vendnew.Shipment_Method_Code = drpShipmentTerm.SelectedValue;
                        }
                        if (drpGenBusPostingGroup.SelectedValue != "0")
                        {
                            vendnew.Gen_Bus_Posting_Group = drpGenBusPostingGroup.SelectedValue;
                        }
                        if (drpVATBusPostingGroup.SelectedValue != "0")
                        {
                            vendnew.VAT_Bus_Posting_Group = drpVATBusPostingGroup.SelectedValue;
                        }
                        if (drpServiceEntityType.SelectedValue != "0")
                        {
                            vendnew.Service_Entity_Type = drpServiceEntityType.SelectedValue;
                        }
                        if (drpExcisePostingGroup.SelectedValue != "0")
                        {
                            vendnew.Excise_Bus_Posting_Group = drpExcisePostingGroup.SelectedValue;
                        }
                        if (drpVendorPostingGroup.SelectedValue != "0")
                        {
                            vendnew.Vendor_Posting_Group = drpVendorPostingGroup.SelectedValue;
                        }
                        if (drpCurrencyCode.SelectedValue != "0")
                        {
                            vendnew.Currency_Code = drpCurrencyCode.SelectedValue;
                        }
                        if (drpAuthorisedby.SelectedValue != "0")
                        {
                            vendnew.Authorised_By = drpAuthorisedby.SelectedItem.Text;
                        }
                        if (drpVendorPostingGroup.SelectedValue != "0")
                        {
                            vendnew.Vendor_Posting_Group = drpVendorPostingGroup.SelectedValue;
                        }
                        vendnew.Tax_Liable = chk_TaxLiable.Checked;
                        vendnew.Home_Page = txtURL.Text;

                        // director
                        vendnew.PDPName = txtDirectName.Text;
                        vendnew.PDPPhoneNo = txtDirectPhone.Text;
                        vendnew.PDPEmailID = txtDirectEmail.Text;
                        vendnew.PDPMobileNo = txtDirectMobile.Text;

                        // sales person
                        vendnew.Sales_Dept_Name = txtSaleName.Text;
                        vendnew.Sales_Dept_PhoneNo = txtSalePhone.Text;
                        vendnew.Sales_Dept_MobileNo = txtSaleMobile.Text;
                        vendnew.Sales_Dept_EmailID = txtSaleEmail.Text;

                        // account department
                        vendnew.Account_Dept_Name = txtAccountName.Text;
                        vendnew.Account_Dept_PhoneNo = txtAccountPhone.Text;
                        vendnew.Account_Dept_EmailID = txtAccountEmail.Text;
                        vendnew.Account_Dept_MobileNo = txtAccountMobile.Text;

                        vendnew.Contact = txtDirectName.Text;

                        if (drp_PaymentTerm.SelectedValue != "0")
                        {
                            vendnew.Payment_Terms_Code = drp_PaymentTerm.SelectedValue;
                        }
                        //vendnew.Shipment_Method_Code = // new field
                        vendnew.P_A_N_Status = P_A_N_Status._blank_;
                        vendnew.P_A_N_No = txtPAN.Text;
                        vendnew.C_S_T_No = txtCST.Text;
                        vendnew.T_I_N_No = txtVAT.Text;
                        vendnew.MSME_No = TextBox100.Text;
                        vendnew.E_C_C_No = txt_ECCNo.Text;
                        vendnew.Range = txt_ExciseRange.Text + " " + txt_ExciseDivision.Text;
                        vendnew.Collectorate = txt_ExciseCollectorate.Text;
                        vendnew.Service_Tax_Registration_No = txt_ServiceTaxRegNo.Text;
                        vendnew.PF_No = txt_PFRegNo.Text;
                        vendnew.ESI_No = txt_ESIRegNo.Text;
                        vendnew.Bank_Name = txtBankName.Text;
                        vendnew.Bank_Branch = txtBAnkBrnch.Text;
                        vendnew.Our_Account_No = txtAcntNo.Text;
                        vendnew.IFSC_Code = txtIFSC.Text;
                        vendnew.Email_RTGS = txtEmailUTR.Text;
                        vendnew.Mobile_No_RTGS = txtMobileUTR.Text;


                        if (typeofAccount == 1)
                        {
                            vendnew.Account_Type = Account_Type.Saving;
                        }
                        else if (typeofAccount == 2)
                        {
                            vendnew.Account_Type = Account_Type.Current;
                        }
                        else if (typeofAccount == 3)
                        {
                            vendnew.Account_Type = Account_Type.CC;
                        }

                        objservend.UseDefaultCredentials = true;
                        objservend.Credentials = NetCredentials;
                        objservend.Update(ref vendnew);
                    }
                    using (var context = new EDMXConnectionString())
                    {
                        VendorRegistration v = new VendorRegistration();// make object of table
                        v.SourceRef = sourceref;
                        v.TypeofBusi = typeofbusi;
                        v.Title = tit;
                        v.SourceRefInquiryBy = txtInquiry.Text;
                        v.SourceRefExternal = txtExtrnCnct.Text;
                        if (txtExtrnCnct.Text != "")
                        {
                            v.SourceRefExternalContNo = txtExtrnCnct.Text;
                        }
                        v.SourceRefExternalOrgName = txtExtrnOrg.Text;
                        v.TypeofBusiForServiceProvider = txt_TypeofService.Text;

                        v.VendorName_HO = txtNameOffice.Text;
                        //v.VendorName_WS = txtNameWorkshop.Text;
                        //v.PremisesNo_HO = txtPremiseOffice.Text;
                        //v.PremisesNo_WS = txtPremiseWorkshop.Text;
                        v.Address_1_HO = txtLine1Office.Text;
                        //v.Address_1_WS = txtLine1Workshop.Text;
                        v.Address_2_HO = txtLine2Office.Text;
                        //   v.Address_2_WS = txtLine2Workshop.Text;

                        //v.City_HO = drpCityOffice.SelectedValue;
                        // v.City_WS = drpCityWorkshop.SelectedValue;
                        v.StateRegion_HO = drpStateOffice.SelectedValue;
                        v.PinCode_HO = Convert.ToInt32(drpPinCode.SelectedValue);
                        v.Country_HO = drpCountryOffice.SelectedValue;
                        //v.StateRegion_WS = drpStateWorkshop.SelectedValue;

                        v.WebSite = txtURL.Text;
                        v.Con_PropDirPar_Name = txtDirectName.Text;
                        if (txtDirectPhone.Text != "")
                        {
                            v.Con_PropDirPar_PhoneNo = Convert.ToString(txtDirectPhone.Text);
                        }
                        if (txtDirectMobile.Text != "")
                        {
                            v.Con_PropDirPar_MobileNo = Convert.ToString(txtDirectMobile.Text);
                        }
                        v.Con_PropDirPar_EmailID = txtDirectEmail.Text;
                        v.Con_SalesDep_Name = txtSaleName.Text;
                        if (txtSaleMobile.Text != "")
                        {
                            v.Con_SalesDep_MobileNo = Convert.ToString(txtSaleMobile.Text);
                        }
                        if (txtSalePhone.Text != "")
                        {
                            v.Con_SalesDep_PhoneNo = Convert.ToString(txtSalePhone.Text);
                        }
                        v.Con_SalesDep_EmailID = txtSaleEmail.Text;
                        v.Con_AccDep_Name = txtAccountName.Text;
                        if (txtAccountPhone.Text != "")
                        {
                            v.Con_AccDep_PhoneNo = Convert.ToString(txtAccountPhone.Text);
                        }
                        if (txtAccountMobile.Text != "")
                        {
                            v.Con_AccDep_MobileNo = Convert.ToString(txtAccountMobile.Text);
                        }
                        v.Con_AccDep_EmailID = txtAccountEmail.Text;
                        v.PaymentTerm = drp_PaymentTerm.SelectedValue;
                        if (txt_TotalStrengthofManpower.Text != "")
                        {
                            v.TotalStrengthOfManPower = Convert.ToInt32(txt_TotalStrengthofManpower.Text);
                        }
                        //v.ShipmentTerm = drpShipmentTerm.SelectedItem.Value;
                        if (txtCST.Text != "")
                        {
                            v.For_SOM_CSTNo = Convert.ToString(txtCST.Text);
                        }
                        if (txtVAT.Text != "")
                        {
                            v.For_SOM_VatNo = Convert.ToString(txtVAT.Text);
                        }
                        v.For_SOM_PanNo = txtPAN.Text;
                        v.For_SOM_TanNo = txtTAN.Text;
                        v.For_SOM_MicroSmallMediumEnterprise = microsmallmed;
                        v.For_SOM_MSMERegNo = TextBox100.Text;
                        v.For_SOM_RegisteredwithExcise = regyes;
                        v.For_SOM_ECCNo = txt_ECCNo.Text;
                        v.For_SOM_ExciseRange = txt_ExciseRange.Text;
                        v.For_SOM_ExciseDivision = txt_ExciseDivision.Text;
                        v.For_SOM_ExciseCollectorate = txt_ExciseCollectorate.Text;
                        //v.For_Others_PanNo = txtPANOthr.Text;
                        v.For_Others_ServcieTaxRegNo = txt_ServiceTaxRegNo.Text;
                        v.For_Others_PFRegNo = txt_PFRegNo.Text;
                        v.For_Others_ESIRegNo = txt_ESIRegNo.Text;
                        v.For_Others_ContractLicenseNo = txtContractLicenseNo.Text;
                        v.For_Others_TDS_Applicability = Convert.ToInt32(tdsapplicability);
                        v.For_Others_LowerDeductionCertiNo = txt_LowerDeductionCertiNo.Text;
                        v.BankName = txtBankName.Text;
                        v.BankBrachName = txtBAnkBrnch.Text;
                        v.BankAccNo = txtAcntNo.Text;
                        v.IFSCode = txtIFSC.Text;
                        v.TypeofAcc = typeofAccount;
                        v.FAX_HO = txtFaxNoOffice.Text;
                        v.Phone_HO = txtLine3Office.Text;
                        v.Mobile_HO = txtMobileNoOffice.Text;
                        v.Email_HO = txtEmailIDOffice.Text;
                        v.Bank_EmailID_UTR = txtEmailUTR.Text;
                        if (drpShipmentTerm.SelectedValue != "0")
                        {
                            v.Shipment_Term = drpShipmentTerm.SelectedValue;
                        }
                        if (VendorNoSeries.SelectedValue != "0")
                        {
                            v.Vendor_No_Series = VendorNoSeries.SelectedValue;
                        }
                        if (drpGenBusPostingGroup.SelectedValue != "0")
                        {
                            v.Gen_Posting_Group = drpGenBusPostingGroup.SelectedValue;
                        }
                        if (drpVATBusPostingGroup.SelectedValue != "0")
                        {
                            v.VAT_Posting_Group = drpVATBusPostingGroup.SelectedValue;
                        }
                        if (drpServiceEntityType.SelectedValue != "0")
                        {
                            v.Service_Entity_Type = drpServiceEntityType.SelectedValue;
                        }
                        if (drpExcisePostingGroup.SelectedValue != "0")
                        {
                            v.Excise_Posting_Group = drpExcisePostingGroup.SelectedValue;
                        }
                        v.Tax_Liable = chk_TaxLiable.Checked == true ? "Yes" : "No";
                        if (drpVendorPostingGroup.SelectedValue != "0")
                        {
                            v.Vendor_Posting_Group = drpVendorPostingGroup.SelectedValue;
                        }
                        if (drpCurrencyCode.SelectedValue != "0")
                        {
                            v.Currency_Code = drpCurrencyCode.SelectedValue;
                        }
                        if (drpAuthorisedby.SelectedValue != "0")
                        {
                            v.Authorised_by = drpAuthorisedby.SelectedValue;
                        }
                        //v.MICRCODE = txtMICR.Text;
                        if (txtMobileUTR.Text != "")
                        {
                            v.BankingMobileNo = txtMobileUTR.Text;
                        }
                        v.ApprovedVendor = false;
                        v.VendorCode = no;
                        v.Last_date_modified = Convert.ToDateTime(DateTime.Now.ToString("yyyy-MM-dd"));
                        context.VendorRegistrations.Add(v);
                        context.SaveChanges();
                        vendcreatedid = v.ID;
                        finalprocesscompleted = true;
                    }
                    using (var context = new EDMXConnectionString())
                    {
                        Busi_Annul_Turnover business = new Busi_Annul_Turnover();// make object of table
                        business.VendorId = vendcreatedid;

                        business.YearFirst = Convert.ToInt32(drpYear1.SelectedItem.Value);
                        business.YearSecond = Convert.ToInt32(drpYear2.SelectedItem.Value);
                        business.YearThird = Convert.ToInt32(drpYear3.SelectedItem.Value);

                        if (txtAmount1.Text != "")
                        {
                            business.YearFirstTurnOver = Convert.ToDecimal(txtAmount1.Text);
                        }
                        if (txtAmount2.Text != "")
                        {
                            business.YearSecondTurnOver = Convert.ToDecimal(txtAmount2.Text);
                        }
                        if (txtAmount3.Text != "")
                        {
                            business.YearThirdTurnOver = Convert.ToDecimal(txtAmount3.Text);
                        }
                        context.Busi_Annul_Turnover.Add(business);
                        context.SaveChanges();
                        finalprocesscompleted = true;
                    }
                    DataTable dt = null;
                    if (finalprocesscompleted == true)
                    {
                        SaveGridLineData();
                        DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable"];

                        for (int i = dtCurrentTable.Rows.Count - 1; i >= 0; i--)
                        {
                            if (dtCurrentTable.Rows[i]["Column1"].ToString() == Convert.ToString(0) && dtCurrentTable.Rows[i]["Column2"].ToString() == Convert.ToString(0) && dtCurrentTable.Rows[i]["Column3"].ToString() == string.Empty)
                            {
                                dtCurrentTable.Rows[i].Delete();
                            }
                            else if (dtCurrentTable.Rows[i]["Column1"].ToString() == string.Empty)
                            {
                                dtCurrentTable.Rows[i].Delete();
                            }
                        }
                        dtCurrentTable.AcceptChanges();
                        dt = dtCurrentTable;
                    }

                    using (var context = new EDMXConnectionString())
                    {


                        for (int i = 0; i <= dt.Rows.Count - 1; i++)
                        {
                            Busi_Cust_Ref business_ref = new Busi_Cust_Ref();// make object of table
                            business_ref.VendorID = vendcreatedid;
                            business_ref.Customer_Name = Convert.ToString(dt.Rows[i]["Column1"]);
                            business_ref.Location = Convert.ToString(dt.Rows[i]["Column2"]);
                            business_ref.Contact_Person = Convert.ToString(dt.Rows[i]["Column3"]);
                            if (Convert.ToString(dt.Rows[i]["Column4"]) != "")
                            {
                                business_ref.Contact_Number = Convert.ToDecimal(dt.Rows[i]["Column4"]);
                            }
                            context.Busi_Cust_Ref.Add(business_ref);
                            context.SaveChanges();

                        }
                        finalprocesscompleted = true;

                    }
                    if (finalprocesscompleted == true)
                    {
                        var message1 = new JavaScriptSerializer().Serialize(no + " - vendor created successfully.!!!");
                        var script1 = string.Format("alert({0});window.location='frmDashboard.aspx';", message1);
                        ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "", script1, true);
                    }
                }
                catch (Exception ex)
                {
                    var message1 = new JavaScriptSerializer().Serialize(ex.Message.ToString());
                    var script1 = string.Format("alert({0});", message1);
                    ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "", script1, true);
                }
            }
            else
            {
                var message1 = new JavaScriptSerializer().Serialize("Please fill all the details.");
                var script1 = string.Format("alert({0});", message1);
                ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "", script1, true);
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

        private void SaveGridLineData()
        {
            try
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

                            TextBox box1 = (TextBox)grd_CustomerDetails.Rows[rowIndex].Cells[1].FindControl("txtCustomerName");
                            TextBox box2 = (TextBox)grd_CustomerDetails.Rows[rowIndex].Cells[2].FindControl("txtLocationName");
                            TextBox box3 = (TextBox)grd_CustomerDetails.Rows[rowIndex].Cells[3].FindControl("txtContactPersonName");
                            TextBox box4 = (TextBox)grd_CustomerDetails.Rows[rowIndex].Cells[3].FindControl("txtContactPersonNumber");

                            drCurrentRow = dtCurrentTable.NewRow();
                            drCurrentRow["RowNumber"] = i;
                            dtCurrentTable.Rows[i - 1]["Column1"] = box1.Text;
                            dtCurrentTable.Rows[i - 1]["Column2"] = box2.Text;
                            dtCurrentTable.Rows[i - 1]["Column3"] = box3.Text;
                            dtCurrentTable.Rows[i - 1]["Column4"] = box4.Text;

                            rowIndex++;
                        }
                        ViewState["CurrentTable"] = dtCurrentTable;
                        grd_CustomerDetails.DataSource = dtCurrentTable;
                        grd_CustomerDetails.DataBind();


                    }
                }
            }
            catch (Exception ex)
            {
                var message = new JavaScriptSerializer().Serialize(ex.Message.ToString());
                var script = string.Format("alert({0});", message);
                ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "", script, true);
            }
        }

        public void ClearAllControls()
        {

        }

        [WebMethod]
        public static string GetMobile(string mobileNo)
        {
            string retval = ""; 
            NetworkCredential NetCredential = new NetworkCredential();
            NetCredential.UserName = SessionManager.GetNAVUserName(HttpContext.Current);
            NetCredential.Password = SessionManager.GetNAVUserPassword(HttpContext.Current);

            WS_NAV_Vendor_Service objservend = new WS_NAV_Vendor_Service();
            objservend.UseDefaultCredentials = true;
            objservend.Credentials = NetCredential;
            List<WS_NAV_Vendor_Filter> WList = new List<WS_NAV_Vendor_Filter>();
            WS_NAV_Vendor_Filter wField = new WS_NAV_Vendor_Filter();
            WList.Add(new WS_NAV_Vendor_Filter() { Field = WS_NAV_Vendor_Fields.Phone_No, Criteria = mobileNo });
            WList.Add(new WS_NAV_Vendor_Filter() { Field = WS_NAV_Vendor_Fields.Blocked, Criteria = "All" });
            WS_NAV_Vendor[] vendList = objservend.ReadMultiple(WList.ToArray(), null, 1);
            if (vendList.Length > 0)
            {
                retval = vendList[0].No;
            }
            else { retval = "false"; }
            return retval;
        }

        [WebMethod]
        public static string GetEmail(string Email)
        {
            string retval = "";
            NetworkCredential NetCredential = new NetworkCredential();
            NetCredential.UserName = SessionManager.GetNAVUserName(HttpContext.Current);
            NetCredential.Password = SessionManager.GetNAVUserPassword(HttpContext.Current);

            WS_NAV_Vendor_Service objservend = new WS_NAV_Vendor_Service();
            objservend.UseDefaultCredentials = true;
            objservend.Credentials = NetCredential;
            List<WS_NAV_Vendor_Filter> WList = new List<WS_NAV_Vendor_Filter>();
            WS_NAV_Vendor_Filter wField = new WS_NAV_Vendor_Filter();
            WList.Add(new WS_NAV_Vendor_Filter() { Field = WS_NAV_Vendor_Fields.E_Mail, Criteria = Email });
            WList.Add(new WS_NAV_Vendor_Filter() { Field = WS_NAV_Vendor_Fields.Blocked, Criteria = "All" });
            WS_NAV_Vendor[] vendList = objservend.ReadMultiple(WList.ToArray(), null, 1);
            if (vendList.Length > 0)
            {
                retval = vendList[0].No;
            }
            else { retval = "false"; }
            return retval;
        }

        [WebMethod]
        public static string GetWebsite(string URL)
        {
            string retval = "";
            NetworkCredential NetCredential = new NetworkCredential();
            NetCredential.UserName = SessionManager.GetNAVUserName(HttpContext.Current);
            NetCredential.Password = SessionManager.GetNAVUserPassword(HttpContext.Current);

            WS_NAV_Vendor_Service objservend = new WS_NAV_Vendor_Service();
            objservend.UseDefaultCredentials = true;
            objservend.Credentials = NetCredential;
            List<WS_NAV_Vendor_Filter> WList = new List<WS_NAV_Vendor_Filter>();
            WS_NAV_Vendor_Filter wField = new WS_NAV_Vendor_Filter();
            WList.Add(new WS_NAV_Vendor_Filter() { Field = WS_NAV_Vendor_Fields.Home_Page, Criteria = URL });
            WList.Add(new WS_NAV_Vendor_Filter() { Field = WS_NAV_Vendor_Fields.Blocked, Criteria = "All" });
            WS_NAV_Vendor[] vendList = objservend.ReadMultiple(WList.ToArray(), null, 1);
            if (vendList.Length > 0)
            {
               retval = vendList[0].No;
            }
            else { retval = "false"; }
            return retval;
        }

        [WebMethod]
        public static string GetPAN(string PAN)
        {
            string retval = "";
            NetworkCredential NetCredential = new NetworkCredential();
            NetCredential.UserName = SessionManager.GetNAVUserName(HttpContext.Current);
            NetCredential.Password = SessionManager.GetNAVUserPassword(HttpContext.Current);

            WS_NAV_Vendor_Service objservend = new WS_NAV_Vendor_Service();
            objservend.UseDefaultCredentials = true;
            objservend.Credentials = NetCredential;
            List<WS_NAV_Vendor_Filter> WList = new List<WS_NAV_Vendor_Filter>();
            WS_NAV_Vendor_Filter wField = new WS_NAV_Vendor_Filter();
            WList.Add(new WS_NAV_Vendor_Filter() { Field = WS_NAV_Vendor_Fields.P_A_N_No, Criteria = PAN });
            WList.Add(new WS_NAV_Vendor_Filter() { Field = WS_NAV_Vendor_Fields.Blocked, Criteria = "All" });
            WS_NAV_Vendor[] vendList = objservend.ReadMultiple(WList.ToArray(), null, 1);
            if (vendList.Length > 0)
            {
                retval = vendList[0].No;
            }
            else { retval = "false"; }
            return retval;
        }

        [WebMethod]
        public static string GetBankAcnt(string AcntNo)
        {
            string retval = "";
            try
            {
                
                NetworkCredential NetCredential = new NetworkCredential();
                NetCredential.UserName = SessionManager.GetNAVUserName(HttpContext.Current);
                NetCredential.Password = SessionManager.GetNAVUserPassword(HttpContext.Current);

                WS_NAV_Vendor_Service objservend = new WS_NAV_Vendor_Service();
                objservend.UseDefaultCredentials = true;
                objservend.Credentials = NetCredential;
                List<WS_NAV_Vendor_Filter> WList = new List<WS_NAV_Vendor_Filter>();
                WS_NAV_Vendor_Filter wField = new WS_NAV_Vendor_Filter();
                WList.Add(new WS_NAV_Vendor_Filter() { Field = WS_NAV_Vendor_Fields.Our_Account_No, Criteria = AcntNo });
                WList.Add(new WS_NAV_Vendor_Filter() { Field = WS_NAV_Vendor_Fields.Blocked, Criteria = "All" });
                WS_NAV_Vendor[] vendList = objservend.ReadMultiple(WList.ToArray(), null, 1);
                if (vendList.Length > 0)
                {
                    retval = vendList[0].No;
                }
                else { retval = "false"; }
                
            }
            catch (Exception ex)
            {

                var message1 = new JavaScriptSerializer().Serialize(ex.Message.ToString());
                var script1 = string.Format("alert({0});", message1);
                
            }
            return retval;
        }

    }
}