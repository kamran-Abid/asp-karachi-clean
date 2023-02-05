using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Runtime.Serialization.Json;
using System.Web.Script.Serialization;
using Excel = Microsoft.Office.Interop.Excel;
using ExcelAutoFormat = Microsoft.Office.Interop.Excel.XlRangeAutoFormat;
using Microsoft.Office.Core;
using System.IO;

public partial class AdvancedSearch : System.Web.UI.Page
{
    string path;
    string fileName = "EmployeeDetails";

    protected void Page_Load(object sender, EventArgs e)
    {
        path = Server.MapPath("~") + "RMS";
        ddlType.Value = Request.QueryString["t"];

        if (Request.QueryString["t"] == "2")
            spnSearchTitle.InnerText = "Non Resident";
        else if (Request.QueryString["t"] == "3")
            spnSearchTitle.InnerText = "Visitor";
        else if (Request.QueryString["t"] == "4")
            spnSearchTitle.InnerText = "VMS Visitor";

        Dictionary<string, object> report = DBCommonMethods.GetAllDesignations();
        List<Dictionary<string, object>> designations = (List<Dictionary<string, object>>)report["Designations"];
            for (int i = 0; i < designations.Count; i++)
            {
                ListItem item = new ListItem(designations[i]["designation"].ToString(), designations[i]["Designation_ID"].ToString());
                ddlRank.Items.Add(item);
            }
    }

    protected void ExportToExcel(object sender, EventArgs e)
    {

        string[] empIds = hdEmpIds.Value.Split(',');
        DBCommonMethods.ExportToExcel(path, empIds, hdType.Value, fileName, hdShowFamily.Value);
        DownloadExcelFile();
    }

    // VIEW THE EXPORTED EXCEL DATA.
    protected void ViewData(object sender, System.EventArgs e)
    {
        string path = Server.MapPath("exportedfiles\\");
        try
        {
            // CHECK IF THE FOLDER EXISTS.
            if (Directory.Exists(path))
            {
                // CHECK IF THE FILE EXISTS.
                if (File.Exists(path + fileName + ".xlsx"))
                {
                    // SHOW (NOT DOWNLOAD) THE EXCEL FILE.
                    Excel.Application xlAppToView = new Excel.Application();
                    xlAppToView.Workbooks.Open(path + fileName + ".xlsx");
                    xlAppToView.Visible = true;
                }
            }
        }
        catch (Exception ex)
        {
            //
        }
    }

    // DOWNLOAD THE FILE.
    protected void DownLoadFile(object sender, EventArgs e)
    {
        DownloadExcelFile();
    }

    private void DownloadExcelFile()
    {
        try
        {
            string sPath = Server.MapPath("exportedfiles\\");

            Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName + ".xlsx");
            Response.TransmitFile(sPath + fileName + ".xlsx");
            Response.End();
        }
        catch (Exception ex) { }
    }
}