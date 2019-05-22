#region "Library"
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VendorLib;
using System.Web.Services;
using System.Collections;
#endregion "Library"

namespace JCILVendorPortal
{
    public partial class ClientSideWebMethod : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string LoginCredential(string Username, string Password)
        {
            try
            {
                string Success = "Success";
                string SuccessApp = "SuccessApp";

                string Fail = "Fail";
                Vendor obj = Vendor.LoginCredentials(Username, Password);
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
            catch (Exception ex)
            {
                //throw ex;
                return ex.Message;
            }
        }

    }
}