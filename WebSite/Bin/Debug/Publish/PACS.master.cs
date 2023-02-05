using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Configuration;
public partial class PACS : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblUserName.Text = Profile.FirstName + ' ' + Profile.LastName;
        lblRole.Text = Profile.UserRole;
    }


    protected void btnlogout_Click(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        FormsAuthentication.RedirectToLoginPage();
        //Response.Redirect("~/login.aspx");
    
    }
}
