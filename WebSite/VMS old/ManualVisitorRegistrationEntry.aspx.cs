using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Runtime.Serialization.Json;
using System.Web.Script.Serialization;



public partial class ManualVisitorRegistrationEntry : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ToString()))
        {
            string Query = "SELECT [ID],[HOST_NAME] from  [host] where is_deleted=1 order by HOST_NAME ASC";
            SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(ds);
            ddlPlaceOfVisit.DataSource = ds;
            ddlPlaceOfVisit.DataValueField = "ID";
            ddlPlaceOfVisit.DataTextField = "HOST_NAME";
            ddlPlaceOfVisit.DataBind();
            ddlPlaceOfVisit.Items.Insert(0, new ListItem("-- Select --", "0"));

        }

       
    }

    
}