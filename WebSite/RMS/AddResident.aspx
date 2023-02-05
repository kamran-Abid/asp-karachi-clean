<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="AddResident.aspx.cs" Inherits="RMS_AddResident" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="divResident">
        <fieldset id="fieldsetPersonal" runat="server">
            <legend>Personal</legend>
            <table id="tblPersonal" class="form">
                <tr>
                    <td class="right">Id:</td>
                    <td>
                        <input type="text" id="txtId" disabled="disabled" runat="server" />
                    </td>

                    <td colspan="2" rowspan="4">
                        <div class="dummy" style="float: right; margin-right: 100px;"></div>
                    </td>
                </tr>
                <tr>
                    <td class="right">Service Code/PNO:<span class="reqSpan">*</span><</td>
                    <td>
                        <input type="text" id="txtPNO" class="req" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="right">First Name:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtFirstName" class="alpha" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="right">Last Name:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtLastName" runat="server" class="req" />
                    </td>
                </tr>
                <tr>
                    <td class="right" style="width: 20%;">NIC:<span class="reqSpan">*</span></td>
                    <td style="width: 30%;">
                        <input type="text" id="txtNIC" runat="server" class="req" />
                    </td>
                    <td class="right" style="width: 20%;">Release Date:</td>
                    <td style="width: 30%;">
                        <input type="text" id="txtReleaseDate" runat="server" />
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
                        <input type="text" id="txtCurrentAdd" runat="server" class="req" />
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
                        <input type="text" id="txtPermanentAdd" runat="server" class="req" />
                    </td>


                </tr>
                <tr>
                    <td class="right">Near Location:</td>
                    <td>
                        <asp:DropDownList ID="ddlNearLoc" runat="server">
                            <asp:ListItem Text="Zafar Gate" Value="Zafar Gate"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="right">Cell Phone:</td>
                    <td>
                        <input type="text" id="txtCellPhone" runat="server" />
                    </td>

                </tr>
                <tr>
                    <%--<td class="right">Card Type:<span class="reqSpan">*</span></td>
                    <td>
                        <asp:DropDownList ID="ddlCardType" runat="server" class="req">
                            <asp:ListItem Text="Resident" Value="Resident"></asp:ListItem>
                        </asp:DropDownList>
                    </td>--%>
                    <td class="right">Card No:</td>
                    <td>
                        <input type="text" id="txtCardNo" disabled="disabled" runat="server" />
                    </td>
                    <td class="right">Phone Home:</td>
                    <td>
                        <input type="text" id="txtPhoneHome" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="right">Allotment Date:</td>
                    <td>
                        <input type="text" id="txtAllotmentDate" runat="server" />
                    </td>
                    <td class="right">Phone Office:</td>
                    <td>
                        <input type="text" id="txtPhoneOffice" runat="server" />
                    </td>

                </tr>
                <tr>
                    <td class="right">Validity Upto:</td>
                    <td>
                        <input type="text" id="txtValidity" runat="server" />
                    </td>

                </tr>
            </table>

            <div class="btn-wrapper" style="padding-top: 20px;">
                <input type="button" id="btnSaveResident" class="btn" value="Save" onclick="saveResidenet();" />
                <input type="hidden" id="hdnEID" runat="server" value="0" />
            </div>

        </fieldset>


        <fieldset id="fieldsetFM" runat="server">
            <legend>Family Member / Servant</legend>

            <table id="tblFamilyMember" class="form">
                <tr>
                    <td class="right">First Name:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtFirstNameFS" class="req" runat="server" />
                    </td>
                    <td colspan="2" rowspan="3">
                        <div class="dummy" style="float: right; margin-right: 100px;"></div>
                    </td>

                </tr>
                <tr>
                    <td class="right">Last Name:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtLastNameFS" class="req" runat="server" />
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
                        <input type="text" id="txtFatherHusbandFS" runat="server" />
                    </td>
                    <td class="right" style="width: 20%;">NIC:</td>
                    <td style="width: 30%;">
                        <input type="text" id="txtNICFS" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="right">Card #:</td>
                    <td>
                        <input type="text" id="txtCardNoFS" runat="server" />
                    </td>
                    <td class="right">Cell #:</td>
                    <td>
                        <input type="text" id="txtCellNoFS" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="right">Visit Purpose:</td>
                    <td>
                        <input type="text" id="txtVisitPurpose" runat="server" />
                    </td>
                    <td class="right">Vistor Address:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtVisitorAdd" class="req" runat="server" />
                    </td>
                </tr>
            </table>
            <div class="btn-wrapper" style="padding-top: 20px;">
                <input type="button" id="btnSaveFamilyMember" class="btn" value="Save" onclick="saveFamilyMember();" />
                <input type="hidden" id="hdnEFID" runat="server" value="0" />
            </div>
        </fieldset>



    </div>

    <fieldset id="fieldsetFMG" runat="server">
        <legend>Family Member / Servant</legend>
        <table class="dataTable">
            <thead>
                <tr>
                    <th>Card #</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Relation</th>
                    <th>NIC</th>
                    <th>Mobile #</th>
                    <th>Address</th>
                    <th>Visit Purpose</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptFamilyMembers" runat="server">
                    <ItemTemplate>
                        <tr onclick="editFMG('<%# Eval("EFID") %>','<%# Eval("status") %>',this)" style="cursor:pointer;">
                        <td class="center cardNo"><%# Eval("CardNumber") %></td>
                        <td class="firstName"><%# Eval("FirstName") %></td>
                        <td class="lastName"><%# Eval("LastName") %></td>
                        <td class="relation"><%# Eval("Relation") %></td>
                        <td class="nic"><%# Eval("NIC") %></td>
                        <td class="mobile"><%# Eval("Mobile") %></td>
                        <td class="vAdd"><%# Eval("vaddr") %></td>
                        <td class="vPurpose"><%# Eval("vpurpose") %></td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </fieldset>

    <div style="text-align:center;width:100%;">
    <input type="button" id="btnBack" value="Back" class="btn" onclick="javascript: history.back(-1);" />
        </div>
    <script type="text/javascript">
        function saveResidenet() {            
            if (!validate("tblPersonal")) {
                var request = "{"
                    + "'EID':'" + $.trim($("[id$='hdnEID']").val()) + "',"
                    + "'ServiceNo':'" + $.trim($("[id$='txtPNO']").val()) + "',"
                    + "'FirstName':'" + $.trim($("[id$='txtFirstName']").val()) + "',"
                    + "'LastName':'" + $.trim($("[id$='txtLastName']").val()) + "',"
                    + "'NIC':'" + $.trim($("[id$='txtNIC']").val()) + "',"
                    + "'ReleaseDate':'" + $.trim($("[id$='txtReleaseDate']").val()) + "',"
                    + "'Rank':'" + $.trim($("[id$='ddlRank']").val()) + "',"
                    + "'Department':'" + $.trim($("[id$='ddlDeptUnit']").val()) + "',"
                    + "'CurrAddr':'" + $.trim($("[id$='txtCurrentAdd']").val()) + "',"
                    + "'Location':'" + $.trim($("[id$='ddlNearLoc']").val()) + "',"
                    + "'PerAddr':'" + $.trim($("[id$='txtPermanentAdd']").val()) + "',"
                    + "'Mobile':'" + $.trim($("[id$='txtCellPhone']").val()) + "',"
                    + "'CardNumber':'" + $.trim($("[id$='txtCardNo']").val()) + "',"
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

                        }
                    });
                }
            }
        }
        function editFMG(efid, status, elm) {
            $("#tblFamilyMember input[type=text]").val("");
            $("#tblFamilyMember select").val("");
            $("[id$='hdnEFID']").val("0");

            $("[id$='txtCardNoFS']").val($.trim($(elm).find(".cardNo").html()));
            $("[id$='txtFirstNameFS']").val($.trim($(elm).find(".firstName").html()));
            $("[id$='txtLastNameFS']").val($.trim($(elm).find(".lastName").html()));
            $("[id$='ddlRelationFS']").val($.trim($(elm).find(".relation").html()));
            $("[id$='txtNICFS']").val($.trim($(elm).find(".nic").html()));
            $("[id$='txtCellNoFS']").val($.trim($(elm).find(".mobile").html()));
            $("[id$='txtVisitorAdd']").val($.trim($(elm).find(".vAdd").html()));
            $("[id$='txtVisitPurpose']").val($.trim($(elm).find(".vPurpose").html()));
            $("[id$='hdnEFID']").val(efid);
        }
        function clearResidentForm() {
            if (window.confirm("Do you want to clear form?")) {
                $("#divResident input[type=text]").val("");
                $("#divResident select").val("");

            }
        }

    </script>
</asp:Content>

