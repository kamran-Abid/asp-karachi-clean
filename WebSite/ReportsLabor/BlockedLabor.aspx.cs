using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class RepotrsLabor_BlockedLabor : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ddDateFrom.Text = DateTime.Today.AddDays(-1).ToString("MM/dd/yyyy");
            ddDateTo.Text = DateTime.Today.ToString("MM/dd/yyyy");

            ReportViewer1.Visible = false;
        }
    }

    protected void btnsearch_Click(object sender, EventArgs e)
    {
        DateTime date_Froms = DateTime.ParseExact(ddDateFrom.Text + " 00:00:00.000", "MM/dd/yyyy 00:00:00.000", null);
        DateTime date_to = DateTime.ParseExact(ddDateFrom.Text + " 00:00:00.000", "MM/dd/yyyy 00:00:00.000", null);
        string DateFrom = date_Froms.ToString("yyyy-MM-dd");
        string DateTo = date_to.ToString("yyyy-MM-dd");
        DataTable ResultsTable = new DataTable();
        DataSet ds = new System.Data.DataSet();
        DBManager db_Manager = new DBManager();

        try
        {


            db_Manager.AddParameterReport("@ToDate", DateTo);
            db_Manager.AddParameterReport("@FromDate", DateFrom);
            ds = db_Manager.ExecuteDataSet("Block_Labor_reports", "vmsconnectionstring");
            ReportViewer1.Visible = true;
            ReportDataSource rds = new ReportDataSource("BlockedLaborDataSet", ds.Tables[0]);
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.DataSources.Add(rds);
        }
        catch (Exception ex)
        {

        }


    }
}