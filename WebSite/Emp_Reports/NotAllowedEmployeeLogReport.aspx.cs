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

public partial class Emp_Reports_NotAllowedEmployeeLogReport : System.Web.UI.Page
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

            DataTable ClearanceStatus = ObjCommon.GetNotAllowedEmployeeClearanceStatus();
            ddlClearanceStatus.DataSource = ClearanceStatus;
            ddlClearanceStatus.DataValueField = "ID";
            ddlClearanceStatus.DataTextField = "ClearanceStatusName";
            ddlClearanceStatus.DataBind();
            ddlClearanceStatus.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));


        }
    }
    public void BindGV()
    {


        string QueryFilters = " select ROW_NUMBER() OVER (ORDER BY(SELECT 1)) AS SR#, Convert(varchar,Convert(DATETime,vl.[DATE]), 106) as Date, ServiceNo as PNo, FirstName+''+LastName as Name , Nic as CNIC, gt.Gate_Name as Gate, Convert(varchar(25), TIME_IN, 108) as TimeIn, Convert(varchar(25), convert(DATETime,TIME_OUT), 08) as TimeOut ";
        if (chkbxFatherName.Checked)
            QueryFilters += ",emp.FatherName as FatherName ";
        if (chkbxClearanceStatus.Checked)
            QueryFilters += ",cs.ClearanceStatusName as Clearance";
        // if (chkbxDate.Checked)
        //    QueryFilters += ", DATE  ";
        if (chkbxDepartment.Checked)
            QueryFilters += ", dep.Department_Name as Deptt";
        if (chkbxDesignation.Checked)
            QueryFilters += ",deg.designation as Designation ";
        if (chkbxRank.Checked)
            QueryFilters += ",rk.Rank_Name as Rank ";
        if (chkbxGender.Checked)
            QueryFilters += ",g.GenderName  as Gender";
        if (chkbxSiteName.Checked)
            QueryFilters += ",psa.Site_Name as SiteAllowed";
        if (chkbxValidUpto.Checked)
            QueryFilters += ", emp.ValidUpto as ExpiryDate ";
        if (chkbxVehicleNo.Checked)
            QueryFilters += ", VEHICLE_NUMBER as Vehicle#";
        //if (chkbxGateName.Checked)
        //    QueryFilters += ",gt.Gate_Name as GateName ";
        //if (chkbxGateNo.Checked)
        //    QueryFilters += ",vl.GATE_NUMBER";
        //if (chkbxGateLane.Checked)
        //    QueryFilters += ",Gate_Lane as GateLane";
        if (chkbxDeviceName.Checked)
            QueryFilters += ",p.LocationName as GateLane";
        //if (chkbxUserType.Checked)
        //    QueryFilters += ",User_Type ";
        if (chkbxTerminalName.Checked)
            QueryFilters += ",ti.TerminalName as Terminal";
        if (chkbxRemarks.Checked)
            QueryFilters += ",Remarks  ";
        //if (chkbxTimeIn.Checked)
        //    QueryFilters += ",TIME_IN ";
        //if (chkbxTimeOut.Checked)
        //    QueryFilters += ",TIME_OUT ";
        string Query = QueryFilters + " FROM [mctx_visitorlog] vl  " +

                        " LEFT JOIN [dbo].[Employee] emp ON emp.EID = vl.VID " +
                        " LEFT JOIN [dbo].[mctx_Department] dep ON dep.Department_ID = emp.Department " +
                        " LEFT JOIN [dbo].[HR_Designation] deg ON deg.Designation_ID = emp.Designation " +
                        " LEFT JOIN [dbo].[mctx_Ranks] rk ON rk.Rank_ID = emp.[Rank] " +
                        " LEFT JOIN [dbo].[Gender] g ON g.ID = emp.Gender" +
                        " LEFT JOIN dbo.ClearanceStatus cs ON cs.ID = emp.ClearanceStatus " +
                        " LEFT JOIN [dbo].[mctx_PersonSiteAllowed] psa ON psa.ID = emp.ClearanceLevel" +
                        " LEFT JOIN [dbo].[mctx_Gates] gt ON gt.Gate_ID = vl.GATE_NUMBER" +
                        " LEFT JOIN [dbo].[mctx_Wiegand_Devices] wd ON wd.ID = vl.TerminalID" +
                        " LEFT JOIN [dbo].[mctx_TerminalInfos] ti ON ti.Terminal_ID = wd.Terminal_ID" +
                        " LEFT JOIN [dbo].[Place] p ON p.ID = vl.Gate_Lane" +

                     //" User_Type = 'Employee'" + 
                     // " where ('" + txtPNo.Text + "'='' or emp.ServiceNo='" + txtPNo.Text + "')" +
                     // " and  ('" + txtCNIC.Text + "'='' or emp.Nic='" + txtCNIC.Text + "' )" +
                     //" and  ('" + txtName.Text + "'='' or emp.FirstName + Emp.LastName like'%" + txtName.Text + "%' )" +

                     // " and  ('" + txtDate.Text + "'='' or vl.DATE='" + txtDate.Text + "' AND  '" + txtToDate.Text + "'='' or vl.DATE='" + txtToDate.Text + "' )" +
                     // " and ('" + ddlRank.SelectedValue + "' = '' or emp.Rank='" + ddlRank.SelectedValue + "')" +
                     //" and ('" + ddlDesignation.SelectedValue + "' = '' or emp.Designation='" + ddlDesignation.SelectedValue + "' )" +
                     //" and ('" + ddlDepartment.SelectedValue + "'= '' or emp.Department = '" + ddlDepartment.SelectedValue + "')" +
                     //" and ('" + ddlGender.SelectedValue + "' = '' or emp.Gender = '" + ddlGender.SelectedValue + "')" +
                     //" and ('" + ddlGateNo.SelectedValue + "' = '' or vl.GATE_NUMBER = '" + ddlGateNo.SelectedValue + "')" +
                     //" and ('" + ddlGateLane.SelectedValue + "' = '' or vl.Gate_Lane = '" + ddlGateLane.SelectedValue + "')" +
                     //" and ('" + ddlDeviceName.SelectedValue + "' = '' or wd.Terminal_ID= '" + ddlDeviceName.SelectedValue + "')" +
                     " where ('" + ddlClearanceStatus.SelectedValue + "' = '' or emp.ClearanceStatus= '" + ddlClearanceStatus.SelectedValue + "')" +
                    " and ( vl.User_Type= 'Employee')" +
                  // " and (vl.[Date]>= '" + txtDate + "') AND  (vl.[Date] <= '" + txtToDate + "') "  ;
                  " and  (convert(varchar(25), vl.[Date], 121) >= '" + txtDate.Text + "' and convert(varchar(25), vl.[Date], 121) <= '" + txtToDate.Text + "') order by vl.DATE";
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
        BindGV();
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
        string FileName = "UnAuthorizedEmployeeLogReport" + DateTime.Now + ".xls";
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
    //protected void ConvertToWord(object sender, EventArgs e)
    //{
    //    ExportGridToword();
    //}
    //private void ExportGridToword()
    //{
    //    Response.Clear();
    //    Response.Buffer = true;
    //    Response.ClearContent();
    //    Response.ClearHeaders();
    //    Response.Charset = "";
    //    string FileName = "UnAuthorized Employee Log Report" + DateTime.Now + ".doc";
    //    StringWriter strwritter = new StringWriter();
    //    HtmlTextWriter htmltextwrtter = new HtmlTextWriter(strwritter);
    //    Response.Cache.SetCacheability(HttpCacheability.NoCache);
    //    Response.ContentType = "application/msword";
    //    Response.AddHeader("Content-Disposition", "attachment;filename=" + FileName);
    //    GVdetails.GridLines = GridLines.Both;
    //    GVdetails.HeaderStyle.Font.Bold = true;
    //    GVdetails.RenderControl(htmltextwrtter);
    //    Response.Write(strwritter.ToString());
    //    Response.End();

    //}

    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GVdetails.PageIndex = e.NewPageIndex;
        BindGrid();
    }
}