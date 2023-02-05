using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Setting_Forms_DamoclesInfos : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Common ObjCommon = new Common();

        DataTable dtDepartments = ObjCommon.GetGates();

        ddlgateid.DataSource = dtDepartments;
        ddlgateid.DataValueField = "Gate_ID";
        ddlgateid.DataTextField = "Gate_Name";
        ddlgateid.DataBind();
        ddlgateid.Items.Insert(0, new ListItem("-- Select --", ""));
    }
}