using DocumentFormat.OpenXml.Drawing.Charts;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class RMS_Business_Comunity_Frm : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    #region LoadDropDowns
    public void LoadDropDowns()
    {
        //using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ToString()))
        //{
        //    try
        //    {
        //        SqlCommand cmdbusiness = new SqlCommand("SELECT [ID],[BusinessName] FROM [dbo].[mctx_BusinessCommunity] where [is_deleted] = 0", cn);
        //        cn.Open();
        //        SqlDataAdapter daBusiness = new SqlDataAdapter(cmdbusiness);
        //        DataTable dtBusiness = new DataTable();
        //        daBusiness.Fill(dtBusiness);
        //        #region PersonDD
        //        RelationDDL.DataSource = dtBusiness;
        //        RelationDDL.DataTextField = "Person_Name";
        //        RelationDDL.DataValueField = "Person_ID";
        //        RelationDDL.DataBind();
        //        RelationDDL.Items.Insert(0, "");
        //        #endregion

        //        #region PlaceDDL
        //        SqlCommand cmdPlace = new SqlCommand("SELECT Place_ID,Place_Name from Place_Tbl WHERE deleted=0 order by Place_Name", cn);
        //        SqlDataAdapter daPlace = new SqlDataAdapter(cmdPlace);
        //        DataTable dtPlace = new DataTable();
        //        daPlace.Fill(dtPlace);
        //        DropDownList2.DataSource = dtPlace;
        //        DropDownList2.DataTextField = "Place_Name";
        //        DropDownList2.DataValueField = "Place_ID";
        //        DropDownList2.DataBind();
        //        DropDownList2.Items.Insert(0, "");
        //        #endregion

        //        #region PurposeDDL
        //        SqlCommand cmdPurpose = new SqlCommand("SELECT Purpose_ID,Purpose_Name from Purpose_Tbl WHERE deleted=0 order by Purpose_Name", cn);
        //        SqlDataAdapter daPurpose = new SqlDataAdapter(cmdPurpose);
        //        DataTable dtPurpose = new DataTable();
        //        daPurpose.Fill(dtPurpose);

        //        DropDownList3.DataSource = dtPurpose;
        //        DropDownList3.DataTextField = "Purpose_Name";
        //        DropDownList3.DataValueField = "Purpose_ID";
        //        DropDownList3.DataBind();
        //        DropDownList3.Items.Insert(0, "");
        //        #endregion

        //        #region UniqueID
        //        SqlCommand cmdUniqueID = new SqlCommand("SELECT Max(V_ID) from Visitor_Tbl", cn);
        //        //SqlDataAdapter daUniqueID = new SqlDataAdapter(cmdUniqueID);
        //        SqlDataReader UniqueIDdata = cmdUniqueID.ExecuteReader();

        //        string s1 = "";
        //        while (UniqueIDdata.Read())
        //        {
        //            s1 = UniqueIDdata[0].ToString();
        //        }
        //        if (s1 == "" || s1 == null) { s1 = "0"; }
        //        int lastID = Convert.ToInt32(s1);
        //        lastID = lastID + 1;
        //        TextBox19.Text = "DF-V/" + lastID.ToString() + "/" + DateTime.Today.Year.ToString();
        //        //int lastID = Convert.ToInt32(daUniqueID);//Start From Here
        //        //DataTable dtlastid = new DataTable();
        //        //daUniqueID.Fill(dtlastid);

        //        //using SDR as SqlDataReader = cmdUniqueID.EndExecuteReader();
        //        //TextBox19.Text = lastID.ToString();
        //        //TextBox19.DataBind();
        //        #endregion

        //        cn.Close();
        //    }
        //    catch (Exception ex)
        //    {
        //        cn.Close();
        //        //throw;
        //    }
        //    cn.Close();
        //}
    }

    #endregion
}