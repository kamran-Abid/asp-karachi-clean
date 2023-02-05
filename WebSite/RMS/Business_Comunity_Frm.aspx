<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="Business_Comunity_Frm.aspx.cs" Inherits="RMS_Business_Comunity_Frm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <link href="../css/jquery-ui.min.css" rel="stylesheet" />
    <script src="../js/jquery-ui.min.js"></script>
       <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
        <fieldset>
            <legend>Business Community</legend>
            <table class="form">
                <tr>
                    <td class="right" style="width: 10%;">Card/NIC:</td>
                    <td style="width: 22%;">
                        <input type="text"  id="txtCardNIC" />
                    </td>
                    <td class="right" style="width: 10%;">Full Name:</td>
                    <td style="width: 22%;">
                        <input type="text" class="alpha" id="txtFullName"  />
                    </td>
                    <td  colspan="2" rowspan="4"><img id="myUploadedImg" style="width:150px; height:150px; margin-left: 34%;" alt="" /></td>
                </tr>
                <tr>
                    <td class="right" style="width: 10%;">DoB:</td>
                    <td style="width: 22%;">
                        <asp:TextBox ID="Dobtxt" runat="server" TextMode="Date" Width="93%"></asp:TextBox>
                    </td>
                    <td class="right" style="width: 10%;">Relation:</td>
                    <td style="width: 22%;">
                        <asp:DropDownList ID="RelationDDL" runat="server" 
                    Style="background-color: Lavender;font-family: Calibri;"></asp:DropDownList>
                    </td>
                    
                </tr>
                <tr>
                    <td class="right" style="width: 10%;">Address:</td>
                    <td style="width: 22%;">
                        <input type="text" class="alpha" id="txtAddress"  />
                    </td>
                    <td class="right" style="width: 10%;">Identification Mark:</td>
                    <td style="width: 22%;">
                        <input type="text" class="alpha" id="txtIdMark"  />
                    </td>
                </tr>
                <tr>
                    <td class="right" style="width: 10%;">Blood Group:</td>
                    <td style="width: 22%;">
                        <input type="text" class="alpha" id="txtBloodGroup"  />
                    </td>
                    <td class="right" style="width: 10%;">Security Clearance:</td>
                    <td style="width: 22%;">
                        <input type="text" class="alpha" id="txtSecurity"  />
                    </td>
                </tr>
                <tr>
                    <td class="right" style="width: 10%;">Business Community:</td>
                    <td style="width: 22%;">
                        <input type="text" class="alpha" id="txtBusinessComunity"  />
                    </td>
                    <td style=""></td>
                        
                    <td style="width: 22%;">
                        <input type="file"  onclick="upload()"   class="s2_5n" id="f_UploadImage"/>
                    </td>
                </tr>
               <%-- <tr>
                   <td class="right" style="width: 10%;">Status:</td>
                    <td>
                        <asp:DropDownList ID="ddlStatusSearch" runat="server">
                        <asp:ListItem Text="All" Value=""></asp:ListItem>
                        <asp:ListItem Text="Active" Value="Active"></asp:ListItem>
                        <asp:ListItem Text="Inactive" Value="Inactive"></asp:ListItem>
                            <asp:ListItem Text="Black List" Value="BlackList"></asp:ListItem>
                    </asp:DropDownList>
                    </td>
                    <td colspan="6" style="text-align: center">
                        <input type="button" id="btnSearch" class="btn" value="Search" onclick="getMember();" />
                        <input type="button" id="btnClear" class="btn" value="Clear" onclick="clearResidentForm()" />
                    </td>
                </tr>--%>
            </table>
        </fieldset>
        <div style="padding: 10px;" align="center">
            <table>
                <tr>
                    <td><input type="button" id="btnAddNew" class="btn" value="Add New Member" onclick="addNewMember();" /></td>
                    <td><input type="button" id="btnUpdate" class="btn" value="Update" onclick="UpdateMember();" /></td>
                    <td><input type="button" id="btnClear" class="btn" value="Clear" onclick="ClearMember();" /></td>
                </tr>
            </table>
        
    </div>


</asp:Content>

