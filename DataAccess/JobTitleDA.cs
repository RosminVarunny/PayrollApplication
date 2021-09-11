using BusinessObject;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace DataAccess
{
    public class JobTitleDA
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Myconstr"].ToString());
        public int Save(JobTitleBO ObjBO) // passing Bussiness object Here  
        {
            try
            {
                SqlCommand cmd = new SqlCommand("SP_JobTitle", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Operation", "Save");
                cmd.Parameters.AddWithValue("@AutoID", ObjBO.AutoID);
                cmd.Parameters.AddWithValue("@Code", ObjBO.Code);
                cmd.Parameters.AddWithValue("@Description", ObjBO.Description);
                cmd.Parameters.AddWithValue("@Salary", ObjBO.Salary);
                con.Open();
                int Result = cmd.ExecuteNonQuery();
                cmd.Dispose();
                con.Close();
                return Result;
            }
            catch
            {
                con.Close();
                throw;
            }
        }
        public object LoadJobTitle()
        {
            try
            {
                SqlCommand cmd = new SqlCommand("SP_JobTitle", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Operation", "selectAll");
                cmd.Parameters.AddWithValue("@AutoID", 0);
                cmd.Parameters.AddWithValue("@Code", null);
                cmd.Parameters.AddWithValue("@Description", null);
                cmd.Parameters.AddWithValue("@Salary", null);
                con.Open();
                DataTable dt = new DataTable();
                SqlDataReader rdr = null;
                rdr = cmd.ExecuteReader();
                dt.Load(rdr);
                con.Close();
                return dt;
            }
            catch
            {
                con.Close();
                throw;
            }
        }
        public void Delete(JobTitleBO ObjBO) // passing Bussiness object Here  
        {
            try
            {
                SqlCommand cmd = new SqlCommand("SP_JobTitle", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Operation", "Delete");
                cmd.Parameters.AddWithValue("@AutoID", ObjBO.AutoID);
                cmd.Parameters.AddWithValue("@Code", ObjBO.Code);
                cmd.Parameters.AddWithValue("@Description", ObjBO.Description);
                cmd.Parameters.AddWithValue("@Salary", ObjBO.Salary);
                con.Open();
                cmd.ExecuteNonQuery();
                cmd.Dispose();
                con.Close();
            }
            catch
            {
                con.Close();
                throw;
            }
        }
        public int IsExists(JobTitleBO ObjBO) // passing Bussiness object Here  
        {
            try
            {
                SqlCommand cmd = new SqlCommand("SP_JobTitle", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Operation", "IsExists");
                cmd.Parameters.AddWithValue("@AutoID", ObjBO.AutoID);
                cmd.Parameters.AddWithValue("@Code", ObjBO.Code);
                cmd.Parameters.AddWithValue("@Description", ObjBO.Description);
                cmd.Parameters.AddWithValue("@Salary", ObjBO.Salary);
                con.Open();
                int x = Convert.ToInt32(cmd.ExecuteScalar());
                cmd.Dispose();
                con.Close();
                return x;
            }
            catch
            {
                con.Close();
                throw;
            }
        }
    }
}
