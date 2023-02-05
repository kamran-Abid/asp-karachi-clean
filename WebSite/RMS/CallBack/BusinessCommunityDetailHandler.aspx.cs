using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class RMS_CallBack_BusinessCommunityDetailHandler : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DBManager ObjDBManager = new DBManager();
        if (Request.Form["CNIC"] !="")
        ObjDBManager.AddParameter("CNIC", Request.Form["CNIC"]);
        
        if (Request.Form["Name"] != "")
        ObjDBManager.AddParameter("Name", Request.Form["Name"]);

        if (Request.Form["CStatus"] != "")
        ObjDBManager.AddParameter("CStatus", Request.Form["CStatus"]);
        DataTable dt = ObjDBManager.ExecuteDataTable("GetBusinessCommunityDetail", "vmsconnectionstring");

        rptBusinessCommunityDetails.DataSource = dt;
        rptBusinessCommunityDetails.DataBind();

    }
}