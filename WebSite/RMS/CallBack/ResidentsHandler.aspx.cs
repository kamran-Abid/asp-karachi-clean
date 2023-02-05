using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class RMS_CallBack_ResidentsHandler : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string a = Request.Form["Desg"];
        DBManager ObjDBManager = new DBManager();
        if (Request.Form["NIC"] !="")
        ObjDBManager.AddParameter("NIC", Request.Form["NIC"]);
        if (Request.Form["Rank"] != "")
            ObjDBManager.AddParameter("Rank", Request.Form["Rank"]);

        if (Request.Form["Dept"] != "")
        ObjDBManager.AddParameter("Dept", Request.Form["Dept"]);

        if (Request.Form["Desg"] != "")
        ObjDBManager.AddParameter("Desg", Request.Form["Desg"]);

        if (Request.Form["Name"] != "")
        ObjDBManager.AddParameter("Name", Request.Form["Name"]);
        if (Request.Form["Status"] != "")
        ObjDBManager.AddParameter("Status", Request.Form["Status"]);
        DataTable dt = ObjDBManager.ExecuteDataTable("GetEmployees", "vmsconnectionstring");
        
        rptResident.DataSource = dt;
        rptResident.DataBind();
        //if (dt.Rows[0]["NewPhoto"] != null)SaveResident
        //{
        //    byte[] bytes = (byte[])dt.Rows[0]["NewPhoto"];
        //    string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);
        //    //  Image1.ImageUrl = "data:image/png;base64," + base64String;
        //}

    }
}