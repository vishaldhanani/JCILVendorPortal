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
    public class DataLogHistory
    {
        private DateTime m_LoginInTime;
        public DateTime LoginInTime
        {
            get { return m_LoginInTime; }
            set { m_LoginInTime = value; }
        }

        private DateTime m_LoginOutTime;
        public DateTime LoginOutTime
        {
            get { return m_LoginOutTime; }
            set { m_LoginOutTime = value; }
        }

        private int m_LoginUserID;
        public int LoginUserID
        {
            get { return m_LoginUserID; }
            set { m_LoginUserID = value; }
        }
        private int m_AccessActivity;
        public int AccessActivity
        {
            get { return m_AccessActivity; }
            set { m_AccessActivity = value; }
        }

      


        public static int InsertLogHistory(DataLogHistory obj)
        {
            int result = 0;
            const string strSql = "CreateLogHistory";
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand dbCommand = db.GetStoredProcCommand(strSql);
            try
            {

                db.AddInParameter(dbCommand, "LoginUserID", DbType.Int32, obj.LoginUserID);
                db.AddInParameter(dbCommand, "LoginInTime", DbType.DateTime, obj.LoginInTime);
                db.AddInParameter(dbCommand, "AccessActivity", DbType.Int32, obj.AccessActivity);
                db.AddOutParameter(dbCommand,"ID",DbType.Int32,1);
                db.ExecuteNonQuery(dbCommand);
                result = Convert.ToInt32(db.GetParameterValue(dbCommand, "@ID"));
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                dbCommand.Dispose();
                dbCommand = null;
                db = null;
            }
            return result;
        }

        public static int UpdateLogHistory(int id, DateTime dt)
        {
            int result = 0;
            const string strSql = "UpdateLogHistory";
            Database db = DatabaseFactory.CreateDatabase();
            DbCommand dbCommand = db.GetStoredProcCommand(strSql);
            try
            {

                db.AddInParameter(dbCommand, "LoginUserID", DbType.Int32, id);
                db.AddInParameter(dbCommand, "LogOutTime", DbType.DateTime, dt);
                db.ExecuteNonQuery(dbCommand);
                result = 1;
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                dbCommand.Dispose();
                dbCommand = null;
                db = null;
            }
            return result;
        }

    }
}
