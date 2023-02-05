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

public partial class PACS_Report_PACS_REPORT : System.Web.UI.Page
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
            DataTable Department = ObjCommon.GetDepartment();

            //ddlDepartment.DataSource = Department;
            //ddlDepartment.DataValueField = "Department_ID";
            //ddlDepartment.DataTextField = "Department_Name";
            //ddlDepartment.DataBind();
            //ddlDepartment.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));

            DataTable VehicleType = ObjCommon.GetVehicleType();

            ddlVehicleType.DataSource = VehicleType;
            ddlVehicleType.DataValueField = "VACS_ID";
            ddlVehicleType.DataTextField = "VehicleType";
            ddlVehicleType.DataBind();
            ddlVehicleType.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));

            //DataTable VehicleNo = ObjCommon.GetVehicleNo();
            //ddlVehicleNo.DataSource = VehicleNo;
            //ddlVehicleNo.DataValueField = "VACS_ID";
            //ddlVehicleNo.DataTextField = "VehicleNo";
            //ddlVehicleNo.DataBind();
            //ddlVehicleNo.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));

            //DataTable Ranks = ObjCommon.GetRanks();s
            //ddlRank.DataSource = Ranks;
            //ddlRank.DataValueField = "Rank_ID";
            //ddlRank.DataTextField = "Rank_Name";
            //ddlRank.DataBind();
            //ddlRank.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));

            DataTable Make = ObjCommon.GetNewMake();
            ddlMake.DataSource = Make;
            ddlMake.DataValueField = "id";
            ddlMake.DataTextField = "TransportMake";
            ddlMake.DataBind();
            ddlMake.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));

            DataTable GateLane = ObjCommon.GetGateLane();
            ddlGateLane.DataSource = GateLane;
            ddlGateLane.DataValueField = "ID";
            ddlGateLane.DataTextField = "LocationName";
            ddlGateLane.DataBind();
            ddlGateLane.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));

            DataTable ClearanceStatus = ObjCommon.GetClearanceStatus();
            ddlClearanceStatus.DataSource = ClearanceStatus;
            ddlClearanceStatus.DataValueField = "ID";
            ddlClearanceStatus.DataTextField = "ClearanceStatusName";
            ddlClearanceStatus.DataBind();
            ddlClearanceStatus.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));


            DataTable GateName = ObjCommon.GetGateNo();
            ddlGateNo.DataSource = GateName;
            ddlGateNo.DataValueField = "Gate_ID";
            ddlGateNo.DataTextField = "Gate_Name";
            ddlGateNo.DataBind();
            ddlGateNo.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));

            DataTable DeviceName = ObjCommon.NewGetDeviceName();
            ddlDeviceName.DataSource = DeviceName;
            ddlDeviceName.DataValueField = "Terminal_ID";
            ddlDeviceName.DataTextField = "TerminalName";
            ddlDeviceName.DataBind();
            ddlDeviceName.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));



        }
    }
    public void BindGV()
    {
        // tbl += "<td style='text-align:left; white-space:nowrap;'id='SR#" + i + "'>" + j + "</td>";
       //<td style='text-align:left; white-space:nowrap;'id='SR#" + i + "'>" + j + "</td>


        string QueryFilters = " select  ROW_NUMBER() OVER (ORDER BY(SELECT 1)) AS SR# , DATE as Date, vac.VehicleNo as VehicleNo, vac.VehicleType as VehicleType, gt.Gate_Name as GateName, TIME_IN as TimeIn, TIME_OUT as TimeOut ";
        // "ServiceNo as PNo, FirstName  +  LastName as Name , vac.CNIC as CNIC, TIME_IN as TimeIn, TIME_OUT as TimeOut ";
        //if (id.Checked)
        //    QueryFilters += ",id ";
        if (chkbxPn.Checked)
            QueryFilters += ",emp.ServiceNo as PNo ";
        if (chkbxName.Checked)
            QueryFilters += ",FirstName  +  LastName as Name";
        if (chkbxCNIC.Checked)
            QueryFilters += ",vac.CNIC as CNIC";

        if (chkbxMake.Checked)
            QueryFilters += ", tm.TransportMake as Make";
        if (chkbxBodyType.Checked)
            QueryFilters += ",tbt.TransportBodyType as Body_Type";
        if (chkbxModel.Checked)
            QueryFilters += ",vac.Model as Model ";
        if (chkbxColour.Checked)
            QueryFilters += ",tc.TransportColour as Colour";
        if (chkbxRank.Checked)
            QueryFilters += ",rk.Rank_Name as Rank ";
        if (chkbxGender.Checked)
            QueryFilters += ",g.GenderName  as Gender";
        if (chkbxUserType.Checked)
            QueryFilters += ",User_Type";
        if (chkbxEmployeeType.Checked)
            QueryFilters += ",vac.EMP_Type as EmployeeType";
        if (chkbxClearanceStatus.Checked)
            QueryFilters += ",cs.ClearanceStatusName as ClearanceStatus";
        if (chkbxSiteAllowed.Checked)
            QueryFilters += ",psa.Site_Name as Site_Allowed";
        if (chkbxDepartment.Checked)
            QueryFilters += ", dep.Department_Name";
        if (chkbxGateLane.Checked)
            if (chkbxGateNo.Checked)
                QueryFilters += ",vl.GATE_NUMBER";
        QueryFilters += ",p.LocationName as GateLane";
        if (chkbxDeviceName.Checked)
            QueryFilters += ", wd.DeviceName as DeviceName";
        if (chkbxRemarks.Checked)
            QueryFilters += ",Remarks  ";
        //gt.Gate_Name

        string Query = QueryFilters + " FROM [mctx_visitorlog] vl  " +

           " LEFT JOIN dbo.mctx_VACS vac ON vac.VACS_ID = vl.VID " +
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
                        " where ('" + txtPNo.Text + "'='' or emp.ServiceNo='" + txtPNo.Text + "')" +
                        " and  ('" + txtCNIC.Text + "'='' or emp.Nic='" + txtCNIC.Text + "' )" +
                        " and  ('" + txtVehicleNo.Text + "'='' or vac.VehicleNo='" + txtVehicleNo.Text + "' )" +

                  // " and  ('" + txtDate.Text + "'='' or vl.DATE='" + txtDate.Text + "' AND  '" + txtToDate.Text + "'='' or vl.DATE='" + txtToDate.Text + "' )" +
                  // " and ('" + ddlVehicleNo.SelectedValue + "' = '' or vac.VACS_ID ='" + ddlVehicleNo.SelectedValue + "')" +
                  " and ('" + ddlVehicleType.SelectedValue + "' = '' or vac.VACS_ID='" + ddlVehicleType.SelectedValue + "' )" +
                  // " and ('" + ddlDeviceName.SelectedValue + "'= '' or  wd.Terminal_ID = '" + ddlDeviceName.SelectedValue + "')" +
                  " and ('" + ddlMake.SelectedValue + "' = '' or vac.Make = '" + ddlMake.SelectedValue + "')" +
                  " and ('" + ddlGateNo.SelectedValue + "' = '' or vl.GATE_NUMBER = '" + ddlGateNo.SelectedValue + "')" +
                  " and ('" + ddlGateLane.SelectedValue + "' = '' or vl.Gate_Lane = '" + ddlGateLane.SelectedValue + "')" +
                  " and ('" + ddlDeviceName.SelectedValue + "' = '' or wd.Terminal_ID= '" + ddlDeviceName.SelectedValue + "')" +
                  " and ('" + ddlClearanceStatus.SelectedValue + "' = '' or vac.VehicleClearanceStatus= '" + ddlClearanceStatus.SelectedValue + "')" +
                  // " and (vl.[Date]>= '" + txtDate + "') AND  (vl.[Date] <= '" + txtToDate + "') "  ;
                  " and  (convert(varchar(25), vl.[Date], 121) >= '" + txtDate.Text + "' and convert(varchar(25), vl.[Date], 121) <= '" + txtToDate.Text + "') Order by vl.[Date] ";
  
        GridDataQuery = Query;
        //Session["GridValue"] = Query;
        DataSet ds = ObjCommon.GetEmployeeDetailForGV(Query);

        GVdetails.DataSource = ds;
        GVdetails.DataBind();

    }
    //string GridDataQuery;

    public void BindGVExport()
    {
        DataSet ds = ObjCommon.GetEmployeeDetailForGV(GridDataQuery);

        GVdetails.DataSource = ds;
        GVdetails.DataBind();

    }
    protected void btnSaveResident_Click(object sender, EventArgs e)
    {
        BindGV();
        Clear();

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        //  ExportGridToPDF();

        CreatePF();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        //required to avoid the runtime error "  
        //Control 'GridView1' of type 'GridView' must be placed inside a form tag with runat=server."  
    }

    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GVdetails.PageIndex = e.NewPageIndex;
        //  this.BindGrid();
        BindGV();
    }
    private void ExportGridToPDF()
    {
        int columnsCount = GVdetails.HeaderRow.Cells.Count;
        PdfPTable pdfTable = new PdfPTable(columnsCount);
        foreach (TableCell gridViewHeaderCell in GVdetails.HeaderRow.Cells)
        {
            iTextSharp.text.Font font = new iTextSharp.text.Font();
            font.Color = new BaseColor(GVdetails.HeaderStyle.ForeColor);
            PdfPCell pdfCell = new PdfPCell(new Phrase(gridViewHeaderCell.Text, font));
            pdfCell.BackgroundColor = new BaseColor(GVdetails.HeaderStyle.BackColor);
            pdfTable.AddCell(pdfCell);
        }
        foreach (GridViewRow gridViewRow in GVdetails.Rows)
        {
            if (gridViewRow.RowType == DataControlRowType.DataRow)
            {
                foreach (TableCell gridViewCell in gridViewRow.Cells)
                {
                    iTextSharp.text.Font font = new iTextSharp.text.Font();
                    font.Color = new BaseColor(GVdetails.RowStyle.ForeColor);
                    PdfPCell pdfCell = new PdfPCell(new Phrase(gridViewCell.Text, font));
                    pdfCell.BackgroundColor = new BaseColor(GVdetails.RowStyle.BackColor);
                    pdfTable.AddCell(pdfCell);
                }
            }
            Document pdfDocument = new Document(PageSize.A4);
            PdfWriter.GetInstance(pdfDocument, Response.OutputStream);
            pdfDocument.Open();
            pdfDocument.Add(pdfTable);
            pdfDocument.Close();
            Response.ContentType = "application/pdf";
            Response.AppendHeader("content-disposition",
                "attachment;filename=Employees.pdf");
            Response.Write(pdfDocument);
            Response.Flush();
            Response.End();
        }
    }
    public void CreatePF()
    {

        GVdetails.PageSize = 35;
        int columnsCount = GVdetails.HeaderRow.Cells.Count;

        PdfPTable pdfTable = new PdfPTable(columnsCount);
        GVdetails.AllowPaging = false;
        BindGVExport();
        //BindGV();
        //GVdetails.DataBind();

        foreach (TableCell gridViewHeaderCell in GVdetails.HeaderRow.Cells)
        {

            iTextSharp.text.Font font = new iTextSharp.text.Font();

            font.Color = new BaseColor(GVdetails.HeaderStyle.ForeColor);
            font.Size = 8;
            PdfPCell pdfCell = new PdfPCell(new Phrase(gridViewHeaderCell.Text, font));

            pdfCell.BackgroundColor = new BaseColor(GVdetails.HeaderStyle.BackColor);

            pdfTable.AddCell(pdfCell);
        }
        TableRowSection TableHeader = GVdetails.HeaderRow.TableSection;
        GVdetails.UseAccessibleHeader = true;
        GVdetails.HeaderRow.TableSection = TableHeader;// GVdetails.HeaderRow;
        GVdetails.Attributes["style"] = "border-collapse:separate";
        foreach (GridViewRow gridViewRow in GVdetails.Rows)
        {
            if ((gridViewRow.RowIndex + 1) % GVdetails.PageSize == 0 && gridViewRow.RowIndex != 0)
            {
                gridViewRow.Attributes["style"] = "page-break-after:always;";
            }

            if (gridViewRow.RowType == DataControlRowType.DataRow)
            {

                foreach (TableCell gridViewCell in gridViewRow.Cells)
                {
                    iTextSharp.text.Font font = new iTextSharp.text.Font();
                    font.Color = new BaseColor(GVdetails.RowStyle.ForeColor);
                    font.Size = 8;
                    PdfPCell pdfCell = new PdfPCell(new Phrase(gridViewCell.Text.Trim().Replace("&nbsp;", ""), font));
                    //PdfPCell pdfCell = new PdfPCell(new Phrase(gridViewCell.Text, font));
                    pdfCell.BackgroundColor = new BaseColor(GVdetails.RowStyle.BackColor);

                    pdfTable.AddCell(pdfCell);

                }
            }
        }

        Document pdfDocument = new Document(PageSize.A4, -10f, -10f, 0f, -10f);

        PdfWriter.GetInstance(pdfDocument, Response.OutputStream);

        pdfDocument.Open();
        pdfDocument.Add(pdfTable);
        pdfDocument.Close();

        Response.ContentType = "application/pdf";
        Response.AppendHeader("content-disposition",
            "attachment;filename=VACSReport.pdf");
        Response.Write(pdfDocument);
        Response.Flush();
        Response.End();
    }

    protected void btnSaeExcel_Click(object sender, EventArgs e)
    {
        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename=VACSReport.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-excel";
        using (StringWriter sw = new StringWriter())
        {
            HtmlTextWriter hw = new HtmlTextWriter(sw);

            //To Export all pages
            GVdetails.AllowPaging = false;
            //BindGV();
            BindGVExport();

            GVdetails.HeaderRow.BackColor = Color.White;
            foreach (TableCell cell in GVdetails.HeaderRow.Cells)
            {
                cell.BackColor = GVdetails.HeaderStyle.BackColor;
            }
            foreach (GridViewRow row in GVdetails.Rows)
            {
                row.BackColor = Color.White;
                foreach (TableCell cell in row.Cells)
                {
                    if (row.RowIndex % 2 == 0)
                    {
                        cell.BackColor = GVdetails.AlternatingRowStyle.BackColor;
                    }
                    else
                    {
                        cell.BackColor = GVdetails.RowStyle.BackColor;
                    }
                    cell.CssClass = "textmode";
                }
            }

            GVdetails.RenderControl(hw);

            //style to format numbers to string
            string style = @"<style> .textmode { } </style>";
            Response.Write(style);
            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();
        }
    }
    public void Clear()
    {
        txtDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
        txtToDate.Text = DateTime.Now.ToString("yyyy-MM-dd");

        txtVehicleNo.Text = string.Empty;
        txtCNIC.Text = string.Empty;
        txtPNo.Text = string.Empty;
        ddlClearanceStatus.SelectedIndex =0;
        ddlDeviceName.SelectedIndex = 0;
        ddlGateLane.SelectedIndex = 0;
        ddlGateNo.SelectedIndex = 0;
        ddlMake.SelectedIndex = 0;
       // ddlVehicleNo.SelectedIndex = 0;
        ddlVehicleType.SelectedIndex = 0;
    }
}