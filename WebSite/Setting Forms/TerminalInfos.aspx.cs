using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Setting_Forms_TerminalInfos : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Common ObjCommon = new Common();

      //  DataTable dtTerminalType = ObjCommon.GetTerminalType();

        //ddlterminaltype.DataSource = dtTerminalType;
        //ddlterminaltype.DataValueField = "Terminal_Type_ID";
        //ddlterminaltype.DataTextField = "Terminal_type";
        //ddlterminaltype.DataBind();
        //ddlterminaltype.Items.Insert(0, new ListItem("-- Select --", ""));

        DataTable dtGates = ObjCommon.GetGates();

        ddlgateid.DataSource = dtGates;
        ddlgateid.DataValueField = "Gate_ID";
        ddlgateid.DataTextField = "Gate_Name";
        ddlgateid.DataBind();
        ddlgateid.Items.Insert(0, new ListItem("-- Select --", ""));

    //    DataTable dtClientid = ObjCommon.GetClientid();

        //ddlclientid.DataSource = dtClientid;
        //ddlclientid.DataValueField = "Client_ID";
        //ddlclientid.DataTextField = "Client_IP";
        //ddlclientid.DataBind();
        //ddlclientid.Items.Insert(0, new ListItem("-- Select --", ""));
    }
     

       
}