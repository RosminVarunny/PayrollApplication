using BusinessLogic;
using BusinessObject;
using System;
using System.Data;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PayrollApplication
{
    public partial class Payroll : Page
    {
        EmployeeBL ObjBL = new EmployeeBL();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                LoadEmployee();
                LoadMonth();
                LoadYear();
            }
        }
       
        public void BindGrid()
        {
            EmployeeBO ObjBo = new EmployeeBO();
            ObjBo.AutoID = Convert.ToInt32(Employee.SelectedValue);
            ObjBo.Duration = Hours.Text == ""?0:Convert.ToDecimal(Hours.Text);
            DataTable dt = (DataTable)ObjBL.Payroll(ObjBo);
            DataColumn newColumn = new DataColumn("Month", typeof(System.String));
            newColumn.DefaultValue = Month.SelectedItem;
            dt.Columns.Add(newColumn);
            DataColumn newColumn1 = new DataColumn("Year", typeof(System.String));
            newColumn1.DefaultValue = Year.SelectedValue;
            dt.Columns.Add(newColumn1);
            GridView.DataSource = dt;
            GridView.DataBind();
        }
        public void LoadMonth()
        {
            for (int month = 1; month <= 12; month++)
            {
                string monthName = DateTimeFormatInfo.CurrentInfo.GetMonthName(month);
                Month.Items.Add(new ListItem(monthName, month.ToString().PadLeft(2, '0')));
            }
            Month.SelectedValue = DateTimeFormatInfo.CurrentInfo.GetMonthName(DateTime.Now.Month);
        }
        public void LoadYear()
        {
            for (int jLoop = DateTime.Now.Year; jLoop >= 1980; jLoop--)
            {
                Year.Items.Add(new ListItem(jLoop.ToString(), jLoop.ToString()));
            }
            Year.SelectedValue = DateTime.Now.Year.ToString();
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                BindGrid();
            }
            catch (Exception ex)
            {
                lblmsg.Text = ex.Message.ToString();
                lblmsg.ForeColor = System.Drawing.Color.Red;
            }
        }
        public void clear()
        {
            Hours.Text = "";
            Employee.SelectedValue = "0";
            Month.SelectedValue = "0";
            Year.SelectedValue = "0";
        }

        protected void GridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView.PageIndex = e.NewPageIndex;
            this.BindGrid();
        }
        public void LoadEmployee()
        {
            try
            {
                Employee.DataSource = ObjBL.Load();
                Employee.DataBind();
                Employee.DataTextField = "Name";
                Employee.DataValueField = "AutoId";
                Employee.DataBind();
                Employee.Items.Insert(0, new ListItem("--Select--", "0"));
            }
            catch (Exception ex)
            {

            }
        }
    }
}