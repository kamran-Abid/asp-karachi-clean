<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="EmployeeFamilyeeDetailReport.aspx.cs" Inherits="EmployeeFamilyeeDetailReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <fieldset>
            <legend>Employee Search Criteria</legend>
           <table id="tblSearchCriteria" class="form">
                <tr>
                    <td class="right">First Name:</td>
                    <td>
                    
                           <asp:TextBox ID="txtFristName"    runat="server"></asp:TextBox>
                    </td >
                  <td class="right">clearance Status:</td>
                    <td>
                      <asp:DropDownList ID="ddlclearanceStatus" CssClass="req" runat="server">
                    </asp:DropDownList>

                    </td>
                </tr>
                        
                <tr>
                    <td class="right">Gender:</td>
                    <td>
                     <asp:DropDownList ID="ddlGender" CssClass="req" runat="server">
                        
                    </asp:DropDownList>
                    </td >
                  <td class="right">
                   Clearance level:
                   </td>
                   <td>
                    <asp:DropDownList ID="ddlSiteAllowed" runat="server">                        
                    </asp:DropDownList>
                   </td>
                </tr>
                
               <tr>
                   
               </tr>
               </table>
            <div class="btn-wrapper" style="padding-top: 20px;">
                <asp:Button  id="btnSearch" class="btn"  Text="Search" runat="server" OnClick="btnSearch_Click"  />
                <asp:Button  id="btnSaveExcel" class="btn"  Text="Save To Excel" runat="server" OnClick="btnSaveExcel_Click" />
                <%--<input type="button" id="btnSaveResident" class="btn" value="Save" onclick="saveResidenet();" />--%>
                <%--<input type="button" id="btnClearResident" class="btn" value="New" onclick="clearResidenet();" />--%>

                <input type="hidden" id="hdnEID" runat="server" value="0" />
            </div>
          </fieldset>
    <fieldset>
        <legend>Details</legend>

        <asp:GridView ID="GVdetails" runat="server" BackColor="#CCCCCC" style="width:100%;"  BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2">
            <FooterStyle BackColor="#CCCCCC" />
            <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
            <RowStyle BackColor="White" />
            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#808080" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#383838" />
        </asp:GridView>
    </fieldset>
</asp:Content>

