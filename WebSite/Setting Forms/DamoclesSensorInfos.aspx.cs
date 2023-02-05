using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Setting_Forms_DamoclesSensorInfos : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Common ObjCommon = new Common();

        DataTable dtsensorinfos = ObjCommon.GetDamoclesSensorTypeInfo();

        ddlDemoclesID.DataSource = dtsensorinfos;
       ddlDemoclesID.DataValueField = "Dam_Sen_Type_ID";
        ddlDemoclesID.DataTextField = "Dam_Sen_Type";
        ddlDemoclesID.DataBind();
        ddlDemoclesID.Items.Insert(0, new ListItem("-- Select --", ""));

        DataTable dtsensorinfos1 = ObjCommon.GetDamoclesSensorTypeInfo1();

        ddldamoclessensorid.DataSource = dtsensorinfos1;
         ddldamoclessensorid.DataValueField = "Dam_ID";
        ddldamoclessensorid.DataTextField = "IPName";
        ddldamoclessensorid.DataBind();
        ddldamoclessensorid.Items.Insert(0, new ListItem("-- Select --", ""));

    }
}