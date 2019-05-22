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
using System.Web.UI.HtmlControls;

namespace JCILVendorPortal
{
    public partial class RegisteredVendorList : System.Web.UI.Page
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
                    BindVendorList();
                }
            }
        }
        public void BindVendorList()
        {
            try
            {
                using (EDMXConnectionString context = new EDMXConnectionString())
                {
                    var oficio = new SqlParameter
                    {
                        ParameterName = "LastDate",
                        Value = DateTime.Now.ToString("yyyy-MM-dd")
                    };

                    var Details = "";// context.Database.SqlQuery<NewOpenVendorList_Result2>("exec NewOpenVendorList @LastDate", oficio).ToList<NewOpenVendorList_Result2>();
                    
                    rpt.DataSource = Details;
                    rpt.DataBind();
                }
            }
            catch (Exception ex)
            {
                var message1 = new JavaScriptSerializer().Serialize(ex.Message.ToString());
                var script1 = string.Format("alert({0});", message1);
                ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "", script1, true);
            }
        }

        protected void txtDate_TextChanged(object sender, EventArgs e)
        {
            try
            {
                using (EDMXConnectionString context = new EDMXConnectionString())
                {
                    var oficio = new SqlParameter
                    {
                        ParameterName = "LastDate",
                        Value = Convert.ToDateTime(txtDate.Text).ToString("yyyy-MM-dd")
                    };

                    var Details = ""; //context.Database.SqlQuery<NewOpenVendorList_Result2>("exec NewOpenVendorList @LastDate", oficio).ToList<NewOpenVendorList_Result2>();
                    rpt.DataSource = Details;
                    rpt.DataBind();
                }
            }
            catch (Exception ex)
            {
                var message1 = new JavaScriptSerializer().Serialize(ex.Message.ToString());
                var script1 = string.Format("alert({0});", message1);
                ScriptManager.RegisterClientScriptBlock(Page, Page.GetType(), "", script1, true);
            }
        }

        protected void rpt_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item)
            {
                HtmlTableRow tr = (HtmlTableRow)e.Item.FindControl("trID");
                Label l = e.Item.FindControl("lblSr") as Label;
                string gen = Convert.ToString(l.Text);

                if (gen == "True")
                {
                    tr.Attributes.Add("style", "background:#ddc9aa !important;");
                    tr.Attributes.Add("Title", "Given for update missing details!!");
                    
                }
                
            }
        }
    }
}