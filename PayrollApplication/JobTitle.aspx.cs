using BusinessLogic;
using BusinessObject;
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PayrollApplication
{
    public partial class JobTitle : Page
    {
        JobTitleBL ObjBL = new JobTitleBL();
        
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!this.IsPostBack)
            {
                this.BindGrid();
            }
        }
        public void CreateGlobalTable()
        {
            DataTable dt = new DataTable();
            dt.Columns.AddRange(new DataColumn[4] { new DataColumn("AutoID"), new DataColumn("Code"), new DataColumn("Description"), new DataColumn("Salary") });
            ViewState["dt"] = dt;
        }
        public void BindGrid()
        {
            ViewState["dt"] = (DataTable)ObjBL.LoadJobTitle();
            GridView.DataSource = (DataTable) ViewState["dt"];
            GridView.DataBind();
        }
        public void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                JobTitleBO ObjBO = new JobTitleBO();
                ObjBO.Code = JobCode.Text;
                ObjBO.Description = Description.Text;
                ObjBO.Salary = Salary.Text == "" ? 0 : Convert.ToDecimal(Salary.Text);
                ObjBO.AutoID = AutoID.Value == "" ? 0 : Convert.ToInt32(AutoID.Value);
                int isexists = ObjBL.IsExists(ObjBO);
                if(isexists == 1)
                {
                    JobCode.Text = "";
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
            JobCode.Text = "";
            Description.Text = "";
            Salary.Text = "";
            AutoID.Value = "";
        }

        protected void GridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView.EditIndex = e.NewEditIndex;
            this.BindGrid();
        }


        protected void GridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int index = Convert.ToInt32(e.RowIndex);
                GridViewRow row = GridView.Rows[index];
                string code = (row.Cells[1].Controls[1] as TextBox).Text;
                string desc = (row.Cells[2].Controls[1] as TextBox).Text;
                string salary = (row.Cells[3].Controls[1] as TextBox).Text;
                int autoId = Convert.ToInt32(GridView.DataKeys[index].Values[0]);
                JobTitleBO ObjBo = new JobTitleBO();
                ObjBo.AutoID = autoId;
                ObjBo.Code = code;
                ObjBo.Description = desc;
                ObjBo.Salary = Convert.ToDecimal(salary);
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
            JobTitleBO ObjBO = new JobTitleBO();
            ObjBO.Code = GridView.Rows[index].Cells[2].Text;
            ObjBL.Delete(ObjBO);
        }

        protected void lnkRemove_Click(object sender, EventArgs e)
        {
            GridViewRow row = (sender as LinkButton).NamingContainer as GridViewRow;
            JobTitleBO ObjBO = new JobTitleBO();
            ObjBO.AutoID = Convert.ToInt32(GridView.DataKeys[row.DataItemIndex].Values[0]);
            ObjBL.Delete(ObjBO);
            this.BindGrid();
        }

        protected void GridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView.PageIndex = e.NewPageIndex;
            this.BindGrid();
        }
    }
}