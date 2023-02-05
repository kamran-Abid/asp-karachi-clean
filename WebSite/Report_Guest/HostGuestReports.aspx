<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="HostGuestReports.aspx.cs" Inherits="Reposts_GuestReports_HostGuestReports" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=15.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <link href="../PrintSlip/jquery-ui.min.css" rel="stylesheet" />
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
  <%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div>
    <fieldset>
        <legend style="width:auto">Search Employee Criteria</legend>
        <div>
            <table>
                <tr>
                    <td>Employee Name:</td>
                    <td> <asp:TextBox ID="txtEmpName" runat="server" ClientIDMode="Static"></asp:TextBox></td>
                   <td></td>
                    <td>CNIC</td>
                    <td><asp:TextBox ID="txtEmpCNIC" runat="server" ClientIDMode="Static"></asp:TextBox></td>
                    <td></td>
                </tr>
            <%-- <tr>
                    <td>P No.</td>
                    <td>
                       <asp:TextBox ID="txtServiceNumber" runat="server" ClientIDMode="Static"></asp:TextBox>
                   </td>
               </tr>--%>
               <%--<tr>
                    <td>Designation:</td>
                    <td>
                      <asp:TextBox ID="txtDesigation" runat="server" ClientIDMode="Static"></asp:TextBox>
                    </td>
                    <td></td>
                    <td>Department:</td>
                    <td>
                       <asp:TextBox ID="txtDepartment" runat="server" ClientIDMode="Static"></asp:TextBox>
                    </td>
                </tr>
                <tr>
               <td>EmployeeID:</td>
                    <td>
                        <asp:TextBox ID="txtEMPID" runat="server" ClientIDMode="Static"></asp:TextBox>
                    </td>
                    <td></td>
                   </tr>--%>
                
                 <tr>
                  <td>Date From</td>
                    <td>
                        <asp:TextBox ID="ddDateFrom" CssClass="date req textboxSize" ClientIDMode = "Static"  runat="server" style="width:90%;float: left; margin-right: 5px;"></asp:TextBox> 
                   </td>
                     <td>
                         <rjs:popcalendar ID="Popcalendar2" Separator="/" Format="mm dd yyyy" Control="ddDateFrom" runat="server"
                         Font-Names="Tahoma" /> 
                    </td>
                    <td>Date To</td>
                    <td>
                        <asp:TextBox ID="ddDateTo" CssClass="date req textboxSize" ClientIDMode = "Static"  runat="server" style="width:90%;float: left; margin-right: 5px;"></asp:TextBox> 
                   </td>
                     <td>
                         <rjs:popcalendar ID="Popcalendar1" Separator="/" Format="mm dd yyyy" Control="ddDateTo" runat="server"
                         Font-Names="Tahoma" /> 
                    </td> <td>
                        <asp:Button ID="btnsearch" class="btn btn-primary" runat="server" Text="Search" OnClick="btnsearch_Click" />
                    </td>
                </tr>
            </table>
        </div>
    </fieldset>
    <fieldset>
        <legend style="width:auto">Reports</legend>
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
             <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="100%" BackColor="" ClientIDMode="AutoID" HighlightBackgroundColor="" InternalBorderColor="204, 204, 204" InternalBorderStyle="Solid" InternalBorderWidth="1px" LinkActiveColor="" LinkActiveHoverColor="" LinkDisabledColor="" PrimaryButtonBackgroundColor="" PrimaryButtonForegroundColor="" PrimaryButtonHoverBackgroundColor="" PrimaryButtonHoverForegroundColor="" SecondaryButtonBackgroundColor="" SecondaryButtonForegroundColor="" SecondaryButtonHoverBackgroundColor="" SecondaryButtonHoverForegroundColor="" SplitterBackColor="" ToolbarDividerColor="" ToolbarForegroundColor="" ToolbarForegroundDisabledColor="" ToolbarHoverBackgroundColor="" ToolbarHoverForegroundColor="" ToolBarItemBorderColor="" ToolBarItemBorderStyle="Solid" ToolBarItemBorderWidth="1px" ToolBarItemHoverBackColor="" ToolBarItemPressedBorderColor="51, 102, 153" ToolBarItemPressedBorderStyle="Solid" ToolBarItemPressedBorderWidth="1px" ToolBarItemPressedHoverBackColor="153, 187, 226">
        <LocalReport ReportPath="Report_Guest/GuestHostReports.rdlc">
        </LocalReport>
                 

    </rsweb:ReportViewer>
        </div>
    </fieldset>

       </div>

    <script src="../js/jquery-1.11.2.js"></script>
    <script src="../js/jquery.min.js"></script>
    <script src="../PrintSlip/jquery.js"></script>
    <script src="../PrintSlip/jquery-ui.min.js"></script>
      <script src="../js/bootstrap.min.js"></script>
       <script>

           $(document).ready(function () {

               $('#txtEmpCNIC').bind('keyup paste', function () {
                   this.value = this.value.replace(/[^0-9]/g, '');
               });
               $('#txtEmpName').bind('keyup paste', function () {
                   this.value = this.value.replace(/[^a-z,^A-Z]/g, '');
               });

               //$('#txtServiceNumber').bind('keyup paste', function () {
               //    this.value = this.value.replace(/[^0-9]/g, '');
               //});

               //$('#txtDesignation').bind('keyup paste', function () {  //uu
               //    this.value = this.value.replace(/[^a-z,^A-Z]/g, '');
               //});
               //$('#txtDepartment').bind('keyup paste', function () {//uu
               //    this.value=this.value.replace(/[^a-z,^A-Z]/g, '');
               //});

               //$('#txtEMPID').bind('keyup paste', function () {//uu
               //    this.value = this.value.replace(/[^0-9]/g, '');
               //});

            $("#txtEmpName").autocomplete({
                source: function (request, responce) {
                    var terms = {
                        'term': request.term
                    }
                    $.ajax({
                        url: "HostGuestReports.aspx/GetEmployeeNames",
                        method: 'POST',
                        data: JSON.stringify(terms),
                        contentType: "application/json;charset=utf-8",
                        dataType: 'json',
                        success: function (data) {
                            responce(data.d);
                        },
                        error: function (err) {
                            alert(err);
                        }
                    });
                }



            });
               $("#txtEmpCNIC").autocomplete({
                   source: function (request, responce) {
                       var terms = {
                           'term': request.term
                       }
                       $.ajax({
                           url: "HostGuestReports.aspx/GetEmployeeCNIC",
                           method: 'POST',
                           data: JSON.stringify(terms),
                           contentType: "application/json;charset=utf-8",
                           dataType: 'json',
                           success: function (data) {
                               responce(data.d);
                           },
                           error: function (err) {
                               alert(err);
                           }
                       });
                   }



               });
               //$("#txtServiceNumber").autocomplete({
               //    source: function (request, responce) {
               //        var term = {
               //            'terms': request.term
               //        }
               //        $.ajax({
               //            url: "HostGuestReports.aspx/GetEmpServiceNo",
               //            datatype: JSON.stringify(terms),
               //            contentType: "application/jason;charset=utf-8",
               //            dataType: 'jason',
               //            success: function (data) {
               //                responce(data.d);
               //            },
               //            error: function (err) {
               //                alert(err);
               //            }
               //        });
               //    }
               //});


        });


       </script>
</asp:Content>

