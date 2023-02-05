<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="CNICWiseReport.aspx.cs" Inherits="CNICWiseReport" %>

<%-- <%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>--%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <link href="../css/jquery-ui.min.css" rel="stylesheet" />
    <script src="../js/jquery-ui.min.js"></script>

    <fieldset style="width: 95%;">
        <legend><span id="spnSearchTitle" runat="server">Resident</span> Search Criteria</legend>
        <div>
            <table id="tblCNICWiseReport" class="form">
                <tr>
                    <td class="right">Enter CNIC NO:</td>
                    <td>
                        <asp:TextBox ID="txtCNICNo" placeholder="Enter minimum 3 digits" class="numeric cnic" runat="server" autocomplete="off"></asp:TextBox>
                        <asp:HiddenField ID="hfCustomerId" runat="server" />
                        <asp:HiddenField ID="ddlType" Value="1" runat="server" />
                      
                    </td>
                    <td>
                        <asp:Button ID="btnSearch" Text="Search" CssClass="btn" OnClientClick="return getEmployee();" runat="server" />
                    </td>
                </tr>
            </table>
        </div>
    </fieldset>


    <%--<input type="button" onclick="tablesToExcel(['fldEmployeeDetails', 'fldEmployeeFamilyDetails', 'fldEmployeeServentDetail', 'fldEmployeeSarventFamilyDetail'], ['first', 'second'], 'myfile.xls')" value="Export to Excel">--%>

    <input type="button" id="btnExport" onserverclick="ExportToExcel" runat="server" value="Export to Excel" />
    <div id="divEmployeeDetailContainer"></div>

    <div id="divEmployeeFamilyDetailContainer"></div>

    <div id="divEmployeeServantDetailContainer"></div>

    <div id="divServantsFamilyDetailContainer"></div>

    <asp:HiddenField ID="hdType" Value="1" runat="server" />
    <asp:HiddenField ID="hdEmpIds" Value="" runat="server" />
     <asp:HiddenField ID="hdShowFamily" Value="" runat="server" />

    <script type="text/javascript" language="javascript">

        var oTable;
        var employeeID;
        var EmpIds = "";
        var serventFamilyIDs = "";

        $(document).ajaxStart(blockUI).ajaxStop(unblockUI);

        function blockUI() {
            $.blockUI({
                message: '<img src="images/ajax-loader.gif" />',
                css: { borderStyle: 'none', backgroundColor: "Transparent" }
            });
        }
        function unblockUI() {
            $.unblockUI();
        }

        $(document).ready(function () {
            // getEmployee();
            $("input[id$='btnExport']").hide();
            $("#btnExport").click(function () {
               
            });

            $("input[id$='txtCNICNo']").autocomplete({
                source: function (request, response) {
                    var CNIC = $("input[id$='txtCNICNo']").val().trim();
                    var Type = $("input[id$='ddlType']").val().trim();
                    $.ajax({
                        url: '<%=ResolveUrl("~/RMS/RMSwebmethods.aspx/GetCNICNos") %>',
                        data: "{  'CNIC':'" + CNIC + "','Type':'" + Type + "','Name':'','Rank':'','Status':''}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            var a = data.d;

                            response($.map(data.d, function (item) {
                                return {
                                    label: item,
                                    val: item
                                }
                            }))
                        },
                        error: function (response) {
                            alert(response.responseText);
                        },
                        failure: function (response) {
                            alert(response.responseText);
                        }
                    });
                },
                select: function (e, i) {
                    $("#<%=hfCustomerId.ClientID %>").val(i.item.val);
                },
                minLength: 3,
                maxNumberOfElements: 10
            });


        });

            function dataTable() {
                oTable = $("#tblEmployeeDetails").dataTable({
                    "aLengthMenu": [[5,10,25, 50, 75, -1], [5,10,25, 50, 75, "All"]],
                    "iDisplayLength": 5
                });
            }
            function dataTableEmpFamily() {
                oTable = $("#tblEmployeeFamilyDetails").dataTable({
                    bPaginate: false,
                    bJQueryUI: true,
                    oLanguage: { "sSearch": "Filter: " }
                });
            }

            function getEmployee() {
                var CNIC = $("input[id$='txtCNICNo']").val().trim();
                if (CNIC == "") {
                    alert("Please Enter CNIC!");
                    $("input[id$='txtCNICNo']").focus();
                    return false;
                }
                $("input[id$='hdShowFamily']").val("");
                $("#divEmployeeDetailContainer").html("");
                $("#divEmployeeFamilyDetailContainer").html("");
                $("#divEmployeeServantDetailContainer").html("");
                $("#divServantsFamilyDetailContainer").html("");
                $("input[id$='btnExport']").show();
                //if (!validate("tblCNICWiseReport")) {
               
                var Type = $("input[id$='ddlType']").val().trim();
                $("input[id$='hdType']").val(Type);
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../RMS/RMSwebmethods.aspx/getCNICWiseReport",
                    data: "{'CNIC':'" + CNIC + "','Type':'" + Type + "'}",
                    success: onsuccessgetEmployee
                });
                // }
                return false;
            }
            function onsuccessgetEmployee(msg) {
                var data = msg.d;
                if (oTable != null) {
                    oTable.fnClearTable();
                    oTable.fnDestroy();
                }
                var Type = $("input[id$='ddlType']").val().trim();
                if (Type == "1") {
                    getEmployeeTable(data);
                } else if (Type == "2"){
                    getNonResidentTable(data);
                } else if (Type == "3") {
                    getVisitorTable(data);
                }
                else if (Type == "4") {
                    getVMSVisitorTable(data);
                }
                
                $("input[id$='btnExport']").show();
                $("input[id$='hdEmpIds']").val(EmpIds);
                // dataTable();
                //getEmployeeFamily(EmpID);
                return false;
            }

            function getEmployeeTable(data) {
                var Type = $("input[id$='ddlType']").val().trim();
                var picDir = "../RMS/EmpPictures/";

                var tbl = "<fieldset id='fldEmployeeDetails' style=width: 95%;'><legend>" + $('span[id$="spnSearchTitle"]').text() + " Details</legend><div id='divEmployeeDetails' style='overflow: auto; width: 100%; '>" +
                          "<table id='tblEmployeeDetails' class='dataTable' style='width: 100%'>";

                tbl += "<thead>";
                tbl += "<tr>";

                tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Employee ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Detail</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Service No</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Name</th>";

                tbl += "<th style='white-space:nowrap; text-align:left;'>Rank</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>NIC</th>";
                //tbl += "<th style='white-space:nowrap; text-align:left;'>Date of Birth</th>";

                //tbl += "<th style='white-space:nowrap; text-align:left;'>Location</th>";
                //tbl += "<th style='white-space:nowrap; text-align:left;'>Department</th>";
                //tbl += "<th style='white-space:nowrap; text-align:left;'>Allotment Date</th>";

                //tbl += "<th style='white-space:nowrap; text-align:left;'>Release Date</th>";
                //tbl += "<th style='white-space:nowrap; text-align:left;'>Cell No</th>";
                //tbl += "<th style='white-space:nowrap; text-align:left;'>Phone Office</th>";

                //tbl += "<th style='white-space:nowrap; text-align:left;'>Phone Home</th>";
                //tbl += "<th style='white-space:nowrap; text-align:left;'>Current Address</th>";
                //tbl += "<th style='white-space:nowrap; text-align:left;'>Permanent Address</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Status</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Photo</th>";

                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
                var EmpID = 0;
               // alert(data.EmployeeDetail.length);
                EmpIds = "";
                for (var i = 0; i < data.EmployeeDetail.length; i++) {
                    tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' >";
                    tbl += "<td style='text-align:right; white-space:nowrap;' ><a onclick='getEmployeeFamily(" + data.EmployeeDetail[i].EID + ")' href='#'>Detail</a></td>";
                    tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.EmployeeDetail[i].EID + "</td>";

                    tbl += "<td style='text-align:left; white-space:nowrap;' id='txtVisitorName" + i + "'>" + data.EmployeeDetail[i].ServiceNo + "</td>";
                    tbl += "<td style='text-align:left; white-space:nowrap;' id='txtVisitorName" + i + "'>" + data.EmployeeDetail[i].FirstName + " " + data.EmployeeDetail[i].LastName + "</td>";

                    tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.EmployeeDetail[i].Rank + "</td>";
                    tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.EmployeeDetail[i].Nic + " </td>";
                    //tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.EmployeeDetail[i].Dob + " </td>";
                    //tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.EmployeeDetail[i].Location + " </td>";

                    //tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.EmployeeDetail[i].Department + "</td>";
                    //tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.EmployeeDetail[i].AllotmentDate + " </td>";
                    //tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.EmployeeDetail[i].ReleaseDate + " </td>";
                    //tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.EmployeeDetail[i].Mobile + " </td>";
                    //tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.EmployeeDetail[i].PhoneOffice + "</td>";
                    //tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.EmployeeDetail[i].PhoneHome + " </td>";
                    //tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.EmployeeDetail[i].CurrAddr + " </td>";
                    //tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.EmployeeDetail[i].PerAddr + " </td>";
                    tbl += "<td style='text-align:right; white-space:nowrap;' id='txtEmpStatus" + i + "'>" + data.EmployeeDetail[i].Status + " </td>";
                    tbl += "<td class='CNICEmpImage' style='text-align:center;'><img src='../RMS/CallBack/GetImageDatafromDB.aspx?PrimaryKeyIDValue=" + data.EmployeeDetail[i].EID + "&tableName=Employee&ImagecolumnName=NewPhoto&PrimaryKeyColumnName=EID' height='50px' width='50px'></td>";
                    tbl += "</tr>";
                    EmpID = data.EmployeeDetail[i].EID;
                    EmpIds += EmpID + ",";
                }
                tbl += "</tbody>";
                tbl += "</table></div></fieldset>";
                $("#divEmployeeDetailContainer").html(tbl);

               // dataTable();
                return false;
            }

            function getNonResidentTable(data) {
                var Type = $("input[id$='ddlType']").val().trim();
                var picDir = "../RMS/NoneResidentsPictures/";
                
                var tbl = "<fieldset id='fldEmployeeDetails' style=width: 95%;'><legend>" + $('span[id$="spnSearchTitle"]').text() + " Details</legend><div id='divEmployeeDetails' style='overflow: auto; width: 100%;'>" +
                          "<table id='tblEmployeeDetails' class='dataTable' style='width: 100%'>";

                tbl += "<thead>";
                tbl += "<tr>";

                tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Employee ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Card No</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Name</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>NIC</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;display:none'>Relation</th>";
               // tbl += "<th style='white-space:nowrap; text-align:left;'>Status</th>";
                //tbl += "<th style='white-space:nowrap; text-align:left;'>Relation Name</th>";

                //tbl += "<th style='white-space:nowrap; text-align:left;'>Current Address</th>";
                //tbl += "<th style='white-space:nowrap; text-align:left;'>Permanent Address</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Department</th>";
                //tbl += "<th style='white-space:nowrap; text-align:left;'>Designation</th>";

                //tbl += "<th style='white-space:nowrap; text-align:left;'>Phone Home</th>";
                //tbl += "<th style='white-space:nowrap; text-align:left;'>Phone Office</th>";
                //tbl += "<th style='white-space:nowrap; text-align:left;'>Mobile</th>";

                //tbl += "<th style='white-space:nowrap; text-align:left;'>Religion</th>";
                //tbl += "<th style='white-space:nowrap; text-align:left;'>Sectt</th>";
                //tbl += "<th style='white-space:nowrap; text-align:left;'>Caste</th>";
                //tbl += "<th style='white-space:nowrap; text-align:left;'>Education</th>";

                //tbl += "<th style='white-space:nowrap; text-align:left;'>Firm</th>";
                //tbl += "<th style='white-space:nowrap; text-align:left;'>Firm Address</th>";
                //tbl += "<th style='white-space:nowrap; text-align:left;'>Product</th>";
                //tbl += "<th style='white-space:nowrap; text-align:left;'>Shop Keeper</th>";
                //tbl += "<th style='white-space:nowrap; text-align:left;'>Market</th>";

                //tbl += "<th style='white-space:nowrap; text-align:left;'>Witness 1</th>";
                //tbl += "<th style='white-space:nowrap; text-align:left;'>Witness 1 Address</th>";
                //tbl += "<th style='white-space:nowrap; text-align:left;'>Witness 2</th>";
                //tbl += "<th style='white-space:nowrap; text-align:left;'>Witness 2 Address</th>";
                //tbl += "<th style='white-space:nowrap; text-align:left;'>Authority</th>";
                //tbl += "<th style='white-space:nowrap; text-align:left;'>Entry Date</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Status</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Photo</th>";

                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
                var EmpID = 0;
                EmpIds = "";
                for (var i = 0; i < data.EmployeeDetail.length; i++) {
                    tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' >";
                    tbl += "<td style='text-align:left; white-space:nowrap; display:none;'>" + data.EmployeeDetail[i].NRID + "</td>";
                    tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].CardNumber + "</td>";
                    tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].FirstName + " " + data.EmployeeDetail[i].LastName + "</td>";
                    tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].NIC + "</td>";
                    tbl += "<td style='white-space:nowrap; text-align:left;display:none;'>" + data.EmployeeDetail[i].RelName + "</td>";
                   
                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].Rel + "</td>";
                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].CurrAddr + "</td>";
                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].PerAddr + "</td>";
                    tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].Department + "</td>";
                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].Designation + "</td>";

                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].PhoneHome + "</td>";
                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].PhoneOffice + "</td>";
                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].Mobile + "</td>";

                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].Religion + "</td>";
                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].Sectt + "</td>";
                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].Caste + "</td>";
                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].Education + "</td>";

                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].Firm + "</td>";
                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].FirmAddr + "</td>";
                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].Product + "</td>";
                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].ShopKeeper + "</td>";
                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].Market + "</td>";

                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].Witness1Name + "</td>";
                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].Witness1Addr + "</td>";
                    //tbl += "<td style='white-space:nowrap; text-align:left;'" + data.EmployeeDetail[i].Witness2Name + "</td>";
                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].Witness2Addr + "</td>";
                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].Authority + "</td>";
                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].DateofEntry + "</td>";
                    tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].Status + "</td>";
                    //tbl += "<td style='white-space:nowrap; text-align:left;display:none;'><input style='width:60px;height:60px;' type='image' src='" + picDir + data.EmployeeDetail[i].Photo + ".jpg'></td>";
                    tbl += "<td class='CNICEmpImage'  style='text-align:center;'><img src='../RMS/CallBack/GetImageDatafromDB.aspx?PrimaryKeyIDValue=" + data.EmployeeDetail[i].NRID + "&tableName=NonResident&ImagecolumnName=NewPhoto&PrimaryKeyColumnName=NRID' height='50px' width='50px'></td>";
                    tbl += "</tr>";
                    EmpID = data.EmployeeDetail[i].NRID;
                    EmpIds += EmpID + ",";
                }
                tbl += "</tbody>";
                tbl += "</table></div></fieldset>";
                $("#divEmployeeDetailContainer").html(tbl);
            }

            function getVisitorTable(data) {
                var Type = $("input[id$='ddlType']").val().trim();
                var picDir = "../RMS/VisitorPictures/";

                var tbl = "<fieldset id='fldEmployeeDetails' style=width: 95%;'><legend>" + $('span[id$="spnSearchTitle"]').text() + " Details</legend><div id='divEmployeeDetails' style='overflow: auto; width: 100%;'>" +
                          "<table id='tblEmployeeDetails' class='dataTable' style='width: 100%'>";

                tbl += "<thead>";
                tbl += "<tr>";

                tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Employee ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Card No</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Name</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>NIC</th>";
               // tbl += "<th style='white-space:nowrap; text-align:left;'>Phone</th>";
                //tbl += "<th style='white-space:nowrap; text-align:left;'>Mobile</th>";

                //tbl += "<th style='white-space:nowrap; text-align:left;'>Address</th>";
                //tbl += "<th style='white-space:nowrap; text-align:left;'>Job/Study</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Visit Purpose</th>";
                //tbl += "<th style='white-space:nowrap; text-align:left;'>Visit Days</th>";

                //tbl += "<th style='white-space:nowrap; text-align:left;'>Issue Date</th>";
                //tbl += "<th style='white-space:nowrap; text-align:left;'>Valid Upto</th>";
                //tbl += "<th style='white-space:nowrap; text-align:left;'>Reference Name</th>";

                tbl += "<th style='white-space:nowrap; text-align:left;'>Relation</th>";
                //tbl += "<th style='white-space:nowrap; text-align:left;'>Rank</th>";
                //tbl += "<th style='white-space:nowrap; text-align:left;'>Reference</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Status</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Photo</th>";

                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
                var EmpID = 0;
                EmpIds = "";
                for (var i = 0; i < data.EmployeeDetail.length; i++) {
                    tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' >";
                    tbl += "<td style='text-align:left; white-space:nowrap; display:none;'>" + data.EmployeeDetail[i].VID + "</td>";
                    tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].CardNo + "</td>";
                    tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].FirstName + " " + data.EmployeeDetail[i].LastName + "</td>";
                    tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].NIC + "</td>";
                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].Phone + "</td>";
                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].Mobile + "</td>";
                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].Addr + "</td>";
                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].Profession + "</td>";
                    tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].VisitPurpose + "</td>";
                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].VisitDays + "</td>";

                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].IssueDt + "</td>";
                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].ValidUpto + "</td>";
                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].ReferenceName + "</td>";

                    tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].Relation + "</td>";
                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].Rank + "</td>";
                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].Reference + "</td>";
                    tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].Status + "</td>";

                   // tbl += "<td style='white-space:nowrap; text-align:left;display:none'><input style='width:60px;height:60px;' type='image' src='" + picDir + data.EmployeeDetail[i].Photo + ".jpg'></td>";
                    tbl += "<td class='CNICEmpImage'  style='text-align:center;'><img src='../RMS/CallBack/GetImageDatafromDB.aspx?PrimaryKeyIDValue=" + data.EmployeeDetail[i].VID + "&tableName=Visitor&ImagecolumnName=NewPhoto&PrimaryKeyColumnName=VID' height='50px' width='50px'></td>";

                    tbl += "</tr>";
                    EmpID = data.EmployeeDetail[i].VID;
                    EmpIds += EmpID + ",";
                }
                tbl += "</tbody>";
                tbl += "</table></div></fieldset>";
                $("#divEmployeeDetailContainer").html(tbl);
            }


            function getVMSVisitorTable(data) {
                var Type = $("input[id$='ddlType']").val().trim();
                var picDir = "../RMS/VisitorPictures/";

                var tbl = "<fieldset id='fldEmployeeDetails' style=width: 95%;'><legend>" + $('span[id$="spnSearchTitle"]').text() + " Details</legend><div id='divEmployeeDetails' style='overflow: auto; width: 100%;'>" +
                          "<table id='tblEmployeeDetails' class='dataTable' style='width: 100%'>";

                tbl += "<thead>";
                tbl += "<tr>";

                tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Employee ID</th>";
                tbl += "<th style=' text-align:left;width:5%;'>Card No</th>";
                tbl += "<th style=' text-align:left;width:6%;'>Name</th>";
                tbl += "<th style=' text-align:left;width:6%;'>Father Name</th>";
                tbl += "<th style=' text-align:left;width:10%;'>Name (English)</th>";
                tbl += "<th style=' text-align:left;width:12%;'>NIC</th>";
                tbl += "<th style=' text-align:left;width:20%;'>Address</th>";
                tbl += "<th style=' text-align:left;width:8%;'>Visitig Date</th>";
              
                tbl += "<th style=' text-align:left;width:10%;'>Visited Person</th>";
                tbl += "<th style=' text-align:left;width:13%;'>Visit Purpose</th>";
               
                tbl += "<th style=' text-align:left;width:5%;'>Status</th>";
                tbl += "<th style=' text-align:left;width:5%;'>Photo</th>";

                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
                var EmpID = 0;
                EmpIds = "";
                for (var i = 0; i < data.EmployeeDetail.length; i++) {
                    tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' >";
                    tbl += "<td style='text-align:left;  display:none;'>" + data.EmployeeDetail[i].ID + "</td>";
                    tbl += "<td style=' text-align:left;'>" + data.EmployeeDetail[i].CardNo + "</td>";
                    tbl += "<td style=' text-align:left;'>" + data.EmployeeDetail[i].VISITOR_NAME + "</td>";
                    tbl += "<td style=' text-align:left;'>" + data.EmployeeDetail[i].FATHER_NAME + "</td>";
                    tbl += "<td style=' text-align:left;'>" + data.EmployeeDetail[i].FirstName + " " + data.EmployeeDetail[i].LastName + "</td>";
                    tbl += "<td style=' text-align:left;'>" + data.EmployeeDetail[i].NIC + "</td>";
                    tbl += "<td style=' text-align:left;'>" + data.EmployeeDetail[i].ADDRESS + "</td>";
                    tbl += "<td style=' text-align:left;'>" + data.EmployeeDetail[i].DATE + "</td>";
                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].Phone + "</td>";
                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].Mobile + "</td>";
                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].Addr + "</td>";
                    tbl += "<td style=' text-align:left;'>" + data.EmployeeDetail[i].HOST + "</td>";
                    tbl += "<td style=' text-align:left;'>" + data.EmployeeDetail[i].VisitPurpose + "</td>";
                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].VisitDays + "</td>";

                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].IssueDt + "</td>";
                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].ValidUpto + "</td>";
                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].ReferenceName + "</td>";

                 
                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].Rank + "</td>";
                    //tbl += "<td style='white-space:nowrap; text-align:left;'>" + data.EmployeeDetail[i].Reference + "</td>";
                    tbl += "<td style='text-align:left;'>" + data.EmployeeDetail[i].Status + "</td>";

                    //tbl += "<td style='white-space:nowrap; text-align:left;display:nones;'><input style='width:60px;height:60px;' type='image' src='" + picDir + data.EmployeeDetail[i].Photo + ".jpg'></td>";
                    tbl += "<td class='CNICmctxVisitorImage'  style='text-align:center;'><img src='../RMS/CallBack/GetImageDatafromDB.aspx?PrimaryKeyIDValue=" + data.EmployeeDetail[i].ID + "&tableName=mctx_visitor&ImagecolumnName=NewPhoto&PrimaryKeyColumnName=ID' height='50px' width='50px'></td>";
                    tbl += "</tr>";
                    EmpID = data.EmployeeDetail[i].ID;
                    EmpIds += EmpID + ",";
                }
                tbl += "</tbody>";
                tbl += "</table></div></fieldset>";
                $("#divEmployeeDetailContainer").html(tbl);
            }

            function getRowID(rowID) {
                $("table[id$='tblEmployeeDetails'] tr").css("background-color", "white");
                $("#trmain" + rowID).css("background-color", "#6798c1");

            }



            function getEmployeeFamily(empID) {
              //  alert(empID);
                //if (!validate("tblCNICWiseReport")) {
                $("input[id$='hdShowFamily']").val(empID);
                var EID = empID;
                employeeID = empID;
                
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../RMS/RMSwebmethods.aspx/getEmployeeFamily",
                    data: "{'EID':'" + EID + "'}",
                    success: onsuccessgetEmployeeFamily
                });
                // }
                return false;
            }
            function onsuccessgetEmployeeFamily(msg) {
                var data = msg.d;
                if (oTable != null) {
                    oTable.fnClearTable();
                    oTable.fnDestroy();
                }
                var tbl = "<fieldset id='fldEmployeeFamilyDetails' style=width: 95%;'><legend>Employee's Family Details</legend><div id='divEmployeeFamilyDetails' style='overflow: auto; width: 100%; ;'>" +
                          "<table id='tblEmployeeFamilyDetails' class='dataTable' style='width: 100%'>";
                tbl += "<thead>";
                tbl += "<tr>";

                tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Employee ID</th>";

                tbl += "<th style='white-space:nowrap; text-align:left;'>Card No</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Name</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Relation</th>";

                tbl += "<th style='white-space:nowrap; text-align:left;'>NIC</th>";
                //tbl += "<th style='white-space:nowrap; text-align:left;'>Cell No</th>";

                //tbl += "<th style='white-space:nowrap; text-align:left;'>Address</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Visit Purpose</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Status</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Photo</th>";

                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
                var EmpID = 0;
                for (var i = 0; i < data.EmployeeFamilyDetail.length; i++) {
                    tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' >";

                    tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.EmployeeFamilyDetail[i].EID + "</td>";

                    tbl += "<td style='text-align:left; white-space:nowrap;' id='txtVisitorName" + i + "'>" + data.EmployeeFamilyDetail[i].CardNumber + "</td>";
                    tbl += "<td style='text-align:left; white-space:nowrap;' id='txtVisitorName" + i + "'>" + data.EmployeeFamilyDetail[i].FirstName + " " + data.EmployeeFamilyDetail[i].LastName + "</td>";
                    tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.EmployeeFamilyDetail[i].Relation + "</td>";
                    tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.EmployeeFamilyDetail[i].NIC + " </td>";
                    //tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.EmployeeFamilyDetail[i].Mobile + " </td>";
                    //tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.EmployeeFamilyDetail[i].vaddr + " </td>";
                    tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.EmployeeFamilyDetail[i].vpurpose + "</td>";
                    tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.EmployeeFamilyDetail[i].Status + "</td>";
                   // tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'><input style='width:60px;height:60px;' type='image' src='../RMS/EmpPictures/EmpFamilyPicture/" + data.EmployeeFamilyDetail[i].Photo + ".jpg'></td>";
                    tbl += "<td class='CNICEmpFamilyImage'  style='text-align:center;'><img src='../RMS/CallBack/GetImageDatafromDB.aspx?PrimaryKeyIDValue=" + data.EmployeeFamilyDetail[i].EFID + "&tableName=EmployeeFamily&ImagecolumnName=NewPhoto&PrimaryKeyColumnName=EFID' height='50px' width='50px'></td>";
                    tbl += "</tr>";
                    EmpID = data.EmployeeFamilyDetail[i].EID;
                }
                tbl += "</tbody>";
                tbl += "</table></div></fieldset>";
                $("#divEmployeeFamilyDetailContainer").html(tbl);
                if (EmpID == null || EmpID == 0)
                    getEmployeeServant(employeeID);
                else
                    getEmployeeServant(EmpID);

                return false;
            }


            function getEmployeeServant(empID) {
                //if (!validate("tblCNICWiseReport")) {
                var EID = empID;
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../RMS/RMSwebmethods.aspx/getEmployeeSerant",
                    data: "{'EID':'" + EID + "'}",
                    success: onsuccessgetEmployeeSerant
                });
                // }
                return false;
            }
            function onsuccessgetEmployeeSerant(msg) {
                var data = msg.d;
                if (oTable != null) {
                    oTable.fnClearTable();
                    oTable.fnDestroy();
                }
                $("#divServantsFamilyDetailContainer").html("");
                var tbl = "<fieldset id='fldEmployeeServentDetail' style='width: 95%;'><legend>Employee's Sarvents Details</legend><div id='divEmployeeServentDetail' style='overflow: auto; width: 100%; ;'>" +
                          "<table id='tblEmployeeServantDetails' class='dataTable' style='width: 100%'>";
                tbl += "<thead>";
                tbl += "<tr>";

                tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Employee ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Card No</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Name</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Religion</th>";

                tbl += "<th style='white-space:nowrap; text-align:left;'>NIC</th>";
                //tbl += "<th style='white-space:nowrap; text-align:left;'>Cell No</th>";

                tbl += "<th style='white-space:nowrap; text-align:left;'>Phone Home</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Status</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Picture</th>";

                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
                var EmpID = 0;
                for (var i = 0; i < data.EmployeeServantDetail.length; i++) {
                    tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' >";

                    tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.EmployeeServantDetail[i].EID + "</td>";
                    tbl += "<td style='text-align:left; white-space:nowrap;' id='txtVisitorName" + i + "'>" + data.EmployeeServantDetail[i].CardNumber + "</td>";
                    tbl += "<td style='text-align:left; white-space:nowrap;' id='txtVisitorName" + i + "'>" + data.EmployeeServantDetail[i].FirstName + " " + data.EmployeeServantDetail[i].LastName + "</td>";
                    tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.EmployeeServantDetail[i].Religion + "</td>";
                    tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.EmployeeServantDetail[i].NIC + " </td>";
                   // tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.EmployeeServantDetail[i].mobile + " </td>";
                    tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.EmployeeServantDetail[i].phonehome + " </td>";
                    tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModDate" + i + "'>" + data.EmployeeServantDetail[i].Status + " </td>";
                   //Add by Eitsham tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'><input style='width:60px;height:60px;' type='image' src='../RMS/EmpPictures/EmpServantPicture/" + data.EmployeeServantDetail[i].Photo + ".jpg'></td>";
                    tbl += "<td class='CNICEmpFamilyImage'  style='text-align:center;'><img src='../RMS/CallBack/GetImageDatafromDB.aspx?PrimaryKeyIDValue=" + data.EmployeeServantDetail[i].SID + "&tableName=Servant&ImagecolumnName=NewPhoto&PrimaryKeyColumnName=SID' height='50px' width='50px'></td>";
                    tbl += "</tr>";
                    EmpID = data.EmployeeServantDetail[i].EID;
                    getEmployeeServantFamily(data.EmployeeServantDetail[i].SID);
                }
                tbl += "</tbody>";
                tbl += "</table></div></fieldset>";
                $("#divEmployeeServantDetailContainer").html(tbl);

                //getEmployeeServantFamily(EmpID);

                // return false;
            }


            function getEmployeeServantFamily(SID) {
                //if (!validate("tblCNICWiseReport")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    //url: "../RMS/RMSwebmethods.aspx/getEmployeeSerantFamily",
                    url: "../RMS/RMSwebmethods.aspx/getEmployeeServantFamily",
                    data: "{'SID':'" + SID + "'}",
                    success: getEmployeeServantFamilyDetails
                });
                // }
                return false;
            }
            function getEmployeeServantFamilyDetails(msg) {
                var data = msg.d;
                if (oTable != null) {
                    oTable.fnClearTable();
                    oTable.fnDestroy();
                }
                if (data.EmployeeServantFamilyDetail.length < 1)
                    return false;

                var tbl = "";
                tbl += "<thead>";
                tbl += "<tr>";

                tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Employee ID</th>";

                tbl += "<th style='white-space:nowrap; text-align:left;'>Card No</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Name</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Relation</th>";

                tbl += "<th style='white-space:nowrap; text-align:left;'>NIC</th>";
                //tbl += "<th style='white-space:nowrap; text-align:left;'>Cell No</th>";

                //tbl += "<th style='white-space:nowrap; text-align:left;'>Profession</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Place of Work</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Status</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Picture</th>";

                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
                var EmpID = 0;
                var SFID = 0;
                var serventName = "";
                for (var i = 0; i < data.EmployeeServantFamilyDetail.length; i++) {
                    tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' >";

                    tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.EmployeeServantFamilyDetail[i].EID + "</td>";

                    tbl += "<td style='text-align:left; white-space:nowrap;' id='txtVisitorName" + i + "'>" + data.EmployeeServantFamilyDetail[i].CardNumber + "</td>";
                    tbl += "<td style='text-align:left; white-space:nowrap;' id='txtVisitorName" + i + "'>" + data.EmployeeServantFamilyDetail[i].FirstName + " " + data.EmployeeServantFamilyDetail[i].LastName + "</td>";
                    tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.EmployeeServantFamilyDetail[i].Relation + "</td>";
                    tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.EmployeeServantFamilyDetail[i].NIC + " </td>";
                    //tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.EmployeeServantFamilyDetail[i].Mobile + " </td>";
                    //tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.EmployeeServantFamilyDetail[i].Profession + " </td>";
                    tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.EmployeeServantFamilyDetail[i].PlaceofWork + " </td>";
                    tbl += "<td style='text-align:left; white-space:nowrap;' id='txtstatus" + i + "'>" + data.EmployeeServantFamilyDetail[i].Status + " </td>";
                    //Add by Eitsham tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'><input style='width:60px;height:60px;' type='image' src='../RMS/EmpPictures/EmpServantPicture/ServantFamilyPicture/" + data.EmployeeServantFamilyDetail[i].Photo + ".jpg'></td>";
                    tbl += "<td class='CNICEmpFamilyImage'  style='text-align:center;'><img src='../RMS/CallBack/GetImageDatafromDB.aspx?PrimaryKeyIDValue=" + data.EmployeeServantFamilyDetail[i].SFID + "&tableName=ServantFamily&ImagecolumnName=NewPhoto&PrimaryKeyColumnName=SFID' height='50px' width='50px'></td>";
                    tbl += "</tr>";
                    EmpID = data.EmployeeServantFamilyDetail[i].EID;
                    SFID = data.EmployeeServantFamilyDetail[i].SFID;
                    serventName = data.EmployeeServantFamilyDetail[i].ServantName;
                }
                tbl += "</tbody>";
                tbl += "</table></fieldset>";
                var tblStart = "<fieldset id='fldEmployeeSarventFamilyDetail' style='width: 95%;'><legend>Sarvent \"" + serventName + "\" Family Details</legend><div style='overflow: auto; width: 100%; ;'><table id='tblEmployeeSarventFamilyDetail" + SFID + "' class='dataTable' style='width: 100%'>";
                tblStart += tbl;

                serventFamilyIDs += "|tblEmployeeSarventFamilyDetail" + SFID;

                //$("#tblEmployeeSarventFamilyDetail").html(tbl);
                //dataTableEmpFamily();
                $("#divServantsFamilyDetailContainer").html(tblStart);
                return false;
            }


            function onsuccessgetEmployeeSerantFamily(msg) {
                var data = msg.d;
                if (oTable != null) {
                    oTable.fnClearTable();
                    oTable.fnDestroy();
                }
                var tbl = "";
                tbl += "<thead>";
                tbl += "<tr>";

                tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Employee ID</th>";

                tbl += "<th style='white-space:nowrap; text-align:left;'>Card No</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Name</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Relation</th>";

                tbl += "<th style='white-space:nowrap; text-align:left;'>NIC</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Cell No</th>";

                tbl += "<th style='white-space:nowrap; text-align:left;'>Profession</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Place of Work</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Status</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Picture</th>";

                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
                var EmpID = 0;
                for (var i = 0; i < data.EmployeeServantFamilyDetail.length; i++) {
                    tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' >";

                    tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.EmployeeServantFamilyDetail[i].EID + "</td>";

                    tbl += "<td style='text-align:left; white-space:nowrap;' id='txtVisitorName" + i + "'>" + data.EmployeeServantFamilyDetail[i].CardNumber + "</td>";
                    tbl += "<td style='text-align:left; white-space:nowrap;' id='txtVisitorName" + i + "'>" + data.EmployeeServantFamilyDetail[i].FirstName + " " + data.EmployeeServantFamilyDetail[i].LastName + "</td>";
                    tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.EmployeeServantFamilyDetail[i].Relation + "</td>";
                    tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.EmployeeServantFamilyDetail[i].NIC + " </td>";
                    tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.EmployeeServantFamilyDetail[i].Mobile + " </td>";
                    tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.EmployeeServantFamilyDetail[i].Profession + " </td>";
                    tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.EmployeeServantFamilyDetail[i].PlaceofWork + " </td>";
                    tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.EmployeeServantFamilyDetail[i].Photo + "</td>";
                    tbl += "</tr>";
                    EmpID = data.EmployeeServantFamilyDetail[i].EID;
                }
                tbl += "</tbody>";
                tbl += "</table>";
                $("#tblEmployeeSarventFamilyDetail").html(tbl);
                //dataTableEmpFamily();
                $("#divSarvents").append("<fieldset id='fldEmployeeSarventFamilyDetail1' style='width: 95%;'><legend>Sarvents's Family Details 123</legend></fieldset>");
                return false;
            }
    </script>
</asp:Content>

