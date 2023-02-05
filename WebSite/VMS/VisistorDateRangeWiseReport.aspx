<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="VisistorDateRangeWiseReport.aspx.cs" Inherits="VisistorDateRangeWiseReport" %>

 <%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


  

    <script type="text/javascript">
        $(document).ready(function () {
           
        });
        
    </script>
   
   
    <fieldset style="width:95%;">
        <legend>Visitor Date Wise Search Criteria</legend>
        <div  >
        <table id="tblDateRangeWiseReport" class="form">
        <tr>
            <td class="right">From Date:</td>
            <td >
                <asp:TextBox ID="txtFromDate" style="width: 82%;float: left;margin-right: 2%;" CssClass="date"  runat="server"></asp:TextBox>
                <rjs:popcalendar ID="rjsDOB" Separator="/" Format="mm dd yyyy" Control="txtFromDate" runat="server"
                                Font-Names="Tahoma" />
            </td>
          <td class="right">To Date:</td>
            <td >
                <asp:TextBox ID="txtToDate" style="width: 82%;float: left;margin-right: 2%;" CssClass="date"  runat="server"></asp:TextBox>
                <rjs:popcalendar ID="Popcalendar1" Separator="/" Format="mm dd yyyy" Control="txtToDate" runat="server"
                                Font-Names="Tahoma" />
            </td>
          


            <td >
                
                <asp:Button ID="btnSearch" Text="Search"  CssClass="btn"  OnClientClick="return getVisitor();" runat="server" />

                
            </td>
        </tr>
    </table>
             </div>
</fieldset>
   


    
        <fieldset id="fldVisitorDetails" style="overflow: auto; width:95% ;">
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
            //if (!validate("tblDateRangeWiseReport")) {
            var FromDate = $("input[id$='txtFromDate']").val().trim();
            var ToDate = $("input[id$='txtToDate']").val().trim();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../VMS/webmethods.aspx/getVisitorDateWiseReport",
                data: "{'FromDate':'" + FromDate + "','ToDate':'" + ToDate + "'}",
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
            tbl += "<th style='white-space:nowrap; text-align:left;'>Visitor NO</th>";

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

