<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="ResidentGuest.aspx.cs" Inherits="ResidentGuests_ResidentGuest" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../js/jquery.min.js"></script>
     <%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <fieldset>
            <legend>Resident Guest</legend>
            <table id="tblSearchReport" class="form" style="width:70%">
                 <%--CNIC Region Department--%>
               <tr>
                       <td class="right">CNIC:<span class="reqSpan">*</span></td>
                       <td style="width: 10%;" colspan="1"><asp:TextBox ID="CNIC" runat="server" style="width:300px;"></asp:TextBox></td>
                    <td class="right" style="width: 2%;">Deparment:<span class="reqSpan" >*</span></td>
                <td>

                     
                    <asp:DropDownList ID="ddlGender" CssClass="req" runat="server" style="width:313px;">
                        
                    </asp:DropDownList>
                </td>   
                </tr>
               <%--#endregion--%>

                <%--Name Region and Time In--%>
                <tr>
                  
                  <td class="right" style="width: 2%;">Name:<span class="reqSpan">*</span></td>
                  <td style="width: 10%;"><asp:TextBox ID="G_Name" runat="server" style="width:300px;"></asp:TextBox></td>
                     <td class="right" style="width: 2%;">Time In:<span class="reqSpan">*</span></td>
                  <td style="width: 10%;"><asp:TextBox ID="txttimein" runat="server" style="width:300px;"></asp:TextBox></td>

                </tr>

                <%--#endregion--%>

                 <%--Employee Name and Date Of visit Region--%>
                 <tr>
                   <td class="right" style="width: 2%;">Employee Name:<span class="reqSpan">*</span></td>
                       <td style="width: 10%;" colspan="1"><asp:TextBox ID="txtEmployeeName" runat="server" style="width:300px;"></asp:TextBox></td>
             

                  <td class="right" style="width: 2%;">Date of Visit:<span class="reqSpan">*</span>
                  </td><td> <asp:TextBox ID="DDatevisit" CssClass="date req"   runat="server" style="width:275px; float: left; margin-right: 5px;"></asp:TextBox>
                        <rjs:popcalendar ID="Popcalendar1" Separator="/" Format="mm dd yyyy" Control="DDatevisit" runat="server"
                                Font-Names="Tahoma" /></td>
                 
                 </tr>
                <tr>
                 <%--Person To Designation Print Button--%>
                    <td class="right" style="width: 2%;">Designation:<span class="reqSpan">*</span></td>
                   <td> <asp:DropDownList ID="DropDownList1" CssClass="req" runat="server" style="width:313px;"></asp:DropDownList></td>
                    <td>

                    </td>
                 <td>
                     <asp:Button ID="btnSearch" runat="server" class="btn" Style="float: right;" Text="Save" />
                 </td>
               </tr>



            </table>
        </fieldset>
</asp:Content>

