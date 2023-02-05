<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="Servant.aspx.cs" Inherits="Residents_Servant" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <fieldset>
        <legend>Residents Search Criteria</legend>
        <table id="tblSearchCriteria" class="form">
            <tr>
                <td class="right" style="width: 10%;">Card/NIC:</td>
                <td style="width: 22%;">
                    <input type="text" id="txtCardNIC" />
                </td>
                <td class="right" style="width: 10%;">Department:</td>
                <td style="width: 22%;">
                    <asp:DropDownList ID="ddlDepartmentSearch" runat="server">
                        <asp:ListItem></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="right" style="width: 10%;">Designation:</td>
                <td>
                    <asp:DropDownList ID="ddlDesignationSearch" runat="server">
                        <asp:ListItem></asp:ListItem>
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td class="right" style="width: 10%;">Name:</td>
                <td style="width: 22%;">
                    <input type="text" id="txtNameSearch" />
                </td>
                <td class="right" style="width: 10%;">Status:</td>
                <td style="width: 22%;">
                    <asp:DropDownList ID="ddlStatusSearch" runat="server">
                        <asp:ListItem Text="Active" Value="1"></asp:ListItem>
                        <asp:ListItem Text="Inactive" Value="0"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td colspan="2" style="text-align: center">
                    <input type="button" id="btnSearch" class="btn" value="Search" onclick="getResidents();" />
                    <input type="button" id="btnClear" class="btn" value="Clear" onclick="clearSearchCriteria();" />
                </td>
            </tr>
        </table>
    </fieldset>

    <div style="padding: 10px;">
        <input type="button" id="btnAddEmployee" class="btn" value="Add Employee" onclick="addNewEmployee();" />
    </div>

    <fieldset id="fieldsetPersonalGrd" style="width: 97%;">
        <legend>Residents</legend>

        <div style="padding-bottom: 20px; width: 1090px; max-height: 300px; overflow: auto;">
            <table class="dataTable">
                <thead>
                    <tr>
                        <th>Edit</th>
                        <th>Family Members</th>
                        <th>Service/PNO</th>
                        <th>Card #</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Rank</th>
                        <th>NIC</th>
                        <th>Location</th>
                        <th>Department</th>
                        <th>AllotmentDate</th>
                        <th>ReleaseDate</th>
                        <th>Cell #</th>
                        <th>Phone Office</th>
                        <th>Phone Home</th>
                        <th>Current Address</th>
                        <th>Permanent Address</th>
                    </tr>
                </thead>
                <tbody id="tbodyResidents">
                    <tr>
                        <td colspan="17">&nbsp;</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </fieldset>


    <fieldset id="fieldsetPersonal" style="display: none;">
        <legend>Personal</legend>
        <table id="tblPersonal" class="form">
            <tr>
                <td class="right">Id:</td>
                <td>
                    <input type="text" id="txtId" disabled="disabled" />
                </td>

                <td colspan="2" rowspan="4">
                    <div class="dummy" style="float: right; margin-right: 100px;"></div>
                </td>
            </tr>
            <tr>
                <td class="right">Card No:</td>
                <td>
                    <input type="text" id="txtCardNo" disabled="disabled" />
                </td>

            </tr>
            <tr>
                <td class="right">Service Code/PNO:</td>
                <td>
                    <input type="text" id="txtPNO" class="req" />
                </td>
            </tr>
            <tr>

                <td class="right">First Name:<span class="reqSpan">*</span></td>
                <td>
                    <input type="text" id="txtFirstName" class="req" />
                </td>

            </tr>
            <tr>
                <td class="right" style="width: 20%;">Last Name:<span class="reqSpan">*</span></td>
                <td style="width: 30%;">
                    <input type="text" id="txtLastName" class="req" />
                </td>

                <td class="right" style="width: 20%;">Allotment Date:</td>
                <td style="width: 30%;">
                    <input type="text" id="txtAllotmentDate" />
                </td>

            </tr>
            <tr>
                <td class="right">NIC:<span class="reqSpan">*</span></td>
                <td>
                    <input type="text" id="txtNIC" class="req" />
                </td>
                <td class="right">Validity Upto:</td>
                <td>
                    <input type="text" id="txtValidity" />
                </td>


            </tr>
            <tr>
                <td class="right">Rank:</td>
                <td>
                    <asp:DropDownList ID="ddlRank" runat="server">
                        <asp:ListItem Text="D Admin NHQ" Value="D Admin NHQ"></asp:ListItem>
                    </asp:DropDownList>
                </td>

                <td class="right">Current Address:<span class="reqSpan">*</span></td>
                <td>
                    <input type="text" id="txtCurrentAdd" class="req" />
                </td>



            </tr>
            <tr>
                <td class="right">Department/Unit:</td>
                <td>
                    <asp:DropDownList ID="ddlDeptUnit" runat="server">
                        <asp:ListItem Text="D Admin NHQ" Value="D Admin NHQ"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="right">Permanent Address:<span class="reqSpan">*</span></td>
                <td>
                    <input type="text" id="txtPermanentAdd" class="req" />
                </td>


            </tr>
            <tr>
                <%--<td class="right">Card Type:<span class="reqSpan">*</span></td>
                    <td>
                        <asp:DropDownList ID="ddlCardType" runat="server" class="req">
                            <asp:ListItem Text="Resident" Value="Resident"></asp:ListItem>
                        </asp:DropDownList>
                    </td>--%>
                <td class="right">Near Location:</td>
                <td>
                    <asp:DropDownList ID="ddlNearLoc" runat="server">
                        <asp:ListItem Text="Zafar Gate" Value="Zafar Gate"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="right">Cell Phone:</td>
                <td>
                    <input type="text" id="txtCellPhone" />
                </td>

            </tr>
            <tr>
                <td class="right">DOB:</td>
                <td>
                    <input type="text" id="txtDOB" />
                </td>
                <td class="right">Phone Office:</td>
                <td>
                    <input type="text" id="txtPhoneOffice" />
                </td>
            </tr>
            <tr>

                <td class="right">Marital Status:</td>
                <td>
                    <asp:DropDownList ID="ddlMaritalStatus" runat="server">
                        <asp:ListItem Text="" Value=""></asp:ListItem>
                        <asp:ListItem Text="Single" Value="Single"></asp:ListItem>
                        <asp:ListItem Text="Married" Value="Married"></asp:ListItem>
                        <asp:ListItem Text="Widow" Value="Widow"></asp:ListItem>
                        <asp:ListItem Text="Seprated" Value="Seprated"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="right">Phone Home:</td>
                <td>
                    <input type="text" id="txtPhoneHome" />
                </td>

            </tr>
            <tr>
                <td class="right">Job Location:</td>
                <td>
                    <input type="text" id="txtJobLoc" />
                </td>

            </tr>
        </table>

        <div class="btn-wrapper" style="padding-top: 20px;">
            <input type="button" id="btnSaveResident" class="btn" value="Save" onclick="saveResidenet();" />
            <input type="hidden" id="hdnEID" runat="server" value="0" />
        </div>

    </fieldset>
    <fieldset id="fieldsetFM" style="display: none;">
        <legend>Family Member / Servant</legend>

        <table id="tblFamilyMember" class="form">
            <tr>
                <td class="right">First Name:<span class="reqSpan">*</span></td>
                <td>
                    <input type="text" id="txtFirstNameFS" class="req" />
                </td>
                <td colspan="2" rowspan="3">
                    <div class="dummy" style="float: right; margin-right: 100px;"></div>
                </td>

            </tr>
            <tr>
                <td class="right">Last Name:<span class="reqSpan">*</span></td>
                <td>
                    <input type="text" id="txtLastNameFS" class="req" />
                </td>

            </tr>
            <tr>
                <td class="right">Relation:<span class="reqSpan">*</span></td>
                <td>
                    <asp:DropDownList ID="ddlRelationFS" runat="server" class="req">
                        <asp:ListItem Text="Daughter" Value="Daughter"></asp:ListItem>
                    </asp:DropDownList>
                </td>

            </tr>
            <tr>
                <td class="right" style="width: 20%;">Father/Husband:</td>
                <td style="width: 30%;">
                    <input type="text" id="txtFatherHusbandFS" />
                </td>
                <td class="right" style="width: 20%;">NIC:</td>
                <td style="width: 30%;">
                    <input type="text" id="txtNICFS" />
                </td>
            </tr>
            <tr>
                <td class="right">Visit Purpose:</td>
                <td>
                    <input type="text" id="txtVisitPurpose" />
                </td>
                <td class="right">Cell No:</td>
                <td>
                    <input type="text" id="txtCellNoFS" />
                </td>
            </tr>
            <tr>
                <td class="right">Card #:</td>
                <td>
                    <input type="text" id="txtCardNoFS" disabled="disabled" />
                </td>

                <td class="right">Vistor Address:<span class="reqSpan">*</span></td>
                <td>
                    <input type="text" id="txtVisitorAdd" class="req" />
                </td>
            </tr>
        </table>
        <div class="btn-wrapper" style="padding-top: 20px;">
            <input type="button" id="btnSaveFamilyMember" class="btn" value="Save" onclick="saveFamilyMember();" />
            <input type="hidden" id="hdnEFID" runat="server" value="0" />
        </div>
    </fieldset>
    <fieldset id="fieldsetFMGrd" style="display: none; width: 97%;">
        <legend>Family Members / Servant</legend>
        <div style="padding: 10px;">
            <input type="button" id="btnAddFM" class="btn" value="Add Family Member / Servant" onclick="addNewFM();" />
        </div>
        <div style="padding-bottom: 20px; width: 950px; max-height: 300px; overflow: auto;">
            <table class="dataTable">
                <thead>
                    <tr>
                        <th>Edit</th>
                        <th>Card #</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Relation</th>
                        <th>NIC</th>
                        <th>Mobile</th>
                        <th>Address</th>
                        <th>Visit Purpose</th>
                    </tr>
                </thead>
                <tbody id="tbodyFM">
                </tbody>
            </table>
        </div>
    </fieldset>
    <script type="text/javascript">
        function getResidents() {
            $("#fieldsetPersonalGrd").show();
            $("#fieldsetPersonal").hide();
            $("#fieldsetFM").hide();
            $("#fieldsetFMGrd").hide();

            $.post("../RMS/CallBack/ResidentsHandler.aspx", { NIC: $("#txtCardNIC").val(), Dept: $("[id$='ddlDepartmentSearch']").val(), Desg: $("[id$='ddlDesignationSearch']").val(), Name: $("#txtNameSearch").val(), Status: $("[id$='ddlStatusSearch']").val() }).done(function (data) {
                var response = data;
                var start = data.indexOf("#StartResident#") + 15;
                var end = data.indexOf("#EndResident#");
                $("#tbodyResidents").html(response.substring(start, end));

                if ($("#tbodyResidents tr").length == 0) {
                    $("#tbodyResidents").html("<tr><td class='noRecordFound' colspan='17'>No Record Found</td></tr>");
                }
            });
        }
        function getFamilyMembers(eid, fmCount, callFrom) {
            if (fmCount != "0") {
                $.post("../RMS/CallBack/FamilyMembersHandler.aspx", { EID: eid, Status: 1 }).done(function (data) {
                    var response = data;
                    var start = data.indexOf("#StartFM#") + 9;
                    var end = data.indexOf("#EndFM#");
                    $("#tbodyFM").html(response.substring(start, end));
                    $("#fieldsetFMGrd").show();
                    if (callFrom == "Grid") {
                        $("#btnAddFM").show();
                    }
                    //$(elem).closest("tr").after("<tr class='familymember'><td colspan='17'><div style='padding: 5px;color: #005978;font-weight: bold;font-style: italic;'>Family Members</div> " + response.substring(start, end) + "</td></tr>");
                });
            }
            else {
                alert("No Family Members exist!");
            }

        }
        function saveResidenet() {
            if (!validate("tblPersonal")) {
                var request = "{"
                    + "'EID':'" + $.trim($("[id$='hdnEID']").val()) + "',"
                    + "'ServiceNo':'" + $.trim($("[id$='txtPNO']").val()) + "',"
                    + "'FirstName':'" + $.trim($("[id$='txtFirstName']").val()) + "',"
                    + "'LastName':'" + $.trim($("[id$='txtLastName']").val()) + "',"
                    + "'NIC':'" + $.trim($("[id$='txtNIC']").val()) + "',"
                    + "'Rank':'" + $.trim($("[id$='ddlRank']").val()) + "',"
                    + "'Department':'" + $.trim($("[id$='ddlDeptUnit']").val()) + "',"
                    + "'CurrAddr':'" + $.trim($("[id$='txtCurrentAdd']").val()) + "',"
                    + "'Location':'" + $.trim($("[id$='ddlNearLoc']").val()) + "',"
                    + "'PerAddr':'" + $.trim($("[id$='txtPermanentAdd']").val()) + "',"
                    + "'Mobile':'" + $.trim($("[id$='txtCellPhone']").val()) + "',"
                    + "'PhoneHome':'" + $.trim($("[id$='txtPhoneHome']").val()) + "',"
                    + "'AllotmentDate':'" + $.trim($("[id$='txtAllotmentDate']").val()) + "',"
                    + "'PhoneOffice':'" + $.trim($("[id$='txtPhoneOffice']").val()) + "',"
                    + "'Photo':''"
                    + "}";

                $.ajax({
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json",
                    url: "../RMS/RMSWebMethod.aspx/SaveResident",
                    data: request,
                    success: function (data) {
                        showSuccessMsg("Information saved successfully!");
                        $("[id$='hdnEID']").val(data.d);
                    }
                });
            }
        }
        function saveFamilyMember() {
            if ($.trim($("[id$='hdnEID']").val()) == "0") {
                showErrorMsg("Please save Personal Information first!");
                return false;
            }
            else {
                if (!validate("tblFamilyMember")) {
                    var request = "{"
                        + "'EFID':'" + $.trim($("[id$='hdnEFID']").val()) + "',"
                        + "'EID':'" + $.trim($("[id$='hdnEID']").val()) + "',"
                        + "'FirstName':'" + $.trim($("[id$='txtFirstNameFS']").val()) + "',"
                        + "'LastName':'" + $.trim($("[id$='txtLastNameFS']").val()) + "',"
                        + "'Relation':'" + $.trim($("[id$='ddlRelationFS']").val()) + "',"
                        //+ "'RoleId':'" + $.trim($("[id$='txtFatherHusbandFS']").val()) + "',"
                        + "'NIC':'" + $.trim($("[id$='txtNICFS']").val()) + "',"
                        + "'CardNumber':'" + $.trim($("[id$='txtCardNoFS']").val()) + "',"
                        + "'Mobile':'" + $.trim($("[id$='txtCellNoFS']").val()) + "',"
                        + "'vpurpose':'" + $.trim($("[id$='txtVisitPurpose']").val()) + "',"
                        + "'vaddr':'" + $.trim($("[id$='txtVisitorAdd']").val()) + "'"
                        + "}";

                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        url: "../RMS/RMSWebMethod.aspx/SaveFamilyMember",
                        data: request,
                        success: function () {
                            showSuccessMsg("Information saved successfully!");
                            $("#tblFamilyMember input[type=text]").val("");
                            $("#tblFamilyMember select").val("");
                            $("[id$='hdnEFID']").val("0");
                            getFamilyMembers($("[id$='hdnEID']").val(), 1);
                            $("#btnAddFM").hide();
                        }
                    });
                }
            }
        }
        function editResident(eid, elm) {
            $("#tblPersonal input[type=text]").val("");
            $("#tblPersonal select").val("");
            $("[id$='hdnEID']").val(eid);
            $("#txtId").val(eid);
            $("#txtPNO").val($.trim($(elm).closest("tr").find(".pno").html()));
            $("#txtFirstName").val($.trim($(elm).closest("tr").find(".fn").html()));
            $("#txtLastName").val($.trim($(elm).closest("tr").find(".ln").html()));
            $("#txtNIC").val($.trim($(elm).closest("tr").find(".nic").html()));
            $("[id$='ddlRank']").val($.trim($(elm).closest("tr").find(".rank").html()));
            $("#txtCurrentAdd").val($.trim($(elm).closest("tr").find(".cAdd").html()));
            $("[id$='ddlDeptUnit']").val($.trim($(elm).closest("tr").find(".dept").html()));
            $("#txtPermanentAdd").val($.trim($(elm).closest("tr").find(".pAdd").html()));
            $("[id$='ddlNearLoc']").val($.trim($(elm).closest("tr").find(".loc").html()));
            $("#txtCellPhone").val($.trim($(elm).closest("tr").find(".mob").html()));
            $("#txtCardNo").val($.trim($(elm).closest("tr").find(".cardNo").html()));
            $("#txtPhoneHome").val($.trim($(elm).closest("tr").find(".poh").html()));
            $("#txtAllotmentDate").val($.trim($(elm).closest("tr").find(".altd").html()));
            $("#txtPhoneOffice").val($.trim($(elm).closest("tr").find(".pof").html()));

            $("#fieldsetPersonal").show();
            $("#fieldsetFM").hide();
            //$("#txtValidity").val($.trim($(elm).find(".cardNo").html()));            
            //window.location = "../RMS/AddResident.aspx?EID=" + eid + "&&Status=" + status + "&&E=R";
        }
        function editFM(eid, efid, elm) {
            $("#tblFamilyMember input[type=text]").val("");
            $("#tblFamilyMember select").val("");
            $("[id$='hdnEFID']").val(efid);
            $("[id$='hdnEID']").val(eid);

            $("[id$='txtCardNoFS']").val($.trim($(elm).closest("tr").find(".cardNo").html()));
            $("[id$='txtFirstNameFS']").val($.trim($(elm).closest("tr").find(".firstName").html()));
            $("[id$='txtLastNameFS']").val($.trim($(elm).closest("tr").find(".lastName").html()));
            $("[id$='ddlRelationFS']").val($.trim($(elm).closest("tr").find(".relation").html()));
            $("[id$='txtNICFS']").val($.trim($(elm).closest("tr").find(".nic").html()));
            $("[id$='txtCellNoFS']").val($.trim($(elm).closest("tr").find(".mobile").html()));
            $("[id$='txtVisitorAdd']").val($.trim($(elm).closest("tr").find(".vAdd").html()));
            $("[id$='txtVisitPurpose']").val($.trim($(elm).closest("tr").find(".vPurpose").html()));


            $("#fieldsetFM").show();
            //$("#fieldsetPersonal").hide();            
        }
        function clearSearchCriteria() {
            $("#tblSearchCriteria input[type=text]").val("");
            $("#tblSearchCriteria select").val("");
        }
        function addNewEmployee() {
            $("#fieldsetPersonalGrd").hide();
            $("#fieldsetFMGrd").hide();

            $("#fieldsetPersonal").show();
            $("#fieldsetFM").show();
            $("#tblPersonal input[type=text]").val("");
            $("#tblPersonal select").val("");
            $("#tblFamilyMember input[type=text]").val("");
            $("#tblFamilyMember select").val("");
        }
        function addNewFM() {
            $("#fieldsetFM").show();
            $("#fieldsetPersonal").hide();
            $("#tblFamilyMember input[type=text]").val("");
            $("#tblFamilyMember select").val("");

            $("[id$='hdnEFID']").val("0");

        }
        //function editFamilyMember(eid,efid, status) {
        //    window.location = "../RMS/AddResident.aspx?EID=" + eid + "&&EFID=" + efid + "&&Status=" + status + "&&E=F";
        //}
    </script>
</asp:Content>

