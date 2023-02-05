using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html.simpleparser;
using System.Drawing;

public partial class EmployeeDetailReport : System.Web.UI.Page
{
    Common ObjCommon = new Common();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            DataTable ClearanceStatus = ObjCommon.ClearanceStatus();

            ddlclearanceStatus.DataSource = ClearanceStatus;
            ddlclearanceStatus.DataValueField = "ID";
            ddlclearanceStatus.DataTextField = "ClearanceStatusName";
            ddlclearanceStatus.DataBind();
            ddlclearanceStatus.Items.Insert(0, new System.Web.UI.WebControls.ListItem("ALL", ""));

            DataTable Gender = ObjCommon.Gender();

            ddlGender.DataSource = Gender;
            ddlGender.DataValueField = "ID";
            ddlGender.DataTextField = "GenderName";
            ddlGender.DataBind();
            ddlGender.Items.Insert(0, new System.Web.UI.WebControls.ListItem("ALL", ""));

            DataTable dtRanks = ObjCommon.GetRanks();
            ddlRank.DataSource = dtRanks;
            ddlRank.DataValueField = "Rank_ID";
            ddlRank.DataTextField = "Rank_Name";
            ddlRank.DataBind();
            ddlRank.Items.Insert(0, new System.Web.UI.WebControls.ListItem("ALL", ""));

            //DataTable dtDesignation = ObjCommon.GetDesignation();
            //ddlDesignation.DataSource = dtDesignation;
            //ddlDesignation.DataValueField = "Designation_ID";
            //ddlDesignation.DataTextField = "designation_Name";
            //ddlDesignation.DataBind();
            //ddlDesignation.Items.Insert(0, new System.Web.UI.WebControls.ListItem("ALL", ""));

            DataTable dtSiteAllowed = ObjCommon.GetSiteAllowed();
            ddlSiteAllowed.DataSource = dtSiteAllowed;
            ddlSiteAllowed.DataValueField = "ID";
            ddlSiteAllowed.DataTextField = "Site_Name";
            ddlSiteAllowed.DataBind();
            ddlSiteAllowed.Items.Insert(0, new System.Web.UI.WebControls.ListItem("ALL", ""));

            DataTable dtTransport = ObjCommon.GetTransport();
            ddlTransport.DataSource = dtTransport;
            ddlTransport.DataValueField = "Transport_ID";
            ddlTransport.DataTextField = "Transport_Name";
            ddlTransport.DataBind();
            ddlTransport.Items.Insert(0, new System.Web.UI.WebControls.ListItem("ALL", ""));

            DataTable dtResidantStatus = ObjCommon.GetResidantStatus();
            ddlResidant.DataSource = dtResidantStatus;
            ddlResidant.DataValueField = "ID";
            ddlResidant.DataTextField = "Rasidant_Status_Name";
            ddlResidant.DataBind();
            ddlResidant.Items.Insert(0, new System.Web.UI.WebControls.ListItem("ALL", ""));

            DataTable dtCadre = ObjCommon.GetCadre();
            ddlCadre.DataSource = dtCadre;
            ddlCadre.DataValueField = "ID";
            ddlCadre.DataTextField = "Cadre_Name";
            ddlCadre.DataBind();
            ddlCadre.Items.Insert(0, new System.Web.UI.WebControls.ListItem("ALL", ""));
        }
    }

    public void BindGV() {

        string QueryFilters = " select FirstName + ' ' + LastName Name ,FatherName,MotherName ";
        if (chkbxPn.Checked)
            QueryFilters += ",ServiceNo ";
        if (chkbxCNIC.Checked)
            QueryFilters += ", Nic  ";
        if (chkbxPhoneHome.Checked)
            QueryFilters += ", PhoneHome ";
        if (chkbxPhoneOffice.Checked)
            QueryFilters += ",PhoneOffice  ";
        if (chkbxMobile.Checked)
            QueryFilters += ",Mobile ";
        if (chkbxDob.Checked)
            QueryFilters += ",Dob ";
        string Query = QueryFilters + " from employee emp " +

                           " inner join HR_Designation desg on desg.Designation_ID = emp.Designation" +
                           " inner join mctx_Department dept on dept.Department_ID = emp.Department" +
                           " inner join Gender gen on gen.ID = emp.Gender " +
                           " inner join BloodGroup BG on BG.ID = emp.BloodGroup" +
                           " inner join mctx_Cadre ca on ca.ID = emp.Cadre" +
                           " inner join CardColor cc on cc.CardColor_ID = emp.CardColor" +
                           " inner join mctx_Rasidant_Status RS on RS.ID = emp.ResidantStatus" +
                           " inner join KRL_Transport TR on TR.Transport_ID = emp.Transport" +
                           " inner join Section sec on sec.ID = emp.Section" +
                           " inner join ClearanceStatus CS on CS.ID = emp.ClearanceStatus" +
                           " inner join mctx_PersonSiteAllowed psa on psa.ID = emp.ClearanceLevel" +
                            " where ('" + txtPNO.Text + "'='' or emp.ServiceNo='" + txtPNO.Text + "')" +
                                    " and ('" + ddlRank.SelectedValue + "' = '' or emp.Rank='" + ddlRank.SelectedValue + "')" +
                                    " and ('" + ddlDesignation.SelectedValue + "' = '' or emp.Designation='" + ddlDesignation.SelectedValue + "' )" +
                                    " and ('" + ddlclearanceStatus.SelectedValue + "'= '' or emp.ClearanceStatus = '" + ddlclearanceStatus.SelectedValue + "')" +
                                    " and ('" + ddlGender.SelectedValue + "' = '' or emp.Gender = '" + ddlGender.SelectedValue + "')" +
                                    " and ('" + ddlResidant.SelectedValue + "' = '' or emp.ResidantStatus = '" + ddlResidant.SelectedValue + "')" +
                                    " and ('" + ddlCadre.SelectedValue + "' = '' or emp.Cadre = '" + ddlCadre.SelectedValue + "')" +
                                    " and ('" + ddlTransport.SelectedValue + "' = '' or emp.Transport='" + ddlTransport.SelectedValue + "')" +
                                    " and ('" + ddlSiteAllowed.SelectedValue + "'= '' or emp.ClearanceLevel = '" + ddlSiteAllowed.SelectedValue + "')";
        DataSet ds = ObjCommon.GetEmployeeDetailForGV(Query);

        GVdetails.DataSource = ds;
        GVdetails.DataBind();

    }

    protected void btnSaveResident_Click(object sender, EventArgs e)
    {
        BindGV();
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


}