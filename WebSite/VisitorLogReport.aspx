    <%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="VisitorLogReport.aspx.cs" Inherits="VisitorLogReport" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <style type="text/css">
             .nowrap {
                 white-space: nowrap;
             }
            .auto-style1 {
                margin-left: 0px;
            }
       
        </style>
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <fieldset>
            <legend>Visitor Search Criteria</legend>
             <table id="tblSearchCriteria" class="form">

                 <tr>
                    <td>
                        <asp:Label ID="lblName" runat="server" Text="Visitor Name:"></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtName" onkeypress="return isAlphabetKey(event)" runat="server" Width="287px" Height="37px" placeholder="Enter Visitor Name"></asp:TextBox>
                        <%--onblur="getVisitorByCNIC()"--%>
                    </td>
                     <td>
                        <asp:Label ID="Label1" runat="server" Text="Employee/Host CNIC:"></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtHostCNIC" runat="server" Width="287px" Height="37px" placeholder="Enter Employee CNIC" MaxLength="15"></asp:TextBox> <%--onkeydown = "return (!(event.keyCode>=65) && event.keyCode!=32)";--%>
                        <%--onblur="getVisitorByCNIC()"--%>
                    </td>
                     <td><asp:Label ID="lblHostName" Visible="false" runat="server" Text="Host Name"></asp:Label></td>
                        <td class="auto-style1">
                        <asp:DropDownList ID="ddlHostName"  runat="server" Visible="false" ClientIDMode="Static" Height="48px" Width="300px" ></asp:DropDownList>
                     </td>
                </tr>
                  <tr>
                    <td>
                        <asp:Label ID="lblCNIC" runat="server" Text="Visitor CNIC:"></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtCNIC" runat="server" Width="287px" Height="37px" placeholder="Enter CNIC With Dashes(-)" MaxLength="15"></asp:TextBox> <%--onkeydown = "return (!(event.keyCode>=65) && event.keyCode!=32)";--%>
                        <%--onblur="getVisitorByCNIC()"--%>
                    </td>
                      
                      <td>
                        <asp:Label ID="lblApprovedDeclined" Visible="false" Text="Status:" runat="server"></asp:Label></td>
                    <td>
                        <asp:DropDownList ID="ddlApprovedDeclined" Visible="false" runat="server" ClientIDMode="Static" Height="52px" Width="300px">
                            <asp:ListItem>--Select--</asp:ListItem>
                            <asp:ListItem>Approved</asp:ListItem>
                            <asp:ListItem>Declined</asp:ListItem>
                            <asp:ListItem>Pending</asp:ListItem>
                        </asp:DropDownList>
                        <%--<asp:TextBox ID="txtHost" runat="server"></asp:TextBox>--%>
                  </td>

                    <%--<ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender1" runat="server"
                     MaskType="Number" Mask="99999-9999999-9" TargetControlID="TxtCNIC"
                     MessageValidatorTip="true" ClearMaskOnLostFocus="false"/>--%>
                </tr>
                <tr>
                              <%--onblur="getVisitorByCNIC()"--%>
                     <td class="auto-style1">
                         <asp:Label ID="lblDesignation" Visible="false" runat="server" Text="Appointment:"></asp:Label>

                     </td>
                    <td class="auto-style1">
                        <asp:DropDownList ID="ddlDesignation" Visible="false" runat="server" ClientIDMode="Static" Height="46px" Width="300px" ></asp:DropDownList>
                        <%--<asp:DropDownList ID="txtFloor" runat="server" 
                        Style="background-color: Lavender;font-family: Calibri;" onchange="return getCompaniesName();"></asp:DropDownList>--%>
                        <%--<asp:TextBox ID="txtFloor" runat="server"></asp:TextBox>" onchange="return getCompaniesName();"--%>
                        <%--background-color: Lavender;--%>
                    </td>
                    <td class="auto-style1"><asp:Label ID="lblRank" Visible="false" runat="server" Text="Rank"></asp:Label>
                        </td>
                    <td class="auto-style1">
                        <asp:DropDownList ID="ddlRank" runat="server" Visible="false" ClientIDMode="Static" Height="48px" Width="300px" CssClass="auto-style1" ></asp:DropDownList>
                        </td>
    <%--                    <select class="form-control" id="txtCompany" disabled="false" name="departmentsDropdown"></select>--%>
                        <%--<asp:TextBox ID="txtCompany" runat="server"></asp:TextBox>--%>
                
                </tr>
                    <tr>
                    
                    
                        <%--<td>HR No:</td>
                        <td> <asp:TextBox ID="txtPNo" runat="server" Height="33px" Width="285px" placeholder="Enter HR No#"></asp:TextBox></td>--%>
                 
                         <td><asp:Label ID="lblGateNo" runat="server" Visible="false" Text="GateName:"></asp:Label>  </td>
                        <td class="auto-style1">
                        <asp:DropDownList ID="ddlGateNo" runat="server" Visible="false" ClientIDMode="Static" Height="48px" Width="300px" ></asp:DropDownList>
                        </td>
                   </tr>
            
                <tr>
                    <td>
                        <asp:Label ID="lblDate" runat="server" Text="*From Date"></asp:Label>
                        :</td>
                    <td>
                        <asp:TextBox ID="txtDate"  TextMode="Date"  runat="server" ></asp:TextBox>
                    </td>
                    <td>
                         <asp:Label ID="lblToDate" runat="server" Text="*To Date"></asp:Label>
                         :</td>
                    <td>
                        <asp:TextBox ID="txtToDate" TextMode="Date" runat="server" ></asp:TextBox>
                    </td>
                </tr>
                          </table>
             <div class="btn-wrapper">
                    <asp:Button Width="10%"  id="btnSaveResident" class="btn"  Text="Search" runat="server" OnClick="btnSaveResident_Click" />
                    <%--<asp:Button  id="btnSaveExcel" class="btn"  Text="Save To PDF" runat="server" OnClick="Button1_Click" />
                    <asp:Button  id="btnSaeExcel" class="btn"  Text="Save To Excel" runat="server" OnClick="btnSaeExcel_Click" />--%>
                 <asp:Button  Width="10%" ID="btnPrint" class="btn" runat="server" Text="Print" OnClick="Print"/>
                 <%--<asp:Button Width="15%" ID="ExportToExcel" class="btn" runat="server" Text="Export To Excel" OnClick="ClickForExcel" />--%>
                 <%--<asp:Button Width="12%" ID="ExportToWord" class="btn" runat="server" Text="Export To Word" OnClick="ConvertToWord" />--%>
                 <asp:Button Width="10%" ID="clear" class="btn" runat="server" Text="Clear"  OnClick="ClearAll"/>
                    <%--<input type="button" id="btnExport" value="Export" />--%>
                    <%--<input type="button" id="btnSaveResident" class="btn" value="Save" onclick="saveResidenet();" />--%>
                    <%--<input type="button" id="btnClearResident" class="btn" value="New" onclick="clearResidenet();" />--%>

                    <input type="hidden" id="hdnEID" runat="server" value="0" />
                </div>
        </fieldset>
        <%--<fieldset>
            <legend>Colums</legend>
            <table width="100%">--%>
                <%--<tr>--%>
                   <%-- <td style='text-align:left; white-space:nowrap; Text="SR#" 'id='SR#" + i + "'>" + j + "</td>";--%>
                     <%--tbl += "<td style='text-align:left; white-space:nowrap;'id='SR#" + i + "'>" + j + "</td>";--%>
                    <%--<td><asp:CheckBox value="ServiceNo" ID="chkbxPn" Text="ServiceNo" runat="server"/></td>--%>
                   <%-- <td><asp:CheckBox value="Nic"  ID="chkbxCNIC" Text="CNIC" runat="server"/></td>--%>
                    <%--<td><asp:CheckBox value="Full_Name" ID="chkbxName" Text="Name" runat="server"/></td>--%>
                    <%--<td><asp:CheckBox value="FatherName"  ID="chkbxFatherName"  Text="Father Name" runat="server"/></td>--%>
                   <%-- <td><asp:CheckBox value="DATE" ID="chkbxDate"  Text="Date" runat="server"/></td>--%>
                    <%--<td><asp:CheckBox value="Department" ID="chkbxDepartment" Text="Department" runat="server"/></td>
                    <td><asp:CheckBox value="Designation" ID="chkbxDesignation" Text="Appointment" runat="server"/></td>
                    <td><asp:CheckBox value="Rank"  ID="chkbxRank" Text="Rank" runat="server"/></td>--%>
                     <%--<td><asp:CheckBox value="Gender" ID="chkbxGender" Text="Gender" runat="server"/></td>--%>
                     <%--<td><asp:CheckBox value="ClearanceStatus"  ID="chkbxClearanceStatus"  Text="ClearanceStatus" runat="server"/></td>--%>
                   <%-- <td><asp:CheckBox value="Vehicle No"  ID="chkbxVehicleNo"  Text="Vehicle No" runat="server"/></td>--%>
                   <%-- <td><asp:CheckBox value="Site Name"  ID="chkbxSiteName" Text="Site Allowed" runat="server"/></td>--%>
                    <%--<td><asp:CheckBox value="Remarks" ID="chkbxRemarks" Text="Remarks" runat="server"/></td>--%>
                <%--</tr>--%>
               <%-- <tr width="10%">--%>
               
                    <%--<td><asp:CheckBox value="Valid Upto" ID="chkbxValidUpto" Text="Expiry Date" runat="server"/></td>--%>
                
                     <%--<td><asp:CheckBox value="Gate No"  ID="chkbxGateNo"  Text="Gate No" runat="server"/></td>--%>
                    <%--<td><asp:CheckBox value="Gate Name" ID="chkbxGateName"  Text="Gate Name" runat="server"/></td>--%>
                    <%--<td><asp:CheckBox value="Gate Lane" ID="chkbxGateLane" Text="Gate Lane" runat="server"/></td>--%>
                     <%--                <td><asp:CheckBox value="UserType" ID="chkbxUserType" Text="User Type" runat="server"/></td>--%>
                   <%-- <td><asp:CheckBox value="Terminal Name"  ID="chkbxTerminalName" Text="Terminal Name" runat="server"/></td>
                    <td><asp:CheckBox value="Device Name"  ID="chkbxDeviceName" Text="Device Name" runat="server"/></td>--%>
                
               
              <%--  </tr>--%>
            <%--</table>
        </fieldset>--%>
         <fieldset runat="server">
            <legend>Details</legend>

            <asp:GridView class="nowrap" ID="GVdetails" runat="server"  BackColor="#CCCCCC" style="width:100%;" AllowPaging="false"  OnPageIndexChanging="OnPageIndexChanging" PageSize="3" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" Caption="Visitor Log Report" CaptionAlign="Top"> 
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

            function isAlphabetKey(evt) {
                var charCode = (evt.which) ? evt.which : event.keyCode
                if ((charCode <= 93 && charCode >= 65 || charCode == 32) || (charCode <= 122 && charCode >= 97 || charCode == 32)) {

                    return true;
                }
                //alert("Only A-Z or a-z");
                return false;

            }

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

