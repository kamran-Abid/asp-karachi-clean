<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="UVSS_Report.aspx.cs" Inherits="UVSS_Report_UVSS_Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
     <style type="text/css">
        .auto-style1 {
            margin-left: 0px;
        }
         .nowrap {
  white-space: nowrap ;
}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <fieldset>
        <legend>Employee Search Criteria</legend>
         <table id="tblSearchCriteria" class="form">
             
            <tr>
                          <%--onblur="getVisitorByCNIC()"--%>
                <td>
                    <asp:Label ID="lblVecNo" runat="server" Text="VehicleNo:"></asp:Label></td>
                <td>
                    <asp:TextBox ID="txtVecNo" runat="server" Width="287px" Height="37px"></asp:TextBox>
                    <%--onblur="getVisitorByCNIC()"--%>
                </td>
                 <td><asp:Label ID="lblGateLane" runat="server" Text="Lane:"></asp:Label>  </td>
                    <td class="auto-style1">
                    <asp:DropDownList ID="ddlGateLane" runat="server" ClientIDMode="Static" Height="48px" Width="300px" ></asp:DropDownList>
                 </td>
<%--                    <select class="form-control" id="txtCompany" disabled="false" name="departmentsDropdown"></select>--%>
                    <%--<asp:TextBox ID="txtCompany" runat="server"></asp:TextBox>--%>
                
            </tr>
                <tr>
                     <%--<td><asp:Label ID="lblGender" runat="server" Text="Gender:"></asp:Label>  </td>
                    <td class="auto-style1">
                    <asp:DropDownList ID="ddlGender" runat="server" ClientIDMode="Static" Height="48px" Width="300px" ></asp:DropDownList>
                    </td>--%>
                    <td><asp:Label ID="lblFOD" runat="server" Text="FOD:"></asp:Label>  </td>
                     <td class="auto-style1">
                    <asp:DropDownList ID="ddlFOD" runat="server" ClientIDMode="Static" Height="48px" Width="300px" ></asp:DropDownList></td>
                     <td>
                    <asp:Label ID="PDI" Text="PDI:" runat="server"></asp:Label></td>
                <td>
                    <asp:DropDownList ID="ddlPDI" runat="server" ClientIDMode="Static" Height="52px" Width="300px"></asp:DropDownList>
                    <%--<asp:TextBox ID="txtHost" runat="server"></asp:TextBox>--%>
              </td>
                 
               </tr>
               <tr>
                <td>
                    <asp:Label ID="lblDate" runat="server" Text="*From Date"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtDate"  TextMode="Date"  runat="server" ></asp:TextBox>
                </td>
                <td>
                     <asp:Label ID="lblToDate" runat="server" Text="*To Date"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtToDate" TextMode="Date"  runat="server" ></asp:TextBox>
                </td>
            </tr>
                      </table>
         <div class="btn-wrapper">
                <asp:Button  Width="10%" id="btnSaveResident" class="btn"  Text="Search" runat="server" OnClick="btnSaveResident_Click" />
               <%-- <asp:Button  id="btnSaveExcel" class="btn"  Text="Save To PDF" runat="server" OnClick="Button1_Click" />--%>
                <%--<asp:Button  id="btnSaeExcel" class="btn"  Text="Save To Excel" runat="server" OnClick="btnSaeExcel_Click" />--%>
                <asp:Button Width="10%" ID="btnPrint" runat="server" class="btn" Text="Print" OnClick="Print"/>
             <asp:Button Width="12%" ID="ExportToExcel" class="btn" runat="server" Text="Export To Excel" OnClick="ClickForExcel" />
             <%--<asp:Button Width="12%" ID="ExportToWord" class="btn" runat="server" Text="Export To Word" OnClick="ConvertToWord" />--%>
              <asp:Button Width="10%" ID="clear" runat="server" class="btn" Text="Clear" OnClick="ClearAll" />
                <%--<input type="button" id="btnExport" value="Export" />--%>
                <%--<input type="button" id="btnSaveResident" class="btn" value="Save" onclick="saveResidenet();" />--%>
                <%--<input type="button" id="btnClearResident" class="btn" value="New" onclick="clearResidenet();" />--%>

                <input type="hidden" id="hdnEID" runat="server" value="0" />
            </div>
    </fieldset>
    <fieldset>
        <legend>Colums</legend>
        <table>
            <tr width="100%;">
                <%--<td><th style='text-align:left; white-space:nowrap;' id="SR#">Sr#</th></td>--%>
              <%--  <td><asp:CheckBox value="id" ID="id" Text="Sr" runat="server"/></td>--%>
             <%--   <td><asp:CheckBox value="LogDate" ID="chkbxLogDate" Text="LogDate" runat="server"/></td>
                <td><asp:CheckBox value="LogDateTime"  ID="chkbxLogDateTime" Text="LogDateTime" runat="server"/></td>
                <td><asp:CheckBox value="Full_Name" ID="chkbxName" Text="Name" runat="server"/></td>
                <td><asp:CheckBox value="VehicelNo"  ID="chkbxVehicelNo"  Text="VehicelNo" runat="server"/></td>
                <td><asp:CheckBox value="FODStaus" ID="chkbxFODStaus"  Text="FODStaus" runat="server"/></td>
                <td><asp:CheckBox value="PDIStatus" ID="chkbxPDIStatus" Text="PDIStatus" runat="server"/></td>--%>
                <td width="30%;"><asp:CheckBox value="PreviousStatus" ID="chkbxPreviousStatus" Text="PreviousStatus" runat="server"/></td>
                <td width="30%;"><asp:CheckBox value="RevisedDecision"  ID="chkbxRevisedDecision" Text="RevisedDecision" runat="server"/></td>
                 <td width="30%;"><asp:CheckBox value="RevisedRemarks" ID="chkbxRevisedRemarks" Text="RevisedRemarks" runat="server"/></td>

            </tr>
        </table>
    </fieldset>
     <fieldset runat="server">
        <legend>Details</legend>
        <asp:GridView  class="nowrap" ID="GVdetails" runat="server" BackColor="#CCCCCC" style="width:100%;" AllowPaging="false"  OnPageIndexChanging="OnPageIndexChanging" PageSize="3" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" Caption="UVSS Report" CaptionAlign="Top">
            <FooterStyle BackColor="#000000" />
            <HeaderStyle BackColor="White" Font-Bold="false"/>
            <PagerStyle BackColor="#000000" ForeColor="Black" HorizontalAlign="Left" />
            <RowStyle BackColor="White" />
            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#808080" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#383838" />
        </asp:GridView>
    </fieldset>
      <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script src="table2excel.js" type="text/javascript"></script>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
    <script type="text/javascript">

        $(function () {

            $("#btnExport").click(function (e) {
                //window.open('data:application/vnd.ms-excel,' +  $("[id*=GVdetails]").text());
                //e.preventDefault();
                printData()
            });
        });


        function printData() {
            // alert('calling');
            var divToPrint = document.getElementById("GVdetails");
            newWin = window.open("");
            newWin.document.write(divToPrint.outerHTML);
            newWin.print();
            newWin.close();
        }

        $('#btnExportNew').on('click', function () {
            printData();
        })

    </script>
</asp:Content>

