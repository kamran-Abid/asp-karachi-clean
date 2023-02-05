<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="Employees List.aspx.cs" Inherits="RMS_Employees_List" %>


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
        <legend>Employee Search Criteria</legend>
         <table id="tblSearchCriteria" class="form">

             <tr>
                <td>
                    <asp:Label ID="lblName" runat="server" Text="Name:"></asp:Label></td>
                <td>
                    <asp:TextBox ID="txtName" onkeypress="return isAlphabetKey(event)" runat="server" Width="287px" Height="37px" placeholder="Enter Employee Name"></asp:TextBox>
                    <%--onblur="getVisitorByCNIC()"--%>
                </td>
                 <td>HR No:</td>
                    <td> <asp:TextBox ID="txtPNo" runat="server" Height="33px" Width="285px" placeholder="Enter HR No#"></asp:TextBox></td>
            </tr>
              <tr>
                <td>
                    <asp:Label ID="lblCNIC" runat="server" Text="CNIC:"></asp:Label></td>
                <td>
                    <asp:TextBox ID="txtCNIC" runat="server" Width="287px" Height="37px" placeholder="Enter CNIC Without Dashes(-)" MaxLength="13" onkeydown = "return (!(event.keyCode>=65) && event.keyCode!=32);"></asp:TextBox>
                    <%--onblur="getVisitorByCNIC()"--%>
                </td>
                <td>
                    <asp:Label ID="lblDepartment" Text="Department:" runat="server"></asp:Label></td>
                <td>
                    <asp:DropDownList ID="ddlDepartment" runat="server" ClientIDMode="Static" Height="52px" Width="300px"></asp:DropDownList>
                    <%--<asp:TextBox ID="txtHost" runat="server"></asp:TextBox>--%>
              </td>
                <%--<ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender1" runat="server"
                 MaskType="Number" Mask="99999-9999999-9" TargetControlID="TxtCNIC"
                 MessageValidatorTip="true" ClearMaskOnLostFocus="false"/>--%>
            </tr>
            <tr>
                          <%--onblur="getVisitorByCNIC()"--%>
                 <td class="auto-style1">
                     <asp:Label ID="lblDesignation" runat="server" Text="Appointment:"></asp:Label>

                 </td>
                <td class="auto-style1">
                    <asp:DropDownList ID="ddlDesignation" runat="server" ClientIDMode="Static" Height="46px" Width="300px" ></asp:DropDownList>
                    <%--<asp:DropDownList ID="txtFloor" runat="server" 
                    Style="background-color: Lavender;font-family: Calibri;" onchange="return getCompaniesName();"></asp:DropDownList>--%>
                    <%--<asp:TextBox ID="txtFloor" runat="server"></asp:TextBox>" onchange="return getCompaniesName();"--%>
                    <%--background-color: Lavender;--%>
                </td>
                <td class="auto-style1"><asp:Label ID="lblRank" runat="server" Text="Rank"></asp:Label>
                    :</td>
                <td class="auto-style1">
                    <asp:DropDownList ID="ddlRank" runat="server" ClientIDMode="Static" Height="48px" Width="300px" CssClass="auto-style1" ></asp:DropDownList>
                    </td>
<%--                    <select class="form-control" id="txtCompany" disabled="false" name="departmentsDropdown"></select>--%>
                    <%--<asp:TextBox ID="txtCompany" runat="server"></asp:TextBox>--%>
                
            </tr>
             <tr>
                 <td>
                     <asp:Label ID="Gender" runat="server" Text="Gender"></asp:Label>
                 </td>
                 <td class="auto-style1">
                    <asp:DropDownList ID="ddlGender" runat="server" ClientIDMode="Static" Height="48px" Width="300px" CssClass="auto-style1" ></asp:DropDownList>
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
    
     <fieldset runat="server">
        <legend>Details</legend>

        <asp:GridView AlternatingRowStyle-CssClass="nowrap" ID="GVdetails" runat="server"  BackColor="#CCCCCC" style="width:100%;" AllowPaging="false"  OnPageIndexChanging="OnPageIndexChanging" PageSize="3" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" Caption="Employees List" CaptionAlign="Top"> 
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

