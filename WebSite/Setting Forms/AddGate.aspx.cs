using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;

public partial class AddGate : System.Web.UI.Page
{
    Common ObjCommon = new Common();
   
    protected void Page_Load(object sender, EventArgs e)
    {
        DataTable Location = ObjCommon.GetGateLocation();

        ddlLocation.DataSource = Location;
        ddlLocation.DataValueField = "ID";
        ddlLocation.DataTextField = "Name";
        ddlLocation.DataBind();
        ddlLocation.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));

        //ddlGateLevel.DataSource = Location;
        //ddlGateLevel.DataValueField = "ID";
        //ddlGateLevel.DataTextField = "Name";
        //ddlGateLevel.DataBind();
        //ddlGateLevel.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));

        ArrayList list = new ArrayList();
        for(int i = 1; i<=10; i++)
        {
            list.Add(i);
        }
        foreach(object item in list)
        {
            ddlGateLevel.Items.Add(new ListItem(item.ToString(), item.ToString()));
        }
    }
}