﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;

public partial class RMS_Contractor_Information : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Common ObjCommon = new Common();


        DataTable dtGender = ObjCommon.Gender();
        ddlGender.DataSource = dtGender;
        ddlGender.DataValueField = "ID";
        ddlGender.DataTextField = "GenderName";
        ddlGender.DataBind();
        ddlGender.Items.Insert(0, new ListItem("-- Select --", ""));

        DataTable dtClearanceStatus = ObjCommon.ClearanceStatus();
        ddlClearanceStatus.DataSource = dtClearanceStatus;
        ddlClearanceStatus.DataValueField = "ID";
        ddlClearanceStatus.DataTextField = "ClearanceStatusName";
        ddlClearanceStatus.DataBind();
        ddlClearanceStatus.Items.Insert(0, new ListItem("-- Select --", ""));



        DataTable dtClLevel = ObjCommon.GetSiteAllowed();
        ddlLevel.DataSource = dtClLevel;
        ddlLevel.DataValueField = "ID";
        ddlLevel.DataTextField = "Site_Name";
        ddlLevel.DataBind();
        ddlLevel.Items.Insert(0, new ListItem("-- Select --", ""));
    }


    protected string UploadFolderPath = "~/RMS/ContractorPictures/";
    protected void FileUploadComplete(object sender, EventArgs e)
    {

        long i = 1;
        foreach (byte b in Guid.NewGuid().ToByteArray())
        {
            i *= ((int)b + 1);
        }

        if (txtCNIC.Value == "")
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Notify", "alert('Please enter CNIC First ');", true);
            return;
            //string script = "<script type="text / javascript">alert('" + cleanMessage + "');</script>";


        }
        //   string newFileName = txtCNIC.Value;//string.Format("{0:x}", i - DateTime.Now.Ticks);

        string newFileName = txtCNIC.Value;// string.Format("{0:x}", i - DateTime.Now.Ticks);
        File.Delete(Server.MapPath(UploadFolderPath + newFileName + ".jpg"));


        //  string filename = txtCNIC.Value;// System.IO.Path.GetFileName(AsyncFileUpload1.FileName);

        AsyncFileUpload1.SaveAs(Server.MapPath(this.UploadFolderPath) + newFileName + ".jpg");

        HttpCookie ActiveTabs = new HttpCookie("tabs");
        ActiveTabs.Values["url"] = newFileName;
        Response.Cookies.Add(ActiveTabs);

    }

}