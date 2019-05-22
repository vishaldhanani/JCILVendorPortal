using AppStarSQL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using VendorLib;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JCILVendorPortal.JCILItemTracking
{
    public partial class Default : System.Web.UI.Page
    {
        Approut objRoute = new Approut();
        SQLServer objSQLServer = new SQLServer();
        AppSQL objSQL = new AppSQL();
        public string IsValid(string UserID, string Password)
        {
            //DataTable dtUsers = objSQLServer.Fill_Datatable(objSQL.VendorConn, "LoginCredentials", new string[] { UserID, Password });
            //if (dtUsers.Rows.Count > 0)
            //{
            //    return true;
            //}
            //else
            //{
            //    return false;
            //}

            string Success = "Success";
            string SuccessApp = "SuccessApp";

            string Fail = "Fail";
            Vendor obj = Vendor.LoginCredentials(UserID, Password);
            if (obj != null)
            {
                HttpContext.Current.Session["VendorName"] = obj.VendorName;
                SessionManager.AddToUserSession(HttpContext.Current, obj.VendorName);
                SessionManager.AddToNavUserSession(HttpContext.Current, obj.NavUserName);
                SessionManager.AddToNavUserPasswordSession(HttpContext.Current, obj.NavPassword);
                SessionManager.AddToUserID(HttpContext.Current, obj.ID);
                SessionManager.AddTypeOfUser(HttpContext.Current, obj.UserType);

                // LOG ALL THE ENTRIES OF THE USER 
                DataLogHistory loghi = new DataLogHistory();
                loghi.LoginUserID = obj.ID;
                loghi.LoginInTime = System.DateTime.Now;
                loghi.AccessActivity = 1;
                int result = DataLogHistory.InsertLogHistory(loghi);
                SessionManager.AddToUserLogID(HttpContext.Current, result);
                // MAIN USER LOG SUMMARY

                if (obj.AccountActivated == false)
                {
                    return Fail;
                }
                else
                {

                    return Success;
                }
            }
            else
            {
                return Fail;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtUserID.Attributes.Add("autocomplete", "off");
            }
        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                if (IsValid(txtUserID.Text, txtPassword.Text) == "Success")
                {
                    Response.Redirect(objRoute.getPath("Dashboard"), false);
                }
                else
                {

                }
            }
            catch (Exception)
            {
            }
        }
    }
}