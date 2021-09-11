using Microsoft.Reporting.WebForms;
using System;
using System.Web.UI;

namespace PayrollApplication
{
    public partial class PaySlipReport : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string Month = Request.QueryString["Month"];
            string year = Request.QueryString["Year"];
            string name = Request.QueryString["Name"];
            string code = Request.QueryString["Code"];
            string Tot = Request.QueryString["TotalAmt"];
            string basic = Request.QueryString["Basic"];
            string housing = Request.QueryString["Housing"];
            string transport = Request.QueryString["Transport"];
            string tax = Request.QueryString["Tax"];
            if (!this.IsPostBack)
            {
               
                ReportViewer1.LocalReport.ReportPath = "rptPaySlip.rdlc";
                ReportParameter[] param = new ReportParameter[] {
                new ReportParameter("Month", Month,false),
                new ReportParameter("Year", year, false),
                new ReportParameter("Name", name, false),
                new ReportParameter("Code", code, false),
                new ReportParameter("TotalAmt", Tot, false),
                new ReportParameter("Housing", housing, false),
                new ReportParameter("Transport", transport, false),
                new ReportParameter("Basic", basic, false),
                new ReportParameter("Tax", tax, false),
            };
                ReportViewer1.LocalReport.SetParameters(param);
                ReportViewer1.LocalReport.Refresh();
            }
        }
    }
}