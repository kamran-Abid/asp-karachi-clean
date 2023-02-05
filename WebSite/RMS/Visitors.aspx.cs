using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class RMS_Visitors : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Common ObjCommon = new Common();

        
        DataTable dtRelation = ObjCommon.GetRelation();
        ddlRelation.DataSource = dtRelation;
        ddlRelation.DataValueField = "Relation_Id";
        ddlRelation.DataTextField = "Relation_Name";
        ddlRelation.DataBind();
        ddlRelation.Items.Insert(0, new ListItem("-- Select --", ""));

        DataTable dtDesignation = ObjCommon.GetDesignation();
        ddlDesignation.DataSource = dtDesignation;
        ddlDesignation.DataValueField = "Designation_ID";
        ddlDesignation.DataTextField = "designation_Name";
        ddlDesignation.DataBind();
        ddlDesignation.Items.Insert(0, new ListItem("-- Select --", ""));



        DataTable dtRanks = ObjCommon.GetRanks();
        ddlRank.DataSource = dtRanks;
        ddlRank.DataValueField = "Rank_ID";
        ddlRank.DataTextField = "Rank_Name";
        ddlRank.DataBind();
        ddlRank.Items.Insert(0, new ListItem("-- Select --", ""));
    }


    protected string UploadFolderPath = "~/RMS/VisitorPictures/";
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