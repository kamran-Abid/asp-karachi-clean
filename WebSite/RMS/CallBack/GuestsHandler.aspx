<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="GuestsHandler.aspx.cs" Inherits="RMS_CallBack_GuestsHandler" %>
 <%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src="../ResidentsEmp.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    #StartGuest#    
    #EndGuest#
    #StartGuestDet#
     <asp:Repeater ID="rptGuest" runat="server">
        <ItemTemplate>
            <tr>
                <td>
                  
                  <span  class="tdGuestInActive" style="cursor:pointer;" title="Inactive" onclick="InactiveGuestRecord('<%# Eval("GID") %>')"> <img src='../images/Cross2.png'/></span>
                              <span  class="tdGuestActive" style="cursor:pointer;" title="Active"  onclick="ActivateGuestRecord('<%# Eval("GID") %>')"> <img   src='../images/Active.png'/>    </span>
                            <span  class="tdGuestBlackList" style="cursor:pointer;"  title="Black List" onclick="BlackListGuestRecord('<%# Eval("GID") %>')"> <img   src="../../images/Blacklist.png"/></span>
                    <span class="edit-icon" onclick="editGuest('<%# Eval("GID") %>',this)">
                     <img src='../images/Edit.png'/>
                    </span>


                   

                   
                </td>             
                   <%--<td style=" /*/*text-align:center;cursor:pointer;*/*/" onclick="getGuestFamily('<%# Eval("SID") %>','Grid','<%# Eval("EID") %>');"><span  style="color:blue;"><%# Eval("GuestFamilyMember") %></span></td>--%>
                <td style="text-align:left; white-space:nowrap; display:none;" class="eid"><%# Eval("EID") %></td>
                <td style="text-align:left; white-space:nowrap;" class="HostName"><%# Eval("FirstName") %></td>
                <td style="text-align:left; white-space:nowrap;" class="GuestName"><%# Eval("Name") %></td>
                <td style="text-align:left; white-space:nowrap;" class="GuestFatherName"><%# Eval("FatherName") %></td>
                <td style="text-align:left; white-space:nowrap; display:none;" class="GuestDoB"><%# Eval("DOB") %></td>--%>
                <td style="text-align:left; white-space:nowrap;" class="GuestCNIC"><%# Eval("CNIC") %></td>
                <td style="text-align:left; white-space:nowrap; " class="GuestMobile"><%# Eval("MobileNumber") %></td>
                <td style="text-align:left; white-space:nowrap; display:none;" class="GuestNationality"><%# Eval("Nationality") %></td>
                <td style="text-align:left; white-space:nowrap;" class="GuestRelation"><%# Eval("Relation_Name") %></td>
                <td style="text-align:left; white-space:nowrap; display:none;" class="GuestAge"><%# Eval("Age") %></td>
                <td style="text-align:left; white-space:nowrap; display:none;" class="GuestGender"><%# Eval("Gender") %></td>
                <td style="text-align:left; white-space:nowrap; display:none;" class="GuestOccupation"><%# Eval("Occupation") %></td>
                <td style="text-align:left; white-space:nowrap; display:none;" class="GuestAddress"><%# Eval("Address") %></td>
                <td style="text-align:left; white-space:nowrap; display:none;" class="GuestIdentification"><%# Eval("IdentificationMark") %></td>
                <td style="text-align:left; white-space:nowrap; display:none;" class="GuestValidTo"><%# Eval("ValidityTo") %></td>
                <td style="text-align:left; white-space:nowrap; display:none;" class="GuestValidFrom"><%# Eval("ValidityFrom") %></td>
                <td style="text-align:left; white-space:nowrap; display:none;" class="GuestSecurity"><%# Eval("SecurityClearance") %></td>
                <td style="text-align:left; white-space:nowrap; display:none;" class="GuestCLevel"><%# Eval("ClearLevel") %></td>
                <td style="text-align:left; white-space:nowrap; display:none;" class="status"><%# Eval("CStatus") %></td>--%>
                
                <%--<td class="EmpName"><%# Eval("FirstName") %></td>--%>
                 <%--<td style="text-align:left; white-space:nowrap;display:none;" class="eid"><%# Eval("EID") %></td>
                 <td style="text-align:left; white-space:nowrap;" class="eidName"><%# Eval("EmployeeName") %></td>
                <td style="text-align:left; white-space:nowrap; display:none;" class="firstName"><%# Eval("FirstName") %></td>
                <td style="text-align:left; white-space:nowrap;display:none;" class="lastName"><%# Eval("LastName") %></td>

                <td style="text-align:left; white-space:nowrap;" class="fullName"><%# Eval("FirstName") %> <%# Eval("LastName") %></td>
                <td style="text-align:left; white-space:nowrap;" class="fh"><%# Eval("FH") %></td>
                <td style="text-align:left; white-space:nowrap;" class="BC"><%# Eval("BCNumber") %></td>
                <td style="text-align:left; white-space:nowrap;" class="dob"><%# Eval("DOB") %></td>--%>
                <%--<td style="text-align:left; white-space:nowrap;display:none;" class="religion"><%# Eval("Religion") %></td>--%>
                <%--<td style="text-align:left; white-space:nowrap;" class="religionName"><%# Eval("Religion_Name") %></td>--%>
                <%--<td style="text-align:left; white-space:nowrap;" class="nic"><%# Eval("NIC") %></td>
                <td style="text-align:left; white-space:nowrap;" class="mob"><%# Eval("mobile") %></td>--%>
                <%--<td style="text-align:left; white-space:nowrap;display:none;" class="phof"><%# Eval("phoneoffice") %></td>--%>
                <%--<td style="text-align:left; white-space:nowrap;display:none;" class="phHome"><%# Eval("phonehome") %></td>--%>
                 <%--<td style="text-align:left; white-space:nowrap;display:none;" class="PlaceofWork"><%# Eval("PlaceofWork") %></td>--%> 
                 <%--<td style="text-align:left; white-space:nowrap;display:none;" class="MarkofIdentification"><%# Eval("MarkofIdentification") %></td>--%> 
                <%--<td style="text-align:left; white-space:nowrap;display:none;" class="curAddr"><%# Eval("CurrAddr") %></td>--%>    
                <%--<td style="text-align:left; white-space:nowrap;display:none;" class="PerAdd"><%# Eval("PerAddr") %></td>
                <td style="text-align:left; white-space:nowrap;display:none;" class="Identification"><%# Eval("MarkofIdentification") %></td>

                 <td style="text-align:left; white-space:nowrap;display:none;" class="VFrom"><%# Eval("ValidFrom") %></td>
                <td style="text-align:left; white-space:nowrap;display:none;" class="VTo"><%# Eval("ValidTo") %></td>

                  <td style="text-align:left; white-space:nowrap;display:none;" class="SClearance"><%# Eval("SecurityClearance") %></td>
                <td style="text-align:left; white-space:nowrap;display:none;" class="ClearanceL"><%# Eval("ClearanceLevel") %></td>

                <td style="text-align:left; white-space:nowrap;display:nones;" class="status"><%# Eval("Status") %></td>--%>
                 <%--<td style="text-align:left; white-space:nowrap;display:none;" class="ownerNameofGuest"><%# Eval("ownerName") %></td>--%>
             <%--   <td class="phto33" style="display:none">
                        <asp:Image ID="ImageForGuest"  runat="server" Height="50px" Width="50px" ImageUrl='<%#"../RMS/EmpPictures/EmpGuestPicture/"+Eval("Photo")+".jpg" %>'/>
                 </td>--%>

                <%--<td class="phto">  <img  src='<%# "../RMS/CallBack/GetImageDatafromDB.aspx?PrimaryKeyIDValue=" + System.Convert.ToString(Eval("GID") + "&tableName=ResidantGuest&ImagecolumnName=NewPhoto&PrimaryKeyColumnName=GID&date="+DateTime.Now+"") %>' height="50px" width="50px"/>--%>
                  <td class="phto">  <img  src='../RMS/EmpPictures/EmpGuestPicture/<%# Eval("photo") %>.jpg' height="50px" width="50px"/>
                        </td> 
                        <td><span class="edit-icon" onclick="ShowDetails_ModalForGuest('<%# Eval("GID") %>',this,'1')"><img style="padding-left:10%;" src='../images/Details.png'/></span> </td>                       
                    </tr>
          
        </ItemTemplate>
    </asp:Repeater>
    #EndGuestDet#
  <%--  #StartFMS#
    <asp:Repeater ID="rptGuestFamily" runat="server">
        <ItemTemplate>
            <tr>
                <td><span class="edit-icon" onclick="editFMS('<%# Eval("EID") %>','<%# Eval("SFID") %>',this)">
                     <img src='../images/Edit.png'/>
                    </span> </td>
                <td class="center cardNo"><%# Eval("CardNumber") %></td>
                <td class="firstName"><%# Eval("FirstName") %></td>
                <td class="lastName"><%# Eval("LastName") %></td>
                <td class="relation"><%# Eval("Relation") %></td>
                <td class="nic"><%# Eval("NIC") %></td>
                <td class="prof"><%# Eval("Profession") %></td>
                <td class="pow"><%# Eval("PlaceofWork") %></td>
                <td class="mob"><%# Eval("Mobile") %></td>
            </tr>
        </ItemTemplate>
    </asp:Repeater>
    #EndFMS#--%>

     
</asp:Content>


