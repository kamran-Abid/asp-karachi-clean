<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="ServantsHandler.aspx.cs" Inherits="RMS_CallBack_ServantsHandler" %>
 <%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    #StartServant#    
  <%--  <table id="tblServant" class="form">
        <tr>
            <td class="right">Id:</td>
            <td>
                <input type="text" id="txtIdST" runat="server" disabled="disabled" />
            </td>

            <td colspan="2" rowspan="4">
               
                   <cc1:AsyncFileUpload OnClientUploadComplete="uploadCompleteForServant" runat="server" ID="AsyncFileUploadForServant"
        Width="400px" UploaderStyle="Modern" ClientIDMode="AutoID" CompleteBackColor="White" UploadingBackColor="#CCFFFF" 
        ThrobberID="imgLoader"  OnUploadedComplete="FileUploadCompleteForServant" ToolTip="Click Here"   OnClientUploadStarted = "uploadStartedForServant"/> <span class="btn" style="padding-left:50px;display:none;">select File</span>
                 <asp:HiddenField ID="hdnPictureIdForServant" runat="server" />
    <asp:Image ID="Image2" style="display:none;" runat="server" ImageUrl="../../images/loader.gif" /><br /><br />
 
                        <div class="dummy" id="divdummyClassForServant" style="float: right; margin-right: 100px;">  
                             <img id = "imgDisplayForServant" alt="" src="" style = "display:none;height:100px;width:100px;"/>

                        </div>
            </td>
        </tr>
        <tr>
            <td class="right">Card No:</td>
            <td>
                <input type="text" id="txtCardNoST" runat="server" disabled="disabled" />
            </td>

        </tr>
        <tr>

            <td class="right">First Name:<span class="reqSpan">*</span></td>
            <td>
                <input type="text" id="txtFirstNameST" runat="server" class="req" />
            </td>

        </tr>
        <tr>
            <td class="right">Last Name:<span class="reqSpan">*</span></td>
            <td>
                <input type="text" id="txtLastNameST" runat="server" class="req" />
            </td>
        </tr>
        <tr>
            <td class="right" style="width: 20%;">NIC:<span class="reqSpan">*</span></td>
            <td style="width: 30%;">
                <input type="text" id="txtNICST" runat="server" class="req" />
            </td>
            <td class="right">Current Address:</td>
            <td>
                <input type="text" id="txtCurrentAddST" runat="server" />
            </td>
        </tr>
        <tr>
            <td class="right">Date of Birth:<span class="reqSpan">*</span></td>
            <td>
         <%--       <input type="text" id="txtDOBST" runat="server" class="req" />
                      <asp:TextBox ID="txtDOBST"   CssClass="req"   runat="server" style="width:60%;float: left; margin-right: 5px;"></asp:TextBox>
                         <rjs:popcalendar ID="Popcalendar3" Separator="/" Format="mm dd yyyy" Control="txtDOBST" runat="server"
                                Font-Names="Tahoma" />
            </td>
            <td class="right">Permanent Address:</td>
            <td>
                <input type="text" id="txtPermanentAddST" runat="server" />
            </td>


        </tr>
        <tr>
            <td class="right" style="width: 20%;">Father/Husband:</td>
            <td style="width: 30%;">
                <input type="text" id="txtFH" runat="server" />
            </td>

            <td class="right" style="width: 20%;">Cell Phone:</td>
            <td style="width: 30%;">
                <input type="text" id="txtCellPhoneST" runat="server" />
            </td>

        </tr>
        <tr>
            <td class="right">Religion:</td>
            <td>
                <asp:DropDownList ID="ddlReligionST" runat="server">
                    <asp:ListItem Text="Islam" Value="Islam"></asp:ListItem>
                </asp:DropDownList>
            </td>
            <td class="right">Phone Office:</td>
            <td>
                <input type="text" id="txtPhoneOfficeST" runat="server" />
            </td>

        </tr>
        <tr>
            <td colspan="2"></td>

            <td class="right">Phone Home:</td>
            <td>
                <input type="text" id="txtPhoneHomeST" runat="server" />
            </td>
        </tr>

    </table>--%>
   
   
    #EndServant#
    #StartServantDet#
     <asp:Repeater ID="rptServant" runat="server">
        <ItemTemplate>
            <tr>
                <td>
                  
                  <span  class="tdServantInActive" style="cursor:pointer;" title="Inactive" onclick="InactiveServantRecord('<%# Eval("SID") %>')"> <img src='../images/Cross2.png'/></span>
                              <span  class="tdServantActive" style="cursor:pointer;" title="Active"  onclick="ActivateServantRecord('<%# Eval("SID") %>')"> <img   src='../images/Active.png'/>    </span>
                            <span  class="tdServantBlackList" style="cursor:pointer;"  title="Black List" onclick="BlackListServantRecord('<%# Eval("SID") %>')"> <img   src="../../images/Blacklist.png"/></span>


               <span class="edit-icon" onclick="editServant('<%# Eval("SID") %>',this)">
                     <img src='../images/Edit.png'/>
                    </span> </td>             
                   <%--<td style=" /*/*text-align:center;cursor:pointer;*/*/" onclick="getServantFamily('<%# Eval("SID") %>','Grid','<%# Eval("EID") %>');"><span  style="color:blue;"><%# Eval("ServantFamilyMember") %></span></td>--%>
                <%--<td class="center cardNo"><%# Eval("CardNumber") %></td>--%>
                 <td style="text-align:left; white-space:nowrap;display:none;" class="eid"><%# Eval("EID") %></td>
                 <td style="text-align:left; white-space:nowrap;" class="eidName"><%# Eval("EmployeeName") %></td>
                <td style="text-align:left; white-space:nowrap; display:none;" class="firstName"><%# Eval("FirstName") %></td>
                <td style="text-align:left; white-space:nowrap;display:none;" class="lastName"><%# Eval("LastName") %></td>

                <td style="text-align:left; white-space:nowrap;" class="fullName"><%# Eval("FirstName") %> <%# Eval("LastName") %></td>
                <td style="text-align:left; white-space:nowrap;" class="fh"><%# Eval("FH") %></td>
                <td style="text-align:left; white-space:nowrap;" class="BC"><%# Eval("BCNumber") %></td>
                <td style="text-align:left; white-space:nowrap;" class="dob"><%# Eval("DOB") %></td>
                <%--<td style="text-align:left; white-space:nowrap;display:none;" class="religion"><%# Eval("Religion") %></td>--%>
                <%--<td style="text-align:left; white-space:nowrap;" class="religionName"><%# Eval("Religion_Name") %></td>--%>
                <td style="text-align:left; white-space:nowrap;" class="nic"><%# Eval("NIC") %></td>
                <td style="text-align:left; white-space:nowrap;" class="mob"><%# Eval("mobile") %></td>
                <%--<td style="text-align:left; white-space:nowrap;display:none;" class="phof"><%# Eval("phoneoffice") %></td>--%>
                <%--<td style="text-align:left; white-space:nowrap;display:none;" class="phHome"><%# Eval("phonehome") %></td>--%>
                 <%--<td style="text-align:left; white-space:nowrap;display:none;" class="PlaceofWork"><%# Eval("PlaceofWork") %></td>--%> 
                 <%--<td style="text-align:left; white-space:nowrap;display:none;" class="MarkofIdentification"><%# Eval("MarkofIdentification") %></td>--%> 
                <%--<td style="text-align:left; white-space:nowrap;display:none;" class="curAddr"><%# Eval("CurrAddr") %></td>--%>    
                <td style="text-align:left; white-space:nowrap;display:none;" class="PerAdd"><%# Eval("PerAddr") %></td>
                <td style="text-align:left; white-space:nowrap;display:none;" class="Identification"><%# Eval("MarkofIdentification") %></td>

                 <td style="text-align:left; white-space:nowrap;display:none;" class="VFrom"><%# Eval("ValidFrom") %></td>
                <td style="text-align:left; white-space:nowrap;display:none;" class="VTo"><%# Eval("ValidTo") %></td>

                  <td style="text-align:left; white-space:nowrap;display:none;" class="SClearance"><%# Eval("SecurityClearance") %></td>
                <td style="text-align:left; white-space:nowrap;display:none;" class="ClearanceL"><%# Eval("ClearanceLevel") %></td>

                <td style="text-align:left; white-space:nowrap;display:none;" class="status"><%# Eval("Status") %></td>
                <td style="text-align:left; white-space:nowrap;display:none;" class="SAuthType"><%# Eval("AuthenticationType") %></td>
                 <%--<td style="text-align:left; white-space:nowrap;display:none;" class="ownerNameofServant"><%# Eval("ownerName") %></td>--%>
             <%--   <td class="phto33" style="display:none">
                        <asp:Image ID="ImageForServant"  runat="server" Height="50px" Width="50px" ImageUrl='<%#"../RMS/EmpPictures/EmpServantPicture/"+Eval("Photo")+".jpg" %>'/>
                 </td>--%>

                <%--<td class="phto">  <img  src='<%# "../RMS/CallBack/GetImageDatafromDB.aspx?PrimaryKeyIDValue=" + System.Convert.ToString(Eval("SID") + "&tableName=Servant&ImagecolumnName=NewPhoto&PrimaryKeyColumnName=SID&date="+DateTime.Now+"") %>' height="50px" width="50px"/>--%>
                     <td class="phto"> <img  src='../RMS/EmpPictures/EmpServantPicture/<%# Eval("Photo") %>.jpg' height="50px" width="50px"/>
                 
                        </td> 
                        <td><span class="edit-icon" onclick="ShowDetails_ModalForServant('<%# Eval("SID") %>',this,'1')"><img style="padding-left:10%;" src='../images/Details.png'/></span> </td>                       
                    </tr>
          
        </ItemTemplate>
    </asp:Repeater>
    #EndServantDet#
  <%--  #StartFMS#
    <asp:Repeater ID="rptServantFamily" runat="server">
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


