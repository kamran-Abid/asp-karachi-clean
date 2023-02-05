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

public partial class CardIssueOrReturn : System.Web.UI.Page
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
    public static Dictionary<string, object> SearchPerson(string PersonType,string cnic, string cardNo)
    {
       
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.AddParameter("@PersonType", PersonType);
        if (cnic != "")
            ObjDBManager.AddParameter("@cnin", cnic);

        if (cardNo != "")
            ObjDBManager.AddParameter("@CardNo", cardNo);


      
     
      
      
        DataSet ds = null;

        ds = ObjDBManager.ExecuteDataSet("GetPersonForIssueOrReturnCard", "vmsconnectionstring");

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
    public static Dictionary<string, object> SearchPersonCardHistory(string PersonType, string cnic, string cardNo)
    {

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.AddParameter("@PersonType", PersonType);
        if (cnic != "")
            ObjDBManager.AddParameter("@cnin", cnic);

        if (cardNo != "")
            ObjDBManager.AddParameter("@CardNo", cardNo);






        DataSet ds = null;

        ds = ObjDBManager.ExecuteDataSet("GetPersonForIssueOrReturnCardHistory", "vmsconnectionstring");

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
    public static void InsertUpdatePersonCard(string PID, string Date, string PersonType, string CardTypeID, string CardTypeName, string card_issueOrReturn_id)
    {
        getUserAndDate();
        if (card_issueOrReturn_id == "")
        {
            string query = "INSERT INTO [mctx_CardIssueOrReturn]" +
      "([PID],[Date],[Person_Type],[Type_id],[Type_Name],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
      "VALUES('" + PID + "','" + Date + "','" + PersonType + "','" + CardTypeID + "','" + CardTypeName + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
        }
        else
        {
            string query = "UPDATE [mctx_CardIssueOrReturn]" +
            " SET [Date] = '" + Date + "',[Type_id] = '" + CardTypeID + "',[Type_Name] = '" + CardTypeName + "',[modified_date] = '" + CurrentDate + "'" +
             " ,[modified_by] = '" + UserID + "' WHERE [card_issueOrReturn_id]='" + card_issueOrReturn_id + "'";
            DBManager ObjDBManager = new DBManager();
            ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

        }


        string query2 = "INSERT INTO [mctx_CardIssueOrReturn_History]" +
      "([PID],[Date],[Person_Type],[Type_id],[Type_Name],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
      "VALUES('" + PID + "','" + Date + "','" + PersonType + "','" + CardTypeID + "','" + CardTypeName + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "' )";

        DBManager ObjDBManager2 = new DBManager();
        ObjDBManager2.InsertUpdateQuery(query2, "vmsconnectionstring");

    }
   
}