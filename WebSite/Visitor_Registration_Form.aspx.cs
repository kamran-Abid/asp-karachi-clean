using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Web.Services;
using System.Drawing;
using System.Data.SqlClient;
using System.Text;
using System.Configuration;
public partial class Visitor_Registration_Form : System.Web.UI.Page
{
    Common ObjCommon = new Common();
    //private object ObjCommon;

    //public object ObjCommon { get; private set; }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

           
            //DataTable Department = ObjCommon.GetDepartment();
            //ddlDepartment.DataSource = Department;
            //ddlDepartment.DataValueField = "Department_ID";
            //ddlDepartment.DataTextField = "Department_Name";
            //ddlDepartment.DataBind();
            //ddlDepartment.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));


            DataTable dtDepartments2 = ObjCommon.GetDepartments();
            ddlDeptUnit.DataSource = dtDepartments2;
            ddlDeptUnit.DataValueField = "Department_Id";
            ddlDeptUnit.DataTextField = "Department_Name";
            ddlDeptUnit.DataBind();
            ddlDeptUnit.Items.Insert(0, new ListItem("-- Select --", ""));

            DataTable EmpVMS = ObjCommon.GetEmpVMS();
            DropDownList1.DataSource = EmpVMS;
            DropDownList1.DataValueField = "NIC";
            DropDownList1.DataTextField = "FullName";
            DropDownList1.DataBind();
            DropDownList1.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select--", ""));

            //#region PlaceDDL
            ////SqlCommand cmdPlace = new SqlCommand("select ID, LocationName from Place", cn);
            //DataTable PlaceVMS = ObjCommon.GetPlaceVMS();
            //DropDownList2.DataSource = PlaceVMS;
            //DropDownList2.DataTextField = "LocationName";
            //DropDownList2.DataValueField = "ID";
            //DropDownList2.DataBind();
            //DropDownList2.Items.Insert(0, "--Select--");
            //#endregion



            //#region PurposeDDL
            //SqlCommand cmdPurpose = new SqlCommand("SELECT Purpose_ID,Purpose_Name from Purpose_Tbl WHERE deleted=0 order by Purpose_Name", cn);
            //SqlDataAdapter daPurpose = new SqlDataAdapter(cmdPurpose);
            //DataTable dtPurpose = new DataTable();
            //daPurpose.Fill(dtPurpose);

            //DropDownList3.DataSource = dtPurpose;
            //DropDownList3.DataTextField = "Purpose_Name";
            //DropDownList3.DataValueField = "Purpose_ID";
            //DropDownList3.DataBind();
            //DropDownList3.Items.Insert(0, "--Select--");
            //#endregion


            //#region DDL VisitArea
            //SqlCommand cmdVisitArea = new SqlCommand("SELECT [VisitArea_ID],[VisitAreaName] FROM [dbo].[VisitArea]", cn);
            //SqlDataAdapter daVisitArea = new SqlDataAdapter(cmdVisitArea);
            //DataTable dtVisitArea = new DataTable();
            //daVisitArea.Fill(dtVisitArea);

            //DDLVisitArea.DataSource = dtVisitArea;
            //DDLVisitArea.DataTextField = "VisitAreaName";
            //DDLVisitArea.DataValueField = "VisitArea_ID";
            //DDLVisitArea.DataBind();
            //DDLVisitArea.Items.Insert(0, "--Select--");
            //#endregion


            //#region   VisitArea
            //DataTable VisitArea = ObjCommon.VisitArea();
            //DDLCarMake.DataSource = VisitArea;
            //DDLVisitArea.DataTextField = "VisitAreaName";
            //DDLVisitArea.DataValueField = "VisitArea_ID";
            //DDLVisitArea.DataBind();
            //DDLVisitArea.Items.Insert(0, "--Select--");
            //#endregion

            //#region DDL VisitArea
            //SqlCommand cmdVisitArea = new SqlCommand("SELECT [VisitArea_ID],[VisitAreaName] FROM [dbo].[VisitArea]");
            //SqlDataAdapter daVisitArea = new SqlDataAdapter(cmdVisitArea);
            //DataTable dtVisitArea = new DataTable();
            //daVisitArea.Fill(dtVisitArea);

            //DDLVisitArea.DataSource = dtVisitArea;
            //DDLVisitArea.DataTextField = "VisitAreaName";
            //DDLVisitArea.DataValueField = "VisitArea_ID";
            //DDLVisitArea.DataBind();
            //DDLVisitArea.Items.Insert(0, "--Select--");
            //#endregion


            #region DDL DDLCarColor
            //SqlCommand cmdCarColor = new SqlCommand("select CardColor_ID, ColorName from CardColor", cn);
            //SqlDataAdapter daCarColor = new SqlDataAdapter(cmdCarColor);
            DataTable CardColorVMS = ObjCommon.GetCardColorVMS();

            //DataTable dtCarColor = new DataTable();
            //daCarColor.Fill(dtCarColor);

            DDLCarColor.DataSource = CardColorVMS;
            DDLCarColor.DataTextField = "TransportColour";
            DDLCarColor.DataValueField = "id";
            DDLCarColor.DataBind();
            DDLCarColor.Items.Insert(0, "--Select--");
            #endregion


            #region DDL DDLCarMake
            DataTable CarMakeVMS = ObjCommon.GetCarMakeVMS();
            DDLCarMake.DataSource = CarMakeVMS;
            DDLCarMake.DataTextField = "TransportMake";
            DDLCarMake.DataValueField = "id";
            DDLCarMake.DataBind();
            DDLCarMake.Items.Insert(0, "--Select--");
            #endregion




            //for (int i = 1950; i <= DateTime.Now.Year; i++)
            //{
            //    DDLCModel.Items.Add(i.ToString());
            //}

            #region DDL DDLDesignation
            DataTable GetLatestDesignation = ObjCommon.GetLatestDesignation();

            DDLDesignation.DataSource = GetLatestDesignation;
            DDLDesignation.DataTextField = "designation";
            DDLDesignation.DataValueField = "Designation_ID";
            DDLDesignation.DataBind();
            DDLDesignation.Items.Insert(0, "--Select--");
            #endregion


            //DDLVarient
            // DDL Varient End
            //#region   DDLDesignation
            //DataTable GetLatestDesignation1 = ObjCommon.GetLatestDesignation();

            //DDLDesignation.DataSource = GetLatestDesignation1;
            //DDLDesignation.DataTextField = "designation";
            //DDLDesignation.DataValueField = "Designation_ID";
            //DDLDesignation.DataBind();
            //DDLDesignation.Items.Insert(0, "--Select--");
            //#endregion

        }

    }



    [System.Web.Services.WebMethod]
    public static string creat_byte(int id)
    {

        string output = "";
        try
        {
            string file_path = HttpContext.Current.Server.MapPath("~/MediaUploader/Visitor/" + id + ".jpg");

            byte[] fileBytes = ReadFile(file_path);

            //DB.executeSQLP("update fbt_resource_m set picture =@fileBytes where pk_id= " + id + "", "@fileBytes", fileBytes);
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ToString()))
            {
                string query = "UPDATE [dbo].[Visitor_Tbl]" +
                    "SET[ImageName] = '/MediaUploader/Visitor/" + id + ".jpg'," +
                    "[ImageData] = '" + fileBytes + "'" +
                    " WHERE V_ID = '" + id + "'";

                SqlCommand cmd = new SqlCommand(query, cn);
                cn.Open();
                cmd.ExecuteNonQuery();

                cn.Close();

            }
        }
        catch (Exception ex) { }
        return output;

    }

    //[System.Web.Services.WebMethod]
    //public static string creat_byte(int id)
    //{

    //    string output = "";

    //    string file_path = HttpContext.Current.Server.MapPath("/MediaUploader/" + id + ".jpg");
    //    byte[] fileBytes = myUploadedImg.ReadFile(file_path);

    //    clsDB DB = new clsDB();
    //    DB.executeSQLP("update fbt_resource_m set picture =@fileBytes where pk_id= " + id + "", "@fileBytes", fileBytes);

    //    return output;
    //}
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
    #region SearchVisitor

    public static Dictionary<string, object> SearchVisitor(string CNIC)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ToString()))
        {
            string Query = "SELECT * FROM [dbo].[Visitor_Tbl] WHERE ((CNIC='" + CNIC + "') OR (Uniq_Code='" + CNIC + "'))";
            SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(ds, "ProjDetails");
            dt = ds.Tables["ProjDetails"];
            return ToJson(dt);
        }
    }
    #endregion

    //DeleteVisitor
    //    [WebMethod]
    //#region DeleteVisitor
    //public static void DeleteITProjs(string ProjID)
    //{
    //    DateTime Date = DateTime.Parse(DateTime.Now.ToShortDateString());
    //    using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ToString()))
    //    {
    //        SqlCommand cmd = new SqlCommand("UPDATE [dbo].[StaffRegF1Tbl] SET Deleted='true' WHERE Unique_ID='" + ProjID + "'", cn);
    //        cn.Open();
    //        cmd.ExecuteNonQuery();
    //    }
    //}
    //#endregion




    [WebMethod]
    #region saveVisitor

    //public static string SaveVisitor(string FullName, string FatherName, string CNIC, string DOB, string CompanyName, string DoVisit, string address,string Person_v,string Place_v,string Purpose_v)
    //public static string SaveVisitor(string Unique_ID,string FullName, string FatherName,
    //    string CNIC, string DOB,string address, string MobileNO, string Parent_Org, string Designation, 
    //    string EmpNo, string PassportNo, string Email, string DrivLic, string CReg,
    //    string CMake, string Cmodel, string CColor, string Person_v, string Place_v,
    //    string Purpose_v, string CompanyName, string DoVisit, string VisitArea)

    public static string SaveVisitor(string UniqueID, string FullName, string FatherName, string Cnic, string Dob,
        string address, string Organization, string Designation, string Department, string EmpNo, string PassportNo, string Email, string MobNo,
        string Cmake, string CRegNo, string CColor, string CVarient, string CModel, string DLic, string Employee, string DoVisit, string VisitArea, string Purpose_v)//, string Comp_name  , ,  , string Floor
    {//string VisitFrom, string VisitTo, byte[] img
     // if (Cmake == "0" || Cmake == "--Select--")
     //{
        DLic = "";
        Cmake = "";
        CVarient = "";
        //CColor = " + CColor + ";
        CModel = "";
        if (CColor == "--Select--")
        {
            CColor = "";
        }
        if (Designation == "--Select--")
        {
            Designation = "";
        }
        if (Department == "--Select--")
        {
            Department = "";
        }
        if (EmpNo == "undefined")
        {
            EmpNo = "";
        }
        //if Pass
        //}
        //string retunid = "";
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ToString()))
        {
            try
            {
                cn.Open();
                string q2 = "Select V_ID from Visitor_Tbl WHERE CNIC='" + Cnic + "'";
                SqlDataAdapter SDA2 = new SqlDataAdapter(q2, cn);
                DataTable SDT2 = new DataTable();
                SDA2.Fill(SDT2);
                if (SDT2.Rows.Count < 1)
                {
                    //string query = "INSERT INTO [dbo].[Visitor_Tbl] ([Uniq_Code],[Full_Name]," +
                    //"[Father_Name],[CNIC],[Address],[DoB],[Person_To_Visit],[Place_To_Visit]," +
                    //"[Purpose_To_Visit],[Status],[DateofVisit],[Company_ID],[RFID],[ParentOrg]," +
                    //"[Designation],[EmpNo],[PassportNo],[Email],[DrivLic],[CReg],[Cmake],[Cmodel]," +
                    //"[CColor],[VisitArea],[TimeIn],[TimeOut],[EnglishName],[AuthenticationType]," +
                    //"[CardExpire],[StrStatus],[ImageName],[ImageData],[imgSize]," +
                    //"[Deleted]) VALUES " +
                    //"('" + Unique_ID + "','" + FullName + "','" + FatherName + "','" + CNIC + "','" + address + "'," +
                    //"'" + DOB + "','" + Person_v + "','" + Place_v + "','" + Purpose_v + "','Pending','" + DoVisit + "'," +
                    //"'" + CompanyName + "',null,'" + Parent_Org + "','" + Designation + "','" + EmpNo + "'," +
                    //"'" + PassportNo + "','" + Email + "','" + DrivLic + "','" + CReg + "','" + CMake + "'," +
                    //"'" + Cmodel + "','" + CColor + "','" + VisitArea + "',null,null,null,null,null,'Active',null,null,null,'false')";

                    string query = "INSERT INTO [dbo].[Visitor_Tbl]([Uniq_Code],[Full_Name],[Father_Name]," +
                   "[CNIC],[Address],[DoB],[PhoneNo],[Person_To_Visit]," +//  [Place_To_Visit],
                   "[Status],[DateofVisit],[RFID],[VisitorOrganization],[Designation],[Department],[EmpNo]," +//,[Company_ID]
                   "[PassportNo],[Email],[DrivLic],[CReg],[Cmake],[CVariant],[Cmodel],[CColor],[VisitArea]," +
                   "[TimeIn],[TimeOut],[EnglishName],[AuthenticationType],[CardExpire],[StrStatus],[ImageName]," +
                   "[ImageData],[imgSize],[Deleted],[Purpose_To_Visit] )" +
                   "VALUES" +
                   "('" + UniqueID + "','" + FullName + "','" + FatherName + "','" + Cnic + "'," +
                   "'" + address + "','" + Dob + "','" + MobNo + "','" + Employee + "'," +//,'" + Floor + "',
                   "'Approved','" + DoVisit + "',''," +//,'" + Comp_name + "' ,
                   "'" + Organization + "','" + Designation + "','" + Department + "','" + EmpNo + "','" + PassportNo + "','" + Email + "'," +
                   "'" + DLic + "','" + CRegNo + "','" + Cmake + "','" + CVarient + "','" + CModel + "','" + CColor + "'," +
                   "'" + VisitArea + "','','','','1'," +
                   "'','Active','','','','false','" + Purpose_v + "')";

                    SqlCommand cmd = new SqlCommand(query, cn);
                    cmd.ExecuteNonQuery();
                }
                else
                {
                    // 


                    string query = "UPDATE [dbo].[Visitor_Tbl] SET " +
                          "[Uniq_Code] = '" + UniqueID + "' ," +
                          "[Full_Name] = '" + FullName + "' ," +
                          "[Father_Name] =  '" + FatherName + "' ," +
                          "[CNIC] =  '" + Cnic + "' ," +
                          "[Address] =  '" + address + "' ," +
                          "[DoB] = '" + Dob + "' ," +
                          "[PhoneNo] = '" + MobNo + "' ," +
                          "[Person_To_Visit] =  '" + Employee + "' ," +
                          //"[Place_To_Visit] =  '" + Floor + "' ," +

                          "[Status] =  'Approved' ," +
                          "[DateofVisit] =  '" + DoVisit + "' ," +
                          //"[Company_ID] =  '" + Comp_name + "' ," +
                          "[VisitorOrganization] =  '" + Organization + "' ," +
                          "[Designation] =  '" + Designation + "' ," +
                          "[Department] =  '" + Department + "' ," +
                          "[EmpNo] =  '" + EmpNo + "' ," +
                          "[PassportNo] = '" + PassportNo + "' ," +
                          "[Email] =  '" + Email + "' ," +
                          "[DrivLic] = '" + DLic + "' ," +
                          "[CReg] = '" + CRegNo + "' ," +
                          "[Cmake] =  '" + Cmake + "' ," +
                          "[CVariant] = '" + CVarient + "' ," +
                          "[Cmodel] =  '" + CModel + "' ," +
                          "[CColor] =  '" + CColor + "' ," +
                          "[VisitArea] =  '" + VisitArea + "' ," +
                          "[StrStatus] =  'Active' ," +
                          //"[ImageName] =  '' ," +
                          //"[ImageData] =  '' ," +
                          //"[imgSize] =  '"++"' ," +
                          "[Deleted] = 'false', " +
                          "[Purpose_To_Visit] =  '" + Purpose_v + "'" +
                          "WHERE V_ID = '" + SDT2.Rows[0][0].ToString() + "'";
                    SqlCommand cmd = new SqlCommand(query, cn);
                    cmd.ExecuteNonQuery();
                }


                string q = "select Max(V_ID) from Visitor_Tbl";
                SqlDataAdapter SDA = new SqlDataAdapter(q, cn);
                DataTable SDT = new DataTable();
                SDA.Fill(SDT);
                string vid = SDT.Rows[0][0].ToString();
                cn.Close();
                return vid;
            }
            catch (Exception ex)
            {
                return ""; //execption
            }

        }
        //return retunid;
    }
    //HttpPostedFile postedFile = FileUpload1.PostedFile;
    //string filename = Path.GetFileName(postedFile.FileName);
    //string fileExtension = Path.GetExtension(filename);
    //int fileSize = postedFile.ContentLength;

    //if (fileExtension.ToLower() == ".jpg" || fileExtension.ToLower() == ".gif"
    //    || fileExtension.ToLower() == ".png" || fileExtension.ToLower() == ".bmp")
    //{
    //    Stream stream = postedFile.InputStream;
    //    BinaryReader binaryReader = new BinaryReader(stream);
    //    Byte[] bytes = binaryReader.ReadBytes((int)stream.Length);
    //}
    //}
    #endregion

    public static byte[] ReadFile(string sPath)
    {
        //Initialize byte array with a null value initially.
        byte[] data = null;

        //Use FileInfo object to get file size.
        FileInfo fInfo = new FileInfo(sPath);
        long numBytes = fInfo.Length;

        //Open FileStream to read file
        FileStream fStream = new FileStream(sPath, FileMode.Open, FileAccess.Read);

        //Use BinaryReader to read file stream into byte array.
        BinaryReader br = new BinaryReader(fStream);

        //When you use BinaryReader, you need to supply number of bytes 
        //to read from file.
        //In this case we want to read entire file. 
        //So supplying total number of bytes.
        data = br.ReadBytes((int)numBytes);

        return data;
    }


    #region Visitor Check
    [WebMethod]
    public static Dictionary<string, object> GetVisitorByCNIC(string CNIC)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ToString()))
        {
            //string Query = "SELECT COUNT[V_ID] as Counts FROM [Visitor_Tbl] where CNIC='" + CNIC + "'";
            string Query = "SELECT [V_ID] FROM [Visitor_Tbl] where CNIC='" + CNIC + "'";
            SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(ds, "GetVisitorCountTable");
            dt = ds.Tables["GetVisitorCountTable"];
            return ToJson(dt);
        }
    }
    #endregion

    #region Visitor Check By UID
    [WebMethod]
    public static Dictionary<string, object> GetVisitorByUID(string uniqueID)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ToString()))
        {
            //string Query = "SELECT COUNT[V_ID] as Counts FROM [Visitor_Tbl] where CNIC='" + CNIC + "'";
            string Query = "SELECT [V_ID] FROM [Visitor_Tbl] where Uniq_Code='" + uniqueID + "'";
            SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(ds, "GetVisitorCountTable");
            dt = ds.Tables["GetVisitorCountTable"];
            return ToJson(dt);
        }
    }
    #endregion


    #region HeadCount Timer
    public static class PageUtility
    {
        public static void MessageBox(System.Web.UI.Page page, string strMsg)
        {
            //+ character added after strMsg "')"
            ScriptManager.RegisterClientScriptBlock(page, page.GetType(), "alertMessage", "alert('" + strMsg + "')", true);

        }
    }
    protected void HeadCountTimer_Tick(object sender, EventArgs e)
    {
        //txtTimer.Text = DateTime.Now.ToString();
        if (DateTime.Now.ToString("HH:mm") == "17:00" || DateTime.Now.ToString("HH:mm") == "17:50")
        {
            PageUtility.MessageBox(this, "Head Count: " + HeadCounter());
        }
    }

    public string HeadCounter()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ToString()))
        {
            string Query = "SELECT COUNT(vid)FROM [dbo].[mctx_visitorlog] WHERE TIME_OUT IS NULL AND DATE='" + DateTime.Now.ToString("dd/MM/yyyy") + "'";
            //06/03/2021
            ////" + DateTime.Now.ToString("dd/MM/yyyy") + "
            SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(ds, "ProjDetails");
            dt = ds.Tables["ProjDetails"];
            //int headCount = Convert.ToInt32(dt.Rows[0][0].ToString());
            string headCount = dt.Rows[0][0].ToString();
            return headCount;
        }
    }

    //protected void Button1_Click(object sender, EventArgs e)
    //{

    //}
    #endregion



    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            DataTable abc = new DataTable();
            abc = DBCommonMethods.GetEmployeeDesignationSelectIndexChange(DropDownList1.SelectedValue.ToString());
            if (abc.Rows.Count > 0)
            {
                DDLDesignation.SelectedValue = abc.Rows[0]["Designation_ID"].ToString();
                ddlDeptUnit.SelectedValue = abc.Rows[0]["Department_Id"].ToString();
            }
        }
        catch (Exception ex) { }



    }
}