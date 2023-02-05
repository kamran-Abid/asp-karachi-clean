<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="BusinessCommunityDetailHandler.aspx.cs" Inherits="RMS_CallBack_BusinessCommunityDetailHandler" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    #StartBusinessCommunityDetails#
            <asp:Repeater ID="rptBusinessCommunityDetails" runat="server">
                <ItemTemplate>
                    <tr>
                                <%--<tr>--%>
                        <td>
                            <span class="tdBusinessCommunityDetailInActive" style="cursor:pointer;" title="Inactive" onclick="InActiveBusinessCommunityDetail('<%# Eval("Id") %>')"> <img src='../images/Cross2.png'/></span> 
                            <span class="tdBusinessCommunityDetailActive" style="cursor:pointer;" title="Active" onclick="ActivatePACSBusinessCommunityDetail('<%# Eval("Id") %>')"> <img    src='../images/Active.png'/></span>
                            <span  class="tdBusinessCommunityDetailBlackList" style="cursor:pointer;"  title="Black List" onclick="BlackListPACSBusinessCommunityDetail('<%# Eval("Id") %>')"> <img   src="../../images/Blacklist.png"/></span>
                      
                            <span class="edit-icon" onclick="editBusinessCommunityDetail('<%# Eval("Id") %>',this)">
                     <img src='../images/Edit.png'/>
                    </span> 
                            </span>
                        </td>
                        <td style="white-space:nowrap" class="center id"><%# Eval("Id") %></td>
                        <td style="white-space:nowrap;" class="BCDName"><%# Eval("Name") %></td>
                        <td style="white-space:nowrap; display:none;" class="Dob"><%# Eval("DOB") %></td>
                        <td style="white-space:nowrap;" class="FatherName"><%# Eval("FatherName") %></td>
                        <td style="white-space:nowrap; display:none;" class="Gender"><%# Eval("Gender") %></td>
                        <td style="white-space:nowrap;" class="CNIC"><%# Eval("CNIC") %></td>
                        <td style="white-space:nowrap; display:none;" class="Designation"><%# Eval("Designation") %></td>
                        <td style="white-space:nowrap; display:none;" class="IdentificationM"><%# Eval("IdentificationMark") %></td>
                        <td style="white-space:nowrap; display:none;" class="BusinessCommunityCat"><%# Eval("BusinessCommunityCategory") %></td>
                        <td style="white-space:nowrap; display:none;" class="BloodGroup"><%# Eval("BloodGroup") %></td>
                        <td style="white-space:nowrap; display:none;" class="Address"><%# Eval("address") %></td>
                        <td style="white-space:nowrap;" class="ValidFrom"><%# Eval("ValidityFrom") %></td>
                        <td style="white-space:nowrap;" class="ValidTo"><%# Eval("ValidityTo") %></td>
                        <td style="white-space:nowrap; display:none;" class="Created By"><%# Eval("created_by") %></td>
                        <td style="white-space:nowrap; display:none;" class="Created Date"><%# Eval("created_date") %></td>
                        <td style="white-space:nowrap; display:none;" class="Modified By"><%# Eval("modified_by") %></td>
                        <td style="white-space:nowrap; display:none;" class="Modified Date"><%# Eval("modified_date") %></td>
                        <td style="white-space:nowrap;" class="ClearanceLevel"><%# Eval("ClearanceLevel") %></td>
                        <td style="white-space:nowrap; display:none;" class="ClearanceStatus"><%# Eval("ClearanceStatus") %></td>
                        <td style="white-space:nowrap; display:none;" class="AuthType"><%# Eval("AuthenticationType") %></td>
                        <td style="white-space:nowrap; display:none;" class="status"><%# Eval("CStatus") %></td>

                        
                     <%--   <td style="white-space:nowrap;display:none;" class="phto33">
                       <asp:Image ID="Image" runat="server" Width="50px" Height="50px" ImageUrl='<%#"../RMS/BusinessCommunityDetailPictures/"+Eval("photo")+".jpg" %>'/>
                        </td> --%>
                        <%--<td class="phto">  <img  src='<%# "../RMS/CallBack/GetImageDatafromDB.aspx?PrimaryKeyIDValue=" + System.Convert.ToString(Eval("Id") + "&tableName=mctx_BusinessCommunityDetail&ImagecolumnName=NewPhoto&PrimaryKeyColumnName=Id&date="+DateTime.Now+"") %>' height="50px" width="50px"/></td> --%>
                        <td class="phto">  <img  src='../RMS/BusinessCommunityDetailPictures/<%# Eval("Photo") %>.jpg' height="50px" width="50px"/></td> 
                        <td><span class="edit-icon" onclick="ShowDetails_Modal('<%# Eval("id") %>',this,'1')"><img style="padding-left:10%;" src='../images/Details.png'/></span> </td>                       
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
    #EndBusinessCommunityDetails#
</asp:Content>


