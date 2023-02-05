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

public partial class PACS_Report_VACSNotAllowedReport : System.Web.UI.Page
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

            

            DataTable ClearanceStatus = ObjCommon.NotAllowdVACS();
            ddlClearanceStatus.DataSource = ClearanceStatus;
            ddlClearanceStatus.DataValueField = "ID";
            ddlClearanceStatus.DataTextField = "ClearanceStatusName";
            ddlClearanceStatus.DataBind();
            ddlClearanceStatus.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));


            

        }

    }
    public void BindGV()
    {
        // tbl += "<td style='text-align:left; white-space:nowrap;'id='SR#" + i + "'>" + j + "</td>";
        //<td style='text-align:left; white-space:nowrap;'id='SR#" + i + "'>" + j + "</td>


        string QueryFilters = " select  ROW_NUMBER() OVER (ORDER BY(SELECT 1)) AS SR# , convert(varchar(25), convert(DATETime,[Date]), 105) as Date, vac.VehicleNo as VehicleNo, vac.VehicleType as VehicleType, gt.Gate_Name as GateName, convert(varchar(25), TIME_IN, 108) as TimeIn, convert(varchar(25), convert(DATETime,TIME_OUT), 108) as TimeOut ";
        // "ServiceNo as PNo, FirstName  +  LastName as Name , vac.CNIC as CNIC, TIME_IN as TimeIn, TIME_OUT as TimeOut ";
        //if (id.Checked)
        //    QueryFilters += ",id ";
        if (chkbxPn.Checked)
            QueryFilters += ",emp.ServiceNo as PNo ";
        if (chkbxName.Checked)
            QueryFilters += ",FirstName  +  LastName as FullName";
        if (chkbxCNIC.Checked)
            QueryFilters += ",vac.CNIC as CNIC";

        if (chkbxMake.Checked)
            QueryFilters += ", tm.TransportMake as Make";
        if (chkbxBodyType.Checked)
            QueryFilters += ",tbt.TransportBodyType as BodyType";
        if (chkbxModel.Checked)
            QueryFilters += ",vac.Model as Model ";
        if (chkbxColour.Checked)
            QueryFilters += ",tc.TransportColour as Colour";
        if (chkbxRank.Checked)
            QueryFilters += ",rk.Rank_Name as Rank ";
        if (chkbxGender.Checked)
            QueryFilters += ",g.GenderName  as Gender";
        if (chkbxUserType.Checked)
            QueryFilters += ",vl.User_Type as UserType";
        //if (chkbxEmployeeType.Checked)
        //    QueryFilters += ",vac.EMP_Type as EmpType";
        if (chkbxClearanceStatus.Checked)
            QueryFilters += ",cs.ClearanceStatusName as ClearanceStatus";
        if (chkbxSiteAllowed.Checked)
            QueryFilters += ",psa.Site_Name as SiteAllowed";
        if (chkbxDepartment.Checked)
            QueryFilters += ", dep.Department_Name as Department";
        //if (chkbxGateNo.Checked)
        //    QueryFilters += ",gt.Gate_Name as GateName";
        if (chkbxGateLane.Checked)
            QueryFilters += ",p.LocationName as GateLane";
        if (chkbxDeviceName.Checked)
            QueryFilters += ", wd.DeviceName as DeviceName";
        if (chkbxRemarks.Checked)
            QueryFilters += ",Remarks  ";
        //gt.Gate_Name

        string Query = QueryFilters + " FROM [mctx_visitorlog] vl  " +

           " LEFT JOIN dbo.mctx_VACS vac ON vac.VehicleNo = vl.VEHICLE_NUMBER " +
            " LEFT JOIN dbo.Employee emp ON emp.EID = vac.EMP_ID " +
            " LEFT JOIN dbo.mctx_Department dep ON dep.Department_ID = emp.Department " +
            " LEFT JOIN dbo.HR_Designation deg ON deg.Designation_ID = emp.Designation " +
            " LEFT JOIN dbo.mctx_Ranks rk ON rk.Rank_ID = emp.[Rank] " +
            " LEFT JOIN dbo.Gender g ON g.ID = emp.Gender " +
           "  LEFT JOIN dbo.mctx_PersonSiteAllowed psa ON psa.ID = vac.VehicleClearanceLevel " +
           "  LEFT JOIN dbo.ClearanceStatus cs ON cs.ID = vac.VehicleClearanceStatus " +
            " LEFT JOIN dbo.mctx_Gates gt ON gt.Gate_ID = vl.GATE_NUMBER " +
            " LEFT JOIN dbo.mctx_Wiegand_Devices wd ON wd.ID = vl.TerminalID " +
            " LEFT JOIN dbo.mctx_TerminalInfos ti ON ti.Terminal_ID = wd.Terminal_ID " +
            " LEFT JOIN dbo.Place p ON p.ID = vl.Gate_Lane " +
           "  LEFT JOIN dbo.win_TransportBodyType tbt ON tbt.id = vac.BodyType " +
           "  LEFT JOIN dbo.win_TransportColour tc ON tc.id = vac.Colour " +
            " LEFT JOIN dbo.win_TransportMake tm ON tm.id = vac.Make " +
                        //WHERE vl.User_Type = @UserType '  

                        //" User_Type = 'Employee'" + 
                        //" where ('" + txtPNo.Text + "'='' or emp.ServiceNo='" + txtPNo.Text + "')" +
                        //               " and  ('" + txtCNIC.Text + "'='' or emp.Nic='" + txtCNIC.Text + "' )" +
                        " where (convert(varchar(25), vl.[Date], 103) >= '" + txtDate.Text + "' and convert(varchar(25), vl.[Date], 103) <= '" + txtToDate.Text + "') " +
                  // " and ('" + txtPNo.Text + "'='' or emp.ServiceNo='" + txtPNo.Text + "')" +
                  //" and  ('" + txtCNIC.Text + "'='' or emp.Nic='" + txtCNIC.Text + "' )" +

                  // " and  ('" + txtDate.Text + "'='' or vl.DATE='" + txtDate.Text + "' AND  '" + txtToDate.Text + "'='' or vl.DATE='" + txtToDate.Text + "' )" +
                  // " and ('" + ddlVehicleNo.SelectedValue + "' = '' or vac.VACS_ID ='" + ddlVehicleNo.SelectedValue + "')" +
                  // " and ('" + ddlVehicleType.SelectedValue + "' = '' or vac.VehicleType ='" + ddlVehicleType.SelectedValue + "' )" +
                  // " and ('" + ddlDeviceName.SelectedValue + "'= '' or  wd.Terminal_ID = '" + ddlDeviceName.SelectedValue + "')" +
                  //" and ('" + ddlMake.SelectedValue + "' = '' or vac.Make = '" + ddlMake.SelectedValue + "')" +
                  //" and ('" + ddlGateNo.SelectedValue + "' = '' or vl.GATE_NUMBER = '" + ddlGateNo.SelectedValue + "')" +
                  //" and ('" + ddlGateLane.SelectedValue + "' = '' or vl.Gate_Lane = '" + ddlGateLane.SelectedValue + "')" +
                  // " and ('" + ddlDeviceName.SelectedValue + "' = '' or wd.Terminal_ID= '" + ddlDeviceName.SelectedValue + "')" +
                  " and ('" + ddlClearanceStatus.SelectedValue + "' = '' or vac.VehicleClearanceStatus= '" + ddlClearanceStatus.SelectedValue + "')" +
                    "and (vl.User_Type = 'mctx_VACS') order by vl.DATE";
        // " and (vl.[Date]>= '" + txtDate + "') AND  (vl.[Date] <= '" + txtToDate + "') "  ;

        GridDataQuery = Query;
        //Session["GridValue"] = Query;
        DataSet ds = ObjCommon.GetEmployeeDetailForGV(Query);

        GVdetails.DataSource = ds;
        GVdetails.DataBind();

    }
    //string GridDataQuery;

    protected void btnSaveResident_Click(object sender, EventArgs e)
    {
        BindGV();
        //Clear();

    }
    protected void ClearAll(object sender, EventArgs e)
    {
        //BindGV();
        //Clear();
        Response.Redirect(Request.RawUrl);
    }

    public void BindGVExport()
    {
        DataSet ds = ObjCommon.GetEmployeeDetailForGV(GridDataQuery);

        GVdetails.DataSource = ds;
        GVdetails.DataBind();

    }
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
            if (row.RowIndex % 10 == 0 && row.RowIndex != 0)
            {
                row.Attributes["style"] = "page-break-after:always;";
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
        string FileName = "UnAuthorized VACS Report" + DateTime.Now + ".xls";
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
    //    string FileName = "UnAuthorized VACS Report" + DateTime.Now + ".doc";
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