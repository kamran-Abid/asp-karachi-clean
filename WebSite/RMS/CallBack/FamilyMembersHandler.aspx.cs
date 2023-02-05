using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class RMS_CallBack_FamilyMembers : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.AddParameter("EID", Request.Form["EID"]);
        if (Request.Form["Status"] != "")
        ObjDBManager.AddParameter("Status", Request.Form["Status"]);
        DataTable dt = ObjDBManager.ExecuteDataTable("GetEmployeeFamily", "vmsconnectionstring");

        rptFamilyMembers.DataSource = dt;
        rptFamilyMembers.DataBind();

    }
}