<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="EmployeeLogReport.aspx.cs" Inherits="RMS_EmployeeLogReport" %>


 <%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
       <table style="width: 100%; margin-top: 0%;">

        <tr>
            <td>
                <fieldset>
                    <legend>Employee Log Report</legend>

                    <table id="tbldamoclesinfo" style="font-family: Calibri; font-size: 11pt; width: 100%;">
                        <tr>
                            <td style="width: 140px; text-align: left;">Employee Name:
                            </td>
                            <td style="width: 600px;">
                                <asp:DropDownList ID="ddlEmployeeName" runat="server">
                            <asp:ListItem Value="">ALL</asp:ListItem>
                            </asp:DropDownList>
                            </td>
                             <td style="width: 140px; text-align: left;">Card No:
                            </td>
                            <td style="width: 600px;">
                                <asp:TextBox ID="txtCardPRefix" Width="95%" placeholder="Card No" class="req"   runat="server" BackColor="White"></asp:TextBox>
                            </td>
                            
                            </tr>

                         <tr>
                            <td style="width: 140px; text-align: left;">Date From:
                            </td>
                            <td style="width: 600px;">
                                <asp:TextBox ID="TextBoxFrom" style="width:60%;float: left; margin-right: 5px;" placeholder="Date From"   runat="server" BackColor="White"></asp:TextBox>
                                   <rjs:popcalendar ID="rjsDOB" Separator="/" Format="mm dd yyyy" Control="TextBoxFrom" runat="server"  To-Today="true"
                                Font-Names="Tahoma" />
                            </td>
                             <td style="width: 140px; text-align: left;">Date To:
                            </td>
                            <td style="width: 600px;">
                                <asp:TextBox ID="TextBoxTo" style="width:60%;float: left; margin-right: 5px;" placeholder="Date To"  runat="server" BackColor="White"></asp:TextBox>
                                 <rjs:popcalendar ID="Popcalendar1" Separator="/" Format="mm dd yyyy" Control="TextBoxTo" runat="server"  To-Today="true"
                                Font-Names="Tahoma" />
                            </td>
                            
                            </tr>

                        <tr>
                            <td style="width: 140px; text-align: left;">Department:
                            </td>
                            <td style="width: 600px;">
                              <asp:DropDownList ID="ddlDepartment" runat="server">
                            <asp:ListItem Value="">ALL</asp:ListItem>
                            </asp:DropDownList>
                            </td>
                             <td style="width: 140px; text-align: left;">Designation:
                            </td>
                            <td style="width: 600px;">
                            <asp:DropDownList ID="ddlRank" runat="server">
                            <asp:ListItem Value="">ALL</asp:ListItem>
                            </asp:DropDownList>
                            </td>
                            
                            </tr>

                         <tr>
                            <td style="width: 140px; text-align: left;">Gate Name:
                            </td>
                            <td style="width: 600px;">
                               <asp:DropDownList ID="ddlGate" runat="server">
                            <asp:ListItem Value="">ALL</asp:ListItem>
                            </asp:DropDownList>
                            </td>
                             <td style="width: 140px; text-align: left;">Terminal Name:
                            </td>
                            <td style="width: 600px;">
                                  <asp:DropDownList ID="ddlTerminal" runat="server">
                            <asp:ListItem Value="">ALL</asp:ListItem>
                            </asp:DropDownList>
                            </td>
                            
                            </tr>


                        <tr style="width:100%;">

                            <td>
                                </td>
                            <td>
                                <asp:Button ID="btnSave" Text="Search" CssClass="btn" OnClientClick="return getEmployee();" runat="server" />

                               
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>

    </table>
    <input type="button" id="btnExport" runat="server" value="Export to Excel" />

    <div id="divEmployeeDetailContainer">
        <fieldset id='fldEmployeeDetails' style="width:95%;""><legend> Details</legend>
             <table id='tblEmployeeDetails' class='dataTable' style='width: 100%'>
               
                 
                 
                   </table>


        </fieldset>
    </div>

    <script type="text/javascript">
        $(document).ready(function () {
        
          //  getEmployee();
        
        });


        function getEmployee() {
       
       //     $("input[id$='btnExport']").hide();
            //if (!validate("tblNameWiseReport")) {
            var EmployeeName = $("select[id$='ddlEmployeeName']").val().trim();
            var CardPRefix = $("input[id$='txtCardPRefix']").val().trim();
            var DateFrom = $("input[id$='TextBoxFrom']").val().trim();
            var DateTo = $("input[id$='TextBoxTo']").val().trim();
            var Department = $("select[id$='ddlDepartment']").val().trim();
            var Deg = $("select[id$='ddlRank']").val().trim();
            var Gate = $("select[id$='ddlGate']").val().trim();
            var Terminal = $("select[id$='ddlTerminal']").val().trim();
            
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../RMS/RMSwebmethods.aspx/getEmployeeLogReport",
                data: "{'Employee_Id':'" + EmployeeName + "','Card_Id':'" + CardPRefix + "','Date_From':'" + DateFrom + "','Date_To':'" + DateTo + "','Department_Id':'" + Department + "','Designation_Id':'" + Deg + "','Gate_Id':'" + Gate + "','Terminal_Id':'" + Terminal + "'}",
                success: onsuccessgetEmployee
            });
            // }
            return false;
        }
        function onsuccessgetEmployee(msg) {
            var data = msg.d;
            //if (oTable != null) {
            //    oTable.fnClearTable();
            //    oTable.fnDestroy();
            //}
           
                getVMSVisitorTable(data);
            

            //$("input[id$='btnExport']").show();
            //$("input[id$='hdEmpIds']").val(EmpIds);
            // dataTable();
            //getEmployeeFamily(EmpID);
            return false;
        }
        function getVMSVisitorTable(data) {
           
            var tbl = "";

            tbl += "<thead>";
            tbl += "<tr>";


            tbl += "<th style='text-align:left;'>Employee</th>";
            tbl += "<th style=' text-align:left;'>Card No</th>";
            tbl += "<th style=' text-align:left;'>Department</th>";
            tbl += "<th style=' text-align:left;'>Designation</th>";
            tbl += "<th style=' text-align:left;'>Gate Name</th>";
            tbl += "<th style=' text-align:left;'>Terminal Name</th>";
            tbl += "<th style=' text-align:left;'>Date</th>";
         

            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
           
            for (var i = 0; i < data.EmployeeLogReport.length; i++) {
                tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' >";
                tbl += "<td style='text-align:left;'>" + data.EmployeeLogReport[i].name + "</td>";
                tbl += "<td style=' text-align:left;'>" + data.EmployeeLogReport[i].CardNumber + "</td>";
                tbl += "<td style=' text-align:left;'>" + data.EmployeeLogReport[i].Department_Name + "</td>";
                tbl += "<td style=' text-align:left;'>" + data.EmployeeLogReport[i].designation + "</td>";
                tbl += "<td style=' text-align:left;'>" + data.EmployeeLogReport[i].Gate_Name + "</td>";
                tbl += "<td style=' text-align:left;'>" + data.EmployeeLogReport[i].TerminalName + "</td>";
                tbl += "<td style=' text-align:left;'>" + data.EmployeeLogReport[i].Date + "</td>";
                tbl += "</tr>";
               
            }
            tbl += "</tbody>";
            $("#tblEmployeeDetails").html(tbl);
        }
    </script>
</asp:Content>

