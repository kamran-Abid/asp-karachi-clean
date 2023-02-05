using iTextSharp.text;
using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.Configuration;
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



public partial class RMS_Employees_List : System.Web.UI.Page
{
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
           // txtDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
          //  txtToDate.Text = DateTime.Now.ToString("yyyy-MM-dd");

            DataTable Department = ObjCommon.GetDepartment();

            ddlDepartment.DataSource = Department;
            ddlDepartment.DataValueField = "Department_ID";
            ddlDepartment.DataTextField = "Department_Name";
            ddlDepartment.DataBind();
            ddlDepartment.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));

            DataTable Gender = ObjCommon.Gender();

            ddlGender.DataSource = Gender;
            ddlGender.DataValueField = "ID";
            ddlGender.DataTextField = "GenderName";
            ddlGender.DataBind();
            ddlGender.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));



            DataTable dtRanks = ObjCommon.GetRanks();
            ddlRank.DataSource = dtRanks;
            ddlRank.DataValueField = "Rank_ID";
            ddlRank.DataTextField = "Rank_Name";
            ddlRank.DataBind();
            ddlRank.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));

            DataTable dtDesignation = ObjCommon.GetDesignation();
            ddlDesignation.DataSource = dtDesignation;
            ddlDesignation.DataValueField = "Designation_ID";
            ddlDesignation.DataTextField = "designation_Name";
            ddlDesignation.DataBind();
            ddlDesignation.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));

            


        }
    }
    public void BindGV()
    {


        string Query = " Select ROW_NUMBER() OVER (ORDER BY(SELECT ServiceNo)) AS SR#, FirstName+'     '+LastName as Name ," +
            " Nic, ServiceNo as HRNo, dep.Department_Name as Department ,deg.designation as Appointment , rk.Rank_Name as Rank, " +
             " g.GenderName as Gender from Employee emp" +
            " LEFT JOIN[dbo].[mctx_Department] dep ON dep.Department_ID = emp.Department " +
            " LEFT JOIN[dbo].[HR_Designation] deg ON deg.Designation_ID = emp.Designation " +
            " LEFT JOIN[dbo].[mctx_Ranks] rk ON rk.Rank_ID = emp.[Rank] " +
            " LEFT JOIN[dbo].[Gender] g ON g.ID = emp.Gender " +

                        " where ('" + txtPNo.Text + "'='' or emp.ServiceNo='" + txtPNo.Text + "')" +
                       " and  ('" + txtName.Text + "'='' or emp.FirstName + Emp.LastName like'%" + txtName.Text + "%' )" +

                        " and  ('" + txtCNIC.Text + "'='' or emp.Nic='" + txtCNIC.Text + "' )" +
                        //" and  ('" + txtName.Text + "'='' or emp.FirstName + Emp.LastName like'%" + txtName.Text + "%' )" +

                         " and ('" + ddlRank.SelectedValue + "' = '' or emp.Rank='" + ddlRank.SelectedValue + "')" +
                  " and ('" + ddlDesignation.SelectedValue + "' = '' or emp.Designation='" + ddlDesignation.SelectedValue + "' )" +
                  " and ('" + ddlGender.SelectedValue + "' = '' or emp.Gender = '" + ddlGender.SelectedValue + "')" +

                  " and ('" + ddlDepartment.SelectedValue + "'= '' or emp.Department = '" + ddlDepartment.SelectedValue + "')";
                    
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
        txtCNIC.Text = String.Empty;
        txtName.Text = String.Empty;
        txtPNo.Text = String.Empty;
        //ddlClearanceStatus.SelectedIndex = 0;
        ddlDepartment.SelectedIndex = 0;
        ddlRank.SelectedIndex = 0;


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
    //    string FileName = "Employee Log Report" + DateTime.Now + ".doc";
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