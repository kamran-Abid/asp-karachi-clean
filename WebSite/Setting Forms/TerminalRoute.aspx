<%@ Page Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="TerminalRoute.aspx.cs" Inherits="Setting_Forms_TerminalRoute" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <link href="css/dataTable.css" rel="stylesheet" />
    <table style="width: 100%; margin-top: 0%;">

        <tr>
            <td>
                <fieldset>
                    <legend>Add/Modify Route Terminal</legend>

                    <table id="tbldamoclesinfo" style="font-family: Calibri; font-size: 11pt; width: 100%;">
                        <tr>
                            <td style="width: 140px; text-align: left;">Place Name:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <asp:TextBox ID="txtPlace" Width="95%" placeholder="Place Name" class="req"  runat="server" BackColor="White"></asp:TextBox>
                            </td>
                             <td style="width: 140px; text-align: left;">Device ID:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                 <asp:DropDownList ID="ddlDevice" runat="server" class="req">
                                    <asp:ListItem Value="">--Select--</asp:ListItem>
                                       <asp:ListItem Value="10">10</asp:ListItem>
                                       <asp:ListItem Value="11">11</asp:ListItem>
                                       <asp:ListItem Value="12">12</asp:ListItem>
                                       <asp:ListItem Value="13">13</asp:ListItem>

                                 </asp:DropDownList>
                                
                            </td>
                            <tr>
                                 <td style="width: 140px; text-align: left;">Terminal:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                               <asp:DropDownList ID="ddlTerminal" runat="server" class="req"></asp:DropDownList>
                                <%-- <asp:TextBox ID="txtTerminalID" Width="95%" placeholder="Gate Id"   runat="server" BackColor="White"></asp:TextBox>--%>
                            </td>
                            </tr>
                            


                            <td align="left">
                                <asp:TextBox ID="txtID" Style="display: none;" runat="server"></asp:TextBox>
                            </td>


                            <td align="left">
                                <asp:Button ID="btnSave" Text="Add" CssClass="btn" OnClientClick="return SaveRouteInfos();" runat="server" />

                                <asp:Button ID="btnClearTerminalRout" Text="Clear" CssClass="btn" OnClientClick="return ClearRouteInfos();" runat="server" />

                                <asp:Button ID="btnUpdate" Text="Update" Style="display: none;" CssClass="btn" OnClientClick="return UpdateTerminalInfos();" runat="server" />
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>

    </table>
    <div id="divDamoclesInfosDetails">
        <fieldset id="fldDamoclesInfosDetails" >
            <legend>DamoclesInfos Details</legend>
                  
            <table id="tblRouteTerminal" class="dataTable">
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
            getRouteInfos();

        });

        function dataTable() {
            oTable = $("#tblRouteTerminalDetails").dataTable();
        }

        function SaveRouteInfos() {
            //var i = 0;
            //if ($("#tblRouteTerminal tr").length - 1 > 1) {
            //    for (i = 0; i < $("#tblRouteTerminal tr").length - 1; i++) {

            //        if ($("#txtPlace" + i).html().toUpperCase().trim() == $("input[id$='txtPlace']").val().toUpperCase().trim()) {
            //            alert("Place_Name " + $("input[id$='txtPlace']").val() + " is already added!");
            //            $("input[id$='txtPlace']").val("");
            //            return false;
            //        }
            //        // alert("test")
            //    }
            //}
          
           
                var Place_Name = $("input[id$='txtPlace']").val().trim();
                var DeviceIDs = $("select[id$='ddlDevice']").val().trim();
                var TerminalID = $("select[id$='ddlTerminal']").val().trim();
                if (Place_Name == "") {
                    alert("Please Enter Place Name!");
                    return false;
                }

                if (DeviceIDs == "") {
                    alert("Please Select Device ID!");
                    return false;
                }
                if (TerminalID == "") {
                    alert("Please Select Terminal Info!");
                    return false;
                }
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/SaveRouteInfos",
                    data: "{'Place_Name':'" + Place_Name + "', 'DeviceIDs':'" + DeviceIDs + "', 'TerminalID':'" + TerminalID + "'}",
                    success: onsuccessSaveRouteInfos
                });
           
            return false;
        }
        function onsuccessSaveRouteInfos(msg) {
            //$("#divMsg").html("Record Successfully Saved!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record saved successfully!");
            $("input[id$='txtPlace']").val("");
            $("select[id$='ddlDevice']").val("");
            $("select[id$='ddlTerminal']").val("");
            getRouteInfos();
            return false;
        }
        function ClearRouteInfos() {
            $("input[id$='txtPlace']").val("");
            $("select[id$='ddlDevice']").val("");
            $("select[id$='ddlTerminal']").val("");
            $("input[id$='btnUpdate']").hide();
            $("input[id$='btnSave']").attr("disabled", false);
            return false;
        }
        function getRouteInfos() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/getRouteInfosDetail",
                data: "{}",
                success: onsuccessgetRouteInfos
            });
            return false;
        }
        function onsuccessgetRouteInfos(msg) {
          
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
            tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Route ID</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Place Name</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Device ID</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Terminal Name</th>";
            tbl += "<th style='white-space:nowrap;display:nones; text-align:left;'>Terminal IP</th>";
            
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            for (var i = 0; i < data.tblRouteTerminalDetails.length; i++) {
                tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
                tbl += "<td id='txtDelete' align='center'> <input  type='image' src='../images/Cross2.png' onclick='return  DeleteTerminalInfos(" + i + ");'> </td>";
                tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord(" + i + ");'><img src='../images/Edit.png'></td>";
                tbl += "<td style='text-align:left; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.tblRouteTerminalDetails[i].RTID + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtPlace" + i + "'>" + data.tblRouteTerminalDetails[i].PlaceName + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='ddlDevice" + i + "'>" + data.tblRouteTerminalDetails[i].Device_ID + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;display:none;' id='txtTerminalID" + i + "'>" + data.tblRouteTerminalDetails[i].Terminal_ID + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtTerminalName" + i + "'>" + data.tblRouteTerminalDetails[i].TerminalName + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;display:nones;' id='txtTerminalIP" + i + "'>" + data.tblRouteTerminalDetails[i].Terminal_IP + " </td>";
                //tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.CasteDetail[i].modified_by + " </td>";
                //tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.CasteDetail[i].modified_date + " </td>";
                tbl += "</tr>";
            }
            tbl += "</tbody>";
            tbl += "</table>";
            $("#tblRouteTerminal").html(tbl);
            dataTable();
            ClearRouteInfos();
            return false;
        }

        function getRowID(rowID) {
            $("table[id$='tblRouteTerminal'] tr").css("background-color", "white");
            $("#trmain" + rowID).css("background-color", "#6798c1");

        }


        function DeleteTerminalInfos(rowNo) {
           
            var Route_ID = $("#txtID" + rowNo).html();
          
            if (confirm("Are you sure you wish to delete this Record?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/DeleteTerminalInfos",
                    data: "{'Route_ID':'" + Route_ID + "'}",
                    success: onsuccessDeleteData,
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
        function onsuccessDeleteData(msg) {
            //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record deleted successfully!");
            getRouteInfos();
            return false;
        }

        function EditRecord(rowNo) {
            var ID = $("#txtID" + rowNo).html().trim();
            $("input[id$='txtID']").val(ID);

            var Place_Name = $("#txtPlace" + rowNo).html().trim();
            $("input[id$='txtPlace']").val(Place_Name);

            var DeviceIDs = $("#ddlDevice" + rowNo).html().trim();
            $("select[id$='ddlDevice']").val(DeviceIDs);

            var Gate_Id = $("#txtTerminalID" + rowNo).html().trim();
            $("select[id$='ddlTerminal']").val(Gate_Id);
            
            $("input[id$='btnUpdate']").show();
            $("input[id$='btnSave']").attr("disabled", true);
            return false;
        }
        function UpdateTerminalInfos() {

            //var i = 0;
            //if ($("#tblRouteTerminal tr").length - 1 > 1) {
            //    for (i = 0; i < $("#tblRouteTerminal tr").length - 1; i++) {

            //        if ($("#txtPlace" + i).html().toUpperCase().trim() == $("input[id$='txtPlace']").val().toUpperCase().trim()) {
            //            alert("Place Name " + $("input[id$='txtPlace']").val() + " is already added!");
            //           // $("input[id$='txtPlace']").val("");
            //            return false;
            //        }
            //        // alert("test")
            //    }
            //}
           
                var Route_ID = $("input[id$='txtID']").val();
                var Place_Name = $("input[id$='txtPlace']").val();
                var DeviceIDs = $("select[id$='ddlDevice']").val();
                var TerminalID = $("select[id$='ddlTerminal']").val();
                if (Place_Name == "") {
                    alert("Please Enter Place Name!");
                    return false;
                }

                if (DeviceIDs == "") {
                    alert("Please Select Device ID!");
                    return false;
                }
                if (TerminalID == "") {
                    alert("Please Select Terminal Info!");
                    return false;
                }
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/UpdateTerminalInfos",
                    data: "{'Route_ID':'" + Route_ID + "','Place_Name':'" + Place_Name + "','DeviceIDs':'" + DeviceIDs + "','TerminalID':'" + TerminalID + "'}",
                    success: onsuccessDamoclesInfos
                });
           
            return false;
        }
        function onsuccessDamoclesInfos() {
          //  $("#divMsg").html("Record Updated Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record Updated successfully!");
            $("input[id$='txtPlace']").val("");
            getRouteInfos();

            ClearRouteInfos();
           
            return false;
        }
    </script>
</asp:Content>

