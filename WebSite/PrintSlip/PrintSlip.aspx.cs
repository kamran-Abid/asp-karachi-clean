using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Runtime.Serialization.Json;
using System.Web.Script.Serialization;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;

public partial class PrintSlip_PrintSlip : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            ToDateFrom.Text = DateTime.Today.ToString("MM/dd/yyyy");
            Common ObjCommon = new Common();

            ddhours.Items.Insert(0, new ListItem("--Hours--", ""));
            ddhours.Items.Insert(1, new ListItem("00", "00"));
            ddhours.Items.Insert(2, new ListItem("01", "01"));
            ddhours.Items.Insert(3, new ListItem("02", "02"));
            ddhours.Items.Insert(4, new ListItem("03", "03"));
            ddhours.Items.Insert(5, new ListItem("04", "04"));
            ddhours.Items.Insert(6, new ListItem("05", "05"));
            ddhours.Items.Insert(7, new ListItem("06", "06"));
            ddhours.Items.Insert(8, new ListItem("07", "07"));
            ddhours.Items.Insert(9, new ListItem("08", "08"));
            ddhours.Items.Insert(10, new ListItem("09", "09"));
            ddhours.Items.Insert(11, new ListItem("10", "10"));
            ddhours.Items.Insert(12, new ListItem("11", "11"));
            ddhours.Items.Insert(13, new ListItem("12", "12"));
            ddhours.Items.Insert(14, new ListItem("13", "13"));
            ddhours.Items.Insert(15, new ListItem("14", "14"));
            ddhours.Items.Insert(16, new ListItem("15", "15"));
            ddhours.Items.Insert(17, new ListItem("16", "16"));
            ddhours.Items.Insert(18, new ListItem("17", "17"));
            ddhours.Items.Insert(19, new ListItem("18", "18"));
            ddhours.Items.Insert(20, new ListItem("19", "19"));
            ddhours.Items.Insert(21, new ListItem("20", "20"));
            ddhours.Items.Insert(22, new ListItem("21", "21"));
            ddhours.Items.Insert(23, new ListItem("22", "22"));
            ddhours.Items.Insert(24, new ListItem("23", "23"));

            ddmunits.Items.Insert(0, new ListItem("--Minutes--", ""));
            ddmunits.Items.Insert(1, new ListItem("00", "00"));
            ddmunits.Items.Insert(2, new ListItem("05", "05"));
            ddmunits.Items.Insert(3, new ListItem("10", "10"));
            ddmunits.Items.Insert(4, new ListItem("15", "15"));
            ddmunits.Items.Insert(5, new ListItem("20", "20"));
            ddmunits.Items.Insert(6, new ListItem("25", "25"));
            ddmunits.Items.Insert(7, new ListItem("30", "30"));
            ddmunits.Items.Insert(8, new ListItem("35", "35"));
            ddmunits.Items.Insert(9, new ListItem("40", "40"));
            ddmunits.Items.Insert(10, new ListItem("45", "45"));
            ddmunits.Items.Insert(11, new ListItem("50", "50"));
            ddmunits.Items.Insert(12, new ListItem("55", "55"));
            DataTable dtDepartments = ObjCommon.GetDepartmentsForResidentSearch();
            ddlDepartmentSearch.DataSource = dtDepartments;
            ddlDepartmentSearch.DataValueField = "Department_ID";
            ddlDepartmentSearch.DataTextField = "Department_Name";
            ddlDepartmentSearch.DataBind();
            ddlDepartmentSearch.Items.Insert(0, new ListItem("-- Select Dpt --", ""));

            DataTable ddDesignations = ObjCommon.GetDesignation();
            ddDesignation.DataSource = ddDesignations;
            ddDesignation.DataValueField = "Designation_ID";
            ddDesignation.DataTextField = "designation_Name";
            ddDesignation.DataBind();
            ddDesignation.Items.Insert(0, new ListItem("-- Select Designation--", ""));



            DataTable dtrealationship = ObjCommon.GetRelationship();
            txtrelation.DataSource = dtrealationship;
            txtrelation.DataValueField = "Relation_ID";
            txtrelation.DataTextField = "Relation_Name";
            txtrelation.DataBind();
            txtrelation.Items.Insert(0, new ListItem("-- Select Relationship --", ""));

            ddtype.Items.Insert(0, new ListItem("--Select Visitor Type--", ""));
            ddtype.Items.Insert(1, new ListItem("Guest", "Guest"));
            ddtype.Items.Insert(2, new ListItem("Contractor", "Contractor"));
            ddtype.Items.Insert(3, new ListItem("Labour-Contractor Employee", "Labour-Contractor Employee"));
        }
    }
    //protected void OnSelectedIndexChanged(object sender, EventArgs e)
    //{

    //    int empid = int.Parse(ddlDepartmentSearch.SelectedValue);
    //    Common ObjCommon = new Common();

    //   /// DataTable dtDepartments = ObjCommon.GetEmployeeNameId(empid);
    //   // ddempName.DataSource = dtDepartments;
    //   // ddempName.DataValueField = "EID";
    //   // ddempName.DataTextField = "Names";
    //   // ddempName.DataBind();
    //   ///// ddempName.Items.Insert(0, new ListItem("--Search Employee--", ""));

    //}

    #region----Get Guest
    [WebMethod]
    public static string GetGuestImages(string nic)
    {

        string strdocPath;
        try
        {
            strdocPath = HttpContext.Current.Server.MapPath("~/RMS/EmpPictures/EmpGuestPicture/" + nic + ".jpg");
            FileStream objfilestream = new FileStream(strdocPath, FileMode.Open, FileAccess.Read);
            int len = (int)objfilestream.Length;
            Byte[] documentcontents = new Byte[len];
            objfilestream.Read(documentcontents, 0, len);
            objfilestream.Close();
            string result = Convert.ToBase64String(documentcontents);
            return result;
        }
        catch (Exception ex)
        {
            return ex.ToString();
        }
    }



    [WebMethod]
    public static List<GetGuestClass> GetGuest(string nic)
    {

        List<GetGuestClass> list = new List<GetGuestClass>();

        string cs = ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ConnectionString;
        SqlConnection con = new SqlConnection(cs);

        SqlCommand cmd = new SqlCommand("GetGuestSlip", con);

        con.Open();
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@cnic", nic);
        SqlDataReader dataReader = cmd.ExecuteReader(CommandBehavior.SingleRow);


        while (dataReader.Read())
        {
            list.Add(new GetGuestClass
            {
                gid = dataReader.GetInt32(0),
                name = dataReader.GetString(1),
                address = dataReader.GetString(4),
                img = dataReader.GetString(3),
                status = dataReader.GetString(2),
                relation = dataReader.GetString(6),
            });
        }
        dataReader.Close();
        con.Close();
        return list;
    }

    #endregion


    #region----Get Contractor
    [WebMethod]
    public static string GetContractorImages(string nic)
    {

        string strdocPath;
        try
        {
            strdocPath = HttpContext.Current.Server.MapPath("~/RMS/ContractorPictures/" + nic + ".jpg");

            FileStream objfilestream = new FileStream(strdocPath, FileMode.Open, FileAccess.Read);
            int len = (int)objfilestream.Length;
            Byte[] documentcontents = new Byte[len];
            objfilestream.Read(documentcontents, 0, len);
            objfilestream.Close();
            string result = Convert.ToBase64String(documentcontents);
            return result;
        }
        catch (Exception ex)
        {
            return ex.ToString();
        }
    }


    [WebMethod]
    public static List<GetGuestClass> GetContractor(string nic)

    {


        List<GetGuestClass> list = new List<GetGuestClass>();

        string cs = ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ConnectionString;
        SqlConnection con = new SqlConnection(cs);

        SqlCommand cmd = new SqlCommand("GetContractorSlip", con);

        con.Open();
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@cnic", nic);
        SqlDataReader dataReader = cmd.ExecuteReader(CommandBehavior.SingleRow);


        while (dataReader.Read())
        {
            list.Add(new GetGuestClass
            {
                gid = dataReader.GetInt32(0),
                name = dataReader.GetString(1),
                address = dataReader.GetString(4),
                img = dataReader.GetString(3),
                status = dataReader.GetString(2),
                relation = "",
            });
        }

        dataReader.Close();
        con.Close();
        return list;

    }

    #endregion

    #region---GetLabor

    [WebMethod]
    public static string GetLaborImages(string nic)
    {

        string strdocPath;
        try
        {
            strdocPath = HttpContext.Current.Server.MapPath("~/RMS/ContractorLaborPictures/" + nic + ".jpg");

            FileStream objfilestream = new FileStream(strdocPath, FileMode.Open, FileAccess.Read);
            int len = (int)objfilestream.Length;
            Byte[] documentcontents = new Byte[len];
            objfilestream.Read(documentcontents, 0, len);
            objfilestream.Close();
            string result = Convert.ToBase64String(documentcontents);
            return result;
        }
        catch (Exception ex)
        {
            return ex.ToString();
        }
    }




    [WebMethod]
    public static List<GetGuestClass> GetLabor(string nic)
    {
        List<GetGuestClass> list = new List<GetGuestClass>();

        string cs = ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ConnectionString;
        SqlConnection con = new SqlConnection(cs);

        SqlCommand cmd = new SqlCommand("GetLaborSlip", con);

        con.Open();
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@cnic", nic);
        SqlDataReader dataReader = cmd.ExecuteReader(CommandBehavior.SingleRow);


        while (dataReader.Read())
        {
            list.Add(new GetGuestClass
            {
                gid = dataReader.GetInt32(0),
                name = dataReader.GetString(1),
                address = dataReader.GetString(4),
                img = dataReader.GetString(3),
                status = dataReader.GetString(2),
                relation = "",
            });
        }

        dataReader.Close();
        con.Close();
        return list;
    }

    #endregion

    #region---save visitor log

    [WebMethod]
    public static int SaveVisterLog(string Address, string CNIC, string Department, string EmployeeId, string Relation, string Timein, int VID, string VISITOR_NAME, string ValiditDate, string VehNo, string date, string status, string userType, string visit_purpose, string img)


    {

        if (userType == "Guest")
        {

            string fileName = CNIC;
            string varFilePath = "~/RMS/EmpPictures/EmpGuestPicture/";
            if (img.Length > 16)
            {
                if (img != "")
                {
                    File.Delete(HttpContext.Current.Server.MapPath(varFilePath + fileName + ".jpg"));

                    byte[] imageBytes = Convert.FromBase64String(img.Split(',')[1]);
                    var imagePath = HttpContext.Current.Server.MapPath(varFilePath + fileName + ".jpg");
                    System.IO.File.WriteAllBytes(imagePath, imageBytes);
                }
            }
        }
        if (userType == "Contractor")
        {
            string varFilePath = "~/RMS/ContractorPictures/";
            string fileName = CNIC;
            if (img.Length > 16)
            {
                if (img != "")
                {
                    File.Delete(HttpContext.Current.Server.MapPath(varFilePath + fileName + ".jpg"));

                    byte[] imageBytes = Convert.FromBase64String(img.Split(',')[1]);
                    var imagePath = HttpContext.Current.Server.MapPath(varFilePath + fileName + ".jpg");
                    System.IO.File.WriteAllBytes(imagePath, imageBytes);
                }
            }

        }

        if (userType == "Labor")
        {
            string varFilePath = "~/RMS/ContractorLaborPictures/";
            string fileName = CNIC;
            if (img.Length > 16)
            {
                if (img != "")
                {
                    File.Delete(HttpContext.Current.Server.MapPath(varFilePath + fileName + ".jpg"));

                    byte[] imageBytes = Convert.FromBase64String(img.Split(',')[1]);
                    var imagePath = HttpContext.Current.Server.MapPath(varFilePath + fileName + ".jpg");
                    System.IO.File.WriteAllBytes(imagePath, imageBytes);
                }
            }

        }

        int slipno = 0;
        DBManager db_Manager = new DBManager();
        int empid = int.Parse(EmployeeId);
        DateTime aDate = DateTime.Now;
        String checkintime = aDate.ToString("HH:mm:ss");

        try
        {
            db_Manager.AddParameterReport("@CNIC", CNIC);
            db_Manager.AddParameterReport("@VISITOR_NAME", VISITOR_NAME);
            db_Manager.AddParameterReport("@Employee_ID", empid);
            db_Manager.AddParameterReport("@ADDRESS", Address);
            db_Manager.AddParameterReport("@DATE", date);
            db_Manager.AddParameterReport("@TIME_IN", checkintime);
            db_Manager.AddParameterReport("@VEHICLE_NUMBER", VehNo);
            db_Manager.AddParameterReport("@DEPARTMENT", Department);
            db_Manager.AddParameterReport("@Relations", Relation);
            db_Manager.AddParameterReport("@Status", status);
            db_Manager.AddParameterReport("@VID", VID);
            db_Manager.AddParameterReport("@ValiditDate", ValiditDate);
            db_Manager.AddParameterReport("@UserType", userType);
            db_Manager.AddParameterReport("@visit_purpose", visit_purpose);

            slipno = db_Manager.ExecuteDataTableIDOut("SaveVisterLog", "vmsconnectionstring");
        }
        catch (Exception ex)
        {

        }
        return slipno;
    }
    #endregion
    #region-----GetEmployee Detail
    [WebMethod]
    public static List<GetEmployeeDetail> GetEmployeeDetails(string empcnic, string empname, string empdesg, string empdep)
    {
        List<GetEmployeeDetail> list = new List<GetEmployeeDetail>();

        string cs = ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ConnectionString;
        SqlConnection con = new SqlConnection(cs);

        SqlCommand cmd = new SqlCommand("GetEmployeeDetail_SP", con);
        int depid;
        int desgid;
        if (empdep == "")
        {
            try
            {
                depid = int.Parse(empdep);
            }
            catch (Exception ex) { depid = 0; }
           
        }
        else
        {
            depid = int.Parse(empdep);
        }
        if (empdesg == "")
        {
            try
            {
                desgid = int.Parse(empdesg);
            }
            catch (Exception ec) { desgid = 0; }
           
        }
        else
        {
            desgid = int.Parse(empdesg);
        }
          
        con.Open();
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@CNIC", empcnic);
        cmd.Parameters.AddWithValue("@empName", empname);
        cmd.Parameters.AddWithValue("@empdep", depid);
        cmd.Parameters.AddWithValue("@empdesg", desgid);

        SqlDataReader dataReader = cmd.ExecuteReader(CommandBehavior.SingleRow);


        while (dataReader.Read())
        {
            list.Add(new GetEmployeeDetail
            {
                eid = dataReader.GetInt32(0),
                empname = dataReader.GetString(1),
                empaddress = dataReader.GetString(2),

                department = dataReader.GetString(3),
                empdesgination = dataReader.GetString(4),


            });
        }
        dataReader.Close();
        con.Close();
        return list;
    }
    #endregion
    #region-------Get Visitor Log
    [WebMethod]
    public static List<Visitor> GetAllVisitor()
    {

        List<Visitor> list = new List<Visitor>();

        string cs = ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ConnectionString;
        SqlConnection con = new SqlConnection(cs);

        SqlCommand cmd = new SqlCommand("GetAllVisitor", con);

        con.Open();
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataReader dataReader = cmd.ExecuteReader();


        while (dataReader.Read())
        {
            list.Add(new Visitor
            {
                v_name = dataReader.GetString(0),
                cnic = dataReader.GetString(1),
                id = dataReader.GetInt32(2),
                isexpared = dataReader.GetInt32(3),
                hostpno = dataReader.GetString(4),
            });
        }
        con.Close();
        dataReader.Close();
        return list;





    }

    #endregion

    #region -------check out
    [WebMethod]
    public static void checkout(string cnic)
    {
        DateTime aDate = DateTime.Now;
        String checkouttime = aDate.ToString("HH:mm:ss");
        DBManager db_Manager = new DBManager();
        db_Manager.AddParameterReport("@CNIC", cnic);
        db_Manager.AddParameterReport("@TimeOut", checkouttime);
        db_Manager.InsertUpdateProcedure("CheckOut_SP", "vmsconnectionstring");
    }


    #endregion
    #region----Get Employee AutoComplete
    [WebMethod]
    public static List<string> GetEmployeeNames(string term)
    {
        List<string> listCountryName = new List<string>();
        string CS = ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ConnectionString;
        using (SqlConnection con = new SqlConnection(CS))
        {
            SqlCommand cmd = new SqlCommand("GetEmployeeName_SP", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter parameter = new SqlParameter()
            {
                ParameterName = "@NameAuto",
                Value = term
            };
            cmd.Parameters.Add(parameter);
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                listCountryName.Add(rdr["emp_Names"].ToString());
            }
            con.Close();
            return listCountryName;
        }
    }
    #endregion

    #region AutoComplet Employee CNIC
    [WebMethod]
    public static List<string> GetEmployeeCNIC(string term)
    {
        List<string> listCountryName = new List<string>();
        string CS = ConfigurationManager.ConnectionStrings[""].ConnectionString;
        using (SqlConnection con = new SqlConnection(CS))
        {
            SqlCommand cmd = new SqlCommand("GetEmployeeCNIC_SP", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter parameter = new SqlParameter()
            {
                ParameterName = "@CNICAuto",
                Value = term
            };
            cmd.Parameters.Add(parameter);
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                listCountryName.Add(rdr["Nic"].ToString());
            }
            con.Close();
            return listCountryName;
        }
    }


    #endregion


    #region Guest CNIC Auto Comlete
    [WebMethod]
    public static List<string> GetGuestCNIC(string term)
    {
        List<string> listCountryName = new List<string>();
        string CS = ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ConnectionString;
        using (SqlConnection con = new SqlConnection(CS))
        {
            SqlCommand cmd = new SqlCommand("GetGuestCNIC_SP", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter parameter = new SqlParameter()
            {
                ParameterName = "@CNICAuto",
                Value = term
            };
            cmd.Parameters.Add(parameter);
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                listCountryName.Add(rdr["CNIC"].ToString());
            }
            con.Close();
            return listCountryName;
        }
    }
    #endregion

    #region Get Labor CNIC Auto Comlete
    [WebMethod]
    public static List<string> GetLaborCNIC(string term)
    {
        List<string> listCountryName = new List<string>();
        string CS = ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ConnectionString;
        using (SqlConnection con = new SqlConnection(CS))
        {
            SqlCommand cmd = new SqlCommand("GetLaborCNIC_SP", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter parameter = new SqlParameter()
            {
                ParameterName = "@CNICAuto",
                Value = term
            };
            cmd.Parameters.Add(parameter);
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                listCountryName.Add(rdr["CNIC"].ToString());
            }
            con.Close();
            return listCountryName;
        }
    }

    #endregion

    #region Get Contractor CNIC Auto Comlete
    [WebMethod]
    public static List<string> GetContractorCNIC(string term)
    {
        List<string> listCountryName = new List<string>();
        string CS = ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ConnectionString;
        using (SqlConnection con = new SqlConnection(CS))
        {
            SqlCommand cmd = new SqlCommand("GetConstractorCNIC_SP", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter parameter = new SqlParameter()
            {
                ParameterName = "@CNICAuto",
                Value = term
            };
            cmd.Parameters.Add(parameter);
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                listCountryName.Add(rdr["CNIC"].ToString());
            }
            con.Close();
            return listCountryName;
        }
    }
    #endregion


    #region-----get All Active Visitor

    [WebMethod]
    public static string GetAllActiveVisitor()
    
    
    
    {
        string stateNotes = string.Empty;
        string cs = ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ConnectionString;
        using (SqlConnection con = new SqlConnection(cs))
        {
            using (SqlCommand cmd = new SqlCommand("totalActiveVisitorCount", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                stateNotes = cmd.ExecuteScalar().ToString();
            }
        }
        return stateNotes;
    }

    #endregion


    #region-----Get Expired Visitor count
    [WebMethod]
    public static string GetAllCountExpiredVistor()
    {
        string stateNotes = string.Empty;
        string cs = ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ConnectionString;
        using (SqlConnection con = new SqlConnection(cs))
        {
            using (SqlCommand cmd = new SqlCommand("totalExpiredVisitorCount", con))
            {
                con.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                stateNotes = cmd.ExecuteScalar().ToString();
            }
        }
        return stateNotes;
    }
    #endregion
    public class GetGuestClass
    {
        public int gid { get; set; }
        public string name { get; set; }
        public string address { get; set; }
        public string img { get; set; }
        public string status { get; set; }
        public string relation { get; set; }
    }
    public class GetEmployeeDetail
    {
        public int eid { get; set; }
        public string empname { get; set; }

        public string empdesgination { get; set; }
        public string empaddress { get; set; }

        public string department { get; set; }

    }

    public class Visitor
    {
        public int id { get; set; }
        public string v_name { get; set; }
        public string cnic { get; set; }
        public int isexpared { get; set; }

        public string hostpno { get; set; }

    }

}