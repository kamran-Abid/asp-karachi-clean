using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BussinessCommunityReport : System.Web.UI.Page
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

            DataTable Gender = ObjCommon.Gender();

            ddlGender.DataSource = Gender;
            ddlGender.DataValueField = "ID";
            ddlGender.DataTextField = "GenderName";
            ddlGender.DataBind();
            ddlGender.Items.Insert(0, new ListItem("ALL", ""));

            DataTable BCateogry = ObjCommon.GetBusinessCommunityCategory();

            ddlBusinessCategory.DataSource = BCateogry;
            ddlBusinessCategory.DataValueField = "ID";
            ddlBusinessCategory.DataTextField = "BusinessName";
            ddlBusinessCategory.DataBind();
            ddlBusinessCategory.Items.Insert(0, new ListItem("ALL", ""));
        }
    }

    //protected void btnSearch_Click(object sender, EventArgs e)
    //{
    //    //  string QueryFilters = " select FirstName + ' ' + LastName Name ,FatherName,MotherName ";
    //    string Query = "select BCD.Name , BCD.FatherName , BCD.CNIC,  BC.BusinessName  from mctx_BusinessCommunityDetail BCD" +
    //            "  inner join mctx_BusinessCommunity BC on BCD.BusinessCommunityCategory = BC.ID"+
    //            "  inner join Gender gen on gen.ID = BCD.Gender"+
    //            "  inner join BloodGroup BG on BG.ID = BCD.BloodGroup"+
    //            "  inner join ClearanceStatus CS on CS.ID = BCD.ClearanceStatus"+
    //            "  inner join mctx_PersonSiteAllowed psa on psa.ID = BCD.ClearanceLevel"+

    //              " where ('"+txtFristName.Text+ "' = '' or  BCD.Name = '" + txtFristName.Text + "')" +
    //              " and('"+ddlGender.SelectedValue+ "' = '' or BCD.Gender = '" + ddlGender.SelectedValue + "')" +
    //              " and('"+ddlSiteAllowed.SelectedValue+ "' = '' or BCD.ClearanceLevel = '" + ddlSiteAllowed.SelectedValue + "')" +
    //              " and('"+ddlclearanceStatus.SelectedValue+ "' = '' or BCD.ClearanceStatus = '" + ddlclearanceStatus.SelectedValue + "')" +
    //              " and('"+ ddlBusinessCategory.SelectedValue + "' = '' or BCD.BusinessCommunityCategory = '"+ ddlBusinessCategory.SelectedValue + "')";

    //    DataSet ds = ObjCommon.GetEmployeeDetailForGV(Query);

    //    GVdetails.DataSource = ds;
    //    GVdetails.DataBind();
    //}

    //protected void btnSaveExcel_Click(object sender, EventArgs e)


    protected void GetBusnesCommunityReport_Click(object sender, EventArgs e)
    {

        string Name = txtbcName.Text;
        string Gender = ddlGender.SelectedValue;
        string SiteAllow = ddlclearanceStatus.SelectedValue;
        string ClearnceAllow = ddlSiteAllowed.SelectedValue;
        string BussinessCat = ddlBusinessCategory.SelectedValue;


        DateTime date_Froms = DateTime.Parse(DDateFrom.Text);
        DateTime date_to = DateTime.Parse(DDateTo.Text);
        string DateFrom = date_Froms.ToString("MM/dd/yyyy");
        string DateTo = date_to.ToString("MM/dd/yyy");

        BussinesLoadReport(Name, Gender, SiteAllow, ClearnceAllow, BussinessCat, DateFrom, DateTo);


    }
    public void BussinesLoadReport(string Name, string Gender, string SiteAllow, string ClearnceAllow, string BussinessCat, string DateFrom, string DateTo)
     {
        DataTable ResultsTable = new DataTable();

        DataSet ds = new System.Data.DataSet();
        DBManager db_Manager = new DBManager();

        try
        {
           
            db_Manager.AddParameterReport("@F_Name", Name);
            db_Manager.AddParameterReport("@Gender", Gender);
            db_Manager.AddParameterReport("@ClearStatus", ClearnceAllow);
            db_Manager.AddParameterReport("@ClearnceLeve", ClearnceAllow);

            db_Manager.AddParameterReport("@Business_catagory", BussinessCat);



            db_Manager.AddParameterReport("@FromDate", DateFrom);
            db_Manager.AddParameterReport("@ToDate", DateTo);
            ds = db_Manager.ExecuteDataSet("Business_Community_Report", "vmsconnectionstring");

            ReportViewer1.Visible = true;
            ReportDataSource rds = new ReportDataSource("BussinessCommunityDataSet", ds.Tables[0]);
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.DataSources.Add(rds);

        }
        catch (Exception ex)
        {

        }


    }
}