using BusinessLogic;
using BusinessObject;
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PayrollApplication
{
    public partial class Employee : Page
    {
        EmployeeBL ObjBL = new EmployeeBL();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.BindGrid();
                LoadJobTitle();
            }
        }
       
        public void BindGrid()
        {
            ViewState["dt"] = (DataTable)ObjBL.Load();
            GridView.DataSource = (DataTable)ViewState["dt"];
            GridView.DataBind();
        }
        public void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                EmployeeBO ObjBO = new EmployeeBO();
                ObjBO.Code = Code.Text;
                ObjBO.Name = Name.Text;
                ObjBO.Duration = Duration.Text == "" ? 0 : Convert.ToDecimal(Duration.Text);
                ObjBO.AutoID = AutoID.Value == "" ? 0 : Convert.ToInt32(AutoID.Value);
                ObjBO.JobTitleId = Convert.ToInt32(JobTitle.SelectedValue);
                int isexists = ObjBL.IsExists(ObjBO);
                if (isexists == 1)
                {
                    Code.Text = "";
                    throw new Exception("Duplicate Code");
                }
                int i = ObjBL.Save(ObjBO);
                if (i > 0)
                {
                    if (ObjBO.AutoID > 0)
                    {
                        lblmsg.Text = "Updated Successfully";
                    }
                    else
                    {
                        lblmsg.Text = "Inserted Successfully";
                    }
                    lblmsg.ForeColor = System.Drawing.Color.DarkGreen;
                    this.BindGrid();
                    clear();
                }
                else
                {
                    lblmsg.Text = "Something went wrong !!!";
                    lblmsg.ForeColor = System.Drawing.Color.Red;
                }
            }
            catch (Exception ex)
            {
                lblmsg.Text = ex.Message.ToString();
                lblmsg.ForeColor = System.Drawing.Color.Red;
            }
        }
        public void clear()
        {
            Code.Text = "";
            Name.Text = "";
            Duration.Text = "";
            AutoID.Value = "";
            JobTitle.SelectedIndex = 0;
        }

        protected void GridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView.EditIndex = e.NewEditIndex;
            this.BindGrid();
            int index = Convert.ToInt32(e.NewEditIndex);
            GridViewRow row = GridView.Rows[index];
            
            LoadddlJobTitle(row);
        }


        protected void GridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int index = Convert.ToInt32(e.RowIndex);
                GridViewRow row = GridView.Rows[index];
                string code = (row.Cells[1].Controls[1] as TextBox).Text;
                string name = (row.Cells[2].Controls[1] as TextBox).Text;
                string duration = (row.Cells[3].Controls[1] as TextBox).Text;
                string jobtitleid = (row.Cells[4].Controls[1] as DropDownList).SelectedValue;
                int autoId = Convert.ToInt32(GridView.DataKeys[index].Values[0]);
                EmployeeBO ObjBo = new EmployeeBO();
                ObjBo.AutoID = autoId;
                ObjBo.Code = code;
                ObjBo.Name = name;
                ObjBo.Duration = Convert.ToDecimal(duration);
                ObjBo.JobTitleId = Convert.ToInt32(jobtitleid);
                int isexists = ObjBL.IsExists(ObjBo);
                if (isexists == 1)
                {
                    throw new Exception("Duplicate Code");
                }
                ObjBL.Save(ObjBo);

                GridView.EditIndex = -1;
                this.BindGrid();
            }
            catch (Exception ex)
            {
                lblmsg.Text = ex.Message.ToString();
                lblmsg.ForeColor = System.Drawing.Color.Red;
            }
        }



        protected void GridView_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView.EditIndex = -1;
            this.BindGrid();
        }

        protected void GridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int index = Convert.ToInt32(e.RowIndex);
            GridViewRow row = (sender as LinkButton).NamingContainer as GridViewRow;
            EmployeeBO ObjBO = new EmployeeBO();
            ObjBO.Code = GridView.Rows[index].Cells[2].Text;
            ObjBL.Delete(ObjBO);
        }

        protected void lnkRemove_Click(object sender, EventArgs e)
        {
            GridViewRow row = (sender as LinkButton).NamingContainer as GridViewRow;
            EmployeeBO ObjBO = new EmployeeBO();
            ObjBO.AutoID = Convert.ToInt32(GridView.DataKeys[row.DataItemIndex].Values[0]);
            ObjBL.Delete(ObjBO);
            this.BindGrid();
        }

        protected void GridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView.PageIndex = e.NewPageIndex;
            this.BindGrid();
        }
        public void LoadJobTitle()
        {
            try
            {
                JobTitleBL jobbl = new JobTitleBL();
                JobTitle.DataSource = jobbl.LoadJobTitle();
                JobTitle.DataBind();
                JobTitle.DataTextField = "Description";
                JobTitle.DataValueField = "AutoId";
                JobTitle.DataBind();
                JobTitle.Items.Insert(0, new ListItem("--Select--", "0"));
            }
            catch (Exception ex)
            {

            }
        }
        public void LoadddlJobTitle(GridViewRow row)
        {
            try
            {
                DropDownList ddlJobTitle = (row.FindControl("ddlJobTitle") as DropDownList);
                HiddenField hdnJobTitle = (row.FindControl("hdnJobTitle") as HiddenField);
                JobTitleBL jobbl = new JobTitleBL();
                ddlJobTitle.DataSource = jobbl.LoadJobTitle();
                ddlJobTitle.DataBind();
                ddlJobTitle.DataTextField = "Description";
                ddlJobTitle.DataValueField = "AutoId";
                ddlJobTitle.DataBind();
                ddlJobTitle.SelectedValue = hdnJobTitle.Value;
            }
            catch (Exception ex)
            {

            }
        }
    }
}