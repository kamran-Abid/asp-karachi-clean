using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;
using System.Drawing;
using System.IO;

public partial class LoggingReport_EmployeeLogging : System.Web.UI.Page
{
    Common ObjCommon = new Common();
    protected void Page_Load(object sender, EventArgs e)
    {


    }

    public void BindGV()
    {



        string Query = "select El.Employee_Id , El.ServiceNo , EL.FirstName + ' ' + EL.LastName  Name ,Ra.Rank_Name[RankName] , Nic CNIC, convert(varchar, ValidUpto, 11) ValidUpto " +
        " , dept.Department_Name  , desg.designation , cad.Cadre_Name , trans.Transport_Name , PS.Site_Name , CS.ClearanceStatusName, us.firstname + ' ' + us.lastname ModifyBy " +
        " , convert(varchar, El.ModifyDate, 11)  modified_date from employeeLog EL " +

        " inner join mctx_Department dept on dept.Department_ID = EL.Department " +
        " inner join HR_Designation desg on desg.Designation_ID = El.designation " +
        " inner join mctx_cadre cad on cad.ID = EL.Cadre " +
        " inner join KRL_Transport trans on trans.Transport_ID = EL.Transport " +
        " inner join  mctx_Ranks Ra on Ra.Rank_ID = El.Rank " +
        " inner join mctx_PersonSiteAllowed PS on PS.ID = EL.ClearanceStatus " +
        " inner join ClearanceStatus CS on CS.ID = EL.ClearanceLevel " +
        " inner join users us on us.userid = El.ModifyBy " +

        "where EL.Employee_Id = "+txtLoggingUniqueID.Text+"";
        DataSet ds = ObjCommon.GetEmployeeDetailForGV(Query);

        GVdetails.DataSource = ds;
        GVdetails.DataBind();

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        //  ExportGridToPDF();

        CreatePF();
    }
    public void CreatePF()
    {


        int columnsCount = GVdetails.HeaderRow.Cells.Count;

        PdfPTable pdfTable = new PdfPTable(columnsCount);
        GVdetails.AllowPaging = false;
        BindGV();
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

        foreach (GridViewRow gridViewRow in GVdetails.Rows)
        {
            if (gridViewRow.RowType == DataControlRowType.DataRow)
            {

                foreach (TableCell gridViewCell in gridViewRow.Cells)
                {
                    iTextSharp.text.Font font = new iTextSharp.text.Font();
                    font.Color = new BaseColor(GVdetails.RowStyle.ForeColor);
                    font.Size = 8;
                    PdfPCell pdfCell = new PdfPCell(new Phrase(gridViewCell.Text, font));

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
            "attachment;filename=Employees.pdf");
        Response.Write(pdfDocument);
        Response.Flush();
        Response.End();
    }
    protected void btnSaeExcel_Click(object sender, EventArgs e)
    {
        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename=Employees.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-excel";
        using (StringWriter sw = new StringWriter())
        {
            HtmlTextWriter hw = new HtmlTextWriter(sw);

            //To Export all pages
            GVdetails.AllowPaging = false;
            BindGV();

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

    protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GVdetails.PageIndex = e.NewPageIndex;
        //  this.BindGrid();
        BindGV();
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindGV();
    }
}