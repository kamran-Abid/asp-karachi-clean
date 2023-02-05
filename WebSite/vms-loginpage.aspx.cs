using System;
using System.Collections.Generic;
using System.Web.Security;
using System.Data;

public partial class vms_loginpage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {

        string userName = txtUserName.Value.ToString();
        string password = txtPassword.Value.ToString();

        DataTable objDataTable = ValidateUser(userName, password);
        if (objDataTable.Rows.Count > 0)
        {
            if (!bool.Parse(objDataTable.Rows[0]["IsActive"].ToString()))
                lblErrorMessage.Text = "Inactive user. Please contact your administrator for more details.";
            else
            {
                ProfileCommon userProfile = Profile.GetProfile(userName);

                userProfile.UserId = Convert.ToInt64(objDataTable.Rows[0]["UserId"].ToString());
                userProfile.UserName = objDataTable.Rows[0]["UserName"].ToString();
                userProfile.FirstName = objDataTable.Rows[0]["FirstName"].ToString();
                userProfile.LastName = objDataTable.Rows[0]["LastName"].ToString();
                userProfile.UserRole = objDataTable.Rows[0]["RoleName"].ToString();
                userProfile.Save();
                FormsAuthentication.RedirectFromLoginPage(userName, false);
            }
        }
        else
        {
            lblErrorMessage.Text = "Invalid username or password.";
        }
    }

    public DataTable ValidateUser(string userName, string password)
    {
        DBManager objDBManager = new DBManager();
        objDBManager.AddParameter("UserName", userName);
        objDBManager.AddParameter("Password", password);
        return objDBManager.ExecuteDataTable("ValidateUser", "vmsconnectionstring");
    }
}