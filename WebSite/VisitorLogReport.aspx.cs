using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Web.Services;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;
using System.Drawing;
using System.Data.SqlClient;
using System.Text;

public partial class VisitorLogReport : System.Web.UI.Page
{
    Common ObjCommon = new Common();
    private string GridDataQuery
    {
        get
        {
            var value = ViewState["GridDataQuery"];
            return null != value ? (string)value : "";
        }
        set
        {
            ViewState["GridDataQuery"] = value;
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            txtToDate.Text = DateTime.Now.ToString("yyyy-MM-dd");

            //DataTable GettingStauts = ObjCommon.GetStatus();
            //ddlApprovedDeclined.DataSource = GettingStauts;
            //ddlApprovedDeclined.DataValueField = "";
            //ddlApprovedDeclined.DataTextField = "Status";
            //ddlApprovedDeclined.DataBind();
            //ddlApprovedDeclined.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));


            //DataTable Department = ObjCommon.GetDepartment();
            //ddlDepartment.DataSource = Department;
            //ddlDepartment.DataValueField = "Department_ID";
            //ddlDepartment.DataTextField = "Department_Name";
            //ddlDepartment.DataBind();
            //ddlDepartment.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));

            //DataTable HostNameForVisitorLog = ObjCommon.GetHostNameForVisitorLogReport();
            //ddlHostName.DataSource = HostNameForVisitorLog;
            //ddlHostName.DataValueField = "NIC";
            //ddlHostName.DataTextField = "FullName";
            //ddlHostName.DataBind();
            //ddlHostName.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));

            //DataTable dtRanks = ObjCommon.GetRanks();
            //ddlRank.DataSource = dtRanks;
            //ddlRank.DataValueField = "Rank_ID";
            //ddlRank.DataTextField = "Rank_Name";
            //ddlRank.DataBind();
            //ddlRank.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));

            //DataTable dtDesignation = ObjCommon.GetDesignation();
            //ddlDesignation.DataSource = dtDesignation;
            //ddlDesignation.DataValueField = "Designation_ID";
            //ddlDesignation.DataTextField = "designation_Name";
            //ddlDesignation.DataBind();
            //ddlDesignation.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));

            //DataTable dtGateLane = ObjCommon.GetGateLane();
            //ddlGateLane.DataSource = dtGateLane;
            //ddlGateLane.DataValueField = "ID";
            //ddlGateLane.DataTextField = "LocationName";
            //ddlGateLane.DataBind();
            //ddlGateLane.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));

            //DataTable dtGateNo = ObjCommon.GetGateNo();
            //ddlGateNo.DataSource = dtGateNo;
            //ddlGateNo.DataValueField = "Gate_ID";
            //ddlGateNo.DataTextField = "Gate_Name";
            //ddlGateNo.DataBind();
            //ddlGateNo.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));

            //DataTable dtDeviceName = ObjCommon.NewGetDeviceName();
            //ddlDeviceName.DataSource = dtDeviceName;
            //ddlDeviceName.DataValueField = "Terminal_ID";
            //ddlDeviceName.DataTextField = "TerminalName";
            //ddlDeviceName.DataBind();
            //ddlDeviceName.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));


        }
    }
    public void BindGV()
    {
      string Query= " Select ROW_NUMBER() OVER(ORDER BY(SELECT DATE)) AS SR#,vt.[Full_Name] as VisitorName ," +
            //"vt.[Father_Name] as FatherName ," +
            "vt.[CNIC] ," +
            //"vt.[Address], " +
                //"vt.[DoB]," +
                //" vt.[PhoneNo] ," +
                //"mv.[HOST] ,vt.[Place_To_Visit] ,
                "vt.[Purpose_To_Visit]  as VisitPurpose," +
            //" vt.[Status] ,
            //vt.[DateofVisit] , " +
          //--vt.[Company_ID],vt.[RFID],vt.[VisitorOrganization]  ,vt.[Designation] ,vt.[EmpNo] ,vt.[PassportNo] ,vt.[Email] ,vt.[DrivLic],vt.[CReg] ,
         //--vt.[Cmake] ,vt.[CVariant] ,vt.[Cmodel] ,vt.[CColor] ,
           " vt.[VisitArea] ," +
           " IsNull(emp.FirstName, '') + ' ' + IsNull(emp.LastName, '') as HostName," +

           //"vt.[TimeIn] ,vt.[TimeOut] ," +
           //--vt.[EnglishName] ,vt.[AuthenticationType] ,vt.[CardExpire],vt.[StrStatus],
           //--vt.[ImageName] ,vt.[ImageData] ,vt.[imgSize] ,vt.[Deleted] ,vt.[IsHandled],mv.[ID],mv.[VID] ,
           " mv.[DATE]  as Date," +
           " Convert(varchar(25), mv.[TIME_IN], 8) as TimeIn, Convert(varchar(25), mv.[TIME_OUT], 8) as TimeOut ," +
           //"mv.[TIME_IN] ,mv.[TIME_OUT]  ," +
           //"mv.[Employee_ID] ,
           "mv.[VEHICLE_NUMBER] as Vehicle#, " +
         //--mv.[TOKEN_NUMBER] ,mv.[DEPARTMENT] ,mv.[GATE_NUMBER],mv.[Gate_Lane],
         //" mv.[NAME] , " +
         //--mv.[Dam_Sen_ID],mv.[RFID_ID] ,mv.[User_Type] ,mv.[IsHandled] ,      select* from mctx_visitorlog where User_Type = 'mctx_Visitor'
        //--mv.[IsHandledUVSS] ,
         //" mv.[Visit_Purpose] , " +
         //--mv.[Client_IP] ,mv.[TerminalID],mv.[Is_Authorised] ,
         //" mv.[CNIC]  ," +
         "mv.[Remarks]  " +
         //", IsNull(emp.FirstName, '') + ' ' + IsNull(emp.LastName, '') as HostName" +
         " FROM [mctx_visitorlog] mv " +
         " left join Visitor_Tbl vt on vt.CNIC = mv.CNIC " +
         " left join Employee emp on emp.Nic = mv.HOST " +
         " where mv.User_Type = 'mctx_Visitor' " +
          " and('" + txtName.Text + "' = '' or vt.[Full_Name] ='" + txtName.Text + "')" +
          " and('" + txtCNIC.Text + "' = '' or mv.CNIC = '" + txtCNIC.Text + "')" +
          " and('" + txtHostCNIC.Text + "' = '' or emp.Nic = '" + txtHostCNIC.Text + "') " +
          //" and ('"+ ddlApprovedDeclined.SelectedValue + "') = '' or vt.[Status] = ' " + ddlApprovedDeclined.SelectedValue + " ' " +
          // " and ('" + ddlGateNo.SelectedValue + "' = '' or vl.GATE_NUMBER = '" + ddlGateNo.SelectedValue + "')" +
     "and(convert(varchar(25), mv.[DATE], 121) >= '" + txtDate.Text + "' and convert(varchar(25), mv.[DATE], 121) <= '" + txtToDate.Text + "') ";


     
     GridDataQuery = Query;
        DataSet ds = ObjCommon.GetEmployeeDetailForGV(Query);

        GVdetails.DataSource = ds;
        GVdetails.DataBind();

    }
    public void BindGVExport()
    {
        DataSet ds = ObjCommon.GetEmployeeDetailForGV(GridDataQuery);

        GVdetails.DataSource = ds;
        GVdetails.DataBind();

    }

    protected void btnSaveResident_Click(object sender, EventArgs e)
    {
        BindGV();
        //txtHostCNIC = String.Empty;
        txtCNIC.Text = String.Empty;
        txtName.Text = String.Empty;
        //txtPNo.Text = String.Empty;
        //ddlHostName.SelectedIndex = 0;
        //ddlDepartment.SelectedIndex = 0;
        //ddlApprovedDeclined.SelectedIndex = 0;
        //ddlRank.SelectedIndex = 0;
        //ddlGateNo.SelectedIndex = 0;
        //ddlDesignation.SelectedIndex = 0;
        txtToDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
        txtDate.Text = DateTime.Now.ToString("yyyyy-MM-dd");



        //ClearAll();


    }
    protected void ClearAll(object sender, EventArgs e)
    {
        //BindGV();
        //ClearAll();
        Response.Redirect(Request.RawUrl);

    }

    //protected void btnSaveResident_Click(object sender, EventArgs e)
    //{
    //    BindGV();
    //    //Clear();

    //}

    //public void BindGVExport()
    //{
    //    DataSet ds = ObjCommon.GetEmployeeDetailForGV(GridDataQuery);

    //    GVdetails.DataSource = ds;
    //    GVdetails.DataBind();

    //}
    private void BindGrid()
    {
        DataSet ds = new DataSet();
        ds.ReadXml(Server.MapPath("~/Customers.xml"));
        GVdetails.DataSource = ds;
        GVdetails.DataBind();

    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }

    protected void Print(object sender, EventArgs e)
    {
        GVdetails.AllowPaging = false;
        //BindGV();
        GVdetails.UseAccessibleHeader = true;
        GVdetails.HeaderRow.TableSection = TableRowSection.TableHeader;
        GVdetails.FooterRow.TableSection = TableRowSection.TableFooter;
        GVdetails.Attributes["style"] = "border-collapse:collapse";
        foreach (GridViewRow row in GVdetails.Rows)
        {
            if (row.RowIndex % 20 == 0 && row.RowIndex != 0)
            {
                row.Attributes["style"] = "page-break-after:always;";
                //row.Attributes["style1"] = "Color:Black;";
            }
        }
        StringWriter sw = new StringWriter();
        HtmlTextWriter hw = new HtmlTextWriter(sw);
        GVdetails.RenderControl(hw);
        string gridHTML = sw.ToString().Replace("\"", "'").Replace(System.Environment.NewLine, "");
        StringBuilder sb = new StringBuilder();
        sb.Append("<script type = 'text/javascript'>");
        sb.Append("window.onload = new function(){");
        sb.Append("var printWin = window.open('', '', 'left=0");
        sb.Append(",top=0,width=1000,height=600,status=0');");
        sb.Append("printWin.document.write(\"");
        string style = "<style type = 'text/css'>thead {display:table-header-group;} tfoot{display:table-footer-group;}</style>";
        //string style1 = "<style type ='text/css'>body{Color:Black;}</style>";
        sb.Append(style + gridHTML);
        sb.Append("\");");
        sb.Append("printWin.document.close();");
        sb.Append("printWin.focus();");
        sb.Append("printWin.print();");
        sb.Append("printWin.close();");
        sb.Append("};");
        sb.Append("</script>");
        ClientScript.RegisterStartupScript(GetType(), "GridPrint", sb.ToString());
        GVdetails.AllowPaging = false;
        GVdetails.DataBind();

    }
    protected void ClickForExcel(object sender, EventArgs e)
    {
        Excel();
    }
    private void Excel()
    {
        Response.Clear();
        Response.Buffer = true;
        Response.ClearContent();
        Response.ClearHeaders();
        Response.Charset = "";
        string FileName = "EmployeeLogReport" + DateTime.Now + ".xls";
        StringWriter strwritter = new StringWriter();
        HtmlTextWriter htmltextwrtter = new HtmlTextWriter(strwritter);
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.ContentType = "application/vnd.ms-excel";
        Response.AddHeader("Content-Disposition", "attachment;filename=" + FileName);
        GVdetails.GridLines = GridLines.Both;
        GVdetails.HeaderStyle.Font.Bold = true;
        GVdetails.RenderControl(htmltextwrtter);
        Response.Write(strwritter.ToString());
        Response.End();

    }
    

    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GVdetails.PageIndex = e.NewPageIndex;
        BindGrid();

    }
}