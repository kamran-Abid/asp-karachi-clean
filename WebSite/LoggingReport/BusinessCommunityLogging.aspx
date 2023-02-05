<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="BusinessCommunityLogging.aspx.cs" Inherits="LoggingReport_BusinessCommunityLogging" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width:100%;margin-top:0%;vertical-align:top;">
     
       
                    <table  style="font-family: Calibri; font-size: 11pt;width:100%;" >
                    <tr>
                        <td style="width:140px;text-align:left;">
                            <asp:Label ID="lblDepartmentName" Text="Unique ID:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 600px;">
                            <asp:TextBox ID="txtLoggingUniqueID" Width="95%"   class="alphanumeric" runat="server" BackColor="White" ></asp:TextBox>
                        </td>
                        
                     
                   
                        <td align="left">
                            <asp:Button ID="btnSearch" Text="Search" CssClass="btn" OnClientClick="return SearchLogging();" runat="server" />
                          <asp:Button  id="btnSaveExcel" class="btn"  Text="Save To PDF" runat="server" OnClick="Button1_Click" />
                            <asp:Button  id="btnSaeExcel" class="btn"  Text="Save To Excel" runat="server" OnClick="btnSaeExcel_Click" />
                        </td>
                    </tr>
                </table>

     <div id="divLoggingDetails"  >
            <fieldset id="LoggingDetails" >
                <legend>Logging Details</legend>
                 <div style="overflow: auto; width: 100%;">

            <asp:GridView ID="GVdetails" runat="server" BackColor="#CCCCCC" style="width:100%;" AllowPaging="true"  PageSize="3" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2">
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
            </div>         
	</fieldset>
        </div>

 </table>
     <script type="text/javascript">
        function SearchLogging() {
           
            var UniqID = $.trim($("[id$='txtLoggingUniqueID']").val());
              if(UniqID==''){
                  alert('Please Enter Unique Id');
                  return false;
          }
        }
    </script>
</asp:Content>

