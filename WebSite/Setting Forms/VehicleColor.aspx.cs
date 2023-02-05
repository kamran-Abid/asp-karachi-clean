using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Setting_Forms_VehicleColor : System.Web.UI.Page
{
    protected void ClearAll(object sender, EventArgs e)
    {
        Response.Redirect(Request.Path);
    }
    protected void Page_Load(object sender, EventArgs e)
    {

    }
}