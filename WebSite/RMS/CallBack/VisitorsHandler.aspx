<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="VisitorsHandler.aspx.cs" Inherits="RMS_CallBack_VisitorsHandler" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    #StartVisitors#
            <asp:Repeater ID="rptVisitors" runat="server">
                <ItemTemplate>
                    <tr>
                                <tr>
                        <td><span class="tdVisitorInActive" style="cursor:pointer;" title="Inactive" onclick="InActiveVisitor('<%# Eval("VID") %>')"> <img src='../images/Cross2.png'/></span> 
                            <span class="tdVisitorActive" style="cursor:pointer;" title="Active" onclick="ActivatePACSVisitor('<%# Eval("VID") %>')"> <img    src='../images/Active.png'/></span>
                            <span  class="tdVisitorBlackList" style="cursor:pointer;"  title="Black List" onclick="BlackListPACSVisitor('<%# Eval("VID") %>')"> <img   src="../../images/Blacklist.png"/></span>


                        </td>
                        <td>

                            <span class="edit-icon" onclick="editVisitor('<%# Eval("VID") %>',this)">
                     <img src='../images/Edit.png'/>
                    </span> 
                            </span> </td>
                        <td style="white-space:nowrap" class="center cardNo"><%# Eval("CardNo") %></td>
                        <td style="white-space:nowrap;display:none;" class="fn"><%# Eval("FirstName") %></td>
                        <td style="white-space:nowrap;display:none;" class="ln"><%# Eval("LastName") %></td>
                        
                        <td style="white-space:nowrap" class="fullName"><%# Eval("FirstName") %> <%# Eval("LastName") %></td>
                       
                        <td style="white-space:nowrap" class="nic"><%# Eval("NIC") %></td>
                        <td style="white-space:nowrap;display:none;" class="phone"><%# Eval("Phone") %></td>
                        <td style="white-space:nowrap;display:none;" class="mobile"><%# Eval("Mobile") %></td>
                        <td style="white-space:nowrap;display:none;" class="Addr"><%# Eval("Addr") %></td>
                        <td style="white-space:nowrap;display:none;" class="prof"><%# Eval("Profession") %></td>
                        <td style="white-space:nowrap" class="vPurpose"><%# Eval("VisitPurpose") %></td>
                        <td style="white-space:nowrap;display:none;" class="vDays"><%# Eval("VisitDays") %></td>
                        <td style="white-space:nowrap" class="issueDt"><%# Eval("IssueDt") %></td>
                        <td style="white-space:nowrap" class="vldDate"><%# Eval("ValidUpto") %></td>
                        <td style="white-space:nowrap" class="refName"><%# Eval("ReferenceName") %></td>
                        <td style="white-space:nowrap;display:none;" class="rel"><%# Eval("Relation") %></td>
                        <td style="white-space:nowrap;display:none;" class="rank"><%# Eval("Rank_ID") %></td>
                        <td style="white-space:nowrap;display:none;" class="refAdd"><%# Eval("CurrAddr") %></td>
                                      <td style="white-space:nowrap;display:none;" class="desgId"><%# Eval("Designation") %></td>
                        <td style="white-space:nowrap" class="status"><%# Eval("Status") %></td>
                                    <td style="white-space:nowrap;display:none;" class="empID"><%# Eval("EID") %></td>
                     <%--   <td style="white-space:nowrap;display:none;" class="phto33">
                       <asp:Image ID="Image" runat="server" Width="50px" Height="50px" ImageUrl='<%#"../RMS/VisitorPictures/"+Eval("photo")+".jpg" %>'/>
                        </td> --%>
                                     <td class="phto">  <img  src='<%# "../RMS/CallBack/GetImageDatafromDB.aspx?PrimaryKeyIDValue=" + System.Convert.ToString(Eval("VID") + "&tableName=Visitor&ImagecolumnName=NewPhoto&PrimaryKeyColumnName=VID&date="+DateTime.Now+"") %>' height="50px" width="50px"/></td> 
                        <td><span class="edit-icon" onclick="ShowDetails_Modal('<%# Eval("VID") %>',this,'1')"><img style="padding-left:10%;" src='../images/Details.png'/></span> </td>                       
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
    #EndVisitors#
</asp:Content>


