using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class RMS_CallBack_NonResidentsHandler : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DBManager ObjDBManager = new DBManager();
        if (Request.Form["NIC"] != "")
            ObjDBManager.AddParameter("NIC", Request.Form["NIC"]);

        if (Request.Form["Dept"] != "")
            ObjDBManager.AddParameter("Dept", Request.Form["Dept"]);

        if (Request.Form["Desg"] != "")
            ObjDBManager.AddParameter("Desg", Request.Form["Desg"]);

        if (Request.Form["Name"] != "")
            ObjDBManager.AddParameter("Name", Request.Form["Name"]);
        if (Request.Form["Status"] !="")
        ObjDBManager.AddParameter("Status", Request.Form["Status"]);
        DataTable dt = ObjDBManager.ExecuteDataTable("GetNonResidents", "vmsconnectionstring");

        rptNonResident.DataSource = dt;
        rptNonResident.DataBind();

    }
}