using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
public partial class Declined_To_Pending : System.Web.UI.Page
{
    //static string userid = "";
    protected void Page_Load(object sender, EventArgs e)
    {
       // userid = Session["User_ID"].ToString();
    }


    public static Dictionary<string, object> ToJson(DataTable table)
    {
        Dictionary<string, object> j = new Dictionary<string, object>();
        j.Add(table.TableName, RowsToDictionary(table));
        return j;
    }

    private static List<Dictionary<string, object>> RowsToDictionary(DataTable table)
    {
        List<Dictionary<string, object>> objs =
            new List<Dictionary<string, object>>();
        foreach (DataRow dr in table.Rows)
        {
            Dictionary<string, object> drow = new Dictionary<string, object>();
            for (int i = 0; i < table.Columns.Count; i++)
            {
                drow.Add(table.Columns[i].ColumnName, dr[i]);
            }
            objs.Add(drow);
        }

        return objs;
    }

    //#region SaveProject
    //[WebMethod]
    //public static void SaveITProject(string ProjName)
    //{
    //    DateTime Date = DateTime.Parse(DateTime.Now.ToShortDateString());
    //    using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ToString()))
    //    {
    //        cn.Open();
    //        string query = "INSERT INTO [Visitor_Tbl]" +
    //       "([Visitor_Name],[CreatedBy],[CreatedDate],[ModifiedBy],[ModifiedDate],[Deleted])" +
    //       "VALUES('" + ProjName + "','" + userid + "','" + Date + "','" + userid + "','" + Date + "','false')";
    //        SqlCommand cmd = new SqlCommand(query, cn);
    //        cmd.ExecuteNonQuery();
    //    }
    //}
    //#endregion

    #region GetProjectDetails
    [WebMethod]
    public static Dictionary<string, object> GetITProjDetails()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ToString()))
        {
            //string Query = @"SELECT [Visitor_Tbl].[Visitor_ID]
            //      ,[Visitor_Tbl].[Visitor_Name]
            //      ,lg.[UserName] CreatedBy
            //      ,convert(varchar, [Visitor_Tbl].[CreatedDate], 103) [CreatedDate]
            //      ,lg1.[UserName] ModifiedBy
            //      ,convert(varchar, [Visitor_Tbl].[CreatedDate], 103) [ModifiedDate]
            //      ,[Visitor_Tbl].[Deleted]
            //  FROM [dbo].[Visitor_Tbl]
            //   inner join [tblLogin] lg on [Visitor_Tbl].CreatedBy=lg.Id 
            //  inner join [tblLogin] lg1 on [Visitor_Tbl].ModifiedBy=lg1.Id Where Deleted='false'";
            //string Query = "SELECT * FROM Visitor_Tbl";
            string Query = @"SELECT [V_ID]
                      ,[Uniq_Code]
                      ,[Full_Name]
                      ,[Father_Name]
                      ,[CNIC]
                      ,[Address]
                      ,convert(varchar, [Dob], 103) DoB
                      ,[Person_To_Visit]
                      ,[Place_To_Visit]
                      ,[Purpose_To_Visit]
                      ,[Status]
                      ,convert(varchar, [DateofVisit], 103) DateofVisit
                      
                      ,[RFID]
                      ,[ImageName]
                      ,[ImageData]
                      ,[imgSize]
                  FROM [dbo].[Visitor_Tbl] vt
                   
                    WHERE Status='Declined' AND Deleted=0";
            SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(ds, "ProjDetails");
            dt = ds.Tables["ProjDetails"];
            return ToJson(dt);
        }
    }
    #endregion

    //#region ApproveVisitor
    //[WebMethod]
    //public static void ApprovedStatus(string Visitor_ID)
    //{
    //    DateTime Date = DateTime.Parse(DateTime.Now.ToShortDateString());
    //    using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ToString()))
    //    {
    //        SqlCommand cmd = new SqlCommand("UPDATE [Visitor_Tbl] SET " +
    //            "[Status] = 'Approved' where [V_ID] = '" + Visitor_ID + "'", cn);
    //        cn.Open();
    //        cmd.ExecuteNonQuery();
    //    }
    //}
    //#endregion



    #region DeclineVisitor
    [WebMethod]
    public static void DeclineStatus(string Visitor_ID)
    {
        DateTime Date = DateTime.Parse(DateTime.Now.ToShortDateString());
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("UPDATE [Visitor_Tbl] SET " +
                "[Status] = 'Pending' where [V_ID] = '" + Visitor_ID + "'", cn);
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }
    #endregion

    #region DeleteVisitor
    [WebMethod]
    public static void DeleteVisitor(string Visitor_ID)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("UPDATE [Visitor_Tbl] SET " +
                "[Deleted] = 1 where [V_ID] = '" + Visitor_ID + "'", cn);
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }
    #endregion
}