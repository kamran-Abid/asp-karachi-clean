<%@ Page Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="DamoclesInfos.aspx.cs" Inherits="Setting_Forms_DamoclesInfos" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <link href="css/dataTable.css" rel="stylesheet" />
    <table style="width: 100%; margin-top: 0%;">

        <tr>
            <td>
                <fieldset>
                    <legend>Add/Modify Damocles Info</legend>

                    <table id="tbldamoclesinfo" style="font-family: Calibri; font-size: 11pt; width: 100%;">
                        <tr>
                            <td style="width: 140px; text-align: left;">IP:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <asp:TextBox ID="txtIp" Width="95%" placeholder="Ip" class="req"  runat="server" BackColor="White"></asp:TextBox>
                            </td>
                             <td style="width: 140px; text-align: left;">MacAddress:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <asp:TextBox ID="txtmacaddress" Width="95%" placeholder="Mac Address" class="req"   runat="server" BackColor="White"></asp:TextBox>
                            </td>
                            <tr>
                                 <td style="width: 140px; text-align: left;">Gate Id:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                               <asp:DropDownList ID="ddlgateid" runat="server" class="req"></asp:DropDownList>
                                <%-- <asp:TextBox ID="txtgateid" Width="95%" placeholder="Gate Id"   runat="server" BackColor="White"></asp:TextBox>--%>
                            </td>
                            </tr>
                            


                            <td align="left">
                                <asp:TextBox ID="txtID" Style="display: none;" runat="server"></asp:TextBox>
                            </td>


                            <td align="left">
                                <asp:Button ID="btnSave" Text="Add" CssClass="btn" OnClientClick="return SaveDamoclesInfos();" runat="server" />

                                <asp:Button ID="btnClearCaste" Text="Clear" CssClass="btn" OnClientClick="return Cleardamoclesinfos();" runat="server" />

                                <asp:Button ID="btnUpdate" Text="Update" Style="display: none;" CssClass="btn" OnClientClick="return UpdateDamoclesInfos();" runat="server" />
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
                  
            <table id="tbleDamoclesInfosDetail" class="dataTable">
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
            getdamoclesinfos();

        });

        function dataTable() {
            oTable = $("#tbleDamoclesInfosDetails").dataTable();
        }

        function SaveDamoclesInfos() {
            var i = 0;
            if ($("#tbleDamoclesInfosDetail tr").length - 1 > 1) {
                for (i = 0; i < $("#tbleDamoclesInfosDetail tr").length - 1; i++) {

                    if ($("#txtIp" + i).html().toUpperCase().trim() == $("input[id$='txtIp']").val().toUpperCase().trim()) {
                        alert("Ip " + $("input[id$='txtIp']").val() + " is already added!");
                        $("input[id$='txtIp']").val("");
                        return false;
                    }
                    // alert("test")
                }
            }
          
           
                var Ip = $("input[id$='txtIp']").val().trim();
                var macaddress = $("input[id$='txtmacaddress']").val().trim();
                var Gateid = $("select[id$='ddlgateid']").val().trim();
                if (Ip == "") {
                    alert("Please Enter IP Address!");
                    return false;
                }

                if (macaddress == "") {
                    alert("Please Enter Mac Address!");
                    return false;
                }
                if (Gateid == "") {
                    alert("Please Enter Gate ID!");
                    return false;
                }
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/SaveDamoclesInfos",
                    data: "{'Ip':'" + Ip + "', 'macaddress':'" + macaddress + "', 'Gateid':'" + Gateid + "'}",
                    success: onsuccessSaveDamoclesInfos
                });
           
            return false;
        }
        function onsuccessSaveDamoclesInfos(msg) {
            //$("#divMsg").html("Record Successfully Saved!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record saved successfully!");
            $("input[id$='txtIp']").val("");
            $("input[id$='txtmacaddress']").val("");
            $("select[id$='ddlgateid']").val("");
            getdamoclesinfos();
            return false;
        }
        function Cleardamoclesinfos() {
            $("input[id$='txtIp']").val("");
            $("input[id$='txtmacaddress']").val("");
            $("select[id$='ddlgateid']").val("");
            $("input[id$='btnUpdate']").hide();
            $("input[id$='btnSave']").attr("disabled", false);
            return false;
        }
        function getdamoclesinfos() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/getdamoclesinfosDetail",
                data: "{}",
                success: onsuccessgetDamoclesInfos
            });
            return false;
        }
        function onsuccessgetDamoclesInfos(msg) {
          
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
            tbl += "<th style='white-space:nowrap; text-align:left;'>Ip</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Mac Address</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Gate Name</th>";
            tbl += "<th style='white-space:nowrap;display:none; text-align:left;'>Gate ID</th>";
            
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            for (var i = 0; i < data.tbleDamoclesInfosDetails.length; i++) {
                tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
                tbl += "<td id='txtDelete' align='center'> <input  type='image' src='../images/Cross2.png' onclick='return  DeletedamoclesInfos(" + i + ");'> </td>";
                tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord(" + i + ");'><img src='../images/Edit.png'></td>";
                tbl += "<td style='text-align:left; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.tbleDamoclesInfosDetails[i].Dam_ID + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtIp" + i + "'>" + data.tbleDamoclesInfosDetails[i].Dam_IP + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtmacaddress" + i + "'>" + data.tbleDamoclesInfosDetails[i].Dam_Mac_Address + "</td>";
                
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtgateName" + i + "'>" + data.tbleDamoclesInfosDetails[i].Gate_Name + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;display:none;' id='txtgateid" + i + "'>" + data.tbleDamoclesInfosDetails[i].Gate_ID + " </td>";
                //tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.CasteDetail[i].modified_by + " </td>";
                //tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.CasteDetail[i].modified_date + " </td>";
                tbl += "</tr>";
            }
            tbl += "</tbody>";
            tbl += "</table>";
            $("#tbleDamoclesInfosDetail").html(tbl);
            dataTable();
            Cleardamoclesinfos();
            return false;
        }

        function getRowID(rowID) {
            $("table[id$='tbleDamoclesInfosDetail'] tr").css("background-color", "white");
            $("#trmain" + rowID).css("background-color", "#6798c1");

        }


        function DeletedamoclesInfos(rowNo) {
           
            var Dam_ID = $("#txtID" + rowNo).html();

            if (confirm("Are you sure you wish to delete this Record?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/DeleteDamoclesInfos",
                    data: "{'Dam_ID':'" + Dam_ID + "'}",
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
            getdamoclesinfos();
            return false;
        }

        function EditRecord(rowNo) {
            var ID = $("#txtID" + rowNo).html().trim();
            $("input[id$='txtID']").val(ID);

            var Ip = $("#txtIp" + rowNo).html().trim();
            $("input[id$='txtIp']").val(Ip);

            var macaddress = $("#txtmacaddress" + rowNo).html().trim();
            $("input[id$='txtmacaddress']").val(macaddress);

            var Gate_Id = $("#txtgateid" + rowNo).html().trim();
            $("select[id$='ddlgateid']").val(Gate_Id);
            
            $("input[id$='btnUpdate']").show();
            $("input[id$='btnSave']").attr("disabled", true);
            return false;
        }
        function UpdateDamoclesInfos() {

            var i = 0;
            if ($("#tbleDamoclesInfosDetail tr").length - 1 > 1) {
                for (i = 0; i < $("#tbleDamoclesInfosDetail tr").length - 1; i++) {

                    if ($("#txtIp" + i).html().toUpperCase().trim() == $("input[id$='txtIp']").val().toUpperCase().trim()) {
                        alert("Ip " + $("input[id$='txtIp']").val() + " is already added!");
                       // $("input[id$='txtIp']").val("");
                        return false;
                    }
                    // alert("test")
                }
            }
           
                var Dam_ID = $("input[id$='txtID']").val();
                var Ip = $("input[id$='txtIp']").val();
                var macaddress = $("input[id$='txtmacaddress']").val();
                var Gate_id = $("select[id$='ddlgateid']").val();
                if (Ip == "") {
                    alert("Please Enter IP Address!");
                    return false;
                }

                if (macaddress == "") {
                    alert("Please Enter Mac Address!");
                    return false;
                }
                if (Gate_id == "") {
                    alert("Please Enter Gate ID!");
                    return false;
                }
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/UpdateDamoclesInfos",
                    data: "{'Dam_ID':'" + Dam_ID + "','Ip':'" + Ip + "','macaddress':'" + macaddress + "','Gate_id':'" + Gate_id + "'}",
                    success: onsuccessDamoclesInfos
                });
           
            return false;
        }
        function onsuccessDamoclesInfos() {
          //  $("#divMsg").html("Record Updated Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record Updated successfully!");
            $("input[id$='txtIp']").val("");
            getdamoclesinfos();

            Cleardamoclesinfos();
           
            return false;
        }
    </script>
</asp:Content>

