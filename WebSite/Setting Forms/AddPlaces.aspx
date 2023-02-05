<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="AddPlaces.aspx.cs" Inherits="AddPlaces" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <link href="css/dataTable.css" rel="stylesheet" />
    <table style="width: 100%; margin-top: 0%;">

        <tr>
            <td>
                <fieldset>
                    <legend>Add/Modified Places</legend>

                    <table id="tblPlaces" style="font-family: Calibri; font-size: 11pt; width: 100%;">
                        <tr>
                            <td style="width: 140px; text-align: left;">Gate Name:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                               <asp:DropDownList ID="ddlGate" CssClass="req" runat="server"></asp:DropDownList>
                            </td>
                            <td style="width: 140px; text-align: left;">Lane Name:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <asp:TextBox ID="txtPlaceName" Width="95%" class="alphanumeric req" placeholder="Enter Lane Name" runat="server" BackColor="White"></asp:TextBox>
                            </td>


                            <td align="left">
                                <asp:TextBox ID="txtID" Style="display: none;" runat="server"></asp:TextBox>
                            </td>
                            </tr>
                            <tr>
                                <td></td>
                            <td>
                                <asp:Button ID="btnSave" Text="Add" CssClass="btn" OnClientClick="return SavePlace();" runat="server" />

                                <asp:Button ID="btnClearPlace" Text="Clear" CssClass="btn" OnClientClick="return ClearPlace();" runat="server" />

                                <asp:Button ID="btnUpdate" Text="Update" Style="display: none;" CssClass="btn" OnClientClick="return UpdatePlace();" runat="server" />
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>

    </table>
    <div id="divPlaceDetails" >
        <fieldset id="fldPlaceDetails" >
            <legend>Places Details</legend>
             <div style="overflow: auto; width: 100%;">
                  
            
            <table id="tblePlaceDetails" class="dataTable">
            </table>
                 </div>
        </fieldset>
    </div>

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
            getPlace();

        });

        function dataTable() {
            oTable = $("#tblePlaceDetails").dataTable();
        }

        function SavePlace() {
            var i = 0;
            if ($("#tblePlaceDetails tr").length - 1 > 1) {
                for (i = 0; i < $("#tblePlaceDetails tr").length - 1; i++) {

                    if ($("#txtPlaceName" + i).html().toUpperCase().trim() == $("input[id$='txtPlaceName']").val().toUpperCase().trim()) {
                        alert("Place " + $("input[id$='txtPlaceName']").val() + " is already added!");
                        $("input[id$='txtPlaceName']").val("");
                        return false;
                    }
                    // alert("test")
                }
            }

            if (!validate("tblPlaces")) {
                var HOST_NAME = $("input[id$='txtPlaceName']").val().trim();

                var GateNAME = $("select[id$='ddlGate']").val();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/SavePlace",
                    data: "{'HOST_NAME':'" + HOST_NAME + "',gateID:'" + GateNAME + "'}",
                    success: onsuccessSavePlace
                });
            }
            return false;
        }
        function onsuccessSavePlace(msg) {
            //$("#divMsg").html("Record Successfully Saved!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record Successfully Saved!");
            $("input[id$='txtPlaceName']").val("");
            $("select[id$='ddlGate']").val("");
            getPlace();
            return false;
        }
        function ClearPlace() {
            $("input[id$='txtPlaceName']").val("");
            $("input[id$='btnUpdate']").hide();
            $("input[id$='btnSave']").attr("disabled", false);
            return false;
        }
        function getPlace() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/getPlaceDetail",
                data: "{}",
                success: onsuccessgetPlace
            });
            return false;
        }
        function onsuccessgetPlace(msg) {
            var data = msg.d;
            if (oTable != null) {
                oTable.fnClearTable();
                oTable.fnDestroy();
            }
            var tbl = "";
            tbl += "<thead>";
            tbl += "<tr>";
            tbl += "<th style='text-align:center;width:8%;'>Delete</th>";
            tbl += "<th style='text-align:center; white-space:nowrap;'>Edit</th>";
            tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Place ID</th>";
            tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Gate ID</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Gate Name</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Lane Name</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            for (var i = 0; i < data.PlaceDetail.length; i++) {
                tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
                tbl += "<td id='txtDelete' align='center'> <input  type='image' src='../images/Cross2.png' onclick='return DeleteDepartmentRecord(" + i + ");'> </td>";
                tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord(" + i + ");'><img src='../images/Edit.png'></td>";
                tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.PlaceDetail[i].ID + "</td>";
                tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtGateID" + i + "'>" + data.PlaceDetail[i].GateID + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtGateName" + i + "'>" + data.PlaceDetail[i].Gate_Name + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtPlaceName" + i + "'>" + data.PlaceDetail[i].LocationName + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.PlaceDetail[i].created_by + "</td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.PlaceDetail[i].created_date + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.PlaceDetail[i].modified_by + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.PlaceDetail[i].modified_date + " </td>";
                tbl += "</tr>";
            }
            tbl += "</tbody>";
            tbl += "</table>";
            $("#tblePlaceDetails").html(tbl);
            dataTable();
            return false;
        }

        function getRowID(rowID) {
            $("table[id$='tblePlaceDetails'] tr").css("background-color", "white");
            $("#trmain" + rowID).css("background-color", "#6798c1");

        }


        function DeleteDepartmentRecord(rowNo) {

            var ID = $("#txtID" + rowNo).html();

            if (confirm("Are you sure you wish to delete this Record?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/DeletePlace",
                    data: "{'ID':'" + ID + "'}",
                    success: onsuccessDeleteData
                });

                return false;
            }
            else
                return false;
        }

        function onsuccessDeleteData(msg) {
            //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record deleted Successfully!");
            getPlace();
            return false;
        }

        function EditRecord(rowNo) {
            var ID = $("#txtID" + rowNo).html().trim();
            $("input[id$='txtID']").val(ID);

            var HOST_NAME = $("#txtPlaceName" + rowNo).html().trim();
            var Gate_NAME = $("#txtGateID" + rowNo).html().trim();
            $("input[id$='txtPlaceName']").val(HOST_NAME);
            $("select[id$='ddlGate']").val(Gate_NAME);

            $("input[id$='btnUpdate']").show();
            $("input[id$='btnSave']").attr("disabled", true);
            return false;
        }
        function UpdatePlace() {
            var i = 0;
            if ($("#tblePlaceDetails tr").length - 1 > 1) {
                for (i = 0; i < $("#tblePlaceDetails tr").length - 1; i++) {

                    if ($("#txtPlaceName" + i).html().toUpperCase().trim() == $("input[id$='txtPlaceName']").val().toUpperCase().trim()) {
                        alert("Place " + $("input[id$='txtPlaceName']").val() + " is already added!");
                        $("input[id$='txtPlaceName']").val("");
                        return false;
                    }
                    // alert("test")
                }
            }

            var i = 0;
            if ($("#tblePlaceDetails tr").length - 1 > 1) {
                //Comented due to not updating if only gate name changed
                //for (i = 0; i < $("#tblePlaceDetails tr").length - 1; i++) {

                //    if ($("#txtPlaceName" + i).html().toUpperCase().trim() == $("input[id$='txtPlaceName']").val().toUpperCase().trim()) {
                //        alert("Place " + $("input[id$='txtPlaceName']").val() + " is already added!");
                //       // $("input[id$='txtPlaceName']").val("");
                //        return false;
                //    }

                //     //alert("test")
                //}
            }
            if (!validate("tblPlaces")) {
                var ID = $("input[id$='txtID']").val();
                var HOST_NAME = $("input[id$='txtPlaceName']").val();
                var GateNAME = $("select[id$='ddlGate']").val();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/UpdatePlace",
                    data: "{'ID':'" + ID + "','HOST_NAME':'" + HOST_NAME + "',gateID:'" + GateNAME + "'}",
                    success: onsuccessUpdatePlaces
                });
            }
            return false;
        }
        function onsuccessUpdatePlaces() {
            // $("#divMsg").html("Record Updated Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record Updated Successfully!");
            $("input[id$='txtPlaceName']").val("");
            $("select[id$='ddlGate']").val("");
            getPlace();

            ClearPlace();
            getPlace();
            return false;
        }
    </script>
</asp:Content>

