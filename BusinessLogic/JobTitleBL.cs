using BusinessObject;
using DataAccess;

namespace BusinessLogic
{
    public class JobTitleBL
    {
        JobTitleDA DAobj = new JobTitleDA();
        public int Save(JobTitleBO ObjBO) // passing Bussiness object Here  
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
        public object LoadJobTitle() // passing Bussiness object Here  
        {
            try
            {
                return DAobj.LoadJobTitle(); // calling Method of DataAccess  
            }
            catch
            {
                throw;
            }
        }  
        public void Delete(JobTitleBO ObjBO) // passing Bussiness object Here  
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
        public int IsExists(JobTitleBO ObjBO) // passing Bussiness object Here  
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
