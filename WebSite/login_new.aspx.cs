using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Security;
using System.Configuration;

public partial class login_new : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.Cookies["userName"] != null && Request.Cookies["password"] != null)
            {
                TxtUserName.Text = Request.Cookies["userName"].Value;
                TxtPassword.Attributes["value"] = Request.Cookies["password"].Value;
            }
        }

    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        if(remember_me.Checked)
        {
            Response.Cookies["userName"].Expires = DateTime.Now.AddDays(30);
            Response.Cookies["password"].Expires = DateTime.Now.AddDays(30);
        }
        else
        {
            Response.Cookies["userName"].Expires = DateTime.Now.AddDays(-1);
            Response.Cookies["password"].Expires = DateTime.Now.AddDays(-1);

        }
        Response.Cookies["userName"].Value = TxtUserName.Text.Trim();
        Response.Cookies["password"].Value = TxtPassword.Text.Trim();

        string userName = TxtUserName.Text.ToString();
        string password = TxtPassword.Text.ToString();

        DataTable objDataTable = ValidateUser(userName, password);
        if (objDataTable.Rows.Count > 0)
        {
            if (!bool.Parse(objDataTable.Rows[0]["IsActive"].ToString()))
                lblErrorMessage.Text = "Inactive user. Please contact your administrator for more details.";
            else
            {
                ProfileCommon userProfile = Profile.GetProfile(userName);

                userProfile.UserId = Convert.ToInt64(objDataTable.Rows[0]["UserId"].ToString());
                userProfile.UserName    =  objDataTable.Rows[0]["UserName"].ToString();
                userProfile.FirstName   =  objDataTable.Rows[0]["FirstName"].ToString();
                userProfile.LastName    =  objDataTable.Rows[0]["LastName"].ToString();
                userProfile.UserRole    =  objDataTable.Rows[0]["RoleName"].ToString();
                userProfile.Save();
                FormsAuthentication.RedirectFromLoginPage(userName, false);
                //FormsAuthentication.RedirectFromLoginPage("Home.aspx", true);
                // Response.Redirect("Home.aspx");
            }
        }
        else
        {
            lblErrorMessage.Text = "Invalid username or password.";
        }
    }

         public DataTable ValidateUser(string userName, string password)
    {
        DBCommonMethods commonMethods = new DBCommonMethods();
        password = commonMethods.HashPassword(password);
        DBManager objDBManager = new DBManager();
        objDBManager.AddParameter("UserName", userName);
        objDBManager.AddParameter("Password", password);
        return objDBManager.ExecuteDataTable("ValidateUser", "vmsconnectionstring");
    }
}