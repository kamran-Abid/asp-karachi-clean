<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="FamilyReports.aspx.cs" Inherits="FamilyReport_FamilyReports" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=15.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>



 <%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <script src="../js/bootstrap.js"></script>
    
 <style>
     .buttons{
         margin-right:40px;
     }
 </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <fieldset>
            <legend>Family Search Criteria</legend>
              <div class="container">
                  <div class="row">
                    <table>
                        <tr>
                             <td>Name</td>
                             <td> <asp:TextBox style="width:300px" CssClass="form-control textboxSize" ID="txtbcName" runat="server"></asp:TextBox>   </td>
                             <td>Clearnce Status</td>
                             <td colspan="2">
                                 <asp:DropDownList style="width:300px" CssClass="form-control textboxSize" ID="ddlclearanceStatus" runat="server"></asp:DropDownList> </td>
                        </tr>
                         <tr>
                             <td>Gender</td>
                             <td>
                                 <asp:DropDownList style="width:300px" CssClass="form-control textboxSize" ID="ddlGender" runat="server"></asp:DropDownList> </td>
                             <td>Clearnce Level</td>
                             <td colspan="2">
                                 <asp:DropDownList style="width:300px" CssClass="form-control" ID="ddlSiteAllowed" runat="server"></asp:DropDownList></td>
                        </tr>
                        <tr>
                           <td>Date From</td>
                                 <td>
                               
                                    <asp:TextBox ID="DDateFrom" CssClass="date req textboxSize"   runat="server" style="width:275px;float: left; margin-right: 5px;"></asp:TextBox>
                        <rjs:popcalendar ID="Popcalendar1" Separator="/" Format="mm dd yyyy" Control="DDateFrom" runat="server"
                                Font-Names="Tahoma" />
                                     </td>
                            
                                  <td></td>
                             <td>
                               
                             </td>
                           
                              



                            
                             <td>  


                             </td>
                              

                            <td colspan="3"></td>
                        </tr>
                        <tr>
                        <td>Date To</td>
                        <td colspan="2"> <asp:TextBox ID="DDateTo" CssClass="date req textboxSize"   runat="server" style="width:275px;float: left; margin-right: 5px;"></asp:TextBox>
                        <rjs:popcalendar ID="Popcalendar2" Separator="/" Format="mm dd yyyy" Control="DDateTo" runat="server"
                                Font-Names="Tahoma" />
                         </td>
                         
                             <td >
                                 <asp:Button ID="GetLaborReport" CssClass="btn btn-primary buttons" runat="server" Text="Search" OnClick="GetFamilyReport_Click" /> </td>
                            
                                </tr>
                    </table>
              </div>
              </div>
               
               
           
          </fieldset>
    <fieldset>
        <legend>Family Report</legend>

        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
      
         <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="100%" BackColor="" ClientIDMode="AutoID" HighlightBackgroundColor="" InternalBorderColor="204, 204, 204" InternalBorderStyle="Solid" InternalBorderWidth="1px" LinkActiveColor="" LinkActiveHoverColor="" LinkDisabledColor="" PrimaryButtonBackgroundColor="" PrimaryButtonForegroundColor="" PrimaryButtonHoverBackgroundColor="" PrimaryButtonHoverForegroundColor="" SecondaryButtonBackgroundColor="" SecondaryButtonForegroundColor="" SecondaryButtonHoverBackgroundColor="" SecondaryButtonHoverForegroundColor="" SplitterBackColor="" ToolbarDividerColor="" ToolbarForegroundColor="" ToolbarForegroundDisabledColor="" ToolbarHoverBackgroundColor="" ToolbarHoverForegroundColor="" ToolBarItemBorderColor="" ToolBarItemBorderStyle="Solid" ToolBarItemBorderWidth="1px" ToolBarItemHoverBackColor="" ToolBarItemPressedBorderColor="51, 102, 153" ToolBarItemPressedBorderStyle="Solid" ToolBarItemPressedBorderWidth="1px" ToolBarItemPressedHoverBackColor="153, 187, 226">
        <LocalReport ReportPath="FamilyReport\FamilyEmployeeReport.rdlc">
        </LocalReport>
       

    </rsweb:ReportViewer>
    </fieldset>





</asp:Content>

