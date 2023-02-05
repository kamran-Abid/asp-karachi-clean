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

public partial class UVSS_Report_UVSS_Report : System.Web.UI.Page
{

    Common ObjCommon = new Common();
    //static string GridDataQuery = Session["GridValue"].ToString();// = Query;
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
        //GridDataQuery = Query;


        if (!IsPostBack)
        {
            txtDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            txtToDate.Text = DateTime.Now.ToString("yyyy-MM-dd");

            //DataTable VehicleNo = ObjCommon.GetUVSSVehicelNumber();
            //ddlVehicleNo.DataSource = VehicleNo;
            //ddlVehicleNo.DataValueField = "UVSSID";
            //ddlVehicleNo.DataTextField = "VehicleNumber";
            //ddlVehicleNo.DataBind();
            //ddlVehicleNo.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));



            DataTable GateLane = ObjCommon.GetGateLane();
            ddlGateLane.DataSource = GateLane;
            ddlGateLane.DataValueField = "ID";
            ddlGateLane.DataTextField = "LocationName";
            ddlGateLane.DataBind();
            ddlGateLane.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));

            DataTable FOD = ObjCommon.GetUVSSFOD();
            ddlFOD.DataSource = FOD;
            ddlFOD.DataValueField = "FOD_ID";
            ddlFOD.DataTextField = "FOD_Status";
            ddlFOD.DataBind();
            ddlFOD.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));

            DataTable PDI = ObjCommon.PDI();
            ddlPDI.DataSource = PDI;
            ddlPDI.DataValueField = "PDI_ID";
            ddlPDI.DataTextField = "PDI_Status";
            ddlPDI.DataBind();
            ddlPDI.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));


        }
    }
    public void BindGV()
    {
        // tbl += "<td style='text-align:left; white-space:nowrap;'id='SR#" + i + "'>" + j + "</td>";
        //<td style='text-align:left; white-space:nowrap;'id='SR#" + i + "'>" + j + "</td>


        string QueryFilters = " select  ROW_NUMBER() OVER (ORDER BY(SELECT 1)) AS SR#, Convert(varchar,ul.LogDate,106) as LogDate, Convert(varchar,ul.LogDateTime,108) as LogDateTime, p.LocationName as Lane, ul.VehicleNumber as VehicleNo, ufd.FOD_Status as FOD, upd.PDI_Status as PDI ";
        // "ServiceNo as PNo, FirstName  +  LastName as Name , vac.CNIC as CNIC, TIME_IN as TimeIn, TIME_OUT as TimeOut ";
        //if (id.Checked)
        //    QueryFilters += ",id ";
        //if (chkbxLocationName.Checked)
        //    QueryFilters += ",p.LocationName";//chkbxPreviousStatus
        if (chkbxPreviousStatus.Checked)
            QueryFilters += ",up.Previous_Status as PreviousStatus";
        if (chkbxRevisedDecision.Checked)
            QueryFilters += ",ul.RevisedDecision";
        if (chkbxRevisedRemarks.Checked)
            QueryFilters += ", ul.RevisedRemarks";


        string Query = QueryFilters + " from [tbl_UVSSlog] ul" +
                                    " LEFT JOIN UVSS_FOD ufd ON ufd.FOD_ID = ul.FOD" +
                                    " LEFT JOIN UVSS_PDI upd ON upd.PDI_ID = ul.PDI" +
                                    " LEFT JOIN UVSS_Previous up ON up.Previous_ID = ul.Previous" +
                                    " LEFT JOIN Place p ON p.ID = ul.Place_Id " +
//" where  (convert(varchar(25), ul.[LogDate] , 121) >= '" + txtDate.Text + "' and convert(varchar(25), ul.[LogDate], 121) <= '" + txtToDate.Text + "') Order by LogDate";

//if (txtVecNo.Text != "")
//    Query = Query + " and (ul.VehicleNumber ='" + txtVecNo.Text+ "')";

//if (ddlFOD.SelectedValue != "")
//    Query = Query + " and (ul.FOD ='" + ddlFOD.SelectedValue + "' ) ";

//if (ddlPDI.SelectedValue != "")
//    Query = Query + " and (ul.PDI ='" + ddlPDI.SelectedValue + "' ) ";

//if (ddlGateLane.SelectedValue != "")
//    Query = Query + " and (ul.Place_Id='" + ddlGateLane.SelectedValue + "' ) ";
//          " and (ul.Place_Id = '' or ul.Place_Id = '" + ddlGateLane.SelectedValue + "')" +

"where (convert(varchar(25), ul.[LogDate], 121) >= '" + txtDate.Text + "' and convert(varchar(25), ul.[LogDate], 121) <= '" + txtToDate.Text + "')" +
             " and ('" + txtVecNo.Text + "'='' or ul.VehicleNumber='" + txtVecNo.Text + "')" +
                        " and  ('" + ddlFOD.SelectedValue + "'='' or ul.FOD='" + ddlFOD.SelectedValue + "' )" +

                  // " and  ('" + txtDate.Text + "'='' or vl.DATE='" + txtDate.Text + "' AND  '" + txtToDate.Text + "'='' or vl.DATE='" + txtToDate.Text + "' )" +
                  " and ('" + ddlPDI.SelectedValue + "' = '' or ul.PDI ='" + ddlPDI.SelectedValue + "')" +
                  " and ('" + ddlGateLane.SelectedValue + "' = '' or ul.Place_Id ='" + ddlGateLane.SelectedValue + "') order by ul.LogDate";


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
        Response.Redirect(Request.RawUrl);
    }
    public void BindGVExport()
    {
        DataSet ds = ObjCommon.GetEmployeeDetailForGV(GridDataQuery);

        GVdetails.DataSource = ds;
        GVdetails.DataBind();

    }
   
    //protected void Page_Load(object sender, EventArgs e)
    //{
    //    Response.Cache.SetCacheability(HttpCacheability.NoCache);
    //    this.BindGrid();
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
        string FileName = "UVSS Report" + DateTime.Now + ".xls";
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
    //    string FileName = "UVSS Report" + DateTime.Now + ".doc";
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