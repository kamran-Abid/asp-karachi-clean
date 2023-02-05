using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class RMS_CallBack_ServantFamilyMembersHandler : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //var abc = Request.Form["SID"].ToString();
        DBManager ObjDBManager = new DBManager();        
        ObjDBManager.AddParameter("SID", Request.Form["SID"]);

        DataTable dt = ObjDBManager.ExecuteDataTable("GetServantFamily", "vmsconnectionstring");

        rptServantFamily.DataSource = dt;
        rptServantFamily.DataBind();

    }
}