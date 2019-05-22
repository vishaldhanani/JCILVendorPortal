using System;
using System.Collections.Generic;
using System.Text;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.Common;
using System.Collections;


namespace VendorLib
{
    public class Vendor
    {
       
        private String m_VendorName;
        public String VendorName
        {
            get { return m_VendorName; }
            set { m_VendorName = value; }
        }
        private int m_ID;
        public int ID
        {
            get { return m_ID; }
            set { m_ID = value; }
        }
        private String m_UserName;
        public String UserName
        {
            get { return m_UserName; }
            set { m_UserName = value; }
        }
        private String m_Password;
        public String Password
        {
            get { return m_Password; }
            set { m_Password = value; }
        }
        
        
        private String m_NavUserName;
        public String NavUserName
        {
            get { return m_NavUserName; }
            set { m_NavUserName = value; }
        
        }
        private String m_NavPassword;
        public String NavPassword
        {
            get { return m_NavPassword; }
            set { m_NavPassword = value; }
        }
        


        private String m_UserType;

        public String UserType
        {
            get { return m_UserType; }
            set { m_UserType = value; }
        }

        private Boolean m_AccountActivated;

        public Boolean AccountActivated
        {
            get { return m_AccountActivated; }
            set { m_AccountActivated = value; }
        }

        
        
        public static ArrayList List()
        {
            string strSQL = string.Empty;
            ArrayList list = new ArrayList();
            SqlDataReader reader;
            strSQL = "ListAgent_sp";
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand dbCommand = db.GetStoredProcCommand(strSQL);
            try
            {
                reader = (SqlDataReader)db.ExecuteReader(dbCommand);
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        Vendor obj = new Vendor();

                        //obj.timestamp=Convert.ToTime(reader.GetValue(reader.GetOrdinal("timestamp")));
                        //obj.Code=Convert.ToString(reader.GetValue(reader.GetOrdinal("Code")));
                        //obj.Agent Name=Convert.ToString(reader.GetValue(reader.GetOrdinal("Agent Name")));
                        //obj.Agent Address=Convert.ToString(reader.GetValue(reader.GetOrdinal("Agent Address")));
                        //obj.Agent Calc_ Base=Convert.ToInt32(reader.GetValue(reader.GetOrdinal("Agent Calc_ Base")));
                        //obj.Commision Type=Convert.ToInt32(reader.GetValue(reader.GetOrdinal("Commision Type")));
                        //obj.Agent Calc_ Rate=Convert.ToDecimal(reader.GetValue(reader.GetOrdinal("Agent Calc_ Rate")));
                        //obj.Agent Currency=Convert.ToString(reader.GetValue(reader.GetOrdinal("Agent Currency")));
                        //obj.Agent Price List=Convert.ToString(reader.GetValue(reader.GetOrdinal("Agent Price List")));
                        //obj.Agent Special Price List=Convert.ToString(reader.GetValue(reader.GetOrdinal("Agent Special Price List")));
                        //obj.Agent Type=Convert.ToInt32(reader.GetValue(reader.GetOrdinal("Agent Type")));
                        //obj.Agent Code=Convert.ToString(reader.GetValue(reader.GetOrdinal("Agent Code")));
                        
                        obj.UserName = Convert.ToString(reader.GetValue(reader.GetOrdinal("UserName")));
                        obj.Password = Convert.ToString(reader.GetValue(reader.GetOrdinal("Password")));

                        list.Add(obj);
                    }
                }
                if (!reader.IsClosed)
                    reader.Close();
            }
            catch (SqlException e)
            { throw e; }
            catch (Exception e)
            { throw e; }
            finally
            {
                dbCommand.Dispose();
                dbCommand = null;
                db = null;
            }
            return list;
        }

        public static Vendor LoginCredentials(string UserName, string Password)
        {
            string strSQL = string.Empty;
            SqlDataReader reader;
            strSQL = "LoginCredentials";
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand dbCommand = db.GetStoredProcCommand(strSQL);
            Vendor obj = null;
            try
            {
                db.AddInParameter(dbCommand, "UserName", DbType.String, UserName);
                db.AddInParameter(dbCommand, "Password", DbType.String, Password);
                reader = (SqlDataReader)db.ExecuteReader(dbCommand);
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        obj = new Vendor();
                        //obj.Code = Convert.ToString(reader.GetValue(reader.GetOrdinal("Code")));
                        //obj.AgentName = Convert.ToString(reader.GetValue(reader.GetOrdinal("Agent Name")));
                        //obj.AgentAddress = Convert.ToString(reader.GetValue(reader.GetOrdinal("Agent Address")));
                        ////obj.Status = Convert.ToInt32(reader.GetValue(reader.GetOrdinal("Status")));
                        //obj.UserName = Convert.ToString(reader.GetValue(reader.GetOrdinal("UserName")));
                        //obj.Password = Convert.ToString(reader.GetValue(reader.GetOrdinal("Password")));
                        //obj.ItemCategoryCode = Convert.ToString(reader.GetValue(reader.GetOrdinal("ItemCategoryCode")));
                        obj.ID = Convert.ToInt32(reader.GetValue(reader.GetOrdinal("ID")));
                        obj.VendorName = Convert.ToString(reader.GetValue(reader.GetOrdinal("UserName")));
                        obj.NavUserName = Convert.ToString(reader.GetValue(reader.GetOrdinal("NavUserName")));
                        obj.NavPassword = Convert.ToString(reader.GetValue(reader.GetOrdinal("NavPassword"))); 
                        obj.AccountActivated = Convert.ToBoolean(reader.GetValue(reader.GetOrdinal("ActiveUser")));
                        obj.UserType = Convert.ToString(reader.GetValue(reader.GetOrdinal("TypeOfUser")));
                       
                    }
                }
                if (!reader.IsClosed)
                    reader.Close();
            }
            catch (SqlException e)
            { throw e; }
            catch (Exception e)
            { throw e; }
            finally
            {
                dbCommand.Dispose();
                dbCommand = null;
                db = null;
            }
            return obj;
        }

        

        
    }
}