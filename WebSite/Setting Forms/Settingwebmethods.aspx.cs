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

public partial class Settingwebmethods : System.Web.UI.Page
{
    static string UserID = "";
    static string CurrentDate = "";

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public static void getUserAndDate()
    {

        CurrentDate = DateTime.Now.ToShortDateString();
        UserID = HttpContext.Current.Profile.GetPropertyValue("FirstName").ToString() + " " + HttpContext.Current.Profile.GetPropertyValue("LastName").ToString();//"mctxAdmin";
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
    public static void UpdateCardCategory(int Cat_ID, string CardCategory, string Card_prefix)
    {
        //getUserAndDate();

        string query = "update mctx_PersonCardCategory set Card_Name ='" + CardCategory + "', Card_Prefix='" + Card_prefix + "' where Card_CatID =" + Cat_ID + "";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    [WebMethod]
    public static void UpdateSiteAllowed(int ID, string SiteAllowed, string Site_prefix)
    {
        //getUserAndDate();

        string query = "update mctx_PersonSiteAllowed set Site_Name ='" + SiteAllowed + "', Site_Prefix='" + Site_prefix + "' where ID =" + ID + "";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }



    [WebMethod]
    public static Dictionary<string, object> getCardCategory()
    {

        string Query = " select * from mctx_PersonCardCategory";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "tbleCardCategory", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["tbleCardCategory"];
        return ToJson(dt);

    }
    [WebMethod]
    public static Dictionary<string, object> getSiteAllowed()
    {

        string Query = " select * from mctx_PersonSiteAllowed";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "tbleCardCategory", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["tbleCardCategory"];
        return ToJson(dt);

    }

    [WebMethod]
    public static void SaveCardCategory(string Card_Category, string Card_prefix)
    {
        // getUserAndDate();


        string query = "INSERT INTO [mctx_PersonCardCategory]" +
       "([Card_Name],[Card_Prefix])" +
       "VALUES('" + Card_Category + "','" + Card_prefix + "')";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }

    [WebMethod]
    public static void SaveSiteAllowed(string Site_Name, string Site_Prefix)
    {
        // getUserAndDate();


        string query = "INSERT INTO [mctx_PersonSiteAllowed]" +
       "([Site_Name],[Site_Prefix])" +
       "VALUES('" + Site_Name + "','" + Site_Prefix + "')";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }


    #region Places

    #region Save Place
    [WebMethod]
    public static void SavePlace(string HOST_NAME, int gateID)
    {
        getUserAndDate();

        string query = "INSERT INTO [Place]" +
       "([LocationName],GateID,[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
       "VALUES('" + HOST_NAME + "'," + gateID + ",'" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    #endregion


    [WebMethod]
    public static void SaveWeigndDevice(string ddlgateid, string ddlLocation, string txtControllerID, string txtWeighdID, string txtDeviceName, string ddlTerminalType, string txtDoorID, string txtClientID, string ddlTerminalID, string ddlSiteAllowed)
    {
        getUserAndDate();

        string query = @"INSERT INTO [dbo].[mctx_Wiegand_Devices] ([Gate_ID] ,[Place_Id] ,[Terminal_ID] ,[DeviceID] ,[wiegandID] ,[DeviceName] ,[TerminalType] ,[DoorID] ,[Client_Id],site_allowed) 
            VALUES(" + Convert.ToInt32(ddlgateid) + " , " + Convert.ToInt32(ddlLocation) + " , " + Convert.ToInt32(ddlTerminalID) + ", " + Convert.ToInt32(txtControllerID) + ",'" + txtWeighdID + "', '" + txtDeviceName + "', '" + ddlTerminalType + "', " + Convert.ToInt32(txtDoorID) + ", " + Convert.ToInt32(txtClientID) + ", " + Convert.ToInt32(ddlSiteAllowed) + ")";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }

    [WebMethod]
    public static void UpdateWeigndDevice(string ddlgateid, string ddlLocation, string txtControllerID, string txtWeighdID, string txtDeviceName, string ddlTerminalType, string txtDoorID, string txtClientID, string ddlTerminalID, int ID, string ddlSiteAllowed)
    {
        getUserAndDate();

        string query = @"UPDATE [dbo].[mctx_Wiegand_Devices]
   SET [Gate_ID] = " + Convert.ToInt32(ddlgateid) + " ,[Place_Id] = " + Convert.ToInt32(ddlLocation) + " ,[Terminal_ID] = " + Convert.ToInt32(ddlTerminalID) + " , [DeviceID] = " + Convert.ToInt32(txtControllerID) + " ,[wiegandID] = '" + txtWeighdID + "' ,[DeviceName] = '" + txtDeviceName + "' ,[TerminalType] = '" + ddlTerminalType + "' ,[DoorID] = " + Convert.ToInt32(txtDoorID) + " ,[Client_Id] = " + Convert.ToInt32(txtClientID) + ",site_allowed=" + Convert.ToInt32(ddlSiteAllowed) + " WHERE ID =" + ID + "";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }

    #region Update Place
    [WebMethod]
    public static void UpdatePlace(string ID, string HOST_NAME, int gateID)
    {
        getUserAndDate();

        string query = "UPDATE [Place]" +
" SET [LocationName] = '" + HOST_NAME + "',[modified_date] = '" + CurrentDate + "',[GateID] = " + gateID + "" +
 " ,[modified_by] = '" + UserID + "' WHERE [ID]='" + ID + "'";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }

    #endregion
    #region Get Places
    [WebMethod]
    public static Dictionary<string, object> getPlaceDetail()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ToString()))
        {
            string Query = @"SELECT [ID],[LocationName],pl.GateID,ga.Gate_Name,isnull(CONVERT(varchar(20), pl.[created_date],101),'') as created_date
                            , pl.[created_by],isnull(CONVERT(varchar(20), pl.[modified_date],101),'') as modified_date 
                            ,pl.[modified_by],pl.[is_deleted]
                            FROM[Place] pl
                            inner join mctx_Gates ga on pl.gateID = ga.Gate_ID
                            where pl.is_deleted=0 order by LocationName ASC";
            SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(ds, "PlaceDetail");
            dt = ds.Tables["PlaceDetail"];
            return ToJson(dt);
        }
    }
    #endregion
    #region Delete Places
    [WebMethod]
    public static void DeletePlace(string ID)
    {

        string query = "update Place set is_deleted=1 where ID='" + int.Parse(ID) + "'";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    #endregion
    #endregion

    #region Relation

    #region Save Relation
    [WebMethod]
    public static void SaveRelation(string Relation_Name)
    {
        getUserAndDate();


        string query = "INSERT INTO [mctx_Relation]" +
       "([Relation_Name],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
       "VALUES('" + Relation_Name + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion

    #region Update Relation
    [WebMethod]
    public static void UpdateRelation(string Relation_ID, string Relation_Name)
    {
        getUserAndDate();

        string query = "UPDATE [mctx_Relation]" +
" SET [Relation_Name] = '" + Relation_Name + "',[modified_date] = '" + CurrentDate + "'" +
 " ,[modified_by] = '" + UserID + "' WHERE [Relation_ID]='" + Relation_ID + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    #endregion
    #region Get Relation
    [WebMethod]
    public static Dictionary<string, object> getRelations()
    {

        string Query = "SELECT [Relation_ID],[Relation_Name],isnull(CONVERT(varchar(20), [created_date],101),'') as created_date" +
        " ,[created_by],isnull(CONVERT(varchar(20), [modified_date],101),'') as modified_date " +
        "  ,[modified_by],[is_deleted]" +
        " FROM [mctx_Relation] where is_deleted=0 order by Relation_Name ASC";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "RelationDetail", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["RelationDetail"];
        return ToJson(dt);


    }
    #endregion

    #region Delete Relation
    [WebMethod]
    public static void DeleteRelation(string Relation_ID)
    {
        string query = "update mctx_Relation set is_deleted=1 where Relation_ID='" + int.Parse(Relation_ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion

    #endregion

    #region Ranks

    #region Save Ranks
    [WebMethod]
    public static void SaveRanks(string Rank, string Category)
    {
        getUserAndDate();


        string query = "INSERT INTO [mctx_Ranks]" +
       "([Rank_Name],[created_date],[created_by],[modified_date],[modified_by],[is_deleted],Person_CateID)" +
       "VALUES('" + Rank + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "','" + Category + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion

    #region Update Ranks
    [WebMethod]
    public static void UpdateRank(string Rank_ID, string Rank, string Category)
    {
        getUserAndDate();

        string query = "UPDATE [mctx_Ranks]" +
" SET [Rank_Name] = '" + Rank + "',[Person_CateID] = '" + Category + "',[modified_date] = '" + CurrentDate + "'" +
 " ,[modified_by] = '" + UserID + "' WHERE [Rank_ID]='" + Rank_ID + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    #endregion
    #region Get Ranks
    [WebMethod]
    public static Dictionary<string, object> getRankDetail()
    {
        string Query = @"SELECT [Rank_ID],[Rank_Name],isnull(CONVERT(varchar(20), rnk.[created_date],101),'') as created_date 
        , rnk.[created_by],isnull(CONVERT(varchar(20), rnk.[modified_date],101),'') as modified_date 
       ,rnk.[modified_by],rnk.[is_deleted]
        FROM[mctx_Ranks] rnk

       where is_deleted=0 order by[Rank_ID] ASC ";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "RankDetail", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["RankDetail"];
        return ToJson(dt);

    }
    #endregion

    #region Delete Ranks
    [WebMethod]
    public static void DeleteRank(string Rank_ID)
    {
        string query = "update mctx_Ranks set is_deleted=1 where Rank_ID='" + int.Parse(Rank_ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion

    #endregion

    #region Gates Name or Number

    #region Save Gate
    [WebMethod]
    public static void SaveGate(string Gate_Name, string Location_ID, string Gate_Level)
    {
        getUserAndDate();

        string query = "INSERT INTO [mctx_Gates]" +
       "([Gate_Name],[LocationID],[GateLevel],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
       "VALUES('" + Gate_Name + "','" + Location_ID + "','" + Gate_Level + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    #endregion

    #region Save Location
    [WebMethod]
    public static void SaveLocation(string LocationName)
    {
        getUserAndDate();

        string query = "INSERT INTO [mctx_Location]" +
       "([LocationName],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
       "VALUES('" + LocationName + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    #endregion

    #region Update Gate
    [WebMethod]
    public static void UpdateGate(string Gate_ID, string Gate_Name, int Location_ID, int GateLevel) // , 
    {
        getUserAndDate();

        string query = "UPDATE [mctx_Gates]" +
        " SET [Gate_Name] = '" + Gate_Name + "',[modified_date] = '" + CurrentDate + "', [LocationID] = '" + Location_ID + "',[GateLevel] = '" + GateLevel + "'" +
         " ,[modified_by] = '" + UserID + "' WHERE [Gate_ID]='" + Gate_ID + "'"; // 

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }

    #endregion
    #region Get Gate
    [WebMethod]
    public static Dictionary<string, object> getGateDetail()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ToString()))
        {
            string Query = "SELECT mgt.[Gate_ID] AS Gate_ID, mgt.[Gate_Name] AS Gate_Name,mgt.[LocationID] AS LocationID,loc.[LocationName] AS LocationName,mgt.[GateLevel] AS GateLevel,isnull(CONVERT(varchar(20), mgt.[created_date],101),'') as created_date" +
            " ,mgt.[created_by] AS created_by,isnull(CONVERT(varchar(20), mgt.[modified_date],101),'') as modified_date " +
            "  ,mgt.[modified_by] AS modified_by,mgt.[is_deleted] AS is_deleted" +
            " FROM [mctx_Gates] mgt " +
            " LEFT JOIN [mctx_Location] loc ON mgt.[LocationID] = loc.[LocationID] " +
            "  WHERE mgt.is_deleted=0 order by Gate_Name ASC";
            SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(ds, "GateDetail");
            dt = ds.Tables["GateDetail"];
            return ToJson(dt);
        }
    }
    #endregion

    #region Delete Gate
    [WebMethod]
    public static void DeleteGate(string Gate_ID)
    {

        string query = "update mctx_Gates set is_deleted=1 where Gate_ID='" + int.Parse(Gate_ID) + "'";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    #endregion

    #region Get Location
    [WebMethod]
    public static Dictionary<string, object> getLocationDetail()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["vmsconnectionstring"].ToString()))
        {
            string Query = "SELECT [LocationID],[LocationName],isnull(CONVERT(varchar(20), [created_date],101),'') as created_date" +
            " ,[created_by],isnull(CONVERT(varchar(20), [modified_date],101),'') as modified_date " +
            "  ,[modified_by],[is_deleted]" +
            " FROM [mctx_Location] where is_deleted=0 order by LocationName ASC";
            SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(ds, "LocationDetail");
            dt = ds.Tables["LocationDetail"];
            return ToJson(dt);
        }
    }
    #endregion

    #region Update Location
    [WebMethod]
    public static void UpdateLocation(string LocationID, string LocationName)
    {
        getUserAndDate();



        string query = "UPDATE [mctx_Location]" +
        " SET [LocationName] = '" + LocationName + "',[modified_date] = '" + CurrentDate + "'" +
         " ,[modified_by] = '" + UserID + "' WHERE [LocationID]='" + LocationID + "'";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion

    #region Delete Location
    [WebMethod]
    public static void DeleteLocation(string LocationID)
    {

        string query = "update mctx_Location set is_deleted=1 where LocationID='" + int.Parse(LocationID) + "'";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    #endregion


    #endregion

    #region VisitArea

    #region Save VisitArea
    [WebMethod]
    public static void SaveDepartment1(string VisitAreaName)
    {
        getUserAndDate();


        string query = "INSERT INTO [VisitArea]" +
       "([VisitAreaName],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
       "VALUES('" + VisitAreaName + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion

    #region Update VisitArea
    [WebMethod]
    public static void UpdateDepartment1(string VisitArea_ID, string VisitAreaName)
    {
        getUserAndDate();

        string query = "UPDATE [VisitArea]" +
" SET [VisitAreaName] = '" + VisitAreaName + "',[modified_date] = '" + CurrentDate + "'" +
 " ,[modified_by] = '" + UserID + "' WHERE VisitArea_ID='" + VisitArea_ID + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    #endregion
    #region Get VisitArea
    [WebMethod]
    public static Dictionary<string, object> getDepartmentDetail1()
    {

        string Query = "SELECT [VisitArea_ID],[VisitAreaName],isnull(CONVERT(varchar(20), [created_date],101),'') as created_date" +
        " ,[created_by],isnull(CONVERT(varchar(20), [modified_date],101),'') as modified_date " +
        "  ,[modified_by],[is_deleted]" +
        " FROM [VisitAreaName] where is_deleted=0 order by VisitAreaName ASC";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "GetDepartmentDetail1", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["GetDepartmentDetail1"];
        return ToJson(dt);

    }
    #endregion
    #region Delete VisitArea
    [WebMethod]
    public static void DeleteDepartment1(string VisitArea_ID)
    {
        string query = "update VisitArea set is_deleted=1 where VisitArea_ID='" + int.Parse(VisitArea_ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion

    #endregion
    #region Department

    #region Save Department
    [WebMethod]
    public static void SaveDepartment(string Department_Name)
    {
        getUserAndDate();


        string query = "INSERT INTO [mctx_Department]" +
       "([Department_Name],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
       "VALUES('" + Department_Name + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion

    #region Update Department
    [WebMethod]
    public static void UpdateDepartment(string Department_ID, string Department_Name)
    {
        getUserAndDate();

        string query = "UPDATE [mctx_Department]" +
" SET [Department_Name] = '" + Department_Name + "',[modified_date] = '" + CurrentDate + "'" +
 " ,[modified_by] = '" + UserID + "' WHERE [Department_ID]='" + Department_ID + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    #endregion
    #region Get Department
    [WebMethod]
    public static Dictionary<string, object> getDepartmentDetail()
    {

        string Query = "SELECT [Department_ID],[Department_Name],isnull(CONVERT(varchar(20), [created_date],101),'') as created_date" +
        " ,[created_by],isnull(CONVERT(varchar(20), [modified_date],101),'') as modified_date " +
        "  ,[modified_by],[is_deleted]" +
        " FROM [mctx_Department] where is_deleted=0 order by Department_Name ASC";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "GetDepartmentDetail", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["GetDepartmentDetail"];
        return ToJson(dt);

    }



    [WebMethod]
    public static Dictionary<string, object> getFingerData(string UserCategory, string CNIC)
    {

        string Query = "";
        if (UserCategory == "Employee")
        {

            Query = @" select emp.Nic CNIC ,fin.User_Name Name , fin.FingerIndex from tbl_Finger fin " +
                 " inner join Employee emp on emp.EID = fin.UserID and fin.User_Type = '" + UserCategory + "'" +
                 " where emp.Nic = '" + CNIC + "'";
        }
        if (UserCategory == "EmployeeFamily")
        {

            Query = @" select empF.NIC CNIC, fin.User_Name Name, fin.FingerIndex from tbl_Finger  fin " +
                 " inner join EmployeeFamily empF on empF.EFID = fin.UserID and fin.User_Type = '" + UserCategory + "'" +
                 " where empF.NIC= '" + CNIC + "'";
        }
        if (UserCategory == "EmployeeServent")
        {
            Query = @" select ser.NIC CNIC , fin.User_Name  Name, fin.FingerIndex  From tbl_Finger fin  " +
                    " inner join Servant ser on ser.SID = fin.UserID and fin.User_Type = '" + UserCategory + "'" +
                    " where ser.NIC= '" + CNIC + "'";
        }
        if (UserCategory == "EmployeeGuest")
        {
            Query = @" select re.CNIC CNIC , fin.User_Name Name , fin.FingerIndex from tbl_Finger fin  " +
                    " inner join ResidantGuest re on re.GID = fin.UserID and fin.User_Type = '" + UserCategory + "'" +
                    " where re.CNIC= '" + CNIC + "'";
        }
        if (UserCategory == "BuissenessCommunity")
        {

            Query = @" select bs.CNIC , fin.User_Name Name , fin.FingerIndex   from tbl_Finger fin   " +
                       " inner join mctx_BusinessCommunityDetail bs on bs.Id =fin.UserID and fin.User_Type = '" + UserCategory + "'" +
                       " where bs.CNIC= '" + CNIC + "'";
        }
        if (UserCategory == "Contractor")
        {

            Query = @" select con.CNIC CNIC, fin.User_Name Name , fin.FingerIndex from tbl_Finger fin   " +
                       " inner join  mctx_ContractorInformation con on con.id = fin.UserID  and fin.User_Type = '" + UserCategory + "'" +
                       " where con.CNIC= '" + CNIC + "'";
        }
        if (UserCategory == "ContractorLabor")
        {

            Query = @" select conL.CNIC CNIC , fin.User_Name Name , fin.FingerIndex  from tbl_Finger fin " +
                       " inner join mctx_ContractorLaborInformation conL on conL.id = fin.UserID and fin.User_Type = '" + UserCategory + "'" +
                       " where conL.CNIC= '" + CNIC + "'";
        }

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "GetFingerData", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["GetFingerData"];
        return ToJson(dt);

    }


    [WebMethod]
    public static Dictionary<string, object> getColor()
    {

        string Query = "select * from win_TransportColour";


        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "GetColorData", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["GetColorData"];
        return ToJson(dt);

    }


    [WebMethod]
    public static Dictionary<string, object> getBodyType()
    {

        string Query = "select * from win_TransportBodyType";


        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "getBodyType", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["getBodyType"];
        return ToJson(dt);

    }

    [WebMethod]
    public static Dictionary<string, object> getMake()
    {

        string Query = "select * from win_TransportMake";


        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "getMake", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["getMake"];
        return ToJson(dt);

    }

    [WebMethod]
    public static void SaveColor(string Color)
    {
        string query = "IF NOT EXISTS(SELECT 1 FROM [win_TransportColour] WITH(NOLOCK) WHERE(TransportColour = '" + Color + "')) " +
            "begin  " + "insert into win_TransportColour( TransportColour) values ('" + Color + "')" + "end";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }


    [WebMethod]
    public static void SaveBodyType(string BodyType)
    {
        string query = "IF NOT EXISTS (SELECT 1 FROM [win_TransportBodyType] WITH (NOLOCK) WHERE (TransportBodyType = '" + BodyType + "')) " +
            "begin  " + "insert into win_TransportBodyType( TransportBodyType) values ('" + BodyType + "')" + "end";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    [WebMethod]
    public static void SaveMake(string Make)
    {
        string query = "IF NOT EXISTS(SELECT 1 FROM [win_TransportMake] WITH(NOLOCK) WHERE (TransportMake = '" + Make + "')) " +
            "begin  " + "insert into win_TransportMake( TransportMake) values ('" + Make + "')" + "end";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }

    #endregion

    #region Delete Department
    [WebMethod]
    public static void DeleteDepartment(string Department_ID)
    {
        string query = "update mctx_Department set is_deleted=1 where Department_ID='" + int.Parse(Department_ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion

    #endregion


    #region Religion

    #region Save Religion
    [WebMethod]
    public static void SaveReligions(string Religion_Name)
    {
        getUserAndDate();


        string query = "INSERT INTO [mctx_Religion]" +
       "([Religion_Name],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
       "VALUES('" + Religion_Name + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion

    #region Update Religion
    [WebMethod]
    public static void UpdateReligions(string Religion_ID, string Religion_Name)
    {
        getUserAndDate();

        string query = "UPDATE [mctx_Religion]" +
" SET [Religion_Name] = '" + Religion_Name + "',[modified_date] = '" + CurrentDate + "'" +
 " ,[modified_by] = '" + UserID + "' WHERE [Religion_ID]='" + Religion_ID + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    #endregion
    #region Get Religion
    [WebMethod]
    public static Dictionary<string, object> getReligionDetail()
    {

        string Query = "SELECT [Religion_ID],[Religion_Name],isnull(CONVERT(varchar(20), [created_date],101),'') as created_date" +
        " ,[created_by],isnull(CONVERT(varchar(20), [modified_date],101),'') as modified_date " +
        "  ,[modified_by],[is_deleted]" +
        " FROM [mctx_Religion] where is_deleted=0 order by Religion_Name ASC";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "ReligionDetail", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["ReligionDetail"];
        return ToJson(dt);

    }
    #endregion

    #region Delete Religion
    [WebMethod]
    public static void DeleteReligion(string Religion_ID)
    {
        string query = "update mctx_Religion set is_deleted=1 where Religion_ID='" + int.Parse(Religion_ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion

    #endregion


    #region Sticker

    #region Save Sticker
    [WebMethod]
    public static void SaveSticker(string Sticker_Name)
    {
        getUserAndDate();


        string query = "INSERT INTO [mctx_Sticker]" +
       "([Sticker_Name],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
       "VALUES('" + Sticker_Name + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion

    #region Update Sticker
    [WebMethod]
    public static void UpdateSticker(string Sticker_ID, string Sticker_Name)
    {
        getUserAndDate();

        string query = "UPDATE [mctx_Sticker]" +
" SET [Sticker_Name] = '" + Sticker_Name + "',[modified_date] = '" + CurrentDate + "'" +
 " ,[modified_by] = '" + UserID + "' WHERE [Sticker_ID]='" + Sticker_ID + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    #endregion
    #region Get Sticker
    [WebMethod]
    public static Dictionary<string, object> getStickerDetail()
    {

        string Query = "SELECT [Sticker_ID],[Sticker_Name],isnull(CONVERT(varchar(20), [created_date],101),'') as created_date" +
        " ,[created_by],isnull(CONVERT(varchar(20), [modified_date],101),'') as modified_date " +
        "  ,[modified_by],[is_deleted]" +
        " FROM [mctx_Sticker] where is_deleted=0 order by Sticker_Name ASC";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "StickerDetail", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["StickerDetail"];
        return ToJson(dt);

    }
    #endregion

    #region Delete Sticker
    [WebMethod]
    public static void DeleteSticker(string Sticker_ID)
    {
        string query = "update mctx_Sticker set is_deleted=1 where Sticker_ID='" + int.Parse(Sticker_ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion

    #endregion



    #region Education

    #region Save Education
    [WebMethod]
    public static void SaveEducation(string Education_Name)
    {
        getUserAndDate();


        string query = "INSERT INTO [mctx_Education]" +
       "([Education_Name],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
       "VALUES('" + Education_Name + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion

    #region Update Education
    [WebMethod]
    public static void UpdateEducation(string Education_ID, string Education_Name)
    {
        getUserAndDate();

        string query = "UPDATE [mctx_Education]" +
" SET [Education_Name] = '" + Education_Name + "',[modified_date] = '" + CurrentDate + "'" +
 " ,[modified_by] = '" + UserID + "' WHERE [Education_ID]='" + Education_ID + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    #endregion
    #region Get Education
    [WebMethod]
    public static Dictionary<string, object> getEducationDetail()
    {

        string Query = "SELECT [Education_ID],[Education_Name],isnull(CONVERT(varchar(20), [created_date],101),'') as created_date" +
        " ,[created_by],isnull(CONVERT(varchar(20), [modified_date],101),'') as modified_date " +
        "  ,[modified_by],[is_deleted]" +
        " FROM [mctx_Education] where is_deleted=0 order by Education_Name ASC";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "EducationDetail", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["EducationDetail"];
        return ToJson(dt);

    }
    #endregion

    #region Delete Education
    [WebMethod]
    public static void DeleteEducation(string Education_ID)
    {
        string query = "update mctx_Education set is_deleted=1 where Education_ID='" + int.Parse(Education_ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion

    #endregion

    #region Sectt

    #region Save Sectt
    [WebMethod]
    public static void SaveSectt(string Sectt_Name)
    {
        getUserAndDate();


        string query = "INSERT INTO [mctx_Sectt]" +
       "([Sectt_Name],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
       "VALUES('" + Sectt_Name + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion

    #region Update Sectt
    [WebMethod]
    public static void UpdateSectt(string Sectt_ID, string Sectt_Name)
    {
        getUserAndDate();

        string query = "UPDATE [mctx_Sectt]" +
" SET [Sectt_Name] = '" + Sectt_Name + "',[modified_date] = '" + CurrentDate + "'" +
 " ,[modified_by] = '" + UserID + "' WHERE [Sectt_ID]='" + Sectt_ID + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    #endregion
    #region Get Sectt
    [WebMethod]
    public static Dictionary<string, object> getSecttDetail()
    {

        string Query = "SELECT [Sectt_ID],[Sectt_Name],isnull(CONVERT(varchar(20), [created_date],101),'') as created_date" +
        " ,[created_by],isnull(CONVERT(varchar(20), [modified_date],101),'') as modified_date " +
        "  ,[modified_by],[is_deleted]" +
        " FROM [mctx_Sectt] where is_deleted=0 order by Sectt_Name ASC";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "SecttDetail", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["SecttDetail"];
        return ToJson(dt);

    }
    #endregion

    #region Delete Sectt
    [WebMethod]
    public static void DeleteSectt(string Sectt_ID)
    {
        string query = "update mctx_Sectt set is_deleted=1 where Sectt_ID='" + int.Parse(Sectt_ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion

    #endregion



    #region Caste

    #region Save Caste
    [WebMethod]
    public static void SaveCaste(string Caste_Name)
    {
        getUserAndDate();


        string query = "INSERT INTO [mctx_Caste]" +
       "([Caste_Name],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
       "VALUES('" + Caste_Name + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion

    #region Update Caste
    [WebMethod]
    public static void UpdateCaste(string Caste_ID, string Caste_Name)
    {
        getUserAndDate();

        string query = "UPDATE [mctx_Caste]" +
" SET [Caste_Name] = '" + Caste_Name + "',[modified_date] = '" + CurrentDate + "'" +
 " ,[modified_by] = '" + UserID + "' WHERE [Caste_ID]='" + Caste_ID + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    #endregion
    #region Get Caste
    [WebMethod]
    public static Dictionary<string, object> getCasteDetail()
    {

        string Query = "SELECT [Caste_ID],[Caste_Name],isnull(CONVERT(varchar(20), [created_date],101),'') as created_date" +
        " ,[created_by],isnull(CONVERT(varchar(20), [modified_date],101),'') as modified_date " +
        "  ,[modified_by],[is_deleted]" +
        " FROM [mctx_Caste] where is_deleted=0 order by Caste_Name ASC";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "CasteDetail", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["CasteDetail"];
        return ToJson(dt);

    }
    #endregion

    #region Delete Caste
    [WebMethod]
    public static void DeleteCaste(string Caste_ID)
    {
        string query = "update mctx_Caste set is_deleted=1 where Caste_ID='" + int.Parse(Caste_ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion

    #endregion
    #region MachineInfos

    #region Machine Infos
    [WebMethod]
    public static void SavemachineInfos(string Client_Ip, string Terminal_Type_Id, string Gate_Id)
    {
        //IF NOT EXISTS(SELECT 1 FROM [mctx_ClientMachinesInfo] WITH(NOLOCK) WHERE Client_IP ='22032022')
        // INSERT INTO[mctx_ClientMachinesInfo]([Client_IP],[Terminal_Type_ID],[Gate_ID])VALUES('22032022', '1', '9')


        // getUserAndDate();
        string query = "IF NOT EXISTS (SELECT 1 FROM [mctx_ClientMachinesInfo] WITH (NOLOCK) WHERE (Client_IP = '" + Client_Ip + "')) " +
            "begin  " +
            "INSERT INTO [mctx_ClientMachinesInfo] ( [Client_IP] , [Terminal_Type_ID] , [Gate_ID] ) " +

            "VALUES ( '" + Client_Ip + "', '" + Terminal_Type_Id + "', '" + Gate_Id + "' )" +
            " select 1 end " +
              "Else begin select 2 end";

        //   "INSERT INTO  [mctx_ClientMachinesInfo]" +
        //"([Client_IP],[Terminal_Type_ID],[Gate_ID])" +
        //"VALUES('" + Client_Ip + "','" + Terminal_Type_Id + "','" + Gate_Id + "')";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion

    #region Update Machine Infos
    [WebMethod]
    public static void UpdateMachineInfos(string Client_Ip, string Terminal_Type_Id, string Gate_ID, string ID)
    {
        //getUserAndDate();

        string query = "IF NOT EXISTS (SELECT 1 FROM [mctx_ClientMachinesInfo] WITH (NOLOCK) WHERE ((Client_IP = '" + Client_Ip + "')" +
            " AND (Terminal_Type_ID='" + Terminal_Type_Id + "') " +
            " AND (Gate_ID = '" + Gate_ID + "' ) ) )" +
            " begin  " +
            " UPDATE [mctx_ClientMachinesInfo]" +
      " SET [Client_IP] = '" + Client_Ip + "' " +
      ",[Terminal_Type_ID]='" + Terminal_Type_Id + "'" +
      ",[Gate_ID]='" + Gate_ID + "'" +
       " WHERE [Client_ID]='" + ID + "'" +
       "end";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    #endregion
    #region Get machineInfos
    [WebMethod]
    public static Dictionary<string, object> getMachineinfosDetail()
    {

        string Query = "SELECT cm.[Client_ID],cm.[Client_IP],mtt.Terminal_type as Terminal_Type,cm.[Gate_ID],mg.Gate_Name as Gate_Name " +
        " FROM [mctx_ClientMachinesInfo] cm left join mctx_Gates mg on cm.Gate_ID=mg.Gate_ID " +
        "inner join mctx_TerminalType mtt on cm.Terminal_Type_ID=mtt.Terminal_Type_ID " +
        "where cm.is_deleted is  null  or cm.is_deleted=0 ";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "tbleMachineInfosDetails", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["tbleMachineInfosDetails"];
        return ToJson(dt);

    }
    #endregion

    #region Delete Machine Infos
    [WebMethod]
    public static void DeleteMachineInfos(string ID)
    {
        string query = "update mctx_ClientMachinesInfo set is_deleted=1  where  Client_ID='" + int.Parse(ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion

    #endregion
    #region damoclesInfos

    #region damocles Infos
    [WebMethod]
    public static void SaveDamoclesInfos(string Ip, string macaddress, int Gateid)
    {
        // getUserAndDate();


        string query = "INSERT INTO [mctx_DamoclesInfo]" +
       "([Dam_IP],[Dam_Mac_Address],[Gate_ID])" +
       "VALUES('" + Ip + "','" + macaddress + "','" + Gateid.ToString() + "')";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion

    #region Update Damocles Infos
    [WebMethod]
    public static void UpdateDamoclesInfos(string Dam_ID, string Ip, string macaddress, string Gate_id)
    {
        //getUserAndDate();

        string query = "UPDATE [mctx_DamoclesInfo]" +
      " SET [Dam_IP] = '" + Ip + "' " +
      " ,[Dam_Mac_Address] = '" + macaddress + "' " +
      " ,[Gate_ID] = '" + Gate_id + "' " +
       " WHERE Dam_ID='" + Dam_ID + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    #endregion
    #region Get DamoclesInfos
    [WebMethod]
    public static Dictionary<string, object> getdamoclesinfosDetail()
    {

        string Query = "SELECT mdi.[Dam_IP],mdi.[Dam_Mac_Address],isnull(mg.Gate_Name,'') as Gate_Name,mg.Gate_ID, mdi.Dam_ID" +
        " FROM [mctx_DamoclesInfo] mdi left join mctx_Gates mg on mdi.Gate_ID=mg.Gate_ID where mdi.is_deleted is  null  or mdi.is_deleted=0 ";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "tbleDamoclesInfosDetails", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["tbleDamoclesInfosDetails"];
        return ToJson(dt);

    }
    #endregion

    #region Delete Damocles Infos
    [WebMethod]
    public static void DeleteDamoclesInfos(string Dam_ID)
    {
        string query = "update mctx_DamoclesInfo set is_deleted=1  where  Dam_ID='" + int.Parse(Dam_ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion

    #endregion
    #region Sensor Type

    #region Sensor Type
    [WebMethod]
    public static void SaveSensorType(string Sensor_Name)
    {
        // getUserAndDate();


        string query = "INSERT INTO [mctx_DamoclesSensorTypeInfo]" +
       "(Dam_Sen_Type)" +
       "VALUES('" + Sensor_Name + "')";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion

    #region Update Sensor Type
    [WebMethod]
    public static void UpdateSensortype(string sensortype_ID, string Sensortype_Name)
    {
        //getUserAndDate();

        string query = "UPDATE [mctx_DamoclesSensorTypeInfo]" +
        " SET [Dam_Sen_Type] = '" + Sensortype_Name + "' " +
       " WHERE Dam_Sen_Type_ID='" + sensortype_ID + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    #endregion
    #region Get Sensortype
    [WebMethod]
    public static Dictionary<string, object> getsensortypeDetail()
    {

        string Query = "SELECT Dam_Sen_Type,Dam_Sen_Type_ID" +
        " FROM mctx_DamoclesSensorTypeInfo where is_deleted is  null  or is_deleted=0";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "tbleSensorTypeDetails", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["tbleSensorTypeDetails"];
        return ToJson(dt);

    }
    #endregion

    #region Delete Sensor Type
    [WebMethod]
    public static void DeleteSensorTypes(string ID)
    {
        string query = "update mctx_DamoclesSensorTypeInfo set is_deleted=1  where  Dam_Sen_Type_ID='" + int.Parse(ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion

    #endregion
    #region Designations

    #region Save Designation
    [WebMethod]
    public static void SavePersonDesignation(string designation, string Person_CateID)
    {
        getUserAndDate();


        string query = "INSERT INTO [HR_Designation]" +
       "([designation],[created_date],[created_by],[modified_date],[modified_by],[is_deleted],Person_CateID)" +
       "VALUES('" + designation + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "', '" + Person_CateID + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion

    #region Update Designation
    [WebMethod]
    public static void UpdatePersonDesignation(string Designation_ID, string designation, string Person_CateID)
    {
        getUserAndDate();

        string query = "UPDATE [HR_Designation]" +
" SET [designation] = '" + designation + "',[Person_CateID] = '" + Person_CateID + "',[modified_date] = '" + CurrentDate + "'" +
 " ,[modified_by] = '" + UserID + "' WHERE [Designation_ID]='" + Designation_ID + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    #endregion
    #region Get Designation
    [WebMethod]
    public static Dictionary<string, object> getPersonDesignationDetail()
    {

        string Query = "SELECT [Designation_ID],[designation],isnull(CONVERT(varchar(20), hrdsg.[created_date],101),'') as created_date " +
        " ,hrdsg.[created_by],isnull(CONVERT(varchar(20), hrdsg.[modified_date],101),'') as modified_date " +
       "  ,hrdsg.[modified_by],hrdsg.[is_deleted],'' as Person_CatID,'' as Person_CatName " +
      "  FROM [HR_Designation] hrdsg   " +

      "   where is_deleted=0 and designation is not null and designation !=''  order by designation ASC";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "PersonDesignationDetail", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["PersonDesignationDetail"];
        return ToJson(dt);

    }
    #endregion

    #region Delete Designation
    [WebMethod]
    public static void DeletePersonDesignation(string Designation_ID)
    {
        string query = "update HR_Designation set is_deleted=1 where Designation_ID='" + int.Parse(Designation_ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion

    #endregion

    #region DamoclesSensorInfos

    #region Damocles SensorInfos
    [WebMethod]
    public static void SaveDamoclesSensorInfoss(string DamoclesSensor, string DamoclesSensorTypeId, string Gateid)
    {
        // getUserAndDate();


        string query = "INSERT INTO [mctx_DamoclesSensorInfo]" +
       "([Dam_ID],[Dam_Sen_ID],[Dam_Sen_Type_ID])" +
       "VALUES('" + DamoclesSensor + "','" + DamoclesSensorTypeId + "','" + Gateid + "')";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion

    #region Update Damocles Sensor Infos
    [WebMethod]
    public static void UpdateDamoclesSensorInfos(string DamoclesSensorId, string DamoclesSensorType, string DamoclesId, string Dam_id)
    {
        //getUserAndDate();

        string query = "UPDATE [mctx_DamoclesSensorInfo]" +
      " SET [Dam_ID] = '" + DamoclesSensorId + "' " +
      ",[Dam_Sen_ID]='" + DamoclesSensorType + "'" +
      ",[Dam_Sen_Type_ID]='" + DamoclesId + "'" +
       " WHERE [DIID]='" + Dam_id + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    #endregion
    #region Get damocles Sensor Infos
    [WebMethod]
    public static Dictionary<string, object> getdamoclesSensorinfosDetail()
    {

        string Query = "select DS.Dam_ID as Dam_ID,DS.DIID ,DS.Dam_Sen_ID,DT.Dam_Sen_Type_ID as Dam_Sen_Type_ID,mdi.Dam_IP+ ' '+mg.Gate_Name as IPName,DT.Dam_Sen_Type as Dam_Sen_Type " +
                   " from mctx_DamoclesSensorInfo DS " +
                   " left join mctx_DamoclesSensorTypeInfo DT on dt.Dam_Sen_Type_ID=DS.Dam_Sen_Type_ID " +
                   " inner join mctx_DamoclesInfo mdi on mdi.Dam_ID=DS.Dam_ID " +
                   " inner join mctx_Gates mg on mg.Gate_ID=mdi.Gate_ID where DS.Is_deleted=0 ";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "tbleDamoclesSensorInfos", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["tbleDamoclesSensorInfos"];
        return ToJson(dt);

    }
    #endregion

    #region Delete Damocles Sensor Infos
    [WebMethod]
    public static void DeleteDamoclesSensorInfos(string Dam_ID)
    {
        string query = "update mctx_DamoclesSensorInfo set Is_deleted=1  where  DIID='" + Dam_ID + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion

    #endregion
    #region TerminalInfos

    #region Terminal Infos
    [WebMethod]
    public static void SaveTerminalInfos(string txtIP, string Controller, string txtPort, string txtDeviceID, string Gate_Id, string Terminal_Name)
    {
        string query = "IF NOT EXISTS (SELECT 1 FROM [mctx_TerminalInfos] WITH (NOLOCK) WHERE (Terminal_IP = '" + txtIP + "')) " +
        "begin  " +
           "INSERT INTO [mctx_TerminalInfos] ( [Terminal_IP] , [DeviceID] , [PortNo] , [Gate_ID] , [TerminalName] , [Controller] ) " +
      "VALUES ( '" + txtIP + "' , '" + txtDeviceID + "' , '" + txtPort + "' , '" + Gate_Id + "' , '" + Terminal_Name + "', '" + Controller + "' ) " +
      " select 1 end " +
               "Else begin select 2 end";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion

    #region Update Terminal Infos
    [WebMethod]
    public static void UpdateTerminalData(string ID, string Terminal_Ip, string txtPort, string Controller, string Gate_Id, string Terminal_Name, string txtDeviceID)
    {
        //getUserAndDate();
        string query = "IF NOT EXISTS ( SELECT 1 FROM [mctx_TerminalInfos]  WITH (NOLOCK) WHERE ((Terminal_IP = '" + Terminal_Ip + "') "
         + " AND (Controller = '" + Controller + "') "
         + " AND (Gate_ID = '" + Gate_Id + "') "
         + " AND (TerminalName = '" + Terminal_Name + "') "
         + " AND (DeviceID = '" + txtDeviceID + "'))) "
         + " begin   "
         + " UPDATE [mctx_TerminalInfos]" +
         " SET [Terminal_IP] =' " + Terminal_Ip + "' ," +
         "  [DeviceID]= '" + txtDeviceID + "' ," +
         "  [PortNo] = '" + txtPort + "' ," +
         "  [Gate_ID] = '" + Gate_Id + "', " +
         "  [TerminalName] = ' " + Terminal_Name + "', " +
         " [Controller] = '" + Controller + "'" +
         "  WHERE [Terminal_ID] = '" + ID + " '" +
         " end ";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    #endregion


    #region Bussiness Community

    [WebMethod]
    public static void SaveBusinessCommunity(string BusinessName)
    {
        getUserAndDate();


        string query = "INSERT INTO [mctx_BusinessCommunity]" +
       "([BusinessName],[CreatedDate],[CreatedBy],[ModifyDate],[ModifyBy],[is_deleted])" +
       "VALUES('" + BusinessName + "','" + DateTime.Now + "','" + UserID + "','" + DateTime.Now + "','" + UserID + "','" + 0 + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }

    [WebMethod]
    public static Dictionary<string, object> getBusinessCommunity()
    {

        string Query = @"SELECT [ID],[BusinessName],isnull(CONVERT(varchar(20), CreatedDate,101),'') as created_date
                            , CreatedBy, isnull(CONVERT(varchar(20), ModifyDate, 101), '') as modified_date
                             ,ModifyBy,[is_deleted]
                             FROM mctx_BusinessCommunity
                             where is_deleted = 0 order by[BusinessName] ASC";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "BusinessCommunityDetail", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["BusinessCommunityDetail"];
        return ToJson(dt);

    }

    [WebMethod]
    public static void DeleteBusinessCommunity(string ID)
    {
        string query = "Update mctx_BusinessCommunity set is_deleted=1 where ID='" + int.Parse(ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }

    [WebMethod]
    public static void UpdateBusinessCommunity(string BusinessName, string ID)
    {
        getUserAndDate();

        string query = "UPDATE [mctx_BusinessCommunity]" +
" SET [BusinessName] = '" + BusinessName + "',[ModifyDate] = '" + CurrentDate + "'" +
" ,[CreatedBy] = '" + UserID + "' WHERE [ID]='" + ID + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    #endregion

    #region Family Category
    [WebMethod]
    public static void Savefamilycatagory(string CategoryName)
    {
        getUserAndDate();


        string query = "INSERT INTO [mctx_FamilyCategory]" +
       "([FamilyCategoryName],[CreatedDate],[CreatedBy],[ModifyDate],[ModifyBy],[is_deleted])" +
       "VALUES('" + CategoryName + "','" + DateTime.Now + "','" + UserID + "','" + DateTime.Now + "','" + UserID + "','" + 0 + "' )";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }

    [WebMethod]
    public static Dictionary<string, object> getFamilyDetail()
    {

        string Query = @"SELECT [ID],[FamilyCategoryName],isnull(CONVERT(varchar(20), CreatedDate,101),'') as created_date
                            , CreatedBy, isnull(CONVERT(varchar(20), ModifyDate, 101), '') as modified_date
                             ,ModifyBy,[is_deleted]
                             FROM mctx_FamilyCategory
                             where is_deleted = 0 order by[FamilyCategoryName] ASC";

        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "familycatagoryDetail", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["familycatagoryDetail"];
        return ToJson(dt);

    }

    [WebMethod]
    public static void Deletefamilycatagory(string ID)
    {
        string query = "Update mctx_FamilyCategory set is_deleted=1 where ID='" + int.Parse(ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }

    [WebMethod]
    public static void Updatefamilycatagory(string CategoryName, string ID)
    {
        getUserAndDate();

        string query = "UPDATE [mctx_FamilyCategory]" +
" SET [FamilyCategoryName] = '" + CategoryName + "',[ModifyDate] = '" + CurrentDate + "'" +
" ,[CreatedBy] = '" + UserID + "' WHERE [ID]='" + ID + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }

    #endregion

    #region Get TerminalInfosInfos
    [WebMethod]
    public static Dictionary<string, object> getTerminalinfosDetail()
    {

        string Query = @"select Terminal_ID,Ti.Terminal_IP,ti.DeviceID, Ti.PortNo,Gt.Gate_ID,Gt.Gate_Name as Gate_Name 
                     , Ti.TerminalName,Ti.Controller
                        from mctx_TerminalInfos Ti
                       left join mctx_Gates Gt on Gt.Gate_ID = Ti.Gate_ID

                      where Ti.Is_Handled is null or Ti.Is_Handled = 0 ";


        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "tbleTerminalInfosDetails", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["tbleTerminalInfosDetails"];
        return ToJson(dt);

    }
    #endregion

    [WebMethod]
    public static Dictionary<string, object> getWeigandDevice()
    {

        string Query = @"select  wi.ID,wi.Gate_ID,ga.Gate_Name,wi.Place_Id ,pl.LocationName,wi.Terminal_ID ,te.TerminalName , wi.DeviceID , wi.wiegandID , wi.DeviceName , wi.TerminalType , tey.Terminal_type , wi.Client_Id,wi.DoorID , ps.ID site_ID,ps.Site_Name
                                from mctx_Wiegand_Devices wi 
                                left join mctx_Gates ga on  ga.Gate_ID = wi.Gate_ID
                                left join place pl on pl.ID = wi.Place_Id 
                                left join mctx_TerminalInfos te on te.Terminal_ID = wi.Terminal_ID
                                left join mctx_TerminalType tey on tey.Terminal_Type_ID = wi.TerminalType
								left join mctx_PersonSiteAllowed ps on ps.ID = wi.site_allowed ";


        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "tbleTerminalInfosDetails", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["tbleTerminalInfosDetails"];
        return ToJson(dt);

    }

    #region Delete Terminal Infos
    [WebMethod]
    public static void DeleteTerminalinfos1(string ID)
    {
        string query = "delete from mctx_TerminalInfos   where  Terminal_ID='" + int.Parse(ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion
    #region Delete Weigand Devices
    [WebMethod]
    public static void DeleteWeigandDevices(string ID)
    {
        string query = "delete from mctx_Wiegand_Devices   where ID='" + int.Parse(ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion

    #endregion


    #region Route Terminal

    #region Save Route Terminal Infos
    [WebMethod]
    public static void SaveRouteInfos(string Place_Name, string DeviceIDs, string TerminalID)
    {
        // getUserAndDate();


        string query = "INSERT INTO [RouteTerminal]" +
       "([Terminal_ID],[Device_ID],[PlaceName])" +
       "VALUES('" + TerminalID + "','" + DeviceIDs + "','" + Place_Name + "')";

        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion

    #region Update Route Terminal Infos
    [WebMethod]
    public static void UpdateTerminalInfos(string Route_ID, string Place_Name, string DeviceIDs, string TerminalID)
    {
        //getUserAndDate();

        string query = "UPDATE [RouteTerminal]" +
      " SET [Terminal_ID] = '" + TerminalID + "' " +
      ",[Device_ID]='" + DeviceIDs + "'" +
      ",[PlaceName]='" + Place_Name + "'" +

       " WHERE [RTID]='" + Route_ID + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");
    }
    #endregion
    #region Get Route Terminal
    [WebMethod]
    public static Dictionary<string, object> getRouteInfosDetail()
    {

        string Query = @"SELECT  RT.[RTID],RT.[Terminal_ID],RT.[Device_ID],RT.[PlaceName],TInfo.[Terminal_IP],TInfo.[TerminalName]
  FROM  [RouteTerminal] RT inner join [mctx_TerminalInfos] TInfo
  on RT.[Terminal_ID]=TInfo.[Terminal_ID] where is_deleted=0 ";


        DBManager ObjDBManager = new DBManager();
        DataSet ds = ObjDBManager.SelectQuery(Query, "tblRouteTerminalDetails", "vmsconnectionstring");
        DataTable dt = new DataTable();
        dt = ds.Tables["tblRouteTerminalDetails"];
        return ToJson(dt);

    }
    #endregion

    #region Delete Route Terminal
    [WebMethod]
    public static void DeleteTerminalInfos(string Route_ID)
    {
        string query = "update RouteTerminal set Is_deleted =1  where  RTID='" + int.Parse(Route_ID) + "'";
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.InsertUpdateQuery(query, "vmsconnectionstring");

    }
    #endregion

    #endregion
}

