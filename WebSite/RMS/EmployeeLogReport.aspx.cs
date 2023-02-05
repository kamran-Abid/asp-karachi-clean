using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class RMS_EmployeeLogReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Dictionary<string, object> report = DBCommonMethods.GetAllDesignations();
            List<Dictionary<string, object>> designations = (List<Dictionary<string, object>>)report["Designations"];
            for (int i = 0; i < designations.Count; i++)
            {
                ListItem item = new ListItem(designations[i]["designation"].ToString(), designations[i]["Designation_ID"].ToString());
                ddlRank.Items.Add(item);
            }

            Dictionary<string, object> Employee = DBCommonMethods.GetAllEmployee();
            List<Dictionary<string, object>> EmployeeList = (List<Dictionary<string, object>>)Employee["Employees"];
            for (int i = 0; i < EmployeeList.Count; i++)
            {
                ListItem item = new ListItem(EmployeeList[i]["Name"].ToString(), EmployeeList[i]["EID"].ToString());
                ddlEmployeeName.Items.Add(item);
            }

            Dictionary<string, object> Dept = DBCommonMethods.GetAllDepartments();
            List<Dictionary<string, object>> DeptList = (List<Dictionary<string, object>>)Dept["mctx_Department"];
            for (int i = 0; i < DeptList.Count; i++)
            {
                ListItem item = new ListItem(DeptList[i]["Department_Name"].ToString(), DeptList[i]["Department_ID"].ToString());
                ddlDepartment.Items.Add(item);
            }

            Dictionary<string, object> Gate = DBCommonMethods.GetAllGate();
            List<Dictionary<string, object>> GateList = (List<Dictionary<string, object>>)Gate["mctx_Gates"];
            for (int i = 0; i < GateList.Count; i++)
            {
                ListItem item = new ListItem(GateList[i]["Gate_Name"].ToString(), GateList[i]["Gate_ID"].ToString());
                ddlGate.Items.Add(item);
            }

            Dictionary<string, object> Terminal = DBCommonMethods.GetAllTerminal();
            List<Dictionary<string, object>> TerminalList = (List<Dictionary<string, object>>)Terminal["mctx_TerminalInfos"];
            for (int i = 0; i < TerminalList.Count; i++)
            {
                ListItem item = new ListItem(TerminalList[i]["TerminalName"].ToString(), TerminalList[i]["Terminal_ID"].ToString());
                ddlTerminal.Items.Add(item);
            }
        }

    }

  

}