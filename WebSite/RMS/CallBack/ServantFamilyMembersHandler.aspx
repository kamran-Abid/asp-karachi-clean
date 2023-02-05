<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="ServantFamilyMembersHandler.aspx.cs" Inherits="RMS_CallBack_ServantFamilyMembersHandler" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    #StartFMS#
    
            <asp:Repeater ID="rptServantFamily" runat="server">
        <ItemTemplate>
            <tr>
                   <td>
                   <%--    <span class="edit-icon" onclick="deleteServentFamilMember('<%# Eval("SFID") %>')">
                     <img src='../images/Cross2.png'/>
                    </span>--%>

                    <span  class="tdServantFamilyInActive" style="cursor:pointer;" title="Inactive" onclick="InactiveServantFamilyRecord('<%# Eval("SFID") %>')"> <img src='../images/Cross2.png'/></span>
                    <span  class="tdServantFamilyActive" style="cursor:pointer;" title="Active"  onclick="ActivateServantFamilyRecord('<%# Eval("SFID") %>')"> <img   src='../images/Active.png'/>    </span>
                    <span  class="tdServantFamilyBlackList" style="cursor:pointer;"  title="Black List" onclick="BlackListServantFamilyRecord('<%# Eval("SFID") %>')"> <img   src="../../images/Blacklist.png"/></span>


                   </td>
                <td><span class="edit-icon" onclick="editFMS('<%# Eval("EID") %>','<%# Eval("SFID") %>',this)">
                     <img src='../images/Edit.png'/>
                    </span> </td>
                 <td class="center eid"><%# Eval("EID") %></td>
                <td class="center cardNo"><%# Eval("CardNumber") %></td>
                <td class="firstName" style="display:none;"><%# Eval("FirstName") %></td>
                <td class="lastName" style="display:none;"><%# Eval("LastName") %></td>

                 <td class="lastName"><%# Eval("FirstName") %> <%# Eval("LastName") %></td>
                <td class="relation" style="display:none"><%# Eval("Relation") %></td>
                <td ><%# Eval("Relation_Name") %></td>
                <td class="nic"><%# Eval("NIC") %></td>
                <td class="prof"><%# Eval("Profession") %></td>
                <td class="pow"><%# Eval("PlaceofWork") %></td>
                <td class="mob"><%# Eval("Mobile") %></td>
                 <td style="text-align:left; white-space:nowrap;display:nones;" class="status"><%# Eval("Status") %></td>
                 <td style="text-align:left; white-space:nowrap;display:none;" class="ownerNameofServantFamily"><%# Eval("ownerName") %></td>
              <%--   <td class="phto23" style="display:none;">
                        <asp:Image ID="ImageForServantFamily"  runat="server" Height="50px" Width="50px" ImageUrl='<%#"../RMS/EmpPictures/EmpServantPicture/ServantFamilyPicture/"+Eval("Photo")+".jpg" %>'/>
                 </td>--%>

                <td class="phto">  <img  src='<%# "../RMS/CallBack/GetImageDatafromDB.aspx?PrimaryKeyIDValue=" + System.Convert.ToString(Eval("SFID") + "&tableName=ServantFamily&ImagecolumnName=NewPhoto&PrimaryKeyColumnName=SFID&date="+DateTime.Now+"") %>' height="50px" width="50px"/>
            </tr>
        </ItemTemplate>
    </asp:Repeater>
   
    #EndFMS#
</asp:Content>


