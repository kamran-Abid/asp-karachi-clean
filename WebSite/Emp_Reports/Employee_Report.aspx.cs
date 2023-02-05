using iTextSharp.text;
using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp.text.html.simpleparser;
using System.IO;
using System.Web.UI.HtmlControls;
using Microsoft.Reporting.WebForms;

//namespace PACS
//{

//}

public partial class Reports_Employee_Report : System.Web.UI.Page
{
    static string userid = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        //userid = Session["User_ID"].ToString();
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

                #region DDL ddlDepartment
                SqlCommand cmdDepartment = new SqlCommand("SELECT [Department_ID],[Department_Name] FROM [dbo].[mctx_Department]", cn);
                SqlDataAdapter daDepartment = new SqlDataAdapter(cmdDepartment);
                DataTable dtDepartment = new DataTable();
                daDepartment.Fill(dtDepartment);

                ddlDepartment.DataSource = dtDepartment;
                ddlDepartment.DataTextField = "Department_Name";
                ddlDepartment.DataValueField = "Department_ID";
                ddlDepartment.DataBind();
                ddlDepartment.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));
                #endregion

                #region DDL ddlDesignation 
                SqlCommand cmdDesignation = new SqlCommand("SELECT [Designation_ID],[designation] FROM [dbo].[HR_Designation]", cn);
                SqlDataAdapter daDesignation = new SqlDataAdapter(cmdDesignation);
                DataTable dtDesignation = new DataTable();
                daDesignation.Fill(dtDesignation);

                ddlDesignation.DataSource = dtDesignation;
                ddlDesignation.DataTextField = "designation";
                ddlDesignation.DataValueField = "Designation_ID";
                ddlDesignation.DataBind();
                ddlDesignation.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));
                #endregion

                #region DDL ddlRank
                SqlCommand cmdRank = new SqlCommand("Select [Rank_ID], [Rank_Name] from [mctx_Ranks]", cn);
                SqlDataAdapter daRank = new SqlDataAdapter(cmdRank);
                DataTable dtRank = new DataTable();
                daRank.Fill(dtRank);

                ddlRank.DataSource = dtRank;
                ddlRank.DataTextField = "Rank_Name";
                ddlRank.DataValueField = "Rank_ID";
                ddlRank.DataBind();
                ddlRank.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));
                #endregion

                #region DDL ddlGender
                SqlCommand cmdGender = new SqlCommand("Select [ID], [GenderName] from [Gender]", cn);
                SqlDataAdapter daGender = new SqlDataAdapter(cmdGender);
                DataTable dtGender = new DataTable();
                daGender.Fill(dtGender);
                ddlGender.DataSource = dtGender;
                ddlGender.DataTextField = "GenderName";
                ddlGender.DataValueField = "ID";
                ddlGender.DataBind();
                ddlGender.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));
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
    public static Dictionary<string, object> GetITProjDetails(string CNIC, string Department, string Designation, string Rank, string Gender, string PNo, string GateNo, string GateLane, string DeviceName, DateTime FromDate, DateTime ToDate)

    {
        //  return EmpNo + "   "+ EmpName+" "+ CNIC+"  "+ Unique_ID+"   "+ Floor+" "+ Company+" "+ FromDate+" "+ToDate;
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ToString()))
        {


            //20 dec

            //string Query = "SELECT SR.FullName AS NAME"+
            //     ", SR.FullName AS HostName"+
            //      ",SR.Unique_ID"+
            //      ",SR.EmpNo"+ 
            //      ",CT.[Company_Name]"+
            //     ", PT.[Place_Name]"+
            //     ", ED.[Designation]"+
            //      ",convert(varchar, VT.TimeIn, 100) TIME_IN"+
            //      ",convert(varchar, VT.TimeOut, 100) TIME_OUT"+
            //      //",vl.[User_Type]"+
            //      "FROM [StaffRegF1Tbl] SR"+
            //      "INNER JOIN [Emp_Designation] ED ON SR.Designation = ED.Designation_ID"+
            //      "INNER JOIN [Visitor_Tbl] VT ON SR.EmpNo = VT.EmpNo"+
            //      "INNER JOIN [mctx_visitorlog] MVL ON VT.V_ID = MVL.VID"+
            //      "INNER JOIN [Place_Tbl] PT ON PT.Place_ID = SR.FloorNo"+ 
            //      "LEFT JOIN [Company_Tbl] CT ON SR.Company = CT.Company_ID"+
            //      "WHERE (convert(date, SR.[Date], 103) >= '" + DateV.ToString("yyyy-MM-dd") + "'" +
            //           " AND convert(date, SR.[Date], 103) <= '" + ToDateV.ToString("yyyy-MM-dd") + "') ";


            //string Query = " SELECT SR.FullName AS NAME "+ 
            // ", SR.FullName AS Host "+
            // " ,SR.CNIC"+
            // ", SR.Unique_ID " +
            // ", SR.EmpNo "+
            // ", CT.[Company_Name] "+
            // ", PT.[Place_Name] "+
            // ", ED.[Designation] "+
            // ", convert(varchar, MVL.TIME_IN, 100) TIME_IN " +
            // ", convert(varchar, MVL.TIME_OUT, 100) TIME_OUT " + 
            // ", MVL.User_Type " +
            // " FROM [dbo].[StaffRegF1Tbl] SR " +
            // " INNER JOIN [Emp_Designation] ED ON SR.Designation = ED.Designation_ID "+
            // " INNER JOIN [Visitor_Tbl] VT ON SR.EmpNo = VT.EmpNo "+
            // " INNER JOIN [mctx_visitorlog] MVL ON VT.V_ID = MVL.VID "+
            // " INNER JOIN [Place_Tbl] PT ON PT.Place_ID = SR.FloorNo "+
            // " LEFT JOIN [Company_Tbl] CT ON SR.Company = CT.Company_ID "+
            // " WHERE MVL.User_Type = 'Employee'" + " and (convert(date,MVL.[Date], 103) >= '" + DateV.ToString("yyyy-MM-dd") + "' AND convert(date,MVL.[Date], 103) <= '" + ToDateV.ToString("yyyy-MM-dd") + "') ";

            //if (CNIC != "" && HostName != "--Select--")
            // { Query = Query + " and ( SR.CNIC = '" + CNIC + "' and SR.S_ID = '" + HostID + "')"; }
            // else if (CNIC != "" && HostName == "--Select--")
            // { Query = Query + " and ( SR.CNIC = '" + CNIC + "')"; }
            // else if (CNIC == "" && HostName != "--Select--")
            // { Query = Query + " and (SR.S_ID = '" + HostID + "')"; }
            // Query = Query + "  order by convert(date,MVL.[Date], 103) asc";

            string Query = "SELECT VID, vl.[DATE], emp.ServiceNo, emp.FirstName  +  emp.LastName as Full_Name," +
                            "emp.Nic,emp.FatherName,dep.Department_Name," +
                            " deg.designation,rk.Rank_Name,g.GenderName," +
                            "convert(varchar, TIME_IN, 100) TIME_IN,  " +
                             "convert(varchar, TIME_OUT, 100) TIME_OUT," +
                            "psa.Site_Name" +
                           // "convert(varchar(25), emp.[ValidUpto], 121)" +
                            ",emp.ValidUpto" +
                            ",VEHICLE_NUMBER, " +
                            " gt.Gate_Name, p.LocationName as Gate_Lane, " +
                             "User_Type," +
                             " wd.ID," +
                             "ti.TerminalName , wd.DeviceName as Device_Name, Remarks " +
                             "FROM [mctx_visitorlog] vl " +
                        " LEFT JOIN [dbo].[Employee] emp ON emp.EID = vl.VID " +
                        " LEFT JOIN [dbo].[mctx_Department] dep ON dep.Department_ID = emp.Department " +

                        " LEFT JOIN [dbo].[HR_Designation] deg ON deg.Designation_ID = emp.Designation " +

                        " LEFT JOIN [dbo].[mctx_Ranks] rk ON rk.Rank_ID = emp.[Rank] " +

                       " LEFT JOIN [dbo].[Gender] g ON g.ID = emp.Gender" +

                       " LEFT JOIN [dbo].[mctx_PersonSiteAllowed] psa ON psa.ID = emp.ClearanceLevel" +

                      " LEFT JOIN [dbo].[mctx_Gates] gt ON gt.Gate_ID = vl.GATE_NUMBER" +

                     " LEFT JOIN [dbo].[mctx_Wiegand_Devices] wd ON wd.ID = vl.TerminalID" +

                       " LEFT JOIN [dbo].[mctx_TerminalInfos] ti ON ti.Terminal_ID = wd.Terminal_ID" +

                    " LEFT JOIN [dbo].[Place] p ON p.ID = vl.Gate_Lane where User_Type = 'Employee'";

            if (PNo != null && PNo != "")
            {

                Query = Query + " And (emp.ServiceNo='" + PNo + "')";
            }


            if (CNIC != null && CNIC != "")
            {
                Query = Query + " And ( emp.Nic= '" + CNIC + "')";
            }

            if (Department != null && Department != "--Select--" && Department != "" )
            {
                Query = Query + "And (dep.Department_Name = '" + Department + "')";
            }

            if (Designation != null && Designation != "--Select--" && Designation != "")
            {
                Query = Query + "And (deg.designation = '" + Designation + "')";
            }

            if (Rank != null & Rank != "--Select--" && Rank != "")
            {
                Query = Query + "And (rk.Rank_Name= '" + Rank + "')";
            }

            if (Gender != null && Gender != "--Select--" && Gender != "")
            {
                Query = Query + " And (g.GenderName= '" + Gender + "')";
            }

            if (GateNo != null && GateNo != "--Select--" && GateNo != "" )
            {
                Query = Query + "And (gt.Gate_Name = '" + GateNo + "')";
            }

            if (GateLane != null && GateLane != "--Select--" && GateLane != "" )
            {
                Query = Query + "And (p.LocationName='" + GateLane + "')";

            }
            if (DeviceName != null && DeviceName != "--Select--" && DeviceName != "" )
            {
                Query = Query + "And (ti.TerminalName= '" + DeviceName + "')";
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
        DataTable table = GetVisits_forExcel(txtCNIC.Text, ddlDepartment.SelectedItem.Value, ddlDesignation.SelectedItem.Value, ddlRank.SelectedItem.Value, ddlGender.SelectedItem.Value, txtPNo.Text, ddlGateNo.SelectedItem.Value, ddlGateLane.SelectedItem.Value, ddlDeviceName.SelectedItem.Value, DateTime.Parse(txtDate.Text), DateTime.Parse(txtToDate.Text));
        if (table.Rows.Count > 0)
        {
            string filename = "EmployeeReport.xls";
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

    public DataTable GetVisits_forExcel(string CNIC, string Department, string Designation, string Rank, string Gender, string PNo, string GateNo, string GateLane, string DeviceName, DateTime FromDate, DateTime ToDate)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ToString()))
        {
            string Query = "SELECT VID, vl.[DATE], emp.ServiceNo, emp.FirstName  +  emp.LastName as Full_Name," +
                            "emp.Nic,emp.FatherName,dep.Department_Name," +
                            " deg.designation,rk.Rank_Name,g.GenderName," +
                            "convert(varchar, TIME_IN, 100) TIME_IN,  " +
                             "convert(varchar, TIME_OUT, 100) TIME_OUT," +
                            "psa.Site_Name" +
                            // "convert(varchar(25), emp.[ValidUpto], 121)" +
                            ",emp.ValidUpto" +
                            ",VEHICLE_NUMBER, " +
                            " gt.Gate_Name, p.LocationName as Gate_Lane, " +
                             "User_Type," +
                             " wd.ID," +
                             "ti.TerminalName , wd.DeviceName as Device_Name, Remarks " +
                             "FROM [mctx_visitorlog] vl " +
                        " LEFT JOIN [dbo].[Employee] emp ON emp.EID = vl.VID " +
                        " LEFT JOIN [dbo].[mctx_Department] dep ON dep.Department_ID = emp.Department " +

                        " LEFT JOIN [dbo].[HR_Designation] deg ON deg.Designation_ID = emp.Designation " +

                        " LEFT JOIN [dbo].[mctx_Ranks] rk ON rk.Rank_ID = emp.[Rank] " +

                       " LEFT JOIN [dbo].[Gender] g ON g.ID = emp.Gender" +

                       " LEFT JOIN [dbo].[mctx_PersonSiteAllowed] psa ON psa.ID = emp.ClearanceLevel" +

                      " LEFT JOIN [dbo].[mctx_Gates] gt ON gt.Gate_ID = vl.GATE_NUMBER" +

                     " LEFT JOIN [dbo].[mctx_Wiegand_Devices] wd ON wd.ID = vl.TerminalID" +

                       " LEFT JOIN [dbo].[mctx_TerminalInfos] ti ON ti.Terminal_ID = wd.Terminal_ID" +

                    " LEFT JOIN [dbo].[Place] p ON p.ID = vl.Gate_Lane where User_Type = 'Employee'";

            if (PNo != null && PNo != "")
            {

                Query = Query + " And (emp.ServiceNo='" + PNo + "')";
            }


            if (CNIC != null && CNIC != "")
            {
                Query = Query + " And ( emp.Nic= '" + CNIC + "')";
            }

            if (Department != null && Department != "--Select--" && Department != "")
            {
                Query = Query + "And (dep.Department_Name = '" + Department + "')";
            }

            if (Designation != null && Designation != "--Select--" && Designation != "")
            {
                Query = Query + "And (deg.designation = '" + Designation + "')";
            }

            if (Rank != null & Rank != "--Select--" && Rank != "")
            {
                Query = Query + "And (rk.Rank_Name= '" + Rank + "')";
            }

            if (Gender != null && Gender != "--Select--" && Gender != "")
            {
                Query = Query + " And (g.GenderName= '" + Gender + "')";
            }

            if (GateNo != null && GateNo != "--Select--" && GateNo != "")
            {
                Query = Query + "And (gt.Gate_Name = '" + GateNo + "')";
            }

            if (GateLane != null && GateLane != "--Select--" && GateLane != "")
            {
                Query = Query + "And (p.LocationName='" + GateLane + "')";

            }
            if (DeviceName != null && DeviceName != "--Select--" && DeviceName != "")
            {
                Query = Query + "And (ti.TerminalName= '" + DeviceName + "')";
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