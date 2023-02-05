using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class RMS_CallBack_GuestsHandler : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DBManager ObjDBManager = new DBManager();
        Common ObjCommon = new Common();
        ObjDBManager.AddParameter("EID", Request.Form["EID"]);
        DataTable dtSrvt = ObjDBManager.ExecuteDataTable("GetGuest", "vmsconnectionstring");

        if(dtSrvt.Rows.Count>0)
        {
            rptGuest.DataSource = dtSrvt;
            rptGuest.DataBind();
        }
    }   
}