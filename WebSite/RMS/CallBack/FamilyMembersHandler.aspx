<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="FamilyMembersHandler.aspx.cs" Inherits="RMS_CallBack_FamilyMembers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    #StartFM#
    <%--<table class="dataTable" style="width: 70%">
        <thead>
            <tr>
                <th  style="background-color:lightblue !important;">Edit</th>
                <th  style="background-color:lightblue !important;">Card #</th>
                <th style="background-color:lightblue !important;">First Name</th>
                <th style="background-color:lightblue !important;">Last Name</th>
                <th style="background-color:lightblue !important;">Relation</th>
                <th style="background-color:lightblue !important;">NIC</th>
                <th style="background-color:lightblue !important;">Mobile</th>
                <th style="background-color:lightblue !important;">Address</th>
                <th style="background-color:lightblue !important;">Visit Purpose</th>
            </tr>
        </thead>
        <tbody>--%>
            <asp:Repeater ID="rptFamilyMembers" runat="server">
                <ItemTemplate>
                    <tr>
                         <td>
                    

                                <span  class="ResidentFamilyMemberInActive" style="cursor:pointer;" title="Inactive" onclick="InactiveEmployeeFamilyRecord('<%# Eval("EFID") %>')"> <img src='../images/Cross2.png'/></span>
                              <span  class="ResidentFamilyMemberActive" style="cursor:pointer;" title="Active"  onclick="ActivateEmployeeFamilyMember('<%# Eval("EFID") %>')"> <img   src='../images/Active.png'/>    </span>
                            <span  class="ResidentFamilyMemberBlackList" style="cursor:pointer;"  title="Black List" onclick="BlackListEmployeeFamilyMember('<%# Eval("EFID") %>')"> <img   src="../../images/Blacklist.png"/></span>


                        <span class="edit-icon" onclick="editFM('<%# Eval("EID") %>','<%# Eval("EFID") %>',this)">
                             <img src='../images/Edit.png'/>
                            </span> </td>
                         <%--<td class="center cardNo"><%# Eval("CardNumber") %></td>--%>
                        <td style="text-align:left; white-space:nowrap;" class="fullName"><%# Eval("FirstName") %> <%# Eval("LastName") %></td>

                        <td style="text-align:left; white-space:nowrap;display:none;" class="firstName"><%# Eval("FirstName") %></td>
                        <td style="text-align:left; white-space:nowrap;display:none;" class="lastName"><%# Eval("LastName") %></td>
                          
                        <td style="text-align:left; white-space:nowrap;display:none;" class="relation"><%# Eval("Relation") %></td>
                        <td style="text-align:left; white-space:nowrap;" class="relationName"><%# Eval("Relation_Name") %></td>
                        <td style="text-align:left; white-space:nowrap;" class="nic"><%# Eval("NIC") %></td>
                        <%--<td style="text-align:left; white-space:nowrap;" class="mobile"><%# Eval("Mobile") %></td>--%>
                        <%--<td style="text-align:left; white-space:nowrap;" class="vAdd"><%# Eval("vaddr") %></td>--%>
                        <%--<td style="text-align:left; white-space:nowrap;" class="vPurpose"><%# Eval("vpurpose") %></td>--%>
                         <td style="text-align:left; white-space:nowrap; display:none;" class="status"><%# Eval("status") %></td>
                         <td style="text-align:left; white-space:nowrap;display:none;" class="ownerName"><%# Eval("ownerName") %></td>

                        <td style="text-align:left; white-space:nowrap;display:none;" class="FGender"><%# Eval("FamilyGender") %></td>
                        <td style="text-align:left; white-space:nowrap;display:none;" class="FClearanceLevel"><%# Eval("ClearanceLevel") %></td>
                         
                       <%-- <td class="phto2" style="display:none;">
                        <asp:Image ID="ImageForFamily"  runat="server" Height="50px" Width="50px" ImageUrl='<%#"../RMS/EmpPictures/EmpFamilyPicture/"+Eval("Photo")+".jpg" %>'/>
                            </td>--%>
                         <%--<td class="phto">  <img  src='<%# "../RMS/CallBack/GetImageDatafromDB.aspx?PrimaryKeyIDValue=" + System.Convert.ToString(Eval("EFID") + "&tableName=EmployeeFamily&ImagecolumnName=NewPhoto&PrimaryKeyColumnName=EFID&date="+DateTime.Now+"") %>' height="50px" width="50px"/>--%>
                             <td class="phto"> <img  src='../RMS/EmpPictures/EmpFamilyPicture/<%# Eval("Photo") %>.jpg' height="50px" width="50px"/>
                 
                        </td> 
                         <td style="text-align:left; white-space:nowrap;display:none;" class="DOB"><%# Eval("Dob") %></td>
                          <td style="text-align:left; white-space:nowrap;display:none;" class="addr"><%# Eval("address") %></td>
                          <td style="text-align:left; white-space:nowrap;display:none;" class="SClearance"><%# Eval("SecurityClearance") %></td>

                        <td style="text-align:left; white-space:nowrap;display:none;" class="VFrom"><%# Eval("ValidFrom") %></td>
                        <td style="text-align:left; white-space:nowrap;display:none;" class="VTo"><%# Eval("ValidTo") %></td>
                        <td style="text-align:left; white-space:nowrap;display:none;" class="FMAuthType"><%# Eval("AuthenticationType") %></td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
   <%--     </tbody>
    </table>--%>

    #EndFM#
</asp:Content>


