using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class RMS_CallBack_ServantsHandler : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DBManager ObjDBManager = new DBManager();
        Common ObjCommon = new Common();
        //DataTable dtReligion = ObjCommon.GetReligion();
        //ddlReligionST.DataSource = dtReligion;
        //ddlReligionST.DataValueField = "Religion_Id";
        //ddlReligionST.DataTextField = "Religion_Name";
        //ddlReligionST.DataBind();
        //ddlReligionST.Items.Insert(0, new ListItem("-- Select --", ""));
        ObjDBManager.AddParameter("EID", Request.Form["EID"]);
        DataTable dtSrvt = ObjDBManager.ExecuteDataTable("GetServant", "vmsconnectionstring");

        if(dtSrvt.Rows.Count>0)
        {
            //txtIdST.Value = dtSrvt.Rows[0]["SID"].ToString();
            //txtCardNoST.Value = dtSrvt.Rows[0]["CardNumber"].ToString();
            //txtFirstNameST.Value = dtSrvt.Rows[0]["FirstName"].ToString();
            //txtLastNameST.Value = dtSrvt.Rows[0]["LastName"].ToString();
            //txtNICST.Value = dtSrvt.Rows[0]["NIC"].ToString();
            //txtCurrentAddST.Value = dtSrvt.Rows[0]["CurrAddr"].ToString();
            //txtDOBST.Value = dtSrvt.Rows[0]["DOB"].ToString();
            //txtPermanentAddST.Value = dtSrvt.Rows[0]["PerAddr"].ToString();
            //txtFH.Value = dtSrvt.Rows[0]["FH"].ToString();
            //txtCellPhoneST.Value = dtSrvt.Rows[0]["mobile"].ToString();
            //ddlReligionST.SelectedValue = dtSrvt.Rows[0]["Religion"].ToString();
            //txtPhoneOfficeST.Value = dtSrvt.Rows[0]["phoneoffice"].ToString();            
            //txtPhoneHomeST.Value = dtSrvt.Rows[0]["phonehome"].ToString();
            rptServant.DataSource = dtSrvt;
            rptServant.DataBind();
            //ObjDBManager.Parameters.Clear();
            //ObjDBManager.AddParameter("SID", txtIdST.Value);
            //DataTable dt = ObjDBManager.ExecuteDataTable("GetServantFamily", "vmsconnectionstring");

            //rptServantFamily.DataSource = dt;
            //rptServantFamily.DataBind();

        }

       
    }


    
}