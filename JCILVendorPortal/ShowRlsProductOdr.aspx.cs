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
using System.Data.SqlClient;

namespace JCILVendorPortal
{
    public partial class ShowRlsProductOdr : System.Web.UI.Page
    {
        Approut objRout = new Approut();
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
                    //Label mpLabel = (Label)Page.Master.FindControl("lblPageCenterHeader");
                    //if (mpLabel != null)
                    //{
                    //    mpLabel.Text = "Steam Entry Summary";
                    //}
                    BindProductionOrerList();
                }
            }            
        }
        public void BindProductionOrerList()
        {
            using (EDMXConnectionString context = new EDMXConnectionString())
            {
                var oficio = new SqlParameter
                {
                    ParameterName = "UserId",
                    Value = Convert.ToString(Session["NavUserName"])
                };
                //IEnumerable<NAV_ProductionOrder_Result> Details = context.Database.SqlQuery<NAV_ProductionOrder_Result>("exec NAV_ProductionOrder ").ToList();
                //rpt.DataSource = Details;
                //rpt.DataBind();

                var Details = context.Database.SqlQuery<NAV_ProductionOrder_Result>("exec NAV_ProductionOrder @UserId", oficio).ToList<NAV_ProductionOrder_Result>();
                rpt.DataSource = Details;
                rpt.DataBind();
            }
        }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            Response.Redirect(objRout.getPath("ReleaseOrder"), false);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {

        }
    }
}