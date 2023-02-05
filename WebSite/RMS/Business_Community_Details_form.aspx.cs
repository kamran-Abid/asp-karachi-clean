using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;
using System.IO;
public partial class RMS_BusinessCommunity_Details : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //HyperLink1.Visible = false;
        }
        LoadDropDowns();
    }

    #region LoadDropDowns
    public void LoadDropDowns()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ToString()))
        {
            try
            {
                SqlCommand cmdPerson = new SqlCommand("SELECT [ID],[BusinessName] FROM mctx_BusinessCommunity WHERE [is_deleted]=0", cn);
                cn.Open();
                SqlDataAdapter daPerson = new SqlDataAdapter(cmdPerson);
                DataTable dtPerson = new DataTable();
                daPerson.Fill(dtPerson);
                #region PersonDD
                ddlBusinessCommunity.DataSource = dtPerson;
                ddlBusinessCommunity.DataTextField = "BusinessName";
                ddlBusinessCommunity.DataValueField = "ID";
                ddlBusinessCommunity.DataBind();
                ddlBusinessCommunity.Items.Insert(0, "");
                #endregion
                cn.Close();
            }
            catch (Exception ex)
            {
                cn.Close();
                //throw;
            }
            cn.Close();
        }
    }

    #endregion

    protected string UploadFolderPath = "~/RMS/EmpPictures/" ;
    protected void FileUploadComplete(object sender, EventArgs e)
    {

        long i = 1;
        foreach (byte b in Guid.NewGuid().ToByteArray())
        {
            i *= ((int)b + 1);
        }
        string newFileName = string.Format("{0:x}", i - DateTime.Now.Ticks);
        
  
        string filename = System.IO.Path.GetFileName(AsyncFileUpload1.FileName);

        AsyncFileUpload1.SaveAs(Server.MapPath(this.UploadFolderPath) + newFileName+".jpg");



        HttpCookie ActiveTabs = new HttpCookie("tabs");
        ActiveTabs.Values["url"] = newFileName;
        Response.Cookies.Add(ActiveTabs);

        //string query = "update NonResident set [NewPhoto]'" + filename + "' where EID='5960'";

        //DBManager ObjDBManager = new DBManager();
        //ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
     
    }


    protected string UploadFolderPathForFamily = "~/RMS/EmpPictures/EmpFamilyPicture/";
    protected void FileUploadCompleteForFamily(object sender, EventArgs e)
    {

        long i = 1;
        foreach (byte b in Guid.NewGuid().ToByteArray())
        {
            i *= ((int)b + 1);
        }
        string newFileName = string.Format("{0:x}", i - DateTime.Now.Ticks);


        string filename = System.IO.Path.GetFileName(AsyncFileUploadForFamily.FileName);

        AsyncFileUploadForFamily.SaveAs(Server.MapPath(this.UploadFolderPathForFamily) + newFileName + ".jpg");

        HttpCookie ActiveTabs = new HttpCookie("tabsForFamily");
        ActiveTabs.Values["urlForFamily"] = newFileName;
        Response.Cookies.Add(ActiveTabs);

    }

    protected string UploadFolderPathForServant = "~/RMS/EmpPictures/EmpServantPicture/";
    protected void FileUploadCompleteForServant(object sender, EventArgs e)
    {

        long i = 1;
        foreach (byte b in Guid.NewGuid().ToByteArray())
        {
            i *= ((int)b + 1);
        }
        string newFileName = string.Format("{0:x}", i - DateTime.Now.Ticks);


        string filename = System.IO.Path.GetFileName(AsyncFileUploadForServant.FileName);

        AsyncFileUploadForServant.SaveAs(Server.MapPath(this.UploadFolderPathForServant) + newFileName + ".jpg");

        HttpCookie ActiveTabs = new HttpCookie("tabsForServant");
        ActiveTabs.Values["urlForServant"] = newFileName;
        Response.Cookies.Add(ActiveTabs);

    }


    protected string UploadFolderPathForServantFamily = "~/RMS/EmpPictures/EmpServantPicture/ServantFamilyPicture/";
    protected void FileUploadCompleteForServantFamily(object sender, EventArgs e)
    {

        long i = 1;
        foreach (byte b in Guid.NewGuid().ToByteArray())
        {
            i *= ((int)b + 1);
        }
        string newFileName = string.Format("{0:x}", i - DateTime.Now.Ticks);


        string filename = System.IO.Path.GetFileName(AsyncFileUploadForServantFamily.FileName);

        AsyncFileUploadForServantFamily.SaveAs(Server.MapPath(this.UploadFolderPathForServantFamily) + newFileName + ".jpg");

        HttpCookie ActiveTabs = new HttpCookie("tabsForServantFamily");
        ActiveTabs.Values["urlForServantFamily"] = newFileName;
        Response.Cookies.Add(ActiveTabs);

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

    #region GetBusinessDetails
    [WebMethod]
    public static Dictionary<string, object> GetBusinessDetails()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ToString()))
        {
            string Query = @"SELECT [Id]
                      ,[CNIC]
                      ,[Name]
                      ,convert(varchar, [DOB], 103) [DOB]
                      ,[address]
                      ,[FatherName]
                      ,[IdentificationMark]
                      ,[BloodGroup]
                      ,[SecurityClearance]
                      ,convert(varchar, [ValidityFrom], 103) [ValidityFrom]
                      ,convert(varchar, [ValidityTo], 103) [ValidityTo]
                      ,[BusinessCommunityCategory]
                      ,[Designation]
                      ,[NewPhoto]
                  FROM [dbo].[mctx_BusinessCommunityDetail]";
            SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(ds, "BusinessComDetails");
            dt = ds.Tables["BusinessComDetails"];
            return ToJson(dt);
        }
    }
    #endregion


    #region SaveBusinessCommunityDetails
    [WebMethod]
    public static int SaveBusinessCommunityDetails(string CNIC, string Name, string Dob,
        string Address, string FatherName, string IdentificationMark, string BloodGroup,
        string SecurityClearance, string validityForm, string ValidityTO, string BusinessCategory, string Designation, string Photo)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ToString()))
        {

            try
            {
                cn.Open();
                int i = 0;
                if (Photo != "")
                {

                    string varFilePath = "~/RMS/EmpPictures/";
                    var imagePath = HttpContext.Current.Server.MapPath(varFilePath + Photo + ".jpg");
                    if (File.Exists(imagePath))
                    {
                        byte[] file;
                        using (var stream = new FileStream(HttpContext.Current.Server.MapPath(varFilePath + Photo + ".jpg"), FileMode.Open, FileAccess.Read))
                        {
                            using (var reader = new BinaryReader(stream))
                            {
                                file = reader.ReadBytes((int)stream.Length);
                            }
                        }

                        //ObjDBManager.AddParameter("@NewPhoto", file);
                        string query = "INSERT INTO [dbo].[mctx_BusinessCommunityDetail]([CNIC],[Name]," +
                                "[DOB],[address],[FatherName],[IdentificationMark],[BloodGroup]," +
                                "[SecurityClearance],[ValidityFrom],[ValidityTo],[BusinessCommunityCategory]," +
                                "[Designation],[NewPhoto]) VALUES " +
                                    "('"+CNIC+"','" + Name + "','" + Dob + "','" + Address + "','" + FatherName + "','" + IdentificationMark + "','" + BloodGroup + "'," +
                                    "'" + SecurityClearance + "','" + validityForm + "','" + ValidityTO + "','" + BusinessCategory + "','" + Designation + "','" + file + "')";

                        SqlCommand cmd = new SqlCommand(query, cn);
                        cmd.ExecuteNonQuery();

                        string q = "select Max(Id) from mctx_BusinessCommunityDetail";
                        SqlDataAdapter SDA = new SqlDataAdapter(q, cn);
                        DataTable SDT = new DataTable();
                        SDA.Fill(SDT);
                        string vid = SDT.Rows[0][0].ToString();
                        cn.Close();
                        //myUploadedImg   Save(@"E:\Hamid Files\Barcode and QRCOde\test.png", System.Drawing.Imaging.ImageFormat.Png);
                        return Int32.Parse(vid);


                        // string path = "~/Pics/Image1.jpg";
                        System.IO.File.Delete(HttpContext.Current.Server.MapPath(varFilePath + Photo + ".jpg"));
                        i = 1;
                    }
                    else
                    {
                        string query = "INSERT INTO [dbo].[mctx_BusinessCommunityDetail]([CNIC],[Name]," +
                                "[DOB],[address],[FatherName],[IdentificationMark],[BloodGroup]," +
                                "[SecurityClearance],[ValidityFrom],[ValidityTo],[BusinessCommunityCategory]," +
                                "[Designation],[NewPhoto]) VALUES " +
                                    "('" + Name + "','" + Dob + "','" + Address + "','" + FatherName + "','" + IdentificationMark + "','" + BloodGroup + "'," +
                                    "'" + SecurityClearance + "','" + validityForm + "','" + ValidityTO + "','" + BusinessCategory + "','" + Designation + "','Null')";

                        SqlCommand cmd = new SqlCommand(query, cn);
                        cmd.ExecuteNonQuery();

                        string q = "select Max(Id) from mctx_BusinessCommunityDetail";
                        SqlDataAdapter SDA = new SqlDataAdapter(q, cn);
                        DataTable SDT = new DataTable();
                        SDA.Fill(SDT);
                        string vid = SDT.Rows[0][0].ToString();
                        cn.Close();
                        //myUploadedImg   Save(@"E:\Hamid Files\Barcode and QRCOde\test.png", System.Drawing.Imaging.ImageFormat.Png);
                        return Int32.Parse(vid);
                    }
                }
            }
            catch (Exception ex)
            { }
            return 0;
        }
    }
    #endregion




}