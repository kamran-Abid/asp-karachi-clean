using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class EmployeeFamilyeeDetailReport : System.Web.UI.Page
{
    Common ObjCommon = new Common();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) {
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
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
      //  string QueryFilters = " select FirstName + ' ' + LastName Name ,FatherName,MotherName ";
        string Query = "select empF.FirstName + '' +empF.LastName Name , empF.NIC , empF.Mobile , DateOfBirth , address  from employeeFamily empF "+
                            "  inner join Employee emp on emp.EID = empF.EID"+
                            "  inner join HR_Designation desg on desg.Designation_ID = emp.Designation"+
                            "  inner join mctx_Department dept on dept.Department_ID = emp.Department"+
                            "  inner join Gender gen on gen.ID = empF.FamilyGender"+
                            "  inner join BloodGroup BG on BG.ID = emp.BloodGroup"+
                            "  inner join mctx_Cadre ca on ca.ID = emp.Cadre"+
                            "  inner join CardColor cc on cc.CardColor_ID = emp.CardColor"+
                            "  inner join mctx_Rasidant_Status RS on RS.ID = emp.ResidantStatus"+
                            "  inner join KRL_Transport TR on TR.Transport_ID = emp.Transport"+
                            "  inner join Section sec on sec.ID = emp.Section"+
                            "  inner join ClearanceStatus CS on CS.ID = emp.ClearanceStatus"+
                            "  inner join ClearanceStatus CSF on CSF.ID = empF.SecurityClearance"+
                            "  inner join mctx_PersonSiteAllowed psa on psa.ID = emp.ClearanceLevel"+
                            "  inner join mctx_PersonSiteAllowed psaF on psaF.ID = empF.ClearanceLevel"+


                            "  where('"+txtFristName.Text+"' = '' or empF.FirstName = '"+txtFristName.Text+"')"+
                            "  and('"+ddlGender.SelectedValue+ "' = '' or empF.FamilyGender = '" + ddlGender.SelectedValue + "')"+
                            "  and('"+ddlSiteAllowed.SelectedValue+ "' = '' or empF.ClearanceLevel = '" + ddlSiteAllowed.SelectedValue + "')" +
                            "  and('"+ddlclearanceStatus.SelectedValue+ "' = '' or empF.SecurityClearance = '" + ddlclearanceStatus.SelectedValue + "')";

        DataSet ds = ObjCommon.GetEmployeeDetailForGV(Query);

        GVdetails.DataSource = ds;
        GVdetails.DataBind();
    }

    protected void btnSaveExcel_Click(object sender, EventArgs e)
    {

    }
}