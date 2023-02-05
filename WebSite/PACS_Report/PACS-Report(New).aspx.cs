//ususing System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Web;
//using System.Web.UI;
//using System.Web.UI.WebControls;
//using System.Data;
//using System.IO;
//using System.Web.Services;
//using iTextSharp.text;
//using iTextSharp.text.pdf;
//using iTextSharp.text.html.simpleparser;
//using System.Drawing;

//public partial class PACS_Report_PACS_Report_New_ : Syestem.Web.UI
//{

//    Common ObjCommon = new Common();

//    protected void Page_Load(object sender, EventArgs e)
//    {

//        if (!IsPostBack)
//        {

//            DataTable dtVehicleType = ObjCommon.GetVehicleType();

//            ddlVehicleType.DataSource = dtVehicleType;
//            ddlVehicleType.DataValueField = "VACS_ID";
//            ddlVehicleType.DataTextField = "VehicelType";
//            ddlVehicleType.DataBind();
//            ddlVehicleType.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));

//            DataTable dtVehicelNo = ObjCommon.GetVehicleNo();
//            ddlVehicleNo.DataSource = dtVehicelNo;
//            ddlVehicleNo.DataValueField = "VACS_ID";
//            ddlVehicleNo.DataTextField = "VehicelNo";
//            ddlVehicleNo.DataBind();
//            ddlVehicleNo.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));

//            //DataTable dtRanks = ObjCommon.GetRanks();
//            //ddlRank.DataSource = dtRanks;
//            //ddlRank.DataValueField = "Rank_ID";
//            //ddlRank.DataTextField = "Rank_Name";
//            //ddlRank.DataBind();
//            //ddlRank.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));

//            DataTable dtMake = ObjCommon.win_LoadTransportMake();
//            ddlMake.DataSource = dtMake;
//            ddlMake.DataValueField = "id";
//            ddlMake.DataTextField = "TransportMake";
//            ddlMake.DataBind();
//            ddlMake.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));

//            DataTable dtGateLane = ObjCommon.GetGateLane();
//            ddlGateLane.DataSource = dtGateLane;
//            ddlGateLane.DataValueField = "ID";
//            ddlGateLane.DataTextField = "LocationName";
//            ddlGateLane.DataBind();
//            ddlGateLane.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));

//            //DataTable dtGateNo = ObjCommon.GetGateNo();
//            //ddlGateNo.DataSource = dtGateNo;
//            //ddlGateNo.DataValueField = "Gate_ID";
//            //ddlGateNo.DataTextField = "Gate_Name";
//            //ddlGateNo.DataBind();
//            //ddlGateNo.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));


//            DataTable dtGateName = ObjCommon.GetGateNo();
//            ddlGateNo.DataSource = dtGateName;
//            ddlGateNo.DataValueField = "Gate_ID";
//            ddlGateNo.DataTextField = "Gate_Name";
//            ddlGateNo.DataBind();
//            ddlGateNo.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));

//            DataTable dtDeviceName = ObjCommon.NewGetDeviceName();
//            ddlDeviceName.DataSource = dtDeviceName;
//            ddlDeviceName.DataValueField = "Terminal_ID";
//            ddlDeviceName.DataTextField = "TerminalName";
//            ddlDeviceName.DataBind();
//            ddlDeviceName.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));


//        }
//    }
//    public void BindGV()
//    {


//        string QueryFilters = " select DATE as Date, ServiceNo as PNo, FirstName  +  LastName as Name , Nic as CNIC, gt.Gate_Name as GateName, TIME_IN as TimeIn, TIME_OUT as TimeOut ";
//        if (chkbxFatherName.Checked)
//            QueryFilters += ",emp.FatherName as FatherName ";
//        // if (chkbxDate.Checked)
//        //    QueryFilters += ", DATE  ";
//        if (chkbxDepartment.Checked)
//            QueryFilters += ", dep.Department_Name as Department";
//        if (chkbxDesignation.Checked)
//            QueryFilters += ",deg.designation as Designation ";
//        if (chkbxRank.Checked)
//            QueryFilters += ",rk.Rank_Name as Rank ";
//        if (chkbxGender.Checked)
//            QueryFilters += ",g.GenderName  as Gender";
//        if (chkbxSiteName.Checked)
//            QueryFilters += ",psa.Site_Name as Site";
//        if (chkbxValidUpto.Checked)
//            QueryFilters += ", emp.ValidUpto as ExpairayDate ";
//        if (chkbxVehicleNo.Checked)
//            QueryFilters += ", VEHICLE_NUMBER as VehicleNo";
//        //if (chkbxGateName.Checked)
//        //    QueryFilters += ",gt.Gate_Name as GateName ";
//        //if (chkbxGateNo.Checked)
//        //    QueryFilters += ",vl.GATE_NUMBER";
//        if (chkbxGateLane.Checked)
//            QueryFilters += ",Gate_Lane as GateLane";
//        if (chkbxDeviceName.Checked)
//            QueryFilters += ",p.LocationName";
//        //if (chkbxUserType.Checked)
//        //    QueryFilters += ",User_Type ";
//        if (chkbxTerminalName.Checked)
//            QueryFilters += ",ti.TerminalName ";
//        if (chkbxRemarks.Checked)
//            QueryFilters += ",Remarks  ";
//        //if (chkbxTimeIn.Checked)
//        //    QueryFilters += ",TIME_IN ";
//        //if (chkbxTimeOut.Checked)
//        //    QueryFilters += ",TIME_OUT ";
//        string Query = QueryFilters + " FROM [mctx_visitorlog] vl  " +

//                        " LEFT JOIN [dbo].[Employee] emp ON emp.EID = vl.VID " +
//                        " LEFT JOIN [dbo].[mctx_Department] dep ON dep.Department_ID = emp.Department " +
//                        " LEFT JOIN [dbo].[HR_Designation] deg ON deg.Designation_ID = emp.Designation " +
//                        " LEFT JOIN [dbo].[mctx_Ranks] rk ON rk.Rank_ID = emp.[Rank] " +
//                        " LEFT JOIN [dbo].[Gender] g ON g.ID = emp.Gender" +
//                        " LEFT JOIN [dbo].[mctx_PersonSiteAllowed] psa ON psa.ID = emp.ClearanceLevel" +
//                        " LEFT JOIN [dbo].[mctx_Gates] gt ON gt.Gate_ID = vl.GATE_NUMBER" +
//                        " LEFT JOIN [dbo].[mctx_Wiegand_Devices] wd ON wd.ID = vl.TerminalID" +
//                        " LEFT JOIN [dbo].[mctx_TerminalInfos] ti ON ti.Terminal_ID = wd.Terminal_ID" +
//                        " LEFT JOIN [dbo].[Place] p ON p.ID = vl.Gate_Lane" +

//                        //" User_Type = 'Employee'" + 
//                        " where ('" + txtPNo.Text + "'='' or emp.ServiceNo='" + txtPNo.Text + "')" +
//                        " and  ('" + txtCNIC.Text + "'='' or emp.Nic='" + txtCNIC.Text + "' )" +

//                         // " and  ('" + txtDate.Text + "'='' or vl.DATE='" + txtDate.Text + "' AND  '" + txtToDate.Text + "'='' or vl.DATE='" + txtToDate.Text + "' )" +
//                         " and ('" + ddlRank.SelectedValue + "' = '' or emp.Rank='" + ddlRank.SelectedValue + "')" +
//                  " and ('" + ddlDesignation.SelectedValue + "' = '' or emp.Designation='" + ddlDesignation.SelectedValue + "' )" +
//                  " and ('" + ddlDepartment.SelectedValue + "'= '' or emp.Department = '" + ddlDepartment.SelectedValue + "')" +
//                  //" and ('" + ddlGender.SelectedValue + "' = '' or emp.Gender = '" + ddlGender.SelectedValue + "')" +
//                  " and ('" + ddlGateNo.SelectedValue + "' = '' or vl.GATE_NUMBER = '" + ddlGateNo.SelectedValue + "')" +
//                  " and ('" + ddlGateLane.SelectedValue + "' = '' or vl.Gate_Lane = '" + ddlGateLane.SelectedValue + "')" +
//                  " and ('" + ddlDeviceName.SelectedValue + "' = '' or wd.Terminal_ID= '" + ddlDeviceName.SelectedValue + "')" +
//                  // " and (vl.[Date]>= '" + txtDate + "') AND  (vl.[Date] <= '" + txtToDate + "') "  ;
//                  " and  (convert(varchar(25), vl.[Date], 121) >= '" + txtDate.Text + "' and convert(varchar(25), vl.[Date], 121) <= '" + txtToDate.Text + "') ";

//        DataSet ds = ObjCommon.GetEmployeeDetailForGV(Query);

//        GVdetails.DataSource = ds;
//        GVdetails.DataBind();

//    }

//    protected void btnSaveResident_Click(object sender, EventArgs e)
//    {
//        BindGV();
//        //ClearAll();

//    }

//    protected void Button1_Click(object sender, EventArgs e)
//    {
//        //  ExportGridToPDF();

//        CreatePF();
//    }
//    public override void VerifyRenderingInServerForm(Control control)
//    {
//        //required to avoid the runtime error "  
//        //Control 'GridView1' of type 'GridView' must be placed inside a form tag with runat=server."  
//    }

//    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
//    {
//        GVdetails.PageIndex = e.NewPageIndex;
//        //  this.BindGrid();
//        BindGV();
//    }
//    private void ExportGridToPDF()
//    {
//        int columnsCount = GVdetails.HeaderRow.Cells.Count;
//        PdfPTable pdfTable = new PdfPTable(columnsCount);
//        foreach (TableCell gridViewHeaderCell in GVdetails.HeaderRow.Cells)
//        {
//            iTextSharp.text.Font font = new iTextSharp.text.Font();
//            font.Color = new BaseColor(GVdetails.HeaderStyle.ForeColor);
//            PdfPCell pdfCell = new PdfPCell(new Phrase(gridViewHeaderCell.Text, font));
//            pdfCell.BackgroundColor = new BaseColor(GVdetails.HeaderStyle.BackColor);
//            pdfTable.AddCell(pdfCell);
//        }
//        foreach (GridViewRow gridViewRow in GVdetails.Rows)
//        {
//            if (gridViewRow.RowType == DataControlRowType.DataRow)
//            {
//                foreach (TableCell gridViewCell in gridViewRow.Cells)
//                {
//                    iTextSharp.text.Font font = new iTextSharp.text.Font();
//                    font.Color = new BaseColor(GVdetails.RowStyle.ForeColor);
//                    PdfPCell pdfCell = new PdfPCell(new Phrase(gridViewCell.Text, font));
//                    pdfCell.BackgroundColor = new BaseColor(GVdetails.RowStyle.BackColor);
//                    pdfTable.AddCell(pdfCell);
//                }
//            }
//            Document pdfDocument = new Document(PageSize.A4);
//            PdfWriter.GetInstance(pdfDocument, Response.OutputStream);
//            pdfDocument.Open();
//            pdfDocument.Add(pdfTable);
//            pdfDocument.Close();
//            Response.ContentType = "application/pdf";
//            Response.AppendHeader("content-disposition",
//                "attachment;filename=Employees.pdf");
//            Response.Write(pdfDocument);
//            Response.Flush();
//            Response.End();
//        }
//    }
//    public void CreatePF()
//    {


//        int columnsCount = GVdetails.HeaderRow.Cells.Count;

//        PdfPTable pdfTable = new PdfPTable(columnsCount);
//        GVdetails.AllowPaging = false;
//        BindGV();
//        //GVdetails.DataBind();

//        foreach (TableCell gridViewHeaderCell in GVdetails.HeaderRow.Cells)
//        {

//            iTextSharp.text.Font font = new iTextSharp.text.Font();

//            font.Color = new BaseColor(GVdetails.HeaderStyle.ForeColor);
//            font.Size = 8;
//            PdfPCell pdfCell = new PdfPCell(new Phrase(gridViewHeaderCell.Text, font));

//            pdfCell.BackgroundColor = new BaseColor(GVdetails.HeaderStyle.BackColor);

//            pdfTable.AddCell(pdfCell);
//        }

//        foreach (GridViewRow gridViewRow in GVdetails.Rows)
//        {
//            if (gridViewRow.RowType == DataControlRowType.DataRow)
//            {

//                foreach (TableCell gridViewCell in gridViewRow.Cells)
//                {
//                    iTextSharp.text.Font font = new iTextSharp.text.Font();
//                    font.Color = new BaseColor(GVdetails.RowStyle.ForeColor);
//                    font.Size = 8;
//                    PdfPCell pdfCell = new PdfPCell(new Phrase(gridViewCell.Text, font));

//                    pdfCell.BackgroundColor = new BaseColor(GVdetails.RowStyle.BackColor);

//                    pdfTable.AddCell(pdfCell);

//                }
//            }
//        }

//        Document pdfDocument = new Document(PageSize.A4, -10f, -10f, 0f, -10f);

//        PdfWriter.GetInstance(pdfDocument, Response.OutputStream);

//        pdfDocument.Open();
//        pdfDocument.Add(pdfTable);
//        pdfDocument.Close();

//        Response.ContentType = "application/pdf";
//        Response.AppendHeader("content-disposition",
//            "attachment;filename=Employees.pdf");
//        Response.Write(pdfDocument);
//        Response.Flush();
//        Response.End();
//    }

//    protected void btnSaeExcel_Click(object sender, EventArgs e)
//    {
//        Response.Clear();
//        Response.Buffer = true;
//        Response.AddHeader("content-disposition", "attachment;filename=Employees.xls");
//        Response.Charset = "";
//        Response.ContentType = "application/vnd.ms-excel";
//        using (StringWriter sw = new StringWriter())
//        {
//            HtmlTextWriter hw = new HtmlTextWriter(sw);

//            //To Export all pages
//            GVdetails.AllowPaging = false;
//            BindGV();

//            GVdetails.HeaderRow.BackColor = Color.White;
//            foreach (TableCell cell in GVdetails.HeaderRow.Cells)
//            {
//                cell.BackColor = GVdetails.HeaderStyle.BackColor;
//            }
//            foreach (GridViewRow row in GVdetails.Rows)
//            {
//                row.BackColor = Color.White;
//                foreach (TableCell cell in row.Cells)
//                {
//                    if (row.RowIndex % 2 == 0)
//                    {
//                        cell.BackColor = GVdetails.AlternatingRowStyle.BackColor;
//                    }
//                    else
//                    {
//                        cell.BackColor = GVdetails.RowStyle.BackColor;
//                    }
//                    cell.CssClass = "textmode";
//                }
//            }

//            GVdetails.RenderControl(hw);

//            //style to format numbers to string
//            string style = @"<style> .textmode { } </style>";
//            Response.Write(style);
//            Response.Output.Write(sw.ToString());
//            Response.Flush();
//            Response.End();
//        }
//    }
//}