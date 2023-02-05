<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="PACS-REPORT.aspx.cs" Inherits="PACS_Report_PACS_REPORT" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

     <style type="text/css">
          .nowrap {
  white-space: nowrap ;
}
        .auto-style1 {
            margin-left: 0px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <fieldset>
        <legend>Employee Search Criteria</legend>
         <table id="tblSearchCriteria" class="form">
              <tr>
                <td>
                    <asp:Label ID="lblCNIC" runat="server" Text="CNIC:"></asp:Label></td>
                <td>
                    <asp:TextBox ID="txtCNIC" runat="server" Width="287px" Height="37px"></asp:TextBox>
                    <%--onblur="getVisitorByCNIC()"--%>
                </td>
                  <td><asp:Label ID="lblPNo" runat="server" Text="PNo:"></asp:Label>  </td>
                  <td> <asp:TextBox ID="txtPNo" runat="server" Height="33px" Width="285px"></asp:TextBox></td>
               
                <%--<ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender1" runat="server"
                 MaskType="Number" Mask="99999-9999999-9" TargetControlID="TxtCNIC"
                 MessageValidatorTip="true" ClearMaskOnLostFocus="false"/>--%>
            </tr>
            <tr>
                          <%--onblur="getVisitorByCNIC()"--%>
                 
               <td>
                    <asp:Label ID="lblVehicleNo" runat="server" Text="VehicleNo:"></asp:Label></td>
                <td>
                    <asp:TextBox ID="txtVehicleNo" runat="server" Width="287px" Height="37px"></asp:TextBox>
                    <%--onblur="getVisitorByCNIC()"--%>
                </td>
                <td class="auto-style1"><asp:Label ID="lblRank" runat="server" Text="VehicleType"></asp:Label>
                </td>
                <td class="auto-style1">
                    <asp:DropDownList ID="ddlVehicleType" runat="server" ClientIDMode="Static" Height="48px" Width="300px" CssClass="auto-style1" ></asp:DropDownList>
                    </td>
<%--                    <select class="form-control" id="txtCompany" disabled="false" name="departmentsDropdown"></select>--%>
                    <%--<asp:TextBox ID="txtCompany" runat="server"></asp:TextBox>--%>
                
            </tr>
                <tr>
                     <%--<td><asp:Label ID="lblGender" runat="server" Text="Gender:"></asp:Label>  </td>
                    <td class="auto-style1">
                    <asp:DropDownList ID="ddlGender" runat="server" ClientIDMode="Static" Height="48px" Width="300px" ></asp:DropDownList>
                    </td>--%>
                    <td><asp:Label ID="lblDeviceName" runat="server" Text="DeviceName:"></asp:Label>  </td>
                     <td class="auto-style1">
                    <asp:DropDownList ID="ddlDeviceName" runat="server" ClientIDMode="Static" Height="48px" Width="300px" ></asp:DropDownList></td>
                     <td>
                    <asp:Label ID="lblDepartment" Text="Make:" runat="server"></asp:Label></td>
                <td>
                    <asp:DropDownList ID="ddlMake" runat="server" ClientIDMode="Static" Height="52px" Width="300px"></asp:DropDownList>
                    <%--<asp:TextBox ID="txtHost" runat="server"></asp:TextBox>--%>
              </td>
                 
               </tr>
            <tr>
                  <td><asp:Label ID="lblGateNo" runat="server" Text="GateNo:"></asp:Label>  </td>
                    <td class="auto-style1">
                    <asp:DropDownList ID="ddlGateNo" runat="server" ClientIDMode="Static" Height="48px" Width="300px" ></asp:DropDownList>
                        </td>
                    <td><asp:Label ID="lblGateLane" runat="server" Text="Gate Lane:"></asp:Label>  </td>
                    <td class="auto-style1">
                    <asp:DropDownList ID="ddlGateLane" runat="server" ClientIDMode="Static" Height="48px" Width="300px" ></asp:DropDownList>
                 </td>
            </tr>
             <tr>
                <td><asp:Label ID="Label1" runat="server" Text="ClearanceStatus"></asp:Label>  </td>
                    <td class="auto-style1">
                    <asp:DropDownList ID="ddlClearanceStatus" runat="server" ClientIDMode="Static" Height="48px" Width="300px" ></asp:DropDownList>
                 </td>
             </tr>
            
            <tr>
                <td>
                    <asp:Label ID="lblDate" runat="server" Text="*From Date"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtDate"  TextMode="Date" value="2021-01-01" runat="server" ></asp:TextBox>
                </td>
                <td>
                     <asp:Label ID="lblToDate" runat="server" Text="*To Date"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtToDate" TextMode="Date"  value="2022-01-01" runat="server" ></asp:TextBox>
                </td>
            </tr>
                      </table>
         <div class="btn-wrapper" style="padding-top: 20px;">
                <asp:Button  id="btnSaveResident" class="btn"  Text="Search" runat="server" OnClick="btnSaveResident_Click" />
                <asp:Button  id="btnSaveExcel" class="btn"  Text="Save To PDF" runat="server" OnClick="Button1_Click" />
                <asp:Button  id="btnSaeExcel" class="btn"  Text="Save To Excel" runat="server" OnClick="btnSaeExcel_Click" />
                <%--<input type="button" id="btnExport" value="Export" />--%>
                <%--<input type="button" id="btnSaveResident" class="btn" value="Save" onclick="saveResidenet();" />--%>
                <%--<input type="button" id="btnClearResident" class="btn" value="New" onclick="clearResidenet();" />--%>

                <input type="hidden" id="hdnEID" runat="server" value="0" />
            </div>
    </fieldset>
    <fieldset>
        <legend>Colums</legend>
        <table width="100%">
            <tr width="20%">
                <%--<td><th style='text-align:left; white-space:nowrap;' id="SR#">Sr#</th></td>--%>
              <%--  <td><asp:CheckBox value="id" ID="id" Text="Sr" runat="server"/></td>--%>
                <td><asp:CheckBox value="PNo" ID="chkbxPn" Text="PNo" runat="server"/></td>
                <td><asp:CheckBox value="Nic"  ID="chkbxCNIC" Text="CNIC" runat="server"/></td>
                <td><asp:CheckBox value="Full_Name" ID="chkbxName" Text="Name" runat="server"/></td>
                <%--<td><asp:CheckBox value="VehicelNo"  ID="chkbxVehicelNo"  Text="VehicelNo" runat="server"/></td>--%>
               <%-- <td><asp:CheckBox value="DATE" ID="chkbxDate"  Text="Date" runat="server"/></td>--%>
                <td><asp:CheckBox value="Make" ID="chkbxMake" Text="Make" runat="server"/></td>
                <td><asp:CheckBox value="BodyType" ID="chkbxBodyType" Text="BodyType" runat="server"/></td>
                <td><asp:CheckBox value="Model"  ID="chkbxModel" Text="Model" runat="server"/></td>
                 <td><asp:CheckBox value="Colour" ID="chkbxColour" Text="Colour" runat="server"/></td>
            <%--    <td><asp:CheckBox value="VehicleType"  ID="chkbxVehicleType" Text="VehicleType" runat="server"/></td>--%>
                <td><asp:CheckBox value="EmployeeType" ID="chkbxEmployeeType" Text="EmployeeType" runat="server"/></td>
                <td><asp:CheckBox value="ClearanceStatus"  ID="chkbxClearanceStatus"  Text="ClearanceStatus" runat="server"/></td>
            </tr>
            <tr width="20%">
               
                 <td><asp:CheckBox value="SiteAllowed"  ID="chkbxSiteAllowed"  Text="SiteAllowed" runat="server"/></td>
                <td><asp:CheckBox value="Department" ID="chkbxDepartment"  Text="Department" runat="server"/></td>
                <td><asp:CheckBox value="Rank" ID="chkbxRank"  Text="Rank" runat="server"/></td>
                <td><asp:CheckBox value="GateNo" ID="chkbxGateNo" Text="GateNo" runat="server"/></td>
                <td><asp:CheckBox value="Gate Lane" ID="chkbxGateLane" Text="Gate Lane" runat="server"/></td>
                <td><asp:CheckBox value="Gender" ID="chkbxGender" Text="Gender" runat="server"/></td>
                <td><asp:CheckBox value="UserType" ID="chkbxUserType" Text="User Type" runat="server"/></td>
<%--                <td><asp:CheckBox value="Terminal Name"  ID="chkbxTerminalName" Text="Terminal Name" runat="server"/></td>--%>
                <td><asp:CheckBox value="Device Name"  ID="chkbxDeviceName" Text="Device Name" runat="server"/></td>
                <td><asp:CheckBox value="Remarks" ID="chkbxRemarks" Text="Remarks" runat="server"/></td>
               
            </tr>
        </table>
    </fieldset>
     <fieldset runat="server">
        <legend>Details</legend>

        <asp:GridView class="nowrap" ID="GVdetails" runat="server" BackColor="#CCCCCC" style="width:100%;" AllowPaging="false"  OnPageIndexChanging="OnPageIndexChanging" PageSize="3" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2">
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

