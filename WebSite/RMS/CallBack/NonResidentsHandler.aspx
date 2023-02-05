<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="NonResidentsHandler.aspx.cs" Inherits="RMS_CallBack_NonResidentsHandler" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    #StartNonResident#
            <asp:Repeater ID="rptNonResident" runat="server">
                <ItemTemplate>
                    <tr id="trNoResident" class="blink_me">
                         <td>
                        <span class="tdNonResidentInActive" style="cursor:pointer;" title="Inactive" onclick="InActiveNonResident('<%# Eval("NRID") %>')"> <img  src='../images/Cross2.png'/> </span>
                        <span class="tdNonResidentActive" style="cursor:pointer;" title="Active" onclick="ActivateNonResident('<%# Eval("NRID") %>')"> <img    src='../images/Active.png'/></span>
                        <span  class="tdNonResidentBlackList" style="cursor:pointer;"  title="Black List" onclick="BlackListNonResident('<%# Eval("NRID") %>')"> <img   src="../../images/Blacklist.png"/></span>
                        </td>
                        <td><span class="edit-icon" title="Edit" onclick="editNonResident('<%# Eval("NRID") %>',this)"><img style="padding-left:10%;" src='../images/Edit.png'/></span> </td>
                        <td class="center cardNo"><%# Eval("CardNumber") %></td>
                        <td style="white-space:nowrap;display:none;" class="fn"><%# Eval("FirstName") %></td>
                        <td style="white-space:nowrap;display:none;" class="ln"><%# Eval("LastName") %></td>
                        <td style="white-space:nowrap" class="fullName"><%# Eval("FirstName") %>  <%# Eval("LastName") %></td>
                        <td style="white-space:nowrap" class="nic"><%# Eval("NIC") %></td>
                        <td style="white-space:nowrap;display:none;" class="rel"><%# Eval("Rel") %></td>
                        <td style="white-space:nowrap;display:none;" class="relName"><%# Eval("RelName") %></td>
                        <td style="white-space:nowrap;display:none;"  class="cAdd"><%# Eval("CurrAddr") %></td>
                        <td style="white-space:nowrap;display:none;"  class="pAdd"><%# Eval("PerAddr") %></td>
                        <td style="white-space:nowrap;display:none;"  class="dept"><%# Eval("Department") %></td>
                        <td style="white-space:nowrap;display:none;"  class="deptn"><%# Eval("DepartmentName") %></td>
                        <td style="white-space:nowrap;display:none;" class="pcat"><%# Eval("Person_CatID") %></td>
                        <td style="white-space:nowrap;display:none;" class="rnk"><%# Eval("Rank_ID") %></td>
                        <td style="white-space:nowrap;display:none;" class="rnkn"><%# Eval("Rank_Name") %></td>

                        <td style="white-space:nowrap;display:none;" class="desg"><%# Eval("Designation") %></td>                         
                        <td style="white-space:nowrap;display:none;" class="desgn"><%# Eval("DesignationName") %></td>
                        <td style="white-space:nowrap;display:none;"  class="pHome"><%# Eval("PhoneHome") %></td>
                        <td  style="white-space:nowrap;display:none;"  class="pOffc"><%# Eval("PhoneOffice") %></td>
                        <td style="white-space:nowrap;display:none;"  class="mobile"><%# Eval("Mobile") %></td>
                        <td style="white-space:nowrap;display:none;"  class="religion"><%# Eval("Religion") %></td>
                        <td style="white-space:nowrap;display:none;"  class="sectt"><%# Eval("Sectt") %></td>
                        <td style="white-space:nowrap;display:none;"  class="caste"><%# Eval("Caste") %></td>
                        <td  style="white-space:nowrap;display:none;"  class="edu"><%# Eval("Education") %></td>
                        <td style="white-space:nowrap;display:none;"  class="firm"><%# Eval("Firm") %></td>
                        <td  style="white-space:nowrap;display:none;" class="firmAdd"><%# Eval("FirmAddr") %></td>
                        <td  style="white-space:nowrap;display:none;" class="product"><%# Eval("Product") %></td>
                        <td  style="white-space:nowrap;display:none;" class="shopKp"><%# Eval("ShopKeeper") %></td>
                        <td  style="white-space:nowrap;display:none;" class="market"><%# Eval("Market") %></td>
                        <td  style="white-space:nowrap;display:none;" class="witness1Name"><%# Eval("Witness1Name") %></td>
                        <td  style="white-space:nowrap;display:none;" class="witnes1Add"><%# Eval("Witness1Addr") %></td>
                        <td style="white-space:nowrap;display:none;"  class="witness2Name"><%# Eval("Witness2Name") %></td>
                        <td  style="white-space:nowrap;display:none;" class="witness2Add"><%# Eval("Witness2Addr") %></td>
                        <td  style="white-space:nowrap;display:none;" class="auth"><%# Eval("Authority") %></td>
                        <td  style="white-space:nowrap;display:none;" class="doe"><%# Eval("DateofEntry") %></td>
                        <td  style="white-space:nowrap;display:none;" class="dor"><%# Eval("DateofRelease") %></td>
                        <td   class="status" style="display: nones;" ><%# Eval("Status") %></td>
                  <%--      <td  style="white-space:nowrap;display:none;" class="photo333"  >

                                  <asp:Image ID="Image" style="padding-left:10%;" runat="server" Width="50px" Height="50" ImageUrl='<%#"../RMS/NoneResidentsPictures/"+Eval("photo")+".jpg" %>'/>

                        </td>--%>

                        <td class="photo">  <img  src='<%# "../RMS/CallBack/GetImageDatafromDB.aspx?PrimaryKeyIDValue=" + System.Convert.ToString(Eval("NRID") + "&tableName=NonResident&ImagecolumnName=NewPhoto&PrimaryKeyColumnName=NRID&date="+DateTime.Now+"") %>' height="50px" width="50px"/></td>
                        <td><span class="edit-icon" onclick="ShowDetails_Modal('<%# Eval("NRID") %>',this,'1')"><img style="padding-left:10%;" src='../images/Details.png'/></span> </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
    #EndNonResident#
   </asp:Content>


