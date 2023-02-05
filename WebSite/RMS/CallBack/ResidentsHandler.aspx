<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="ResidentsHandler.aspx.cs" Inherits="RMS_CallBack_ResidentsHandler" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    #StartResident#
            <asp:Repeater ID="rptResident" runat="server">
                <ItemTemplate>
                    <tr>                       
                        <td style="display:none;">
                              <span  class="ResidentActive" style="cursor:pointer;" title="Active"  onclick="ActivateEmployee('<%# Eval("EID") %>')"> <img   src='../images/Active.png'/>    </span>
                            <span  class="ResidentBlackList" style="cursor:pointer;"  title="Black List" onclick="BlackListPACSResident('<%# Eval("EID") %>')"> <img   src="../../images/Blacklist.png"/></span>
                        </td>
                          <td>
                              <span  class="ResidentInActive" style="cursor:pointer;" title="Inactive" onclick="InactiveEmployee('<%# Eval("EID") %>')"> <img src='../images/Cross2.png'/></span>
                          </td>

                        <td><span class="edit-icon" title="Edit" onclick="editResident('<%# Eval("EID") %>',this,)">
                            <img  src='../images/Edit.png'/>
                            </span>
                        </td>
                        
                        <%--<td class="EIDs" style="text-align:center;cursor:pointer;" onclick="getFamilyMembers('<%# Eval("Rasidant_Status_Name") %>','<%# Eval("EID") %>','Grid');"><span  style="color:blue;"><%# Eval("FamilyMembers") %></span></td>
                        <td style=" text-align:center;cursor:pointer;" onclick="getServants('<%# Eval("Rasidant_Status_Name") %>','<%# Eval("EID") %>','Grid');"><span  style="color:blue;"><%# Eval("Servants") %></span></td>
                        <td style=" text-align:center;cursor:pointer;"  onclick ="getGuests('<%# Eval("Rasidant_Status_Name") %>','<%# Eval("EID") %>','Grid');"><span  style="color:blue;"><%# Eval("Guests") %></span></td>--%>
                        <td style="text-align:left; white-space:nowrap;" class="pno"><%# Eval("ServiceNo") %></td>
                        
                        <td style="text-align:left; white-space:nowrap;display:none" class="fn"><%# Eval("FirstName") %></td>
                        <td style="text-align:left; white-space:nowrap;display:none" class="ln"><%# Eval("LastName") %></td>

                        <td style="text-align:left; display:nones" class="fullName"><%# Eval("FirstName") %> <%# Eval("LastName") %></td>

                       <td style="white-space:nowrap;display:none;" class="reld"><%# Eval("ValidUpto") %></td>
                        <td style="white-space:nowrap;display:none;" class="rank"><%# Eval("Rank") %></td>
                        <td style="display:nones;" class="rankName"><%# Eval("Rank_Name") %></td>

                        <td style="white-space:nowrap;display:none;" class="desg"><%# Eval("Designation") %></td>                         
                        <td style="white-space:nowrap;display:none;" class="desgn"><%# Eval("DesignationName") %></td>

                        <td style="text-align:left; white-space:nowrap;" class="nic"><%# Eval("NIC") %></td>
                        <td style="text-align:left; white-space:nowrap;display:none;" class="DOB"><%# Eval("DOB") %></td>
                        
                        <td style="text-align:left; white-space:nowrap;" class="deptName"><%# Eval("Department") %></td>
                        
                        <td style="text-align:left; white-space:nowrap;display:none;" class="dept"><%# Eval("Deparment_id") %></td>

                        <td style="text-align:left; white-space:nowrap;display:none;" class="mob"><%# Eval("Mobile") %></td>
                        <td style="text-align:left; white-space:nowrap;display:none;" class="pof"><%# Eval("PhoneOffice") %></td>
                        
                        <td style="text-align:left; white-space:nowrap;display:none;" class="cAdd"><%# Eval("CurrAddr") %></td>
                        <td style="text-align:left; white-space:nowrap;display:none;" class="pAdd"><%# Eval("PerAddr") %></td>

                        <td style="text-align:left; white-space:nowrap;display:none;" class="MName"><%# Eval("MotherName") %></td>
                        <td style="text-align:left; white-space:nowrap;display:none;" class="FName"><%# Eval("FatherName") %></td>
                        
                        <td style="text-align:left; white-space:nowrap;display:none;" class="BGrop"><%# Eval("BloodGroup") %></td>
                        <td style="text-align:left; white-space:nowrap;display:none;" class="IdtM"><%# Eval("IdentificationMark") %></td>
                        
                        <td style="text-align:left; white-space:nowrap;display:none;" class="Cad"><%# Eval("Cadre") %></td>
                        <td style="text-align:left; white-space:nowrap;display:none;" class="CadName"><%# Eval("Cadre_Name") %></td>

                           <td style="text-align:left; white-space:nowrap;display:none;" class="Sstaus"><%# Eval("ResidantStatus") %></td>
                        <td style="text-align:left; white-space:nowrap;display:none;" class="RaStatusName"><%# Eval("Rasidant_Status_Name") %></td>
                        
                        
                     <%--      <td style="text-align:left; white-space:nowrap;display:none;" class="CColor"><%# Eval("CardColor") %></td>
                        <td style="text-align:left; white-space:nowrap;display:none;" class="CName"><%# Eval("ColorName") %></td>--%>

                        
                           <%--<td style="text-align:left; white-space:nowrap;display:none;" class="Tranp"><%# Eval("Transport") %></td>
                        <td style="text-align:left; white-space:nowrap;display:none;" class="TranpName"><%# Eval("Transport_Name") %></td>--%>

                          <td style="text-align:left; white-space:nowrap;display:none;" class="CLevel"><%# Eval("ClearanceLevel") %></td>
                        <td style="text-align:left; white-space:nowrap;display:none;" class="CName"><%# Eval("Site_Name") %></td>

                        <td style="text-align:left; white-space:nowrap;display:none;" class="Section"><%# Eval("Section") %></td>

                          <td style="text-align:left; white-space:nowrap;display:none;" class="CStatus"><%# Eval("ClearanceStatus") %></td>

                        <td style="text-align:left; white-space:nowrap; display:none;" class="status"><%# Eval("Status") %></td>
                        <td style="text-align:left; white-space:nowrap;display:none;" class="gender"><%# Eval("GenID") %></td>
                        <td style="text-align:left; white-space:nowrap; display:none;" class="Remarks"><%#Eval("Remarks") %></td>
                        <td style="text-align:left; white-space:nowrap;display:none;" class="PHome"><%# Eval("PhoneHome") %></td>
                        <td style="text-align:left; white-space:nowrap;display:none;" class="AuthType"><%# Eval("AuthenticationType") %></td>
                        
                       <%-- <td class="phto" style="display:none;">
                       <asp:Image ID="Image" runat="server" Width="50px" Height="50px" ImageUrl='<%#"../RMS/EmpPictures/"+Eval("photo")+".jpg" %>'/>
   
                        </td>--%> 
                         <%--td class="newImage">  <img  src='<%#"../RMS/CallBack/cc.aspx?PrimaryKeyIDValue=" + System.Convert.ToString(Eval("EID") + "&tableName=Employee&ImagecolumnName=NIC&PrimaryKeyColumnName=EID&date="+DateTime.Now+"") %>' height="50px" width="50px"/>--%>
                              <td class="newImage"> <img  src='../RMS/EmpPictures/<%# Eval("PHOTO") %>.jpg' height="50px" width="50px"/>
                        </td>
                         <td><span class="edit-icon" onclick="ShowDetails_Modal('<%# Eval("EID") %>',this,'1')"><img style="padding-left:10%;" src='../images/Details.png'/></span> </td>     
                        <td style="text-align:left; white-space:nowrap;" class="deptName"><%# Eval("Remarks") %></td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
    #EndResident#
</asp:Content>


