using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.SessionState;
using VendorLib;
namespace JCILVendorPortal
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


            DataLogHistory.UpdateLogHistory(SessionManager.GetUserLogID(HttpContext.Current), System.DateTime.Now);

            Response.Cache.SetNoStore();
            Response.Redirect("VendorLogin.aspx");
        }
    }
}