<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="ContractorHandler.aspx.cs" Inherits="RMS_CallBack_ContractHandler" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    #StartContractors#
            <asp:Repeater ID="rptContractors" runat="server">
                <ItemTemplate>
                    <tr>
                                <%--<tr>--%>
                        <td>
                            <span class="tdContractorInActive" style="cursor:pointer;" title="Inactive" onclick="InActiveContractor('<%# Eval("id") %>')"> <img src='../images/Cross2.png'/></span> 
                            <span class="tdContractorActive" style="cursor:pointer;" title="Active" onclick="ActivatePACSContractor('<%# Eval("id") %>')"> <img    src='../images/Active.png'/></span>
                            <span  class="tdContractorBlackList" style="cursor:pointer;"  title="Black List" onclick="BlackListPACSContractor('<%# Eval("id") %>')"> <img   src="../../images/Blacklist.png"/></span>
                       
                            <span class="edit-icon" onclick="editContractor('<%# Eval("id") %>',this)">
                     <img src='../images/Edit.png'/>
                    </span> 
                            </span>
                        </td>
                        <td style="white-space:nowrap" class="center id"><%# Eval("id") %></td>
                        <td style="white-space:nowrap;" class="firmName"><%# Eval("FirmName") %></td>
                        <td style="white-space:nowrap;" class="ContractorName"><%# Eval("ContractorName") %></td>
                        <td style="white-space:nowrap; display:none;" class="Gender"><%# Eval("Gender") %></td>
                        <td style="white-space:nowrap;" class="CNIC"><%# Eval("CNIC") %></td>
                        <td style="white-space:nowrap; display:none;" class="FirmAddr"><%# Eval("FirmAddress") %></td>
                        <td style="white-space:nowrap; display:none;" class="ResidentAddr"><%# Eval("ResidantAddress") %></td>
                        <td style="white-space:nowrap;" class="Mobile"><%# Eval("MobileNo") %></td>
                        <td style="white-space:nowrap; display:none;" class="OfficeNo"><%# Eval("OfficeNumber") %></td>
                        <td style="white-space:nowrap; display:none;" class="IdentificationM"><%# Eval("IdentificationMark") %></td>
                        <td style="white-space:nowrap; display:none;" class="Rank"><%# Eval("RankOrAppointment") %></td>
                        <td style="white-space:nowrap;" class="Created By"><%# Eval("created_by") %></td>
                        <td style="white-space:nowrap;" class="Created Date"><%# Eval("created_date") %></td>
                        <td style="white-space:nowrap; display:none;" class="Modified By"><%# Eval("modified_by") %></td>
                        <td style="white-space:nowrap; display:none;" class="Modified Date"><%# Eval("modified_date") %></td>
                        <td style="white-space:nowrap; display:none;" class="ClearanceLevel"><%# Eval("ClearanceLevel") %></td>
                        <td style="white-space:nowrap; display:none;" class="ClearanceStatus"><%# Eval("ClearanceStatus") %></td>
                        <td style="white-space:nowrap; display:none;" class="ValidFrom"><%# Eval("ValidityFrom") %></td>
                        <td style="white-space:nowrap; display:none;" class="ValidTo"><%# Eval("ValidityTo") %></td>
                        
                        <td style="white-space:nowrap; display:none;" class="status"><%# Eval("CStatus") %></td>
                        <td style="white-space:nowrap; display:none;" class="AuthType"><%# Eval("AuthenticationType") %></td>

                        
                     <%--   <td style="white-space:nowrap;display:none;" class="phto33">
                       <asp:Image ID="Image" runat="server" Width="50px" Height="50px" ImageUrl='<%#"../RMS/ContractorPictures/"+Eval("photo")+".jpg" %>'/>
                        </td> --%>
                        <%--<td class="phto">  <img  src='<%# "../RMS/CallBack/GetImageDatafromDB.aspx?PrimaryKeyIDValue=" + System.Convert.ToString(Eval("id") + "&tableName=mctx_ContractorInformation&ImagecolumnName=NewPhoto&PrimaryKeyColumnName=id&date="+DateTime.Now+"") %>' height="50px" width="50px"/></td>--%> 
                          <td class="phto">  <img  src='../RMS/ContractorPictures/<%# Eval("Photo") %>.jpg' height="50px" width="50px"/></td> 
                        <td><span class="edit-icon" onclick="ShowDetails_Modal('<%# Eval("id") %>',this,'1')"><img style="padding-left:10%;" src='../images/Details.png'/></span> </td>                       
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
    #EndContractors#
</asp:Content>


