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
using System.Web.Script.Services;
using System.IO;

public partial class RMSwebmethods : System.Web.UI.Page
{
    static string UserID = "";
    static string CurrentDate = "";

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public static void getUserAndDate()
    {
        CurrentDate = DateTime.Now.ToShortDateString();
        UserID = HttpContext.Current.Profile.GetPropertyValue("FirstName").ToString() + " " + HttpContext.Current.Profile.GetPropertyValue("LastName").ToString();
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
    public static Dictionary<string, object> getCNICAndName(string CNIC)
    {
        return DBCommonMethods.getCNICAndName(CNIC);        
    }


    [WebMethod]
    public static string[] GetCNICNos(string CNIC, string Type = "1", string Name = "", string Rank = "", string Status = "")
    {
        return DBCommonMethods.GetCNICNos(CNIC, Type, Name, Rank, Status);
    }


    [WebMethod]
    public static string[] GetVisitorReferenceName(string Name)
    {
        return DBCommonMethods.GetVisitorReferenceName(Name);
    }
    [WebMethod]
    public static string[] GetNames(string Name, string Type = "1", string CNIC = "", string Rank = "", string Status = "")
    {
        return DBCommonMethods.GetNames(Name, Type, CNIC, Rank, Status);
    }

    [WebMethod]
    public static Dictionary<string, object> GetAllDesignations()
    {
        return DBCommonMethods.GetAllDesignations();
    }

    #region Reports
    #region Get  Employee by CNIC No
    [WebMethod]
    public static Dictionary<string, object> getCNICWiseReport(string CNIC, string Type = "1")
    {
        return DBCommonMethods.getCNICWiseReport(CNIC, Type);
    }


    [WebMethod]
    public static Dictionary<string, object> getEmployeeFamily(string EID)
    {
        return DBCommonMethods.getEmployeeFamily(EID);
    }

    [WebMethod]
    public static Dictionary<string, object> getEmployeeSerant(string EID)
    {
        return DBCommonMethods.getEmployeeSerant(EID);
    }

    [WebMethod]
    public static Dictionary<string, object> getEmployeeServantFamily(string SID)
    {
        return DBCommonMethods.getEmployeeServantFamily(SID);
    }

    //[WebMethod]
    //public static Dictionary<string, object> getEmployeeSerantFamily(string EID)
    //{
    //    return DBCommonMethods.getEmployeeSerantFamily(EID);
    //}
    #endregion

    #region Get  Employee by Name
    [WebMethod]
    public static Dictionary<string, object> getEmployeeNameWiseReport(string Name, string Type = "1", string CNIC = "", string Rank = "", string Status = "Active",string From="", string To="")
    {
        return DBCommonMethods.getEmployeeNameWiseReport(Name, Type, CNIC, Rank, Status,From,To);
    }
     [WebMethod]
    public static Dictionary<string, object> getEmployeeLogReport(string Employee_Id, string Card_Id, string Date_From, string Date_To, string Department_Id, string Designation_Id, string Gate_Id, string Terminal_Id )
    {
        return DBCommonMethods.getEmployeeLogReport( Employee_Id, Card_Id, Date_From, Date_To, Department_Id, Designation_Id, Gate_Id, Terminal_Id);
    }
    
    #endregion


    #region Get  Visitor by Date
    [WebMethod]
    public static Dictionary<string, object> getVisitorDateWiseReport(string FromDate, string ToDate)
    {
        return DBCommonMethods.getVisitorDateWiseReport(FromDate, ToDate);
    }
    #endregion
    #endregion

    #region Login and Master Page

    [WebMethod]
    public static string UpdatePassword(string OldPwd, string NewPwd, string RepeatPwd)
    {
        DBCommonMethods dbMethods = new DBCommonMethods();
        string result = dbMethods.UpdateUserPassword(OldPwd, NewPwd, RepeatPwd);
        return result;
    }

    #endregion



    #region Is  Employee exist
    [WebMethod]
    public static Dictionary<string, object> GetEmpResultByCNIC(string CNIC)
    {

        string Query = "SELECT COUNT([EID]) as Counts  FROM [Employee] where Nic='" + CNIC + "'";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "GetEmpCountTable", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["GetEmpCountTable"];
        return ToJson(dt);

    }
    #endregion

    #region Is  HRNo exist
    [WebMethod]
    public static Dictionary<string, object> getEmployeeResultByHRNo(string ServiceNo)
    {

        string Query = "SELECT COUNT([EID]) as Counts  FROM [Employee] where ServiceNo='" + ServiceNo + "'";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "GetEmpCountTable", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["GetEmpCountTable"];
        return ToJson(dt);

    }
    #endregion

    #region Is  ServantFamily exist
    [WebMethod]
    public static Dictionary<string, object> GetServantFamilyResultByCNIC(string SFCNIC)
    {

        string Query = "SELECT COUNT([SFID]) as Counts  FROM [ServantFamily] where NIC='" + SFCNIC + "'";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "GetServantfamilyCountTable", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["GetServantfamilyCountTable"];
        return ToJson(dt);

    }
    #endregion
    #region Is  Servant exist
    [WebMethod]
    public static Dictionary<string, object> GetServantResultByCNIC(string SCNIC)
    {

        string Query = "SELECT COUNT([SID]) as Counts  FROM [Servant] where NIC='" + SCNIC + "'";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "GetServantCountTable", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["GetServantCountTable"];
        return ToJson(dt);

    }
    #endregion

    #region Is  Employee Family exist
    [WebMethod]
    public static Dictionary<string, object> GetEmployeeFamilyResultByCNIC(string EFCNIC)
    {

        string Query = "SELECT COUNT([EFID]) as Counts  FROM [EmployeeFamily] where NIC='" + EFCNIC + "'";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "GetEmployeeFamilyCountTable", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["GetEmployeeFamilyCountTable"];
        return ToJson(dt);

    }
    #endregion
    #region Is  Non Resident exist
    [WebMethod]
    public static Dictionary<string, object> GetNonresidentResultByCNIC(string NRCNIC)
    {

        string Query = "SELECT COUNT([NRID]) as Counts  FROM [NonResident] where NIC='" + NRCNIC + "'";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "GetNonresidentCountTable", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["GetNonresidentCountTable"];
        return ToJson(dt);

    }
    #endregion

    #region Is  Visitor exist
    [WebMethod]
    public static Dictionary<string, object> GetVisitorResultByCNIC(string VCNIC)
    {

        string Query = "SELECT COUNT([VID]) as Counts  FROM [Visitor] where NIC='" + VCNIC + "'";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "GetVisitorCountTable", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["GetVisitorCountTable"];
        return ToJson(dt);

    }
    #endregion

    #region Is  Guest exist
    [WebMethod]
    public static Dictionary<string, object> GetGuestResultByCNIC(string SCNIC)
    {

        string Query = "SELECT COUNT([GID]) as Counts  FROM [ResidantGuest] where CNIC='" + SCNIC + "'";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "GetGuestCountTable", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["GetGuestCountTable"];
        return ToJson(dt);

    }
    #endregion


    #region Is  Business Community Details exist
    [WebMethod]
    public static Dictionary<string, object> GetBusinessCommunityDetailResultByCNIC(string VCNIC)
    {

        string Query = "SELECT COUNT([id]) as Counts  FROM [mctx_BusinessCommunityDetail] where CNIC='" + VCNIC + "'";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "GetBusinessCommunityDetailCountTable", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["GetBusinessCommunityDetailCountTable"];
        return ToJson(dt);

    }
    #endregion

    #region Is  Contractor  exist
    [WebMethod]
    public static Dictionary<string, object> GetContractorLaborResultByCNIC(string VCNIC)
    {

        string Query = "SELECT COUNT([id]) as Counts  FROM [mctx_ContractorLaborInformation] where CNIC='" + VCNIC + "'";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "GetContractorLaborCountTable", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["GetContractorLaborCountTable"];
        return ToJson(dt);

    }
    public static Dictionary<string, object> GetContractorResultByCNIC(string VCNIC)
    {

        string Query = "SELECT COUNT([id]) as Counts  FROM [mctx_ContractorInformation] where CNIC='" + VCNIC + "'";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "GetContractorCountTable", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["GetContractorCountTable"];
        return ToJson(dt);

    }
    #endregion

    //#region Is  EmployeeFamily exist
    //public static Dictionary<string, object> GetEmployeeFamilyResultByCNIC(string EFCNIC)
    //{

    //    string Query = "SELECT COUNT([EFID]) as Counts  FROM [EmployeeFamily] where NIC='" + EFCNIC + "'";

    //    DBManager ObjDBManager = new DBManager();
    //    DataSet ds = ObjDBManager.SelectQuery(Query, "GetEmployeeFamilyCountTable", "vmsconnectionstring");
    //    DataTable dt = new DataTable();
    //    dt = ds.Tables["GetEmployeeFamilyCountTable"];
    //    return ToJson(dt);

    //}
    //#endregion



}