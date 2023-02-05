<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/PACS.master" CodeFile="MachineInfos.aspx.cs" Inherits="Setting_Forms_MachineInfos" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <link href="css/dataTable.css" rel="stylesheet" />
    <table style="width: 100%; margin-top: 0%;">

        <tr>
            <td>
                <fieldset>
                    <legend>Add/Modify Client Machine Infos </legend>

                    <table id="tblCaste" style="font-family: Calibri; font-size: 11pt; width: 100%;">
                        <tr>
                            
                            <td style="width: 140px; text-align: left;">Client IP:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <asp:TextBox ID="txtclientip" Width="95%" placeholder="client Ip"   runat="server" BackColor="White"></asp:TextBox>
                            </td>
                            <td style="width: 140px; text-align: left;">Terminal Type ID:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <%--<asp:TextBox ID="txtterminaltypeid" Width="95%" placeholder="Terminal Type"   runat="server" BackColor="White"></asp:TextBox>--%>
                                <asp:DropDownList ID="ddlterminaltypeid" runat="server"></asp:DropDownList>
                            </td>
                            </tr>
                        <tr>
                         
                            <td style="width: 140px; text-align: left;">Gate ID:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <asp:DropDownList ID="ddlgateid" runat="server"></asp:DropDownList>
                                <%--<asp:TextBox ID="txtgateid" Width="95%" placeholder=" Gate Id"   runat="server" BackColor="White"></asp:TextBox>--%>
                            </td>
                           
                            <td align="left">
                                <asp:TextBox ID="txtID" Style="display: none;" runat="server"></asp:TextBox>
                            </td>


                            <td align="left">
                                <asp:Button ID="btnSave" Text="Add" CssClass="btn" OnClientClick="return SaveMachineInfos();" runat="server" />

                                <asp:Button ID="btnClearCaste" Text="Clear" CssClass="btn" OnClientClick="return Clearmachineinfos();" runat="server" />

                                <asp:Button ID="btnUpdate" Text="Update" Style="display: none;" CssClass="btn" OnClientClick="return UpdateMachineInfos();" runat="server" />
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>

    </table>
    <div id="divMachineinfosDetails">
        <fieldset id="fldMachineinfosDetails" >
            <legend>Machine Info Details</legend>
             <div style="overflow: auto; width: 100%;">
                  
            <table id="tblemachineDetail" class="dataTable">
            </table>
                 </div>
        </fieldset>
    </div>

    <script type="text/javascript">
        var oTable;
        $(document).ready(function () {
            getMachineInfos();

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
            oTable = $("#tblemachineDetail").dataTable();
        }

        function SaveMachineInfos() {

            var Client_Ip = $("input[id$='txtclientip']").val().trim();
            var Terminal_Type_Id = $("select[id$='ddlterminaltypeid']").val().trim();
            var Gate_Id = $("select[id$='ddlgateid']").val().trim();

            if (Client_Ip == "") {
                alert("Please Enter Client Ip!");
                return false;
            }
            //if (Terminal_Type_Id == "") {
            //    alert("Please Enter Terminal Type Id!");
            //    return false;
            //}
            if (Gate_Id == "") {
                alert("Please Enter Gate Id!");
                return false;
            }  
            //var i = 0;
            //if ($("#tblemachineDetail tr").length - 1 > 1) {
            //    for (i = 0; i < $("#tblemachineDetail tr").length - 1; i++) {

            //        if ($("#txtclientip" + i).html().toUpperCase().trim() == $("input[id$='txtclientip']").val().toUpperCase().trim()) {
            //            alert("Client IP  " + $("input[id$='txtclientip']").val() + " is already added!");
            //            $("input[id$='txtclientip']").val("");
            //            return false;
            //        }
            //        // alert("test")
            //    }
            //}
               
                //var Terminal_Name = $("input[id$='txtterminalname']").val().trim();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/SavemachineInfos",
                    data: "{'Client_Ip':'" + Client_Ip + "','Terminal_Type_Id':'" + Terminal_Type_Id + "','Gate_Id':'" + Gate_Id + "'}",
                    success: onsuccessSaveMachineInfo
                });
            
            return false;
        }
        function onsuccessSaveMachineInfo(msg) {
            //$("#divMsg").html("Record Successfully Saved!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record saved successfully!" + msg.data);
            
            $("input[id$='txtclientip']").val("");
            $("select[id$='ddlterminaltypeid']").val("");
            $("select[id$='ddlgateid']").val("");
            getMachineInfos();
            return false;
        }
        function Clearmachineinfos() {
            
            $("input[id$='txtclientip']").val("");
            $("select[id$='ddlterminaltypeid']").val("");
            $("select[id$='ddlgateid']").val("");
            $("input[id$='btnUpdate']").hide();
            $("input[id$='btnSave']").attr("disabled", false);
            return false;
        }
        function getMachineInfos() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/getMachineinfosDetail",
                data: "{}",
                success: onsuccessGetMachineinfos
            });
            return false;
        }
        function onsuccessGetMachineinfos(msg) {
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
            tbl += "<th style='text-align:left; white-space:nowrap; display:none;'> Client ID</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Client IP</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Terminal Type</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Gate Name</th>";
            tbl += "<th style='white-space:nowrap;display:none; text-align:left;'>Gate ID</th>";
            //tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
            //tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            for (var i = 0; i < data.tbleMachineInfosDetails.length; i++) {
                tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
                tbl += "<td id='txtDelete' align='center'> <input  type='image' src='../images/Cross2.png' onclick='return DeleteMachineInfo(" + i + ");'> </td>";
                tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord(" + i + ");'><img src='../images/Edit.png'></td>";
                tbl += "<td style='text-align:left; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.tbleMachineInfosDetails[i].Client_ID + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtclientip" + i + "'>" + data.tbleMachineInfosDetails[i].Client_IP + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtterminaltypeid" + i + "'>" + data.tbleMachineInfosDetails[i].Terminal_Type + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtgateName" + i + "'>" + data.tbleMachineInfosDetails[i].Gate_Name + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;display:none;' id='txtgateid" + i + "'>" + data.tbleMachineInfosDetails[i].Gate_ID + " </td>";
               // tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.CasteDetail[i].modified_by + " </td>";
                //tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.CasteDetail[i].modified_date + " </td>";
                tbl += "</tr>";
            }
            tbl += "</tbody>";
            tbl += "</table>";
            $("#tblemachineDetail").html(tbl);
            dataTable();
            return false;
        }

        function getRowID(rowID) {
            $("table[id$='tblemachineDetail'] tr").css("background-color", "white");
            $("#trmain" + rowID).css("background-color", "#6798c1");

        }


        function DeleteMachineInfo(rowNo) {

           // var Sen_type_ID = $("#txtID" + rowNo).html();
            var ID = $("#txtID" + rowNo).html().trim();
          
            if (confirm("Are you sure you wish to delete this Record?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/DeleteMachineInfos",
                   // data: "{'Sen_type_ID ':'" + ID + "'}",
                    data: "{'ID':'" + ID + "'}",
                    success: onsuccessDeleteMachineInfo,
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
        function onsuccessDeleteMachineInfo(msg) {
            //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record deleted successfully!");
            getMachineInfos();
            return false;
        }

        function EditRecord(rowNo) {
     
            var ID = $("#txtID" + rowNo).html().trim();
            $("input[id$='txtID']").val(ID);

            var Client_Ip = $("#txtclientip" + rowNo).html().trim();
            $("input[id$='txtclientip']").val(Client_Ip);

            var Terminal_Type_Id = $("#txtID" + rowNo).html();
            $("select[id$='ddlterminaltypeid']").val(Terminal_Type_Id);

            var Gate_ID = $("#txtgateid" + rowNo).html().trim();
        
            $("select[id$='ddlgateid']").val(Gate_ID);

           

            $("input[id$='btnUpdate']").show();
            $("input[id$='btnSave']").attr("disabled", true);
            return false;
        }
        function UpdateMachineInfos() {
            var ID = $("input[id$='txtID']").val();
            var Client_Ip = $("input[id$='txtclientip']").val();
            var Terminal_Type_Id = $("select[id$='ddlterminaltypeid']").val();
            var Gate_ID = $("select[id$='ddlgateid']").val();

            if (Client_Ip == "") {
                alert("Please Enter Client Ip!");
                return false;
            }
            if (Terminal_Type_Id == "") {
                alert("Please Enter Terminal Type Id!");
                return false;
            }
            if (Gate_ID == "") {
                alert("Please Enter Gate Id!");
                return false;
            }
            //var i = 0;
            //if ($("#tblemachineDetail tr").length - 1 > 1) {
            //    for (i = 0; i < $("#tblemachineDetail tr").length - 1; i++) {

            //        if ($("#txtclientip" + i).html().toUpperCase().trim() == $("input[id$='txtclientip']").val().toUpperCase().trim()) {
            //            alert("client Ip " + $("input[id$='txtclientip']").val() + " is already added!");
            //           // $("input[id$='txtclientip']").val("");
            //            return false;
            //        }
            //        // alert("test")
            //    }
            //}
                
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/UpdateMachineInfos",
                    data: "{'ID':'" + ID + "','Client_Ip':'" + Client_Ip + "','Terminal_Type_Id':'" + Terminal_Type_Id + "','Gate_ID':'" + Gate_ID + "'}",
                    success: onsuccessmachineinfosType
                });
           
            return false;
        }
        function onsuccessmachineinfosType() {
          //  $("#divMsg").html("Record Updated Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record Updated successfully!");
            $("input[id$='txtclientip']").val("");
            $("input[id$='txtterminaltypeide']").val("");
            $("select[id$='ddlgateid']").val("");
            
            Clearmachineinfos();

            getMachineInfos();
           
            return false;
        }
    </script>
</asp:Content>

