using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ResidentGuests_ResidentGuest : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public string Test(string t)
    {
        return null;
    }
     
    [WebMethod]
    public static string Stat(string v)
    {
        //string un = ResidentGuests_ResidentGuest.Test(v);
        return null;
    }
}
