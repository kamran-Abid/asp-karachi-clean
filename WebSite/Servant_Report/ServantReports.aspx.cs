using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Servant_Report_ServantReports : System.Web.UI.Page
{
    Common ObjCommon = new Common();
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            DDateFrom.Text = DateTime.Today.AddDays(-1).ToString("MM/dd/yyyy");
            DDateTo.Text = DateTime.Today.ToString("MM/dd/yyyy");

            ReportViewer1.Visible = false;
            DataTable dtSiteAllowed = ObjCommon.GetSiteAllowed();
            ddlSiteAllowed.DataSource = dtSiteAllowed;
            ddlSiteAllowed.DataValueField = "ID";
            ddlSiteAllowed.DataTextField = "Site_Name";
            ddlSiteAllowed.DataBind();
            ddlSiteAllowed.Items.Insert(0, new ListItem("ALL", ""));

            DataTable ClearanceStatus = ObjCommon.ClearanceStatus();
            ddlclearanceStatus.DataSource = ClearanceStatus;
            ddlclearanceStatus.DataValueField = "ID";
            ddlclearanceStatus.DataTextField = "ClearanceStatusName";
            ddlclearanceStatus.DataBind();
            ddlclearanceStatus.Items.Insert(0, new ListItem("ALL", ""));
        }

    }

    protected void GetServantReport_Click(object sender, EventArgs e)
    {
        string Name = txtbcName.Text;
        string cnic = txtcnic.Text;
        string SiteAllow = ddlclearanceStatus.SelectedValue;
        string ClearnceAllow = ddlSiteAllowed.SelectedValue;
        string bcnumber = txtbcnumber.Text;


        DateTime date_Froms = DateTime.Parse(DDateFrom.Text);
        DateTime date_to = DateTime.Parse(DDateTo.Text);
        string DateFrom = date_Froms.ToString("MM/dd/yyyy");
        string DateTo = date_to.ToString("MM/dd/yyy");

        ServantLoadReport(Name, cnic, SiteAllow, ClearnceAllow, bcnumber, DateFrom, DateTo);


    }

    public void ServantLoadReport(string Name, string cnic, string SiteAllow, string ClearnceAllow, string bcnumber, string DateFrom, string DateTo)
    {
        DataTable ResultsTable = new DataTable();
        DataSet ds = new System.Data.DataSet();
        DBManager db_Manager = new DBManager();

        try
        {

            db_Manager.AddParameterReport("@F_Name", Name);
            db_Manager.AddParameterReport("@CNIC", cnic);
            db_Manager.AddParameterReport("@ClearStatus", ClearnceAllow);
            db_Manager.AddParameterReport("@ClearnceLeve", ClearnceAllow);
            db_Manager.AddParameterReport("@bcNumber", bcnumber);
            db_Manager.AddParameterReport("@FromDate", DateFrom);
            db_Manager.AddParameterReport("@ToDate", DateTo);
            ds = db_Manager.ExecuteDataSet("Servant_Report", "vmsconnectionstring");
            ReportViewer1.Visible = true;
            ReportDataSource rds = new ReportDataSource("ServantDataSet", ds.Tables[0]);
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.DataSources.Add(rds);
        }
        catch (Exception ex)
        {

        }

    }
}