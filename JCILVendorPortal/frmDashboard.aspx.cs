using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using VendorLib;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.UI.HtmlControls;
using System.Web.Script.Serialization;
using System.Data.SqlClient;

namespace JCILVendorPortal
{
    public partial class frmDashboard : System.Web.UI.Page
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
                    BindDashboardMenu();
                }
            }
        }

        public void BindDashboardMenu()
        {
            using (EDMXConnectionString context = new EDMXConnectionString())
            {
                var oficio = new SqlParameter
                {
                    ParameterName = "UserTypeID",
                    Value = SessionManager.GetTypeOfUser(HttpContext.Current) 
                };

                var Details = context.Database.SqlQuery<DashboardDynamicMenu_Result>("exec DashboardDynamicMenu @UserTypeID", oficio).ToList<DashboardDynamicMenu_Result>();
                 //var Details = context.Database.SqlQuery<DashboardDynamicMenu_Result>("exec DashboardDynamicMenu @UserTypeID ", UserTypeID).ToList<DashboardDynamicMenu_Result>();
                rpt_Dashboard.DataSource = Details;
                rpt_Dashboard.DataBind();
            }
        }
        protected void rpt_Dashboard_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            try
            {
                if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
                {
                    HtmlAnchor a_link = e.Item.FindControl("a_link") as HtmlAnchor;
                    if (a_link != null)
                    {
                        a_link.HRef = Convert.ToString(DataBinder.Eval(e.Item.DataItem, "DashboardLink"));
                    }
                }
            }
            catch (Exception ex)
            {
                var message = new JavaScriptSerializer().Serialize(ex.Message.ToString());
                var script = string.Format("alert({0});window.location='frmDashBoard.aspx';", message);
                ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "", script, true);
            }
        }
    }
}