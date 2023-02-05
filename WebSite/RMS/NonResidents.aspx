<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="NonResidents.aspx.cs" Inherits="RMS_NonResidents" EnableEventValidation="false" %>

<%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>




    <fieldset>

        <legend>Non Residents Search Criteria</legend>
        <table id="tblSearchCriteria" class="form">
            <tr>
                <td class="right" style="width: 10%;">Card/NIC:</td>
                <td style="width: 22%;">
                    <input type="text" id="txtCardNIC" />
                </td>
                <td class="right" style="width: 10%;">Department/Unit:</td>
                <td style="width: 22%;">
                    <asp:DropDownList ID="ddlDepartmentSearch" runat="server">
                    </asp:DropDownList>
                </td>
                <td class="right" style="width: 10%;">Designation:</td>
                <td>
                    <asp:DropDownList ID="ddlDesignationSearch" runat="server">
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td class="right" style="width: 10%;">Name:</td>
                <td style="width: 22%;">
                    <input type="text" class="alpha" id="txtNameSearch" />
                </td>
                <td class="right" style="width: 10%;">Status:</td>
                <td style="width: 22%;">
                    <asp:DropDownList ID="ddlStatusSearch" runat="server">
                        <asp:ListItem Text="All" Value=""></asp:ListItem>
                        <asp:ListItem Text="Active" Value="Active"></asp:ListItem>
                        <asp:ListItem Text="Inactive" Value="Inactive"></asp:ListItem>
                        <asp:ListItem Text="Black List" Value="BlackList"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td colspan="2" style="text-align: center">
                    <input type="button" id="btnSearch" class="btn" value="Search" onclick="getNonResidents();" />
                    <input type="button" id="btnClear" class="btn" value="Clear" onclick="clearSearchCriteria();" />
                </td>
            </tr>
        </table>
    </fieldset>

    <div style="padding: 10px;">
        <input type="button" id="btnAddNew" class="btn" value="Add Non Resident" onclick="addNewNonResident();" />
    </div>
    <fieldset id="fieldsetGrd" style="width: 97%;">
        <legend>Non Residents</legend>
        <div style="padding-bottom: 20px; max-height: 440px; overflow: auto;">
            <table class="dataTable">
                <thead>
                    <tr>
                        <%-- <th style="width:5%">Delete</th>--%>
                        <th id="thNonResidantActiveOrInActive">Action</th>
                        <th>Edit</th>
                        <th>Card #</th>
                        <th style="display: none">First Name</th>
                        <th style="display: none">Last Name</th>
                        <th>Name</th>
                        <th>CNIC #</th>
                        <th style="display: none">Relation</th>
                        <th style="display: none">Relation Name</th>
                        <th style="display: none">Current Address</th>
                        <th style="display: none">Permanent Address</th>
                        <th style="display: none">Department/Unit</th>
                        <th style="display: none">Category</th>
                        <th style="display: none">Rank</th>
                        <th style="display: none">Designation</th>
                        <th style="display: none">Phone Home</th>
                        <th style="display: none">Phone Office</th>
                        <th style="display: none">Mobile</th>
                        <th style="display: none">Religion</th>
                        <th style="display: none">Sect</th>
                        <th style="display: none">Caste</th>
                        <th style="display: none">Education</th>
                        <th style="display: none">Firm</th>
                        <th style="display: none">Firm Address</th>
                        <th style="display: none">Product</th>
                        <th style="display: none">Shop Keeper</th>
                        <th style="display: none">Market</th>
                        <th style="display: none">Witness 1</th>
                        <th style="display: none">Witness 1 Address</th>
                        <th style="display: none">Witness 2</th>
                        <th style="display: none">Witness 2 Address</th>
                        <th style="display: none">Authority</th>
                        <th style="display: none">Entry Date</th>
                        <th>Status</th>
                        <th>Photo</th>
                        <th>Detail</th>
                    </tr>
                </thead>
                <tbody id="tbodyNonResidents" style="background-color: white;">
                    <tr>
                        <td colspan="30">&nbsp;</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </fieldset>

    <div style="display: block;" id="divNonResidentForm">
        <fieldset>
            <legend>Personal</legend>
            <table class="form">
                <tr id="trClose">
                    <td style="text-align: right; border: none">
                        <div id="close">
                            <img src='../images/btn_close02.png' style="background: none repeat scroll 0 0 transparent; border: medium none; height: 32px; margin-top: -52px; position: absolute; width: 32px; cursor: pointer; right: 434px; left: 98%;"
                                alt="Close" onclick='return CloseModal();' />
                        </div>
                    </td>
                </tr>
                <tr style="line-height: 12px;">
                    <td class="right">Id:</td>
                    <td>
                        <input type="text" id="txtId" disabled="disabled" />
                        &nbsp;
                    </td>
                    <td>&nbsp;
                    </td>
                    <td rowspan="4">
                        <div style="float: right; margin-right: 0px;">
                            <cc1:AsyncFileUpload OnClientUploadComplete="uploadComplete2" runat="server" ID="AsyncFileUpload1"
                                Width="400px" UploaderStyle="Modern" ClientIDMode="AutoID" CompleteBackColor="White" UploadingBackColor="#CCFFFF"
                                ThrobberID="imgLoader" OnUploadedComplete="FileUploadComplete" ToolTip="Click Here" OnClientUploadStarted="uploadStarted" />
                            <asp:HiddenField ID="hdnPictureId" runat="server" />
                            <asp:Image ID="imgLoader" runat="server" ImageUrl="../images/loader.gif" /><br />
                            <br />
                        </div>
                        <div class="dummy" id="divdummyClass" style="float: right; margin-right: 100px;">
                            <img id="imgDisplay" alt="" src="" style="display: none; height: 100px; width: 100px;" />

                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="right">P No:</td>
                    <td>
                        <input type="text" id="txtCardNo" disabled="disabled" />
                    </td>
                </tr>
                <tr>
                    <td class="right">First Name:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtFirstName" class="req alpha" />
                    </td>
                </tr>
                <tr>
                    <td class="right">Last Name:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtLastName" class="req alpha" />
                    </td>
                </tr>
                <tr>
                    <td class="right" style="width: 20%;">CNIC:<span class="reqSpan">*</span></td>
                    <td style="width: 30%;">
                        <input type="text" id="txtNIC" class="req cnic" onblur="getNonResidentResultByCNIC();" />
                    </td>
                    <td class="right" style="width: 20%;">Present Address:</td>
                    <td style="width: 30%;">
                        <input type="text" id="txtCurrentAddress" />
                    </td>

                </tr>
                <tr>

                    <td class="right">Ranks/Appointment:</td>
                    <td>
                        <asp:DropDownList ID="ddlRanks" runat="server">
                        </asp:DropDownList>
                    </td>
                    <td class="right" style="display: none">Category:</td>
                    <td class="right">Phone Office:</td>
                    <td>
                        <asp:DropDownList ID="ddlCategory" runat="server" Style="display: none">
                        </asp:DropDownList>
                        <input type="text" id="txtPhoneOff" class="phone" />
                    </td>
                </tr>
                <tr>
                    <td class="right">Designation:</td>
                    <td>
                        <asp:DropDownList ID="ddlDesignation" runat="server">
                        </asp:DropDownList>
                    </td>
                    <td class="right">Phone Home:</td>
                    <td>
                        <input type="text" id="txtPhoneHome" class="phone" />
                    </td>

                </tr>
                <tr>
                    <td class="right">Division:<span class="reqSpan">*</span></td>
                    <td>
                        <asp:DropDownList ID="ddlDepartment" runat="server" class="req">
                        </asp:DropDownList>
                    </td>
                    <td class="right">Cell Phone:</td>
                    <td>
                        <input type="text" id="txtCellPhone" class="cell" />
                    </td>

                </tr>
                <tr>
                    <td class="right">Relation:</td>
                    <td>
                        <asp:DropDownList ID="ddlRelation" runat="server">
                        </asp:DropDownList>
                    </td>
                    <td class="right">Permanent Address:</td>
                    <td>
                        <input type="text" id="txtPermanentAddress" />
                    </td>

                </tr>

                <tr>
                    <td class="right">Relation Name:</td>
                    <td>
                        <input type="text" id="txtRelationName" class="alpha" />
                    </td>
                    <td class="right">Entry Date: <span class="reqSpan">*</span></td>
                    <td>

                        <asp:TextBox ID="txtEntryDate" CssClass="date req" runat="server" Style="width: 60%; float: left; margin-right: 5px;"></asp:TextBox>
                        <rjs:PopCalendar ID="Popcalendar2" Separator="/" Format="mm dd yyyy" Control="txtEntryDate" runat="server"
                            Font-Names="Tahoma" />
                    </td>
                </tr>



                <tr>
                    <td class="right">Religion:<span class="reqSpan">*</span></td>
                    <td>
                        <asp:DropDownList ID="ddlReligion" runat="server" class="req">
                        </asp:DropDownList>
                    </td>

                    <td class="right">Valid Upto:<span class="reqSpan">*</span></td>
                    <td>

                        <asp:TextBox ID="txtValidUpto" CssClass="date req" runat="server" Style="width: 60%; float: left; margin-right: 5px;"></asp:TextBox>
                        <rjs:PopCalendar ID="Popcalendar1" Separator="/" Format="mm dd yyyy" Control="txtValidUpto" runat="server"
                            Font-Names="Tahoma" />
                    </td>
                </tr>
                <tr>
                    <td class="right">Sect:</td>
                    <td>
                        <asp:DropDownList ID="ddlSect" runat="server">
                        </asp:DropDownList>
                        <%-- <input type="text" id="txtSect"  />--%>
                    </td>
                    <td class="right">Education:</td>
                    <td>
                        <asp:DropDownList ID="txtEducation" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="right">Caste:</td>
                    <td>
                        <asp:DropDownList ID="ddlCast" runat="server">
                        </asp:DropDownList>
                    </td>
                    <td class="right">Card Category:<span class="reqSpan">*</span></td>
                    <td>
                        <asp:DropDownList ID="ddlCardCategory" CssClass="req" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>

                <tr>
                    <td class="right">Section:</td>
                    <td>
                        <input type="text" id="txtSection" class="alpha" />
                    </td>
                    <td class="right">clearance Status:<span class="reqSpan">*</span></td>
                    <td>
                        <asp:DropDownList ID="ddlclearanceStatus" CssClass="req" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="right">Father Name:</td>
                    <td>
                        <input type="text" id="txtFatherName" class="alpha" />
                    </td>
                    <td class="right">Mother Name:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtMotherName" class="alpha" />
                    </td>
                </tr>
                <tr>
                    <td class="right">Blood Group:</td>
                    <td>
                        <input type="text" id="txtBloodGroup" class="alpha" />
                    </td>
                    <td class="right">Cadre:<span class="reqSpan">*</span></td>
                    <td>
                        <asp:DropDownList ID="ddlCadre" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="right">Card Color:</td>
                    <td>
                        <input type="text" id="txtCardColor" class="alpha" />
                    </td>
                    <td class="right">Resident Status:<span class="reqSpan">*</span></td>
                    <td>
                        <asp:DropDownList ID="ddlResidant" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="right">Transport:</td>
                    <td>
                        <asp:DropDownList ID="ddlTransport" runat="server">
                        </asp:DropDownList>
                    </td>
                    <td class="right">Site Allowed:</td>
                    <td>
                        <asp:DropDownList ID="ddlSiteAllowed" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
        </fieldset>
        <fieldset id="fldWitnesses">
            <legend>Witnesses</legend>
            <table class="form">
                <tr>
                    <td class="right" style="width: 20%;">Witness #1:</td>
                    <td style="width: 30%;">
                        <input type="text" id="txtWitness1Name" class="alpha" />
                    </td>
                    <td class="right" style="width: 20%;">Witness #1 Address:</td>
                    <td style="width: 30%;">
                        <input type="text" id="txtWitness1Add" />
                    </td>
                </tr>
                <tr>
                    <td class="right">Witness #2:</td>
                    <td>
                        <input type="text" id="txtWitness2Name" class="alpha" />
                    </td>
                    <td class="right">Witness #2 Address:</td>
                    <td>
                        <input type="text" id="txtWitness2Add" />
                    </td>
                </tr>
                <tr>
                    <td class="right">Firm:</td>
                    <td>
                        <input type="text" id="txtFirm" />
                    </td>
                    <td class="right">Shop Keeper:</td>
                    <td>
                        <input type="text" id="txtShopKeeper" />
                    </td>
                </tr>
                <tr>
                    <td class="right">Product/Service:</td>
                    <td>
                        <input type="text" id="txtProduct" />
                    </td>
                    <td class="right">Supplier Address:</td>
                    <td>
                        <input type="text" id="txtSuppplierAdd" />
                    </td>
                </tr>
                <tr>
                    <td class="right">Market:</td>
                    <td>
                        <input type="text" id="txtMarket" />
                    </td>
                    <td class="right">Authority:</td>
                    <td>
                        <input type="text" id="txtAuthority" class="alpha" />
                    </td>
                </tr>
            </table>
        </fieldset>

        <div class="btn-wrapper" style="padding-top: 20px;" id="divSaveAndClearButtons">
            <input type="button" id="btnSave" class="btn" value="Save" onclick="saveNonResidenet();" />
            <input type="button" id="btnNew" class="btn" value="New" onclick="addNewNonResident();" />
        </div>

    </div>

    <script type="text/javascript">
        //------------------------------------------------------start  get Nonresident result on the basis of CNIC--------------

        function getNonResidentResultByCNIC() {
            var NRCNIC = $("input[id$='txtNIC']").val();
            if ($("input[id$='txtId']").val() == "") {
                if ($("input[id$='txtNIC']").val().indexOf('_') < 0) {


                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../RMS/RMSwebmethods.aspx/GetNonresidentResultByCNIC",
                        data: "{'NRCNIC':'" + NRCNIC + "'}",
                        success: onsuccessGetNonResidentResult,
                        error: onErrorGetnonresidentResult
                    });
                    return false;

                }



                else
                    return false;

            }


        }

        function onsuccessGetNonResidentResult(msg) {
            var data = msg.d;
            var result = data.GetNonresidentCountTable[0].Counts;
            if (parseInt(result) > 0) {
                alert("Non Resident already exist!");
                $("input[id$='txtNIC']").val("");
                return false;
            }
        }

        function onErrorGetnonresidentResult() {


        }



        //--------------------------------------------------End of Nonresident result-----------------

        $(document).ready(function () {
            showModelPopUp();
            getNonResidents();
        });
        function showModelPopUp() {
            // Get the modal
            var modal = document.getElementById('myModal');

            // Get the button that opens the modal
            var btn = document.getElementById("myBtn");

            // Get the <span> element that closes the modal
            var span = document.getElementsByClassName("close")[0];

            // When the user clicks the button, open the modal 
            btn.onclick = function () {
                modal.style.display = "block";
            }

            // When the user clicks on <span> (x), close the modal
            span.onclick = function () {
                modal.style.display = "none";
            }

            // When the user clicks anywhere outside of the modal, close it
            window.onclick = function (event) {
                if (event.target == modal) {
                    modal.style.display = "none";
                }
            }
        }
        function readCookie(name) {
            var nameEQ = name + "=";
            var ca = document.cookie.split(';');
            for (var i = 0; i < ca.length; i++) {
                var c = ca[i];
                while (c.charAt(0) == ' ') c = c.substring(1, c.length);
                if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
            }
            return null;
        }
        function uploadStarted() {
            $get("imgDisplay").style.display = "none";
        }
        function uploadComplete2(sender, args) {

            //var a = $("input[id$='txtimangeName']").val();
            //alert(a+ "ha ja" )

            var name = readCookie("tabs").replace("url=", "");
            //alert(name + " Kuch nai bhai");
            var imgDisplay = $get("imgDisplay");
            imgDisplay.src = "../images/loader.gif";
            imgDisplay.style.cssText = "";
            var img = new Image();
            img.onload = function () {
                imgDisplay.style.cssText = "height:100px;width:100px";
                imgDisplay.src = img.src;
            };

            $("#divdummyClass").removeClass("dummy");


            img.src = "<%=ResolveUrl(UploadFolderPath) %>" + name + ".jpg";// args.get_fileName();
            $("input[id$='hdnPictureId']").val(name);

        }
        function ShowDetails_Modal(NRID, elm, flag) {



            editNonResident(NRID, elm, flag);

        }
        function CloseModal() {
            //  Clear_Details();
            // alert("test");
            $("#divNonResidentForm").jqmHide();
            $(".jqmWindow input, select").attr("disabled", false);
            return false;
        }

        function getNonResidents() {
            $("#fieldsetGrd").show();
            $("#divNonResidentForm").hide();

            $.post("../RMS/CallBack/NonResidentsHandler.aspx", { NIC: $("#txtCardNIC").val(), Dept: $("[id$='ddlDepartmentSearch']").val(), Desg: $("[id$='ddlDesignationSearch']").val(), Name: $("#txtNameSearch").val(), Status: $("[id$='ddlStatusSearch']").val() }).done(function (data) {
                var response = data;
                var start = data.indexOf("#StartNonResident#") + 18;
                var end = data.indexOf("#EndNonResident#");
                $("#tbodyNonResidents").html(response.substring(start, end));

                if ($("#tbodyNonResidents tr").length == 0) {
                    $("#tbodyNonResidents").html("<tr><td class='noRecordFound' colspan='29'>No Record Found</td></tr>");
                }

                //  alert($("#tbodyNonResidents tr").length);
                if ($("select[id$='ddlStatusSearch']").val() == "Active") {
                    $("#thNonResidantActiveOrInActive").html("Active");
                    $(".tdNonResidentInActive").css("display", "inline-block");
                    $(".tdNonResidentActive").css("display", "none");


                }
                else if ($("select[id$='ddlStatusSearch']").val() == "Inactive") {
                    $("#thNonResidantActiveOrInActive").html("Inactive List")
                    $(".tdNonResidentInActive").css("display", "none");
                    $(".tdNonResidentActive").css("display", "inline-block");
                }
                else {
                    // for (i = 0; i <= $("#tbodyNonResidents tr").length; i++)
                    $("#tbodyNonResidents tr").each(function () {
                        if ($(this).find('.status').html() == "Active") {
                            $(this).find(".tdNonResidentInActive").css("display", "inline-block");
                            $(this).find(".tdNonResidentBlackList").css("display", "inline-block");
                            $(this).find(".tdNonResidentActive").css("display", "none");
                        }
                        else if ($(this).find('.status').html() == "InActive") {
                            $(this).find(".tdNonResidentActive").css("display", "inline-block");
                            $(this).find(".tdNonResidentBlackList").css("display", "inline-block");
                            $(this).find(".tdNonResidentInActive").css("display", "none");
                        }

                        else {
                            $(this).find(".tdNonResidentBlackList").css("display", "none");
                            $(this).find(".tdNonResidentBlackList").parent().parent().css("color", "Red");
                            $(this).find(".tdNonResidentBlackList").parent().parent().css("font-weight", "bold");
                            $(this).find(".tdNonResidentActive").css("display", "inline-block");
                            $(this).find(".tdNonResidentInActive").css("display", "inline-block");
                        }


                    });
                    // alert($("#tbodyNonResidents tr").find('.status').html());
                }
            });
        }
        function saveNonResidenet() {

            if ($("input[id$='hdnPictureId']").val().indexOf(":") >= 0) {
                $("input[id$='hdnPictureId']").val("");

            }
            if (!validate("divNonResidentForm")) {
                var nrid = $.trim($("[id$='txtId']").val()) == "" ? 0 : $.trim($("[id$='txtId']").val());

                var request = "{"
                    + "'NRID':'" + nrid + "',"
                    + "'FirstName':'" + $.trim($("[id$='txtFirstName']").val()) + "',"
                    + "'LastName':'" + $.trim($("[id$='txtLastName']").val()) + "',"
                    + "'NIC':'" + $.trim($("[id$='txtNIC']").val()) + "',"
                    + "'CurrAddr':'" + $.trim($("[id$='txtCurrentAddress']").val()) + "',"
                    + "'Rel':'" + $.trim($("[id$='ddlRelation']").val()) + "',"
                    + "'PerAddr':'" + $.trim($("[id$='txtPermanentAddress']").val()) + "',"
                    + "'RelName':'" + $.trim($("[id$='txtRelationName']").val()) + "',"
                    + "'PhoneOffice':'" + $.trim($("[id$='txtPhoneOff']").val()) + "',"
                    + "'PCategory':'" + $.trim($("[id$='ddlCategory']").val()) + "',"
                    + "'Ranks':'" + $.trim($("[id$='ddlRanks']").val()) + "',"
                    + "'Designation':'" + $.trim($("[id$='ddlDesignation']").val()) + "',"

                    + "'PhoneHome':'" + $.trim($("[id$='txtPhoneHome']").val()) + "',"
                    + "'Department':'" + $.trim($("[id$='ddlDepartment']").val()) + "',"
                    + "'Mobile':'" + $.trim($("[id$='txtCellPhone']").val()) + "',"
                    + "'Religion':'" + $.trim($("[id$='ddlReligion']").val()) + "',"
                    + "'DateofEntry':'" + $.trim($("[id$='txtEntryDate']").val()) + "',"
                    + "'ValidUptoDate':'" + $.trim($("[id$='txtValidUpto']").val()) + "',"
                    + "'Sectt':'" + $.trim($("[id$='ddlSect']").val()) + "',"
                    + "'Education':'" + $.trim($("[id$='txtEducation']").val()) + "',"
                    + "'Caste':'" + $.trim($("[id$='ddlCast']").val()) + "',"
                    + "'Witness1Name':'" + $.trim($("[id$='txtWitness1Name']").val()) + "',"
                    + "'Witness1Addr':'" + $.trim($("[id$='txtWitness1Add']").val()) + "',"
                    + "'Witness2Name':'" + $.trim($("[id$='txtWitness2Name']").val()) + "',"
                    + "'Witness2Addr':'" + $.trim($("[id$='txtWitness2Add']").val()) + "',"
                    + "'Firm':'" + $.trim($("[id$='txtFirm']").val()) + "',"
                    + "'ShopKeeper':'" + $.trim($("[id$='txtShopKeeper']").val()) + "',"
                    + "'Product':'" + $.trim($("[id$='txtProduct']").val()) + "',"
                    + "'FirmAddr':'" + $.trim($("[id$='txtSuppplierAdd']").val()) + "',"
                    + "'Market':'" + $.trim($("[id$='txtMarket']").val()) + "',"
                    + "'Authority':'" + $.trim($("[id$='txtAuthority']").val()) + "',"
                    + "'Photo':'" + $("input[id$='hdnPictureId']").val() + "',"
                    + "'cardPrefix':'" + $("select[id$='ddlCardCategory']").val() + "'"
                    + "}";

                $.ajax({
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json",
                    url: "../RMS/RMSWebMethod.aspx/SaveNonResident",
                    data: request,
                    success: function (data) {
                        showSuccessMsg("Information saved successfully!");
                        getNonResidents();
                        $("#txtId").val(data.d);


                    }
                });
            }
        }
        function editNonResident(nrid, elm, flag) {


            if (flag == '1') {
                $('#divNonResidentForm').addClass("jqmWindow");
                $(".jqmWindow input, select").attr("disabled", true);
                $("img[src$='Calendar.gif']").hide();
                $('#divNonResidentForm').css("margin-left", "-44%");
                $('#divNonResidentForm').css("width", "86%");
                $('#trClose').show();
                $("img[src$='btn_close02.png']").show();
                $("#fldWitnesses").css("margin-top", "-1%");
                $("#fldWitnesses legend").hide();
                $("#divSaveAndClearButtons").hide();
                $("div[id*='AsyncFileUpload1']").hide();
                $('#divNonResidentForm').jqm({ modal: true, overlay: 75, trigger: false });
                $('#divNonResidentForm').jqmShow();
            }
            else {
                $('#divNonResidentForm').css("margin-left", "0%");
                $('#divNonResidentForm').css("width", "97%");
                $('#trClose').hide();
                $("img[src$='btn_close02.png']").hide();
                $("#fldWitnesses").css("margin-top", "");
                $("#fldWitnesses legend").show();
                $("#divSaveAndClearButtons").show();
                $("div[id*='AsyncFileUpload1']").show();
                $('#divNonResidentForm').removeClass("jqmWindow");
                $(".jqmWindow input, select").attr("disabled", false);
                $("img[src$='Calendar.gif']").show();
            }

            $("#divNonResidentForm input[type=text]").val("");
            $("#divNonResidentForm select").val("");
            $("[id$='txtId']").val("0");
            $("#divNonResidentForm").show();
            $("div[id*='AsyncFileUpload1']").css("width", "400px");
            $("input[id*='AsyncFileUpload1']").val("");
            $("div[id*='AsyncFileUpload1']").css("margin-top", "-34px");
            $("input[id*='AsyncFileUpload1']").css("background-color", "");
            // $("input[id$='hdnPictureId']").val("");
            $("img[id$='imgDisplay']").hide();
            $("#divdummyClass").addClass("dummy");
            $("[id$='txtId']").val(nrid);
            $("[id$='txtCardNo']").val($.trim($(elm).closest("tr").find(".cardNo").html()));
            $("[id$='txtFirstName']").val($.trim($(elm).closest("tr").find(".fn").html()));
            $("[id$='txtLastName']").val($.trim($(elm).closest("tr").find(".ln").html()));
            $("[id$='txtNIC']").val($.trim($(elm).closest("tr").find(".nic").html()));
            $("[id$='txtCurrentAddress']").val($.trim($(elm).closest("tr").find(".cAdd").html()));
            $("[id$='ddlRelation']").val($.trim($(elm).closest("tr").find(".rel").html()));
            $("[id$='txtPermanentAddress']").val($.trim($(elm).closest("tr").find(".pAdd").html()));
            $("[id$='txtRelationName']").val($.trim($(elm).closest("tr").find(".relName").html()));
            $("[id$='txtPhoneOff']").val($.trim($(elm).closest("tr").find(".pOffc").html()));

            $("[id$='ddlCategory']").val($.trim($(elm).closest("tr").find(".pcat").html()));

            $("[id$='ddlRanks']").val($.trim($(elm).closest("tr").find(".rnk").html()));
            $("[id$='ddlDesignation']").val($.trim($(elm).closest("tr").find(".desg").html()));
            $("[id$='txtPhoneHome']").val($.trim($(elm).closest("tr").find(".pHome").html()));
            $("[id$='ddlDepartment']").val($.trim($(elm).closest("tr").find(".dept").html()));
            $("[id$='txtCellPhone']").val($.trim($(elm).closest("tr").find(".mobile").html()));
            $("[id$='ddlReligion']").val($.trim($(elm).closest("tr").find(".religion").html()));
            $("[id$='txtEntryDate']").val($.trim($(elm).closest("tr").find(".doe").html()));
            $("[id$='txtValidUpto']").val($.trim($(elm).closest("tr").find(".dor").html()));
            $("[id$='ddlSect']").val($.trim($(elm).closest("tr").find(".sectt").html()));
            $("[id$='txtEducation']").val($.trim($(elm).closest("tr").find(".edu").html()));
            $("[id$='ddlCast']").val($.trim($(elm).closest("tr").find(".caste").html()));
            $("[id$='txtWitness1Name']").val($.trim($(elm).closest("tr").find(".witness1Name").html()));
            $("[id$='txtWitness1Add']").val($.trim($(elm).closest("tr").find(".witnes1Add").html()));
            $("[id$='txtWitness2Name']").val($.trim($(elm).closest("tr").find(".witness2Name").html()));
            $("[id$='txtWitness2Add']").val($.trim($(elm).closest("tr").find(".witness2Add").html()));
            $("[id$='txtFirm']").val($.trim($(elm).closest("tr").find(".firm").html()));
            $("[id$='txtShopKeeper']").val($.trim($(elm).closest("tr").find(".shopKp").html()));
            $("[id$='txtProduct']").val($.trim($(elm).closest("tr").find(".product").html()));
            $("[id$='txtSuppplierAdd']").val($.trim($(elm).closest("tr").find(".firmAdd").html()));
            $("[id$='txtMarket']").val($.trim($(elm).closest("tr").find(".market").html()));
            $("[id$='txtAuthority']").val($.trim($(elm).closest("tr").find(".auth").html()));
            var str = $(elm).closest("tr").find(".photo img").attr("src");
            // alert("this is test new");
            var last = str.substring(str.lastIndexOf("/") + 1, str.length);

            if (last.split('.')[0] != "") {
                $("#imgDisplay").attr("src", str);
                $("input[id$='hdnPictureId']").val(last.split('.')[0])
                $("#imgDisplay").show();
                $("#divdummyClass").removeClass("dummy");
            }
            else {
                $("#imgDisplay").hide();
                $("#divdummyClass").addClass("dummy");
            }

            var CardPrefix = $.trim($(elm).closest("tr").find(".cardNo").html());
            CardPrefix = CardPrefix.split('-')[0];
            $("select[id$='ddlCardCategory']").val(CardPrefix);
            // $("select[id$='ddlCardCategory']").attr("disabled", true);
            //alert($.trim($(elm).closest("tr").find(".rnk").html()) + "ddd");
            // getRanks($.trim($(elm).closest("tr").find(".rnk").html()));

        }
        function addNewNonResident() {
            //$("select[id$='ddlRanks']").html("");
            // $("select[id$='ddlRanks']").text("");

            //$("select[id$='ddlDesignation']").html("");
            //$("select[id$='ddlDesignation']").text("");

            $("#divNonResidentForm").show();

            $("img[src$='btn_close02.png']").hide();
            $('#divNonResidentForm').css("margin-left", "0%");
            $('#divNonResidentForm').css("width", "97%");
            $('#trClose').hide();
            $("#fldWitnesses").css("margin-top", "");
            $("#fldWitnesses legend").show();
            $("#divSaveAndClearButtons").show();
            $("div[id*='AsyncFileUpload1']").show();
            $('#divNonResidentForm').removeClass("jqmWindow");
            $(".jqmWindow input, select").attr("disabled", false);
            $("img[src$='Calendar.gif']").show();
            $("div[id*='AsyncFileUpload1']").css("width", "400px");
            $("input[id*='AsyncFileUpload1']").val("");
            $("div[id*='AsyncFileUpload1']").css("margin-top", "-34px");
            $("input[id*='AsyncFileUpload1']").css("background-color", "");
            $("input[id$='hdnPictureId']").val("");
            $("img[id$='imgDisplay']").hide();
            $("#divdummyClass").addClass("dummy");
            $("#divNonResidentForm input[type=text]").val("");
            $("#divNonResidentForm select").val("");
        }
        function clearSearchCriteria() {
            $("#tblSearchCriteria input[type=text]").val("");
            $("#tblSearchCriteria select").val("");
        }




        //---------------------------------------------InActive Non Resident Record------------------------------------------
        function InActiveNonResident(NRID) {

            if (confirm("Are you sure you wish to Inactive this User?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../RMS/RMSWebMethod.aspx/DeleteNonResidentEmployeeRecord",
                    data: "{'NRID':'" + NRID + "'}",
                    success: onsuccessDeleteNonResidentsEmployeeRecord
                });

                return false;
            }
            else
                return false;
        }


        function onsuccessDeleteNonResidentsEmployeeRecord(msg) {
            //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("User has been Inactive Successfully!");
            getNonResidents()
            return false;
        }



        //-----------------------------------------------end-------------------------------------------------------------


        //---------------------------------------------Activate Non Resident Record------------------------------------------
        function ActivateNonResident(NRID) {

            if (confirm("Are you sure you wish to Activate this User?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../RMS/RMSWebMethod.aspx/ActivateNonResidentRecord",
                    data: "{'NRID':'" + NRID + "'}",
                    success: onsuccessDeleteNonResidentsEmployeeRecord
                });

                return false;
            }
            else
                return false;
        }


        function onsuccessDeleteNonResidentsEmployeeRecord(msg) {
            //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("User has been Activated Successfully!");
            getNonResidents()
            return false;
        }

        //----------------------------------------Black List Non Resident---------------------------------------------------------------------------------------

        function BlackListNonResident(NRID) {
            if (confirm("Are you sure you wish to Black List this User?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../RMS/RMSWebMethod.aspx/BlackListNonResidentRecord",
                    data: "{'NRID':'" + NRID + "'}",
                    success: onsuccessBlackListNonResident
                });

                return false;
            }
            else
                return false;
        }


        function onsuccessBlackListNonResident(msg) {
            //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("User has been Black Listed Successfully!");
            getNonResidents()
            return false;
        }

        //-----------------------------------------------Get Rankas on the basis of change the category dropdown list-------------------------------------------------------------
        var rankIds = '';
        function getRanks(rankId) {
            // $("select[id$='ddlRanks']").html("");
            // $("select[id$='ddlRanks']").text("");
            rankIds = rankId;
            var catVal = $("select[id$='ddlCategory']").val();
            if (catVal.trim() != "") {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../RMS/RMSWebMethod.aspx/getRanks",
                    data: "{'catVal':'" + catVal + "'}",
                    success: onsuccessGetRanks
                });
            }
        }

        function onsuccessGetRanks(msg) {

            var data = msg.d;
            var catop = "";
            for (var i = 0; i < data.RanksDetail.length; i++) {
                catop += "<option value='" + data.RanksDetail[i].Rank_ID + "'>" + data.RanksDetail[i].Rank_Name + "</option>";
            }
            if (rankIds != '') {

                $("select[id$='ddlRanks']").append(catop);
                $("select[id$='ddlRanks']").val(rankIds);
            }

            else
                $("select[id$='ddlRanks']").append(catop);

            getDesignation();


        }

        function getDesignation() {

            var catVal = $("select[id$='ddlCategory']").val();
            if (catVal == '1' || catVal == '2') {
                catVal = '1,2';
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../RMS/RMSWebMethod.aspx/getDesignation",
                data: "{'catVal':'" + catVal + "'}",
                success: onsuccessGetDesignation
            });
        }

        function onsuccessGetDesignation(msg) {

            //$("select[id$='ddlDesignation']").html("");
            //$("select[id$='ddlDesignation']").text("")
            var data = msg.d;
            var catop = "";
            for (var i = 0; i < data.DesignationDetail.length; i++) {
                catop += "<option value='" + data.DesignationDetail[i].Designation_ID + "'>" + data.DesignationDetail[i].designation + "</option>";
            }
            $("select[id$='ddlDesignation']").append(catop);


        }

        //------------------------------------------------------------------------End-----------------------------------------------------------------------------------
    </script>

</asp:Content>

