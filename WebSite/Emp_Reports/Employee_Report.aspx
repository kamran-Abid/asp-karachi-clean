<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="Employee_Report.aspx.cs" Inherits="Reports_Employee_Report" %>


<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=15.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>


 <%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <script src="../../js/BlockUI.js" type="text/javascript"></script>
    <script src="../../js/FieldValidation.js" type="text/javascript"></script>

    <link rel="stylesheet" type="text/css" href="DataTables/datatables.min.css"/>
 
    <script type="text/javascript" src="DataTables/datatables.min.js"></script>

    <fieldset>
        <legend>Filters</legend>
        <table style="width: 100%;">
            <tr>
                <td>
                    <asp:Label ID="lblCNIC" runat="server" Text="CNIC:"></asp:Label></td>
                <td>
                    <asp:TextBox ID="txtCNIC" runat="server" Width="287px" Height="25px"></asp:TextBox>
                    <%--onblur="getVisitorByCNIC()"--%>
                </td>
                <td>
                    <asp:Label ID="lblDepartment" Text="Department:" runat="server"></asp:Label></td>
                <td>
                    <asp:DropDownList ID="ddlDepartment" runat="server" ClientIDMode="Static" Height="52px" Width="300px"></asp:DropDownList>
                    <%--<asp:TextBox ID="txtHost" runat="server"></asp:TextBox>--%>
              </td>
                <%--<ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender1" runat="server"
                 MaskType="Number" Mask="99999-9999999-9" TargetControlID="TxtCNIC"
                 MessageValidatorTip="true" ClearMaskOnLostFocus="false"/>--%>
            </tr>
            <tr>
                          <%--onblur="getVisitorByCNIC()"--%>
                 <td class="auto-style1">
                     <asp:Label ID="lblDesignation" runat="server" Text="Designation:"></asp:Label>

                 </td>
                <td class="auto-style1">
                    <asp:DropDownList ID="ddlDesignation" runat="server" ClientIDMode="Static" Height="46px" Width="300px" ></asp:DropDownList>
                    <%--<asp:DropDownList ID="txtFloor" runat="server" 
                    Style="background-color: Lavender;font-family: Calibri;" onchange="return getCompaniesName();"></asp:DropDownList>--%>
                    <%--<asp:TextBox ID="txtFloor" runat="server"></asp:TextBox>" onchange="return getCompaniesName();"--%>
                    <%--background-color: Lavender;--%>
                </td>
                <td class="auto-style1"><asp:Label ID="lblRank" runat="server" Text="Rank"></asp:Label>
                </td>
                <td class="auto-style1">
                    <asp:DropDownList ID="ddlRank" runat="server" ClientIDMode="Static" Height="48px" Width="300px" ></asp:DropDownList>
                    </td>
<%--                    <select class="form-control" id="txtCompany" disabled="false" name="departmentsDropdown"></select>--%>
                    <%--<asp:TextBox ID="txtCompany" runat="server"></asp:TextBox>--%>
                
            </tr>
                <tr>
                     <td><asp:Label ID="lblGender" runat="server" Text="Gender:"></asp:Label>  </td>
                    <td class="auto-style1">
                    <asp:DropDownList ID="ddlGender" runat="server" ClientIDMode="Static" Height="48px" Width="300px" ></asp:DropDownList>
                    </td>
                    <td><asp:Label ID="lblPNo" runat="server" Text="PNo:"></asp:Label>  </td>
                    <td> <asp:TextBox ID="txtPNo" runat="server" Height="25px" Width="285px"></asp:TextBox></td>
                 
               </tr>
            <tr>
                  <td><asp:Label ID="lblGateNo" runat="server" Text="GateNo:"></asp:Label>  </td>
                    <td class="auto-style1">
                    <asp:DropDownList ID="ddlGateNo" runat="server" ClientIDMode="Static" Height="48px" Width="300px" ></asp:DropDownList>
                        </td>
                    <td><asp:Label ID="lblGateLane" runat="server" Text="Gate Lane:"></asp:Label>  </td>
                    <td class="auto-style1">
                    <asp:DropDownList ID="ddlGateLane" runat="server" ClientIDMode="Static" Height="48px" Width="300px" ></asp:DropDownList>
                 </td>
            </tr>
            <tr>
                
                    <td><asp:Label ID="lblDeviceName" runat="server" Text="DeviceName:"></asp:Label>  </td>
                     <td class="auto-style1">
                    <asp:DropDownList ID="ddlDeviceName" runat="server" ClientIDMode="Static" Height="48px" Width="300px" ></asp:DropDownList>
            </tr>
              
            <tr>
                <td>
                    <asp:Label ID="lblDate" Text="From Date:" runat="server"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtDate" runat="server" TextMode="Date" value="2021-01-01" Width="297px" Height="25px"></asp:TextBox>
                </td>
                <td>
                    <asp:Label ID="lblToDate" Text="To Date:" runat="server"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtToDate" runat="server" TextMode="Date" value ="2022-01-01" Height="25px" Width="300px"></asp:TextBox>
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
        <table id="tblITProjDetails" class="dataTable" style="width: 95%;">
        </table>
    </fieldset>


    <script type="text/javascript" language="javascript">
        var oTable;
        $(document).ready(function () {
            //getITProj();
        });
        function dataTable() { $("#tblITProjDetails").dataTable({}); }

        //function getCompaniesName() {

        //    var ProjectID = $("select[id$='ddlFloor']").val();
        //    $.ajax({
        //        type: "POST",
        //        contentType: "application/json; charset=utf-8",
        //        url: "Staff_Registration_Search.aspx/getCompanyName",
        //        data: "{'ProjectID':'" + ProjectID + "'}",
        //        success: onsuccessgetCompaniesName,
        //        error: onerrorCompaniesName
        //    });
        //    return;
        //}
        //function onsuccessgetCompaniesName(msg) {
        //    var data = msg.d;
        //    var s = '<option value="0">--Select--</option>';

        //    for (var i = 0; i < data.CompanyDetails.length; i++) {
        //        s += '<option value="' + data.CompanyDetails[i].Company_ID + '">' + data.CompanyDetails[i].Company_Name + '</option>';
        //    }

        //    $("#ddlCompany").html(s);

        //    document.getElementById('ddlCompany').disabled = false;

        //}

        //function onerrorCompaniesName() {
        //    document.getElementById("ddlCompany").disabled = true;
        //    alert("Error In Loading Company Name!");
        //    return false;
        //}

       
       
        function getITProj() {
         
            var CNIC = $("input[id$='txtCNIC']").val();
            //alert(CNIC);
            var Department = $('#ddlDepartment').find('option:selected').text();
            //alert(Department);

            var Designation = $('#ddlDesignation').find('option:selected').text();
            
            var Rank = $('#ddlRank').find('option:selected').text();
            //alert(Rank);
            var Gender = $('#ddlGender').find('option:selected').text();
            //alert(Gender);
            var PNo = $("input[id$='txtPNo']").val();
           
            var GateNo = $('#ddlGateNo').find('option:selected').text();
            
            var GateLane = $('#ddlGateLane').find('option:selected').text();
           
            var DeviceName = $('#ddlDeviceName').find('option:selected').text();


            var DateV = $("input[id$='txtDate']").val();
          
            var ToDateV = $("input[id$='txtToDate']").val();
         


            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Employee_Report.aspx/GetITProjDetails",
                data: "{'CNIC':'" + CNIC + "','Department':'" + Department + "','Designation':'" + Designation + "', 'Rank':'" + Rank + "','Gender': '" + Gender + "', 'PNo': '" + PNo + "' , 'GateNo': '" + GateNo + "' , 'GateLane': '" + GateLane + "' , 'DeviceName': '" + DeviceName + "','FromDate':'" + DateV + "','ToDate':'" + ToDateV + "'}",

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
           // tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Person ID</th>";
            tbl += "<th style='text-align:left; white-space:nowrap;'>Sr#</th>";
            tbl += "<th style='text-align:left; white-space:nowrap;'>VID</th>";
            tbl += "<th style='text-align:left; white-space:nowrap;'>Date</th>";
            tbl += "<th style='text-align:left; white-space:nowrap;'>PNo</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Name</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>CNIC</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Father Name</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;' >Department</th>"
            tbl += "<th style='white-space:nowrap; text-align:left;' >Designation</th>"
            tbl += "<th style='white-space:nowrap; text-align:left;' >Rank</th>"
            tbl += "<th style='white-space:nowrap; text-align:left;' >Gender</th>"
           
            tbl += "<th style='white-space:nowrap; text-align:left;'>Site Name</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Valid Upto</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Vehicle No</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Gate Name</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Gate Lane</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>User Type</th>";

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
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtProjID" + i + "'>" + data.ProjDetails[i].VID + "</td>";
                //tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtVID" + i + "'>" + data.ProjDetails[i].VID + "</td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtDate" + i + "'>" + data.ProjDetails[i].DATE + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtPNo" + i + "'>" + data.ProjDetails[i].ServiceNo + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtName" + i + "'>" + data.ProjDetails[i].Full_Name + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCNIC" + i + "'>" + data.ProjDetails[i].Nic + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtFatherName" + i + "'>" + data.ProjDetails[i].FatherName + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtDepartment" + i + "'>" + data.ProjDetails[i].Department_Name + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtDesignation" + i + "'>" + data.ProjDetails[i].designation + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtRank" + i + "'>" + data.ProjDetails[i].Rank_Name + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtGender" + i + "'>" + data.ProjDetails[i].GenderName + " </td>";

                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtSiteName" + i + "'>" + data.ProjDetails[i].Site_Name + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtValidUpto" + i + "'>" + data.ProjDetails[i].ValidUpto + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtVEHICLENUMBER" + i + "'>" + data.ProjDetails[i].VEHICLE_NUMBER + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtGateName" + i + "'>" + data.ProjDetails[i].Gate_Name + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtGatelane" + i + "'>" + data.ProjDetails[i].Gate_Lane + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtUserType" + i + "'>" + data.ProjDetails[i].User_Type + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtTeriminalName" + i + "'>" + data.ProjDetails[i].TerminalName + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtDeviceName" + i + "'>" + data.ProjDetails[i].Device_Name + " </td>";
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