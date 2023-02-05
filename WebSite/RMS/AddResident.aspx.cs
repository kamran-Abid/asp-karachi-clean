using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class RMS_AddResident : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["E"] != null)
        {
            DBManager ObjDBManager = new DBManager();                 
            if (Request.QueryString["E"] == "R")
            {
                
                ObjDBManager.AddParameter("EID", Request.QueryString["EID"]);
                ObjDBManager.AddParameter("Status", Request.QueryString["Status"]);
                DataTable dt = ObjDBManager.ExecuteDataTable("GetEmployees", "vmsconnectionstring");

                fieldsetFM.Visible = false;
                fieldsetFMG.Visible = false;

                if (dt.Rows.Count > 0)
                {
                    txtId.Value = dt.Rows[0]["EID"].ToString();
                    txtPNO.Value = dt.Rows[0]["ServiceNo"].ToString();
                    txtFirstName.Value = dt.Rows[0]["FirstName"].ToString();
                    txtLastName.Value = dt.Rows[0]["LastName"].ToString();
                    txtNIC.Value = dt.Rows[0]["Nic"].ToString();
                    txtReleaseDate.Value = dt.Rows[0]["ReleaseDate"].ToString();
                    ddlRank.SelectedValue = dt.Rows[0]["Rank"].ToString();
                    txtCurrentAdd.Value = dt.Rows[0]["CurrAddr"].ToString();
                    ddlDeptUnit.SelectedValue = dt.Rows[0]["Department"].ToString();
                    txtPermanentAdd.Value = dt.Rows[0]["PerAddr"].ToString();
                    ddlNearLoc.SelectedValue = dt.Rows[0]["Location"].ToString();
                    txtCellPhone.Value = dt.Rows[0]["Mobile"].ToString();
                    txtCardNo.Value = dt.Rows[0]["CardNumber"].ToString();
                    txtPhoneHome.Value = dt.Rows[0]["PhoneHome"].ToString();
                    txtAllotmentDate.Value = dt.Rows[0]["AllotmentDate"].ToString();
                    txtPhoneOffice.Value = dt.Rows[0]["PhoneOffice"].ToString();
                    //txtValidity.Value = dt.Rows[0][""].ToString();

                    hdnEID.Value = dt.Rows[0]["EID"].ToString();
                }
            }
            else if (Request.QueryString["E"] == "F")
            {
                fieldsetPersonal.Visible = false;
                ObjDBManager.AddParameter("EFID", Request.QueryString["EFID"]);
                ObjDBManager.AddParameter("Status", Request.QueryString["Status"]);
                DataTable dt = ObjDBManager.ExecuteDataTable("GetEmployeeFamily", "vmsconnectionstring");

                if (dt.Rows.Count > 0)
                {
                    txtFirstNameFS.Value = dt.Rows[0]["FirstName"].ToString();
                    txtLastNameFS.Value = dt.Rows[0]["LastName"].ToString();
                    ddlRelationFS.SelectedValue = dt.Rows[0]["Relation"].ToString();
                    //txtFatherHusbandFS.Value = dt.Rows[0]["PhoneOffice"].ToString();
                    txtNICFS.Value = dt.Rows[0]["NIC"].ToString();
                    txtCardNoFS.Value = dt.Rows[0]["CardNumber"].ToString();
                    txtCellNoFS.Value = dt.Rows[0]["Mobile"].ToString();
                    txtVisitPurpose.Value = dt.Rows[0]["vpurpose"].ToString();
                    txtVisitorAdd.Value = dt.Rows[0]["vaddr"].ToString();

                    hdnEFID.Value = dt.Rows[0]["EFID"].ToString();
                }


                ObjDBManager.Parameters.Clear();

                ObjDBManager.AddParameter("EID", Request.QueryString["EID"]);
                ObjDBManager.AddParameter("Status", Request.QueryString["Status"]);
                DataTable dtFM = ObjDBManager.ExecuteDataTable("GetEmployeeFamily", "vmsconnectionstring");

                rptFamilyMembers.DataSource = dtFM;
                rptFamilyMembers.DataBind();

            }
        }
    }
}