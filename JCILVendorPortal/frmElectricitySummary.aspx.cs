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
    public partial class frmElectricitySummary : System.Web.UI.Page
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
                        mpLabel.Text = "Electricity Entry Summary";
                    }
                    BindProductionOrerList();
                }
            }
            
        }
        public void BindProductionOrerList()
        {
            using (EDMXConnectionString context = new EDMXConnectionString())
            {
                IEnumerable<NAV_ItemLedgerEntry_Electricity_Result> Details = context.Database.SqlQuery<NAV_ItemLedgerEntry_Electricity_Result>("exec NAV_ItemLedgerEntry_Electricity ").ToList();
                rpt.DataSource = Details;
                rpt.DataBind();
            }
        }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            Response.Redirect("frmElecNegPosEntry.aspx", false);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {

        }
    }
}