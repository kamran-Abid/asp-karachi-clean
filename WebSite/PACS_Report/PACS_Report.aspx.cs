using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.Services;
using iTextSharp.text.html.simpleparser;
using System.IO;
using System.Web.UI.HtmlControls;
using Microsoft.Reporting.WebForms;
public partial class PACS_Report_PACS_Report : System.Web.UI.Page
{
    static string userid = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadDropDowns();
            //HyperLink1.Visible = false;
        }

    }

    #region LoadDropDowns
    public void LoadDropDowns()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ToString()))
        {
            try
            {
                cn.Open();

                #region DDL ddlVehicleNo
                SqlCommand cmdVehicleNo = new SqlCommand("SELECT [VACS_ID],[VehicleNo] FROM [dbo].[mctx_VACS]", cn);
                SqlDataAdapter daVehicleNo = new SqlDataAdapter(cmdVehicleNo);
                DataTable dtVehicleNo = new DataTable();
                daVehicleNo.Fill(dtVehicleNo); 
                ddlVehicleNo.DataSource = dtVehicleNo;
                ddlVehicleNo.DataTextField = "VehicleNo";
                ddlVehicleNo.DataValueField = "VACS_ID";
                ddlVehicleNo.DataBind();
                ddlVehicleNo.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));
                #endregion

                #region DDL ddlMake 
                SqlCommand cmdMake = new SqlCommand("SELECT [id],[TransportMake] FROM [dbo].[win_TransportMake]", cn);
                SqlDataAdapter daMake = new SqlDataAdapter(cmdMake);
                DataTable dtMake = new DataTable();
                daMake.Fill(dtMake);
                ddlMake.DataSource = dtMake;
                ddlMake.DataTextField = "TransportMake";
                ddlMake.DataValueField = "id";
                ddlMake.DataBind();
                ddlMake.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));
                #endregion

                #region DDL ddlVehicleType
                SqlCommand cmdVehicleType = new SqlCommand("Select [VACS_ID], [VehicleType] from [mctx_VACS]", cn);
                SqlDataAdapter daVehicleType = new SqlDataAdapter(cmdVehicleType);
                DataTable dtVehicleType = new DataTable();
                daVehicleType.Fill(dtVehicleType); 
                ddlVehicleType.DataSource = dtVehicleType;
                ddlVehicleType.DataTextField = "VehicleType";
                ddlVehicleType.DataValueField = "VACS_ID";
                ddlVehicleType.DataBind();
                ddlVehicleType.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));
                #endregion

                #region DDL ddlGateLane
                SqlCommand cmdGateLane = new SqlCommand("Select [ID], [LocationName] from [Place]", cn);
                SqlDataAdapter daGateLane = new SqlDataAdapter(cmdGateLane);
                DataTable dtGateLane = new DataTable();
                daGateLane.Fill(dtGateLane);
                ddlGateLane.DataSource = dtGateLane;
                ddlGateLane.DataTextField = "LocationName";
                ddlGateLane.DataValueField = "ID";
                ddlGateLane.DataBind();
                ddlGateLane.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));
                #endregion



                #region DDL ddlDeviceName
                SqlCommand cmdDeviceName = new SqlCommand("Select [Terminal_ID], [TerminalName] from [mctx_TerminalInfos]", cn);
                SqlDataAdapter daDeviceName = new SqlDataAdapter(cmdDeviceName);
                DataTable dtDeviceName = new DataTable();
                daDeviceName.Fill(dtDeviceName);
                ddlDeviceName.DataSource = dtDeviceName;
                ddlDeviceName.DataTextField = "TerminalName";
                ddlDeviceName.DataValueField = "Terminal_ID";
                ddlDeviceName.DataBind();
                ddlDeviceName.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));
                #endregion

                #region DDL ddlGateNo
                SqlCommand cmdGateNo = new SqlCommand("Select [Gate_ID], [Gate_Name] from [mctx_Gates]", cn);
                SqlDataAdapter daGateNo = new SqlDataAdapter(cmdGateNo);
                DataTable dtGateNo = new DataTable();
                daGateNo.Fill(dtGateNo);
                ddlGateNo.DataSource = dtGateNo;
                ddlGateNo.DataTextField = "Gate_Name";
                ddlGateNo.DataValueField = "Gate_ID";
                ddlGateNo.DataBind();
                ddlGateNo.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));
                #endregion


                #region DDL ddlClearanceStatus
                SqlCommand cmdClearanceStatus = new SqlCommand("Select [ID], [ClearanceStatusName] from [ClearanceStatus]", cn);
                SqlDataAdapter daClearanceStatus = new SqlDataAdapter(cmdClearanceStatus);
                DataTable dtClearanceStatus = new DataTable();
                daClearanceStatus.Fill(dtClearanceStatus);
                ddlClearanceStatus.DataSource = dtClearanceStatus;
                ddlClearanceStatus.DataTextField = "ClearanceStatusName";
                ddlClearanceStatus.DataValueField = "ID";
                ddlClearanceStatus.DataBind();
                ddlClearanceStatus.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));
                #endregion



                cn.Close();
            }
            catch (Exception ex)
            {
                cn.Close();
                //throw;
            }
            cn.Close();
        }
    }

    #endregion

    public static Dictionary<string, object> ToJson(DataTable table)
    {
        Dictionary<string, object> j = new Dictionary<string, object>();
        j.Add(table.TableName, RowsToDictionary(table));
        return j;
    }

    private static List<Dictionary<string, object>> RowsToDictionary(DataTable table)
    {
        List<Dictionary<string, object>> objs =
            new List<Dictionary<string, object>>();
        foreach (DataRow dr in table.Rows)
        {
            Dictionary<string, object> drow = new Dictionary<string, object>();
            for (int i = 0; i < table.Columns.Count; i++)
            {
                drow.Add(table.Columns[i].ColumnName, dr[i]);
            }
            objs.Add(drow);
        }

        return objs;
    }

    #region GetProjectDetails
    [WebMethod]
    //public static Dictionary<string, object>
    public static Dictionary<string, object> GetITProjDetails(string CNIC, string PNo, string VehicleNo, string Make, string VehicleType, string GateNo, string GateLane, string DeviceName, string ClearanceStatus, DateTime FromDate, DateTime ToDate)

    {
        //  return EmpNo + "   "+ EmpName+" "+ CNIC+"  "+ Unique_ID+"   "+ Floor+" "+ Company+" "+ FromDate+" "+ToDate;
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ToString()))
        {
             

            string Query = "SELECT VID,"+
                         "vl.[DATE],"+
                          "vac.VehicleNo," +
                           "tm.TransportMake as Make," +
                           " tbt.TransportBodyType as Body_Type," +
                             "vac.Model, " +
                        "tc.TransportColour as Colour," +
                         "vac.VehicleType," +
                         "vac.EMP_Type,convert(varchar, TIME_IN, 100) TIME_IN," +
                          " convert(varchar, TIME_OUT, 100) TIME_OUT," +
                        "cs.ClearanceStatusName as Clearance_Status," +
                         "psa.Site_Name as Site_Allowed," +
                         " emp.ServiceNo," +
                          " emp.FirstName + emp.LastName as Full_Name," +
                           " vac.CNIC," +
                         "dep.Department_Name, " +
                        " deg.designation, " +
                         "rk.Rank_Name, " +
                        " g.GenderName, " +
                        " gt.Gate_Name, " +
                        " p.LocationName as Gate_Lane, User_Type, wd.ID, " +
                        " ti.TerminalName + wd.DeviceName as Device_Name,Remarks" +
                         " FROM [mctx_visitorlog] vl " +
                         " LEFT JOIN [dbo].[mctx_VACS] vac ON vac.VACS_ID = vl.VID"+
                           " LEFT JOIN [dbo].[Employee] emp ON emp.EID = vac.EMP_ID"+
                             " LEFT JOIN [dbo].[mctx_Department] dep ON dep.Department_ID = emp.Department" +

                             " LEFT JOIN [dbo].[HR_Designation] deg ON deg.Designation_ID = emp.Designation" +

                              " LEFT JOIN [dbo].[mctx_Ranks] rk ON rk.Rank_ID = emp.[Rank]" +

                              " LEFT JOIN [dbo].[Gender] g ON g.ID = emp.Gender" +

                               " LEFT JOIN [dbo].[mctx_PersonSiteAllowed] psa ON psa.ID = vac.VehicleClearanceLevel" +

                              " LEFT JOIN [dbo].[ClearanceStatus] cs ON cs.ID = vac.VehicleClearanceStatus" +

                                " LEFT JOIN [dbo].[mctx_Gates] gt ON gt.Gate_ID = vl.GATE_NUMBER" +

                                " LEFT JOIN [dbo].[mctx_Wiegand_Devices] wd ON wd.ID = vl.TerminalID" +

                               " LEFT JOIN [dbo].[mctx_TerminalInfos] ti ON ti.Terminal_ID = wd.Terminal_ID" +

                               " LEFT JOIN [dbo].[Place] p ON p.ID = vl.Gate_Lane" +

                                " LEFT JOIN [dbo].[win_TransportBodyType] tbt ON tbt.id = vac.BodyType" +

                               " LEFT JOIN [dbo].[win_TransportColour] tc ON tc.id = vac.Colour " +

                                " LEFT JOIN [dbo].[win_TransportMake] tm ON tm.id = vac.Make" +

                                " WHERE (vl.User_Type = 'User_Type')";


            if (CNIC != null && CNIC != "")
            {
                Query = Query + " And ( emp.Nic = '" + CNIC + "')";
            }

            if (PNo != null && PNo != "")
            {

                Query = Query + " And (emp.ServiceNo='" + PNo + "')";
            }

            if (VehicleNo != null  && VehicleNo != "--Select--"  && VehicleNo != "")
            {
                Query = Query + "And (vac.VehicleNo = '" + VehicleNo + "')";
            }

            if (Make != null  &&  Make != "--Select--"  && Make != "")
            {
                Query = Query + "And (vac.Make  = '" + Make + "')";
            }

            if (VehicleType != null && VehicleType != "--Select--"  && VehicleType != "")
            {
                Query = Query + "And (vac.VehicleType = '" + VehicleType + "')";
            }

            if (GateLane != null && GateLane != "--Select--"  && GateLane != "")
            {
                Query = Query + "And (p.LocationName ='" + GateLane + "')";

            }
            if (DeviceName != null && DeviceName != "--Select--" && DeviceName != "")
            {
                Query = Query + "And (vl.TerminalID = '" + DeviceName + "')";
            }


            if (GateNo != null && GateNo != "--Select--" && GateNo != "")
            {
                Query = Query + "And (vl.GATE_NUMBER = '" + GateNo + "')";
            }


            if (ClearanceStatus != null  &&   ClearanceStatus !=  "--Select--"   &&  ClearanceStatus  != "")
            {
                Query = Query + "And (cs.ClearanceStatusName = '" + ClearanceStatus + "')";
            }


            if (FromDate != null && ToDate != null)
            {
                Query = Query + " and  (convert(varchar(25), vl.[Date], 121) >= '" + FromDate.ToString("yyyy-MM-dd") + "' and convert(varchar(25), vl.[Date], 121) <= '" + ToDate.ToString("yyyy-MM-dd") + "') ";
            }

            // " WHERE MVL.User_Type = 'Employee'" +
            SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(ds, "ProjDetails");
            dt = ds.Tables["ProjDetails"];

            return ToJson(dt);
            //SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            //DataSet ds = new DataSet();
            //DataTable dt = new DataTable();
            //da.Fill(ds, "ProjDetails");
            //dt = ds.Tables["ProjDetails"];

            //return ToJson(dt);
        }
    }
    #endregion
    protected void btnExportToExcel_Click(object sender, EventArgs e)
    {
        DataTable table = GetVisits_forExcel(txtCNIC.Text, txtPNo.Text, ddlVehicleNo.SelectedItem.Value, ddlMake.SelectedItem.Value, ddlVehicleType.SelectedItem.Value, ddlGateNo.SelectedItem.Value, ddlGateLane.SelectedItem.Value, ddlDeviceName.SelectedItem.Value, ddlClearanceStatus.SelectedItem.Value,  DateTime.Parse(txtDate.Text), DateTime.Parse(txtToDate.Text));
        if (table.Rows.Count > 0)
        {
            string filename = "PACSReport.xls";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);
            DataGrid dgGrid = new DataGrid();
            dgGrid.DataSource = table;
            dgGrid.DataBind();

            dgGrid.RenderControl(hw);
            Response.ContentType = "application/vnd.ms-excel";
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + filename + "");
            this.EnableViewState = false;
            Response.Write(tw.ToString());
            Response.End();
        }
    }
    public DataTable GetVisits_forExcel(string CNIC, string PNo, string VehicleNo, string Make, string VehicleType, string GateNo, string GateLane, string DeviceName, string ClearanceStatus, DateTime FromDate, DateTime ToDate)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ToString()))
        {
            string Query = "SELECT VID," +
                            " vl.[DATE]," +
                             " vac.VehicleNo," +
                             " tm.TransportMake as Make," +
                             " tbt.TransportBodyType as Body_Type," +
                             " vac.Model," +
                            " tc.TransportColour as Colour," +
                            " vac.VehicleType," +
                            " vac.EMP_Type," +
                            "convert(varchar, TIME_IN, 100) TIME_IN,  " +
                             "convert(varchar, TIME_OUT, 100) TIME_OUT," +
                            "cs.ClearanceStatusName as Clearance_Status, " +
                            "psa.Site_Name as Site_Allowed, " +
                            "emp.ServiceNo, " +
                            "emp.FirstName + emp.LastName as Full_Name, " +
                            "vac.CNIC," +
                            " dep.Department_Name, " +
                            "deg.designation, " +
                            "rk.Rank_Name, " +
                            "g.GenderName," +
                            " gt.Gate_Name," +
                            " p.LocationName as Gate_Lane," +
                            " User_Type," +
                            " wd.ID, " +
                            "ti.TerminalName + wd.DeviceName as Device_Name," +
                            "Remarks" +
                            " FROM [mctx_visitorlog] vl" +
                            " LEFT JOIN [dbo].[mctx_VACS] vac ON vac.VACS_ID = vl.VID" +
                            " LEFT JOIN [dbo].[Employee] emp ON emp.EID = vac.EMP_ID" +
                            " LEFT JOIN [dbo].[mctx_Department] dep ON dep.Department_ID = emp.Department" +
                            " LEFT JOIN [dbo].[HR_Designation] deg ON deg.Designation_ID = emp.Designation" +
                            " LEFT JOIN [dbo].[mctx_Ranks] rk ON rk.Rank_ID = emp.[Rank]" +
                            " LEFT JOIN [dbo].[Gender] g ON g.ID = emp.Gender" +
                            " LEFT JOIN [dbo].[mctx_PersonSiteAllowed] psa ON psa.ID = vac.VehicleClearanceLevel" +
                            " LEFT JOIN [dbo].[ClearanceStatus] cs ON cs.ID = vac.VehicleClearanceStatus" +
                            " LEFT JOIN [dbo].[mctx_Gates] gt ON gt.Gate_ID = vl.GATE_NUMBER" +
                            " LEFT JOIN [dbo].[mctx_Wiegand_Devices] wd ON wd.ID = vl.TerminalID" +
                            " LEFT JOIN [dbo].[mctx_TerminalInfos] ti ON ti.Terminal_ID = wd.Terminal_ID" +
                            " LEFT JOIN [dbo].[Place] p ON p.ID = vl.Gate_Lane" +
                            " LEFT JOIN [dbo].[win_TransportBodyType] tbt ON tbt.id = vac.BodyType" +
                            " LEFT JOIN [dbo].[win_TransportColour] tc ON tc.id = vac.Colour" +
                            " LEFT JOIN [dbo].[win_TransportMake] tm ON tm.id = vac.Make WHERE (vl.User_Type = User_Type )";


            if (CNIC != null && CNIC != "")
            {
                Query = Query + " And ( emp.Nic = '" + CNIC + "')";
            }

            if (PNo != null && PNo != "")
            {

                Query = Query + " And (emp.ServiceNo='" + PNo + "')";
            }

            if (VehicleNo != null && VehicleNo != "--Select--" && VehicleNo != "")
            {
                Query = Query + "And (vac.VehicleNo = '" + VehicleNo + "')";
            }

            if (Make != null && Make != "--Select--" && Make != "")
            {
                Query = Query + "And (vac.Make  = '" + Make + "')";
            }

            if (VehicleType != null && VehicleType != "--Select--" && VehicleType != "")
            {
                Query = Query + "And (vac.VehicleType = '" + VehicleType + "')";
            }

            if (GateLane != null && GateLane != "--Select--" && GateLane != "")
            {
                Query = Query + "And (vl.Gate_Lane ='" + GateLane + "')";

            }
            if (DeviceName != null && DeviceName != "--Select--" && DeviceName != "")
            {
                Query = Query + "And (vl.TerminalID = '" + DeviceName + "')";
            }


            if (GateNo != null && GateNo != "--Select--" && GateNo != "")
            {
                Query = Query + "And (vl.GATE_NUMBER = '" + GateNo + "')";
            }

            if (FromDate != null && ToDate != null)
            {
                Query = Query + " and  (convert(varchar(25), vl.[Date], 121) >= '" + FromDate.ToString("yyyy-MM-dd") + "' and convert(varchar(25), vl.[Date], 121) <= '" + ToDate.ToString("yyyy-MM-dd") + "') ";
            }
            DataTable dt = new DataTable();
            DataSet ds = new DataSet();
            cn.Open();
            SqlCommand cmd = new SqlCommand(Query, cn);
            SqlDataAdapter ad = new SqlDataAdapter(cmd);
            ad.Fill(ds, "Visits");
            dt = ds.Tables["Visits"];
            return dt;
        }
    }
}