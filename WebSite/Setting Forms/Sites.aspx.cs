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

public partial class Setting_FormsSites : System.Web.UI.Page
{
    static string UserID = "";
    static string CurrentDate = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        CurrentDate = DateTime.Now.ToShortDateString();
        UserID = "mctxAdmin";
        Common ObjCommon = new Common();

        DataTable dtDepartments = ObjCommon.GetGates();

        ddlGate.DataSource = dtDepartments;
        ddlGate.DataValueField = "Gate_ID";
        ddlGate.DataTextField = "Gate_Name";
        ddlGate.DataBind();
        ddlGate.Items.Insert(0, new ListItem("-- Select --", ""));
    }
}