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
    public partial class ReleaseProdtctOrder : System.Web.UI.Page
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
                        mpLabel.Text = "Steam - Production Order Creation";
                    }

                    LinkButton LinkBackbuttonDynamic = (LinkButton)Page.Master.FindControl("LinkBackbuttonDynamic");

                    if (LinkBackbuttonDynamic != null)
                    {
                        LinkBackbuttonDynamic.Text = "Back";
                        LinkBackbuttonDynamic.PostBackUrl = "ShowRlsProductOdr.aspx";

                    }

                    GetItem();
                    txtPostingDate.Focus();
                    GetOutput();
                    GetConsumption();
                    if (Request["No"] != null)
                    {
                        lblItemNo.Text = Request["ItemNo"];
                        lblNo.Text = Request["No"];
                        lblItemDescription.Text = Request["Desc"];
                        pnlHide.Visible = false;
                        pnlShow.Visible = true;
                        tblID.Visible = true;
                    }
                }
            }
        }

        protected void btnCreate_Click(object sender, EventArgs e)
        {
            try
            {
                NetworkCredential NetCredentials = new NetworkCredential();
                NetCredentials.UserName = SessionManager.GetNAVUserName(HttpContext.Current);
                NetCredentials.Password = SessionManager.GetNAVUserPassword(HttpContext.Current);

                Web_Order_Mail objser = new Web_Order_Mail();
                objser.UseDefaultCredentials = true;
                objser.Credentials = NetCredentials;
                no = objser.CreateReleasedProductionOrder(drpItem.SelectedItem.Value, Convert.ToString(Session["NavUserName"]));

                objser = null;
                lblItemNo.Text = drpItem.SelectedItem.Value;
                lblItemDescription.Text = drpItem.SelectedItem.Text;
                lblItemNo.Visible = false;
                lblNo.Text = no;
                pnlHide.Visible = false;
                pnlShow.Visible = true;
                tblID.Visible = true;
                txtPostingDate.Focus();
            }
            catch (Exception ex)
            {
                var message1 = new JavaScriptSerializer().Serialize(ex.Message.ToString());
                var script1 = string.Format("alert({0});", message1);
                ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "", script1, true);
            }

        }
        public void GetItem()
        {
            try
            {
                using (EDMXConnectionString context = new EDMXConnectionString())
                {
                    IEnumerable<GetItem_Result> Details = context.Database.SqlQuery
                                                                      <GetItem_Result>("exec GetItem ").ToList();

                    drpItem.DataValueField = "No_";
                    drpItem.DataTextField = "Description";
                    drpItem.DataSource = Details;
                    drpItem.DataBind();
                }
                drpItem.Items.Insert(0, new ListItem("-Select-", "0"));
            }
            catch (Exception ex)
            {
                var message1 = new JavaScriptSerializer().Serialize(ex.Message.ToString());
                var script1 = string.Format("alert({0});", message1);
                ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "", script1, true);
            }
        }
        public void GetOutput()
        {
            try
            {
                using (EDMXConnectionString context = new EDMXConnectionString())
                {
                    IEnumerable<GetOutputDim_Result> Details = context.Database.SqlQuery<GetOutputDim_Result>("exec GetOutputDim ").ToList();
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
        public void GetConsumption()
        {
            try
            {
                using (EDMXConnectionString context = new EDMXConnectionString())
                {
                    IEnumerable<GetConsuptionDim_Result> Details = context.Database.SqlQuery<GetConsuptionDim_Result>("exec GetConsuptionDim ").ToList();
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
                    lblOutputSum.Text = ":" + Convert.ToString(OpSum);

                }
                foreach (GridViewRow g1 in gvCons.Rows)
                {
                    string Qty = (g1.FindControl("txtCons") as TextBox).Text;
                    if (Qty != null && Qty != "")
                    {
                        ConsSum = ConsSum + Convert.ToDecimal(Qty);
                    }
                    lblConsumptionTotal.Text = ":" + Convert.ToString(ConsSum);
                }

                if (OpSum == ConsSum)
                {
                    NetworkCredential NetCredentials = new NetworkCredential();
                    NetCredentials.UserName = SessionManager.GetNAVUserName(HttpContext.Current);
                    NetCredentials.Password = SessionManager.GetNAVUserPassword(HttpContext.Current);

                    try
                    {
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
                                    // 0 = output
                                    objser.CreateItemJournal(0, lblNo.Text, quantity, code, lblItemNo.Text, Convert.ToDateTime(txtPostingDate.Text), Convert.ToDateTime(txtDocumentDate.Text), Convert.ToString(Session["NavUserName"]), string.Empty);
                                    objser = null;
                                }
                            }
                            // posted the entry for output
                            Web_Order_Mail objserv = new Web_Order_Mail();
                            objserv.UseDefaultCredentials = true;
                            objserv.Credentials = NetCredentials;
                            indicatorofOutputPosted = objserv.PostItemJournal(0);
                            objserv = null;
                        }
                        try
                        {
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
                                    objser.CreateItemJournal(1, lblNo.Text, quantity, code, lblItemNo.Text, Convert.ToDateTime(txtPostingDate.Text), Convert.ToDateTime(txtDocumentDate.Text), Convert.ToString(Session["NavUserName"]), string.Empty);
                                    objser = null;
                                }
                            }
                            // Consumption post
                            Web_Order_Mail objservc = new Web_Order_Mail();
                            objservc.UseDefaultCredentials = true;
                            objservc.Credentials = NetCredentials;
                            bool i = objservc.PostItemJournal(1);
                            objservc = null;
                        }
                        catch (Exception ex)
                        {
                            ViewState["Indicator"] = true;
                            var message1 = new JavaScriptSerializer().Serialize(ex.Message.ToString());
                            var script1 = string.Format("alert({0});", message1);
                            ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "", script1, true);
                        }

                        var messagefordi1 = new JavaScriptSerializer().Serialize("Production Order :" + lblNo.Text + " : Output and Consumption entries are posted successfully.!!!");
                        var scriptForview = string.Format("alert({0});window.location='ShowRlsProductOdr.aspx';", messagefordi1);
                        ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "", scriptForview, true);
                    }
                    catch (Exception ex)
                    {
                        //ViewState["Indicator"] = true; 
                        var message1 = new JavaScriptSerializer().Serialize(ex.Message.ToString());
                        var script1 = string.Format("alert({0});", message1);
                        ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "", script1, true);
                    }



                }
                else
                {
                    var message1 = new JavaScriptSerializer().Serialize("Sum of Output and Consumption must be same!!!");
                    var script1 = string.Format("alert({0});", message1);
                    ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "", script1, true);
                }

            }




        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ShowRlsProductOdr.aspx", false);
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