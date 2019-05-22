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
using System.Data.SqlClient;
using System.Drawing;

namespace JCILVendorPortal
{
    public partial class EditProdConsuption : System.Web.UI.Page
    {
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
                        mpLabel.Text = "Posted Steam Entries";
                    }
                    LinkButton LinkBackbuttonDynamic = (LinkButton)Page.Master.FindControl("LinkBackbuttonDynamic");

                    if (LinkBackbuttonDynamic != null)
                    {
                        LinkBackbuttonDynamic.Text = "Back";
                        LinkBackbuttonDynamic.PostBackUrl = "ShowRlsProductOdr.aspx";

                    }
                    if (Request["No"] != "")
                    {
                        lblProductionOrderNo.Text = Request["No"];
                        GetILE();
                    }
                }
            }
        }

        public void GetILE()
        {
            try
            {
                using (EDMXConnectionString context = new EDMXConnectionString())
                {
                    var oficio = new SqlParameter
                    {
                        ParameterName = "ProductionOrderNo",
                        Value = Convert.ToString(Request.QueryString["No"])
                    };

                    var Details = context.Database.SqlQuery<NAV_OutputConsumptionSummary_Result>("exec NAV_OutputConsumptionSummary @ProductionOrderNo", oficio).ToList<NAV_OutputConsumptionSummary_Result>();
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
        static DataTable ConvertListToDataTable(List<string[]> list)
        {
            // New table.
            DataTable table = new DataTable();
            // Get max columns.
            int columns = 0;
            foreach (var array in list)
            {
                if (array.Length > columns)
                {
                    columns = array.Length;
                }
            }
            // Add columns.
            for (int i = 0; i < columns; i++)
            {
                table.Columns.Add();
            }
            // Add rows.
            foreach (var array in list)
            {
                table.Rows.Add(array);
            }
            return table;
        }


        string currentId = string.Empty;
        decimal subTotal = 0;
        decimal total = 0;
        int subTotalRowIndex = 0;
        protected void OnRowCreated(object sender, GridViewRowEventArgs e)
        {
            subTotal = 0;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                string entrytype = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "EntryType"));
                decimal d = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Qty"));
                if (entrytype != currentId)
                {
                    if (e.Row.RowIndex > 0)
                    {
                        for (int i = subTotalRowIndex; i < e.Row.RowIndex; i++)
                        {
                            subTotal += Convert.ToDecimal(gvCons.Rows[i].Cells[5].Text);
                        }
                        this.AddTotalRow("Sub Total", subTotal.ToString("N2"));
                        subTotalRowIndex = e.Row.RowIndex;
                    }
                    currentId = entrytype;
                }
            }
        }

        private void AddTotalRow(string labelText, string value)
        {
            GridViewRow row = new GridViewRow(0, 0, DataControlRowType.DataRow, DataControlRowState.Normal);
            row.BackColor = ColorTranslator.FromHtml("#F9F9F9");
            row.Cells.AddRange(new TableCell[6] { new TableCell (), //Empty Cell
                new TableCell (), //Empty Cell
                new TableCell (), //Empty Cell
                new TableCell (), //Empty Cell
                                        new TableCell { Text = labelText, HorizontalAlign = HorizontalAlign.Right,ForeColor= Color.Red},
                                        new TableCell { Text = value, HorizontalAlign = HorizontalAlign.Right,ForeColor= Color.Red } });

            gvCons.Controls[0].Controls.Add(row);
        }
        protected void OnDataBound(object sender, EventArgs e)
        {
            if (gvCons.Rows.Count > 0)
            {
                for (int i = subTotalRowIndex; i < gvCons.Rows.Count; i++)
                {
                    subTotal += Convert.ToDecimal(gvCons.Rows[i].Cells[5].Text);
                }
                this.AddTotalRow("Sub Total", subTotal.ToString("N2"));
                //this.AddTotalRow("Total", total.ToString("N2"));
            }
        }
        
    }
}