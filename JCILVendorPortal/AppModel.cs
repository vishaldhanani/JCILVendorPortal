using System;
using System.Collections.Generic;
using System.Linq;
using System.Data.SqlClient;
using System.Web;
using System.Configuration;
using System.Web.UI;
using System.Data.SqlClient;
using System.Web.Routing;

namespace JCILVendorPortal
{
    public class AppTools
    {
        public void jsWarning(Page pgIntance, string alertValue)
        {
            ScriptManager.RegisterClientScriptBlock(pgIntance.Page, pgIntance.Page.GetType(), "", "alert('Waring!" + @alertValue + "');", true);
        }
        public void jsError(Page pgIntance, string alertValue)
        {
            ScriptManager.RegisterClientScriptBlock(pgIntance.Page, pgIntance.Page.GetType(), "", "alert('Error!" + @alertValue + "');", true);
        }
        public decimal getDecimal(string Values)
        {
            decimal DefaultDecimal = 0;
            return decimal.TryParse(Values, out DefaultDecimal) == true ? Convert.ToDecimal(Values) : 0;
        }
    }
    public class AppSQL
    {
        public SqlConnection VendorConn = new SqlConnection(Convert.ToString(ConfigurationManager.ConnectionStrings["VendorPortalEntities"]));
    }
    public class AppSession
    {
        public string getSessionValue(HttpContext hc, string SessionName)
        {
            return Convert.ToString(hc.Session[SessionName]);
        }
        public object getSession(HttpContext hc, string SessionName)
        {
            return hc.Session[SessionName];
        }
        public void setSession(HttpContext hc, string SessionName, object ObjectValue)
        {
            hc.Session.Add(SessionName, ObjectValue);
        }
        public void setSession(HttpContext hc, string SessionName, string StringValue)
        {
            hc.Session.Add(SessionName, StringValue);
        }
        public bool IsSession(HttpContext hc, string SessionName)
        {
            return hc.Session[SessionName] == null ? false : true;
        }
        public void unsetSession(HttpContext hc, string SessionName)
        {
            hc.Session.Remove(SessionName);
        }
        public void unsetSession(HttpContext hc)
        {
            hc.Session.RemoveAll();
            hc.Session.Abandon();
        }
    }
    public class Approut
    {
        public RouteAttrib[] getRoutes()
        {
            List<RouteAttrib> LstRoutes = new List<RouteAttrib>();
            LstRoutes.Add(new RouteAttrib() { PageControl = "~/Index", PageURL = "Index", PageTag = "Index", PhysicalAddress = "~/JCILItemTracking/Default.aspx", IsShowURL = false });
            LstRoutes.Add(new RouteAttrib() { PageControl = "~/Dashboard", PageURL = "Dashboard", PageTag = "Dashboard", PhysicalAddress = "~/JCILItemTracking/frmDashboard.aspx", IsShowURL = false });
            LstRoutes.Add(new RouteAttrib() { PageControl = "~/Orders", PageURL = "Orders", PageTag = "Show Order", PhysicalAddress = "~/JCILItemTracking/ShowRlsProductOdr.aspx", IsShowURL = true });
            LstRoutes.Add(new RouteAttrib() { PageControl = "~/ProductBOM", PageURL = "ProdBOM", PageTag = "Product BOM", PhysicalAddress = "~/JCILItemTracking/frmProdBOM.aspx", IsShowURL = false });
            LstRoutes.Add(new RouteAttrib() { PageControl = "~/CreateOrder", PageURL = "ReleaseOrder", PageTag = "Release Order", PhysicalAddress = "~/JCILItemTracking/ReleaseProdtctOrder.aspx", IsShowURL = false });
            LstRoutes.Add(new RouteAttrib() { PageControl = "~/SignOut", PageURL = "SignOut", PageTag = "SignOut", PhysicalAddress = "~/Logout.aspx", IsShowURL = false });

            return LstRoutes.ToArray();
        }
        public void setRoute(RouteCollection routeList)
        {
            var ListRoutes = getRoutes().Select(x => new { PageControl = x.PageControl, PageURL = x.PageURL, PhysicalAddress = x.PhysicalAddress });
            foreach (var RoutItem in ListRoutes)
            {
                routeList.MapPageRoute(RoutItem.PageControl, RoutItem.PageURL, RoutItem.PhysicalAddress);
            }
        }
        public object getNavigation()
        {
            var ListRoutes = getRoutes().Where(x => x.IsShowURL == true).Select(x => new { PageControl = x.PageControl, PageURL = x.PageURL, PageTag = x.PageTag });
            return ListRoutes;
        }
        public string getPath(string PageURL)
        {
            RouteAttrib[] LstNavigation = getRoutes();
            string path = string.Empty;
            for (int i = 0; i < LstNavigation.Length; i++)
            {
                if (LstNavigation[i].PageURL == PageURL)
                {
                    path = Convert.ToString(LstNavigation[i].PageControl);
                }
            }
            return path;
        }
        [Serializable()]
        public class RouteAttrib
        {
            public string PageControl { get; set; }
            public string PageURL { get; set; }
            public string PageTag { get; set; }
            public string PhysicalAddress { get; set; }
            public bool IsShowURL { get; set; }
        }
    }
}