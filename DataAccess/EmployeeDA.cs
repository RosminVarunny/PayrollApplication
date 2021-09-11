using BusinessObject;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace DataAccess
{
    public class EmployeeDA
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Myconstr"].ToString());
        public int Save(EmployeeBO ObjBO) // passing Bussiness object Here  
        {
            try
            {
                SqlCommand cmd = new SqlCommand("SP_Employee", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Operation", "Save");
                cmd.Parameters.AddWithValue("@AutoID", ObjBO.AutoID);
                cmd.Parameters.AddWithValue("@Code", ObjBO.Code);
                cmd.Parameters.AddWithValue("@Name", ObjBO.Name);
                cmd.Parameters.AddWithValue("@Duration", ObjBO.Duration);
                cmd.Parameters.AddWithValue("@JobTitleID", ObjBO.JobTitleId);
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
        public object Load()
        {
            try
            {
                SqlCommand cmd = new SqlCommand("SP_Employee", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Operation", "selectAll");
                cmd.Parameters.AddWithValue("@AutoID", 0);
                cmd.Parameters.AddWithValue("@Code", null);
                cmd.Parameters.AddWithValue("@Name", null);
                cmd.Parameters.AddWithValue("@Duration", null);
                cmd.Parameters.AddWithValue("@JobTitleID", null);
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
        public void Delete(EmployeeBO ObjBO) // passing Bussiness object Here  
        {
            try
            {
                SqlCommand cmd = new SqlCommand("SP_Employee", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Operation", "Delete");
                cmd.Parameters.AddWithValue("@AutoID", ObjBO.AutoID);
                cmd.Parameters.AddWithValue("@Code", ObjBO.Code);
                cmd.Parameters.AddWithValue("@Name", ObjBO.Name);
                cmd.Parameters.AddWithValue("@Duration", ObjBO.Duration);
                cmd.Parameters.AddWithValue("@JobTitleID", ObjBO.JobTitleId);
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
        public int IsExists(EmployeeBO ObjBO) // passing Bussiness object Here  
        {
            try
            {
                SqlCommand cmd = new SqlCommand("SP_Employee", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Operation", "IsExists");
                cmd.Parameters.AddWithValue("@AutoID", ObjBO.AutoID);
                cmd.Parameters.AddWithValue("@Code", ObjBO.Code);
                cmd.Parameters.AddWithValue("@Name", ObjBO.Name);
                cmd.Parameters.AddWithValue("@Duration", ObjBO.Duration);
                cmd.Parameters.AddWithValue("@JobTitleID", ObjBO.JobTitleId);
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
        public object Payroll(EmployeeBO ObjBo)
        {
            try
            {
                SqlCommand cmd = new SqlCommand("SP_Employee", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Operation", "Payroll");
                cmd.Parameters.AddWithValue("@AutoID", ObjBo.AutoID);
                cmd.Parameters.AddWithValue("@Code", ObjBo.Code);
                cmd.Parameters.AddWithValue("@Name", null);
                cmd.Parameters.AddWithValue("@Duration", ObjBo.Duration);
                cmd.Parameters.AddWithValue("@JobTitleID", null);
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
    }
}
