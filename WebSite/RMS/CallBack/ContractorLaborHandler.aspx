<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="ContractorLaborHandler.aspx.cs" Inherits="RMS_CallBack_ContractLaborHandler" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    #StartContractorLabors#
            <asp:Repeater ID="rptContractorLabors" runat="server">
                <ItemTemplate>
                    <tr>
                                <%--<tr>--%>
                        <td>
                            <span class="tdContractorLaborInActive" style="cursor:pointer;" title="Inactive" onclick="InActiveContractorLabor('<%# Eval("id") %>')"> <img src='../images/Cross2.png'/></span> 
                            <span class="tdContractorLaborActive" style="cursor:pointer;" title="Active" onclick="ActivatePACSContractorLabor('<%# Eval("id") %>')"> <img    src='../images/Active.png'/></span>
                            <span  class="tdContractorLaborBlackList" style="cursor:pointer;"  title="Black List" onclick="BlackListPACSContractorLabor('<%# Eval("id") %>')"> <img   src="../../images/Blacklist.png"/></span>
                        
                            <span class="edit-icon" onclick="editContractorLabor('<%# Eval("id") %>',this)">
                     <img src='../images/Edit.png'/>
                    </span> 
                            </span>
                        </td>
                        <td style="white-space:nowrap" class="center id"><%# Eval("id") %></td>
                        <td style="white-space:nowrap;" class="firmName"><%# Eval("FirmName") %></td>
                        <td style="white-space:nowrap;" class="ContractorName"><%# Eval("ContractorName") %></td>
                        <td style="white-space:nowrap;" class="LaborName"><%# Eval("LaborName") %></td>
                        <td style="white-space:nowrap; display:none;" class="Gender"><%# Eval("Gender") %></td>
                        <td style="white-space:nowrap;" class="CNIC"><%# Eval("CNIC") %></td>
                        <td style="white-space:nowrap; display:none;" class="IdentificationM"><%# Eval("IdentificationMark") %></td>
                        <td style="white-space:nowrap; display:none;" class="PlaceofWork"><%# Eval("Placeofwork") %></td>
                        <td style="white-space:nowrap; display:none;" class="Address"><%# Eval("address") %></td>
                        <td style="white-space:nowrap;" class="Mobile"><%# Eval("MobileNumber") %></td>
                        <td style="white-space:nowrap;" class="Created By"><%# Eval("created_by") %></td>
                        <td style="white-space:nowrap;" class="Created Date"><%# Eval("created_date") %></td>
                        <td style="white-space:nowrap; display:none;" class="Modified By"><%# Eval("modified_by") %></td>
                        <td style="white-space:nowrap; display:none;" class="Modified Date"><%# Eval("modified_date") %></td>
                        <td style="white-space:nowrap;" class="ClearanceLevel"><%# Eval("ClearanceLevel") %></td>
                        <td style="white-space:nowrap; display:none;" class="status"><%# Eval("CStatus") %></td>
                        
                        <td style="white-space:nowrap; display:none;" class="ClearanceStatus"><%# Eval("ClearanceStatus") %></td>
                        <td style="white-space:nowrap; display:none;" class="ValidFrom"><%# Eval("ValidFrom") %></td>
                        <td style="white-space:nowrap; display:none;" class="ValidTo"><%# Eval("ValidTo") %></td>
                        <td style="white-space:nowrap; display:none;" class="AuthType"><%# Eval("AuthenticationType") %></td>
                        
                        
                     <%--   <td style="white-space:nowrap;display:none;" class="phto33">
                       <asp:Image ID="Image" runat="server" Width="50px" Height="50px" ImageUrl='<%#"../RMS/ContractorLaborPictures/"+Eval("photo")+".jpg" %>'/>
                        </td> --%>
                        <%--<td class="phto">  <img  src='<%# "../RMS/CallBack/GetImageDatafromDB.aspx?PrimaryKeyIDValue=" + System.Convert.ToString(Eval("id") + "&tableName=mctx_ContractorLaborInformation&ImagecolumnName=NewPhoto&PrimaryKeyColumnName=id&date="+DateTime.Now+"") %>' height="50px" width="50px"/></td> --%>
                        <td class="phto">  <img  src='../RMS/ContractorLaborPictures/<%# Eval("Photo") %>.jpg' height="50px" width="50px"/></td> 
                        <td><span class="edit-icon" onclick="ShowDetails_Modal('<%# Eval("id") %>',this,'1')"><img style="padding-left:10%;" src='../images/Details.png'/></span> </td>                       
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
    #EndContractorLabors#
</asp:Content>


