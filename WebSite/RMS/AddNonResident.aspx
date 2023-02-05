<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="AddNonResident.aspx.cs" Inherits="RMS_AddNonResident" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="divResident">
        <fieldset>
            <legend>Non Residents Search Criteria</legend>
            <table class="form">
                <tr>
                    <td class="right" style="width: 10%;">Card/NIC:</td>
                    <td style="width: 22%;">
                        <input type="text" class="numeric" id="txtCardNIC" />
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
                        <input type="text" class="alpha" id="txtNameSearch" />
                    </td>
                    <td class="right" style="width: 10%;">Status:</td>
                    <td style="width: 22%;">
                        <asp:DropDownList ID="ddlStatusSearch" runat="server">
                            <asp:ListItem></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td colspan="2" style="text-align: center">
                        <input type="button" id="btnSearch" class="btn" value="Search" />
                        <input type="button" id="btnClear" class="btn" value="Clear" onclick="clearResidentForm()" />
                    </td>
                </tr>
            </table>
        </fieldset>

        <fieldset>
            <legend>Personal</legend>
            <table class="form">
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
                    <td class="right">Service Code/PNO:</td>
                    <td>
                        <input type="text" id="txtPNO" disabled="disabled" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="right">First Name:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtFirstName" class="req" runat="server" />
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
                    <td class="right" style="width: 20%;">Current Address:</td>
                    <td style="width: 30%;">
                        <input type="text" id="txtCurrentAddress" runat="server" />
                    </td>

                </tr>
                <tr>
                    <td class="right">Relation:</td>
                    <td>
                        <asp:DropDownList ID="ddlRelation" runat="server">
                            <asp:ListItem Text="S/O" Value="S/O"></asp:ListItem>
                            <asp:ListItem Text="F/O" Value="F/O"></asp:ListItem>
                            <asp:ListItem Text="W/O" Value="W/O"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="right">Permanent Address:</td>
                    <td>
                        <input type="text" id="txtPermanentAddress" runat="server" />
                    </td>

                </tr>
                <tr>
                    <td class="right">Relation Name:</td>
                    <td>
                        <input type="text" id="txtRelationName" runat="server" class="req" />
                    </td>
                    <td class="right">Phone Office:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtPhoneOff" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="right">Designation:</td>
                    <td>
                        <asp:DropDownList ID="ddlDesignation" runat="server">
                            <asp:ListItem Text="Shop Owner" Value="Shop Owner"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="right">Phone Home:</td>
                    <td>
                        <input type="text" id="txtPhoneHome" runat="server" />
                    </td>


                </tr>
                <tr>
                    <td class="right">Department:<span class="reqSpan">*</span></td>
                    <td>
                        <asp:DropDownList ID="ddlDepartment" runat="server" class="req">
                            <asp:ListItem Text="A-26(L) NSC" Value="A-26(L) NSC"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="right">Cell Phone:</td>
                    <td>
                        <input type="text" id="txtCellPhone" runat="server" />
                    </td>

                </tr>
                <tr>
                    <td class="right">Religion:</td>
                    <td>
                        <asp:DropDownList ID="ddlReligion" runat="server" class="req">
                            <asp:ListItem Text="Islam" Value="Islam"></asp:ListItem>
                        </asp:DropDownList>
                    </td>

                    <td class="right">Entry Date:</td>
                    <td>
                        <input type="text" id="txtEntryDate" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="right">Sect:</td>
                    <td>
                        <input type="text" id="txtSect" runat="server" />
                    </td>
                    <td class="right">Education:</td>
                    <td>
                        <input type="text" id="txtEducation" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="right">Cast:</td>
                    <td>
                        <asp:DropDownList ID="ddlCast" runat="server">
                            <asp:ListItem Text="Islam" Value="Islam"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>

        </fieldset>


        <fieldset>
            <legend>Witnesses</legend>
            <table class="form">
                <tr>
                    <td class="right" style="width: 20%;">Witness #1:</td>
                    <td style="width: 30%;">
                        <input type="text" id="txtWitness1Name" runat="server" />
                    </td>
                    <td class="right" style="width: 20%;">Witness #1 Address:</td>
                    <td style="width: 30%;">
                        <input type="text" id="txtWitness1Add" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="right">Witness #2:</td>
                    <td>
                        <input type="text" id="txtWitness2Name" runat="server" />
                    </td>
                    <td class="right">Witness #2 Address:</td>
                    <td>
                        <input type="text" id="txtWitness2Add" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="right">Firm:</td>
                    <td>
                        <input type="text" id="txtFirm" runat="server" />
                    </td>
                    <td class="right">Shop Keeper:</td>
                    <td>
                        <input type="text" id="txtShopKeeper" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="right">Product/Service:</td>
                    <td>
                        <input type="text" id="txtProduct" runat="server" />
                    </td>
                    <td class="right">Supplier Address:</td>
                    <td>
                        <input type="text" id="txtSuppplierAdd" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td class="right">Market:</td>
                    <td>
                        <input type="text" id="txtMarket" runat="server" />
                    </td>
                    <td class="right">Authority:</td>
                    <td>
                        <input type="text" id="txtAuthority" runat="server" />
                    </td>
                </tr>
            </table>
        </fieldset>

        <div class="btn-wrapper" style="padding-top: 20px;">
            <input type="button" id="btnSaveResident" class="btn" value="Save" onclick="saveResidenet();" />
        </div>

    </div>

    <fieldset>
        <legend>Family Member / Servant</legend>
        <table class="dataTable">
            <thead>
                <tr>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Address</th>
                    <th>City</th>
                    <th>Mobile #</th>
                    <th>Email</th>
                    <th>User Name</th>
                    <th>Password</th>
                    <th>Role</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="Repeater1" runat="server">
                    <ItemTemplate>
                        <tr>
                            <td><%# Eval("firstname") %></td>
                            <td><%# Eval("lastname") %></td>
                            <td><%# Eval("address") %></td>
                            <td><%# Eval("city") %></td>
                            <td><%# Eval("mobile") %></td>
                            <td><%# Eval("email") %></td>
                            <td><%# Eval("username") %></td>
                            <td><%# Eval("password") %></td>
                            <td><%# Eval("RoleName") %></td>
                            <%--                        <td><span class="edit-icon" onclick="getUser(<%# Eval("userid") %>)">Edit</span> </td>--%>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </tbody>
        </table>
    </fieldset>

    <input type="hidden" id="hdnNRID" runat="server" />
    <script type="text/javascript">
        function saveResidenet() {
            if (!validate("tblUserForm")) {
                var request = "{"
                    + "'NRID':'" + $.trim($("[id$='hdnNRID']").val()) + "',"
                    + "'FirstName':'" + $.trim($("[id$='txtFirstName']").val()) + "',"
                    + "'LastName':'" + $.trim($("[id$='txtLastName']").val()) + "',"
                    + "'CurrAddr':'" + $.trim($("[id$='txtCurrentAdd']").val()) + "',"
                    + "'PerAddr':'" + $.trim($("[id$='txtPermanentAdd']").val()) + "',"
                    + "'NIC':'" + $.trim($("[id$='txtNIC']").val()) + "',"
                    + "'PhoneHome':'" + $.trim($("[id$='txtPhoneHome']").val()) + "',"
                    + "'PhoneOffice':'" + $.trim($("[id$='txtPhoneOffice']").val()) + "',"
                    + "'Mobile':'" + $.trim($("[id$='txtCellPhone']").val()) + "',"
                    + "'Department':'" + $.trim($("[id$='ddlDeptUnit']").val()) + "',"
                    + "'cardtype':'" + $.trim($("[id$='ddlCardType']").val()) + "',"
                    //+ "'photo':'" + $.trim($("[id$='ddlRole']").val()) + "',"

                    + "'RoleId':'" + $.trim($("[id$='ddlRole']").val()) + "',"
                    + "'RoleId':'" + $.trim($("[id$='ddlRole']").val()) + "',"
                    + "'RoleId':'" + $.trim($("[id$='ddlRole']").val()) + "',"
                    + "'RoleId':'" + $.trim($("[id$='ddlRole']").val()) + "',"
                    + "'RoleId':'" + $.trim($("[id$='ddlRole']").val()) + "',"
                    + "'RoleId':'" + $.trim($("[id$='ddlRole']").val()) + "',"
                    + "'RoleId':'" + $.trim($("[id$='ddlRole']").val()) + "',"
                    + "'RoleId':'" + $.trim($("[id$='ddlRole']").val()) + "',"
                    + "'RoleId':'" + $.trim($("[id$='ddlRole']").val()) + "'"
                    + "}";

                $.ajax({
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json",
                    url: "/PascWebMethod.aspx/SaveUser",
                    data: request,
                    success: onsuccessSaveUser
                });
            }
        }
        function clearResidentForm() {
            if (window.confirm("Do you want to clear form?")) {
                $("#divResident input[type=text]").val("");
                $("#divResident select").val("");

            }
        }

    </script>
</asp:Content>

