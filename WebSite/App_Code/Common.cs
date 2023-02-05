using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
/// <summary>
/// Summary description for Common
/// </summary>
public class Common
{
	public Common()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    //GetUVSSVehicelNumber
    //public object ClsLivePage { get; private set; }

    //
    //NEW FOR NLC VMS
    //
    public DataTable GetEmpVMS()
    {
        DBManager ObjDBManager = new DBManager();
        return ObjDBManager.ExecuteDataTable("EmpVMS", "vmsconnectionstring");
    }
    public DataTable GetPlaceVMS()
    {
        DBManager ObjDBManager = new DBManager();
        return ObjDBManager.ExecuteDataTable("PlaceVMS", "vmsconnectionstring");
    }
    public DataTable GetCardColorVMS()
    {
        DBManager ObjDBManager = new DBManager();
        return ObjDBManager.ExecuteDataTable("CardColorVMS", "vmsconnectionstring");
    }
    //CarMakeVMS
    public DataTable GetCarMakeVMS()
    {
        DBManager ObjDBManager = new DBManager();
        return ObjDBManager.ExecuteDataTable("CarMakeVMS", "vmsconnectionstring");
    }
    public DataTable PDI()
    {
        DBManager ObjDBManager = new DBManager();
        return ObjDBManager.ExecuteDataTable("PDI", "vmsconnectionstring");
    }
    public DataTable GetLatestDesignation()
    {
        DBManager ObjDBManager = new DBManager();
        return ObjDBManager.ExecuteDataTable("GetLatestDesignation", "vmsconnectionstring");
    }
    public DataTable GetNewMake()
    {
        DBManager ObjDBManager = new DBManager();
        return ObjDBManager.ExecuteDataTable("GetNewMake", "vmsconnectionstring");
    }

    public DataTable GetUVSSFOD()
    {
        DBManager ObjDBManager = new DBManager();
        return ObjDBManager.ExecuteDataTable("GetUVSSFOD", "vmsconnectionstring");
    }
    public DataTable GetUVSSVehicelNumber()
    {
        DBManager ObjDBManager = new DBManager();
        return ObjDBManager.ExecuteDataTable("GetUVSSVehicelNumber", "vmsconnectionstring");
    }
    //[NotAllowdVACS]
    public DataTable NotAllowdVACS()
    {
        DBManager ObjDBManager = new DBManager();
        return ObjDBManager.ExecuteDataTable("NotAllowdVACS", "vmsconnectionstring");
    }

    public DataTable GetNotAllowedEmployeeClearanceStatus()
    {
        DBManager ObjDBManager = new DBManager();
        return ObjDBManager.ExecuteDataTable("GetNotAllowedEmployeeClearanceStatus", "vmsconnectionstring");
    }
    public DataTable GetClearanceStatus()
    {
        DBManager ObjDBManager = new DBManager();
        return ObjDBManager.ExecuteDataTable("GetClearanceStatus", "vmsconnectionstring");
    }
    public DataTable GetHostNameForVisitorLogReport()
    {
        DBManager ObjDBManager = new DBManager();
        return ObjDBManager.ExecuteDataTable("EmpVMS", "vmsconnectionstring");
    }
    public DataTable win_LoadTransportMake()
    {
        DBManager ObjDBManager = new DBManager();
        return ObjDBManager.ExecuteDataTable("win_LoadTransportMake", "vmsconnectionstring");
    }
    public DataTable GetVehicleType()
    {
        DBManager ObjDBManager = new DBManager();
        return ObjDBManager.ExecuteDataTable("GetVehicleType", "vmsconnectionstring");
    }
    public DataTable GetVehicleNo()
    {
        DBManager ObjDBManager = new DBManager();
        return ObjDBManager.ExecuteDataTable("GetVehicleNo", "vmsconnectionstring");
    }
    public DataTable GetStatus()
    {
        DBManager ObjDBManager = new DBManager();
        return ObjDBManager.ExecuteDataTable("GetStatus", "vmsconnectionstring");
    }
    public DataTable GetDepartment()
    {
        DBManager ObjDBManager = new DBManager();
        return ObjDBManager.ExecuteDataTable("GetDepartment", "vmsconnectionstring");
    }
    public DataTable GetGateLane()
    {
        DBManager ObjDBManager = new DBManager();
        return ObjDBManager.ExecuteDataTable("GetGateLane", "vmsconnectionstring");
    }
    public DataTable GetGateNo()
    {
        DBManager ObjDBManager = new DBManager();
        return ObjDBManager.ExecuteDataTable("GetGateNo", "vmsconnectionstring");
    }
    public DataTable VisitArea()
    {
        DBManager ObjDBManager = new DBManager();
        return ObjDBManager.ExecuteDataTable("VisitArea1", "vmsconnectionstring");
    }
    public DataTable NewGetDeviceName()
    {
        DBManager ObjDBManager = new DBManager();
        return ObjDBManager.ExecuteDataTable("NewGetDeviceName", "vmsconnectionstring");
    }
    public DataTable GetGates()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetGate", "vmsconnectionstring");
    }

    public DataTable GetTerminalInfo()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetTerminalInfo", "vmsconnectionstring");
    }

    public DataTable LoadClientId()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetClientS", "vmsconnectionstring");
    }

    public DataTable GetTerminalNameAndIPs()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetTerminalNameAndIPs", "vmsconnectionstring");
    }
    public DataTable GetClientid()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetClientID", "vmsconnectionstring");
    }
    public DataTable GetTerminalType()
        {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetTerminalType", "vmsconnectionstring");
    }


    public DataTable GetContractorName()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetContractor", "vmsconnectionstring");
    }
  
    public DataTable GetSiteAllowedForWiegandDevices()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetSiteAllowedForWiegandDevices", "vmsconnectionstring");
    }
    public DataTable GetSiteAllowed()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetSiteAllowed", "vmsconnectionstring");
    }

    public DataTable GetTransport()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetTransport", "vmsconnectionstring");
    }
    
    public DataTable GetResidantStatus()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetRasidantStatus", "vmsconnectionstring");
    }

    public DataTable GetCadre()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetCadre", "vmsconnectionstring");
    }
    public DataTable GetCardColor()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("EmployeeCardColor", "vmsconnectionstring");
    }
    public DataTable GetDamoclesSensorTypeInfo()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetDamoclesSensorTypeInfos", "vmsconnectionstring");
    }

    public DataTable GetDamoclesSensorTypeInfo1()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetDamoclesSensorTypeInfos1", "vmsconnectionstring");
    }



    public DataTable GetDepartments()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetDepartment", "vmsconnectionstring");
    }




    public DataTable GetDepartmentsForResidentSearch()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetDepartmentForResidentSearch", "vmsconnectionstring");
    }

    public DataTable GetRelationship()
    {
        DBManager ObjDBManager = new DBManager();
        return ObjDBManager.ExecuteDataTable("GetRelationshipSP", "vmsconnectionstring");

    }

    public DataTable GetEmployeeNameId(int empid)
    {
        DBManager ObjDBManager = new DBManager();
        ObjDBManager.AddParameterReport("@DepId", empid);
        return ObjDBManager.ExecuteDataTable("GetEmployeeNameId", "vmsconnectionstring");

    }

    public DataTable ClearanceStatus()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("Sp_ClearanceStatus", "vmsconnectionstring");
    }

    public DataSet GetEmployeeDetailForGV( string Query)
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.SelectQuery(Query, "Details","vmsconnectionstring");
    }

    public DataTable Gender()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("Sp_Gender", "vmsconnectionstring");
    }


    public DataTable GetBusinessCommunityCategory()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetBusinessCommunity", "vmsconnectionstring");
    }



    public DataTable BloodGroup()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("Sp_BloodGroup", "vmsconnectionstring");
    }

    public DataTable Section()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("Sp_Section", "vmsconnectionstring");
    }


    public DataTable GetDepartmentsForNonResidentSearch()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetDepartmentForNonResidentSearch", "vmsconnectionstring");
    }
    public DataTable GetReligion()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetReligion", "vmsconnectionstring");
    }

    public DataTable GetRelation()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetRelation", "vmsconnectionstring");
    }

    public DataTable GetCategory()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetCategory", "vmsconnectionstring");
    }

    public DataTable GetCardCategory()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetCardCategory", "vmsconnectionstring");
    }
    //GetCount

        public DataTable GetCount()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetCount", "vmsconnectionstring");
    }
    public DataTable GetRanks()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetRanks", "vmsconnectionstring");
    }
    public DataTable GetDesignation()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetDesignation", "vmsconnectionstring");
    }

    public DataTable GetDesignationForResidentSearch()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetDesignationForResidentSearch", "vmsconnectionstring");
    }


    public DataTable GetDesignationForNonResidentSearch()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetDesignationForNonResidentSearch", "vmsconnectionstring");
    }



    public DataTable GetLocations()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetLocations", "vmsconnectionstring");
    }

    public DataTable GetCaste()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetCaste", "vmsconnectionstring");
    }

    public DataTable GetSectt()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetSectt", "vmsconnectionstring");
    }


    public DataTable GetEduducation()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetEducation", "vmsconnectionstring");
    }

    public DataTable GetGateLocation()
    {
        DBManager ObjDBManager = new DBManager();

        return ObjDBManager.ExecuteDataTable("GetGateLocations", "vmsconnectionstring");
    }

}