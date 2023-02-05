<%@ Page Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="DamoclesSensorInfos.aspx.cs" Inherits="Setting_Forms_DamoclesSensorInfos" %>




<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <link href="css/dataTable.css" rel="stylesheet" />
    <table style="width: 100%; margin-top: 0%;">

        <tr>
            <td>
                <fieldset>
                    <legend>Add/Modify Damocles SensorInfos</legend>

                    <table id="tbldamoclesinfo" style="font-family: Calibri; font-size: 11pt; width: 100%;">
                        <tr>
                            <td style="width: 140px; text-align: left;">Damocles ID:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <asp:DropDownList ID="ddldamoclessensorid" runat="server"></asp:DropDownList>
                            </td>
                             <td style="width: 140px; text-align: left;">Damocles Sensor ID:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                 <asp:DropDownList ID="ddldamoclessensortypeinfo" runat="server">
                                     <asp:ListItem Text="--select--" Value="select"></asp:ListItem>
                                     <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                     <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                     <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                     <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                     <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                     <asp:ListItem Text="6" Value="6"></asp:ListItem>
                                 </asp:DropDownList>
                            </td>
                            <tr>
                                 <td style="width: 140px; text-align: left;">Gadets Info:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                               <asp:DropDownList ID="ddlDemoclesID" runat="server">

                               </asp:DropDownList>
                               

                                <%-- <asp:TextBox ID="txtgateid" Width="95%" placeholder="Gate Id"   runat="server" BackColor="White"></asp:TextBox>--%>
                            </td>
                            </tr>
                            


                            <td align="left">
                                <asp:TextBox ID="txtID" Style="display: none;" runat="server"></asp:TextBox>
                            </td>


                            <td align="left">
                                <asp:Button ID="btnSave" Text="Add" CssClass="btn" OnClientClick="return SaveDamoclesSensorInfos();" runat="server" />

                                <asp:Button ID="btnClearCaste" Text="Clear" CssClass="btn" OnClientClick="return CleardamoclesSensorinfos();" runat="server" />

                                <asp:Button ID="btnUpdate" Text="Update" Style="display: none;" CssClass="btn" OnClientClick="return UpdateDamoclesSensorInfos();" runat="server" />
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>

    </table>
    <div id="divDamoclesSensorInfosDetails">
        <fieldset id="fldDamoclesSensorInfosDetails" >
            <legend>Damocles Sensor Infos Details</legend>
                  
            <table id="tbleDamoclesSensorInfosDetail" class="dataTable">
            </table>
                 
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
            getdamoclesSensorinfos();

        });

        function dataTable() {
            oTable = $("#tbleDamoclesSensorInfosDetail").dataTable();
        }

        function SaveDamoclesSensorInfos() {

            var DamoclesSensor = $("select[id$='ddldamoclessensorid']").val().trim();
            var DamoclesSensorTypeId = $("select[id$='ddldamoclessensortypeinfo']").val().trim();
            var Gateid = $("select[id$='ddlDemoclesID']").val().trim();

            if (DamoclesSensor == "") {
                alert("Please Enter Damocles Sensor!");
                return false;
            }
            if (DamoclesSensorTypeId == "") {
                alert("Please Enter Damocles Sensor Type Id!");
                return false;
            } if (Gateid == "") {
                alert("Please Enter Gate Id!");
                return false;
            }
           
            //var i = 0;
            //if ($("#tbleDamoclesSensorInfosDetail tr").length - 1 > 1) {
            //    for (i = 0; i < $("#tbleDamoclesSensorInfosDetail tr").length - 1; i++) {
                    
            //        if ($("#ddldamoclessensoride" + i).html().toUpperCase().trim() == $("select[id$='ddldamoclessensorid'] option:selected").text().toUpperCase().trim()) {
            //            alert("Damocles Sensor  " + $("select[id$='ddldamoclessensorid'] option:selected").text().toUpperCase().trim() + " is already added!");
            //            $("select[id$='ddldamoclessensorid']").val("");
            //            return false;
            //        }

            //    }
            //}
           
                var DamoclesSensor = $("select[id$='ddldamoclessensorid']").val().trim();
                var DamoclesSensorTypeId = $("select[id$='ddldamoclessensortypeinfo']").val().trim();
                var Gateid = $("select[id$='ddlDemoclesID']").val().trim();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/SaveDamoclesSensorInfoss",
                    data: "{'DamoclesSensor':'" + DamoclesSensor + "', 'DamoclesSensorTypeId':'" + DamoclesSensorTypeId + "', 'Gateid':'" + Gateid + "'}",
                    success: onsuccessSaveDamoclesSensorInfos
                });
            
            return false;
        }
        function onsuccessSaveDamoclesSensorInfos(msg) {
            //$("#divMsg").html("Record Successfully Saved!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record saved successfully!");
            $("select[id$='ddldamoclessensorid']").val("");
            $("select[id$='ddldamoclessensortypeinfo']").val("");
            $("select[id$='ddlDemoclesID']").val("");
            getdamoclesSensorinfos();
            return false;
        }
        function CleardamoclesSensorinfos() {
            $("select[id$='ddldamoclessensorid']").val("");
            $("select[id$='ddldamoclessensortypeinfo']").val("");
            $("select[id$='ddlDemoclesID']").val("");
            $("input[id$='btnUpdate']").hide();
            $("input[id$='btnSave']").attr("disabled", false);
            return false;
        }
        function getdamoclesSensorinfos() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/getdamoclesSensorinfosDetail",
                data: "{}",
                success: onsuccessgetDamoclesSensorInfos
            });
            return false;
        }
        function onsuccessgetDamoclesSensorInfos(msg) {
            debugger;
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
            tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Dam ID</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Dam Name</th>";
            tbl += "<th style='white-space:nowrap;display:none; text-align:left;'>Dam ID</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Damocles Sensor Type</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;display:none'>Damocles Sensor Type ID</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Gadget Name</th>";
            //tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
            //tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
          
            for (var i = 0; i < data.tbleDamoclesSensorInfos.length; i++) {
                
                tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
                tbl += "<td id='txtDelete' align='center'> <input  type='image' src='../images/Cross2.png' onclick='return  DeletedamoclesSensorInfos(" + i + ");'> </td>";
                tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord(" + i + ");'><img src='../images/Edit.png'></td>";
                tbl += "<td style='text-align:left; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.tbleDamoclesSensorInfos[i].DIID + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='ddldamoclessensoride" + i + "'>" + data.tbleDamoclesSensorInfos[i].IPName + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;display:none;' id='ddldamoclessensorids" + i + "'>" + data.tbleDamoclesSensorInfos[i].Dam_ID + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='ddldamoclessensortypeinfos" + i + "'>" + data.tbleDamoclesSensorInfos[i].Dam_Sen_ID + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='ddlDemocles" + i + "'>" + data.tbleDamoclesSensorInfos[i].Dam_Sen_Type + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;display:none' id='ddlDemoclesid" + i + "'>" + data.tbleDamoclesSensorInfos[i].Dam_Sen_Type_ID + " </td>";
                
                //tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.CasteDetail[i].modified_by + " </td>";
                //tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.CasteDetail[i].modified_date + " </td>";
                tbl += "</tr>";
            }
            tbl += "</tbody>";
            tbl += "</table>";
            $("#tbleDamoclesSensorInfosDetail").html(tbl);
            dataTable();
            return false;
        }

        function getRowID(rowID) {
            $("table[id$='tbleDamoclesSensorInfosDetail'] tr").css("background-color", "white");
            $("#trmain" + rowID).css("background-color", "#6798c1");

        }


        function DeletedamoclesSensorInfos(rowNo) {

            var Dam_ID = $("#txtID" + rowNo).html();

            if (confirm("Are you sure you wish to delete this Record?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/DeleteDamoclesSensorInfos",
                    data: "{'Dam_ID':'" + Dam_ID + "'}",
                    success: onsuccessDeleteSensorData,
                    error: onerror
                });

                return false;
            }
            else
                return false;
        }

        function onerror(xhr) {
            $(".alert").html(xhr.responseText);

        }
        function onsuccessDeleteSensorData(msg) {
            //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record deleted successfully!");
            getdamoclesSensorinfos();
            return false;
        }

        function EditRecord(rowNo) {
            var DemoclesID = $("#txtID" + rowNo).html().trim();
            $("input[id$='txtID']").val(DemoclesID);

            var DemoclesID = $("#ddldamoclessensorids" + rowNo).html().trim();
           // alert(DemoclesID);
            $("select[id$='ddldamoclessensorid']").val(DemoclesID);

            var DamoclesSensorType = $("#ddldamoclessensortypeinfos" + rowNo).html().trim();
            
            $("Select[id$='ddldamoclessensortypeinfo']").val(DamoclesSensorType);

            var DamoclesSensorId = $("#ddlDemoclesid" + rowNo).html().trim();
            //alert(DamoclesSensorId);
            $("select[id$='ddlDemoclesID']").val(DamoclesSensorId);

            $("input[id$='btnUpdate']").show();
            $("input[id$='btnSave']").attr("disabled", true);
            return false;
        }
        function UpdateDamoclesSensorInfos() {
        
                var Dam_id = $("input[id$='txtID']").val();
                var DamoclesSensorId = $("select[id$='ddldamoclessensorid']").val();
                var DamoclesSensorType = $("select[id$='ddldamoclessensortypeinfo']").val();
                var DamoclesId = $("select[id$='ddlDemoclesID']").val();


                if (DamoclesSensorId == "") {
                    alert("Please Enter Damocles Sensor!");
                    return false;
                }
                if (DamoclesSensorType == "") {
                    alert("Please Enter Damocles Sensor Type Id!");
                    return false;
                } if (DamoclesId == "") {
                    alert("Please Enter Gate Id!");
                    return false;
                }

                //var i = 0;
                //if ($("#tbleDamoclesSensorInfosDetail tr").length - 1 > 1) {
                //    for (i = 0; i < $("#tbleDamoclesSensorInfosDetail tr").length - 1; i++) {

                //        if ($("#ddldamoclessensoride" + i).html().toUpperCase().trim() == $("select[id$='ddldamoclessensorid'] option:selected").text().toUpperCase().trim()) {
                //            alert("Damocles Sensor  " + $("select[id$='ddldamoclessensorid'] option:selected").text().toUpperCase().trim() + " is already added!");
                //            //$("select[id$='ddldamoclessensorid']").val("");
                //            return false;
                //        }

                //    }
                //}
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/UpdateDamoclesSensorInfos",
                    data: "{'Dam_id':'" + Dam_id + "','DamoclesSensorId':'" + DamoclesSensorId + "','DamoclesSensorType':'" + DamoclesSensorType + "','DamoclesId':'" + DamoclesId + "'}",
                    success: onsuccessDamoclesSensorInfos
                });
            
            return false;
        }
        function onsuccessDamoclesSensorInfos() {
          //  $("#divMsg").html("Record Updated Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record Updated successfully!");
            $("select[id$='ddldamoclessensorid']").val("");


            getdamoclesSensorinfos();

            CleardamoclesSensorinfos();
           
            return false;
        }
    </script>
</asp:Content>


