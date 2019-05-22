using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.SessionState;
using System.IO;
using System.Security.Cryptography;
using System.Data;
using System.Configuration;

namespace VendorLib
{
    public class SessionManager
    {
        #region Varible
        public static string CartTableName = "Cart";
        #endregion

        #region Create User Session
        public static void CreateUserSession(HttpContext hc)
        {
            hc.Session.Add("VendorName", "");
 
        }

        #endregion

        #region Add To User Session
        public static void AddToUserSession(HttpContext hc, string VendorName)
        {

            hc.Session["VendorName"] = VendorName;
            hc.Session.Timeout = 60;

            //hc.Session["FullName"] = FullName;
            //hc.Session.Timeout = 60;
        }

        public static void AddToNavUserSession(HttpContext hc, string VendorName)
        {

            hc.Session["NavUserName"] = VendorName;
            hc.Session.Timeout = 60;

            //hc.Session["FullName"] = FullName;
            //hc.Session.Timeout = 60;
        }
        public static void AddToNavUserPasswordSession(HttpContext hc, string password)
        {

            hc.Session["NavPassword"] = password;
            hc.Session.Timeout = 60;

            //hc.Session["FullName"] = FullName;
            //hc.Session.Timeout = 60;
        }
        public static void AddToUserLogID(HttpContext hc, int ID)
        {

            hc.Session["UserLogID"] = ID;
            hc.Session.Timeout = 60;

            //hc.Session["FullName"] = FullName;
            //hc.Session.Timeout = 60;
        }
        public static void AddToUserID(HttpContext hc, int ID)
        {

            hc.Session["UserID"] = ID;
            hc.Session.Timeout = 60;

            //hc.Session["FullName"] = FullName;
            //hc.Session.Timeout = 60;
        }
        public static void AddTypeOfUser(HttpContext hc, string ID)
        {

            hc.Session["TypeOfUser"] = ID;
            hc.Session.Timeout = 60;

            //hc.Session["FullName"] = FullName;
            //hc.Session.Timeout = 60;
        }
        #endregion


        #region End User Session
        public static void EndUserSession(HttpContext hc)
        {
            hc.Session["VendorName"] = null;
            
            //hc.Session["AdminUserType"] = null;
        }

        #endregion

        #region End Front User Session
        public static void EndFrontUserSession(HttpContext hc)
        {
            hc.Session["VendorName"] = null;
  
        }

        #endregion

        #region Check User Session
        public static void CheckUserSession(HttpContext hc, string loginurl)
        {
            //if (hc.Session["AdminUserName"].Equals(String.Empty))
            if (hc.Session["VendorName"] == null )
            {
                hc.Response.Redirect(loginurl);
            }
            //if (hc.Session["AgentCode"] == null || hc.Session["CustName"] == null || hc.Session["userName"] == null || hc.Session["CompanyCode"] == null || hc.Session["CustomerId"] == null || hc.Session["CustPriGrp"] == null || hc.Session["Customer"] == null || hc.Session["Consignee"] == null)
        }

        public static string GetUserID(HttpContext hc)
        {
            if (hc.Session["UserID"] == null)
            {
                return String.Empty;
            }
            else
            {
                return hc.Session["UserID"].ToString();
            }
        }
        public static int GetUserLogID(HttpContext hc)
        {
            if (hc.Session["UserLogID"] == null)
            {
                return 0;
            }
            else
            {
                return Convert.ToInt32(hc.Session["UserLogID"]);
            }
        }
        public static String GetTypeOfUser(HttpContext hc)
        {
            if (hc.Session["TypeOfUser"] == null)
            {
                return null;
            }
            else
            {
                return Convert.ToString(hc.Session["TypeOfUser"]);
            }
        }
        
        public static string GetNAVUserName(HttpContext hc)
        {
            if (hc.Session["NavUserName"] == null)
            {
                return String.Empty;
            }
            else
            {
                return hc.Session["NavUserName"].ToString();
            }
        }
        public static string GetNAVUserPassword(HttpContext hc)
        {
            if (hc.Session["NavPassword"] == null)
            {
                return String.Empty;
            }
            else
            {
                return hc.Session["NavPassword"].ToString();
            }
        }
        #endregion
       
        #region Cart
        public static void CartTable(HttpContext hc)
        {
            DataTable dtTemp = new DataTable();
            DataSet ds = new DataSet();
            DataColumn[] dc = new DataColumn[1];
            dtTemp.TableName = CartTableName;
            dtTemp.Columns.Add("noField", System.Type.GetType("System.String"));
            dtTemp.Columns.Add("ProductCode", System.Type.GetType("System.String"));
            dtTemp.Columns.Add("ProductName", System.Type.GetType("System.String"));
            dtTemp.Columns.Add("Quantity", System.Type.GetType("System.Decimal"));
            dtTemp.Columns.Add("Rate", System.Type.GetType("System.Decimal"));
            dtTemp.Columns.Add("SellingPrice", System.Type.GetType("System.Decimal"));
            dtTemp.Columns.Add("UOM", System.Type.GetType("System.String"));
            dtTemp.Columns.Add("VariantCode", System.Type.GetType("System.String"));
            dtTemp.Columns.Add("Remark", System.Type.GetType("System.String"));
            dtTemp.Columns.Add("CSellingPrice", System.Type.GetType("System.Decimal"));
            dtTemp.Columns.Add("DiscPercentage", System.Type.GetType("System.Decimal"));
            dtTemp.Columns.Add("DiscPrice", System.Type.GetType("System.Decimal"));
            dtTemp.Columns.Add("ExtField_Cprice", System.Type.GetType("System.Decimal"));
            dtTemp.Columns.Add("ExtField_SellingPrice", System.Type.GetType("System.Decimal"));

            // Added below two fields by vishal for Dyes
            dtTemp.Columns.Add("DyesDiscPrice", System.Type.GetType("System.Decimal"));
            dtTemp.Columns.Add("DyesNetAmount", System.Type.GetType("System.Decimal"));
            dtTemp.Columns.Add("BillPrice", System.Type.GetType("System.Decimal"));




            ds.Tables.Add(dtTemp);
            hc.Session[CartTableName] = ds;
        }

        //public static string AddProductToCart(string ProductCode, string ProductName, string Variant, string UOM, decimal Price, decimal Qty, decimal discountpercentage)
        //{
        //    try
        //    {
        //        bool IsProductExists = false;
        //        DataSet dsCart = (DataSet)HttpContext.Current.Session[CartTableName];
        //        if (dsCart.Tables[CartTableName] != null && dsCart.Tables[CartTableName].Rows.Count >= Convert.ToInt32(ConfigurationManager.AppSettings["MaxOrderItem"]))
        //        {
        //            // added by raj shah - MaxOrderItem is defined in web.config but not initialed in 
        //            return "You can not add product more than" + Convert.ToInt32(ConfigurationManager.AppSettings["MaxOrderItem"]) + ".";
        //        }
        //        else
        //        {
        //            if (dsCart.Tables[CartTableName] != null)
        //            {
        //                if (dsCart.Tables[CartTableName].Rows.Count > 0)
        //                {
        //                    for (int i = 0; i < dsCart.Tables[CartTableName].Rows.Count; i++)
        //                    {
        //                        if (ProductCode.ToLower().Equals(dsCart.Tables[CartTableName].Rows[i]["ProductCode"].ToString().ToLower()))
        //                        {
        //                            if (Variant.ToLower().Equals(dsCart.Tables[CartTableName].Rows[i]["VariantCode"].ToString().ToLower()))
        //                            {
        //                                IsProductExists = true;
        //                                // Because Case for Same Item is not consider while development and now change it for same item add. ( 06-10-2015 ) 
        //                                //break;                                        
        //                            }
        //                        }                                
        //                    }
        //                    if (IsProductExists)
        //                    {
                                
        //                        //int inum = dsCart.Tables[CartTabsleName].Rows.Count;
        //                        //return "Product is already exists.";
        //                        return "Product is already added in the Cart.";
        //                        //inum = inum + 1;
        //                        //DataRow dr = dsCart.Tables[CartTableName].NewRow();
        //                        //dr["noField"] = Convert.ToString(inum);
        //                        //dr["ProductCode"] = ProductCode;
        //                        //dr["ProductName"] = ProductName;
        //                        //dr["Quantity"] = Qty;
        //                        //dr["Rate"] = Price;
        //                        //dr["SellingPrice"] = Qty * Price;
        //                        //dr["UOM"] = UOM;
        //                        //dr["VariantCode"] = Variant;
        //                        //dr["Remark"] = "";
        //                        //dr["CSellingPrice"] = 0;
        //                        //dr["DiscPrice"] = 0;
        //                        //dr["DiscPercentage"] = discountpercentage;
        //                        //dr["ExtField_Cprice"] = 0;
        //                        //dr["ExtField_SellingPrice"] = 0;

        //                        //// Added below two fields by vishal for Dyes
        //                        //dr["DyesDiscPrice"] = 0;
        //                        //dr["DyesNetAmount"] = 0;
        //                        //dr["BillPrice"] = 0;

        //                        //dsCart.Tables[CartTableName].Rows.Add(dr);

        //                    }
        //                    else
        //                    {
        //                        int inum = dsCart.Tables[CartTableName].Rows.Count;
        //                        //return "Product is already exists.";
        //                        inum = inum + 1;

        //                        DataRow dr = dsCart.Tables[CartTableName].NewRow();
        //                        dr["noField"] = Convert.ToString(inum);
        //                        dr["ProductCode"] = ProductCode;
        //                        dr["ProductName"] = ProductName;
        //                        dr["Quantity"] = Qty;
        //                        dr["Rate"] = Price;
        //                        dr["SellingPrice"] = Qty * Price;
        //                        dr["UOM"] = UOM;
        //                        dr["VariantCode"] = Variant;
        //                        dr["Remark"] = "";
        //                        dr["CSellingPrice"] = 0;
        //                        dr["DiscPrice"] = 0;
        //                        dr["DiscPercentage"] = discountpercentage;
        //                        dr["ExtField_Cprice"] = 0;
        //                        dr["ExtField_SellingPrice"] = 0;

        //                        // Added below two fields by vishal for Dyes
        //                        dr["DyesDiscPrice"] = 0;
        //                        dr["DyesNetAmount"] = 0;
        //                        dr["BillPrice"] = 0;

        //                        dsCart.Tables[CartTableName].Rows.Add(dr);
        //                    }
        //                }
        //                else
        //                {
        //                    int inum = dsCart.Tables[CartTableName].Rows.Count;
        //                    //return "Product is already exists.";
        //                    inum = inum + 1;
        //                    DataRow dr = dsCart.Tables[CartTableName].NewRow();
        //                    dr["noField"] = Convert.ToString(inum);
        //                    dr["ProductCode"] = ProductCode;
        //                    dr["ProductName"] = ProductName;
        //                    dr["Quantity"] = Qty;
        //                    dr["Rate"] = Price;
        //                    dr["SellingPrice"] = Qty * Price;
        //                    dr["UOM"] = UOM;
        //                    dr["VariantCode"] = Variant;
        //                    dr["Remark"] = "";
        //                    dr["CSellingPrice"] = 0;
        //                    dr["DiscPrice"] = 0;
        //                    dr["DiscPercentage"] = discountpercentage;
        //                    dr["ExtField_Cprice"] = 0;
        //                    dr["ExtField_SellingPrice"] = 0;

        //                    // Added below two fields by vishal for Dyes
        //                    dr["DyesDiscPrice"] = 0;
        //                    dr["DyesNetAmount"] = 0;
        //                    dr["BillPrice"] = 0;

        //                    dsCart.Tables[CartTableName].Rows.Add(dr);
        //                }
        //            }
        //            else
        //            {
        //                return "Sorry cart is not available.";
        //            }
        //            return string.Empty;
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}

        //public static void UpdateProductToCart(string ProductCode, string ProductName, string Variant, string UOM, decimal Price, decimal Qty, string Remark, decimal CPrice, decimal DisPercentage)
        //{
        //    try
        //    {
        //        DataSet dsCart = (DataSet)HttpContext.Current.Session[CartTableName];


        //        if (dsCart.Tables[CartTableName] != null)
        //        {
        //            if (dsCart.Tables[CartTableName].Rows.Count > 0)
        //            {

        //                for (int i = 0; i < dsCart.Tables[CartTableName].Rows.Count; i++)
        //                {
        //                    // Added by Raj Shah 06/10/2015
        //                    // Changed the code for the purpose of Veifying which item to update.


        //                    if (ProductCode.ToLower().Equals(dsCart.Tables[CartTableName].Rows[i]["ProductCode"].ToString().ToLower()))
        //                    {
        //                        if ((dsCart.Tables[CartTableName].Rows[i]["VariantCode"].ToString().ToLower()) == "")
        //                        {


        //                            Decimal DisPrice = (CPrice * DisPercentage) / 100;
        //                            Decimal Amt = ((CPrice * Qty) * DisPercentage) / 100;
        //                            Decimal AmountAfterDiscount = (CPrice * Qty) - Amt;
        //                            Decimal CpriceDiscount = (CPrice - DisPrice);

        //                            // Added below two fields by vishal for Dyes
        //                            Decimal DyesDisAmt = (Price * DisPercentage) / 100;
        //                            Decimal DyesNetPrice = (Price - DyesDisAmt);

        //                            int inum = dsCart.Tables[CartTableName].Rows.Count;
        //                            //return "Product is already exists.";

        //                            dsCart.Tables[CartTableName].Rows[i]["noField"] = Convert.ToString(inum);
        //                            dsCart.Tables[CartTableName].Rows[i]["ProductCode"] = ProductCode;
        //                            dsCart.Tables[CartTableName].Rows[i]["ProductName"] = ProductName;
        //                            dsCart.Tables[CartTableName].Rows[i]["Quantity"] = Qty;
        //                            dsCart.Tables[CartTableName].Rows[i]["Rate"] = Price;
        //                            dsCart.Tables[CartTableName].Rows[i]["SellingPrice"] = Math.Round(AmountAfterDiscount); //Qty * CPrice;
        //                            dsCart.Tables[CartTableName].Rows[i]["UOM"] = UOM;
        //                            dsCart.Tables[CartTableName].Rows[i]["VariantCode"] = Variant;
        //                            dsCart.Tables[CartTableName].Rows[i]["Remark"] = Remark;
        //                            // Removed Roudingdue to the problem of Sales Order Line creation. - Raj Shah 24/09/2015
        //                            dsCart.Tables[CartTableName].Rows[i]["CSellingPrice"] = (CPrice);
        //                            dsCart.Tables[CartTableName].Rows[i]["DiscPrice"] = (DisPrice);
        //                            dsCart.Tables[CartTableName].Rows[i]["DiscPercentage"] = DisPercentage;
        //                            dsCart.Tables[CartTableName].Rows[i]["ExtField_Cprice"] = CpriceDiscount;
        //                            dsCart.Tables[CartTableName].Rows[i]["ExtField_SellingPrice"] = Math.Round(Qty * CPrice);

        //                            // Added below two fields by vishal for Dyes
        //                            dsCart.Tables[CartTableName].Rows[i]["DyesDiscPrice"] = DyesDisAmt;
        //                            dsCart.Tables[CartTableName].Rows[i]["DyesNetAmount"] = DyesNetPrice;

        //                        }
        //                        else
        //                        {
        //                            if (ProductCode.ToLower().Equals(dsCart.Tables[CartTableName].Rows[i]["ProductCode"].ToString().ToLower()))
        //                            {
        //                                // reverse for that 
        //                                if ((dsCart.Tables[CartTableName].Rows[i]["VariantCode"].ToString().ToLower()) != "")
        //                                {
        //                                    int tempi = i + 1;
        //                                    if ((tempi).Equals(dsCart.Tables[CartTableName].Rows[i]["noField"].ToString().ToLower()))
        //                                    {
        //                                        Decimal DisPrice = (CPrice * DisPercentage) / 100;
        //                                        Decimal Amt = ((CPrice * Qty) * DisPercentage) / 100;
        //                                        Decimal AmountAfterDiscount = (CPrice * Qty) - Amt;
        //                                        Decimal CpriceDiscount = (CPrice - DisPrice);

        //                                        // Added below two fields by vishal for Dyes
        //                                        Decimal DyesDisAmt = (Price * DisPercentage) / 100;
        //                                        Decimal DyesNetPrice = (Price - DyesDisAmt);


        //                                        int inum = dsCart.Tables[CartTableName].Rows.Count;
        //                                        //return "Product is already exists.";

        //                                        dsCart.Tables[CartTableName].Rows[i]["noField"] = Convert.ToString(inum);
        //                                        dsCart.Tables[CartTableName].Rows[i]["ProductCode"] = ProductCode;
        //                                        dsCart.Tables[CartTableName].Rows[i]["ProductName"] = ProductName;
        //                                        dsCart.Tables[CartTableName].Rows[i]["Quantity"] = Qty;
        //                                        dsCart.Tables[CartTableName].Rows[i]["Rate"] = Price;
        //                                        dsCart.Tables[CartTableName].Rows[i]["SellingPrice"] = Math.Round(AmountAfterDiscount); //Qty * CPrice;
        //                                        dsCart.Tables[CartTableName].Rows[i]["UOM"] = UOM;
        //                                        dsCart.Tables[CartTableName].Rows[i]["VariantCode"] = Variant;
        //                                        dsCart.Tables[CartTableName].Rows[i]["Remark"] = Remark;
        //                                        // Removed Roudingdue to the problem of Sales Order Line creation. - Raj Shah 24/09/2015
        //                                        dsCart.Tables[CartTableName].Rows[i]["CSellingPrice"] = (CPrice);
        //                                        dsCart.Tables[CartTableName].Rows[i]["DiscPrice"] = (DisPrice);
        //                                        dsCart.Tables[CartTableName].Rows[i]["DiscPercentage"] = DisPercentage;
        //                                        dsCart.Tables[CartTableName].Rows[i]["ExtField_Cprice"] = CpriceDiscount;
        //                                        dsCart.Tables[CartTableName].Rows[i]["ExtField_SellingPrice"] = Math.Round(Qty * CPrice);

        //                                        // Added below two fields by vishal for Dyes
        //                                        dsCart.Tables[CartTableName].Rows[i]["DyesDiscPrice"] = DyesDisAmt;
        //                                        dsCart.Tables[CartTableName].Rows[i]["DyesNetAmount"] = DyesNetPrice;

        //                                    }
        //                                }
        //                            }
        //                        }
        //                    }
        //                }
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}

        
        //public static string GetCartCount()
        //{
        //    try
        //    {
        //        if (HttpContext.Current.Session[CartTableName] != null)
        //        {
        //            DataSet dsCart = (DataSet)HttpContext.Current.Session[CartTableName];
        //            if (dsCart.Tables[CartTableName] != null)
        //            {
        //                return dsCart.Tables[CartTableName].Rows.Count.ToString();
        //            }
        //            else
        //            {
        //                return "0";
        //            }
        //        }
        //        else
        //        {
        //            return "0";
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}

        //public static void ClearCart(HttpContext hc)
        //{
        //    try
        //    {
        //        hc.Session[CartTableName] = null;
        //    }
        //    catch (Exception)
        //    {

        //        throw;
        //    }
        //}

        //public static string DeleteProductFromCart(string ProductCode, int id)
        //{
        //    try
        //    {
        //        if (HttpContext.Current.Session[CartTableName] != null)
        //        {
        //            DataSet dsCart = (DataSet)HttpContext.Current.Session[CartTableName];
        //            if (dsCart.Tables[CartTableName] != null)
        //            {
        //                //foreach (DataRow dr in dsCart.Tables[CartTableName].Rows)
        //                //{
        //                //    if (ProductCode.ToLower().Equals(dr["ProductCode"].ToString().ToLower()))
        //                //    {
        //                //        dsCart.Tables[CartTableName].Rows.Remove(dr);
        //                //    }
        //                //}
        //                for (int i = 0; i < dsCart.Tables[CartTableName].Rows.Count; i++)
        //                {
        //                    if (ProductCode.ToLower().Equals(dsCart.Tables[CartTableName].Rows[i]["ProductCode"].ToString().ToLower()))
        //                    {
        //                        if ((dsCart.Tables[CartTableName].Rows[i]["noField"].ToString().ToLower()) == Convert.ToString(id))
        //                        {
        //                            dsCart.Tables[CartTableName].Rows.RemoveAt(i);
        //                        }
        //                    }
        //                }
        //                dsCart.Tables[CartTableName].AcceptChanges();
        //            }
        //            HttpContext.Current.Session[CartTableName] = dsCart;
        //        }
        //        return string.Empty;
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}
        //public static string DeleteProductFromCartData(string ProductCode, int Rate)
        //{
        //    try
        //    {
        //        if (HttpContext.Current.Session[CartTableName] != null)
        //        {
        //            DataSet dsCart = (DataSet)HttpContext.Current.Session[CartTableName];
        //            if (dsCart.Tables[CartTableName] != null)
        //            {
        //                for (int i = 0; i < dsCart.Tables[CartTableName].Rows.Count; i++)
        //                {
        //                    if (ProductCode.ToLower().Equals(dsCart.Tables[CartTableName].Rows[i]["ProductCode"].ToString().ToLower()))
        //                    {
        //                        if ((dsCart.Tables[CartTableName].Rows[i]["Rate"].ToString().ToLower()) == Convert.ToString(Rate))
        //                        {
        //                            dsCart.Tables[CartTableName].Rows.RemoveAt(i);
        //                        }
        //                    }
        //                    dsCart.Tables[CartTableName].AcceptChanges();
        //                }
        //                dsCart.Tables[CartTableName].AcceptChanges();
        //            }
        //            HttpContext.Current.Session[CartTableName] = dsCart;
        //        }
        //        return string.Empty;
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}


        #endregion
    }
}