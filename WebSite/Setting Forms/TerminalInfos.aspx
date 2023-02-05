<%@ Page Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true"  CodeFile="TerminalInfos.aspx.cs" Inherits="Setting_Forms_TerminalInfos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <link href="css/dataTable.css" rel="stylesheet" />
    <table style="width: 100%; margin-top: 0%;">
        <tr>
            <td>
                <fieldset>
                    <legend>Add/Modify Terminal Type Infos </legend>
                    <table id="tblCaste" style="font-family: Calibri; font-size: 11pt; width: 100%;">
                        <tr>
                            <td style="width: 140px; text-align: left;">IP:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <asp:TextBox ID="txtIP" Width="95%" placeholder="Device IP" Maxlength="15"  runat="server" BackColor="White" onkeypress="return isNumberKey(event)"></asp:TextBox>
                            </td>
                             <td style="width: 140px; text-align: left;">Controller:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <asp:DropDownList ID="ddlcontroller" class="chzn-select" runat="server">
                               <asp:ListItem Text="--Select--" Value=""></asp:ListItem>
                               <asp:ListItem Text="CoreStation04" Value="CoreStation04"></asp:ListItem>
                               <asp:ListItem Text="BioLite N2" Value="BioLiteN2"></asp:ListItem>
                               <asp:ListItem Text="BioEntry W2" Value="BioEntryW2"></asp:ListItem>   
                        </asp:DropDownList>
                            </td>
                            </tr>
                        <tr>
                            <td style="width: 140px; text-align: left;">Port:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <asp:TextBox ID="txtPort" Width="95%" placeholder="Device Port" Value="51211" ReadOnly="true"  runat="server" BackColor="White"></asp:TextBox>
                            </td>
                            <td style="width: 140px; text-align: left;">Device ID:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                              <asp:TextBox ID="txtDeviceID" Width="95%" placeholder="Device ID"   runat="server" BackColor="White"></asp:TextBox>
                            </td>
                            </tr>
                        <tr>
                            <td style="width: 140px; text-align: left;">Gate ID:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <asp:DropDownList ID="ddlgateid" runat="server"></asp:DropDownList>
                                <%--<asp:TextBox ID="txtgateid" Width="95%" placeholder=" Gate Id"   runat="server" BackColor="White"></asp:TextBox>--%>
                            </td>
                            <td style="width: 140px; text-align: left;">Terminal Name:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <asp:TextBox ID="txtterminalname" Width="95%" placeholder="Terminal Name"   runat="server" BackColor="White"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                <asp:TextBox ID="txtID" Style="display: none;"  runat="server"></asp:TextBox>
                            </td>
                            <td align="left">
                                <asp:Button ID="btnSave" Text="Add" CssClass="btn" OnClientClick="return SaveTerminalInfos();" runat="server" />

                                <asp:Button ID="btnClearCaste" Text="Clear" CssClass="btn" OnClientClick="return Clearterminalinfos();" runat="server" />

                                <asp:Button ID="btnUpdate" Text="Update" Style="display: none;" CssClass="btn" OnClientClick="return UpdateTerminalInfos();" runat="server" />
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>
    </table>
    <div id="divTerminalinfosDetails">
        <fieldset id="fldTerminalinfosDetails" >
            <legend>Terminal Info Details</legend>
             <div style="overflow: auto; width: 100%;">     
            <table id="tbleterminalDetail" class="dataTable">
            </table>
                 </div>
        </fieldset>
    </div>

    <script type="text/javascript">
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode != 46 && charCode > 31
                && (charCode < 48 || charCode > 57))
                return false;

            return true;
        }
        var oTable;
        $(document).ready(function () {  
            getTerminalInfos();

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
            oTable = $("#tbleterminalDetail").dataTable();
        }

        function SaveTerminalInfos() {
            var txtIP = $("input[id$='txtIP']").val().trim();
            var Controller = $("select[id$='ddlcontroller']").val().trim();

            var txtPort = $("input[id$='txtPort']").val().trim();
            var txtDeviceID = $("input[id$='txtDeviceID']").val().trim();

            var Gate_Id = $("select[id$='ddlgateid']").val().trim();
            var Terminal_Name = $("input[id$='txtterminalname']").val().trim();

            if (txtIP == "") {
                alert("Please Enter Device IP");
                return false;
            }

            if (Controller == "") {
                alert("Please  Select Controller!");
                return false;
            }
            if (txtPort == "") {
                alert("Please Enter Device Port");
                return false;
            } if (txtDeviceID == "") {
                alert("Please Enter Device Id!");
                return false;
            }

            
            if (Gate_Id == "") {
                alert("Please Select Gate!");
                return false;
            }
            if (Terminal_Name == "") {
                alert("Please Enter Terminal Name!");
                return false;
            }

            //Check for Device IP
            var i = 0;
            if ($("#tbleterminalDetail tr").length > 1) {
                for (i = 0; i < $("#tbleterminalDetail tr").length - 1; i++) {

                    if ($("#txtID" + i).html().toUpperCase().trim() == $("input[id$='txtIP']").val().toUpperCase().trim()) {
                        alert("IP " + $("input[id$='txtIP']").val() + "  already exists!");
                        $("input[id$='txtIP']").val("");
                        return false;
                    }
                    // alert("test")
                }
            }

            //check for Device ID
            var i = 0;
            if ($("#tbleterminalDetail tr").length > 1) {
                for (i = 0; i < $("#tbleterminalDetail tr").length - 1; i++) {

                    if ($("#txtDeviceID" + i).html().toUpperCase().trim() == $("input[id$='txtDeviceID']").val().toUpperCase().trim()) {
                        alert("Device ID " + $("input[id$='txtDeviceID']").val() + "  already exists!");
                        $("input[id$='txtDeviceID']").val("");
                        return false;
                    }
                    // alert("test")
                }
            }

            
            $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/SaveTerminalInfos",
                    data: "{'txtIP':'" + txtIP + "','Controller':'" + Controller + "','txtPort':'" + txtPort + "','txtDeviceID':'" + txtDeviceID + "','Gate_Id':'" + Gate_Id + "','Terminal_Name':'" + Terminal_Name + "'}",
                    success: onsuccessSaveTerminalInfo
            });
           
            return false;
        }
        function onsuccessSaveTerminalInfo(msg) {
            //$("#divMsg").html("Record Successfully Saved!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record saved successfully!");
            $("input[id$='txtID']").val("");
            $("input[id$='txtIP']").val("");
           // $("input[id$='txtPort']").val("");
                 $("select[id$='ddlcontroller']").val("");
            $("select[id$='ddlgateid']").val("");
            $("input[id$='txtterminalname']").val("");
            $("input[id$='txtDeviceID']").val("");
          
            getTerminalInfos();
            return false;
        }
        function Clearterminalinfos() {
           // $("input[id$='txtTerminalID']").attr("disabled", false);
            $("input[id$='txtID']").val("");
            $("input[id$='txtIP']").val("");
            //$("input[id$='txtPort']").val("");
            $("select[id$='ddlcontroller']").val("");
            $("select[id$='ddlgateid']").val("");
            $("input[id$='txtterminalname']").val("");
            $("input[id$='txtDeviceID']").val("");
            $("input[id$='btnUpdate']").hide();
            $("input[id$='btnSave']").attr("disabled", false);
            return false;
        }
        function getTerminalInfos()
        {
            $("input[id$='txtTerminalID']").attr("disabled", false);
            $.ajax({
                
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/getTerminalinfosDetail",
                data: "{}",
                success: onsuccessGetTerminalinfos
            });
            return false;
        }
        function onsuccessGetTerminalinfos(msg) {
    
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
            tbl += "<th style='text-align:left; white-space:nowrap;display:nones;'>Terminal ID</th>";
            tbl += "<th style='text-align:left; white-space:nowrap;text-align:left;'> Terminal IP</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Device ID</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Port No</th>";
            tbl += "<th style='white-space:nowrap;display:none; text-align:left;'>Terminal Id </th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Gate Name</th>";
            tbl += "<th style='white-space:nowrap;display:none; text-align:left;'>Gate ID</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Terminal Name</th>";
            tbl += "<th style='white-space:nowrap;display:none; text-align:left;'>Client ID</th>";
            
            tbl += "<th style='white-space:nowrap; text-align:left;'>Controller</th>";
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            for (var i = 0; i < data.tbleTerminalInfosDetails.length; i++) {
                tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
                tbl += "<td id='txtDelete' align='center'> <input  type='image' src='../images/Cross2.png' onclick='return DeleteTerminalInfo(" + i + ");'> </td>";
                tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord(" + i + ");'><img src='../images/Edit.png'></td>";
                tbl += "<td style='text-align:left; white-space:nowrap; display:nones;' id='txtID" + i + "'>" + data.tbleTerminalInfosDetails[i].Terminal_ID + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtterminalip" + i + "'>" + data.tbleTerminalInfosDetails[i].Terminal_IP + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtDeviceID" + i + "'>" + data.tbleTerminalInfosDetails[i].DeviceID + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtPort" + i + "'>" + data.tbleTerminalInfosDetails[i].PortNo + "</td>";
                
                tbl += "<td style='text-align:left; white-space:nowrap;' id='ddlgateName" + i + "'>" + data.tbleTerminalInfosDetails[i].Gate_Name + " </td>";
                tbl += "<td style='text-align:left;display:none; white-space:nowrap;' id='ddlgateid" + i + "'>" + data.tbleTerminalInfosDetails[i].Gate_ID + " </td>";
               
                
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtterminalname" + i + "'>" + data.tbleTerminalInfosDetails[i].TerminalName + " </td>";
                
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtController" + i + "'>" + data.tbleTerminalInfosDetails[i].Controller + " </td>";
                tbl += "</tr>";
            }
            tbl += "</tbody>";
            tbl += "</table>";
            $("#tbleterminalDetail").html(tbl);
           // dataTable();
            return false;
        }

        function getRowID(rowID) {
            $("table[id$='tbleterminalDetail'] tr").css("background-color", "white");
            $("#trmain" + rowID).css("background-color", "#6798c1");

        }


        function DeleteTerminalInfo(rowNo) {
            debugger;
           // var Sen_type_ID = $("#txtID" + rowNo).html();
            var ID = $("#txtID" + rowNo).html().trim();
          
            if (confirm("Are you sure you wish to delete this Record?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/DeleteTerminalinfos1",
                    data: "{'ID':'" + ID + "'}",
                    success: onsuccessDeleteTerminalInfo,
                    error: onerrorsDeleteTerminalData
                });

                //return false;
            }
            else
                return false;
        }

        function onerrorsDeleteTerminalData(xhr) {
            $(".alert").html(xhr.responseText);

        }
        function onsuccessDeleteTerminalInfo(msg) {
            //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record deleted successfully!");
            getTerminalInfos();
            return false;
        }

        function EditRecord(rowNo) {
         
           // $("input[id$='txtTerminalID']").attr("disabled",true);
            var Gate_Id = $("#ddlgateid" + rowNo).html().trim();
            $("select[id$='ddlgateid']").val(Gate_Id);

            var ID = $("#txtID" + rowNo).html().trim();
            $("input[id$='txtID']").val(ID);
            $("input[id$='txtTerminalID']").val(ID);
            var Terminal_Ip = $("#txtterminalip" + rowNo).html().trim();
            $("input[id$='txtIP']").val(Terminal_Ip);

            var txtDeviceID = $("#txtDeviceID" + rowNo).html().trim();
           
            $("input[id$='txtDeviceID']").val(txtDeviceID);

            var txtPort = $("#txtPort" + rowNo).html().trim();
            $("input[id$='txtPort']").val(txtPort);

            var Terminal_Name = $("#txtterminalname" + rowNo).html().trim();
            $("input[id$='txtterminalname']").val(Terminal_Name);

            
            var Controller = $("#txtController" + rowNo).html().trim();
        
            $("select[id$='ddlcontroller']").val(Controller);

            
            $("input[id$='btnUpdate']").show();
            $("input[id$='btnSave']").attr("disabled", true);
            return false;
        }
        function UpdateTerminalInfos() {
          //  debugger;
             var ID = $("input[id$='txtID']").val();
            //alert(ID);
             var Terminal_Ip = $("input[id$='txtIP']").val();
             var txtPort = $("input[id$='txtPort']").val();
             var Controller = $("select[id$='ddlcontroller']").val();
                var Gate_Id = $("select[id$='ddlgateid']").val();
                var Terminal_Name = $("input[id$='txtterminalname']").val();
                var txtDeviceID = $("input[id$='txtDeviceID']").val();
                

                if (Terminal_Ip == "") {
                    alert("Please Enter Terminal Ip!");
                    return false;
                }
                if (txtPort == "") {
                    alert("Please Enter Port!");
                    return false;
                } if (Controller == "") {
                    alert("Please Select Controller!");
                    return false;
                }
                if (Gate_Id == "") {
                    alert("Please Select Gate");
                    return false;
                }
                if (Terminal_Name == "") {
                    alert("Please Select Client Id!");
                    return false;
                }
                if (txtDeviceID == "") {
                    alert("Please Enter Device ID!");
                    return false;
                }

            //check for Device ID
            //var i = 0;
            //if ($("#tbleterminalDetail tr").length - 1 > 1) {
            //    for (i = 0; i < $("#tbleterminalDetail tr").length - 1; i++) {

            //        if ($("#txtDeviceID" + i).html().toUpperCase().trim() == $("input[id$='txtDeviceID']").val().toUpperCase().trim()) {
            //            alert("Device ID " + $("input[id$='txtDeviceID']").val() + " is already exists!");
            //            $("input[id$='txtDeviceID']").val("");
            //            return false;
            //        }
            //        // alert("test")
            //    }
            //}
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/UpdateTerminalData",
                    //data: "{'ID':'" + ID + "','Terminal_Ip':'" + Terminal_Ip + "','Terminal_Type_Id':'" + Terminal_Type_Id + "','Gate_Id':'" + Gate_Id + "','Terminal_Name':'" + Terminal_Name + "','Client_Id':'" + Client_Id + "','Controller':'" + Controller + "'}",
                    data: "{'ID':'" + ID + "','Terminal_Ip':'" + Terminal_Ip + "','txtPort':'" + txtPort + "','Controller':'" + Controller + "','Gate_Id':'" + Gate_Id + "','Terminal_Name':'" + Terminal_Name + "','txtDeviceID':'" + txtDeviceID + "'}",
                    success: onsuccessTerminalinfosType
                });
            
            return false;
        }
        function onsuccessTerminalinfosType() {
          //  $("#divMsg").html("Record Updated Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record Updated successfully!");
            $("input[id$='txtID']").val("");
            $("input[id$='txtIP']").val("");
            //$("input[id$='txtPort']").val("");
            $("select[id$='ddlcontroller']").val("");
            $("select[id$='ddlgateid']").val("");
            $("input[id$='txtterminalname']").val("");
            $("input[id$='txtDeviceID']").val("");
            $("input[id$='btnUpdate']").hide();
            $("input[id$='btnSave']").attr("disabled", false);
            getTerminalInfos();           
            return false;
        }
    </script>
</asp:Content>

