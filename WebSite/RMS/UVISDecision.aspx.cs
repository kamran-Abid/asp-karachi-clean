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

public partial class RMS_UVISDecision : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            DateFrom.Text = DateTime.Today.AddDays(-1).ToString("MM/dd/yyyy");
            Dateto.Text = DateTime.Today.ToString("MM/dd/yyyy");
            //ddtype.Items.Insert(0, new ListItem("Allowed", "Allowed"));
            //ddtype.Items.Insert(1, new ListItem("NotAllowed", "NotAllowed"));

        }

    }

#region---------GetALLUVSSLOG
    [WebMethod]
    public static List<UVIS> GetuvisList()
    {
        List<UVIS> list = new List<UVIS>();

        string cs = ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ConnectionString;
        SqlConnection con = new SqlConnection(cs);
        

        SqlCommand cmd = new SqlCommand("GetUVSSlog", con);
      
        con.Open();
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataReader dataReader = cmd.ExecuteReader();


        while (dataReader.Read())
        {
            list.Add(new UVIS
            {
                uvssid = dataReader.GetInt32(0),
                Logdate = dataReader.GetDateTime(1).ToString("dd/MM/yyyy"),
                logdatetime = dataReader.GetDateTime(2).ToString("dd/MM/yyyy:HH-mm-ss"),
                cameraip = dataReader.GetString(3),
                sequence = dataReader.GetInt32(4),
                
                vehiclenumber = dataReader.GetString(5),
                fod = dataReader.GetInt32(6),
                pdi = dataReader.GetString(7),
                previous = dataReader.GetInt32(8),
                previouspath = dataReader.GetString(9),

                ishandled = dataReader.GetBoolean(10),
                isdisplayed = dataReader.GetBoolean(11),
                locationname = dataReader.GetString(12),
                
            });
        }
        dataReader.Close();
        con.Close();
        return list;

    }
    #endregion
    #region---------GetALL Remarks Decision UVSSLOG
    [WebMethod]
    public static List<UVIS> GetuvisRemarksList()
    {
        List<UVIS> list = new List<UVIS>();

        string cs = ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ConnectionString;
        SqlConnection con = new SqlConnection(cs);


        SqlCommand cmd = new SqlCommand("GetremarkedUVSSlog", con);

        con.Open();
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataReader dataReader = cmd.ExecuteReader();


        while (dataReader.Read())
        {
            list.Add(new UVIS
            {
                uvssid = dataReader.GetInt32(0),
                Logdate = dataReader.GetDateTime(1).ToString("dd/MM/yyyy"),
                logdatetime = dataReader.GetDateTime(2).ToString("dd/MM/yyyy:HH-mm-ss"),
                cameraip = dataReader.GetString(3),
                sequence = dataReader.GetInt32(4),

                vehiclenumber = dataReader.GetString(5),
                fod = dataReader.GetInt32(6),
                pdi = dataReader.GetString(7),
                previous = dataReader.GetInt32(8),
                previouspath = dataReader.GetString(9),

               
                locationname = dataReader.GetString(10),
                reviseddecision  = dataReader.GetString(11),
                revisedremarks = dataReader.GetString(12),

            });
        }
        dataReader.Close();
        con.Close();
        return list;

    }



    #endregion

    #region------Get By date UVSSLog
    [WebMethod]
    public static List<UVIS> GetbydateuvssList(string fromdate, string todate)
    {
        List<UVIS> list = new List<UVIS>();

        string cs = ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ConnectionString;
        SqlConnection con = new SqlConnection(cs);

        SqlCommand cmd = new SqlCommand("GetbydateUVSSlog", con);
        cmd.Parameters.AddWithValue("@fromdate", fromdate);
        cmd.Parameters.AddWithValue("@todate", todate);
        con.Open();
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataReader dataReader = cmd.ExecuteReader();


        while (dataReader.Read())
        {
            list.Add(new UVIS
            {
                uvssid = dataReader.GetInt32(0),
                Logdate = dataReader.GetDateTime(1).ToString("dd/MM/yyyy"),
                logdatetime = dataReader.GetDateTime(2).ToString("dd/MM/yyyy:HH-mm-ss"),
                cameraip = dataReader.GetString(3),
                sequence = dataReader.GetInt32(4),

                vehiclenumber = dataReader.GetString(5),
                fod = dataReader.GetInt32(6),
                pdi = dataReader.GetString(7),
                previous = dataReader.GetInt32(8),
                previouspath = dataReader.GetString(9),


                locationname = dataReader.GetString(10),

            });
        }
        dataReader.Close();
        con.Close();
        return list;

    }
    #endregion


    #region-----update UVSSLog
    [WebMethod]
    public static int UpdateUVSSLog(string uvssid, string reviseddecision, string revisedremarks)
    {

        DBManager db_Manager = new DBManager();
        try
        {
            int id = int.Parse(uvssid);

            db_Manager.AddParameterReport("@uvssid", id);
            db_Manager.AddParameterReport("@reviseddesion", reviseddecision);
            db_Manager.AddParameterReport("@revisedremarks", revisedremarks);
           int result =  db_Manager.InsertUpdateProcedure("UpdateUVSSLog", "vmsconnectionstring");

            return result;
        }
        catch
        {

        }
        return 1;
    }
#endregion
    public class UVIS
    {
        public int uvssid { get; set; }
        public string Logdate { get; set; }
        public string logdatetime { get; set; }
        public string cameraip { get; set; }
        public int sequence { get; set; }
        public string vehiclenumber { get; set; }
        public int fod { get; set; }
        public string pdi { get; set; }
        public int previous { get; set; }
        public string previouspath { get; set; }
        public bool ishandled { get; set; }
        public bool isdisplayed { get; set; }
        public string locationname { get; set; }

        public string reviseddecision { get; set; }
        public string revisedremarks { get; set; }

    } 

}