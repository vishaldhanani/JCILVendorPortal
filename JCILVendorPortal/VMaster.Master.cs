using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VendorLib;
namespace JCILVendorPortal
{
    public partial class VMaster : System.Web.UI.MasterPage
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
                    lblUserName.Text = Convert.ToString(Session["VendorName"]);
                    lblNavUser.Text = Convert.ToString(Session["NavUserName"]);
                    lblTypUser.Text = Convert.ToString(Session["TypeOfUser"]);
                }
            }
        }
    }
}