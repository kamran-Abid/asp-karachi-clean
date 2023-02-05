<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="AddSticker.aspx.cs" Inherits="AddSticker" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <link href="css/dataTable.css" rel="stylesheet" />
    <table style="width: 100%; margin-top: 0%;">

        <tr>
            <td>
                <fieldset>
                    <legend>Add/Modified Sticker</legend>

                    <table id="tblSticker" style="font-family: Calibri; font-size: 11pt; width: 100%;">
                        <tr>
                            <td style="width: 140px; text-align: left;">Sticker Type:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <asp:TextBox ID="txtStickerName" Width="95%" class="req alphanumeric" runat="server" BackColor="White"></asp:TextBox>
                            </td>


                            <td align="left">
                                <asp:TextBox ID="txtID" Style="display: none;" runat="server"></asp:TextBox>
                            </td>


                            <td align="left">
                                <asp:Button ID="btnSave" Text="Add" CssClass="btn" OnClientClick="return SaveSticker();" runat="server" />

                                <asp:Button ID="btnClearSticker" Text="Clear" CssClass="btn" OnClientClick="return ClearSticker();" runat="server" />

                                <asp:Button ID="btnUpdate" Text="Update" Style="display: none;" CssClass="btn" OnClientClick="return UpdateSticker();" runat="server" />
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>

    </table>
    <div id="divStickerDetails" >
        <fieldset id="fldStickerDetails" >
            <legend>Sticker Details</legend>
            <div style="overflow: auto; width: 100%;">
                  <table id="tbleStickerDetails" class="dataTable">
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
            getSticker();

        });

        function dataTable() {
            oTable = $("#tbleStickerDetails").dataTable();
        }

        function SaveSticker() {
            var i = 0;
            if ($("#tbleStickerDetails tr").length - 1 > 1) {
                for (i = 0; i < $("#tbleStickerDetails tr").length - 1; i++) {

                    if ($("#txtStickerName" + i).html().toUpperCase().trim() == $("input[id$='txtStickerName']").val().toUpperCase().trim()) {
                        alert("Sticker is " + $("input[id$='txtStickerName']").val() + " already added!");
                        $("input[id$='txtStickerName']").val("");
                        return false;
                    }
                    // alert("test")
                }
            }
            if (!validate("tblSticker")) {
                var Sticker_Name = $("input[id$='txtStickerName']").val().trim();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/SaveSticker",
                    data: "{'Sticker_Name':'" + Sticker_Name + "'}",
                    success: onsuccessSaveSticker
                });
            }
            return false;
        }
        function onsuccessSaveSticker(msg) {
            // $("#divMsg").html("Record Successfully Saved!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record Saved successfully!");
            $("input[id$='txtStickerName']").val("");
            getSticker();
            return false;
        }
        function ClearSticker() {
            $("input[id$='txtStickerName']").val("");
            $("input[id$='btnUpdate']").hide();
            $("input[id$='btnSave']").attr("disabled", false);
            return false;
        }
        function getSticker() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/getStickerDetail",
                data: "{}",
                success: onsuccessgetSticker
            });
            return false;
        }
        function onsuccessgetSticker(msg) {
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
            tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Sticker ID</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Sticker Name</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            for (var i = 0; i < data.StickerDetail.length; i++) {
                tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
                tbl += "<td id='txtDelete' align='center'> <input  type='image' src='../images/Cross2.png' onclick='return DeleteStickerRecord(" + i + ");'> </td>";
                tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord(" + i + ");'><img src='../images/Edit.png'></td>";
                tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.StickerDetail[i].Sticker_ID + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtStickerName" + i + "'>" + data.StickerDetail[i].Sticker_Name + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.StickerDetail[i].created_by + "</td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.StickerDetail[i].created_date + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.StickerDetail[i].modified_by + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.StickerDetail[i].modified_date + " </td>";
                tbl += "</tr>";
            }
            tbl += "</tbody>";
            tbl += "</table>";
            $("#tbleStickerDetails").html(tbl);
            dataTable();
            return false;
        }

        function getRowID(rowID) {
            $("table[id$='tbleStickerDetails'] tr").css("background-color", "white");
            $("#trmain" + rowID).css("background-color", "#6798c1");

        }


        function DeleteStickerRecord(rowNo) {

            var Sticker_ID = $("#txtID" + rowNo).html();

            if (confirm("Are you sure you wish to delete this Record?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/DeleteSticker",
                    data: "{'Sticker_ID':'" + Sticker_ID + "'}",
                    success: onsuccessDeleteData
                });

                return false;
            }
            else
                return false;
        }

        function onsuccessDeleteData(msg) {
            // $("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record deleted successfully!");
            getSticker();
            return false;
        }

        function EditRecord(rowNo) {
            var ID = $("#txtID" + rowNo).html().trim();
            $("input[id$='txtID']").val(ID);

            var Sticker_Name = $("#txtStickerName" + rowNo).html().trim();
            $("input[id$='txtStickerName']").val(Sticker_Name);

            $("input[id$='btnUpdate']").show();
            $("input[id$='btnSave']").attr("disabled", true);
            return false;
        }
        function UpdateSticker() {
            if (!validate("tblSticker")) {
                var Sticker_ID = $("input[id$='txtID']").val();
                var Sticker_Name = $("input[id$='txtStickerName']").val();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/UpdateSticker",
                    data: "{'Sticker_ID':'" + Sticker_ID + "','Sticker_Name':'" + Sticker_Name + "'}",
                    success: onsuccessUpdateSticker
                });
            }
            return false;
        }
        function onsuccessUpdateSticker() {
           // $("#divMsg").html("Record Updated Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record Updated successfully!");
            $("input[id$='txtStickerName']").val("");
            getSticker();

            ClearSticker();
            getSticker();
            return false;
        }
    </script>
</asp:Content>

