using BusinessObject;
using DataAccess;

namespace BusinessLogic
{
    public class EmployeeBL
    {
        EmployeeDA DAobj = new EmployeeDA();
        public int Save(EmployeeBO ObjBO) // passing Bussiness object Here  
        {
            try
            {
                return DAobj.Save(ObjBO); // calling Method of DataAccess  
            }
            catch
            {
                throw;
            }
        }
        public object Load() // passing Bussiness object Here  
        {
            try
            {
                return DAobj.Load(); // calling Method of DataAccess  
            }
            catch
            {
                throw;
            }
        }
        public object Payroll(EmployeeBO ObjBo) // passing Bussiness object Here  
        {
            try
            {
                return DAobj.Payroll(ObjBo); // calling Method of DataAccess  
            }
            catch
            {
                throw;
            }
        }
        public void Delete(EmployeeBO ObjBO) // passing Bussiness object Here  
        {
            try
            {
                DAobj.Delete(ObjBO); // calling Method of DataAccess  
            }
            catch
            {
                throw;
            }
        }
        public int IsExists(EmployeeBO ObjBO) // passing Bussiness object Here  
        {
            try
            {
                return DAobj.IsExists(ObjBO); // calling Method of DataAccess  
            }
            catch
            {
                throw;
            }
        }
    }
}
