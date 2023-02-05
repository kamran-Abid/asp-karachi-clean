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
public partial class RMS_LivePage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection("Data Source = PACS-VACS-2\\SQLEXPRESS; Initial Catalog=NLC_DB;User ID=sa;Password=sa@1234");
        con.Open();
        
        SqlCommand cmd = new SqlCommand("Select  ROW_NUMBER() OVER (ORDER BY(SELECT DATE)) AS SR#, isnull(FirstName,'')+' '+ isnull(LastName,'') as Name , Nic as CNIC , " +
                    " ServiceNo as HRNo#, dep.Department_Name as Department, deg.designation as Appointment, rk.Rank_Name as Rank, " +
                    " gt.Gate_Name as Gate, Convert(varchar(25), TIME_IN, 113) as TimeIn, " +
                    " Convert(varchar(25), convert(DATETime, TIME_OUT), 113) as TimeOut, vl.Remarks, " +
                     " ( CASE WHEN (vl.User_Type = 'mctx_VACS') THEN  vac.VehicleNo ELSE '' END ) as VehicleNo, " +
                     " ( CASE WHEN (vl.User_Type = 'mctx_VACS') THEN  vac.VehicleType  ELSE '' END ) as VehicleType  " +
                     " FROM [mctx_visitorlog] vl " +
                    " LEFT JOIN dbo.mctx_VACS vac ON vac.VehicleNo = vl.VEHICLE_NUMBER " +
                    " LEFT JOIN dbo.Employee emp ON emp.NIC = vl.CNIC " +
                    " LEFT JOIN dbo.mctx_Department dep ON dep.Department_ID = emp.Department " +
                    " LEFT JOIN dbo.HR_Designation deg ON deg.Designation_ID = emp.Designation " +
                    " LEFT JOIN dbo.mctx_Ranks rk ON rk.Rank_ID = emp.[Rank] " +

                   " LEFT JOIN dbo.mctx_Gates gt ON gt.Gate_ID = vl.GATE_NUMBER " +

                   " LEFT JOIN dbo.mctx_Wiegand_Devices wd ON wd.ID = vl.TerminalID " +

                    " Where DATE='" + DateTime.Now.ToString("yyyy-MM-dd") + "' " +
                    " order by TIME_IN DESC ", con);
        SqlDataReader rdr = cmd.ExecuteReader();
        GVdetails1.DataSource = rdr;
        GVdetails1.DataBind();
        con.Close();
    }
    //Common ObjCommon = new Common();
    //private string GridDataQuery
    //{
    //    get
    //    {
    //        var value = ViewState["GridDataQuery"];
    //        return null != value ? (string)value : "";
    //    }
    //    set
    //    {
    //        ViewState["GridDataQuery"] = value;
    //    }
    //}
    //protected void Page_Load(object sender, EventArgs e)
    //{
    //    if (!IsPostBack)
    //    {
           


    //    }
    //}
    //public void BindGV1()
    //{


    //    string Query = " select ROW_NUMBER() OVER (ORDER BY(SELECT 1)) AS SR# , FirstName + '' + LastName as Name , ServiceNo as HRNo# , Nic as CNIC , deg.designation as Appointment , " +
    //        "dep.Department_Name as Department "
    //        + " FROM [mctx_visitorlog] vl  " ;
        
    //    //string Query = QueryFilters + " FROM [mctx_visitorlog] vl  " +

    //    //                " LEFT JOIN [dbo].[Employee] emp ON emp.EID = vl.VID " +
    //    //                " LEFT JOIN [dbo].[mctx_Department] dep ON dep.Department_ID = emp.Department " +
    //    //                " LEFT JOIN [dbo].[HR_Designation] deg ON deg.Designation_ID = emp.Designation " +
    //    //                " LEFT JOIN [dbo].[mctx_Ranks] rk ON rk.Rank_ID = emp.[Rank] " +
    //    //                " LEFT JOIN [dbo].[Gender] g ON g.ID = emp.Gender" +
    //    //                " LEFT JOIN dbo.ClearanceStatus cs ON cs.ID = emp.ClearanceStatus " +
    //    //                " LEFT JOIN [dbo].[mctx_PersonSiteAllowed] psa ON psa.ID = emp.ClearanceLevel" +
    //    //                " LEFT JOIN [dbo].[mctx_Gates] gt ON gt.Gate_ID = vl.GATE_NUMBER" +
    //    //                " LEFT JOIN [dbo].[mctx_Wiegand_Devices] wd ON wd.ID = vl.TerminalID" +
    //    //                " LEFT JOIN [dbo].[mctx_TerminalInfos] ti ON ti.Terminal_ID = wd.Terminal_ID" +
    //    //                " LEFT JOIN [dbo].[Place] p ON p.ID = vl.Gate_Lane";

                        
    //    GridDataQuery = Query;
    //    DataSet ds = ObjCommon.GetEmployeeDetailForGV(Query);

    //    GVdetails1.DataSource = ds;
    //    GVdetails1.DataBind();

    //}
    //public void BindGVExport1()
    //{
    //    DataSet ds = ObjCommon.GetEmployeeDetailForGV(GridDataQuery);

    //    GVdetails1.DataSource = ds;
    //    GVdetails1.DataBind();

    //}
    // End of GVdetails1

    ////Start of GVdetails2
    //public void BindGV2()
    //{


    //    string QueryFilters = " select ROW_NUMBER() OVER (ORDER BY(SELECT 1)) AS SR# , FirstName + '' + LastName as Name , ServiceNo as HRNo# , Nic as CNIC , deg.designation as Appointment , " +
    //        "dep.Department_Name as Department ";

    //    string Query = QueryFilters + " FROM [mctx_visitorlog] vl  " +

    //                    " LEFT JOIN [dbo].[Employee] emp ON emp.EID = vl.VID " +
    //                    " LEFT JOIN [dbo].[mctx_Department] dep ON dep.Department_ID = emp.Department " +
    //                    " LEFT JOIN [dbo].[HR_Designation] deg ON deg.Designation_ID = emp.Designation " +
    //                    " LEFT JOIN [dbo].[mctx_Ranks] rk ON rk.Rank_ID = emp.[Rank] " +
    //                    " LEFT JOIN [dbo].[Gender] g ON g.ID = emp.Gender" +
    //                    " LEFT JOIN dbo.ClearanceStatus cs ON cs.ID = emp.ClearanceStatus " +
    //                    " LEFT JOIN [dbo].[mctx_PersonSiteAllowed] psa ON psa.ID = emp.ClearanceLevel" +
    //                    " LEFT JOIN [dbo].[mctx_Gates] gt ON gt.Gate_ID = vl.GATE_NUMBER" +
    //                    " LEFT JOIN [dbo].[mctx_Wiegand_Devices] wd ON wd.ID = vl.TerminalID" +
    //                    " LEFT JOIN [dbo].[mctx_TerminalInfos] ti ON ti.Terminal_ID = wd.Terminal_ID" +
    //                    " LEFT JOIN [dbo].[Place] p ON p.ID = vl.Gate_Lane";


    //    GridDataQuery = Query;
    //    DataSet ds = ObjCommon.GetEmployeeDetailForGV(Query);

    //    GVdetails2.DataSource = ds;
    //    GVdetails2.DataBind();

    //}
    //public void BindGVExport2()
    //{
    //    DataSet ds = ObjCommon.GetEmployeeDetailForGV(GridDataQuery);

    //    GVdetails2.DataSource = ds;
    //    GVdetails2.DataBind();

    //}

    ////End of GVdetails2
    ////Start of GVdetails3
    //public void BindGV3()
    //{


    //    string QueryFilters = " select ROW_NUMBER() OVER (ORDER BY(SELECT 1)) AS SR# , FirstName + '' + LastName as Name , ServiceNo as HRNo# , Nic as CNIC , deg.designation as Appointment , " +
    //        "dep.Department_Name as Department ";

    //    string Query = QueryFilters + " FROM [mctx_visitorlog] vl  " +

    //                    " LEFT JOIN [dbo].[Employee] emp ON emp.EID = vl.VID " +
    //                    " LEFT JOIN [dbo].[mctx_Department] dep ON dep.Department_ID = emp.Department " +
    //                    " LEFT JOIN [dbo].[HR_Designation] deg ON deg.Designation_ID = emp.Designation " +
    //                    " LEFT JOIN [dbo].[mctx_Ranks] rk ON rk.Rank_ID = emp.[Rank] " +
    //                    " LEFT JOIN [dbo].[Gender] g ON g.ID = emp.Gender" +
    //                    " LEFT JOIN dbo.ClearanceStatus cs ON cs.ID = emp.ClearanceStatus " +
    //                    " LEFT JOIN [dbo].[mctx_PersonSiteAllowed] psa ON psa.ID = emp.ClearanceLevel" +
    //                    " LEFT JOIN [dbo].[mctx_Gates] gt ON gt.Gate_ID = vl.GATE_NUMBER" +
    //                    " LEFT JOIN [dbo].[mctx_Wiegand_Devices] wd ON wd.ID = vl.TerminalID" +
    //                    " LEFT JOIN [dbo].[mctx_TerminalInfos] ti ON ti.Terminal_ID = wd.Terminal_ID" +
    //                    " LEFT JOIN [dbo].[Place] p ON p.ID = vl.Gate_Lane";


    //    GridDataQuery = Query;
    //    DataSet ds = ObjCommon.GetEmployeeDetailForGV(Query);

    //    GVdetails3.DataSource = ds;
    //    GVdetails3.DataBind();

    //}
    //public void BindGVExport3()
    //{
    //    DataSet ds = ObjCommon.GetEmployeeDetailForGV(GridDataQuery);

    //    GVdetails3.DataSource = ds;
    //    GVdetails3.DataBind();

    //}
    ////End of GVdetails3

    //protected void TC_LiveDataPage_ActiveTabChanged(object sender, EventArgs e)
    //{
    //  //if ( "TC_LiveDataPage_ActiveTabChanged  ==  0")
    //  //{
    //            BindGVExport1();
    //            //ClearMMDHOD();
    //            //
    //  //}
        
    //}





    //protected void TC_StoreSetup_ActiveTabChanged(object sender, EventArgs e)
    //{

    //    if ("TC_StoreSetup_ActiveTabChanged == 0 ")
    //    {
    //        BindGV1();
    //        //BindGV();
    //    }
    //    else if ("TC_StoreSetup_ActiveChanged == 1")
    //    {
    //        BindGV2();
    //    }
    //    else if ("TC_StoreSetup_ActiveTabChanged == 2")
    //    {
    //        BindGV3();
    //    }
    //}
}