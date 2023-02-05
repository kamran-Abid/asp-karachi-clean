<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="PACS_Report.aspx.cs" Inherits="PACS_Report_PACS_Report" %>


<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=15.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>


 <%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style1 {
            width: 407px;
        }
        .auto-style2 {
            width: 250px;
        }
        .auto-style3 {
            width: 202px;
        }
        .auto-style4 {
            margin-left: 3px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
     <script src="../../js/BlockUI.js" type="text/javascript"></script>
    <script src="../../js/FieldValidation.js" type="text/javascript"></script>

    <link rel="stylesheet" type="text/css" href="DataTables/datatables.min.css"/>
 
    <script type="text/javascript" src="DataTables/datatables.min.js"></script>
    <fieldset>
       <legend>Filters</legend>
          <table style width="100%;">
              <tr>
                  <td class="auto-style1">
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      <asp:Label ID="lblCNIC" runat="server" Text="CNIC">

                      </asp:Label>
                      :</td>
                   <td class="auto-style1">
                       <asp:TextBox ID="txtCNIC" runat="server" Height="24px" Width="389px" ClientIDMode="Static"></asp:TextBox>
                   </td>
                   <td class="auto-style1">
                       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                       <asp:Label ID="lblPNo" runat="server" Text="PNo"></asp:Label>
                       :</td>
                   <td> <asp:TextBox ID="txtPNo" runat="server" Height="24px" Width="375px" ClientIDMode="Static" CssClass="auto-style4"></asp:TextBox></td>
              </tr>
              <tr>
                   <td class="auto-style1">
                       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                       <asp:Label ID="lblVehicleNo" runat="server" Text="VehicleNo"></asp:Label>
                   </td>
                   <td class="auto-style1">
                         <asp:DropDownList ID="ddlVehicleNo" runat="server" ClientIDMode="Static" Height="48px" Width="401px" ></asp:DropDownList>
                   </td>
                   <td class="auto-style1"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblMake" runat="server" Text="Make"></asp:Label></td>
                   <td>
                        <asp:DropDownList ID="ddlMake" runat="server" ClientIDMode="Static" Height="48px" Width="393px" ></asp:DropDownList>
                   </td>
              </tr>
               <tr>
                   <td class="auto-style1">
                       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                       <asp:Label ID="lblVehicleType" runat="server" Text="Vehicle Type"></asp:Label>
                   </td>
                   <td>
                      <asp:DropDownList ID="ddlVehicleType" runat="server" ClientIDMode="Static" Height="48px" Width="401px"> 

                      </asp:DropDownList>
                   </td>
                  
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="lblGateLane" runat="server" Text="Gate Lane:"></asp:Label>  </td>
                    <td class="auto-style1">
                    <asp:DropDownList ID="ddlGateLane" runat="server" ClientIDMode="Static" Height="48px" Width="390px" ></asp:DropDownList>
                 </td>
            </tr>
            <tr>
                
                    <td class="auto-style1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="lblDeviceName" runat="server" Text="DeviceName:"></asp:Label>  </td>
                     <td class="auto-style1">
                    <asp:DropDownList ID="ddlDeviceName" runat="server" ClientIDMode="Static" Height="48px" Width="400px" ></asp:DropDownList>
                         </td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="lblGateNo" runat="server" Text="GateNo:"></asp:Label>  </td>
                    <td class="auto-style1">
                    <asp:DropDownList ID="ddlGateNo" runat="server" ClientIDMode="Static" Height="48px" Width="391px" ></asp:DropDownList>
                        </td>
            </tr>
              <tr>
                   <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="lblClearanceStatus" runat="server" Text="ClearanceStatus:"></asp:Label>  </td>
                    <td class="auto-style1">
                    <asp:DropDownList ID="ddlClearanceStatus" runat="server" ClientIDMode="Static" Height="48px" Width="391px" ></asp:DropDownList>
                        </td>
              </tr>
              
            <tr>
                <td class="auto-style1">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Label ID="lblDate" Text="From Date:" runat="server"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtDate" runat="server" TextMode="Date" value="2021-01-01" Width="388px" Height="25px"></asp:TextBox>
                </td>
                <td>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Label ID="lblToDate" Text="To Date:" runat="server"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtToDate" runat="server" TextMode="Date" value ="2022-01-01" Height="25px" Width="396px"></asp:TextBox>
                </td>
            </tr>
                   <tr>
                <td>
                    <asp:Button ID="btnSearch" ClientIDMode="Static" Text="Search" runat="server" OnClientClick=" return getITProj();"></asp:Button>

                </td>
                <td>
                <asp:Button ID="btnExportToExcel"  runat="server" Text="Export to Excel" onclick="btnExportToExcel_Click"/>
                </td>
            </tr>
           
          </table>
      
    </fieldset>
    <fieldset>
        <legend>Details</legend>
        <table id= "tblITProjDetails" Width="100%;"  class="datatable">

        </table>
    </fieldset>
    <script type="text/javascript" language="javascript">
        var oTable;
        document.ready(function () {

        });
        function dataTable() { $("#tblITProjDetails").dataTable({}); }

        function getITProj() {


            var CNIC = $("input[id$='txtCNIC']").val();
            //alert(CNIC);
            var PNo = $("input[id$='txtPNo']").val();

            var VehicleNo = $('#ddlVehicleNo').find('option:selected').text();
            //alert(Department);

            var Make = $('#ddlMake').find('option:selected').text();

            var VehicleType = $('#ddlVehicleType').find('option:selected').text();

            var GateLane = $('#ddlGateLane').find('option:selected').text();

            var DeviceName = $('#ddlDeviceName').find('option:selected').text();

            var GateNo = $('#ddlGateNo').find('option:selected').text();

            var ClearanceStatus = $('#ddlClearanceStatus').find('option:selected').text;

            var DateV = $("input[id$='txtDate']").val();

            var ToDateV = $("input[id$='txtToDate']").val();

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "PACS_Report.aspx/GetITProjDetails",
                data: "{'CNIC':'" + CNIC + "','PNo':'" + PNo + "','VehicleNo':'" + VehicleNo + "', 'Make':'" + Make + "','VehicleType': '" + VehicleType + "' ,  'GateLane': '" + GateLane + "' , 'DeviceName': '" + DeviceName + "', 'GateNo': '" + GateNo + "' ,'ClearanceStatus': '" + ClearanceStatus +"','FromDate':'" + DateV + "','ToDate':'" + ToDateV + "'}", // 
                //string CNIC, string PNo, string VehicleNo, string Make, string VehicleType, string GateNo, string GateLane, string DeviceName, DateTime FromDate, DateTime ToDate
                success: onsuccessgetITProj,
                error: onretrievegetITProj
            });
            return false;
        }
        function onsuccessgetITProj(msg) {
            var data = msg.d;
            //alert("Success");
            if (oTable != null) {
                oTable.fnClearTable();
                oTable.fnDestroy();
            }
            var tbl = "";
            tbl += "<thead>";
            tbl += "<tr>";
             tbl += "<th style='text-align:left; white-space:nowrap;'>Sr#</th>";
            tbl += "<th style='text-align:left; white-space:nowrap;'>Date</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>PNo</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;' >Name</th>"
            tbl += "<th style='white-space:nowrap; text-align:left;' >CNIC</th>" 
            tbl += "<th style='white-space:nowrap; text-align:left;'>Department</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Designation</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Rank</th>";
            tbl += "<th style='text-align:left; white-space:nowrap;'>VehicelNo</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;' >VehicelType</th>"
            tbl += "<th style='text-align:left; white-space:nowrap;'>Make</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>BodyType</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Model</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Colour</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;' >VehicelType</th>"
            tbl += "<th style='white-space:nowrap; text-align:left;' >Employee Type</th>"
            tbl += "<th style='white-space:nowrap; text-align:left;'>Clearance Status</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Site Allowed</th>"; 
            tbl += "<th style='white-space:nowrap; text-align:left;'>Vehicle No</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Gate Name</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Gate Lane</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>User Type</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Gender</th>"; 
            tbl += "<th style='white-space:nowrap; text-align:left;'>Terminal Name</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Device Name</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Remarks</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Time In</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Time Out</th>";

            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            //tbl += "<tr> <td style='text-align:left; white-space:nowrap;'id='txtHeadCount'><strong>Head Count: " + data.ProjDetails.length + "</strong></td></tr>";
            for (var i = 0; i < data.ProjDetails.length; i++) {
                var j = i + 1;
                tbl += "<tr>";

                tbl += "<td style='text-align:left; white-space:nowrap;'id='SR#" + i + "'>" + j + "</td>";
                //tbl += "<td style='text-align:right; white-space:nowrap;' id='txtVID" + i + "'>" + data.ProjDetails[i].VID + "</td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtDate" + i + "'>" + data.ProjDetails[i].DATE + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtPNo" + i + "'>" + data.ProjDetails[i].ServiceNo + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtName" + i + "'>" + data.ProjDetails[i].Full_Name + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCNIC" + i + "'>" + data.ProjDetails[i].CNIC + "</td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtDepartment" + i + "'>" + data.ProjDetails[i].Department_Name + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtDesignation" + i + "'>" + data.ProjDetails[i].designation + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtRank" + i + "'>" + data.ProjDetails[i].Rank_Name + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtVehicelNo" + i + "'>" + data.ProjDetails[i].VehicleNo + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='VehicleType" + i + "'>" + data.ProjDetails[i].VehicleType + "</td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtMake" + i + "'>" + data.ProjDetails[i].Make + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtBodyType" + i + "'>" + data.ProjDetails[i].Body_Type + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModel" + i + "'>" + data.ProjDetails[i].Model + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtColour" + i + "'>" + data.ProjDetails[i].Colour + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtEmpType" + i + "'>" + data.ProjDetails[i].EMP_Type + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtClearanceStatus" + i + "'>" + data.ProjDetails[i].Clearance_Status + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtSiteAllowed" + i + "'>" + data.ProjDetails[i].Site_Allowed + " </td>";
                
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtGateName" + i + "'>" + data.ProjDetails[i].Gate_Name + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtGateLane" + i + "'>" + data.ProjDetails[i].Gate_Lane + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtUser_Type" + i + "'>" + data.ProjDetails[i].User_Type + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtGender_Name" + i + "'>" + data.ProjDetails[i].GenderName + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtTerminalName" + i + "'>" + data.ProjDetails[i].TerminalName + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtDevice_Name" + i + "'>" + data.ProjDetails[i].Device_Name + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtRemarks" + i + "'>" + data.ProjDetails[i].Remarks + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtTimeIn" + i + "'>" + data.ProjDetails[i].TIME_IN + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtTimeOut" + i + "'>" + data.ProjDetails[i].TIME_OUT + " </td>";
                /*       tbl += "<td style='text-align:right; white-space:nowrap;' id='txtPurpose" + i + "'>" + data.ProjDetails[i].Purpose_Name + " </td>";*/
                //tbl += "<td style='text-align:right; white-space:nowrap;' id='txtTimeIn" + i + "'>" + data.ProjDetails[i].TIME_IN + " </td>";
                //tbl += "<td style='text-align:right; white-space:nowrap;' id='txtTimeOut" + i + "'>" + data.ProjDetails[i].TIME_OUT + " </td>";
                //tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.ProjDetails[i].Visitor_Type + " </td>";
                //tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord(" + i + ");'><img src='images/Edit.png' width='40px' height='40px'></td>";
                //tbl += "<td style='cursor:Pointer;' id='txtdelete' align='center' onclick='return DeleteRecord(" + data.ProjDetails[i].Person_ID + ");'><img src='images/Cross3.png' width='45px' height='60px'> </td>";
                tbl += "</tr>";
            }
            tbl += "</tbody>";
            tbl += "</table>";
            $("#tblITProjDetails").html(tbl);
            //dataTable();
            return false;
        }
        function onretrievegetITProj() {
            alert("Error In Loading Details!");
            return false;
        }
        
    </script>
</asp:Content>

