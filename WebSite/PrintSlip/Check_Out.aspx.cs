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

public partial class PrintSlip_Check_Out : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static List<GetGuest> Search_cnic(string cnic)
    {

        List<GetGuest> list = new List<GetGuest>();

        string cs = ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ConnectionString;
        SqlConnection con = new SqlConnection(cs);

        SqlCommand cmd = new SqlCommand("GetGuestInfoCheckout", con);

        con.Open();
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@CNIC", cnic);
        SqlDataReader dataReader = cmd.ExecuteReader(CommandBehavior.SingleRow);

        string date = "";
        while (dataReader.Read())
        {
            list.Add(new GetGuest
            {
                visitorname = dataReader.GetString(0),
                date = dataReader.GetDateTime(1).ToString("dd/MM/yyyy"),
                validitdate = dataReader.GetDateTime(2).ToString("dd/MM/yyyy"),
                cnic = dataReader.GetString(3),
                relations = dataReader.GetString(4),
                visit_purpose = dataReader.GetString(5),
                vehical_number = dataReader.GetString(6),
                time_in = dataReader.GetString(7),
                department = dataReader.GetString(8),
                id = dataReader.GetInt32(9),
                hostname = dataReader.GetString(10),
                currddr = dataReader.GetString(11),
                designation = dataReader.GetString(12),
                usertype = dataReader.GetString(13)

            }) ;
        }
        con.Close();
        dataReader.Close();
        return list;
    }

    [WebMethod]
    public static void checkout(string cnic)
    {
        DateTime aDate = DateTime.Now;
        String checkouttime =  aDate.ToString("HH:mm:ss");
        DBManager db_Manager = new DBManager();
        db_Manager.AddParameterReport("@CNIC", cnic);
        db_Manager.AddParameterReport("@TimeOut", checkouttime);
        db_Manager.InsertUpdateProcedure("CheckOut_SP", "vmsconnectionstring");
    }

    public class GetGuest
    {
       public string visitorname {get; set;}
       public string date {get; set;}
       public string  validitdate {get; set;}
       public string cnic {get; set;}
       public string relations {get; set;}
       public string visit_purpose {get; set;}
       public string vehical_number {get; set;}
       public string time_in {get; set;}
       public string department {get; set;}
       public int id {get; set;}
       public string hostname {get; set;}
       public string currddr {get; set;}
       public string designation { get; set; }
        public string usertype { get; set; }

    }

}