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
using System.IO;

public partial class RMSWebMethod : System.Web.UI.Page
{
    static string UserID = "";
    static string CurrentDate = "";
    
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

    //#region SaveBusinessCommunityDetails
    //[WebMethod]
    //public static int SaveBusinessCommunityDetails(string CNIC, string Name, string Dob,
    //    string Address, string FatherName, string IdentificationMark, string BloodGroup,
    //    string SecurityClearance, string validityForm, string ValidityTO, string BusinessCategory, string Designation, string Photo)
    //{
    //    using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ToString()))
    //    {

    //        try
    //        {
    //            cn.Open();
    //            int i = 0;
    //            if (Photo != "")
    //            {

    //                string varFilePath = "~/RMS/EmpPictures/";
    //                var imagePath = HttpContext.Current.Server.MapPath(varFilePath + Photo + ".jpg");
    //                if (File.Exists(imagePath))
    //                {
    //                    byte[] file;
    //                    using (var stream = new FileStream(HttpContext.Current.Server.MapPath(varFilePath + Photo + ".jpg"), FileMode.Open, FileAccess.Read))
    //                    {
    //                        using (var reader = new BinaryReader(stream))
    //                        {
    //                            file = reader.ReadBytes((int)stream.Length);
    //                        }
    //                    }

    //                    //ObjDBManager.AddParameter("@NewPhoto", file);
    //                    string query = "INSERT INTO [dbo].[mctx_BusinessCommunityDetail]([Name]," +
    //                            "[DOB],[address],[FatherName],[IdentificationMark],[BloodGroup]," +
    //                            "[SecurityClearance],[ValidityFrom],[ValidityTo],[BusinessCommunityCategory]," +
    //                            "[Designation],[photo]) VALUES " +
    //                                "('" + Name + "','" + Dob + "','" + Address + "','" + FatherName + "','" + IdentificationMark + "','" + BloodGroup + "'," +
    //                                "'" + SecurityClearance + "','" + validityForm + "','" + ValidityTO + "','" + BusinessCategory + "','" + Designation + "','" + file + "')";
    //                    SqlCommand cmd = new SqlCommand(query, cn);
    //                    cmd.ExecuteNonQuery();
    //                    // string path = "~/Pics/Image1.jpg";
    //                    System.IO.File.Delete(HttpContext.Current.Server.MapPath(varFilePath + Photo + ".jpg"));
    //                    i = 1;
    //                }
    //                else
    //                {
    //                    string query = "INSERT INTO [dbo].[mctx_BusinessCommunityDetail]([Name]," +
    //                            "[DOB],[address],[FatherName],[IdentificationMark],[BloodGroup]," +
    //                            "[SecurityClearance],[ValidityFrom],[ValidityTo],[BusinessCommunityCategory]," +
    //                            "[Designation],[photo]) VALUES " +
    //                                "('" + Name + "','" + Dob + "','" + Address + "','" + FatherName + "','" + IdentificationMark + "','" + BloodGroup + "'," +
    //                                "'" + SecurityClearance + "','" + validityForm + "','" + ValidityTO + "','" + BusinessCategory + "','" + Designation + "','Null')";

    //                    SqlCommand cmd = new SqlCommand(query, cn);
    //                    cmd.ExecuteNonQuery();

    //                    //string q = "select Max(Id) from mctx_BusinessCommunityDetail";
    //                    //SqlDataAdapter SDA = new SqlDataAdapter(q, cn);
    //                    //DataTable SDT = new DataTable();
    //                    //SDA.Fill(SDT);
    //                    //string vid = SDT.Rows[0][0].ToString();
    //                    //cn.Close();
    //                    ////myUploadedImg   Save(@"E:\Hamid Files\Barcode and QRCOde\test.png", System.Drawing.Imaging.ImageFormat.Png);
    //                    //return Int32.Parse(vid);
    //                }
                    

    //                string q = "select Max(Id) from mctx_BusinessCommunityDetail";
    //                SqlDataAdapter SDA = new SqlDataAdapter(q, cn);
    //                DataTable SDT = new DataTable();
    //                SDA.Fill(SDT);
    //                string vid = SDT.Rows[0][0].ToString();
    //                cn.Close();
    //                //myUploadedImg   Save(@"E:\Hamid Files\Barcode and QRCOde\test.png", System.Drawing.Imaging.ImageFormat.Png);
    //                return Int32.Parse(vid);

    //            }
    //        }
    //        catch (Exception ex)
    //        { }
    //        return 0;
    //    }
    //}
    //#endregion

    //    int eid = int.Parse(EID);

    //    DBManager ObjDBManager = new DBManager();
    //    ObjDBManager.AddParameter("ServiceNo", ServiceNo);
    //    ObjDBManager.AddParameter("FirstName", FirstName);
    //    ObjDBManager.AddParameter("LastName", LastName);
    //    ObjDBManager.AddParameter("NIC", NIC);


    //    ObjDBManager.AddParameter("Designation", Designation);
    //    ObjDBManager.AddParameter("Rank_ID", Rank);
    //    ObjDBManager.AddParameter("Person_CatID", PCategory);
    //    ObjDBManager.AddParameter("Department", Department);
    //    ObjDBManager.AddParameter("CurrAddr", CurrAddr);
    //    ObjDBManager.AddParameter("Location", Location);
    //    ObjDBManager.AddParameter("PerAddr", PerAddr);
    //    ObjDBManager.AddParameter("Mobile", Mobile);
    //    ObjDBManager.AddParameter("PhoneHome", PhoneHome);
    //    ObjDBManager.AddParameter("AllotmentDate", AllotmentDate);
    //    ObjDBManager.AddParameter("ReleaseDate", ReleaseDate);
    //    ObjDBManager.AddParameter("PhoneOffice", PhoneOffice);
    //    ObjDBManager.AddParameter("Dob", Dob);
    //    ObjDBManager.AddParameter("MaritalStatus", MaritalStatus);
    //    ObjDBManager.AddParameter("JobLocation", JobLocation);

    //    ObjDBManager.AddParameter("@Photo", Photo);
    //    int i = 0;
    //    if (Photo != "")
    //    {
           
    //        string varFilePath = "~/RMS/EmpPictures/";
    //        var imagePath = HttpContext.Current.Server.MapPath(varFilePath + Photo + ".jpg");
    //        if (File.Exists(imagePath))
    //        {
    //            byte[] file;
    //            using (var stream = new FileStream(HttpContext.Current.Server.MapPath(varFilePath + Photo + ".jpg"), FileMode.Open, FileAccess.Read))
    //            {
    //                using (var reader = new BinaryReader(stream))
    //                {
    //                    file = reader.ReadBytes((int)stream.Length);
    //                }
    //            }

    //            ObjDBManager.AddParameter("@NewPhoto", file);

    //            // string path = "~/Pics/Image1.jpg";
    //            System.IO.File.Delete(HttpContext.Current.Server.MapPath(varFilePath + Photo + ".jpg"));
    //            i = 1;
    //        }
    //    }
       
    //    if (int.Parse(EID) == 0)
    //    {            
    //        ObjDBManager.AddParameter("@created_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
    //        ObjDBManager.AddParameter("@created_date", DateTime.Now);           
    //        ObjDBManager.AddParameter("card_prefix", cardPrefix);
    //        ObjDBManager.AddParameter("EID", eid, SqlDbType.Int, 4, ParameterDirection.Output);
    //        ObjDBManager.InsertUpdateProcedure("EmployeeAdd", "vmsconnectionstring");
    //       eid = int.Parse(ObjDBManager.Parameters[23+i].Value.ToString());
    //    }
    //    else
    //    {
    //        ObjDBManager.AddParameter("card_prefix", cardPrefix);
    //        ObjDBManager.AddParameter("EID", eid);
    //        ObjDBManager.AddParameter("@modified_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
    //        ObjDBManager.AddParameter("@modified_date", DateTime.Now);
    //        ObjDBManager.InsertUpdateProcedure("EmployeeUpdate", "vmsconnectionstring");
    //    }
    //    return eid;
    //}


    //[WebMethod]
    //public static void InactiveEmployee(string EID)
    //{

    //    string query = "update Employee set Status='InActive' ,_status='" + 0 + "' where EID='" + int.Parse(EID) + "'";

    //    DBManager ObjDBManager = new DBManager();
    //    ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    //}


    //[WebMethod]
    //public static void ActivateEmployeeRecord(string EID)
    //{

    //    string query = "update Employee set Status='Active' ,_status='" + 1 + "' where EID='" + int.Parse(EID) + "'";

    //    DBManager ObjDBManager = new DBManager();
    //    ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    //}

    //[WebMethod]
    //public static void AddEmployeeBLReason(string EmployeeID, string BlackListReason)
    //{

    //    string query = "update Employee set modified_by='" + BlackListReason + "'  where EID='" + int.Parse(EmployeeID) + "'";

    //    DBManager ObjDBManager = new DBManager();
    //    ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    //}


    //[WebMethod]
    //public static void BlackListResidentRecord(string EID)
    //{

    //    string query = "update Employee set Status='BlackList' ,_status='" + 0 + "' where EID='" + int.Parse(EID) + "'";

    //    DBManager ObjDBManager = new DBManager();
    //    ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    //}
    //[WebMethod]
    //public static void SaveFamilyMember(string EFID, string EID, string FirstName, string LastName, string Relation, string NIC,
    //    string Mobile, string vpurpose, string photo, string vaddr,string cardPrefix)
    //{


    //    DBManager ObjDBManager = new DBManager();
    //   ObjDBManager.AddParameter("card_prefix", cardPrefix);
    //    ObjDBManager.AddParameter("EFID", EFID);

    //    ObjDBManager.AddParameter("EID", EID);     
    //    ObjDBManager.AddParameter("FirstName", FirstName);
    //    ObjDBManager.AddParameter("LastName", LastName);
    //    ObjDBManager.AddParameter("Relation", Relation);
    //    ObjDBManager.AddParameter("NIC", NIC);        
    //    ObjDBManager.AddParameter("Mobile", Mobile);        
    //    ObjDBManager.AddParameter("vpurpose", vpurpose);
    //    ObjDBManager.AddParameter("vaddr", vaddr);
    //    ObjDBManager.AddParameter("Photo", photo);
        
    //    if (photo != "")
    //    {
    //        string varFilePath = "~/RMS/EmpPictures/EmpFamilyPicture/";
    //        var imagePath = HttpContext.Current.Server.MapPath(varFilePath + photo + ".jpg");
    //        if (File.Exists(imagePath))
    //        {

    //            byte[] file;
    //            using (var stream = new FileStream(HttpContext.Current.Server.MapPath(varFilePath + photo + ".jpg"), FileMode.Open, FileAccess.Read))
    //            {
    //                using (var reader = new BinaryReader(stream))
    //                {
    //                    file = reader.ReadBytes((int)stream.Length);
    //                }
    //            }

    //            ObjDBManager.AddParameter("@NewPhoto", file);

    //            // string path = "~/Pics/Image1.jpg";
    //            System.IO.File.Delete(HttpContext.Current.Server.MapPath(varFilePath + photo + ".jpg"));
               
    //        }
    //    }
    //    if (int.Parse(EFID) == 0)
    //    {
    //        ObjDBManager.AddParameter("@created_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
    //        ObjDBManager.AddParameter("@created_date", DateTime.Now);

    //        ObjDBManager.InsertUpdateProcedure("EmployeeFamilyAdd", "vmsconnectionstring");
    //    }
    //    else
    //    {
    //        ObjDBManager.AddParameter("@modified_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
    //        ObjDBManager.AddParameter("@modified_date", DateTime.Now);
    //        ObjDBManager.InsertUpdateProcedure("EmployeeFamilyUpdate", "vmsconnectionstring");
    //    }
    //}


    //[WebMethod]
    //public static void InactiveEmployeeFamilyRecord(string EFID)
    //{
       
    //    string query = "update EmployeeFamily set Status='InActive' ,_status='" + 0 + "' where EFID='" + int.Parse(EFID) + "'";

    //    DBManager ObjDBManager = new DBManager();
    //    ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    //}

    //[WebMethod]
    //public static void ActivateEmployeeFamilyRecord(string EFID)
    //{

    //    string query = "update EmployeeFamily set Status='Active' ,_status='" + 1 + "' where EFID='" + int.Parse(EFID) + "'";

    //    DBManager ObjDBManager = new DBManager();
    //    ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    //}

    //[WebMethod]
    //public static void BlackListEmployeeFamilyRecord(string EFID)
    //{

    //    string query = "update EmployeeFamily set Status='BlackList' ,_status='" + 0 + "' where EFID='" + int.Parse(EFID) + "'";

    //    DBManager ObjDBManager = new DBManager();
    //    ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    //}

    //[WebMethod]
    //public static int SaveServant(string SID, string EID,  string FirstName, string LastName, string NIC,
    //    string CurrAddr, string DOB, string PerAddr, string FH, string Mobile,
    //       string Religion, string PlaceofWork, string MarkofIdentification, string PhoneOffice, string Phonehome, string Photo)
    //{
    //    int sid = int.Parse(SID);

    //    DBManager ObjDBManager = new DBManager();
    //    ObjDBManager.AddParameter("EID", EID);
    //    ObjDBManager.AddParameter("FirstName", FirstName);
    //    ObjDBManager.AddParameter("LastName", LastName);
    //    ObjDBManager.AddParameter("NIC", NIC);        
    //    ObjDBManager.AddParameter("CurrAddr", CurrAddr);
    //    ObjDBManager.AddParameter("DOB", DOB);
    //    ObjDBManager.AddParameter("PerAddr", PerAddr);
    //    ObjDBManager.AddParameter("FH", FH);
    //    ObjDBManager.AddParameter("Mobile", Mobile);
    //    ObjDBManager.AddParameter("Religion", Religion);
    //    ObjDBManager.AddParameter("PlaceofWork", PlaceofWork);
    //    ObjDBManager.AddParameter("MarkofIdentification", MarkofIdentification);     
    //    ObjDBManager.AddParameter("PhoneOffice", PhoneOffice);
    //    ObjDBManager.AddParameter("phonehome", Phonehome);                
    //    ObjDBManager.AddParameter("Photo", Photo);

    //    int i = 0;
    //    if (Photo != "")
    //    {
    //        string varFilePath = "~/RMS/EmpPictures/EmpServantPicture/";
    //        var imagePath = HttpContext.Current.Server.MapPath(varFilePath + Photo + ".jpg");
    //        if (File.Exists(imagePath))
    //        {

    //            byte[] file;
    //            using (var stream = new FileStream(HttpContext.Current.Server.MapPath(varFilePath + Photo + ".jpg"), FileMode.Open, FileAccess.Read))
    //            {
    //                using (var reader = new BinaryReader(stream))
    //                {
    //                    file = reader.ReadBytes((int)stream.Length);
    //                }
    //            }

    //            ObjDBManager.AddParameter("@NewPhoto", file);

    //            // string path = "~/Pics/Image1.jpg";
    //            System.IO.File.Delete(HttpContext.Current.Server.MapPath(varFilePath + Photo + ".jpg"));
    //            i = 1;
    //        }
    //    }


    //    if (int.Parse(SID) == 0)
    //    {

    //        ObjDBManager.AddParameter("@created_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
    //        ObjDBManager.AddParameter("@created_date", DateTime.Now);
    //        ObjDBManager.AddParameter("SID", sid, SqlDbType.Int, 4, ParameterDirection.Output);

    //        ObjDBManager.InsertUpdateProcedure("ServantAdd", "vmsconnectionstring");
    //        sid = int.Parse(ObjDBManager.Parameters[17+i].Value.ToString());
    //    }
    //    else
    //    {
    //        ObjDBManager.AddParameter("SID", SID);
    //        ObjDBManager.AddParameter("@modified_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
    //        ObjDBManager.AddParameter("@modified_date", DateTime.Now);
    //        ObjDBManager.InsertUpdateProcedure("ServantUpdate", "vmsconnectionstring");



    //        //var user = HttpContext.Current.Profile.GetPropertyValue("UserId");
    //        //string query = "update Servant set " +
    //        //" FirstName='" + FirstName + "',LastName='" + LastName + "',FH='" + FH + "',CurrAddr='" + CurrAddr + "',PerAddr='" + PerAddr + "',Caste='',DOB='" + DOB + "', " +
    //        //" PlaceofWork='" + PlaceofWork + "',NIC='" + NIC + "',Religion='" + Religion + "',MarkofIdentification='" + MarkofIdentification + "',Photo='" + Photo + "',phoneoffice='" + PhoneOffice + "',phonehome='" + Phonehome + "',mobile='" + Mobile + "',modified_by='"+user+"',modified_date='"+DateTime.Now+"' " +
    //        //" where SID='"+sid+"' ";

    //        //DBManager ObjDBManager2 = new DBManager();
    //        //ObjDBManager2.InsertUpdateQuery(query, "vmsconnectionstring");
    //    }
    //    return sid;
    //}

    //[WebMethod]
    //public static void InactiveServantRecord(string SID)
    //{


    //    string query = "update Servant set Status='InActive' where SID='" + int.Parse(SID) + "'";

    //    DBManager ObjDBManager = new DBManager();
    //    ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    //}

    //[WebMethod]
    //public static void ActivateServantRecord(string SID)
    //{

    //    string query = "update Servant set Status='Active' where SID='" + int.Parse(SID) + "'";

    //    DBManager ObjDBManager = new DBManager();
    //    ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    //}
    //[WebMethod]
    //public static void BlackListServantRecord(string SID)
    //{

    //    string query = "update Servant set Status='BlackList' where SID='" + int.Parse(SID) + "'";

    //    DBManager ObjDBManager = new DBManager();
    //    ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    //}
    

    //[WebMethod]
    //public static void SaveFamilyMemberServant(string SFID,string SID, string EID, string FirstName, string LastName, 
    //    string Relation, string NIC,
    //    string Profession, string Mobile, string PlaceofWork, string Photo)
    //{


    //    DBManager ObjDBManager = new DBManager();
    //    ObjDBManager.AddParameter("SFID", SFID);
    //    ObjDBManager.AddParameter("SID", SID);
    //    ObjDBManager.AddParameter("EID", EID);
    //    ObjDBManager.AddParameter("FirstName", FirstName);
    //    ObjDBManager.AddParameter("LastName", LastName);
    //    ObjDBManager.AddParameter("Relation", Relation);
    //    ObjDBManager.AddParameter("NIC", NIC);
    //    ObjDBManager.AddParameter("Profession", Profession);
    //    ObjDBManager.AddParameter("Mobile", Mobile);
    //    ObjDBManager.AddParameter("PlaceofWork", PlaceofWork);
    //    ObjDBManager.AddParameter("Photo", Photo);

    //    if (Photo != "")
    //    {
    //        string varFilePath = "~/RMS/EmpPictures/EmpServantPicture/ServantFamilyPicture/";
    //        var imagePath = HttpContext.Current.Server.MapPath(varFilePath +Photo +".jpg");
    //        if (File.Exists(imagePath))
    //        {
    //            byte[] file;
    //            using (var stream = new FileStream(HttpContext.Current.Server.MapPath(varFilePath + Photo + ".jpg"), FileMode.Open, FileAccess.Read))
    //            {
    //                using (var reader = new BinaryReader(stream))
    //                {
    //                    file = reader.ReadBytes((int)stream.Length);
    //                }
    //            }

    //            ObjDBManager.AddParameter("@NewPhoto", file);

    //            // string path = "~/Pics/Image1.jpg";
    //            System.IO.File.Delete(HttpContext.Current.Server.MapPath(varFilePath + Photo + ".jpg"));
    //        }
    //    }
    //    if (int.Parse(SFID) == 0)
    //    {
    //        ObjDBManager.AddParameter("@created_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
    //        ObjDBManager.AddParameter("@created_date", DateTime.Now);

    //        ObjDBManager.InsertUpdateProcedure("ServantFamilyAdd", "vmsconnectionstring");
    //    }
    //    else
    //    {
    //        ObjDBManager.AddParameter("@modified_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
    //        ObjDBManager.AddParameter("@modified_date", DateTime.Now);
    //        ObjDBManager.InsertUpdateProcedure("ServantFamilyUpdate", "vmsconnectionstring");
    //    }
    //}

    //[WebMethod]
    //public static void InactiveServantFamilyRecord(string SFID)
    //{

    //    string query = "update ServantFamily set Status='InActive' where SFID='" + int.Parse(SFID) + "'";

    //    DBManager ObjDBManager = new DBManager();
    //    ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    //}



    //[WebMethod]
    //public static void ActivateServantFamilyRecord(string SFID)
    //{

    //    string query = "update ServantFamily set Status='Active' where SFID='" + int.Parse(SFID) + "'";

    //    DBManager ObjDBManager = new DBManager();
    //    ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    //}

    //[WebMethod]
    //public static void BlackListServantFamilyRecord(string SFID)
    //{

    //    string query = "update ServantFamily set Status='BlackList' where SFID='" + int.Parse(SFID) + "'";

    //    DBManager ObjDBManager = new DBManager();
    //    ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");


    #region Resident
    [WebMethod]
    public static int SaveResident(string EID, string ServiceNo, string FirstName, string LastName, string NIC, 
         string Rank, string ReleaseDate, string Designation, string CurrAddr, string Department, string PerAddr, 
         string Mobile, string PhoneHome, string Dob, string PhoneOffice,
         string clearanceStatus, string Section,
         string FatherName, string MotherName,
         string BloodGroup, string Cadre,
         string ResidentStatus, string CardColor,
         string Transport, string SiteAllowed,
         string EmployeeIdentificationMark
         ,string gender,string Remarks,
         string AuthType,
         string Photo)
    {

        string fileName = NIC;
        string varFilePath = "~/RMS/EmpPictures/";
        //////////////Add CNIC Name images
        ///

        if (Photo.Length > 16)
        {


            if (Photo != "")
            {
                File.Delete(HttpContext.Current.Server.MapPath(varFilePath + fileName+".jpg"));
                byte[] imageBytes = Convert.FromBase64String(Photo.Split(',')[1]);
                var imagePath = HttpContext.Current.Server.MapPath(varFilePath + fileName + ".jpg");
                System.IO.File.WriteAllBytes(imagePath, imageBytes);
            }
        }
        else { 
        int i = 0;
        if (Photo != "")
        { 
            var imagePath = HttpContext.Current.Server.MapPath(varFilePath + fileName + ".jpg");
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

               i = 1;
            }
        }
        }
        /////////////////////////////////////////end Images upload


        int eid = int.Parse(EID);

        DBManager ObjDBManager = new DBManager();       
        ObjDBManager.AddParameter("ServiceNo", ServiceNo);
        ObjDBManager.AddParameter("FirstName", FirstName);
        ObjDBManager.AddParameter("LastName", LastName);
        ObjDBManager.AddParameter("NIC", NIC);

        ObjDBManager.AddParameter("MotherName", MotherName);
        ObjDBManager.AddParameter("FatherName", FatherName);
        ObjDBManager.AddParameter("clearanceStatus", clearanceStatus);
        ObjDBManager.AddParameter("Section", Section);

        ObjDBManager.AddParameter("BloodGroup", BloodGroup);
        ObjDBManager.AddParameter("Cadre", Cadre);
        ObjDBManager.AddParameter("ResidentStatus", ResidentStatus);
        //ObjDBManager.AddParameter("CardColor", CardColor);
        //ObjDBManager.AddParameter("Transport", Transport);
        ObjDBManager.AddParameter("SiteAllowed", SiteAllowed);
        ObjDBManager.AddParameter("EmployeeIdentificationMark", EmployeeIdentificationMark);

        ObjDBManager.AddParameter("Designation", Designation);
        ObjDBManager.AddParameter("Rank_ID", Rank);
      // ObjDBManager.AddParameter("Person_CatID", PCategory);   
        ObjDBManager.AddParameter("Department", Department);
        ObjDBManager.AddParameter("CurrAddr", CurrAddr);
       // ObjDBManager.AddParameter("Location", Location);
        ObjDBManager.AddParameter("PerAddr", PerAddr);        
        ObjDBManager.AddParameter("Mobile", Mobile);        
        ObjDBManager.AddParameter("PhoneHome", PhoneHome);
       // ObjDBManager.AddParameter("AllotmentDate", AllotmentDate);
        ObjDBManager.AddParameter("ReleaseDate", ReleaseDate);
        ObjDBManager.AddParameter("PhoneOffice", PhoneOffice);
        ObjDBManager.AddParameter("Dob", Dob);        
        ObjDBManager.AddParameter("Gender", gender);
        ObjDBManager.AddParameter("Remarks", Remarks);
        ObjDBManager.AddParameter("authType", AuthType);
        ObjDBManager.AddParameter("@Photo", fileName);


        
        if (int.Parse(EID) == 0)
        {            
            ObjDBManager.AddParameter("@created_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
            ObjDBManager.AddParameter("@created_date", DateTime.Now);           
         //   ObjDBManager.AddParameter("card_prefix", cardPrefix);
            ObjDBManager.AddParameter("EID", eid, SqlDbType.Int, 4, ParameterDirection.Output);
            ObjDBManager.InsertUpdateProcedure("EmployeeAdd", "vmsconnectionstring");
//           eid = int.Parse(ObjDBManager.Parameters[23+i].Value.ToString());
        }
        else
        {
            //ObjDBManager.AddParameter("card_prefix", cardPrefix);
            ObjDBManager.AddParameter("EID", eid);
            ObjDBManager.AddParameter("@modified_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
            ObjDBManager.AddParameter("@modified_date", DateTime.Now);
            ObjDBManager.InsertUpdateProcedure("EmployeeUpdate", "vmsconnectionstring");
        }
        return eid;
    }


    [WebMethod]
    public static void InactiveEmployee(string EID)
    {
        

        string query = "update Employee set Status='InActive' ,_status='" + 0 + "' where EID='" + int.Parse(EID) + "'";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }


    [WebMethod]
    public static void ActivateEmployeeRecord(string EID)
    {

        string query = "update Employee set Status='Active' ,_status='" + 1 + "' where EID='" + int.Parse(EID) + "'";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }

    [WebMethod]
    public static void AddEmployeeBLReason(string EmployeeID, string BlackListReason)
    {

        string query = "update Employee set modified_by='" + BlackListReason + "'  where EID='" + int.Parse(EmployeeID) + "'";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }


    [WebMethod]
    public static void BlackListResidentRecord(string EID)
    {

        string query = "update Employee set Status='BlackList' ,_status='" + 0 + "' where EID='" + int.Parse(EID) + "'";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    [WebMethod]
    public static void SaveFamilyMember(string EFID, string EID, string FirstName, string LastName, string Relation, string NIC,
       string ddlFamilysecurityClearance, string Dob, string VisitorAdd,  string Gender,string ClearanceLevel, string ValidFrom, string ValidTo, string AuthType, string photo)
    {

        string fileName = NIC;
        string varFilePath = "~/RMS/EmpPictures/EmpFamilyPicture/";

        if (photo.Length > 16)
        {
            if (photo != "")
            {
                File.Delete(HttpContext.Current.Server.MapPath(varFilePath + fileName + ".jpg"));

                byte[] imageBytes = Convert.FromBase64String(photo.Split(',')[1]);
                var imagePath = HttpContext.Current.Server.MapPath(varFilePath + fileName + ".jpg");
                System.IO.File.WriteAllBytes(imagePath, imageBytes);
            }
        }
        else { 
        int i = 0;
        if (photo != "")
        {
                       var imagePath = HttpContext.Current.Server.MapPath(varFilePath + photo + ".jpg");
            if (File.Exists(imagePath))
            {
                byte[] file;
                using (var stream = new FileStream(HttpContext.Current.Server.MapPath(varFilePath + photo + ".jpg"), FileMode.Open, FileAccess.Read))
                {
                    using (var reader = new BinaryReader(stream))
                    {
                        file = reader.ReadBytes((int)stream.Length);
                    }
                }
                i = 1;
            }
        }
        }




        DBManager ObjDBManager = new DBManager();
       
        ObjDBManager.AddParameter("EFID", EFID);

        ObjDBManager.AddParameter("EID", EID);     
        ObjDBManager.AddParameter("FirstName", FirstName);
        ObjDBManager.AddParameter("LastName", LastName);
        ObjDBManager.AddParameter("Relation", Relation);
        ObjDBManager.AddParameter("NIC", NIC);

        ObjDBManager.AddParameter("securityClearance", ddlFamilysecurityClearance);
        ObjDBManager.AddParameter("DOB", Dob);
        ObjDBManager.AddParameter("vaddr", VisitorAdd);

        ObjDBManager.AddParameter("FamilyGender", Gender);
        ObjDBManager.AddParameter("ClearanceLevel", ClearanceLevel);

        ObjDBManager.AddParameter("ValidFrom", ValidFrom);
        ObjDBManager.AddParameter("ValidTo", ValidTo);
        ObjDBManager.AddParameter("AuthType", AuthType);

        ObjDBManager.AddParameter("Photo", fileName);
                if (int.Parse(EFID) == 0)
        {
            ObjDBManager.AddParameter("@created_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
            ObjDBManager.AddParameter("@created_date", DateTime.Now);

            ObjDBManager.InsertUpdateProcedure("EmployeeFamilyAdd", "vmsconnectionstring");
        }
        else
        {
            ObjDBManager.AddParameter("@modified_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
            ObjDBManager.AddParameter("@modified_date", DateTime.Now);
            ObjDBManager.InsertUpdateProcedure("EmployeeFamilyUpdate", "vmsconnectionstring");
        }
    }


    [WebMethod]
    public static void InactiveEmployeeFamilyRecord(string EFID)
    {
       
        string query = "update EmployeeFamily set Status='InActive' ,_status='" + 0 + "' where EFID='" + int.Parse(EFID) + "'";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }

    [WebMethod]
    public static void ActivateEmployeeFamilyRecord(string EFID)
    {

        string query = "update EmployeeFamily set Status='Active' ,_status='" + 1 + "' where EFID='" + int.Parse(EFID) + "'";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }

    [WebMethod]
    public static void BlackListEmployeeFamilyRecord(string EFID)
    {

        string query = "update EmployeeFamily set Status='BlackList' ,_status='" + 0 + "' where EFID='" + int.Parse(EFID) + "'";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }

    [WebMethod]
    public static int SaveServant(string SID, string EID, string BCNo, string FirstName, string LastName, string NIC, string DOB, string PerAddr, string FH, string MarkofIdentification, string Mobile,
           string servantSecurity, string ClearanceLevel, string ValidTo, string ValidFrom,  string AuthType, string Photo)
    {
        int sid = int.Parse(SID);
        string varFilePath = "~/RMS/EmpPictures/EmpServantPicture/";

        string fileName = NIC;
        if (Photo.Length > 16)
        {
            if (Photo != "")
            {
                File.Delete(HttpContext.Current.Server.MapPath(varFilePath + fileName + ".jpg"));

                byte[] imageBytes = Convert.FromBase64String(Photo.Split(',')[1]);
                var imagePath = HttpContext.Current.Server.MapPath(varFilePath + fileName + ".jpg");
                System.IO.File.WriteAllBytes(imagePath, imageBytes);
            }
        }
        else
        {
            int i = 0;
            if (Photo != "")
            {
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

                   i = 1;
                }
            }
        }


        DBManager ObjDBManager = new DBManager();
        ObjDBManager.AddParameter("EID", EID);
        ObjDBManager.AddParameter("BCnumber", BCNo);
        ObjDBManager.AddParameter("FirstName", FirstName);
        ObjDBManager.AddParameter("LastName", LastName);
        ObjDBManager.AddParameter("NIC", NIC);        
       // ObjDBManager.AddParameter("CurrAddr", CurrAddr);
        ObjDBManager.AddParameter("DOB", DOB);
        ObjDBManager.AddParameter("PerAddr", PerAddr);
        ObjDBManager.AddParameter("FH", FH);
        ObjDBManager.AddParameter("Mobile", Mobile);

        ObjDBManager.AddParameter("validTo", ValidTo);
        ObjDBManager.AddParameter("validFrom", ValidFrom);
        ObjDBManager.AddParameter("SeurityClearance", servantSecurity);
        ObjDBManager.AddParameter("clearanaceLevel", ClearanceLevel);

        ObjDBManager.AddParameter("AuthType", AuthType);


        ObjDBManager.AddParameter("MarkofIdentification", MarkofIdentification);     
        //ObjDBManager.AddParameter("PhoneOffice", PhoneOffice);
        //ObjDBManager.AddParameter("phonehome", Phonehome);                
        ObjDBManager.AddParameter("Photo", fileName);

        
        if (int.Parse(SID) == 0)
        {

            ObjDBManager.AddParameter("@created_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
            ObjDBManager.AddParameter("@created_date", DateTime.Now);
            ObjDBManager.AddParameter("SID", sid, SqlDbType.Int, 4, ParameterDirection.Output);

            ObjDBManager.InsertUpdateProcedure("ServantAdd", "vmsconnectionstring");
           // sid = int.Parse(ObjDBManager.Parameters[17+i].Value.ToString());
        }
        else
        {
            ObjDBManager.AddParameter("SID", SID);
            ObjDBManager.AddParameter("@modified_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
            ObjDBManager.AddParameter("@modified_date", DateTime.Now);
            ObjDBManager.InsertUpdateProcedure("ServantUpdate", "vmsconnectionstring");



            //var user = HttpContext.Current.Profile.GetPropertyValue("UserId");
            //string query = "update Servant set " +
            //" FirstName='" + FirstName + "',LastName='" + LastName + "',FH='" + FH + "',CurrAddr='" + CurrAddr + "',PerAddr='" + PerAddr + "',Caste='',DOB='" + DOB + "', " +
            //" PlaceofWork='" + PlaceofWork + "',NIC='" + NIC + "',Religion='" + Religion + "',MarkofIdentification='" + MarkofIdentification + "',Photo='" + Photo + "',phoneoffice='" + PhoneOffice + "',phonehome='" + Phonehome + "',mobile='" + Mobile + "',modified_by='"+user+"',modified_date='"+DateTime.Now+"' " +
            //" where SID='"+sid+"' ";

            //DBManager ObjDBManager2 = new DBManager();
            //ObjDBManager2.InsertUpdateQuery(query, "vmsconnectionstring");
        }
        return sid;
    }

    [WebMethod]
    public static void InactiveServantRecord(string SID)
    {


        string query = "update Servant set Status='InActive' where SID='" + int.Parse(SID) + "'";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }

    [WebMethod]
    public static void ActivateServantRecord(string SID)
    {

        string query = "update Servant set Status='Active' where SID='" + int.Parse(SID) + "'";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    [WebMethod]
    public static void BlackListServantRecord(string SID)
    {

        string query = "update Servant set Status='BlackList' where SID='" + int.Parse(SID) + "'";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    

    [WebMethod]
    public static void SaveFamilyMemberServant(string SFID,string SID, string EID, string FirstName, string LastName, 
        string Relation, string NIC,
        string Profession, string Mobile, string PlaceofWork, string Photo)
    {

        string varFilePath = "~/RMS/EmpPictures/EmpServantPicture/ServantFamilyPicture/";
        string fileName = NIC;
        if (Photo.Length > 16)
        {
            if (Photo != "")
            {
                File.Delete(HttpContext.Current.Server.MapPath(varFilePath + fileName + ".jpg"));

                byte[] imageBytes = Convert.FromBase64String(Photo.Split(',')[1]);
                var imagePath = HttpContext.Current.Server.MapPath(varFilePath + fileName + ".jpg");
                System.IO.File.WriteAllBytes(imagePath, imageBytes);
            }
        }
        else { 
        if (Photo != "")
        {
            
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
                System.IO.File.Delete(HttpContext.Current.Server.MapPath(varFilePath + Photo + ".jpg"));
            }
        }
        }

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.AddParameter("SFID", SFID);
        ObjDBManager.AddParameter("SID", SID);
        ObjDBManager.AddParameter("EID", EID);
        ObjDBManager.AddParameter("FirstName", FirstName);
        ObjDBManager.AddParameter("LastName", LastName);
        ObjDBManager.AddParameter("Relation", Relation);
        ObjDBManager.AddParameter("NIC", NIC);
        ObjDBManager.AddParameter("Profession", Profession);
        ObjDBManager.AddParameter("Mobile", Mobile);
        ObjDBManager.AddParameter("PlaceofWork", PlaceofWork);
        ObjDBManager.AddParameter("Photo", fileName);

        
        if (int.Parse(SFID) == 0)
        {
            ObjDBManager.AddParameter("@created_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
            ObjDBManager.AddParameter("@created_date", DateTime.Now);

            ObjDBManager.InsertUpdateProcedure("ServantFamilyAdd", "vmsconnectionstring");
        }
        else
        {
            ObjDBManager.AddParameter("@modified_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
            ObjDBManager.AddParameter("@modified_date", DateTime.Now);
            ObjDBManager.InsertUpdateProcedure("ServantFamilyUpdate", "vmsconnectionstring");
        }
    }

    [WebMethod]
    public static void InactiveServantFamilyRecord(string SFID)
    {

        string query = "update ServantFamily set Status='InActive' where SFID='" + int.Parse(SFID) + "'";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }



    [WebMethod]
    public static void ActivateServantFamilyRecord(string SFID)
    {

        string query = "update ServantFamily set Status='Active' where SFID='" + int.Parse(SFID) + "'";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }

    [WebMethod]
    public static void BlackListServantFamilyRecord(string SFID)
    {

        string query = "update ServantFamily set Status='BlackList' where SFID='" + int.Parse(SFID) + "'";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    #endregion

    #region Non Residents
    [WebMethod]
    public static int SaveNonResident(string NRID,  string FirstName, string LastName, string NIC, string CurrAddr,
        string Rel, string PerAddr, string RelName, string PhoneOffice, string PCategory, string Ranks, string Designation, string PhoneHome,
          string Department, string Mobile, string Religion, string DateofEntry,string ValidUptoDate, string Sectt,
        string Education, string Caste, string Witness1Name, string Witness1Addr, string Witness2Name,
        string Witness2Addr, string Firm, string ShopKeeper, string Product, string FirmAddr,
        string Market, string Authority, string Photo, string cardPrefix)
    {
        int nRID = int.Parse(NRID);
        
        DBManager ObjDBManager = new DBManager();        
        ObjDBManager.AddParameter("FirstName", FirstName);
        ObjDBManager.AddParameter("LastName", LastName);
        ObjDBManager.AddParameter("RelName", RelName);        
        ObjDBManager.AddParameter("CurrAddr", CurrAddr);
        ObjDBManager.AddParameter("PerAddr", PerAddr);
        ObjDBManager.AddParameter("NIC", NIC);
        ObjDBManager.AddParameter("PhoneOffice", PhoneOffice);
        ObjDBManager.AddParameter("PhoneHome", PhoneHome);
        ObjDBManager.AddParameter("Mobile", Mobile);
        ObjDBManager.AddParameter("Religion", Religion);
        ObjDBManager.AddParameter("Sectt", Sectt);
        ObjDBManager.AddParameter("Caste", Caste);
        ObjDBManager.AddParameter("Education", Education);
        ObjDBManager.AddParameter("Witness1Name", Witness1Name);
        ObjDBManager.AddParameter("Witness1Addr", Witness1Addr);
        ObjDBManager.AddParameter("Witness2Name", Witness2Name);
        ObjDBManager.AddParameter("Witness2Addr", Witness2Addr);
        ObjDBManager.AddParameter("Authority", Authority);
        ObjDBManager.AddParameter("DateofEntry", DateofEntry);
        ObjDBManager.AddParameter("DateofRelease", ValidUptoDate);
        ObjDBManager.AddParameter("Firm", Firm);
        ObjDBManager.AddParameter("FirmAddr", FirmAddr);
        ObjDBManager.AddParameter("Product", Product);
        ObjDBManager.AddParameter("ShopKeeper", ShopKeeper);
        ObjDBManager.AddParameter("Department", Department);
        ObjDBManager.AddParameter("Market", Market);
        ObjDBManager.AddParameter("Photo", Photo);
        ObjDBManager.AddParameter("Designation", Designation);        
        ObjDBManager.AddParameter("Rel", Rel);
        ObjDBManager.AddParameter("Rank_ID", Ranks);
        ObjDBManager.AddParameter("Person_CatID", PCategory);
        int i = 0;
        if (Photo != "")
        {
            string varFilePath = "~/RMS/NoneResidentsPictures/";
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

         //       ObjDBManager.AddParameter("@NewPhoto", file);

                // string path = "~/Pics/Image1.jpg";
                System.IO.File.Delete(HttpContext.Current.Server.MapPath(varFilePath + Photo + ".jpg"));
                i = 1;
            }
        }
                
        if (nRID == 0)
        {

            ObjDBManager.AddParameter("@created_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
            ObjDBManager.AddParameter("@created_date", DateTime.Now);
            ObjDBManager.AddParameter("card_prefix", cardPrefix); 
            ObjDBManager.AddParameter("NRID", NRID, SqlDbType.Int, 4, ParameterDirection.Output);

            ObjDBManager.InsertUpdateProcedure("NonResidentAdd", "vmsconnectionstring");
            nRID = int.Parse(ObjDBManager.Parameters[34+i].Value.ToString());
        }
        else
        {
            ObjDBManager.AddParameter("card_prefix", cardPrefix); 
            ObjDBManager.AddParameter("NRID", NRID);
            ObjDBManager.AddParameter("@modified_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
            ObjDBManager.AddParameter("@modified_date", DateTime.Now);

            ObjDBManager.InsertUpdateProcedure("NonResidentUpdate", "vmsconnectionstring");
        }
        return nRID;
    }


    [WebMethod]
    public static void DeleteNonResidentEmployeeRecord(string NRID)
    {

        string query = "update NonResident set Status='InActive' ,_status='" + 0 + "' where NRID='" + int.Parse(NRID) + "'";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }


    [WebMethod]
    public static void ActivateNonResidentRecord(string NRID)
    {

        string query = "update NonResident set Status='Active' ,_status='" + 1 + "' where NRID='" + int.Parse(NRID) + "'";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }

    [WebMethod]
    public static void BlackListNonResidentRecord(string NRID)
    {

        string query = "update NonResident set Status='BlackList' ,_status='" + 0 + "' where NRID='" + int.Parse(NRID) + "'";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    [WebMethod]
    public static Dictionary<string, object> getRanks(string catVal)
    {

        string query = "  SELECT Rank_ID,Rank_Name  FROM mctx_Ranks where is_deleted=0 and Person_CateID=" + catVal;

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(query, "RanksDetail", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["RanksDetail"];
        return ToJson(dt);
    }

    [WebMethod]
    public static Dictionary<string, object> getDesignation(string catVal)
    {

        string query = "  select Designation_ID,designation from HR_Designation where is_deleted=0 and Person_CateID in (" + catVal+")";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(query, "DesignationDetail", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["DesignationDetail"];
        return ToJson(dt);
    }
    #endregion

    #region Visitors
    [WebMethod]
    public static int SaveVisitor(string VID, string FirstName, string LastName, string NIC, string VisitPurpose,
         string Addr, string Profession, string Phone, string IssueDt, string Mobile, string ValidUpto,
        string ReferenceName, string VisitDays, string Relation, string Rank, string ReferenceAdd, string Photo, string Designation, string empID)
    {
        int vid = int.Parse(VID);
        string varFilePath = "~/RMS/VisitorPictures/";
        string fileName = NIC;
        int i = 0;

        if (Photo.Length > 16)
        {
            if (Photo != "")
            {
                File.Delete(HttpContext.Current.Server.MapPath(varFilePath + fileName + ".jpg"));

                byte[] imageBytes = Convert.FromBase64String(Photo.Split(',')[1]);
                var imagePath = HttpContext.Current.Server.MapPath(varFilePath + fileName + ".jpg");
                System.IO.File.WriteAllBytes(imagePath, imageBytes);
            }
        }
        else
        {
            if (Photo != "")
            {
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

                   System.IO.File.Delete(HttpContext.Current.Server.MapPath(varFilePath + Photo + ".jpg"));
                    i = 1;
                }
            }
        }


        DBManager ObjDBManager = new DBManager();
        
        ObjDBManager.AddParameter("FirstName", FirstName);
        ObjDBManager.AddParameter("LastName", LastName);        
        ObjDBManager.AddParameter("NIC", NIC);
        ObjDBManager.AddParameter("IssueDt", IssueDt);        
        ObjDBManager.AddParameter("Addr", Addr);
        ObjDBManager.AddParameter("Phone", Phone);
        ObjDBManager.AddParameter("Mobile", Mobile);
        ObjDBManager.AddParameter("Profession", Profession);
        ObjDBManager.AddParameter("VisitPurpose", VisitPurpose);
        ObjDBManager.AddParameter("VisitDays", VisitDays);
        ObjDBManager.AddParameter("ReferenceName", ReferenceName);
        ObjDBManager.AddParameter("ReferenceAdd", ReferenceAdd);
        ObjDBManager.AddParameter("Rank", Rank);
        ObjDBManager.AddParameter("Relation", Relation);
        ObjDBManager.AddParameter("ValidUpto", ValidUpto);        
        ObjDBManager.AddParameter("Photo", fileName);
        ObjDBManager.AddParameter("Designation_ID", Designation);
        ObjDBManager.AddParameter("EmpID", empID);
        

        if (vid == 0)
        {

            ObjDBManager.AddParameter("@created_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
            ObjDBManager.AddParameter("@created_date", DateTime.Now);
            ObjDBManager.AddParameter("VID", vid, SqlDbType.Int, 4, ParameterDirection.Output);

            ObjDBManager.InsertUpdateProcedure("VisitorAdd", "vmsconnectionstring");
            vid = int.Parse(ObjDBManager.Parameters[20 +i].Value.ToString());
        }
        else
        {
            ObjDBManager.AddParameter("VID", vid);
            ObjDBManager.AddParameter("@modified_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
            ObjDBManager.AddParameter("@modified_date", DateTime.Now);
            ObjDBManager.InsertUpdateProcedure("VisitorUpdate", "vmsconnectionstring");
        }
        return vid;
    }


    [WebMethod]
    public static void InActiveVisitorRecord(string VID)
    {

        string query = "update Visitor set Status='InActive'  where VID=" + int.Parse(VID);

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }

    [WebMethod]
    public static void ActivateVisitorRecord(string VID)
    {

        string query = "update Visitor set Status='Active'  where VID=" + int.Parse(VID);

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }

    [WebMethod]
    public static void BlackListVisitorRecord(string VID)
    {

        //string query = "update NonResident set Status='BlackList' ,_status='" + 0 + "' where NRID='" + int.Parse(NRID) + "'";
        string query = "update Visitor set Status='BlackList'  where VID=" + int.Parse(VID);
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    #endregion


    #region Contractor Information
    [WebMethod]
    public static int SaveContractorInfo(string CID, string FirmName, string ContractorName, string Gender,
        string CNIC, string FirmAddr, string ResidenceAddr, string Mobile, string OfficeNo,
        string IdentificationM, string Rank, string CLearanceStatus, string ClearanceLevel, string ValidFrom, string ValidTo, string AuthType , string Photo)

    {
        
        string fileName = CNIC;
        string varFilePath = "~/RMS/ContractorPictures/";

        int cid = int.Parse(CID);

        if (Photo.Length > 16)
        {
        
            if (Photo != "")
            {
                File.Delete(HttpContext.Current.Server.MapPath(varFilePath + fileName + ".jpg"));

                byte[] imageBytes = Convert.FromBase64String(Photo.Split(',')[1]);
                var imagePath = HttpContext.Current.Server.MapPath(varFilePath + fileName + ".jpg");
                System.IO.File.WriteAllBytes(imagePath, imageBytes);

            }
        }
        else
        {
            int i = 0;
            if (Photo != "")
            {
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

                    i = 1;
                }
            }
        }



        DBManager ObjDBManager = new DBManager();
        //ObjDBManager.AddParameter("@id", 0);
        ObjDBManager.AddParameter("FirmName", FirmName);
        ObjDBManager.AddParameter("@ContractorName", ContractorName);
        ObjDBManager.AddParameter("@Gender", Gender);
        ObjDBManager.AddParameter("@CNIC", CNIC);
        ObjDBManager.AddParameter("@FirmAddress", FirmAddr);
        ObjDBManager.AddParameter("@ResidantAddress", ResidenceAddr);
        ObjDBManager.AddParameter("@MobileNo", Mobile);
        ObjDBManager.AddParameter("@OfficeNumber", OfficeNo);
        ObjDBManager.AddParameter("@IdentificationMark", IdentificationM);
        ObjDBManager.AddParameter("@RankOrAppointment", Rank);
        ObjDBManager.AddParameter("@Photo", fileName);

        ObjDBManager.AddParameter("@ClearanceStatus", CLearanceStatus);//Convert.ToInt32(CLearanceStatus)
        ObjDBManager.AddParameter("@ClearanceLevel", ClearanceLevel);//Convert.ToInt32(ClearanceLevel)
        ObjDBManager.AddParameter("@ValidFrom", ValidFrom);
        ObjDBManager.AddParameter("@ValidTo", ValidTo);

        ObjDBManager.AddParameter("@authType", AuthType);

        

        if (cid == 0)
        {

            ObjDBManager.AddParameter("@created_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
            ObjDBManager.AddParameter("@created_date", DateTime.Now);
            ObjDBManager.AddParameter("id", cid, SqlDbType.Int, 4, ParameterDirection.Output);

            ObjDBManager.InsertUpdateProcedure("ContractorAdd", "vmsconnectionstring");
            //cid = int.Parse(ObjDBManager.Parameters[20 + i].Value.ToString());
        }
        else
        {
            ObjDBManager.AddParameter("id", cid);
            ObjDBManager.AddParameter("@modified_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
            ObjDBManager.AddParameter("@modified_date", DateTime.Now);
            ObjDBManager.InsertUpdateProcedure("ContractorUpdate", "vmsconnectionstring");
        }
        return cid;
    }


    [WebMethod]
    public static void InActiveContractorRecord(string VID)
    {

        string query = "update mctx_ContractorInformation set CStatus='InActive'  where id=" + int.Parse(VID);

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }

    [WebMethod]
    public static void ActivateContractorRecord(string VID)
    {

        string query = "update mctx_ContractorInformation set CStatus='Active'  where id=" + int.Parse(VID);

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }

    [WebMethod]
    public static void BlackListContractorRecord(string VID)
    {

        //string query = "update NonResident set Status='BlackList' ,_status='" + 0 + "' where NRID='" + int.Parse(NRID) + "'";
        string query = "update mctx_ContractorInformation set CStatus='BlackList'  where id=" + int.Parse(VID);
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    #endregion

    #region Contractor Labor
    [WebMethod]
    public static int SaveContractorLaborInfo(string CID, string ContractorName, string FirmName,
        string LaborName, string Gender, string CNIC, string PlaceofWork, string Address, string Mobile,
        string IdentificationM, string CLearanceStatus, string ClearanceLevel, string ValidFrom, string ValidTo, string AuthType, string Photo)
    {
        string varFilePath = "~/RMS/ContractorLaborPictures/";

        int cid = int.Parse(CID);
         string fileName = CNIC;
        if (Photo.Length > 16)
        {
            if (Photo != "")
            {
                File.Delete(HttpContext.Current.Server.MapPath(varFilePath + fileName + ".jpg"));

                byte[] imageBytes = Convert.FromBase64String(Photo.Split(',')[1]);
                var imagePath = HttpContext.Current.Server.MapPath(varFilePath + fileName + ".jpg");
                System.IO.File.WriteAllBytes(imagePath, imageBytes);
            }
        }
        else
        {
            int i = 0;
            if (Photo != "")
            {
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

                   i = 1;
                }
            }
        }

        DBManager ObjDBManager = new DBManager();
        //ObjDBManager.AddParameter("@id", 0);
        //int temp=int.Parse()
        ObjDBManager.AddParameter("@ContractorName", ContractorName);//Convert.ToInt32(ContractorName) 
        ObjDBManager.AddParameter("FirmName", FirmName);
        ObjDBManager.AddParameter("@LaborName", LaborName);
        ObjDBManager.AddParameter("@Gender", Gender);
        ObjDBManager.AddParameter("@CNIC", CNIC);
        ObjDBManager.AddParameter("@IdentificationMark", IdentificationM);
        ObjDBManager.AddParameter("@Placeofwork", PlaceofWork);
        ObjDBManager.AddParameter("@address", Address);
        ObjDBManager.AddParameter("@MobileNumber", Mobile);
        ObjDBManager.AddParameter("@Photo", fileName);
        ObjDBManager.AddParameter("@ClearanceStatus", CLearanceStatus);//Convert.ToInt32(CLearanceStatus)
        ObjDBManager.AddParameter("@ClearanceLevel", ClearanceLevel);//Convert.ToInt32(ClearanceLevel)
        ObjDBManager.AddParameter("@ValidFrom", ValidFrom);
        ObjDBManager.AddParameter("@ValidTo", ValidTo);
        ObjDBManager.AddParameter("@AuthType", AuthType);

        
        if (cid == 0)
        {

            ObjDBManager.AddParameter("@created_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
            ObjDBManager.AddParameter("@created_date", DateTime.Now);
            ObjDBManager.AddParameter("id", cid, SqlDbType.Int, 4, ParameterDirection.Output);

            ObjDBManager.InsertUpdateProcedure("ContractorLaborAdd", "vmsconnectionstring");
            //cid = int.Parse(ObjDBManager.Parameters[20 + i].Value.ToString());
        }
        else
        {
            ObjDBManager.AddParameter("id", cid);
            ObjDBManager.AddParameter("@modified_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
            ObjDBManager.AddParameter("@modified_date", DateTime.Now);
            ObjDBManager.InsertUpdateProcedure("ContractorLaborUpdate", "vmsconnectionstring");
        }
        return cid;
    }


    [WebMethod]
    public static void InActiveContractorLaborRecord(string VID)
    {

        string query = "update mctx_ContractorLaborInformation set CStatus='InActive'  where id=" + int.Parse(VID);

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }

    [WebMethod]
    public static void ActivateContractorLaborRecord(string VID)
    {

        string query = "update mctx_ContractorLaborInformation set CStatus='Active'  where id=" + int.Parse(VID);

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }

    [WebMethod]
    public static void BlackListContractorLaborRecord(string VID)
    {

        //string query = "update NonResident set Status='BlackList' ,_status='" + 0 + "' where NRID='" + int.Parse(NRID) + "'";
        string query = "update mctx_ContractorLaborInformation set CStatus='BlackList'  where id=" + int.Parse(VID);
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    #endregion


    #region BusinessCommunity Detail
    [WebMethod]
    public static int SaveBusinessCommunityDetailInfo(string CID, string BCDName, string Gender, string CNIC, string Designation,
        string FatherName, string Dob, string Address, string IdentificationM, string BusinessCommunityCat, string BloodGroup,
        string CLearanceStatus, string ClearanceLevel, string ValidFrom, string ValidTo, string AuthType, string Photo)
    {
        

        string fileName = CNIC;
        string varFilePath = "~/RMS/BusinessCommunityDetailPictures/";
        int cid = int.Parse(CID);

        if (Photo.Length > 16)
        {
            if (Photo != "")
            {
                File.Delete(HttpContext.Current.Server.MapPath(varFilePath + fileName + ".jpg"));

                byte[] imageBytes = Convert.FromBase64String(Photo.Split(',')[1]);
                var imagePath = HttpContext.Current.Server.MapPath(varFilePath + fileName + ".jpg");
                System.IO.File.WriteAllBytes(imagePath, imageBytes);
            }
        }
        else
        {
            int i = 0;
            if (Photo != "")
            {
                

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
                    i = 1;
                }
            }

        }


        DBManager ObjDBManager = new DBManager();
        ObjDBManager.AddParameter("@CNIC", CNIC);
        ObjDBManager.AddParameter("@Name", BCDName);
        ObjDBManager.AddParameter("@Gender", Gender);
        ObjDBManager.AddParameter("@DOB", Dob);
        ObjDBManager.AddParameter("@address", Address);
        ObjDBManager.AddParameter("@FatherName", FatherName);
        ObjDBManager.AddParameter("@IdentificationMark", IdentificationM);
        ObjDBManager.AddParameter("@BloodGroup", BloodGroup);
        ObjDBManager.AddParameter("@ValidityFrom", ValidFrom);
        ObjDBManager.AddParameter("@ValidityTo", ValidTo);
        ObjDBManager.AddParameter("@BusinessCommunityCategory", BusinessCommunityCat);
        ObjDBManager.AddParameter("@Designation", Designation);
        ObjDBManager.AddParameter("@Photo",fileName);
        ObjDBManager.AddParameter("@ClearanceLevel", ClearanceLevel);
        ObjDBManager.AddParameter("@ClearanceStatus", AuthType);

        ObjDBManager.AddParameter("@authType", AuthType);

        

        if (cid == 0)
        {

            ObjDBManager.AddParameter("@created_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
            ObjDBManager.AddParameter("@created_date", DateTime.Now);
            ObjDBManager.AddParameter("Id", cid, SqlDbType.Int, 4, ParameterDirection.Output);

            ObjDBManager.InsertUpdateProcedure("BusinessCommunityDetailAdd", "vmsconnectionstring");
            //cid = int.Parse(ObjDBManager.Parameters[20 + i].Value.ToString());
        }
        else
        {
            ObjDBManager.AddParameter("Id", cid);
            ObjDBManager.AddParameter("@modified_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
            ObjDBManager.AddParameter("@modified_date", DateTime.Now);
            ObjDBManager.InsertUpdateProcedure("BusinessCommunityDetailUpdate", "vmsconnectionstring");
        }
        return cid;
    }


    [WebMethod]
    public static void InActiveBusinessCommunityDetailRecord(string VID)
    {

        string query = "update mctx_BusinessCommunityDetail set CStatus='InActive'  where id=" + int.Parse(VID);

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }

    [WebMethod]
    public static void ActivateBusinessCommunityDetailRecord(string VID)
    {

        string query = "update mctx_BusinessCommunityDetail set CStatus='Active'  where id=" + int.Parse(VID);

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }

    [WebMethod]
    public static void BlackListBusinessCommunityDetailRecord(string VID)
    {

        //string query = "update NonResident set Status='BlackList' ,_status='" + 0 + "' where NRID='" + int.Parse(NRID) + "'";
        string query = "update mctx_BusinessCommunityDetail set CStatus='BlackList'  where id=" + int.Parse(VID);
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    #endregion



    #region Guest
    [WebMethod]
    public static int SaveGuest(string GID, string EID, string GuestName, string FatherName,
       string CNIC, string Gender, string DOB, string Addr, string Age, string Occupation,
       string Nationality, string ValidTo, string ValidFrom, string MarkofIdentification,
       string Mobile, string GuestSecurity, string ClearanceLevel, string RelationType, string AuthType, string Photo)
    {
        string fileName = CNIC;
        string varFilePath = "~/RMS/EmpPictures/EmpGuestPicture/";
        if (Photo.Length > 16)
        {
            if (Photo != "")
            {
                File.Delete(HttpContext.Current.Server.MapPath(varFilePath + fileName + ".jpg"));

                byte[] imageBytes = Convert.FromBase64String(Photo.Split(',')[1]);
                var imagePath = HttpContext.Current.Server.MapPath(varFilePath + fileName + ".jpg");
                System.IO.File.WriteAllBytes(imagePath, imageBytes);
            }
        }
        else
        {
            int i = 0;
            if (Photo != "")
            {
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
                    i = 1;
                }
            }

        }

        


        int gid = int.Parse(GID);
        int eid = int.Parse(EID);
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.AddParameter("@EID", EID);
        ObjDBManager.AddParameter("@CNIC", CNIC);
        ObjDBManager.AddParameter("@Name", GuestName);
        ObjDBManager.AddParameter("@RelationType", RelationType);
        ObjDBManager.AddParameter("@Nationality", Nationality);
        ObjDBManager.AddParameter("@FatherName", FatherName);
        ObjDBManager.AddParameter("@Address", Addr);
        ObjDBManager.AddParameter("@MobileNumber", Mobile);
        ObjDBManager.AddParameter("@IdentificationMark", MarkofIdentification);
        ObjDBManager.AddParameter("@SecurityClearance", GuestSecurity);
        ObjDBManager.AddParameter("@ValidityFrom", ValidFrom);
        ObjDBManager.AddParameter("@ValidityTo", ValidTo);
        ObjDBManager.AddParameter("@DOB", DOB);
        ObjDBManager.AddParameter("@Age", Age);
        ObjDBManager.AddParameter("@Gender", Gender);
        ObjDBManager.AddParameter("@Occupation", Occupation);
        ObjDBManager.AddParameter("@ClearLevel", ClearanceLevel);
        ObjDBManager.AddParameter("@AuthType", AuthType);
        ObjDBManager.AddParameter("@photo", fileName);


        

        if (int.Parse(GID) == 0)
        {

            ObjDBManager.AddParameter("@created_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
            ObjDBManager.AddParameter("@created_date", DateTime.Now);
            ObjDBManager.AddParameter("GID", gid, SqlDbType.Int, 4, ParameterDirection.Output);

            ObjDBManager.InsertUpdateProcedure("GuestAdd", "vmsconnectionstring");
            // sid = int.Parse(ObjDBManager.Parameters[17+i].Value.ToString());
        }
        else
        {
            ObjDBManager.AddParameter("GID", GID);
            ObjDBManager.AddParameter("@modified_by", HttpContext.Current.Profile.GetPropertyValue("UserId"));
            ObjDBManager.AddParameter("@modified_date", DateTime.Now);
            ObjDBManager.InsertUpdateProcedure("GuestUpdate", "vmsconnectionstring");



            //var user = HttpContext.Current.Profile.GetPropertyValue("UserId");
            //string query = "update Guest set " +
            //" FirstName='" + FirstName + "',LastName='" + LastName + "',FH='" + FH + "',CurrAddr='" + CurrAddr + "',PerAddr='" + PerAddr + "',Caste='',DOB='" + DOB + "', " +
            //" PlaceofWork='" + PlaceofWork + "',NIC='" + NIC + "',Religion='" + Religion + "',MarkofIdentification='" + MarkofIdentification + "',Photo='" + Photo + "',phoneoffice='" + PhoneOffice + "',phonehome='" + Phonehome + "',mobile='" + Mobile + "',modified_by='"+user+"',modified_date='"+DateTime.Now+"' " +
            //" where SID='"+sid+"' ";

            //DBManager ObjDBManager2 = new DBManager();
            //ObjDBManager2.InsertUpdateQuery(query, "vmsconnectionstring");
        }
        return gid;
    }

    #endregion
    [WebMethod]
    public static void InactiveGuestRecord(string SID)
    {


        string query = "update ResidantGuest set CStatus='InActive' where GID='" + int.Parse(SID) + "'";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }

    [WebMethod]
    public static void ActivateGuestRecord(string SID)
    {

        string query = "update ResidantGuest set CStatus='Active' where GID='" + int.Parse(SID) + "'";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    [WebMethod]
    public static void BlackListGuestRecord(string SID)
    {

        string query = "update ResidantGuest set CStatus='BlackList' where GID='" + int.Parse(SID) + "'";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }

    #region---Get Guest Name
    [WebMethod]
    public static string GetGuestName(string EID)
    {
        string stateNotes = string.Empty;
        string cs = ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ConnectionString;
        using (SqlConnection con = new SqlConnection(cs))
        {
            using (SqlCommand cmd = new SqlCommand("GetHostName", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EID", int.Parse(EID));
                stateNotes = cmd.ExecuteScalar().ToString();
            }
        }
        return stateNotes;
    }
    #endregion

    #region---Get Guest Name
    [WebMethod]
    public static string GetRank(string EID)
    {
        string stateNotes = string.Empty;
        string cs = ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ConnectionString;
        using (SqlConnection con = new SqlConnection(cs))
        {
            using (SqlCommand cmd = new SqlCommand("GetRenk", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EID", int.Parse(EID));
                stateNotes = cmd.ExecuteScalar().ToString();
            }
        }
        return stateNotes;
    }
    #endregion

    public static byte[] String_To_Bytes2(string strInput)
    {
        int numBytes = (strInput.Length) / 2;
        byte[] bytes = new byte[numBytes];
        for (int x = 0; x < numBytes; ++x)
        {
            bytes[x] = Convert.ToByte(strInput.Substring(x * 2, 2), 16);
        }
        return bytes;
    }

}