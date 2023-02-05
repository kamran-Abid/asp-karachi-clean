using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Reposts_GuestReports_HostGuestReports : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ddDateFrom.Text = DateTime.Today.AddDays(-1).ToString("MM/dd/yyyy");
            ddDateTo.Text = DateTime.Today.ToString("MM/dd/yyyy");

            ReportViewer1.Visible = false;
        }
    }
    protected void btnsearch_Click(object sender, EventArgs e)
    {
        DateTime date_Froms = DateTime.ParseExact(ddDateFrom.Text + " 00:00:00.000", "MM/dd/yyyy 00:00:00.000",null);
        DateTime date_to = DateTime.ParseExact(ddDateTo.Text + " 00:00:00.000", "MM/dd/yyyy 00:00:00.000",null);   
        string DateFrom = date_Froms.ToString("yyyy/MM/dd");
        string DateTo = date_to.ToString("yyyy/MM/dd");
        DataTable ResultsTable = new DataTable();
        DataSet ds = new System.Data.DataSet();
        DBManager db_Manager = new DBManager();

        try
        {
            db_Manager.AddParameterReport("@Name", txtEmpName.Text);
            db_Manager.AddParameterReport("@CNIC", txtEmpCNIC.Text);
            //db_Manager.AddParameterReport("@Designation",txtDesigation.Text); 
            //db_Manager.AddParameterReport("@Department",txtDepartment.Text); 
            //db_Manager.AddParameterReport("@txtEMPID" ,txtEMPID.Text); 
            //db_Manager.AddParameterReport("@txtServiceNumber", txtServiceNumber.Text);
            db_Manager.AddParameterReport("@ToDate", DateTo);
            db_Manager.AddParameterReport("@FromDate", DateFrom);
            ds = db_Manager.ExecuteDataSet("Employee_Report", "vmsconnectionstring");
            ReportViewer1.Visible = true;                                             
            ReportDataSource rds = new ReportDataSource("GuestHostDataSet", ds.Tables[0]);
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.DataSources.Add(rds);
        }
        catch (Exception ex)
        {

        }
        //gridview call
    }
    #region----Get Employee AutoComplete
    [WebMethod]

    public static List<string> GetEmployeeNames(string term)
    {
        List<string> listCountryName = new List<string>();
        string CS = ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ConnectionString;
        using (SqlConnection con = new SqlConnection(CS))
        {
            SqlCommand cmd = new SqlCommand("GetEmployeeName_SP", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter parameter = new SqlParameter()
            {
                ParameterName = "@NameAuto",
                Value = term
            };
            cmd.Parameters.Add(parameter);
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                listCountryName.Add(rdr["emp_Names"].ToString());
            }
            con.Close();
            return listCountryName;
        }
    }
    #endregion

    //GridView function for Visitor GridView//

    //    public static List<string> VisitorGridView(string NAME, string FATHER_NAME, string CNIC, DateTime DATE, DateTime TIME_IN, DateTime TIME_OUT, int Status, string Visit_Purpose, DateTime validitDate)

    //    {
    //        List<string> VisitorGridview = new List<string>();

    //        string CS = ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ConnectionString;
    //        using (SqlConnection con = new SqlConnection(CS))
    //        {
    //            SqlCommand cmd = new SqlConnection("Employee_Reportt", con);
    //            cmd.CommandType = CommandType.StoredProcedure;

    //            SqlParameter parameter = new SqlParameter()
    //            {
    //                ParameterName = "@CNIC",
    //                Value = string;

    //            ParameterName = "@NAME",
    //                Value = string;

    //            ParameterName = "@ServiceNo",
    //                Value = int;

    //        };
    //        cmd.Parameters.Add(parameter);
    //        con.Open();
    //        SqlDataReader rdr = cmd.ExecuteReader();
    //        while (rdr.Read())
    //        {
    //            VisitorGridview.Add(rdr["EID"].ToString());
    //        }
    //        con.Close();
    //        return VisitorGridview;
    //    }
    //}




    //function for getting Employees Service Number from Employees Table
    //Updated by UMAIR Khan
    //public static List<string> GetEmpServiceNo(string term)
    //{
    //    List<string> listCountryName = new List<string>();
    //    string CS = ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ConnectionString;
    //    using (SqlConnection con = new SqlConnection(CS))
    //    {
    //        SqlCommand cmd = new SqlCommand("GetEmpServiceNo_SP", con);
    //        cmd.CommandType = CommandType.StoredProcedure;

    //        SqlParameter parameter = new SqlParameter()
    //        {
    //            ParameterName = "@ServiceNoAuto",
    //            Value = term
    //        };
    //        cmd.Parameters.Add(parameter);
    //        con.Open();
    //        SqlDataReader rdr = cmd.ExecuteReader();
    //        while (rdr.Read())
    //        {
    //            listCountryName.Add(rdr["ServiceNo"].ToString());
    //        }
    //        con.Close();
    //        return listCountryName;
    //    }
    //}


    #region AutoComplet Employee CNIC
    [WebMethod]
    public static List<string> GetEmployeeCNIC(string term)
    {
        List<string> listCountryName = new List<string>();
        string CS = ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ConnectionString;
        using (SqlConnection con = new SqlConnection(CS))
        {
            SqlCommand cmd = new SqlCommand("GetEmployeeCNIC_SP", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter parameter = new SqlParameter()
            {
                ParameterName = "@CNICAuto",
                Value = term
            };
            cmd.Parameters.Add(parameter);
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                listCountryName.Add(rdr["Nic"].ToString());
            }
            con.Close();
            return listCountryName;
        }
    }
    #endregion
  
}