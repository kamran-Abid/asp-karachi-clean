<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="CNICWiseReport.aspx.cs" Inherits="VisitorRegistration" %>

<%-- <%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>--%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


  

    <script type="text/javascript">
        $(document).ready(function () {
            getCurrentTime();
        });
        function getCurrentTime() {
            var currentTime = new Date()
            var hours = currentTime.getHours()
            var minutes = currentTime.getMinutes()

            if (minutes < 10)
                minutes = "0" + minutes;

            var suffix = "AM";
            if (hours >= 12) {
                suffix = "PM";
                hours = hours - 12;
            }
            if (hours == 0) {
                hours = 12;
            }
            var current_time = hours + ":" + minutes + " " + suffix;
            $("input[id$='txtTimeIn']").val(current_time);
            //  show_message("Current Your System Time is : " + current_time);
        }
    </script>
   
   
    <fieldset style="width:95%;">
        <legend>Residents Search Criteria</legend>
        <div  >
        <table id="tblCNICWiseReport" class="form">
        <tr>
            <td class="right">Enter CNIC NO:</td>
            <td >
                <asp:TextBox ID="txtCNICNo" CssClass="cnic"  runat="server"></asp:TextBox>
            </td>
          


            <td >
                
                <asp:Button ID="btnSearch" Text="Search"  CssClass="btn"  OnClientClick="return getVisitor();" runat="server" />

                
            </td>
        </tr>
    </table>
             </div>
</fieldset>
   


    
        <fieldset id="fldVisitorDetails" style="width:95% ;">
            <legend>Visitors Details</legend>
            <div id="divVisitorDetails" style="overflow: auto; width: 1060px; height: 300px; ">
            <table id="tblVisitorDetails" class="dataTable">
            </table>
                 </div>
        </fieldset>
   

    <script type="text/javascript" language="javascript">
        var oTable;

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
            getVisitor();

        });

        function dataTable() {
            oTable = $("#tblVisitorDetails").dataTable({
                bPaginate: false,
                bJQueryUI: true,
                oLanguage: { "sSearch": "Filter: " }
            });
        }

       
        function getVisitor() {
            //if (!validate("tblCNICWiseReport")) {
                var CNIC = $("input[id$='txtCNICNo']").val().trim();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../VMS/webmethods.aspx/getCNICWiseReport",
                data: "{'CNIC':'" + CNIC + "'}",
                success: onsuccessgetVisitor
            });
           // }
            return false;
        }
        function onsuccessgetVisitor(msg) {
            var data = msg.d;
            if (oTable != null) {
                oTable.fnClearTable();
                oTable.fnDestroy();
            }
            var tbl = "";
            tbl += "<thead>";
            tbl += "<tr>";
            
            tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Visitor ID</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Visitor Name</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>CNIC NO</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Father Name</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Date Of Birth</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Address</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Date</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Time In</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Time Out</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Place Of Visit</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Vechile No.</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Token No</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Department</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Gate No.</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Name</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Phone No.</th>";

            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            for (var i = 0; i < data.VisitorDetail.length; i++) {
                tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' >";
               
                tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.VisitorDetail[i].ID + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtVisitorName" + i + "'>" + data.VisitorDetail[i].VISITOR_NAME + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtVisitorName" + i + "'>" + data.VisitorDetail[i].CNIC + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.VisitorDetail[i].FATHER_NAME + "</td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.VisitorDetail[i].DOB + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.VisitorDetail[i].ADDRESS + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.VisitorDetail[i].DATE + " </td>";


                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.VisitorDetail[i].TIME_IN + "</td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.VisitorDetail[i].TIME_OUT + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.VisitorDetail[i].HOST + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.VisitorDetail[i].VEHICLE_NUMBER + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.VisitorDetail[i].TOKEN_NUMBER + "</td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.VisitorDetail[i].DEPARTMENT + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.VisitorDetail[i].GATE_NUMBER + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.VisitorDetail[i].NAME + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.VisitorDetail[i].PHONE_NUMBER + " </td>";
                tbl += "</tr>";
            }
            tbl += "</tbody>";
            tbl += "</table>";
            $("#tblVisitorDetails").html(tbl);
            dataTable();
            return false;
        }

        function getRowID(rowID) {
            $("table[id$='tblVisitorDetails'] tr").css("background-color", "white");
            $("#trmain" + rowID).css("background-color", "#6798c1");

        }
        
            
    </script>
</asp:Content>

