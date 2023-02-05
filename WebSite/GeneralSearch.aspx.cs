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

public partial class GeneralSearch : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
    }


    public static Dictionary<string, object> ToJson(DataTable table)
    {
        if(table!=null){
        Dictionary<string, object> j = new Dictionary<string, object>();
        j.Add(table.TableName, RowsToDictionary(table));
        return j;
        }
        else
        {
            Dictionary<string, object> j = null;
            return j;
        }
        
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
    public static Dictionary<string, object> getPersonRecord(string CNIC, string CardNo)
     {
         DataSet ds = null;
        DBManager ObjDBManager = new DBManager();
       
       
        if (CNIC != ""){
            ObjDBManager.AddParameter("CNIC", CNIC);
            ds = ObjDBManager.ExecuteDataSet("GetPersonInfoFromDifferentTables", "vmsconnectionstring"); 
        }

        else
        {
            ObjDBManager.AddParameter("CardNo", CardNo);
            ds = ObjDBManager.ExecuteDataSet("GetPersonInfoFromDifferentTablesUsingCardNumber", "vmsconnectionstring"); 
        }
           
        DataTable dt = new DataTable();
     
        dt = ds.Tables[0];
        if (dt.Rows.Count < 1)
        {
            dt = null;
        }
        return ToJson(dt);
    }

}