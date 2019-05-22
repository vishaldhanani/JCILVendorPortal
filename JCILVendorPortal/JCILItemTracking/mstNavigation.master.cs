using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JCILVendorPortal.JCILItemTracking
{
    public partial class mstNavigation : System.Web.UI.MasterPage
    {
        Approut objRoutes = new Approut();
        public void BindNavigation()
        {
            rptNavigationMobile.DataSource = objRoutes.getRoutes().Where(x => x.IsShowURL == true);
            rptNavigationMobile.DataBind();
            rptNavigationlg.DataSource = objRoutes.getRoutes().Where(x => x.IsShowURL == true);
            rptNavigationlg.DataBind();

            //showUserTag.Text = Convert.ToString(Session["VendorName"]);
            //lblNavUser.Text = Convert.ToString(Session["NavUserName"]);
            //lblTypUser.Text = Convert.ToString(Session["TypeOfUser"]);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindNavigation();
            }
        }
    }
}