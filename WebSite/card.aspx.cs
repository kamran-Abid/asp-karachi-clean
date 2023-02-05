using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Data.SqlClient;
using System.Runtime.Serialization.Json;
using System.Web.Script.Serialization;
using System.Configuration;
using System.Data;



public partial class card : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

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
    public static Dictionary<string, object> getdata(string Nic, string CardNo)
     {
        /*
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ToString()))
        {

            SqlCommand cmd = new SqlCommand("select * from NonResident" +
                                             " where nic='" + Nic + "'", cn);
                   cn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds, "settings");
            DataTable dt = new DataTable();
            dt = ds.Tables["settings"];
            return ToJson(dt);
          
        }
         */
         DBManager ObjDBManager = new DBManager();
        ObjDBManager.AddParameter("CNIC", Nic);
        ObjDBManager.AddParameter("CardNo", CardNo);
        DataSet ds=null;
        if(Nic!="")
         ds = ObjDBManager.ExecuteDataSet("GetPersonInfoForCardPrinting2", "vmsconnectionstring");  
        else
             ds = ObjDBManager.ExecuteDataSet("GetPersonInfoForCardPrintingUsingCardNo", "vmsconnectionstring");  
        
        DataTable dt = new DataTable();
        dt = ds.Tables[0];
     if(dt.Rows.Count>0)
       
        return ToJson(dt);
     else
     {
         dt = null;
         return ToJson(dt);
     }
         
    }
         

    /*
    public int getType(string CardNo, out string Type1, out string Num1)
    {
        if (CardNo.Length <= 0)
        {
            Type1 = "";
            Num1 = "";
            return 0;
        }
            int index = CardNo.IndexOf("-");
        if (index > 0)
        {
            Type1 = CardNo.Substring(0, index);
            Num1 = CardNo.Substring(index + 1, CardNo.Length - index - 1);
            return 2;
        }
        else 
        {
            Num1 = CardNo;
            Type1 = "";
            return 1;
        }
    
        //string Type1 = "", Num1 = "";
    }
     */ 
}