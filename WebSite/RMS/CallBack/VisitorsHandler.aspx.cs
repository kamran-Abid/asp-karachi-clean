using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class RMS_CallBack_VisitorsHandler : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DBManager ObjDBManager = new DBManager();
        if (Request.Form["NIC"] !="")
        ObjDBManager.AddParameter("NIC", Request.Form["NIC"]);
        
        if (Request.Form["Name"] != "")
        ObjDBManager.AddParameter("Name", Request.Form["Name"]);
        if (Request.Form["Status"] != "")
        ObjDBManager.AddParameter("Status", Request.Form["Status"]);
        DataTable dt = ObjDBManager.ExecuteDataTable("Getvisitor", "vmsconnectionstring");

        rptVisitors.DataSource = dt;
        rptVisitors.DataBind();

    }
}