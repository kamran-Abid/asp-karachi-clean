using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Net.Configuration;
using System.Net.Mail;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.Services;
using OfficeOpenXml.FormulaParsing.Excel.Functions.DateTime;
public partial class Approved_Appointment : System.Web.UI.Page
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
				  
				  WHERE Status='Approved' 
                  order by DateofVisit desc";
            SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(ds, "ProjDetails");
            dt = ds.Tables["ProjDetails"];
            return ToJson(dt);
        }
    }
    #endregion

    #region ApproveVisitor
    [WebMethod]
    public static void ApprovedStatus(string Visitor_ID)
    {
        DateTime Date = DateTime.Parse(DateTime.Now.ToShortDateString());
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("UPDATE [Visitor_Tbl] SET " +
                "[Status] = 'Approved' where [V_ID] = '" + Visitor_ID + "'", cn);
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }
    #endregion



    #region DeclineVisitor
    [WebMethod]
    public static void DeclineStatus(string Visitor_ID)
    {
        DateTime Date = DateTime.Parse(DateTime.Now.ToShortDateString());
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("Delete from  [Visitor_Tbl]  where [V_ID] = '" + Visitor_ID + "'", cn);
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }
    #endregion

    #region GenerateEmail
    [WebMethod]
    public static string SendEmail(string rtxt, string status)
    {
        string returnvalue = "";
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ToString()))
        {
            string EQuery = "SELECT Email from Visitor_Tbl WHERE V_ID ='" + rtxt + "'";
            cn.Open();
            SqlDataAdapter SDA = new SqlDataAdapter(EQuery, cn);
            DataTable SDT = new DataTable();
            SDA.Fill(SDT);
            string email = SDT.Rows[0][0].ToString();

            Regex regex = new Regex(@"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$");
            Match match = regex.Match(email);
            if (match.Success)
            {
                ////Full Name
                //SqlDataAdapter SDA2 = new SqlDataAdapter("SELECT E_Name FROM tbl_employee WHERE E_badge = '" + E_Badge + "'", cn);
                //DataTable SDT2 = new DataTable();
                //SDA2.Fill(SDT2);
                //string Emp_full_name = SDT2.Rows[0][0].ToString();

                //string Search_In_db = "SELECT Report_ID,Proj_Name,Jobs,TimeTaken " +
                //    " FROM DailyJobHourlyReport r inner join tbl_IT_Projects p on r.Proj_ID=p.Proj_IT_ID" +
                //    " inner join DailyJobsTbl j on r.Job_ID=j.Job_ID" +
                //    " WHERE (Report_Date = '" + DateTime.Now.Date.ToString() + "' AND E_Badge = '" + E_Badge + "')";
                //SqlDataAdapter SDA1 = new SqlDataAdapter(Search_In_db, cn);
                //DataTable SDT1 = new DataTable();
                //SDA1.Fill(SDT1);

                //if (SDT1.Rows.Count != 0)
                //{
                try
                {
                    //string line;
                    //StreamReader sr = File.OpenText(@status);

                    //{
                    //    line = sr.ReadToEnd();
                    //} 

                    //string path = "";
                    //if (status == "Approved")
                    //{
                    //    path = "/Email_Messages/Approved.txt";
                    //}
                    //else 
                    //{
                    //    {
                    //        path = "/Email_Messages/Decline.txt";
                    //    }
                    //}
                    //string[] readText = File.ReadAllLines(path);


                    //System.IO.StreamReader r = new StreamReader(Server.MapPath("~/App_Data/email.txt"));
                    //string body = r.ReadToEnd();
                    //r.Dispose();

                    //mail.Body = body;



                    string dateandtime = DateTime.Now.ToShortDateString();
                    StringBuilder sb = new StringBuilder();
                    //sb.Append(line);
                    sb.Append("<p>Your Appointment is " +
                        "" + status + "</p>" +
                        "<p>Regards,</p>" +
                        "<p>Dawood Group</p>");

                    SmtpSection section = (SmtpSection)ConfigurationManager.GetSection("system.net/mailSettings/smtp");

                    //string from = section.From;
                    //string host = section.Network.Host;
                    //int port = section.Network.Port;
                    //bool enableSsl = section.Network.EnableSsl;
                    //string user = section.Network.UserName;
                    //string password = section.Network.Password;





                    MailMessage mail = new MailMessage();
                    //mail.From = new MailAddress("13.cs.013@gmail.com");
                    mail.From = new MailAddress(section.From);
                    mail.To.Add(email.ToString());
                    mail.Subject = "Appointment Status Info!";
                    mail.Body = sb.ToString();
                    mail.IsBodyHtml = true;
                    //SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
                    SmtpClient smtp = new SmtpClient(section.Network.Host, section.Network.Port);
                    //SmtpClient smtp = new SmtpClient();
                    //smtp.Host = "mail.mechatronix.com.pk";
                    //smtp.Host = "smtp.gmail.com";
                    //smtp.Port = 587;
                    System.Net.NetworkCredential BasicAuthenticationInfo = new System.Net.NetworkCredential(section.Network.UserName, section.Network.Password);
                    smtp.Timeout = 200000;
                    smtp.UseDefaultCredentials = false;
                    smtp.Credentials = BasicAuthenticationInfo;
                    smtp.EnableSsl = section.Network.EnableSsl;
                    smtp.Send(mail);
                    cn.Close();
                    returnvalue = "Email Sent Successfully!";
                    return returnvalue;
                }
                catch (Exception ex)
                {
                    return "Email Exception!" + ex.ToString();
                }
            }
            //else
            //{
            //    cn.Close();
            //    return returnvalue;
            //}
            //}
            else
            {
                return "Email address is not Valid";
            }
        }
    }
    #endregion
}