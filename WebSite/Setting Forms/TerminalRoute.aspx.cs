using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Setting_Forms_TerminalRoute : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Common ObjCommon = new Common();

        DataTable dtDepartments = ObjCommon.GetTerminalNameAndIPs();

        ddlTerminal.DataSource = dtDepartments;
        ddlTerminal.DataValueField = "Terminal_ID";
        ddlTerminal.DataTextField = "TerminalInfo";
        ddlTerminal.DataBind();
        ddlTerminal.Items.Insert(0, new ListItem("-- Select --", ""));
    }
}