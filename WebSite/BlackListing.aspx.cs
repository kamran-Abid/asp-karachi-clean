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

public partial class BlackListing : System.Web.UI.Page
{
    static string UserID = "";
    static string CurrentDate = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        //CurrentDate = DateTime.Now.ToShortDateString();
        //UserID = "mctxAdmin";
    }

    public static void getUserAndDate()
    {

        CurrentDate = DateTime.Now.ToShortDateString();
        UserID = HttpContext.Current.Profile.GetPropertyValue("FirstName").ToString() + " " + HttpContext.Current.Profile.GetPropertyValue("LastName").ToString();//"mctxAdmin";
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
    [WebMethod]
    public static Dictionary<string, object> SeachBlackListingDetail(string PersonType)
    {
       
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.AddParameter("PersonType", PersonType);
      
        DataSet ds = null;

        ds = ObjDBManager.ExecuteDataSet("GetBlackListingInfo", "vmsconnectionstring");

        DataTable dt = new DataTable();
        dt = ds.Tables[0];
        if (dt.Rows.Count > 0)

            return ToJson(dt);
        else
        {
            //dt = null;
            //return ToJson(dt);
            return null;
        }

    }

    [WebMethod]
    public static void InsertUpdateBlackListing(string BlackListingID, string BlackListComments, string PersonType, string PersonID)
    {
        getUserAndDate();
        if (BlackListingID == "0") {
            string query = "INSERT INTO [mctx_PersonBlackListing]" +
      "([BlackListing_comments],[Person_TableName],[Person_ID],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
      "VALUES('" + BlackListComments + "','" + PersonType + "','" + PersonID + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
        }
        else
        {
            string query = "UPDATE [mctx_PersonBlackListing]" +
            " SET [BlackListing_comments] = '" + BlackListComments + "',[modified_date] = '" + CurrentDate + "'" +
             " ,[modified_by] = '" + UserID + "' WHERE [BlackListing_ID]='" + BlackListingID + "'";
            DBManager ObjDBManager = new DBManager();
            ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

        }
    }
   
}