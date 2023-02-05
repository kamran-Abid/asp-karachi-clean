using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class RMS_NonResidents : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Common ObjCommon = new Common();

        DataTable dtDepartments = ObjCommon.GetDepartmentsForNonResidentSearch();

        ddlDepartmentSearch.DataSource = dtDepartments;
        ddlDepartmentSearch.DataValueField = "Department_Id";
        ddlDepartmentSearch.DataTextField = "Department_Name";
        ddlDepartmentSearch.DataBind();
        ddlDepartmentSearch.Items.Insert(0, new ListItem("-- Select --", ""));

        DataTable dtDesignation = ObjCommon.GetDesignationForNonResidentSearch();
        ddlDesignationSearch.DataSource = dtDesignation;
        ddlDesignationSearch.DataValueField = "Designation_ID";
        ddlDesignationSearch.DataTextField = "designation_Name";
        ddlDesignationSearch.DataBind();
        ddlDesignationSearch.Items.Insert(0, new ListItem("-- Select --", ""));


        DataTable dtRelation = ObjCommon.GetRelation();
        ddlRelation.DataSource = dtRelation;
        ddlRelation.DataValueField = "Relation_Id";
        ddlRelation.DataTextField = "Relation_Name";
        ddlRelation.DataBind();
        ddlRelation.Items.Insert(0, new ListItem("-- Select --", ""));

        DataTable dtPersonCategory = ObjCommon.GetCategory();
        ddlCategory.DataSource = dtPersonCategory;
        ddlCategory.DataValueField = "Person_CatID";
        ddlCategory.DataTextField = "Person_CatName";
        ddlCategory.DataBind();
        ddlCategory.Items.Insert(0, new ListItem("-- Select --", ""));

        DataTable dtPersonCardCategory = ObjCommon.GetCardCategory();
        ddlCardCategory.DataSource = dtPersonCardCategory;
        ddlCardCategory.DataValueField = "Card_Prefix";
        ddlCardCategory.DataTextField = "Card_Name";
        ddlCardCategory.DataBind();
        ddlCardCategory.Items.Insert(0, new ListItem("-- Select --", ""));


        DataTable dtDesignation2 = ObjCommon.GetDesignation();
        ddlDesignation.DataSource = dtDesignation2;
        ddlDesignation.DataValueField = "Designation_ID";
        ddlDesignation.DataTextField = "designation_Name";
        ddlDesignation.DataBind();
        ddlDesignation.Items.Insert(0, new ListItem("-- Select --", ""));

        DataTable dtDepartments2 = ObjCommon.GetDepartments();
        ddlDepartment.DataSource = dtDepartments2;
        ddlDepartment.DataValueField = "Department_Id";
        ddlDepartment.DataTextField = "Department_Name";
        ddlDepartment.DataBind();
        ddlDepartment.Items.Insert(0, new ListItem("-- Select --", ""));

        DataTable dtReligion = ObjCommon.GetReligion();
        ddlReligion.DataSource = dtReligion;
        ddlReligion.DataValueField = "Religion_Id";
        ddlReligion.DataTextField = "Religion_Name";
        ddlReligion.DataBind();
        ddlReligion.Items.Insert(0, new ListItem("-- Select --", ""));

        DataTable dtCaste = ObjCommon.GetCaste();
        ddlCast.DataSource = dtCaste;
        ddlCast.DataValueField = "Caste_Id";
        ddlCast.DataTextField = "Caste_Name";
        ddlCast.DataBind();
        ddlCast.Items.Insert(0, new ListItem("-- Select --", ""));

        DataTable dtSect = ObjCommon.GetSectt();
        ddlSect.DataSource = dtSect;
        ddlSect.DataValueField = "Sectt_ID";
        ddlSect.DataTextField = "Sectt_Name";
        ddlSect.DataBind();
        ddlSect.Items.Insert(0, new ListItem("-- Select --", ""));


        DataTable dtRanks = ObjCommon.GetRanks();
        ddlRanks.DataSource = dtRanks;
        ddlRanks.DataValueField = "Rank_ID";
        ddlRanks.DataTextField = "Rank_Name";
        ddlRanks.DataBind();
        ddlRanks.Items.Insert(0, new ListItem("-- Select --", ""));


        DataTable dtEducation = ObjCommon.GetEduducation();
        txtEducation.DataSource = dtEducation;
        txtEducation.DataValueField = "Education_ID";
        txtEducation.DataTextField = "Education_Name";
        txtEducation.DataBind();
        txtEducation.Items.Insert(0, new ListItem("-- Select --", ""));

        DataTable dtSiteAllowed = ObjCommon.GetSiteAllowed();
        ddlSiteAllowed.DataSource = dtSiteAllowed;
        ddlSiteAllowed.DataValueField = "ID";
        ddlSiteAllowed.DataTextField = "Site_Name";
        ddlSiteAllowed.DataBind();
        ddlSiteAllowed.Items.Insert(0, new ListItem("-- Select --", ""));

        DataTable dtTransport = ObjCommon.GetTransport();
        ddlTransport.DataSource = dtTransport;
        ddlTransport.DataValueField = "ID";
        ddlTransport.DataTextField = "Transport_Name";
        ddlTransport.DataBind();
        ddlTransport.Items.Insert(0, new ListItem("-- Select --", ""));

        DataTable dtResidantStatus = ObjCommon.GetResidantStatus();
        ddlResidant.DataSource = dtResidantStatus;
        ddlResidant.DataValueField = "ID";
        ddlResidant.DataTextField = "Rasidant_Status_Name";
        ddlResidant.DataBind();
        ddlResidant.Items.Insert(0, new ListItem("-- Select --", ""));

        DataTable dtCadre = ObjCommon.GetCadre();
        ddlCadre.DataSource = dtCadre;
        ddlCadre.DataValueField = "ID";
        ddlCadre.DataTextField = "Cadre_Name";
        ddlCadre.DataBind();
        ddlCadre.Items.Insert(0, new ListItem("-- Select --", ""));


    }


    protected string UploadFolderPath = "~/RMS/NoneResidentsPictures/";
    protected void FileUploadComplete(object sender, EventArgs e)
    {

        long i = 1;
        foreach (byte b in Guid.NewGuid().ToByteArray())
        {
            i *= ((int)b + 1);
        }
        string newFileName = string.Format("{0:x}", i - DateTime.Now.Ticks);


        string filename = System.IO.Path.GetFileName(AsyncFileUpload1.FileName);

        AsyncFileUpload1.SaveAs(Server.MapPath(this.UploadFolderPath) + newFileName + ".jpg");

        HttpCookie ActiveTabs = new HttpCookie("tabs");
        ActiveTabs.Values["url"] = newFileName;
        Response.Cookies.Add(ActiveTabs);

    }
}