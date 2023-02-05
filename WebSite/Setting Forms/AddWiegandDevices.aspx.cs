using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Setting_Forms_AddWiegandDevices : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Common ObjCommon = new Common();
            DataTable dtGates = ObjCommon.GetGates();
            ddlgateid.DataSource = dtGates;
            ddlgateid.DataValueField = "Gate_ID";
            ddlgateid.DataTextField = "Gate_Name";
            ddlgateid.DataBind();
            ddlgateid.Items.Insert(0, new ListItem("-- Select --", ""));

            DataTable dtTerminal = ObjCommon.GetTerminalType();
            ddlTerminalType.DataSource = dtTerminal;
            ddlTerminalType.DataValueField = "Terminal_Type_ID";
            ddlTerminalType.DataTextField = "Terminal_type";
            ddlTerminalType.DataBind();
            ddlTerminalType.Items.Insert(0, new ListItem("-- Select --", ""));

            DataTable dtSiteAllowed = ObjCommon.GetSiteAllowedForWiegandDevices();
            ddlSiteAllowed.DataSource = dtSiteAllowed;
            ddlSiteAllowed.DataValueField = "ID";
            ddlSiteAllowed.DataTextField = "Site_Name";
            ddlSiteAllowed.DataBind();
            ddlSiteAllowed.SelectedValue = null;
            //ddlSiteAllowed.Items.Insert(0, new ListItem("-- Select --", ""));

            DataTable dtTerminalID = ObjCommon.GetTerminalInfo();
            ddlTerminalID.DataSource = dtTerminalID;
            ddlTerminalID.DataValueField = "Terminal_ID";
            ddlTerminalID.DataTextField = "TerminalName";
            ddlTerminalID.DataBind();
            ddlTerminalID.Items.Insert(0, new ListItem("-- Select --", ""));
            
            DataTable dtClients = ObjCommon.LoadClientId();
            txtClientID.DataSource = dtClients;
            txtClientID.DataValueField = "Client_ID";
            txtClientID.DataTextField = "Client_IP";
            txtClientID.DataBind();
            txtClientID.Items.Insert(0, new ListItem("-- Select --", ""));


            ddlLocation.Items.Insert(0, new ListItem("-- Select --", ""));
            txtControllerID.Items.Insert(0, new ListItem("-- Select --", ""));


        }
    }

    protected void ddlgateid_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        DataTable dtController = new DataTable();
        var con = ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ToString();
        using(SqlConnection myConnection = new SqlConnection(con))
            {
            myConnection.Open();
            string Query = "select * from place where GateID=@GateID";
            SqlCommand oCmd = new SqlCommand(Query, myConnection);
            oCmd.Parameters.AddWithValue("@GateID", ddlgateid.SelectedItem.Value);
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = oCmd;
            myConnection.Close();
            DataSet ds = new DataSet();
            da.Fill(ds);
            dt =  ds.Tables[0];
            ddlLocation.DataSource = dt;
            ddlLocation.DataValueField = "ID";
            ddlLocation.DataTextField = "LocationName";
            ddlLocation.DataBind();
            ddlLocation.Items.Insert(0, new ListItem("-- Select --", ""));

            myConnection.Open();
            string QueryController = "select DeviceID from mctx_TerminalInfos where Gate_ID='"+ ddlgateid.SelectedItem.Value + "'";
            SqlCommand oCmdController = new SqlCommand(QueryController, myConnection);
           // oCmd.Parameters.AddWithValue("@GateIDController", ddlgateid.SelectedItem.Value);
            SqlDataAdapter daController = new SqlDataAdapter();
            daController.SelectCommand = oCmdController;
            myConnection.Close();
            DataSet dsController = new DataSet();
            daController.Fill(dsController);
            dtController = dsController.Tables[0];
            txtControllerID.DataSource = dtController;
            txtControllerID.DataValueField = "DeviceID";
            txtControllerID.DataTextField = "DeviceID";
            txtControllerID.DataBind();
            txtControllerID.Items.Insert(0, new ListItem("-- Select --", ""));
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        txtControllerID.Text = String.Empty;
        ddlgateid.Text = String.Empty;
        ddlLocation.Text = String.Empty;
        txtControllerID.Text = String.Empty;
        txtWeighdID.Text = String.Empty;
        txtDeviceName.Text = String.Empty;
        ddlTerminalType.Text = String.Empty;
        txtDoorID.Text = String.Empty;
        txtClientID.Text = String.Empty;
        ddlTerminalID.Text = String.Empty;

    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        txtControllerID.Text = String.Empty;
        ddlgateid.Text = String.Empty;
        ddlLocation.Text = String.Empty;
        txtControllerID.Text = String.Empty;
        txtWeighdID.Text = String.Empty;
        txtDeviceName.Text = String.Empty;
        ddlTerminalType.Text = String.Empty;
        txtDoorID.Text = String.Empty;
        txtClientID.Text = String.Empty;
        ddlTerminalID.Text = String.Empty;

    }
}