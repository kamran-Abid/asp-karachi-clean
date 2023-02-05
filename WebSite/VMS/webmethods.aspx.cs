using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Runtime.Serialization.Json;
using System.Web.Script.Serialization;

public partial class webmethods : System.Web.UI.Page
{
    static string UserID = "";
    static string CurrentDate = "";

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public static void getUserAndDate()
    {

        CurrentDate = DateTime.Now.ToShortDateString();
        UserID = HttpContext.Current.Profile.GetPropertyValue("FirstName").ToString() + " " + HttpContext.Current.Profile.GetPropertyValue("LastName").ToString();
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

    #region Visitor
    #region Save Visistor
    [WebMethod]
    public static void SaveVisitor(string CNIC, string VISITOR_NAME, string FATHER_NAME, string DOB, string ADDRESS, string TIME_IN, string TIME_OUT, string HOST,
        string VEHICLE_NUMBER, string TOKEN_NUMBER, string DEPARTMENT, string GATE_NUMBER, string NAME, string PHONE_NUMBER, string RESTRICTED, string PICTURE_ID)
    {
        getUserAndDate();

        string query = "INSERT INTO mctx_visitor" +
       "([CNIC],[VISITOR_NAME],[FATHER_NAME],[DOB],[ADDRESS] "+
           ",[DATE],[TIME_IN],[TIME_OUT],[HOST],[VEHICLE_NUMBER],[TOKEN_NUMBER],[DEPARTMENT] "+
           ",[GATE_NUMBER],[NAME],[PHONE_NUMBER],[RESTRICTED],[PICTURE_ID])" +
           "VALUES('" + CNIC + "',N'" + VISITOR_NAME + "',N'" + FATHER_NAME + "','" + DOB + "',N'" + ADDRESS + "','" + CurrentDate + "', '" + TIME_IN + "' " +
       ",'" + TIME_OUT + "','" + HOST + "','" + VEHICLE_NUMBER + "','" + TOKEN_NUMBER + "','" + DEPARTMENT + "', '" + GATE_NUMBER + "','" + NAME + "','" + PHONE_NUMBER + "','" + RESTRICTED + "', '" + PICTURE_ID + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    #endregion

    #region Get  Visitor
    [WebMethod]
    public static Dictionary<string, object> getVisitorDetail()
    {
       
            string Query = "SELECT  [ID],[CNIC],[VISITOR_NAME],[FATHER_NAME],[DOB],[ADDRESS],[DATE],[TIME_IN],[TIME_OUT],[HOST],[VEHICLE_NUMBER]"+
             " ,[TOKEN_NUMBER],[DEPARTMENT],[GATE_NUMBER],[NAME],[PHONE_NUMBER],[RESTRICTED],[PICTURE_ID]  FROM mctx_visitor order by [ID] desc";
            DBManager ObjDBManager = new DBManager();
            DataSet ds = ObjDBManager.SelectQuery(Query, "VisitorDetail", "vmsconnectionstring");
            DataTable dt = new DataTable();
            dt = ds.Tables["VisitorDetail"];
            return ToJson(dt);
        
    }
    #endregion
    #region Delete Visitor
    [WebMethod]
    public static void DeleteVisitor(string ID)
    {
        string query = "DELETE FROM mctx_visitor where [ID]='" + int.Parse(ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion

    #region Get  Visitor Detail by CNIC No
    [WebMethod]
    public static Dictionary<string, object> getResultFromCNIC(string CNIC)
    
    {
      
        string Query = "SELECT top 1  [ID],[CNIC],[VISITOR_NAME],[FATHER_NAME],[DOB],[ADDRESS],[DATE],[TIME_IN],[TIME_OUT],[HOST],[VEHICLE_NUMBER]" +
         " ,[TOKEN_NUMBER],[DEPARTMENT],[GATE_NUMBER],[NAME],[PHONE_NUMBER],[RESTRICTED],LEFT([PICTURE_ID], 15) as FirtstFifteen, RIGHT([PICTURE_ID],4) last4 FROM mctx_visitor where CNIC ='" + CNIC + "' order by [ID] desc";
        
         //   Query += " where CNIC ='" + CNIC + "' ";
        
       // Query += " order by [ID] desc";
        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "VisitorDetailNew", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["VisitorDetailNew"];
        return ToJson(dt);
        
    }
    #endregion

    #endregion

    #region Reports
    #region Get  Visitor by CNIC No
    [WebMethod]
    public static Dictionary<string, object> getCNICWiseReport(string CNIC)
    {
        
        string Query = "SELECT  [ID],[CNIC],[VISITOR_NAME],[FATHER_NAME],[DOB],[ADDRESS],[DATE],[TIME_IN],[TIME_OUT],[HOST],[VEHICLE_NUMBER]" +
         " ,[TOKEN_NUMBER],[DEPARTMENT],[GATE_NUMBER],[NAME],[PHONE_NUMBER],[RESTRICTED],[PICTURE_ID]  FROM mctx_visitor";
         if(CNIC !=null && CNIC != "")
         {
             Query += " where CNIC like'%" + CNIC + "%' ";
         }
        Query += " order by [ID] desc";
        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "VisitorDetail", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["VisitorDetail"];
        return ToJson(dt);

    }
    #endregion

    #region Get  Visitor by Name
    [WebMethod]
    public static Dictionary<string, object> getVisitorNameWiseReport(string VisitorName)
    {

        string Query = "SELECT  [ID],[CNIC],[VISITOR_NAME],[FATHER_NAME],[DOB],[ADDRESS],[DATE],[TIME_IN],[TIME_OUT],[HOST],[VEHICLE_NUMBER]" +
         " ,[TOKEN_NUMBER],[DEPARTMENT],[GATE_NUMBER],[NAME],[PHONE_NUMBER],[RESTRICTED],[PICTURE_ID]  FROM mctx_visitor";
        if (VisitorName != null && VisitorName != "")
        {
            Query += " where NAME like'%" + VisitorName + "%' OR VISITOR_NAME like N'%" + VisitorName + "%'";
        }
        Query += " order by [ID] desc";
        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "VisitorDetail", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["VisitorDetail"];
        return ToJson(dt);

    }
    #endregion


    #region Get  Visitor by Date
    [WebMethod]
    public static Dictionary<string, object> getVisitorDateWiseReport(string FromDate, string ToDate)
    {
       
        string Query = "SELECT  [ID],[CNIC],[VISITOR_NAME],[FATHER_NAME],[DOB],[ADDRESS],[DATE],[TIME_IN],[TIME_OUT],[HOST],[VEHICLE_NUMBER]" +
         " ,[TOKEN_NUMBER],[DEPARTMENT],[GATE_NUMBER],[NAME],[PHONE_NUMBER],[RESTRICTED],[PICTURE_ID]  FROM mctx_visitor";
        if (FromDate != null && FromDate != "")
        {
            DateTime dtFrom = Convert.ToDateTime(FromDate);
            string dtFromOnlyDate = string.Format("{0:M/d/yyyy}", dtFrom);
            DateTime dtTo = Convert.ToDateTime(ToDate);
            string dtToOnlyDate = string.Format("{0:M/d/yyyy}", dtTo);
            Query += " where [Date] between '" + dtFromOnlyDate + "' and '" + dtToOnlyDate + "'";
        }
        Query += " order by [ID] desc";
        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "VisitorDetail", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["VisitorDetail"];
        return ToJson(dt);

    }
    #endregion
    #endregion
}