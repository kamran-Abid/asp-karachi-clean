<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="EmployeeDetailReport.aspx.cs" Inherits="EmployeeDetailReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   <fieldset>
            <legend>Employee Search Criteria</legend>
           <table id="tblSearchCriteria" class="form">
                <tr>
                    <td class="right">PNo.:</td>
                    <td>
                    
                           <asp:TextBox ID="txtPNO"    runat="server"></asp:TextBox>
                    </td >
                    <td class="right">Rank/Appoitment:</td>
                    <td>
                     <asp:DropDownList ID="ddlRank" runat="server" class="chzn-select" >                            
                        </asp:DropDownList> </td>
                </tr>
                        <tr>
                    <td class="right">Designation:</td>
                    <td>
                    <asp:DropDownList ID="ddlDesignation" runat="server" class="chzn-select">
                        
                    </asp:DropDownList>
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
                    <td class="right">Resident Status:</td>
                    <td>
                     <asp:DropDownList ID="ddlResidant" runat="server">                        
                    </asp:DropDownList>

                    </td>
                </tr>
                      <tr>
                    <td class="right">Cadre:</td>
                    <td>
                    <asp:DropDownList ID="ddlCadre" runat="server">                        
                    </asp:DropDownList>
                    </td >
                    <td class="right">Transport:</td>
                    <td>
                      <asp:DropDownList ID="ddlTransport" runat="server">                        
                    </asp:DropDownList>

                    </td>
                </tr>
               <tr>
                   <td class="right">
                   Clearance level:
                   </td>
                   <td>
                    <asp:DropDownList ID="ddlSiteAllowed" runat="server">                        
                    </asp:DropDownList>
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
        <table>
            <tr>
                <td><asp:CheckBox value="ServiceNo" ID="chkbxPn" Text="ServiceNo" runat="server"/></td>
                <td><asp:CheckBox value="Nic"  ID="chkbxCNIC" Text="CNIC" runat="server"/></td>
                <td><asp:CheckBox value="PhoneHome" ID="chkbxPhoneHome" Text="PhoneHome" runat="server"/></td>
                <td><asp:CheckBox value="PhoneOffice" ID="chkbxPhoneOffice"  Text="PhoneOffice" runat="server"/></td>
                <td><asp:CheckBox value="Mobile" ID="chkbxMobile" Text="Mobile" runat="server"/></td>
                <td><asp:CheckBox value="Dob" ID="chkbxDob" Text="Dob" runat="server"/></td>
                <td><asp:CheckBox value="FatherName"  ID="chkbxFatherName"  Text="FatherName" runat="server"/></td>
                <td><asp:CheckBox value="MotherName"  ID="chkbxMotherName" Text="MotherName" runat="server"/></td>
            </tr>
        </table>
    </fieldset>
    <fieldset runat="server">
        <legend>Details</legend>

        <asp:GridView ID="GVdetails" runat="server" BackColor="#CCCCCC" style="width:100%;" AllowPaging="false"  OnPageIndexChanging="OnPageIndexChanging" PageSize="3" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2">
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
    <script  type="text/javascript">
        //$(document).ready(function () {

        //    $("body").on("click", "#btnExport", function () {


        //        alert('calling');
        //        $("[id*=GVdetails]").table2excel({
        //            filename: "Table.xls"
        //        });
        //    });
        //});
        //$("body").on("click", "#btnExport", function () {


        //    alert('calling');
        //    $("[id*=GVdetails]").table2excel({
        //        filename: "Table.xls"
        //    });
        //});


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

