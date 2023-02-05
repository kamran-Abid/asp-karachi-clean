<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="AddWiegandDevices.aspx.cs" Inherits="Setting_Forms_AddWiegandDevices" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <%--<link href="css/dataTable.css" rel="stylesheet" />--%>
    <table style="width: 100%; margin-top: 0%;">
        <tr>
            <td>
                <fieldset>
                    <legend>Add/Modify Wiegand Device Infos </legend>
                    <table id="tblTerminal" style="font-family: Calibri; font-size: 11pt; width: 100%;">
                        <tr>
                            <td style="width: 140px; text-align: left;">Gate:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <asp:DropDownList ID="ddlgateid" OnSelectedIndexChanged="ddlgateid_SelectedIndexChanged" AutoPostBack="true" runat="server"></asp:DropDownList>
                            </td>
                             <td style="width: 140px; text-align: left;">Location:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <asp:DropDownList ID="ddlLocation" class="chzn-select" runat="server">  
                                </asp:DropDownList>
                            </td>
                            </tr>
                        <tr>
                            <td style="width: 140px; text-align: left;">Controller ID:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">

                                <asp:DropDownList ID="txtControllerID" class="chzn-select" runat="server">  
                                </asp:DropDownList>
                                <%--<asp:TextBox ID="txtControllerID" Width="95%" placeholder="Controller ID"   runat="server" BackColor="White"></asp:TextBox>--%>
                            </td>
                            <td style="width: 140px; text-align: left;">Wiegand ID:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                              <asp:TextBox ID="txtWeighdID" Width="95%" placeholder="Wiegand ID" runat="server" BackColor="White"></asp:TextBox>
                            </td>
                            </tr>
                        <tr>
                            <td style="width: 140px; text-align: left;">Device Name:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <asp:TextBox ID="txtDeviceName" Width="95%" placeholder="Device Name" runat="server" BackColor="White"></asp:TextBox>
                                <%--<asp:TextBox ID="txtgateid" Width="95%" placeholder=" Gate Id"   runat="server" BackColor="White"></asp:TextBox>--%>
                            </td>
                            <td style="width: 140px; text-align: left;">Terminal Type:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <asp:DropDownList ID="ddlTerminalType" class="chzn-select" runat="server">  
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 140px; text-align: left;">Door ID:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <asp:TextBox ID="txtDoorID" Width="95%" placeholder="Door ID"   runat="server" BackColor="White"></asp:TextBox>
                            </td>
                            <td style="width: 140px; text-align: left;">Client IP:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                 <asp:DropDownList ID="txtClientID" class="chzn-select" runat="server">  
                                </asp:DropDownList>
                             
                            </td>
                            </tr>
                        <tr>
                           
                            <td style="width: 140px; text-align: left;">Terminal ID:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <asp:DropDownList ID="ddlTerminalID" class="chzn-select" runat="server">  
                                </asp:DropDownList>
                            </td>
                            <td style="width: 140px; text-align: left;">Site Allowed:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                                <asp:DropDownList ID="ddlSiteAllowed" class="chzn-select" runat="server">  
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                
                                <asp:TextBox ID="txtID" Style="display: none;"  runat="server"></asp:TextBox>
                            </td>
                            <td align="left">
                                <asp:Button ID="btnSave" Text="Add" CssClass="btn" OnClientClick="return saveWeigandDevices();" runat="server" OnClick="btnSave_Click" />

                                <asp:Button ID="btnClearCaste" Text="Clear" CssClass="btn" OnClientClick="return clearfields();" runat="server" />

                                <asp:Button ID="btnUpdate" Text="Update" Style="display: none;" CssClass="btn" OnClientClick="return UpdateTerminalInfos();" runat="server" OnClick="btnUpdate_Click"/>
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>
    </table>
    <div id="divWiegandDevicesInfoDetails">
        <fieldset id="fldTerminalinfosDetails" >
            <legend>Wiegand Devices Info Details</legend>
             <div style="overflow: auto; width: 100%;">     
            <table id="tbleterminalDetail" class="dataTable">
            </table>
                 </div>
        </fieldset>
    </div>
    <script type="text/javascript">

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
    function saveWeigandDevices() {
        debugger;
        var ddlgateid = $("select[id$='ddlgateid']").val();
        var ddlLocation = $("select[id$='ddlLocation']").val();

        var txtControllerID = $("select[id$='txtControllerID']").val().trim();
        var txtWeighdID = $("input[id$='txtWeighdID']").val().trim();

        var txtDeviceName = $("input[id$='txtDeviceName']").val().trim();
        var ddlTerminalType = $("select[id$='ddlTerminalType']").val();

        var txtDoorID = $("input[id$='txtDoorID']").val().trim();
        var txtClientID = $("select[id$='txtClientID']").val().trim();

        var ddlTerminalID = $("select[id$='ddlTerminalID']").val();
        var ddlSiteAllowed = $("select[id$='ddlSiteAllowed']").val();

        if (ddlgateid == "") {
            alert("Please Select Gate!");
            return false;
        }

        if (ddlLocation == "") {
            alert("Please Select Location!");
            return false;
        }

        if (txtControllerID == "") {
            alert("Please Enter Controller Id!");
            return false;
        }

        if (txtWeighdID == "") {
            alert("Please Enter Weighd Id!");
            return false;
        }

        if (txtDeviceName == "") {
            alert("Please Enter Device Name!");
            return false;
        }
        if (ddlTerminalType == "") {
            alert("Please Select Terminal Type!");
            return false;
        }
        if (txtDoorID == "") {
            alert("Please Enter Door Id!");
            return false;
        }
        if (txtClientID == "") {
            alert("Please Enter Client Id!");
            return false;
        }
        if (ddlTerminalID == "") {
            alert("Please Select Terminal Id!");
            return false;
        }

        if (ddlSiteAllowed == "") {
            alert("Please Select Site Allowed!");
            return false;
        }
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "Settingwebmethods.aspx/SaveWeigndDevice",
            data: "{'ddlgateid':'" + ddlgateid + "','ddlLocation':'" + ddlLocation + "','txtControllerID':'" + txtControllerID + "','txtWeighdID':'" + txtWeighdID + "','txtDeviceName':'" + txtDeviceName + "','ddlTerminalType':'" + ddlTerminalType + "','txtDoorID':'" + txtDoorID + "','txtClientID':'" + txtClientID + "','ddlTerminalID':'" + ddlTerminalID + "','ddlSiteAllowed':'" + ddlSiteAllowed + "'}",
            success: onsuccessSaveTerminalInfo
        });
    }
    function onsuccessSaveTerminalInfo(msg) {
        showSuccessMsg("Record saved successfully!");
        getTerminalInfos();
        clearfields();
    }

    function getTerminalInfos() {

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "Settingwebmethods.aspx/getWeigandDevice",
            data: "{}",
            success: onsuccessGetTerminalinfos
        });
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
        //tbl += "<th style='text-align:center;width:8%;'>Delete</th>";
        tbl += "<th style='text-align:center; white-space:nowrap;'>Edit</th>";
        tbl += "<th style='text-align:left; white-space:nowrap;display:none;'>ID</th>";
        
        tbl += "<th style='white-space:nowrap;display:none; text-align:left;'>Gate Id </th>";
        tbl += "<th style='white-space:nowrap; text-align:left;'>Gate Name</th>";

        tbl += "<th style='white-space:nowrap;display:none; text-align:left;'>Place Id </th>";
        tbl += "<th style='white-space:nowrap; text-align:left;'>Place Name</th>";
        
        tbl += "<th style='white-space:nowrap; text-align:left;'>Terminal Name</th>";
        tbl += "<th style='white-space:nowrap; text-align:left;'>Device Id</th>";
        tbl += "<th style='white-space:nowrap; text-align:left;'>Weigand Id</th>";
        tbl += "<th style='white-space:nowrap; text-align:left;'>Device Name</th>";

        tbl += "<th style='white-space:nowrap;display:none; text-align:left;'>Terminal Type ID</th>";
        tbl += "<th style='white-space:nowrap; text-align:left;'>Terminal Type</th>";

        tbl += "<th style='white-space:nowrap; text-align:left;'>Client Id</th>";
        tbl += "<th style='white-space:nowrap; text-align:left;'>Door ID</th>";

        tbl += "<th style='white-space:nowrap;display:none; text-align:left;'>Site Id </th>";
        tbl += "<th style='white-space:nowrap; text-align:left;'>Site Name</th>";

        tbl += "</tr>";
        tbl += "</thead>";
        tbl += "<tbody>";
        for (var i = 0; i < data.tbleTerminalInfosDetails.length; i++) {
            tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
            //tbl += "<td id='txtDelete' align='center'> <input  type='image' src='../images/Cross2.png' onclick='return DeleteTerminalInfo(" + i + ");'> </td>";
            tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord(" + i + ");'><img src='../images/Edit.png'></td>";
            tbl += "<td style='text-align:left; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.tbleTerminalInfosDetails[i].ID + "</td>";

            tbl += "<td style='text-align:left; white-space:nowrap; display:none;' id='txtGate_ID" + i + "'>" + data.tbleTerminalInfosDetails[i].Gate_ID + "</td>";
            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtGate_Name" + i + "'>" + data.tbleTerminalInfosDetails[i].Gate_Name + "</td>";

            tbl += "<td style='text-align:left; white-space:nowrap; display:none;' id='txtPlace_Id" + i + "'>" + data.tbleTerminalInfosDetails[i].Place_Id + "</td>";
            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtterminalip" + i + "'>" + data.tbleTerminalInfosDetails[i].LocationName + "</td>";

            tbl += "<td style='text-align:left; white-space:nowrap; display:none;' id='txtTerminal_ID" + i + "'>" + data.tbleTerminalInfosDetails[i].Terminal_ID + "</td>";
            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtTerminalName" + i + "'>" + data.tbleTerminalInfosDetails[i].TerminalName + "</td>";

            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtDeviceID" + i + "'>" + data.tbleTerminalInfosDetails[i].DeviceID + "</td>";
            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtwiegandID" + i + "'>" + data.tbleTerminalInfosDetails[i].wiegandID + "</td>";
            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtDeviceName" + i + "'>" + data.tbleTerminalInfosDetails[i].DeviceName + "</td>";

            tbl += "<td style='text-align:left; white-space:nowrap; display:none;' id='txtTerminalType" + i + "'>" + data.tbleTerminalInfosDetails[i].TerminalType + "</td>";
            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtTerminal_type" + i + "'>" + data.tbleTerminalInfosDetails[i].Terminal_type + "</td>";

            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtClient_Id" + i + "'>" + data.tbleTerminalInfosDetails[i].Client_Id + " </td>";
            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtDoorID" + i + "'>" + data.tbleTerminalInfosDetails[i].DoorID + " </td>";

            tbl += "<td style='text-align:left; white-space:nowrap; display:none;' id='txtSite_Id" + i + "'>" + data.tbleTerminalInfosDetails[i].site_ID + "</td>";
            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtSiteName" + i + "'>" + data.tbleTerminalInfosDetails[i].Site_Name + "</td>";

            tbl += "</tr>";
        }
        tbl += "</tbody>";
        tbl += "</table>";
        $("#tbleterminalDetail").html(tbl);
        //  dataTable();
     //  clearfields();
        //getTerminalInfos();
       // return false;
    }
    function clearfields() {
        
        $("input[id$='txtID']").val("");
        $("select[id$='ddlgateid']").val("");
        $("select[id$='ddlLocation']").val("");
        $("select[id$='txtControllerID']").val("");
        $("input[id$='txtWeighdID']").val("");
        $("input[id$='txtDeviceName']").val("");
        $("select[id$='ddlTerminalType']").val("");
        $("input[id$='txtDoorID']").val("");
        $("select[id$='txtClientID']").val("");
        $("select[id$='ddlTerminalID']").val("");
        $("input[id$='btnUpdate']").hide();
        $("input[id$='btnSave']").attr("disabled", false);

    }

    function EditRecord(rowNo) {

        // $("input[id$='txtTerminalID']").attr("disabled",true);
        var txtID = $("#txtID" + rowNo).html().trim();
        $("input[id$='txtID']").val(txtID);

        var txtGate_ID = $("#txtGate_ID" + rowNo).html().trim();
        $("select[id$='ddlgateid']").val(txtGate_ID);
        
        var txtPlace_Id = $("#txtPlace_Id" + rowNo).html().trim();
        $("select[id$='ddlLocation']").val(txtPlace_Id);

        var txtTerminal_ID = $("#txtTerminal_ID" + rowNo).html().trim();
        $("select[id$='ddlTerminalID']").val(txtTerminal_ID);

        var txtDeviceID = $("#txtDeviceID" + rowNo).html().trim();
        $("select[id$='txtControllerID']").val(txtDeviceID);

        var txtwiegandID = $("#txtwiegandID" + rowNo).html().trim();
        $("input[id$='txtWeighdID']").val(txtwiegandID);


        var txtDeviceName = $("#txtDeviceName" + rowNo).html().trim();
        $("input[id$='txtDeviceName']").val(txtDeviceName);

        var txtTerminalType = $("#txtTerminalType" + rowNo).html().trim();
        $("select[id$='ddlTerminalType']").val(txtTerminalType);

        var txtClient_Id = $("#txtClient_Id" + rowNo).html().trim();
        $("select[id$='ddlcontroller']").val(txtClient_Id);

        var txtDoorID = $("#txtDoorID" + rowNo).html().trim();
        $("input[id$='txtDoorID']").val(txtDoorID);

        var txtClient_Id = $("#txtClient_Id" + rowNo).html().trim();
        $("select[id$='txtClientID']").val(txtClient_Id);

        var txtSite_Id = $("#txtSite_Id" + rowNo).html().trim();
        $("select[id$='ddlSiteAllowed']").val(txtSite_Id);

        $("input[id$='btnUpdate']").show();
        $("input[id$='btnSave']").attr("disabled", true);
        return false;
    }

        function DeleteTerminalInfo(rowNo) {


            var ID = $("#txtID" + rowNo).html();

            if (confirm("Are you sure you wish to delete this Record?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "Settingwebmethods.aspx/DeleteWeigandDevices",
                    data: "{'ID':'" + ID + "'}",
                    success: onsuccessDeleteData,
                    error: OnretrievePhysicianError
                });

                return false;
            }
            else
                return false;

        }

        function onsuccessDeleteData(msg) {


            showSuccessMsg("Record Deleted successfully!");
            //getDepartment();
            //getWeigandDevice
            //getTerminalInfos();
            getTerminalInfos();

            return false;

        }

        function OnretrievePhysicianError(msg) {
            // getDepartmentalRecod();
            alert(msg.responseText);
            $("#ErrorMessageDiv").show();
            $("#ErrorMessageDiv").html("");
            $("#ErrorMessageDiv").html("Error in Record Deleting!");
            $("#ErrorMessageDiv").fadeOut(6000);
            return false;
        }


    function UpdateTerminalInfos() {

        var ID = $("input[id$='txtID']").val();

        var ddlgateid = $("select[id$='ddlgateid']").val().trim();
        var ddlLocation = $("select[id$='ddlLocation']").val().trim();

        var txtControllerID = $("select[id$='txtControllerID']").val().trim();
        var txtWeighdID = $("input[id$='txtWeighdID']").val().trim();

        var txtDeviceName = $("input[id$='txtDeviceName']").val().trim();
        var ddlTerminalType = $("select[id$='ddlTerminalType']").val().trim();

        var txtDoorID = $("input[id$='txtDoorID']").val().trim();
        var txtClientID = $("select[id$='txtClientID']").val().trim();

        var ddlTerminalID = $("select[id$='ddlTerminalID']").val().trim();
        var ddlSiteAllowed = $("select[id$='ddlSiteAllowed']").val();

        if (ddlgateid == "") {
            alert("Please Select Gate!");
            return false;
        }

        if (ddlLocation == "") {
            alert("Please Select Location!");
            return false;
        }

        if (txtControllerID == "") {
            alert("Please Enter Controller Id!");
            return false;
        }

        if (txtWeighdID == "") {
            alert("Please Enter Weighd Id!");
            return false;
        }

        if (txtDeviceName == "") {
            alert("Please Enter Device Name!");
            return false;
        }
        if (ddlTerminalType == "") {
            alert("Please Select Terminal Type!");
            return false;
        }
        if (txtDoorID == "") {
            alert("Please Enter Door Id!");
            return false;
        }
        if (txtClientID == "") {
            alert("Please Enter Client Id!");
            return false;
        }
        if (ddlTerminalID == "") {
            alert("Please Select Terminal Id!");
            return false;
        }
        if (ddlSiteAllowed == "") {
            alert("Please Select Site Allowed!");
            return false;
        }

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "Settingwebmethods.aspx/UpdateWeigndDevice",
            data: "{'ddlgateid':'" + ddlgateid + "','ddlLocation':'" + ddlLocation + "','txtControllerID':'" + txtControllerID + "','txtWeighdID':'" + txtWeighdID + "','txtDeviceName':'" + txtDeviceName + "','ddlTerminalType':'" + ddlTerminalType + "','txtDoorID':'" + txtDoorID + "','txtClientID':'" + txtClientID + "','ddlTerminalID':'" + ddlTerminalID + "','ID':" + ID + ",'ddlSiteAllowed':'" + ddlSiteAllowed + "'}",
            success: onsuccessUpdateTerminalInfo
        });
    }
    function onsuccessUpdateTerminalInfo(msg) {
        showSuccessMsg("Record Updated successfully!");
        clearfields();
        getTerminalInfos();
    }

    </script>
</asp:Content>

