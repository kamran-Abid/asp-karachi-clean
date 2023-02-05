<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/PACS.master" CodeFile="sensortypeinfo.aspx.cs" Inherits="Setting_Forms_sensortypeinfo" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <link href="css/dataTable.css" rel="stylesheet" />
    <table style="width: 100%; margin-top: 0%;">

        <tr>
            <td>
                <fieldset>
                    <legend>Add/Modify Sensor Type </legend>

                    <table id="tblCaste" style="font-family: Calibri; font-size: 11pt; width: 100%;">
                        <tr>
                            <td style="width: 140px; text-align: left;">Sensor Type:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <asp:TextBox ID="txtsensortype" Width="95%" placeholder="Sensor Type"  class="alpha" runat="server" BackColor="White"></asp:TextBox>
                            </td>


                            <td align="left">
                                <asp:TextBox ID="txtID" Style="display: none;" runat="server"></asp:TextBox>
                            </td>


                            <td align="left">
                                <asp:Button ID="btnSave" Text="Add" CssClass="btn" OnClientClick="return SaveSensorType();" runat="server" />

                                <asp:Button ID="btnClearCaste" Text="Clear" CssClass="btn" OnClientClick="return ClearSensortype();" runat="server" />

                                <asp:Button ID="btnUpdate" Text="Update" Style="display: none;" CssClass="btn" OnClientClick="return UpdateSensortype();" runat="server" />
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>

    </table>
    <div id="divSensortypeDetails">
        <fieldset id="fldsensortypeDetails" >
            <legend>SensorType Details</legend>
             <div style="overflow: auto; width: 100%;">
                  
            <table id="tbleSensorTypeDetail" class="dataTable">
            </table>
                 </div>
        </fieldset>
    </div>

    <script type="text/javascript">
        var oTable;
        $(document).ready(function () {
            getSensortypes();

        });
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


        function dataTable() {
            oTable = $("#tbleSensorTypeDetails").dataTable();
        }

        function SaveSensorType() {
            var Sensor_Name = $("input[id$='txtsensortype']").val().trim();
            if (Sensor_Name == "") {
                alert("Please Enter Sensor Name!");
                return false;
            }
            var i = 0;
            if ($("#tbleSensorTypeDetail tr").length - 1 > 1) {
                for (i = 0; i < $("#tbleSensorTypeDetail tr").length - 1; i++) {

                    if ($("#txtsensortype" + i).html().toUpperCase().trim() == $("input[id$='txtsensortype']").val().toUpperCase().trim()) {
                        alert("Sensor Type " + $("input[id$='txtsensortype']").val() + " is alread added!");
                        $("input[id$='txtsensortype']").val("");
                        return false;
                    }
                    // alert("test")
                }
            }
           
               
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/SaveSensorType",
                    data: "{'Sensor_Name':'" + Sensor_Name + "'}",
                    success: onsuccessSaveSensorType
                });
            
            return false;
        }
        function onsuccessSaveSensorType(msg) {
            //$("#divMsg").html("Record Successfully Saved!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record saved successfully!");
            $("input[id$='txtsensortype']").val("");
            getSensortypes();
            return false;
        }
        function ClearSensortype() {
            $("input[id$='txtsensortype']").val("");
            $("input[id$='btnUpdate']").hide();
            $("input[id$='btnSave']").attr("disabled", false);
            return false;
        }
        function getSensortypes() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/getsensortypeDetail",
                data: "{}",
                success: onsuccessGetSensorType
            });
            return false;
        }
        function onsuccessGetSensorType(msg) {
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
            tbl += "<th style='text-align:left; white-space:nowrap; display:none;'> Sensor ID</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Sensor Name</th>";

         //   tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
           // tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
            //tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
            //tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            for (var i = 0; i < data.tbleSensorTypeDetails.length; i++) {
                tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
                tbl += "<td id='txtDelete' align='center'> <input  type='image' src='../images/Cross2.png' onclick='return DeleteSensortype(" + i + ");'> </td>";
                tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord(" + i + ");'><img src='../images/Edit.png'></td>";
                tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.tbleSensorTypeDetails[i].Dam_Sen_Type_ID  + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtsensortype" + i + "'>" + data.tbleSensorTypeDetails[i].Dam_Sen_Type + "</td>";

               // tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.CasteDetail[i].created_by + "</td>";
               // tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.CasteDetail[i].created_date + " </td>";
               // tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.CasteDetail[i].modified_by + " </td>";
                //tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.CasteDetail[i].modified_date + " </td>";
                tbl += "</tr>";
            }
            tbl += "</tbody>";
            tbl += "</table>";
            $("#tbleSensorTypeDetail").html(tbl);
            dataTable();
            return false;
        }

        function getRowID(rowID) {
            $("table[id$='tbleSensorTypeDetail'] tr").css("background-color", "white");
            $("#trmain" + rowID).css("background-color", "#6798c1");

        }


        function DeleteSensortype(rowNo) {

           // var Sen_type_ID = $("#txtID" + rowNo).html();
            var ID = $("#txtID" + rowNo).html().trim();
          
            if (confirm("Are you sure you wish to delete this Record?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/DeleteSensorTypes",
                   // data: "{'Sen_type_ID ':'" + ID + "'}",
                    data: "{'ID':'" + ID + "'}",
                    success: onsuccessDeleteSensortype,
                    error: onerrors
                });

                return false;
            }
            else
                return false;
        }

        function onerrors(xhr) {
            $(".alert").html(xhr.responseText);

        }
        function onsuccessDeleteSensortype(msg) {
            //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record deleted successfully!");
            getSensortypes();
            return false;
        }

        function EditRecord(rowNo) {
            var ID = $("#txtID" + rowNo).html().trim();
            $("input[id$='txtID']").val(ID);

            var Sensortype_Name = $("#txtsensortype" + rowNo).html().trim();
            $("input[id$='txtsensortype']").val(Sensortype_Name);

            $("input[id$='btnUpdate']").show();
            $("input[id$='btnSave']").attr("disabled", true);
            return false;
        }
        function UpdateSensortype() {
            var Sensortype_Name = $("input[id$='txtsensortype']").val();
            if (Sensortype_Name == "") {
                alert("Please Enter Sensor Name!");
                return false;
            }
            var i = 0;
            if ($("#tbleSensorTypeDetail tr").length - 1 > 1) {
                for (i = 0; i < $("#tbleSensorTypeDetail tr").length - 1; i++) {

                    if ($("#txtsensortype" + i).html().toUpperCase().trim() == $("input[id$='txtsensortype']").val().toUpperCase().trim()) {
                        alert("Sensor Type " + $("input[id$='txtsensortype']").val() + " is alread added!");
                       // $("input[id$='txtsensortype']").val("");
                        return false;
                    }
                    // alert("test")
                }
            }
           
                var sensortype_ID = $("input[id$='txtID']").val();
                
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/UpdateSensortype",
                    data: "{'sensortype_ID':'" + sensortype_ID + "','Sensortype_Name':'" + Sensortype_Name + "'}",
                    success: onsuccessUpdateSensorType
                });
           
            return false;
        }
        function onsuccessUpdateSensorType() {
          //  $("#divMsg").html("Record Updated Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record Updated successfully!");
            $("input[id$='txtsensortype']").val("");
           

            getSensortypes();
           
            return false;
        }
    </script>
</asp:Content>

