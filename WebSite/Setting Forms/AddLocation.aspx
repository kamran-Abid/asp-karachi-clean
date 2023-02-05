<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="AddLocation.aspx.cs" Inherits="AddLocation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">




    <table style="width: 100%; margin-top: 0%; vertical-align: top;">
        <tr>
            <td>
                <div class="sussessMessageDiv" id="divSuccessMsg" style="display: none">
                    &nbsp;
                </div>
                <div class="ErrorMessageDiv" id="ErrorMessageDiv" style="display: none">
                    &nbsp;
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <fieldset>
                    <legend>Add/Modified Location Name</legend>

                    <table style="font-family: Calibri; font-size: 11pt; width: 100%;">
                        <tr>
                            <td align="left">
                                <asp:TextBox ID="txtID" Style="display: none;" runat="server"></asp:TextBox>
                            </td>

                            <td style="width: 120px; text-align: left; padding-left: 10px;">
                                <asp:Label ID="lblLocationName" Text="Location Name:" runat="server"></asp:Label>
                            </td>
                            <td style="width: 400px;">
                                <asp:TextBox ID="txtLocationName" placeholder="Enter Location Name" Width="95%" class="alphanumeric" runat="server" BackColor="White"></asp:TextBox>
                            </td>


                            <td align="left">
                                <asp:Button ID="btnSave" Text="Add" CssClass="btn" OnClientClick="return SaveLocation();" runat="server" />
                                <asp:Button ID="btnClearGate" Text="Clear" CssClass="btn" OnClientClick="return ClearGate();" runat="server" />
                                <asp:Button ID="btnUpdate" Text="Update" Style="display: none;" CssClass="btn" OnClientClick="return UpdateLocation();" runat="server" />
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>

    </table>
    <div id="divLocationDetails">
        <fieldset id="fldLocationDetails">
            <legend>Location Details</legend>
            <div style="overflow: auto; width: 100%;">


                <table id="tblLocationDetails" class="dataTable">
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
            getGate();

        });

        function dataTable() {
            oTable = $("#tblLocationDetails").dataTable();
        }

        function SaveLocation() {
            var i = 0;
            if ($("#tblLocationDetails tr").length - 1 > 1) {
                for (i = 0; i < $("#tblLocationDetails tr").length - 1; i++) {

                    if ($("#txtLocationName" + i).html().toUpperCase().trim() == $("input[id$='txtLocationName']").val().toUpperCase().trim()) {
                        alert("Location " + $("input[id$='txtLocationName']").val() + " is already added!");
                        $("input[id$='txtLocationName']").val("");
                        return false;
                    }
                    // alert("test")
                }
            }
            var Location_Name = $("input[id$='txtLocationName']").val().trim();

            if (Location_Name == "") {
                alert("Please Enter Location Name!");
                return false;
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/SaveLocation",
                data: "{'LocationName':'" + Location_Name + "'}",
                success: onsuccessSaveGate,
                error: onretrieveSaveGateError
            });
            return false;
        }
        function onsuccessSaveGate(msg) {
            $("#divSuccessMsg").show();
            $("#divSuccessMsg").html("");
            $("#divSuccessMsg").html("Record Successfully Saved!");
            $("#divSuccessMsg").fadeOut(6000);
            $("input[id$='txtLocationName']").val("");
            getGate();
            return false;
        }
        function onretrieveSaveGateError(msg) {

            alert("Error In Saving Data!");
            return false;
        }
        function ClearGate() {
            $("input[id$='txtLocationName']").val("");

            $("input[id$='btnUpdate']").hide();
            $("input[id$='btnSave']").attr("disabled", false);
            return false;
        }
        function getGate() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/getLocationDetail",
                data: "{}",
                success: onsuccessgetGate,
                error: onretrievegetGate
            });
            return false;
        }
        function onsuccessgetGate(msg) {

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
            tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Gate ID</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Location Name</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            for (var i = 0; i < data.LocationDetail.length; i++) {
                tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
                tbl += "<td id='txtDelete' align='center'> <input  type='image' src='../images/Cross2.png' onclick='return DeleteLocationRecord(" + i + ");'> </td>";
                tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord(" + i + ");'><img src='../images/Edit.png'></td>";
                tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.LocationDetail[i].LocationID + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtLocationName" + i + "'>" + data.LocationDetail[i].LocationName + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.LocationDetail[i].created_by + "</td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.LocationDetail[i].created_date + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.LocationDetail[i].modified_by + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.LocationDetail[i].modified_date + " </td>";
                tbl += "</tr>";
            }
            tbl += "</tbody>";
            tbl += "</table>";
            $("#tblLocationDetails").html(tbl);
            dataTable();
            return false;
        }

        function getRowID(rowID) {
            $("table[id$='tblLocationDetails'] tr").css("background-color", "white");
            $("#trmain" + rowID).css("background-color", "#6798c1");

        }
        function onretrievegetGate() {
            alert("Error In Loading Details!");
            return false;
        }

        function DeleteLocationRecord(rowNo) {


            var LocationID = $("#txtID" + rowNo).html();

            if (confirm(`Are you sure you wish to delete Record?`)) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/DeleteLocation",
                    data: "{'LocationID':'" + LocationID + "'}",
                    success: onsuccessDeleteData,
                    error: OnretrievePhysicianError
                });

                return false;
            }
            else
                return false;

        }

        function onsuccessDeleteData(msg) {
            $("#divSuccessMsg").show();
            $("#divSuccessMsg").html("");
            $("#divSuccessMsg").html("Record Successfully Deleted!");
            $("#divSuccessMsg").fadeOut(6000);
            getGate();
            return false;

        }

        function OnretrievePhysicianError(msg) {
            // getGatealRecod();
            alert(msg.responseText);
            $("#ErrorMessageDiv").show();
            $("#ErrorMessageDiv").html("");
            $("#ErrorMessageDiv").html("Error in Record Deleting!");
            $("#ErrorMessageDiv").fadeOut(6000);
            return false;
        }

        function EditRecord(rowNo) {
            var ID = $("#txtID" + rowNo).html().trim();
            $("input[id$='txtID']").val(ID);

            var LocationID = $("#txtLocationName" + rowNo).html().trim();
            $("input[id$='txtLocationName']").val(LocationID);

            $("input[id$='btnUpdate']").show();
            $("input[id$='btnSave']").attr("disabled", true);
            return false;
        }
        function UpdateLocation() {
            var LocationID = $("input[id$='txtID']").val();
            var LocationName = $("input[id$='txtLocationName']").val();

            if (LocationName == "") {
                alert("Please Enter Location Name!");
                return false;
            }
            var i = 0;
            if ($("#tblLocationDetails tr").length - 1 > 1) {
                for (i = 0; i < $("#tblLocationDetails tr").length - 1; i++) {

                    if ($("#txtLocationName" + i).html().toUpperCase().trim() == $("input[id$='txtLocationName']").val().toUpperCase().trim()) {
                        alert("Location " + $("input[id$='txtLocationName']").val() + " is already added!");
                        // $("input[id$='txtLocationName']").val("");
                        return false;
                    }
                    // alert("test")
                }
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/UpdateLocation",
                data: "{'LocationID':'" + LocationID + "','LocationName':'" + LocationName + "'}",
                success: onsuccessUpdateLocations,
                error: onretrieveUpdateLocations
            });
            return false;
        }
        function onsuccessUpdateLocations() {
            $("#divSuccessMsg").show();
            $("#divSuccessMsg").html("");
            $("#divSuccessMsg").html("Record Successfully Updated!");
            $("#divSuccessMsg").fadeOut(6000);
            $("input[id$='txtLocationName']").val("");
            getGate();

            ClearGate();
            getGate();
            return false;
        }
        function onretrieveUpdateLocations() {
            alert("Error In Updating Record!");
            return false;
        }




    </script>
</asp:Content>

