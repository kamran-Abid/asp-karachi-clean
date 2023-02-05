using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using OfficeOpenXml.FormulaParsing.Excel.Functions.DateTime;
using System.IO;
using System.Web.Services;
using System.Drawing;
using System.Data.SqlClient;
using System.Text;
public partial class Residents_Residents : System.Web.UI.Page
{
    //Refresh function
    protected void ClearAll(object sender, EventArgs e)
    {

        Response.Redirect(Request.RawUrl);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        txtCountEmp.Text = DBCommonMethods.GetActiveEmployees();

        //using (SqlConnection scn = new SqlConnection(@"Data Source =DESKTOP-P65HT14\SQLEXPRESS; Initial Catalog=NLC_DB-16-07-2022; User ID=sa;Password=sa@1234"))
        //{
        //    scn.Open();
        //    //  string query1 = "SELECT COUNT(*) FORM EMPLOYEE";
        //    SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FRoM EMPLOYEE WHERE STATUS='Active'", scn);

        //    //// Add the parameter required by the query....
        //    //cmd.Parameters.Add(query1,scn).Value = txtCountEmp;

        //    //// Run the query and get the single row/column returned
        //    object value = cmd.ExecuteScalar();

        //    // If it is not null (possible if the where fails) then put on textbox
        //    //if (value !=null)
        //    //{
        //    txtCountEmp.Text = value.ToString();
        //    //txtCountEmp.
        //    //}
        //}


        Common ObjCommon = new Common();

        DataTable dtDepartments = ObjCommon.GetDepartmentsForResidentSearch();

        txtGuestnationality.Items.Insert(0, new ListItem("--Select Country--", ""));
        txtGuestnationality.Items.Insert(1, new ListItem("Pakistan", "Pakistan"));
        



        ddlDepartmentSearch.DataSource = dtDepartments;
        ddlDepartmentSearch.DataValueField = "Department_Id";
        ddlDepartmentSearch.DataTextField = "Department_Name";
        ddlDepartmentSearch.DataBind();
        ddlDepartmentSearch.Items.Insert(0, new ListItem("-- Select --", ""));

        DataTable dtRanksSearch = ObjCommon.GetRanks();
        ddlRankSearch.DataSource = dtRanksSearch;
        ddlRankSearch.DataValueField = "Rank_ID";
        ddlRankSearch.DataTextField = "Rank_Name";
        ddlRankSearch.DataBind();
        ddlRankSearch.Items.Insert(0, new ListItem("-- Select --", ""));


        DataTable ClearanceStatus = ObjCommon.ClearanceStatus();

        ddlclearanceStatus.DataSource = ClearanceStatus;
        ddlclearanceStatus.DataValueField = "ID";
        ddlclearanceStatus.DataTextField = "ClearanceStatusName";
        ddlclearanceStatus.DataBind();
        ddlclearanceStatus.Items.Insert(0, new ListItem("-- Select --", ""));

        ddlFamilysecurityClearance.DataSource = ClearanceStatus;
        ddlFamilysecurityClearance.DataValueField = "ID";
        ddlFamilysecurityClearance.DataTextField = "ClearanceStatusName";
        ddlFamilysecurityClearance.DataBind();
        ddlFamilysecurityClearance.Items.Insert(0, new ListItem("-- Select --", ""));

        ddlServantSecurityClearance.DataSource = ClearanceStatus;
        ddlServantSecurityClearance.DataValueField = "ID";
        ddlServantSecurityClearance.DataTextField = "ClearanceStatusName";
        ddlServantSecurityClearance.DataBind();
        ddlServantSecurityClearance.Items.Insert(0, new ListItem("-- Select --", ""));

        ddlGuestSecurityClearance.DataSource = ClearanceStatus;
        ddlGuestSecurityClearance.DataValueField = "ID";
        ddlGuestSecurityClearance.DataTextField = "ClearanceStatusName";
        ddlGuestSecurityClearance.DataBind();
        ddlGuestSecurityClearance.Items.Insert(0, new ListItem("-- Select --", ""));



        //DataTable Section = ObjCommon.Section();

        //txtSection.DataSource = Section;
        //txtSection.DataValueField = "ID";
        //txtSection.DataTextField = "SectionName";
        //txtSection.DataBind();
        //txtSection.Items.Insert(0, new ListItem("-- Select --", ""));



        DataTable Gender = ObjCommon.Gender();

        ddlGender.DataSource = Gender;
        ddlGender.DataValueField = "ID";
        ddlGender.DataTextField = "GenderName";
        ddlGender.DataBind();
        ddlGender.Items.Insert(0, new ListItem("-- Select --", ""));

        ddlFamilyGender.DataSource = Gender;
        ddlFamilyGender.DataValueField = "ID";
        ddlFamilyGender.DataTextField = "GenderName";
        ddlFamilyGender.DataBind();
        ddlFamilyGender.Items.Insert(0, new ListItem("-- Select --", ""));

        txtGuestGender.DataSource = Gender;
        txtGuestGender.DataValueField = "ID";
        txtGuestGender.DataTextField = "GenderName";
        txtGuestGender.DataBind();
        txtGuestGender.Items.Insert(0, new ListItem("-- Select --", ""));




        //DataTable BloodGroup = ObjCommon.BloodGroup();

        //txtBloodGroup.DataSource = BloodGroup;
        //txtBloodGroup.DataValueField = "ID";
        //txtBloodGroup.DataTextField = "BloodGroupName";
        //txtBloodGroup.DataBind();
        //txtBloodGroup.Items.Insert(0, new ListItem("-- Select --", ""));


        DataTable dtRanks = ObjCommon.GetRanks();
        ddlRank.DataSource = dtRanks;
        ddlRank.DataValueField = "Rank_ID";
        ddlRank.DataTextField = "Rank_Name";
        ddlRank.DataBind();
        ddlRank.Items.Insert(0, new ListItem("-- Select --", ""));
        //ddlRank.Items.Insert(1, new ListItem("-", ""));

        DataTable dtDesignation= ObjCommon.GetDesignation();
        ddlDesignationSearch.DataSource = dtDesignation;
        ddlDesignationSearch.DataValueField = "Designation_ID";
        ddlDesignationSearch.DataTextField = "designation_Name";
        ddlDesignationSearch.DataBind();
        ddlDesignationSearch.Items.Insert(0, new ListItem("-- Select --", ""));

        //DataTable dtPersonCategory = ObjCommon.GetCategory();
        //ddlCategory.DataSource = dtPersonCategory;
        //ddlCategory.DataValueField = "Person_CatID";
        //ddlCategory.DataTextField = "Person_CatName";
        //ddlCategory.DataBind();
        //ddlCategory.Items.Insert(0, new ListItem("-- Select --", ""));

        DataTable dtDesignation2 = ObjCommon.GetDesignation();
        ddlDesignation.DataSource = dtDesignation2;
        ddlDesignation.DataValueField = "Designation_ID";
        ddlDesignation.DataTextField = "designation_Name";
        ddlDesignation.DataBind();
        ddlDesignation.Items.Insert(0, new ListItem("-- Select --", ""));

       DataTable dtDepartments2 = ObjCommon.GetDepartments();
       ddlDeptUnit.DataSource = dtDepartments2;
         ddlDeptUnit.DataValueField = "Department_Id";
         ddlDeptUnit.DataTextField = "Department_Name";
         ddlDeptUnit.DataBind();
         ddlDeptUnit.Items.Insert(0, new ListItem("-- Select --", ""));

         //DataTable dtLoc = ObjCommon.GetLocations();
         //ddlNearLoc.DataSource = dtLoc;
         //ddlNearLoc.DataValueField = "Id";
         //ddlNearLoc.DataTextField = "LocName";
         //ddlNearLoc.DataBind();
         //ddlNearLoc.Items.Insert(0, new ListItem("-- Select --", ""));

         DataTable dtRelation = ObjCommon.GetRelation();
         ddlRelationFM.DataSource = dtRelation;
         ddlRelationFM.DataValueField = "Relation_Id";
         ddlRelationFM.DataTextField = "Relation_Name";
         ddlRelationFM.DataBind();
         ddlRelationFM.Items.Insert(0, new ListItem("-- Select --", ""));

        //DataTable dtReligion = ObjCommon.GetReligion();
        //ddRelationType.DataSource = dtReligion;
        //ddRelationType.DataValueField = "Religion_Id";
        //ddRelationType.DataTextField = "Religion_Name";
        //ddRelationType.DataBind();
        //ddRelationType.Items.Insert(0, new ListItem("-- Select --", ""));


        DataTable dtrealationship = ObjCommon.GetRelationship();
        ddRelationType.DataSource = dtrealationship;
        ddRelationType.DataValueField = "Relation_ID";
        ddRelationType.DataTextField = "Relation_Name";
        ddRelationType.DataBind();
        ddRelationType.Items.Insert(0, new ListItem("-- Select Relationship --", ""));

        //DataTable dtPersonCardCategory = ObjCommon.GetCardCategory();
        //ddlCardCategory.DataSource = dtPersonCardCategory;
        //ddlCardCategory.DataValueField = "Card_Prefix";
        //ddlCardCategory.DataTextField = "Card_Name";
        //ddlCardCategory.DataBind();
        //ddlCardCategory.Items.Insert(0, new ListItem("-- Select --", ""));


        //DataTable dtFamilyCardCategory = ObjCommon.GetCardCategory();
        //ddlFamilyCardCategory.DataSource = dtFamilyCardCategory;
        //ddlFamilyCardCategory.DataValueField = "Card_Prefix";
        //ddlFamilyCardCategory.DataTextField = "Card_Name";
        //ddlFamilyCardCategory.DataBind();
        //ddlFamilyCardCategory.Items.Insert(0, new ListItem("-- Select --", ""));

        //ddlRelationFMS.DataSource = dtRelation;
        //ddlRelationFMS.DataSource = dtRelation;
        //ddlRelationFMS.DataValueField = "Relation_Id";
        //ddlRelationFMS.DataTextField = "Relation_Name";
        //ddlRelationFMS.DataBind();
        //ddlRelationFMS.Items.Insert(0, new ListItem("-- Select --", ""));



        DataTable dtSiteAllowed = ObjCommon.GetSiteAllowed();
        ddlSiteAllowed.DataSource = dtSiteAllowed;
        ddlSiteAllowed.DataValueField = "ID";
        ddlSiteAllowed.DataTextField = "Site_Name";
        ddlSiteAllowed.DataBind();
        ddlSiteAllowed.SelectedValue = null;//
       // ddlSiteAllowed.Items.Insert(0, new ListItem("--Select--", ""));


       ddlFamilyClearanceLevel.DataSource = dtSiteAllowed;
       ddlFamilyClearanceLevel.DataValueField = "ID";
       ddlFamilyClearanceLevel.DataTextField = "Site_Name";
       ddlFamilyClearanceLevel.DataBind();
       ddlFamilyClearanceLevel.Items.Insert(0, new ListItem("-- Select --", ""));

        ddlServantlearanceLevel.DataSource = dtSiteAllowed;
        ddlServantlearanceLevel.DataValueField = "ID";
        ddlServantlearanceLevel.DataTextField = "Site_Name";
        ddlServantlearanceLevel.DataBind();
        ddlServantlearanceLevel.Items.Insert(0, new ListItem("-- Select --", ""));

        ddlGuestclearanceLevel.DataSource = dtSiteAllowed;
        ddlGuestclearanceLevel.DataValueField = "ID";
        ddlGuestclearanceLevel.DataTextField = "Site_Name";
        ddlGuestclearanceLevel.DataBind();
        ddlGuestclearanceLevel.Items.Insert(0, new ListItem("-- Select --", ""));

        //DataTable dtTransport = ObjCommon.GetTransport();
        //ddlTransport.DataSource = dtTransport;
        //ddlTransport.DataValueField = "Transport_ID";
        //ddlTransport.DataTextField = "Transport_Name";
        //ddlTransport.DataBind();
        //ddlTransport.Items.Insert(0, new ListItem("-- Select --", ""));
        //ddlTransport.Attributes.Add("style", "display:none");

        //DataTable dtResidantStatus = ObjCommon.GetResidantStatus();
        //ddlResidant.DataSource = dtResidantStatus;
        //ddlResidant.DataValueField = "ID";
        //ddlResidant.DataTextField = "Rasidant_Status_Name";
        //ddlResidant.DataBind();
        //ddlResidant.Items.Insert(0, new ListItem("-- Select --", ""));

        //DataTable dtCadre = ObjCommon.GetCadre();
        //ddlCadre.DataSource = dtCadre;
        //ddlCadre.DataValueField = "ID";
        //ddlCadre.DataTextField = "Cadre_Name";
        //ddlCadre.DataBind();
        //ddlCadre.Items.Insert(0, new ListItem("-- Select --", ""));

        //DataTable dtCardColor = ObjCommon.GetCardColor();
        //ddlCardColor.DataSource = dtCardColor;
        //ddlCardColor.DataValueField = "CardColor_ID";
        //ddlCardColor.DataTextField = "ColorName";
        //ddlCardColor.DataBind();
        //ddlCardColor.Items.Insert(0, new ListItem("-- Select --", ""));
        //ddlCardColor.Attributes.Add("style", "display:none");

    }


    protected string UploadFolderPath = "~/RMS/EmpPictures/" ;
    protected void FileUploadComplete(object sender, EventArgs e)
    {

        long i = 1;
        foreach (byte b in Guid.NewGuid().ToByteArray())
        {
            i *= ((int)b + 1);
        }
        if (txtNIC.Value == "")
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Notify", "alert('Please enter CNIC First ');", true);
            return;
            //string script = "<script type="text / javascript">alert('" + cleanMessage + "');</script>";


        }
        string newFileName = txtNIC.Value;//string.Format("{0:x}", i - DateTime.Now.Ticks);
        File.Delete(Server.MapPath(UploadFolderPath + newFileName+".jpg"));

        string filename = System.IO.Path.GetFileName(AsyncFileUpload1.FileName);

        AsyncFileUpload1.SaveAs(Server.MapPath(this.UploadFolderPath) + newFileName + ".jpg");



        HttpCookie ActiveTabs = new HttpCookie("tabs");
        ActiveTabs.Values["url"] = newFileName;
        Response.Cookies.Add(ActiveTabs);

        //string query = "update NonResident set [NewPhoto]'" + filename + "' where EID='5960'";

        //DBManager ObjDBManager = new DBManager();
        //ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }


    protected string UploadFolderPathForFamily = "~/RMS/EmpPictures/EmpFamilyPicture/";
    protected void FileUploadCompleteForFamily(object sender, EventArgs e)
    {

        long i = 1;
        foreach (byte b in Guid.NewGuid().ToByteArray())
        {
            i *= ((int)b + 1);

        }
        if (txtNICFM.Value == "")
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Notify", "alert('Please enter CNIC First ');", true);
            return;
            //string script = "<script type="text / javascript">alert('" + cleanMessage + "');</script>";


        }
       // string newFileName = txtNIC.Value;//string.Format("{0:x}", i - DateTime.Now.Ticks);



        string newFileName = txtNICFM.Value;// string.Format("{0:x}", i - DateTime.Now.Ticks);

        File.Delete(Server.MapPath(UploadFolderPathForFamily + newFileName + ".jpg"));

        string filename = System.IO.Path.GetFileName(AsyncFileUploadForFamily.FileName);

        AsyncFileUploadForFamily.SaveAs(Server.MapPath(this.UploadFolderPathForFamily) + newFileName + ".jpg");

        HttpCookie ActiveTabs = new HttpCookie("tabsForFamily");
        ActiveTabs.Values["urlForFamily"] = newFileName;
        Response.Cookies.Add(ActiveTabs);

    }

    protected string UploadFolderPathForServant = "~/RMS/EmpPictures/EmpServantPicture/";
    protected void FileUploadCompleteForServant(object sender, EventArgs e)
    {

        long i = 1;
        foreach (byte b in Guid.NewGuid().ToByteArray())
        {
            i *= ((int)b + 1);
        }
        if (txtNICST.Value == "")
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Notify", "alert('Please enter CNIC First ');", true);
            return;
            //string script = "<script type="text / javascript">alert('" + cleanMessage + "');</script>";


        }
        string newFileName = txtNICST.Value; // string.Format("{0:x}", i - DateTime.Now.Ticks);
        File.Delete(Server.MapPath(UploadFolderPathForServant + newFileName + ".jpg"));


        string filename = System.IO.Path.GetFileName(AsyncFileUploadForServant.FileName);

        AsyncFileUploadForServant.SaveAs(Server.MapPath(this.UploadFolderPathForServant) + newFileName + ".jpg");

        HttpCookie ActiveTabs = new HttpCookie("tabsForServant");
        ActiveTabs.Values["urlForServant"] = newFileName;
        Response.Cookies.Add(ActiveTabs);

    }


    protected string UploadFolderPathForServantFamily = "~/RMS/EmpPictures/EmpGuestPicture/";
    protected void FileUploadCompleteForServantFamily(object sender, EventArgs e)
    {

        long i = 1;
        foreach (byte b in Guid.NewGuid().ToByteArray())
        {
            i *= ((int)b + 1);
        }

        if (txtGuestCNIC.Value == "")
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Notify", "alert('Please enter CNIC First');", true);
            return;
            //string script = "<script type="text / javascript">alert('" + cleanMessage + "');</script>";


        }


        string newFileName = txtGuestCNIC.Value;// string.Format("{0:x}", i - DateTime.Now.Ticks);

        File.Delete(Server.MapPath(UploadFolderPathForServantFamily + newFileName + ".jpg"));

        string filename = System.IO.Path.GetFileName(AsyncFileUploadForServantFamily.FileName);

        AsyncFileUploadForServantFamily.SaveAs(Server.MapPath(this.UploadFolderPathForServantFamily) + newFileName + ".jpg");

        HttpCookie ActiveTabs = new HttpCookie("tabsForServantFamily");
        ActiveTabs.Values["urlForServantFamily"] = newFileName;
        Response.Cookies.Add(ActiveTabs);

        

    }



    //protected void txtCountEmp_TextChanged(object sender, EventArgs e)
    //{

        
    //}
}