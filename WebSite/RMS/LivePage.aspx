<% @Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="LivePage.aspx.cs" Inherits="RMS_LivePage" %>
<% @Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content2" runat="server" contentplaceholderid="head">
    
    <style type="text/css">
        
         .nowrap {
             white-space: nowrap;
             text-wrap:none;
         }
        .auto-style1 {
            margin-left:00px;
            

        }
        /*.TabStyling{
            width:80%;
            height:50%;
            border-block-color:aqua;
            border-spacing:initial;
            padding-bottom:initial
        }*/

    </style>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js">

        
    </script>
    <%--Automatic Page Refresh Option--%>
    <meta http-equiv="Refresh" content="15"/>
<script src="table2excel.js" type="text/javascript"></script>
    <script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
   
    <%--<script type="text/javascript">
        function update() {
            $.get("response.php", function (data) {
                $("#some_div").html(data);
                window.setTimeout(update, 10000);
            });
        }
    </script>--%>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceholderID="ContentPlaceHolder1" runat="server">
    <div>
        
        <h2 style="color: orange; font-style:  unset; font-size:xx-large; align-content:center; padding-left:36%;">National Logistics Cell</h2>
        <h2 style="color: black; font-style: unset; font-size:xx-large; align-content:center; padding-left:40%; text-underline-position: alphabetic">Live Data Page  </h2>

        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <ajaxToolkit:TabContainer ID="LiveDataPage" runat="server" ActiveTabIndex="0">  <%--OnActiveTabChanged="TC_LiveDataPage_ActiveTabChanged"--%>
            <ajaxToolkit:TabPanel ID="Pnl_Gate1" runat="server" TabIndex="0">
               
                <HeaderTemplate>
                    <b style="width:100%">NLC Employees Log Live Details</b>
                </HeaderTemplate>
                <ContentTemplate>
                    <h3 style="color:darkblue; padding-left:610px; font-size:xx-large">Employees Log Details</h3>
                    <asp:GridView  AlternatingRowStyle-CssClass="nowrap" ID="GVdetails1" runat="server"  BackColor="#CCCCCC" 
                        EmptyDataText="No Records Found"  BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black"
                        CellSpacing="2" Height="218px" Width="16px" CssClass="auto-style1">
                  <%--<mastertableview ShowHeadersWhenNoRecords="true">--%> 
             <FooterStyle BackColor="Black" />
            <HeaderStyle BackColor="White" Font-Bold="False"/>
            <PagerStyle BackColor="Black" ForeColor="Black" HorizontalAlign="Left" />
            <RowStyle BackColor="White" />
            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="Gray" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#383838" />
         </asp:GridView>
                    <asp:GridView  AlternatingRowStyle-CssClass="nowrap" ID="GridView2" runat="server"  BackColor="#CCCCCC" 
                        EmptyDataText="No Records Found"  BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black"
                        CellSpacing="2" Height="218px" Width="16px" CssClass="auto-style1">
                  <%--<mastertableview ShowHeadersWhenNoRecords="true">--%> 
             <FooterStyle BackColor="Black" />
            <HeaderStyle BackColor="White" Font-Bold="False"/>
            <PagerStyle BackColor="Black" ForeColor="Black" HorizontalAlign="Left" />
            <RowStyle BackColor="White" />
            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="Gray" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#383838" />
         </asp:GridView>

                </ContentTemplate>
            </ajaxToolkit:TabPanel>
           <%-- Gate2 Details--%>
            <%--<ajaxToolkit:TabPanel ID="Pnl_Gate2" runat="server" TabIndex="1" Width="33.3%">
                <HeaderTemplate>Gate-2 Details</HeaderTemplate>
                <ContentTemplate>
                    <asp:GridView  class="nowrap" ID="GVdetails2" runat="server" BackColor="#CCCCCC"  BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" Caption="Gate-1 Details" Height="218px" Width="16px">
             <FooterStyle BackColor="Black" />
            <HeaderStyle BackColor="White" Font-Bold="False"/>
            <PagerStyle BackColor="Black" ForeColor="Black" HorizontalAlign="Left" />
            <RowStyle BackColor="White" />
            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="Gray" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#383838" />
         </asp:GridView>
                </ContentTemplate>
            </ajaxToolkit:TabPanel>--%>
            <%--<ajaxToolkit:TabPanel ID="Pnl_Gate3" runat="server" TabIndex="2" Width="33.3%">
                <HeaderTemplate>Gate-3 Details</HeaderTemplate>
                <ContentTemplate>
                    <asp:GridView  class="nowrap" ID="GVdetails3" runat="server" BackColor="#CCCCCC"  BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" ForeColor="Black" CellSpacing="2" Caption="Gate-1 Details" Height="218px" Width="16px">
             <FooterStyle BackColor="Black" />
            <HeaderStyle BackColor="White" Font-Bold="False"/>
            <PagerStyle BackColor="Black" ForeColor="Black" HorizontalAlign="Left" />
            <RowStyle BackColor="White" />
            <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="Gray" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#383838" />
         </asp:GridView>
                </ContentTemplate>
            </ajaxToolkit:TabPanel>--%>
        </ajaxToolkit:TabContainer>
        
    </div>
   
</asp:Content>


