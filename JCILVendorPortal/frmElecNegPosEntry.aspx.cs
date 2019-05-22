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
using System.Text.RegularExpressions;
using System.Globalization;

namespace JCILVendorPortal
{
    public partial class frmElecNegPosEntry : System.Web.UI.Page
    {
        string no = "";
        Decimal OpSum = 0.00m, ConsSum = 0.00m;
        bool indicatorofOutputPosted = false;
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
                        mpLabel.Text = "Electricity - Unit Generation/Used Entry";
                    }
                    LinkButton LinkBackbuttonDynamic = (LinkButton)Page.Master.FindControl("LinkBackbuttonDynamic");

                    if (LinkBackbuttonDynamic != null)
                    {
                        LinkBackbuttonDynamic.Text = "Back";
                        LinkBackbuttonDynamic.PostBackUrl = "frmElectricitySummary.aspx";

                    }

                    txtPostingDate.Focus();
                    GetOutput();
                    GetElectricityItems();
                    GetConsumption();
                    if (Request["No"] != null)
                    {
                        //lblItemNo.Text = Request["ItemNo"];

                        pnlShow.Visible = true;
                        tblID.Visible = true;
                    }
                }
            }
        }



        public void GetOutput()
        {
            try
            {
                using (EDMXConnectionString context = new EDMXConnectionString())
                {
                    IEnumerable<GetElectricityPositiveDim_Result> Details = context.Database.SqlQuery<GetElectricityPositiveDim_Result>("exec GetElectricityPositiveDim ").ToList();
                    gvOutput.DataSource = Details;
                    gvOutput.DataBind();
                }
            }
            catch (Exception ex)
            {
                var message1 = new JavaScriptSerializer().Serialize(ex.Message.ToString());
                var script1 = string.Format("alert({0});", message1);
                ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "", script1, true);
            }
        }

        public void GetElectricityItems()
        {
            try
            {
                using (EDMXConnectionString context = new EDMXConnectionString())
                {
                    IEnumerable<NAV_ElectricityItems_Result> Details = context.Database.SqlQuery<NAV_ElectricityItems_Result>("exec NAV_ElectricityItems ").ToList();

                    drpItem.DataValueField = "Item";
                    drpItem.DataTextField = "Description";
                    drpItem.DataSource = Details;
                    drpItem.DataBind();
                }
            }
            catch (Exception ex)
            {
                var message1 = new JavaScriptSerializer().Serialize(ex.Message.ToString());
                var script1 = string.Format("alert({0});", message1);
                ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "", script1, true);
            }
        }
        public void GetConsumption()
        {
            try
            {
                using (EDMXConnectionString context = new EDMXConnectionString())
                {
                    IEnumerable<GetElectricityNegativeDim_Result> Details = context.Database.SqlQuery<GetElectricityNegativeDim_Result>("exec GetElectricityNegativeDim ").ToList();
                    gvCons.DataSource = Details;
                    gvCons.DataBind();
                }
            }
            catch (Exception ex)
            {
                var message1 = new JavaScriptSerializer().Serialize(ex.Message.ToString());
                var script1 = string.Format("alert({0});", message1);
                ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "", script1, true);
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (ViewState["Indicator"] != null)
                {
                    indicatorofOutputPosted = true;
                }
                if (!Regex.IsMatch(txtPostingDate.Text, "(((0|1)[0-9]|2[0-9]|3[0-1])\\/(0[1-9]|1[0-2])\\/((19|20)\\d\\d))$") || !Regex.IsMatch(txtDocumentDate.Text, "(((0|1)[0-9]|2[0-9]|3[0-1])\\/(0[1-9]|1[0-2])\\/((19|20)\\d\\d))$"))
                {

                    var message1 = new JavaScriptSerializer().Serialize("Not Valid dates!!!");
                    var script1 = string.Format("alert({0});", message1);
                    ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "", script1, true);
                }
                else
                {
                    foreach (GridViewRow g1 in gvOutput.Rows)
                    {
                        string Qty = (g1.FindControl("txtOut") as TextBox).Text;
                        if (Qty != null && Qty != "")
                        {
                            OpSum = OpSum + Convert.ToDecimal(Qty);
                        }
                    }
                    foreach (GridViewRow g1 in gvCons.Rows)
                    {
                        string Qty = (g1.FindControl("txtCons") as TextBox).Text;
                        if (Qty != null && Qty != "")
                        {
                            ConsSum = ConsSum + Convert.ToDecimal(Qty);
                        }
                    }

                    if (OpSum == ConsSum)
                    {
                        NetworkCredential NetCredentials = new NetworkCredential();
                        NetCredentials.UserName = SessionManager.GetNAVUserName(HttpContext.Current);
                        NetCredentials.Password = SessionManager.GetNAVUserPassword(HttpContext.Current);

                        Web_Order_Mail objservno = new Web_Order_Mail();
                        objservno.UseDefaultCredentials = true;
                        objservno.Credentials = NetCredentials;
                        string docno = objservno.ItemJournalDocumentNoSeries();
                        objservno = null;

                        if (indicatorofOutputPosted == false)
                        {


                            foreach (GridViewRow g1 in gvOutput.Rows)
                            {
                                string code = (g1.FindControl("lblDimCode1") as Label).Text;
                                string Qty = (g1.FindControl("txtOut") as TextBox).Text;
                                Decimal quantity = 0;
                                if (Qty != null && Qty != "")
                                {
                                    if (Qty != null)
                                    {
                                        quantity = Convert.ToDecimal(Qty);
                                    }
                                    Web_Order_Mail objser = new Web_Order_Mail();
                                    objser.UseDefaultCredentials = true;
                                    objser.Credentials = NetCredentials;
                                    // 2 = Positive
                                    objser.CreateItemJournal(2, docno, quantity, code, drpItem.SelectedItem.Value, Convert.ToDateTime(txtPostingDate.Text), Convert.ToDateTime(txtDocumentDate.Text), Convert.ToString(Session["NavUserName"]), string.Empty);
                                    objser = null;
                                }
                            }
                            // posted the entry for output
                            Web_Order_Mail objserv = new Web_Order_Mail();
                            objserv.UseDefaultCredentials = true;
                            objserv.Credentials = NetCredentials;
                            indicatorofOutputPosted = objserv.PostItemJournal(2);
                            objserv = null;
                        }
                        foreach (GridViewRow g1 in gvCons.Rows)
                        {
                            string code = (g1.FindControl("lblDimCode2") as Label).Text;
                            string Qty = (g1.FindControl("txtCons") as TextBox).Text;
                            if (Qty != null && Qty != "")
                            {
                                Decimal quantity = Convert.ToDecimal(Qty);
                                Web_Order_Mail objser = new Web_Order_Mail();
                                objser.UseDefaultCredentials = true;
                                objser.Credentials = NetCredentials;
                                // 1 = Consumption
                                objser.CreateItemJournal(3, docno, quantity, code, drpItem.SelectedItem.Value, Convert.ToDateTime(txtPostingDate.Text), Convert.ToDateTime(txtDocumentDate.Text), Convert.ToString(Session["NavUserName"]), string.Empty);
                                objser = null;
                            }
                        }
                        // Consumption post
                        Web_Order_Mail objservc = new Web_Order_Mail();
                        objservc.UseDefaultCredentials = true;
                        objservc.Credentials = NetCredentials;
                        bool i = objservc.PostItemJournal(3);
                        objservc = null;

                        var message1 = new JavaScriptSerializer().Serialize("Positive and Negative entries are posted successfully.!!!");
                        var script1 = string.Format("alert({0});window.location='frmElectricitySummary.aspx';", message1);
                        ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "", script1, true);
                    }
                    else
                    {
                        var message1 = new JavaScriptSerializer().Serialize("Sum of Output and Consumption must be same!!!");
                        var script1 = string.Format("alert({0});", message1);
                        ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "", script1, true);
                    }

                }



            }
            catch (Exception ex)
            {
                ViewState["Indicator"] = true;
                var message1 = new JavaScriptSerializer().Serialize(ex.Message.ToString());
                var script1 = string.Format("alert({0});", message1);
                ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "", script1, true);
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("frmElectricitySummary.aspx", false);
        }

        protected void btnTotalOutput_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow g1 in gvOutput.Rows)
            {
                string Qty = (g1.FindControl("txtOut") as TextBox).Text;
                if (Qty != null && Qty != "")
                {
                    OpSum = OpSum + Convert.ToDecimal(Qty);
                }
            }
            lblOutputSum.Text = ":" + Convert.ToString(OpSum);

            foreach (GridViewRow g1 in gvCons.Rows)
            {
                string Qty = (g1.FindControl("txtCons") as TextBox).Text;
                if (Qty != null && Qty != "")
                {
                    ConsSum = ConsSum + Convert.ToDecimal(Qty);
                }
            }
            lblConsumptionTotal.Text = ":" + Convert.ToString(ConsSum);
        }





    }
}