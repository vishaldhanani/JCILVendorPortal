using AppStarSQL;
using JCILVendorPortal.CodeUnit_AllFuncs;
using JCILVendorPortal.Serv_Vendor;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Text;
using System.Text.RegularExpressions;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using VendorLib;

namespace JCILVendorPortal
{
    public partial class frmProdBOM : System.Web.UI.Page
    {
        string no = "";
        Decimal OpSum = 0.00m, ConsSum = 0.00m;
        bool indicatorofOutputPosted = false;
        SQLServer objSQLServer = new SQLServer();
        AppSQL objSQL = new AppSQL();
        AppTools objTools = new AppTools();
        AppSession objSession = new AppSession();

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
        public void GetOutput()
        {
            try
            {
                using (EDMXConnectionString context = new EDMXConnectionString())
                {
                    var oficio = new SqlParameter
                    {
                        ParameterName = "ProdBOMNo",
                        Value = Convert.ToString(Request.QueryString["BOMNo"])
                    };
                    var Details = context.Database.SqlQuery<NAV_ProdcutionOrderBOMLine_Result>("exec NAV_ProdcutionOrderBOMLine @ProdBOMNo", oficio).ToList<NAV_ProdcutionOrderBOMLine_Result>();

                    //   IEnumerable<NAV_ProdcutionOrderBOMLine_Result> Details = context.Database.SqlQuery<NAV_ProdcutionOrderBOMLine_Result>("exec NAV_ProdcutionOrderBOMLine ").ToList();
                    rptOutput.DataSource = Details;
                    rptOutput.DataBind();
                }
            }
            catch (Exception ex)
            {
                var message1 = new JavaScriptSerializer().Serialize(ex.Message.ToString());
                var script1 = string.Format("alert({0});", message1);
                ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "", script1, true);
            }
        }
                
        public void ResetItemTrack()
        {
            hfItemTrackRowQty.Value = string.Empty;
        }
        public decimal getItemTrackQTYUsedSum()
        {
            decimal TotalQty = 0;
            for (int i = 0; i < rptLotList.Items.Count; i++)
            {
                TotalQty += objTools.getDecimal(((TextBox)rptLotList.Items[i].FindControl("txtUsingQty")).Text);
                ((Literal)rptLotList.Items[i].FindControl("lables")).Text = "<label for='" + ((CheckBox)rptLotList.Items[i].FindControl("chkLotSelect")).ClientID + "'></label>";
            }
            return TotalQty;
        }

        public void setTrackList()
        {
            if (objSession.IsSession(HttpContext.Current, "TrackSessionState") == false)
            {
                objSession.setSession(HttpContext.Current, "TrackSessionState", new List<ItemTrackList>());
            }
        }
        public void unsetTrackList()
        {
            objSession.unsetSession(HttpContext.Current, "TrackSessionState");
        }
        public List<ItemTrackList> getTrackList()
        {
            setTrackList();
            return ((List<ItemTrackList>)objSession.getSession(HttpContext.Current, "TrackSessionState"));
        }
        public void unsetTrackList(string TrackItemCode)
        {
            List<ItemTrackList> ListRemove = ((List<ItemTrackList>)objSession.getSession(HttpContext.Current, "TrackSessionState"));
            for (int i = 0; i < ListRemove.Count; i++)
            {
                if (TrackItemCode == ListRemove[i].TrackItemCode)
                {
                    ((List<ItemTrackList>)objSession.getSession(HttpContext.Current, "TrackSessionState")).RemoveAt(i);
                }
            }
            BindTrack();
        }
        public void addTrackList(ItemTrackList LineTrackList)
        {
            setTrackList();
            ((List<ItemTrackList>)objSession.getSession(HttpContext.Current, "TrackSessionState")).Add(LineTrackList);
        }
        public void BindTrack()
        {
            setTrackList();
            List<ItemTrackList> ListItemTrack = getTrackList();
            //if (ListItemTrack.Count > 0)
            //{
            //StringBuilder sbTags = new System.Text.StringBuilder();
            for (int i = 0; i < rptOutput.Items.Count; i++)
            {
                //bool IsTrackItems = false;
                Label lblNo = ((Label)rptOutput.Items[i].FindControl("lblDimCode1"));
                TextBox txtQty = ((TextBox)rptOutput.Items[i].FindControl("txtOut"));
                //Literal ltrTages = ((Literal)rptOutput.Items[i].FindControl("ltrShowDetails"));
                if (ListItemTrack.Where(x => x.TrackItemCode == lblNo.Text).Count() > 0)
                {
                    ((LinkButton)rptOutput.Items[i].FindControl("lnkShow")).Visible = true;
                    txtQty.Enabled = false;
                }
                else
                {
                    ((LinkButton)rptOutput.Items[i].FindControl("lnkShow")).Visible = false;
                    txtQty.Enabled = true;
                    txtQty.Text = string.Empty;
                }
                //sbTags.AppendLine("<a class=' btn-floating btn-large blue darken-3 waves-effect waves-light btn' href='#modal1'><i class='material-icons'>list</i></a>");
                //sbTags.AppendLine("<div id='modal1' class='modal'> <div class='modal-content'><table>");

                //for (int j = 0; j < ListItemTrack.Count; j++)
                //{
                //    if (lblNo.Text == ListItemTrack[j].TrackItemCode)
                //    {
                //        IsTrackItems = true;
                //        sbTags.AppendLine("<tr><td>" + ListItemTrack[j].LotNo + "</td><td>" + ListItemTrack[j].Quanity + " </td></tr>");
                //    }
                //}
                //sbTags.AppendLine("</table></div> <div class='modal-footer'> <a href='#!' class='modal-action modal-close waves-effect waves-green btn-flat'>OK</a> </div> </div>");
                //ltrTages.Text = IsTrackItems == true ? sbTags.ToString() : string.Empty;
            }
            //}
        }

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
                BindTrack();
                if (Session["VendorName"] == null)
                {
                    Response.Redirect(ConfigurationManager.AppSettings["DefaultLoginPage"]);
                    
                }
                else
                {
                    Label mpLabel = (Label)Page.Master.FindControl("lblPageCenterHeader");
                    SetTrackListDetails();
                    if (mpLabel != null)
                    {
                        mpLabel.Text = "Production BOM";
                    }
                    LinkButton LinkBackbuttonDynamic = (LinkButton)Page.Master.FindControl("LinkBackbuttonDynamic");

                    if (LinkBackbuttonDynamic != null)
                    {
                        LinkBackbuttonDynamic.Text = "Back";
                        LinkBackbuttonDynamic.PostBackUrl = "ShowRlsProductOdr.aspx";

                    }
                    GetOutput();
                    if (Request["No"] != null)
                    {
                        pnlShow.Visible = true;
                        tblID.Visible = true;
                    }
                }
            }
        }
        public void SetTrackListDetails()
        {

            ItemTrackDetails.DataSource = getTrackList();
            ItemTrackDetails.DataBind();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {


                NetworkCredential NetCredentials = new NetworkCredential();
                NetCredentials.UserName = SessionManager.GetNAVUserName(HttpContext.Current);
                NetCredentials.Password = SessionManager.GetNAVUserPassword(HttpContext.Current);

                ItemTrackDetails.DataSource = getTrackList();
                ItemTrackDetails.DataBind();
                

                foreach (RepeaterItem itemEquipment in ItemTrackDetails.Items)
                    {
                        string lblLotNo = (itemEquipment.FindControl("lblLotNo") as Label).Text;
                        string Qty = (itemEquipment.FindControl("lblQty") as Label).Text;
                        string lblDimenItem = (itemEquipment.FindControl("lblDimenItem") as Label).Text;
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
                            objser.CreateItemJournal(1,Request.QueryString["No"] ,Convert.ToDecimal(Qty) ,string.Empty,lblDimenItem ,Convert.ToDateTime(txtPostingDate.Text) , Convert.ToDateTime(txtDocumentDate.Text), Convert.ToString(Session["NavUserName"]),lblLotNo);
                            objser = null;
                        }
                    
                    
                
                    }

            }
            catch (Exception ex)
            {

                var message1 = new JavaScriptSerializer().Serialize(ex.Message.ToString());
                var script1 = string.Format("alert({0});", message1);
                ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "", script1, true);
            }
        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ShowRlsProductOdr.aspx", false);
        }
        protected void btnItemTrack_Click(object sender, EventArgs e)
        {
            try
            {
                TextBox txtQunatity = ((TextBox)rptOutput.Items[((RepeaterItem)((LinkButton)sender).NamingContainer).ItemIndex].FindControl("txtOut"));
                Label lblDimCode1 = ((Label)rptOutput.Items[((RepeaterItem)((LinkButton)sender).NamingContainer).ItemIndex].FindControl("lblDimCode1"));
                decimal DefaultDecimal = 0;
                if (decimal.TryParse(txtQunatity.Text, out DefaultDecimal) == false)
                {
                    objTools.jsWarning(this.Page, "Enter Quantity Proper.");
                    txtQunatity.Focus();
                }
                else
                {
                    string LocationCode = Convert.ToString(Server.UrlDecode(Request.QueryString["LocationCode"]));
                    string ItemNo = lblDimCode1.Text; //Convert.ToString(Request.QueryString["ItemNo"]);
                    DataTable dtLotNos = objSQLServer.Fill_Datatable(objSQL.VendorConn, "JAY$Item Ledger Entry_getLotNos", new string[] { ItemNo, LocationCode });
                    if (dtLotNos.Rows.Count > 0)
                    {
                        pnlItemTracking.Visible = true;
                        hfItemTrackRowQty.Value = txtQunatity.Text;
                        txtQuantityList.Text = txtQunatity.Text;
                        rptLotList.DataSource = dtLotNos;
                        rptLotList.DataBind();
                        for (int i = 0; i < rptLotList.Items.Count; i++)
                        {
                            ((TextBox)rptLotList.Items[i].FindControl("txtUsingQty")).Text = "0.00";
                        }
                        lblQtyUntilizeSum.Text = getItemTrackQTYUsedSum().ToString();
                        hfQtyUntilizeSum.Value = getItemTrackQTYUsedSum().ToString();
                        hdnFieldItemNo.Value = lblDimCode1.Text;
                    }
                    else
                    {
                        objTools.jsWarning(this.Page, "Sorry, Not found any Item Tracking List.");
                    }
                }
            }
            catch (Exception ex)
            {
                objTools.jsError(this.Page, ex.Message.ToString());
            }
        }
        protected void chkLotSelect_CheckedChanged(object sender, EventArgs e)
        {
            try
            {
                CheckBox chkSelect = ((CheckBox)sender);
                int ItemIndex = ((RepeaterItem)chkSelect.NamingContainer).ItemIndex;
                TextBox txtUsedQty = ((TextBox)rptLotList.Items[ItemIndex].FindControl("txtUsingQty"));
                if (chkSelect.Checked)
                {
                    if (objTools.getDecimal(hfQtyUntilizeSum.Value) < objTools.getDecimal(hfItemTrackRowQty.Value))
                    {
                        txtUsedQty.Text = (objTools.getDecimal(hfItemTrackRowQty.Value) - objTools.getDecimal(hfQtyUntilizeSum.Value)).ToString();
                        txtUsedQty.ReadOnly = false;
                    }
                    else
                    {
                        chkSelect.Checked = false;
                    }
                }
                else
                {
                    txtUsedQty.Text = "0.00";
                    txtUsedQty.ReadOnly = true;
                }
                lblQtyUntilizeSum.Text = getItemTrackQTYUsedSum().ToString();
                hfQtyUntilizeSum.Value = getItemTrackQTYUsedSum().ToString();
            }
            catch (Exception ex)
            {
                objTools.jsError(this.Page, ex.Message.ToString());
            }


        }
        protected void txtUsingQty_TextChanged(object sender, EventArgs e)
        {
            try
            {
                TextBox txtQty = ((TextBox)sender);
                decimal QtyValue = objTools.getDecimal(txtQty.Text);
                int ItemIndex = ((RepeaterItem)txtQty.NamingContainer).ItemIndex;
                if (QtyValue <= 0)
                {
                    ((CheckBox)rptLotList.Items[ItemIndex].FindControl("chkLotSelect")).Checked = false;
                    txtQty.Text = "0.00";
                    txtQty.ReadOnly = true;
                }
                else
                {
                    txtQty.Text = QtyValue.ToString();
                }
                lblQtyUntilizeSum.Text = getItemTrackQTYUsedSum().ToString();
                hfQtyUntilizeSum.Value = getItemTrackQTYUsedSum().ToString();
            }
            catch (Exception ex)
            {
                objTools.jsError(this.Page, ex.Message.ToString());
            }
        }
        protected void lnkUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                decimal totalUntilizeQty = objTools.getDecimal(hfItemTrackRowQty.Value) - objTools.getDecimal(hfQtyUntilizeSum.Value);
                if (objTools.getDecimal(hfQtyUntilizeSum.Value) <= 0)
                {
                    objTools.jsWarning(this.Page, "");
                }
                else if (totalUntilizeQty != 0)
                {
                    objTools.jsWarning(this.Page, "");
                }
                else
                {
                    
                    foreach (RepeaterItem itemEquipment in rptLotList.Items)
                    {
                        ItemTrackList LineItemTrack = new ItemTrackList();
                        bool check = (itemEquipment.FindControl("chkLotSelect") as CheckBox).Checked;
                        string Qty = (itemEquipment.FindControl("txtUsingQty") as TextBox).Text;
                        string LotNo = (itemEquipment.FindControl("LotNo") as Label).Text;
                        if (check)
                        {
                            if (!string.IsNullOrEmpty(Qty))
                            {
                                LineItemTrack.Quanity = Convert.ToDecimal(Qty);
                                LineItemTrack.LotNo = LotNo;
                                LineItemTrack.TrackItemCode = hdnFieldItemNo.Value;
                                addTrackList(LineItemTrack);
                                BindTrack();

                            }
                        }
                    }
                    pnlItemTracking.Visible = false;
                }
            }
            catch (Exception ex)
            {
                objTools.jsError(this.Page, ex.Message.ToString());
            }
        }
        protected void lnkClear_Click(object sender, EventArgs e)
        {
            try
            {
                pnlItemTracking.Visible = false;
            }
            catch (Exception ex)
            {
                objTools.jsError(this.Page, ex.Message.ToString());
            }
        }
        protected void lnkRemove_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton lnkRemovee = ((LinkButton)sender);
                int ItemIndex = ((RepeaterItem)lnkRemovee.NamingContainer).ItemIndex;
                string ItemCode = ((Label)rptOutput.Items[ItemIndex].FindControl("lblDimCode1")).Text;
                unsetTrackList(ItemCode);
            }
            catch (Exception ex)
            {
                objTools.jsError(this.Page, ex.Message.ToString());
            }
        }

        [Serializable()]
        public class ItemTrackList
        {
            public string TrackItemCode { get; set; }
            public string LotNo { get; set; }
            public decimal Quanity { get; set; }
        }

        protected void lnkShow_Click(object sender, EventArgs e)
        {
            try
            {
                int ItemIndex = ((RepeaterItem)((LinkButton)sender).NamingContainer).ItemIndex;
                ItemTrackDetails.DataSource = getTrackList().Where(x => x.TrackItemCode == ((Label)rptOutput.Items[ItemIndex].FindControl("lblDimCode1")).Text);
                ItemTrackDetails.DataBind();
                pnlTrackingDetails.Visible = true;
            }
            catch (Exception ex)
            {
                objTools.jsError(this.Page, ex.Message.ToString());
            }
        }

        protected void lnkCloseDetails_Click(object sender, EventArgs e)
        {
            try
            {
                pnlTrackingDetails.Visible = false;
            }
            catch (Exception ex)
            {
                objTools.jsError(this.Page, ex.Message.ToString());
            }
        }
    }
}