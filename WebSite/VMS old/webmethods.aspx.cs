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
        UserID = HttpContext.Current.Profile.GetPropertyValue("FirstName").ToString()+" "+HttpContext.Current.Profile.GetPropertyValue("LastName").ToString();//"mctxAdmin";
    }
    #region Save Place
    [WebMethod]
    public static void SavePlace(string HOST_NAME)
    {
        getUserAndDate();
        
        string query = "INSERT INTO [host]" +
       "([HOST_NAME],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
       "VALUES('" + HOST_NAME + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 1 + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    #endregion

    #region Update Place
    [WebMethod]
    public static void UpdatePlace(string ID, string HOST_NAME)
    {
        getUserAndDate();


        
        string query = "UPDATE [host]" +
" SET [HOST_NAME] = '" + HOST_NAME + "',[modified_date] = '" + CurrentDate + "'" +
 " ,[modified_by] = '" + UserID + "' WHERE [ID]='" + ID + "'";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion
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
    #region Get Task Type
    [WebMethod]
    public static Dictionary<string, object> getPlaceDetail()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ToString()))
        {
            string Query = "SELECT [ID],[HOST_NAME],isnull(CONVERT(varchar(20), [created_date],101),'') as created_date" +
            " ,[created_by],isnull(CONVERT(varchar(20), [modified_date],101),'') as modified_date " +
            "  ,[modified_by],[is_deleted]" +
            " FROM [host] where is_deleted=1 order by HOST_NAME ASC";
            SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(ds, "PlaceDetail");
            dt = ds.Tables["PlaceDetail"];
            return ToJson(dt);
        }
    }
    #endregion

    [WebMethod]
    public static void DeletePlace(string ID)
    {

        string query = "update host set is_deleted=0 where ID='" + int.Parse(ID) + "'";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }

    #region Visitor
    #region Save Place
    [WebMethod]
    public static void SaveVisitor(string CNIC, string VISITOR_NAME, string FATHER_NAME, string DOB, string ADDRESS, string TIME_IN, string TIME_OUT, string HOST,
        string VEHICLE_NUMBER, string TOKEN_NUMBER, string DEPARTMENT, string GATE_NUMBER, string NAME, string PHONE_NUMBER, string RESTRICTED, string PICTURE_ID)
    {
        getUserAndDate();

        string query = "INSERT INTO [visitor]" +
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
             " ,[TOKEN_NUMBER],[DEPARTMENT],[GATE_NUMBER],[NAME],[PHONE_NUMBER],[RESTRICTED],[PICTURE_ID]  FROM [visitor] order by [ID] desc";
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
        string query = "DELETE FROM [visitor] where [ID]='" + int.Parse(ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion

    #endregion

}