<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="Residents.aspx.cs" Inherits="Residents_Residents" EnableEventValidation="false" %>

 <%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

        <script src="EmpResidentsNew.js"></script>

    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    
          <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
          <fieldset>
            <legend>Employee Search Criteria</legend>
            <table id="tblSearchCriteria" class="form">
                <tr>
                    <td class="right" style="width: 10%;">CNIC/HR No:</td>
                    <td style="width: 22%;">
                        <input type="text"  id="txtCardNIC" maxlength="13" placeholder="Enter HR No/ CNIC without (-)" />
                    </td>
                    <td class="right" style="width: 10%;">Department:



                    </td>
                    <td style="width: 22%;">
                  

                        <asp:DropDownList ID="ddlDepartmentSearch" class="chzn-select" runat="server">                            
                        </asp:DropDownList>
                   
                    </td>
                    <td class="right" style="width: 10%;">Appointment:</td>
                    <td>
                   

                        <asp:DropDownList ID="ddlDesignationSearch" class="chzn-select" runat="server">                            
                        </asp:DropDownList>
                   
                            </td>
                    
                </tr>
                <tr>
                    <td class="right" style="width: 10%;">Name:</td>
                    <td style="width: 22%;">
                        <input type="text" class="alpha" placeholder="Enter Employee Name" id="txtNameSearch" />
                    </td>
                    <td class="right" style="width: 10%;">Rank:</td>
                    <td>                  
                        <asp:DropDownList ID="ddlRankSearch" class="chzn-select" runat="server">                            
                        </asp:DropDownList>
                        </td>
                    <td class="right" style="width: 10%; display:none;">Status:</td>
                    <td style="width: 22%;  display:none;">
                        <asp:DropDownList ID="ddlStatusSearch" class="chzn-select" runat="server">
                               <asp:ListItem Text="All" Value=""></asp:ListItem>
                               <asp:ListItem Text="Active" Value="Active"></asp:ListItem>
                                <asp:ListItem Text="Inactive" Value="Inactive"></asp:ListItem>
                                <asp:ListItem Text="Black List" Value="BlackList"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center">
                        <input type="button" id="btnSearch" class="btn" value="Search" onclick="getResidents();" />  
                        <input type="button" id="btnClear1" class="btn" value="Clear" onclick="clearSearchCriteria();" />
                        <asp:Button  ID="btnClear" class="btn" runat="server" Text="Refresh" OnClick="ClearAll"/>
                    </td>
                </tr>
            </table>
        </fieldset>

        <div style="padding: 10px; text-align: center;">
            <input type="button" id="btnAddEmployee" class="btn" value="Add Employee" onclick="addNewEmployee();" />
        </div>

        <fieldset id="fieldsetPersonalGrd" style="width: 97%;">
            <legend>Employee</legend>
            <div>
                <asp:Label ID="lblCountEmp" runat="server" Text="<b>Active Employees:</b>"></asp:Label>

                <asp:TextBox ID="txtCountEmp" runat="server" Width="5%"  readonly="true"  BackColor="#cccccc" BorderColor="#000000" BorderWidth="2px" Font-Size="Large" ></asp:TextBox></div>

            
            <div style="padding-bottom: 20px; width: 100%; max-height: 440px; overflow:auto; ">
                <table class="dataTable">
                    <thead>
                        <tr>
                           <th>Delete</th>
                            <th>Edit</th>

                            <%--<th>F.Members</th>
                            <th>Servants</th>
                            <th>Guests</th>--%>
                            <th>HR NO.</th>
                            <th> Name</th>
                            <th style="display:none;">ReleadDate</th>
                            <th>Rank</th>

                            <th style="display:none;">Rank ID</th>

                            <th style="display:none">Designation</th>
                            <th style="display:none">DesignationName</th>

                            <th>CNIC #</th>
                            <th style="display:none;">Date of Birth</th>
                            
                            <th>Department</th>
                            <th style="display:none;">Department ID</th>

                            
                            <th style="display:none;">Cell #</th>
                            <th style="display:none;">Phone Office</th>

                            <th style="display:none;">Current Address</th>
                            <th style="display:none;">Permanent Address</th>

                             <th style="display:none;">Mother Name</th>
                            <th style="display:none;">Father Name</th>

                             <th style="display:none;">BloodGroup</th>
                            <th style="display:none;">IdentificationMark</th>

                             <th style="display:none;">CadreID</th>
                            <th style="display:none;">Cadre Name</th>

                            <th style="display:none;">ResidantID</th>
                            

                             <th style="display:none;">CardColorID</th>
                            <th style="display:none;">ColorName</th>

                            <th style="display:none;">TransportID</th>
                            <th style="display:none;">TransportName</th>

                             <th style="display:none;">ClearanceLevelID</th>
                            <th style="display:none;">Site_Name</th>
                            <th style="display:none;">Section</th>
                              <th style="display:none;">ClearanceStatus</th>
                            <th style="display:none;">Status</th>
                            <th style="display:none;">Gender</th>
                            <th style="display:none;">PhoneHome</th>
                            <th style="display:none;">AuthType</th>
                            <th>Photo</th>
                            <th>Detail</th>
                            <th>Remarks</th>
                        </tr>
                    </thead>
                    <tbody id="tbodyResidents" style="background-color:white;">
                        <tr>
                            <td colspan="19">&nbsp;</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </fieldset>

        <div id="fieldsetPersonal" style="display: block;width:97%" >

               <fieldset  style="height:100%">
            <legend>Personal</legend>
            <table id="tblPersonal" class="form" style="height:50%; height:100%">

                 <tr id="trClose">
                    <td style="text-align: right; border: none">
                        <div id="close">
                            <img src='../images/btn_close02.png' style="background: none repeat scroll 0 0 transparent;
                                border: medium none; height: 32px; margin-top: -52px; position: absolute; width: 32px;
                                cursor: pointer; right: 434px; left: 98%;" alt="Close" onclick='return CloseModal();' />
                        </div>
                    </td>
                </tr>
                <%--<caption  style="text-align:left; color:red;">Note: All Fields marked with asterik(*) are mandatory.</caption>--%>

                <tr style="line-height:12px;">
                    <td class="right">Id:</td>
                    <td>
                        <input type="text" id="txtId"  disabled="disabled"/>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                    <td rowspan="4" align="left">
                     <div style="margin-right: 0px;">
                        <cc1:AsyncFileUpload OnClientUploadComplete="uploadComplete2" runat="server" ID="AsyncFileUpload1"
        Width="400px" UploaderStyle="Modern" ClientIDMode="AutoID" CompleteBackColor="White" UploadingBackColor="#CCFFFF" 
        ThrobberID="imgLoader"  OnUploadedComplete="FileUploadComplete" ToolTip="Click Here"   OnClientUploadStarted = "uploadStarted"/> <span class="btn" style="padding-left:50px;display:none;">select File</span>
                 <asp:HiddenField ID="hdnPictureId" runat="server" />
    <asp:Image ID="imgLoader" runat="server" ImageUrl="../images/loader.gif" /><br /><br />
 </div>
                        <div class="dummy" id="divdummyClass" style="display:none; float: right; margin-right: 100px;">  
                             
                        </div>

                        <div  style="float:left; margin-right: 100px;">  
                 <img id = "imgDisplay" alt="" src="" style = "display:none;height:100px;width:100px;"/>

            <div class="camera" style="float:left">
            <video id="videoEmp" style ="height:150px;width:150px;">Video stream not available.</video>
        </div>
       
        <canvas id="canvasEmp" style="display:none"></canvas>
        <div class="output">
            <img id="photoEmp" alt="The screen capture will appear in this box." style =" float:left height:130px;width:150px;">
        </div>
        <div>
             <div>
                 <input type="button" class="btn btn-primary" id="startbuttonEmp" value="Capture" />
                  <input type="button" class="btn btn-primary" id="Recaptures" onclick="Recapture();" value="ReCapture" />
                  
             </div>
            <input type="button" class="btn btn-primary" value="WebCam" id="WebCamCallEmps" onclick="WebCamCallEmp();"/>
        </div>
                        </div>

                    </td>
                </tr>
                
                <tr>
                    <td class="right">HR NO:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtPNO" placeholder="HR No#" onblur="getEmployeeResultByHRNo();"  />
                    </td>
                </tr>
                <tr>

                    <td class="right">First Name:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtFirstName" class="req alpha"  placeholder="First Name"/>
                    </td>

                </tr>
                <tr>
                    <td class="right" style="width: 20%;">Last Name:<span class="reqSpan">*</span></td>
                    <td style="width: 30%;">
                        <input type="text" id="txtLastName" class="req alpha" placeholder="Last Name" />
                    </td>

                

                </tr>
                <tr>
                    <td class="right">CNIC:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" runat="server" id="txtNIC" class="req" placeholder="Enter CNIC" maxlength="13" onblur="getEmployeeResultByCNIC();" />
                    </td>
                   
                    
                </tr>
                <tr>

                 
                    <td class="right">Rank:</td>
                    <td>
                        <asp:DropDownList ID="ddlRank" runat="server"  class="chzn-select" >                            
                        </asp:DropDownList>
                    </td>
                  <td class="right">Validity Upto:<span class="reqSpan">*</span></td>
                    <td>
                        
                        <asp:TextBox ID="txtValidity" CssClass="date req"   runat="server" style="width:60%;float: left; margin-right: 5px;"></asp:TextBox>
                         <rjs:popcalendar ID="Popcalendar1" Separator="/" Format="mm dd yyyy" Control="txtValidity" runat="server" Font-Names="Tahoma" />
                    </td>
                </tr>
                
                <tr>

                     <td class="right">Appointment:<span class="reqSpan">*</span></td>
                <td>
                    <asp:DropDownList ID="ddlDesignation" runat="server" class="chzn-select">
                        
                    </asp:DropDownList>
                </td>
                      <%--<td class="right">Current Adr:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtCurrentAdd" class="req" />
                    </td>--%>
                </tr>
                <tr>
                    <td class="right">Department:<span class="reqSpan">*</span></td>
                    <td>
                        <asp:DropDownList ID="ddlDeptUnit" runat="server" class="chzn-select">                            
                        </asp:DropDownList>
                    </td>
                    <%--<td class="right">Permanent Adr:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtPermanentAdd" class="req" />
                    </td>--%>


                </tr>
                <tr>
                    <%--<td class="right">Card Type:<span class="reqSpan">*</span></td>
                        <td>
                            <asp:DropDownList ID="ddlCardType" runat="server" class="req">
                                <asp:ListItem Text="Resident" Value="Resident"></asp:ListItem>
                            </asp:DropDownList>
                        </td>--%>
                  
                    <td class="right">Cell Phone:</td>
                    <td>
                        <input type="text" id="txtCellPhone" placeholder="Enter Mobile No#"/>
                    </td>
                      <%--<td class="right">Phone Home:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtPhoneHome"/>
                    </td>--%>
                </tr>
                <tr>
                    <%--<td class="right">DOB:<span class="reqSpan">*</span></td>
                    <td>
                        
                         <asp:TextBox ID="txtDOB"  CssClass="date req"   runat="server" style="width:60%;float: left; margin-right: 5px;"></asp:TextBox>
                         <rjs:popcalendar ID="rjsDOB" Separator="/" Format="mm dd yyyy" Control="txtDOB" runat="server"  To-Today="true"
                                Font-Names="Tahoma" />

                    </td>--%>
                   <%-- <td class="right">Phone Office:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtPhoneOffice" class="phone" />
                    </td>--%>
                </tr>
            
              
                 <tr>
                            <td class="right">Clearance Status:<span class="reqSpan">*</span></td>
                <td>
                    <asp:DropDownList ID="ddlclearanceStatus" CssClass="req" runat="server">
                        
                    </asp:DropDownList>
                </td>
                <%--<td class="right">Section:<span class="reqSpan">*</span></td>
                <td>
                    <asp:DropDownList ID="txtSection" CssClass="req" runat="server">
                        
                    </asp:DropDownList>
                   
                </td>--%>
          
            </tr>

                 <tr>
                            <td class="right">Gender:<span class="reqSpan">*</span></td>
                <td>
                    <asp:DropDownList ID="ddlGender" CssClass="req" runat="server">
                        
                    </asp:DropDownList>
                </td>
                <%--<td class="right">Blood Group:<span class="reqSpan">*</span></td>
                <td>
                    <asp:DropDownList ID="txtBloodGroup" CssClass="req" runat="server">
                        
                    </asp:DropDownList>
                    
                </td>--%>
          
            </tr>

             <%-- <tr>
                <td class="right">Father Name:<span class="reqSpan">*</span></td>
                <td>
                    <input type="text" id="txtFatherName" class="alpha"   />
                </td>
                 <td class="right">Mother Name:<span class="reqSpan">*</span></td>
                <td>
                    <input type="text" id="txtMotherName" class="alpha"   />
                </td>
            </tr>--%>
             <%--<tr>
               <td class="right">Identification Mark:<span class="reqSpan">*</span></td>
                <td>
                     <input type="text" id="txtEmployeeIdentificationMark" class="alpha"   />
                </td>
                 <td class="right">Cadre:<span class="reqSpan">*</span></td>
                <td>
                    <asp:DropDownList ID="ddlCadre" runat="server">                        
                    </asp:DropDownList>
                </td>
            </tr>--%>
                <tr>
                       <%--<td class="right">Resident Status:<span class="reqSpan">*</span></td>
                <td>
                    <asp:DropDownList ID="ddlResidant" runat="server">                        
                    </asp:DropDownList>
                </td>--%>
               <%-- <td class="right">Card Color:<span class="reqSpan">*</span></td>
                <td>
                   <asp:DropDownList ID="ddlCardColor" runat="server">                        
                    </asp:DropDownList>
                </td>--%>
              
            </tr>
              <tr>
                <%--<td class="right">Transport:<span class="reqSpan">*</span></td>
                <td>
                   <asp:DropDownList ID="ddlTransport" runat="server">                        
                    </asp:DropDownList>
                </td>--%>
                
            </tr>
                <tr style="visibility:collapse;">
                    <td class="right">Site Allowed:<span class="reqSpan">*</span></td>
                <td>
                    <asp:DropDownList ID="ddlSiteAllowed" runat="server">                        
                    </asp:DropDownList>
                </td>
                </tr>
                <tr>
                    <td class="right">Remarks:</td>
                    <td>
                        <input type="text" runat="server" id="txtRemarks" placeholder="Enter Employee Remarks"/>
                    </td>
                </tr>
                <tr>
                    <%--<td class="right">Authentication Type<span class="reqSpan">*</span></td>
                    <td>
                          <asp:DropDownList ID="ResidentAuthenticationType" runat="server">    
                              <asp:ListItem Value="1" Text="Card Only"></asp:ListItem>                    
                              <asp:ListItem Value="2" Text="Finger Only"></asp:ListItem>                    
                              <asp:ListItem Value="3" Text="Card Or Finger "></asp:ListItem>  
                              <asp:ListItem Value="4" Text="Card and Finger "></asp:ListItem>                    
                    </asp:DropDownList>

                       
                    </td>--%>

                </tr>
                </table>

            <div class="btn-wrapper" style="padding-top: 20px;">

               <input type="button" id="btnBackResident" class="btn" value="Back" onclick="BackResidenet();" />
               
                <input type="button" id="btnSaveResident" class="btn" value="Save" onclick="saveResidenet();" />
                <input type="button" id="btnClearResident" class="btn" value="New" onclick="clearResidenet();" />

                <input type="hidden" id="hdnEID" runat="server" value="0" />
            </div>

        </fieldset>

        </div>
     

        <div id="divFMS" style="padding: 10px; text-align: center; display: none;">
            <input type="button" id="btnAddFamilyM" class="btn" value="Add Family Member" onclick="addFamilyM();" />
            <input type="button" id="btnAddServant" class="btn" value="Add Servant" onclick="AddServant();" />
        </div>

        <fieldset id="fieldsetFM" style="display: none;width:96%">
            <legend id="lgndFamilyMember">Family Member</legend>

            <table id="tblFamilyMember" class="form">
                <tr style="line-height:12px;" >
                    <td class="right">Id:</td>
                    <td>
                        <input type="text" id="txtIdFM" disabled="disabled"  />
                    </td>
                    
                    <td colspan="4"   rowspan="4">
                        <div style="float:right; margin-right: 0px;">
                        <cc1:AsyncFileUpload OnClientUploadComplete="uploadCompleteForFamily" runat="server" ID="AsyncFileUploadForFamily"
          Width="400px" UploaderStyle="Modern" ClientIDMode="AutoID" CompleteBackColor="White" UploadingBackColor="#CCFFFF" 
          ThrobberID="imgLoader"  OnUploadedComplete="FileUploadCompleteForFamily" ToolTip="Click Here"   OnClientUploadStarted = "uploadStartedForFamily"/> <span class="btn" style="padding-left:50px;display:none;">select File</span>
                 <asp:HiddenField ID="hdnPictureIdForFamily" runat="server" />
    <asp:Image ID="Image1" style="display:none;" runat="server" ImageUrl="../images/loader.gif" /><br /><br />

                        <div class="dummy" id="divdummyClassForFamily" style="display:none; float: right; margin-right: 100px;">  
                            
                        </div>
                        <div  style="float: right; margin-right: 100px;">  
                 <img id = "imgDisplayForFamily" alt="" src="" style = "display:none;height:100px;width:100px;"/>

            <div class="camera">
            <video id="videoFM" style ="height:150px;width:150px;">Video stream not available.</video>
        </div>
       
        <canvas id="canvasFM" style="display:none"></canvas>
        <div class="output">
            <img id="photoFM" alt="The screen capture will appear in this box." style ="height:130px;width:150px;">
        </div>
        <div>
             <div>
                 <input type="button" class="btn btn-primary" id="startbuttonFM" value="Capture" />
                  <input type="button" class="btn btn-primary" id="RecaptureFM" onclick="RecaptureFMs();" value="ReCapture" />
                  
             </div>
            <input type="button" class="btn btn-primary" value="WebCam" id="WebCamCallFM" onclick="WebCamCallFMs();"/>
        </div>
                        </div>
 </div>
                    </td>

                </tr>
                <tr>
                     <td class="right">First Name:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtFirstNameFM" class="req alpha" />
                    </td>
                   

                </tr>
                <tr>
                     <td class="right">Last Name:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtLastNameFM" class="req alpha" />
                    </td>
                   

                </tr>
                <tr>
                     <td class="right">Relation:<span class="reqSpan">*</span></td>
                    <td>
                        <asp:DropDownList ID="ddlRelationFM" runat="server" class="chzn-select req">                            
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr >
                    <td  class="right" style="width: 20%;display:none;">Father/Husband:</td>
                    <td style="width: 30%;display:none;">
                        <input type="text" id="txtFatherHusbandFM" class="alpha" />
                    </td>
                    <td class="right" style="width: 20%;">CNIC:</td>
                    <td style="width: 30%;">
                        <input type="text" runat="server" id="txtNICFM"  onblur="getEmployeeFamilyResultByCNIC();" />
                    </td>
                    <td class="right">Security Clearance:<span class="reqSpan">*</span></td>
                <td>
                    <asp:DropDownList ID="ddlFamilysecurityClearance" class="chzn-select req" runat="server">
                         
                    </asp:DropDownList>
                </td>
                </tr>
               
                <tr>
                    <td class="right">Dob</td>
                    <td>     
                          <asp:TextBox ID="txtFamilyDOB"  CssClass="date req"   runat="server" style="width:60%;float: left; margin-right: 5px;"></asp:TextBox>
                         <rjs:popcalendar ID="Popcalendar2" Separator="/" Format="mm dd yyyy" Control="txtFamilyDOB" runat="server"  To-Today="true"
                                Font-Names="Tahoma" />
                       
                    </td>

                    <td class="right">Address:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtVisitorAdd" class="req" />
                    </td>
                </tr>

                 <tr>
               
                      <td class="right">Clearance Level:<span class="reqSpan">*</span></td>
                <td>
                    <asp:DropDownList ID="ddlFamilyClearanceLevel" CssClass="req" runat="server">
                        
                    </asp:DropDownList>
                </td>
                                  <td class="right">Gender:<span class="reqSpan">*</span></td>
                <td>
                    <asp:DropDownList ID="ddlFamilyGender" CssClass="req" runat="server">
                        
                    </asp:DropDownList>
                </td>


                 </tr>

                <tr>

                    <td class="right">Valid From</td>
                    <td>
                         <asp:TextBox ID="txtFamilyMemberValidityFrom" CssClass="date req"   runat="server" style="width:60%;float: left; margin-right: 5px;"></asp:TextBox>
                         <rjs:popcalendar ID="Popcalendar10" Separator="/" Format="mm dd yyyy" Control="txtFamilyMemberValidityFrom" runat="server"
                                Font-Names="Tahoma" />
                    </td>
                  <td class="right">Valid To:<span class="reqSpan">*</span></td>
                    <td>
                        
                        <asp:TextBox ID="txtFamilyMemberValidityTo" CssClass="date req"   runat="server" style="width:60%;float: left; margin-right: 5px;"></asp:TextBox>
                         <rjs:popcalendar ID="Popcalendar9" Separator="/" Format="mm dd yyyy" Control="txtFamilyMemberValidityTo" runat="server"
                                Font-Names="Tahoma" />
                    </td>

                </tr>


                <tr>
                    
                         <td class="right">Authentication Type:<span class="reqSpan">*</span></td>
                    <td>
                        <asp:DropDownList ID="FamilyMemberAuthenticationType" CssClass="req" runat="server">
                         <asp:ListItem Value="1" Text="Card Only"></asp:ListItem>                    
                              <asp:ListItem Value="2" Text="Finger Only"></asp:ListItem>                    
                              <asp:ListItem Value="3" Text="Card Or Finger "></asp:ListItem>  
                              <asp:ListItem Value="4" Text="Card and Finger "></asp:ListItem>  
                    </asp:DropDownList>
                    </td>
                </tr>
            </table>
            <div class="btn-wrapper" style="padding: 20px;">

                 <input type="button" id="btnBackFamilyMember" class="btn" value="Back" onclick="BackFamilyMember();" />
               
                <input type="button" id="btnSaveFamilyMember" class="btn" value="Save" onclick="saveFamilyMember();" />
                <input type="button" id="btnClearFamilyMember" class="btn" value="New" onclick="clearFamilyMember();" />
                
            </div>
            <fieldset >
                <legend id="lgndFamilyMemberDetail">Family Members Detail</legend>
            
            <div style="padding-bottom: 20px; width: 98%; max-height: 300px; overflow: auto;">
                <table class="dataTable">
                    <thead>
                        <tr>
                            <th style="display:none;">Action</th>
                            <th>Edit</th>
                            <%--<th>Card #</th>--%>
                            <th>Name</th>
                            <th style="display:none;">First Name</th>
                            <th style="display:none;">Last Name</th>
                            <th>Relation</th>
                            <th>NIC</th>
                            <%--<th>Mobile</th>--%>
                            <%--<th>Address</th>--%>
                            <%--<th>Visit Purpose</th>--%>
                             <th style="display:none;">Status</th>
                             <th style="display:none;">Gender</th>
                             <th style="display:none;">ClearanceLevel</th>
                            <th>Photo</th>
                             <th style="display:none;">Dob</th>
                             <th style="display:none;">address</th>
                             <th style="display:none;">SecurityClearance</th>

                            <th style="display:none;">ValidFrom</th>
                            <th style="display:none;">ValidTo</th>
                            <th style="display:none;">AuthenticationType</th>
                        </tr>
                    </thead>
                    <tbody id="tbodyFM" style="background-color:white;">
                    </tbody>
                </table>
            </div>
                </fieldset>
            
        </fieldset>
        
        <fieldset id="fieldsetServant" style="display: none; width:96.5%;">
            <legend id="lgndAddUpdateServant">Servant</legend>

           
            <div id="divServantInfo">
                 <%--<div class="heading">Servant Info</div>--%>
           <table id="tblServant" class="form">

                <tr id="trCloseforServant">
                    <td style="text-align: right; border: none">
                        <div id="closeforServant">
                            <img src='../images/btn_close02.png' style="background: none repeat scroll 0 0 transparent;
                                border: medium none; height: 32px; margin-top: -52px; position: absolute; width: 32px;
                                cursor: pointer; right: 434px; left: 98%;" alt="Close" onclick='return CloseModalForServant();' />
                        </div>
                    </td>
                </tr>
        <tr style="line-height:12px;" >
            <td class="right">Id:</td>
            <td>
                <input type="text" id="txtIdST" runat="server" disabled="disabled" />
            </td>
            <td>
                &nbsp;
            </td>
            <td  rowspan="4">
               <div style="float: left; margin-right: 0px;">
                   <cc1:AsyncFileUpload OnClientUploadComplete="uploadCompleteForServant" runat="server" ID="AsyncFileUploadForServant"
         Width="400px" UploaderStyle="Modern" ClientIDMode="AutoID" CompleteBackColor="White" UploadingBackColor="#CCFFFF" 
         ThrobberID="imgLoader"  OnUploadedComplete="FileUploadCompleteForServant" ToolTip="Click Here"   OnClientUploadStarted = "uploadStartedForServant"/> 
                 <asp:HiddenField ID="hdnPictureIdForServant" runat="server" />
    <asp:Image ID="Image2" style="display:none;" runat="server" ImageUrl="../../images/loader.gif" /><br /><br />
 </div>
                        <div class="dummy" id="divdummyClassForServant" style=" display:none; float: left; margin-right: 100px;">  
            
                            </div>
                
 <div  style="float: left; margin-right: 100px;">  
                 <img id = "imgDisplayForServant" alt="" src="" style = "float: left; display:none;height:100px;width:100px;"/>

            <div class="camera">
            <video id="videoSR" style ="float: left; height:150px;width:150px;">Video stream not available.</video>
        </div>
       
        <canvas id="canvasSR" style="display:none"></canvas>
        <div class="output">
            <img id="photoSR" alt="The screen capture will appear in this box." style ="float: left;height:130px;width:150px;">
        </div>
        <div>
             <div>
                 <input type="button" class="btn btn-primary" id="startbuttonSR" value="Capture" />
                  <input type="button" class="btn btn-primary" id="RecaptureSR" onclick="RecaptureSRs();" value="ReCapture" />
                  
             </div>
            <input type="button" class="btn btn-primary" value="WebCam" id="WebCamCallSR" onclick="WebCamCallSRs();"/>
        </div>
                        </div>





            </td>
        </tr>
        <tr>
            <td class="right">BC Number:</td>
            <td>
                <input type="text" id="txtBCNumber" runat="server" class="req" />
            </td>

        </tr>
        <tr>

            <td class="right">First Name:<span class="reqSpan">*</span></td>
            <td>
                <input type="text" id="txtFirstNameST" runat="server" class="req alpha" />
            </td>

        </tr>
        <tr>
            <td class="right">Last Name:<span class="reqSpan">*</span></td>
            <td>
                <input type="text" id="txtLastNameST" runat="server" class="req alpha" />
            </td>
        </tr>
        <tr>
            <td class="right" style="width: 20%;">CNIC:<span class="reqSpan">*</span></td>
            <td style="width: 30%;">
                <input type="text" id="txtNICST" runat="server" class="req " onblur="getServantResultByCNIC();" />
            </td>
            
        </tr>
        <tr>
            <td class="right">Date of Birth:<span class="reqSpan">*</span></td>
            <td>
         <%--       <input type="text" id="txtDOBST" runat="server" class="req" />--%>
                      <asp:TextBox ID="txtDOBST"   CssClass="req date"   runat="server" style="width:60%;float: left; margin-right: 5px;"></asp:TextBox>
                         <rjs:popcalendar ID="Popcalendar3" Separator="/" Format="mm dd yyyy" Control="txtDOBST" runat="server" To-Today="true"
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
                <input type="text" id="txtFH" class="alpha" runat="server" />
            </td>
            <td class="right">Valid From:</td>
                    <td>
                        <asp:TextBox ID="txtServantValidFrom"   CssClass="req date"   runat="server" style="width:60%;float: left; margin-right: 5px;"></asp:TextBox>
                       
                          <rjs:popcalendar ID="Popcalendar4" Separator="/" Format="mm dd yyyy" Control="txtServantValidFrom" runat="server" To-Today="true"
                                Font-Names="Tahoma" />
                    </td>
            </tr>
        
    
                 <tr>
              
                      <td class="right">Mark of Identification:</td>
                    <td>
                        <input type="text" id="txtMarkofIdentification" class="alpha"  runat="server"  />
                    </td>

                     <td class="right">Valid To:</td>
                    <td>
                        
                        <asp:TextBox ID="txtServantValidTo"   CssClass="req date"   runat="server" style="width:60%;float: left; margin-right: 5px;"></asp:TextBox>
                          <rjs:popcalendar ID="Popcalendar5" Separator="/" Format="mm dd yyyy" Control="txtServantValidTo" runat="server"
                                Font-Names="Tahoma" />
                    </td>
                    
                </tr>
               <tr>

                   <td class="right">Security Clearance: </td>
                   <td>
                        <asp:DropDownList ID="ddlServantSecurityClearance" CssClass="req" runat="server">
                        
                    </asp:DropDownList>
                   </td>
                   <td class="right">
                       Mobile No.:
                   </td>
                   <td>
                   <input type="text" id="txtCellPhoneST"  runat="server" />
                       </td>
               </tr>
               <tr>
                  <td class="right">Clearance Level:</td>
                   <td>
                        <asp:DropDownList ID="ddlServantlearanceLevel" CssClass="req" runat="server">
                        
                    </asp:DropDownList>
                   </td>
                   <td>Authentication Type<span class="reqSpan">*</span></td>
                   <td>
                        <asp:DropDownList ID="ServantAuthenticationType" CssClass="req" runat="server">
                         <asp:ListItem Value="1" Text="Card Only"></asp:ListItem>                    
                              <asp:ListItem Value="2" Text="Finger Only"></asp:ListItem>                    
                              <asp:ListItem Value="3" Text="Card Or Finger "></asp:ListItem>  
                              <asp:ListItem Value="4" Text="Card and Finger "></asp:ListItem>  
                    </asp:DropDownList>
                   </td>
               </tr>
    </table>
                </div>
            <div class="btn-wrapper" style="padding-top: 20px;" id="divServantSaveClearButtons">
                 <input type="button" id="btnBackServant" class="btn" value="Back" onclick="BackServant();" />
                
                <input type="button" id="btnSaveServant" class="btn" value="Save" onclick="saveServant();" />
                 <input type="button" id="btnNewServant" class="btn" value="New" onclick="ClearServantTable();" />
                
            </div>
             <fieldset style="width:96%;"  >
                <legend id="lgndServantDetail">Servant Detail</legend>
            
            <div style="padding-bottom: 20px; width: 98%; max-height: 300px; overflow: auto;">
                <table class="dataTable">
                    <thead>
                        <tr>
                            <th  style="display:none;">Action</th>
                            <th>Edit</th>
                            <%--<th>Servant Family</th>--%>
                           <%-- <th>Card #</th>--%>
                            <th  style="display:none;">EID</th>
                             <th>Servant Of</th>
                            <th  style="display:none;">First Name</th>
                            <th  style="display:none;">Last Name</th>
                            <th>Name</th>
                            <th>Fahter Name</th>
                            <th>BC Number</th>
                            <th>DOB</th>
                            <%--<th>Religion</th>--%>
                            <th>CNIC #</th>
                            <th>Mobile</th>
                            <%--<th style="display:none">Office Phone #.</th>--%>
                            <%--<th style="display:none">Home Phone #.</th>--%>
                            <%--<th style="display:none">Current Address</th>--%>
                            <th style="display:none">Permanent Address</th>
                            <th style="display:none">MarkOfIDentification</th>
                            <th style="display:none">ValidTo</th>
                            <th style="display:none">ValidFrom</th>

                            <th style="display:none">SecurityClearance</th>
                            <th style="display:none">ClearanceLevel</th>
                            <th style="display:none">Status</th>
                            <th style="display:none">AuthType</th>
                            <th>Photo</th>
                            <th>Detail</th>
                        </tr>
                    </thead>
                    <tbody id="tbodyServant" style="background-color:white;">
                    </tbody>
                </table>
            </div>
                </fieldset>
            <%--Saqib--%>
            <%--<div id="divServantFamily" style="display:none;">
            <div class="heading" id="lgndAddServantFamilyDetail">Servant Family Member</div>

            <div id="divFMSForm">
            <table id="tblFMSForm" class="form">
                <tr style="line-height:12px;" >
                    <td class="right">Id:</td>
                    <td>
                        <input type="text" id="txtIdFMS" disabled="disabled"  />
                    </td>
                    <td colspan="2" rowspan="3">
                        <div style="float: right; margin-right: 0px;">
                        <cc1:AsyncFileUpload OnClientUploadComplete="uploadCompleteForServantFamily" runat="server" ID="AsyncFileUploadForServantFamily"
        Width="400px" UploaderStyle="Modern" ClientIDMode="AutoID" CompleteBackColor="White" UploadingBackColor="#CCFFFF" 
        ThrobberID="imgLoader"  OnUploadedComplete="FileUploadCompleteForServantFamily" ToolTip="Click Here"   OnClientUploadStarted = "uploadStartedForServantFamily"/> 
                 <asp:HiddenField ID="hdnPictureIdForServantFamily" runat="server" />
    <asp:Image ID="Image3" style="display:none;" runat="server" ImageUrl="../../images/loader.gif" /><br /><br />
 </div>
                        <div class="dummy" id="divdummyClassForServantFamily" style="float: right; margin-right: 100px;">  
                             <img id = "imgDisplayForServantFamily" alt="" src="" style = "display:none;height:100px;width:100px;"/>

                        </div>
                    </td>

                </tr>
                <tr>
                   
                    <td class="right">First Name:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtFirstNameFMS" class="req alpha" />
                    </td>
                </tr>
                <tr>
                     <td class="right">Last Name:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtLastNameFMS" class="req alpha" />
                    </td>                    

                </tr>
                <tr>                                        
                    <td class="right">NIC:</td>
                    <td>
                        <input type="text" id="txtNICFMS" class="cnic" onblur="getServantFamilyResultByCNIC();"/>
                    </td>
                </tr>
                <tr>
                    <td class="right" style="width:20%;">Profession:</td>
                    <td  style="width:30%;">
                        <input type="text" id="txtProfessionFMS" class="alpha" />
                    </td>
                    <td class="right"  style="width:20%;">Cell No:</td>
                    <td  style="width:30%;">
                        <input type="text" id="txtCellNoFMS" class="cell" />
                    </td>
                </tr>
                <tr>
                    <td class="right">Relation:<span class="reqSpan">*</span></td>
                     <td>
                        <asp:DropDownList ID="ddlRelationFMS" runat="server" class="chzn-select req">                            
                        </asp:DropDownList>
                    </td>                   

                    <td class="right">Place of Work:</td>
                    <td>
                        <input type="text" id="txtPOWFMS"  />
                    </td>
                </tr>
                <tr>
                     <td class="right">Card #:</td>
                    <td>
                        <input type="text" id="txtCardNoFMS" disabled="disabled" />
                    </td>
                </tr>
            </table>
                </div>
            <div class="btn-wrapper" style="padding: 20px;">
                    <input type="button" id="btnSaveFMS" class="btn" value="Save" onclick="saveServantFamilyMember();" />
                 <input type="button" id="btnClearServantFamily" class="btn" value="New" onclick="ClearServantFamilyTable();" />
                    </div>
                
            <fieldset>
                <legend id="lgndSevantFamilyDetail">Servant`s Family Detail</legend>
           
            <div style="padding-bottom: 20px; width: 98%; max-height: 300px; overflow: auto;">
                <table class="dataTable">
                    <thead>
                        <tr>
                            <th>Action</th>
                            <th>Edit</th>
                            <th>EID</th>
                            <th>Card #</th>
                            <th style="display:none;">First Name</th>
                            <th style="display:none;">Last Name</th>
                            <th>Name</th>
                            <th>Relation</th>
                            <th>NIC</th>
                            <th>Profession</th>
                            <th>Place of Work</th>
                            <th>Mobile</th>
                            <th>Status</th>
                            <th>Photo</th>
                        </tr>
                    </thead>
                    <tbody id="tbodyFMS" style="background-color:white;">
                                        <tr>
                            <td colspan="9">&nbsp;</td>
                        </tr>
        
                    </tbody>
                </table>
            </div>
             </fieldset>
                </div>--%>
        </fieldset>
        <%--Guest--%>
    

           <%---------------------------------------------------Guest-Design-------------------------------------------------------%>

        <fieldset id="fieldsetGuest" style="display: none; width:96.5%;">
            <legend id="lgndAddUpdateGuest">Guest</legend>

           
            <div id="divGuestInfo">
                 <%--<div class="heading">Guest Info</div>--%>
           <table id="tblGuest" class="form">

                <tr id="trCloseforGuest">
                    <td style="text-align: right; border: none">
                        <div id="closeforGuest">
                            <img src='../images/btn_close02.png' style="background: none repeat scroll 0 0 transparent;
                                border: medium none; height: 32px; margin-top: -52px; position: absolute; width: 32px;
                                cursor: pointer; right: 434px; left: 98%;" alt="Close" onclick='return CloseModalForGuest();' />
                        </div>
                    </td>
                </tr>
        <tr style="line-height:12px;" >
            <td class="right">Id:</td>
            <td>
                <input type="text" id="txtIdGT" runat="server" disabled="disabled" />
            </td>
            <td>
                &nbsp;
            </td>


                  <td colspan="2" rowspan="3">
                        <div style="float: left; margin-right: 0px;">
                        <cc1:AsyncFileUpload OnClientUploadComplete="uploadCompleteForServantFamily" runat="server" ID="AsyncFileUploadForServantFamily"
        Width="400px" UploaderStyle="Modern" ClientIDMode="AutoID" CompleteBackColor="White" UploadingBackColor="#CCFFFF" 
        ThrobberID="imgLoader"  OnUploadedComplete="FileUploadCompleteForServantFamily" ToolTip="Click Here"   OnClientUploadStarted = "uploadStartedForServantFamily"/> 
                 <asp:HiddenField ID="hdnPictureIdForServantFamily" runat="server" />
    <asp:Image ID="Image3" style="display:none;" runat="server" ImageUrl="../../images/loader.gif" /><br /><br />
 </div>
                        <div class="dummy" id="divdummyClassForServantFamily" style="display:none; float: right; margin-right: 100px;">  
                        </div>


                       <div  style="float: right; margin-right: 100px;">  
                 <img id = "imgDisplayForServantFamily" alt="" src="" style = "float: left; display:none;height:100px;width:100px;"/>

            <div class="camera">
            <video id="videoGU" style ="float: left;height:150px;width:150px;">Video stream not available.</video>
        </div>
       
        <canvas id="canvasGU" style="display:none"></canvas>
        <div class="output">
            <img id="photoGU" alt="The screen capture will appear in this box." style ="float: left; height:130px;width:150px;">
        </div>
        <div>
             <div>
                 <input type="button" class="btn btn-primary" id="startbuttonGU" value="Capture" />
                  <input type="button" class="btn btn-primary" id="RecaptureGU" onclick="RecaptureGUs();" value="ReCapture" />
                  
             </div>
            <input type="button" class="btn btn-primary" value="WebCam" id="WebCamCallGU" onclick="WebCamCallGUs();"/>
        </div>
                        </div>
                    </td>

        <%--    <td  rowspan="4">
               <div style="float: right; margin-right: 0px;">
                   <cc1:AsyncFileUpload OnClientUploadComplete="uploadCompleteForGuest" runat="server" ID="AsyncFileUploadForGuest"
         Width="400px" UploaderStyle="Modern" ClientIDMode="AutoID" CompleteBackColor="White" UploadingBackColor="#CCFFFF" 
         ThrobberID="imgLoader"  OnUploadedComplete="FileUploadCompleteForGuest" ToolTip="Click Here"   OnClientUploadStarted = "uploadStartedForGuest"/> 
                 <asp:HiddenField ID="hdnPictureIdForGuest" runat="server" />

    <asp:Image ID="Image4" style="display:none;" runat="server" ImageUrl="../../images/loader.gif" /><br /><br />
 </div>
                        <div class="dummy" id="divdummyClassForGuest" style="float: right; margin-right: 100px;">  
                             <img id = "imgDisplayForGuest" alt="" src="" style = "display:none;height:100px;width:100px;"/>

                        </div>
            </td>--%>
        </tr>
        <tr>
            <td class="right">Name:<span class="reqSpan">*</span></td>
            <td>
                <input type="text" id="txtGuestName" runat="server" class="req alpha" />
            </td>

        </tr>
        <tr>
            <td class="right">Father Name:<span class="reqSpan">*</span></td>
            <td>
                <input type="text" id="txtGuestFatherName" runat="server" class="req alpha" />
            </td>

        </tr>
        <tr>
            <td class="right">CNIC:<span class="reqSpan">*</span></td>
            <td>
                <input type="text" id="txtGuestCNIC" runat="server" class="req" onblur="getGuestResultByCNIC();" />
            </td>
        </tr>
        <tr>
            <td class="right">Gender: </td>
                   <td>
                        <asp:DropDownList ID="txtGuestGender" CssClass="req" runat="server">
                        
                    </asp:DropDownList>
                   </td>
        </tr>
        <tr>
            <td class="right">Date of Birth:<span class="reqSpan">*</span></td>
            <td>
         <%--       <input type="text" id="txtDOBST" runat="server" class="req" />--%>
                      <asp:TextBox ID="txtGuestDoB"   CssClass="req date" ClientIDMode = "Static"   runat="server" style="width:60%;float: left; margin-right: 5px;"></asp:TextBox>
                         <rjs:popcalendar ID="Popcalendar6" Separator="/" Format="mm dd yyyy" Control="txtGuestDoB" runat="server" To-Today="true"
                                Font-Names="Tahoma" />
            </td>
            <td class="right">Address:</td>
            <td>
                <input type="text" id="txtGuestAddress" runat="server" />
            </td>


        </tr>
        <tr>
            <td class="right" style="width: 20%;">Age:</td>
            <td style="width: 30%;">
                <input type="text"  id="txtGuestAge" runat="server" readonly />
            </td>
            <td class="right" style="width: 20%;">Occupation:</td>
            <td style="width: 30%;">
                <input type="text" id="txtGuestOccupation" class="alpha" runat="server" />
            </td>
            </tr>

        <tr>
            <td class="right" style="width: 20%;">Nationality:</td>
            <td style="width: 30%;">
                <asp:DropDownList style="width:90%" class="form-control" ID="txtGuestnationality" runat="server" ClientIDMode = "Static"></asp:DropDownList>
          
            
            
            </td>
            <td class="right">Valid From:</td>
                    <td>
                        <asp:TextBox ID="txtGuestValidFrom"   CssClass="req date"   runat="server" style="width:60%;float: left; margin-right: 5px;"></asp:TextBox>
                       
                          <rjs:popcalendar ID="Popcalendar7" Separator="/" Format="mm dd yyyy" Control="txtGuestValidFrom" runat="server" To-Today="true"
                                Font-Names="Tahoma" />
                    </td>
            </tr>
        
    
                 <tr>
              
                      <td class="right">Mark of Identification:</td>
                    <td>
                        <input type="text" id="txtGuestMarkIdentification" class="alpha"  runat="server"  />
                    </td>

                     <td class="right">Valid To:</td>
                    <td>
                        
                        <asp:TextBox ID="txtGuestValidTo"   CssClass="req date"   runat="server" style="width:60%;float: left; margin-right: 5px;"></asp:TextBox>
                          <rjs:popcalendar ID="Popcalendar8" Separator="/" Format="mm dd yyyy" Control="txtGuestValidTo" runat="server"
                                Font-Names="Tahoma" />
                    </td>
                    
                </tr>
               <tr>

                   <td class="right">Security Clearance: </td>
                   <td>
                        <asp:DropDownList ID="ddlGuestSecurityClearance" CssClass="req" runat="server">
                        
                    </asp:DropDownList>
                   </td>
                   <td class="right">
                       Mobile No.:
                   </td>
                   <td>
                   <input type="text" id="txtGuestMobile"  runat="server" />
                       </td>
               </tr>
               <tr>
                  <td class="right">Clearance Level:</td>
                   <td>
                        <asp:DropDownList ID="ddlGuestclearanceLevel" CssClass="req" runat="server">
                        
                    </asp:DropDownList>
                   </td>
                   <td class="right" style="width: 20%;">Relation Type:</td>
            <td style="width: 30%;">
                <input type="text" style="display:none" id="txtGuestRelationType" class="alpha" runat="server" />
           
               
                <asp:DropDownList ID="ddRelationType" ClientIDMode="Static" runat="server"></asp:DropDownList>
            
            </td>
               </tr>

               <tr>
                    <td class="right">Authentication Type<span class="reqSpan">*</span></td>
                    <td>
                          <asp:DropDownList ID="GuestAuthenticationType" runat="server">    
                              <asp:ListItem Value="1" Text="Card Only"></asp:ListItem>                    
                              <asp:ListItem Value="2" Text="Finger Only"></asp:ListItem>                    
                              <asp:ListItem Value="3" Text="Card Or Finger "></asp:ListItem>  
                              <asp:ListItem Value="4" Text="Card and Finger "></asp:ListItem>                    
                    </asp:DropDownList>

                        <%--From-Today="true"--%>
                    </td></tr>
    </table>
                </div>
            <div class="btn-wrapper" style="padding-top: 20px;" id="divGuestSaveClearButtons">
               
                 <input type="button" id="btnBackGuest" class="btn" value="Back" onclick="BackGuest();" />
               
                <input type="button" id="btnSaveGuest" class="btn" value="Save" onclick="saveGuest();" />
                 <input type="button" id="btnNewGuest" class="btn" value=
                     "New" onclick="ClearGuestTable();" />
                
            </div>
             <fieldset style="width:96%;"  >
                <legend id="lgndGuestDetail">Guest Detail</legend>
            
            <div style="padding-bottom: 20px; width: 98%; max-height: 300px; overflow: auto;">
                <table class="dataTable">
                    <thead>
                        <tr>
                            <th  style="display:none;">Action</th>
                            <th>Edit</th>
                            <th  style="display:none;">EID</th>
                             <th style="display:none;">Guest Of</th>
                            <th>Guest Of</th>
                            <th> Name</th>
                            <th>Fahter Name</th>
                            <th style="display:none">DOB</th>
                            <th>CNIC #</th>
                            <th>Mobile</th>
                            <th style="display:none">Nationality</th>
                            <th>Relation</th>
                            <th style="display:none">Age</th>
                            <th style="display:none">Gender</th>
                            
                            <th style="display:none">Occupation</th>

                            <th style="display:none">Address</th>
                            <th style="display:none">Identification Mark</th>

                            <th style="display:none">ValidTo</th>
                            <th style="display:none">ValidFrom</th>

                            <th style="display:none">SecurityClearance</th>
                            <th style="display:none">ClearanceLevel</th>
                            <th style="display:none">Status</th>
                            <th>Photo</th>
                            <th>Detail</th>
                        </tr>
                    </thead>
                    <tbody id="tbodyGuest" style="background-color:white;">
                    </tbody>
                </table>
            </div>
                </fieldset>
            
        </fieldset>

       <%-- ---------------------------------------------------End-Guest----------------------------------------------------%>










        
        <div class="top-header" id="divBlackLisReasoning" style="display:none;">
             <fieldset>
                <legend>Reason for BlackList</legend>
                <table class="form">
                    <tr id="">
                        <td><input type="text" id="txtReason" /></td>
                         <td><input type="text" id="txtEmployeeIDS" /></td>
                </tr>
                           <%-- <div id="close">
                                <img src='../images/btn_close02.png' style="background: none repeat scroll 0 0 transparent; border: medium none; height: 32px; margin-top: -52px; position: absolute; width: 32px; cursor: pointer; right: 434px; left: 98%;"
                                    alt="Close" onclick='return CloseModal();' />
                            </div>--%>
                        
                                       
             
               </table>     
        <div class="btn-wrapper" style="padding-top: 20px;" id="">
                <input type="button" id="btnSaveReason" class="btn" value="Save " onclick="savereason();" />
              
                <input type="button" id="btnCloseReason" class="btn" value="Cancel " onclick="return CloseModalBlackList();" />
              </div>
            </fieldset>
         
               <%-- <tr>
                    <td>Reason:</td>
                    <td><input type="text" id="txtReason" /></td>
                </tr>--%>
         
           


        </div></script>
        <script type="text/javascript">
            //setTimeout(function () {
            //    window.location.reload(1);
            //}, 6000);

            $(document).ready(function () {

                $("#Recaptures").hide();
                $("#startbuttonEmp").hide();
                $("#photoEmp").hide();

                $("#RecaptureFM").hide();
                $("#startbuttonFM").hide();
                $("#photoFM").hide();

                $("#RecaptureSR").hide();
                $("#startbuttonSR").hide();
                $("#photoSR").hide();


                $("#RecaptureGU").hide();
                $("#startbuttonGU").hide();
                $("#photoGU").hide();
                getResidents();

            });

            function CloseModalForGuest() {

                $("#WebCamCallGU").show();
                $("#divGuestInfo").jqmHide();
                $(".jqmWindow input, select").attr("disabled", false);
                return false;
            }


            function saveGuest() {


                var Getimg = $("#photoGU")[0].src;
                var img = "";
                if (Getimg == "") {
                    img = $.trim($("input[id$='hdnPictureIdForServantFamily']").val());

                }
                else {
                    img = Getimg;

                }
                //alert($.trim($("[id$='hdnPictureIdForGuest']").val()));
                if ($("input[id$='hdnPictureIdForServantFamily']").val().indexOf(":") >= 0) {
                    $("input[id$='hdnPictureIdForServantFamily']").val("");

                }
                $("#divMsg").hide();
                if (!validate("tblGuest")) {
                    var GID = $.trim($("[id$='txtIdGT']").val()) == "" ? 0 : $.trim($("[id$='txtIdGT']").val());
                    var request = "{"
                        + "'GID':'" + GID + "',"
                        + "'EID':'" + $.trim($("[id$='hdnEID']").val()) + "',"
                        + "'GuestName':'" + $.trim($("[id$='txtGuestName']").val()) + "',"
                        + "'FatherName':'" + $.trim($("[id$='txtGuestFatherName']").val()) + "',"
                        + "'CNIC':'" + $.trim($("[id$='txtGuestCNIC']").val()) + "',"
                        + "'Gender':'" + $.trim($("[id$='txtGuestGender']").val()) + "',"
                        + "'DOB':'" + $.trim($("[id$='txtGuestDoB']").val()) + "',"
                        + "'Addr':'" + $.trim($("[id$='txtGuestAddress']").val()) + "',"
                        + "'Age':'" + $.trim($("[id$='txtGuestAge']").val()) + "',"
                        + "'Occupation':'" + $.trim($("[id$='txtGuestOccupation']").val()) + "',"
                        + "'Nationality':'" + $.trim($("[id$='txtGuestnationality']").val()) + "',"
                        + "'ValidTo':'" + $.trim($("[id$='txtGuestValidTo']").val()) + "',"
                        + "'ValidFrom':'" + $.trim($("[id$='txtGuestValidFrom']").val()) + "',"
                        + "'MarkofIdentification':'" + $.trim($("[id$='txtGuestMarkIdentification']").val()) + "',"
                        + "'Mobile':'" + $.trim($("[id$='txtGuestMobile']").val()) + "',"
                        + "'GuestSecurity':'" + $.trim($("[id$='ddlGuestSecurityClearance']").val()) + "',"
                        + "'ClearanceLevel':'" + $.trim($("[id$='ddlGuestclearanceLevel']").val()) + "',"
                        + "'RelationType':'" + $.trim($("#ddRelationType").val()) + "',"
                        + "'AuthType':'" + $.trim($("[id$='GuestAuthenticationType']").val()) + "',"
                        + "'Photo':'" + img + "'"
                        + "}";


                    //  alert(request);
                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        url: "../RMS/RMSWebMethod.aspx/SaveGuest",
                        data: request,
                        success: function (data) {
                            showSuccessMsg("Information saved successfully!");

                            $("[id$='txtIdST']").val(data.d);
                            getGuests('', $.trim($("[id$='hdnEID']").val()));
                            getResidents();
                            ClearGuestTable();
                            // alert($("[id$='txtIdST']").val());
                        }
                    });
                }
            }

            function ClearGuestTable() {
                $("#tblGuest input[type='text']").val('');
                $("div[id*='AsyncFileUploadForServantFamily']").css("width", "400px");
                $("input[id*='AsyncFileUploadForServantFamily']").val("");
                $("div[id*='AsyncFileUploadForServantFamily']").css("margin-top", "-34px");
                $("input[id*='AsyncFileUploadForServantFamily']").css("background-color", "");
                $("input[id$='hdnPictureIdForServantFamily']").val("");
                $("img[id$='imgDisplayForServantFamily']").hide();
                //$("select[id$='ddlReligionST']").val("");
                $("#divdummyClassForServantFamily").addClass("dummy");
            }

            function ShowDetails_ModalForGuest(SID, elm, flag) {

                $("#WebCamCallGU").hide();
                editGuest(SID, elm, flag);
            }

            function editGuest(gid, elm, flag) {
                $("#imgDisplayForServantFamily").show();

                $("#photoGU").hide();
                $("#videoGU").hide();

                if (flag == '1') {
                    $('#divGuestInfo').addClass("jqmWindow");
                    $(".jqmWindow input, select").attr("disabled", true);
                    $("img[src$='Calendar.gif']").hide();
                    $('#divGuestInfo').css("margin-left", "-44%");
                    $('#divGuestInfo').css("width", "86%");
                    $('#trCloseforGuest').show();
                    $("#divGuestSaveClearButtons").hide();
                    $("div[id*='AsyncFileUploadForServantFamily']").hide();

                    $('#divGuestInfo').jqm({ modal: true, overlay: 75, trigger: false });
                    $('#divGuestInfo').jqmShow();
                }
                else {
                    $('#divGuestInfo').css("margin-left", "0%");
                    $('#divGuestInfo').css("width", "97%");
                    $('#trCloseforGuest').hide();

                    $("#divGuestSaveClearButtons").show();
                    $("div[id*='AsyncFileUploadForServantFamily']").show();
                    $(".jqmWindow input, select").attr("disabled", false);
                    $("img[src$='Calendar.gif']").show();
                    $('#divGuestInfo').removeClass("jqmWindow");
                    $('#divGuestInfo').show();
                }


                $("div[id*='AsyncFileUploadForServantFamily']").css("width", "400px");
                $("input[id*='AsyncFileUploadForServantFamily']").val("");
                $("div[id*='AsyncFileUploadForServantFamily']").css("margin-top", "-34px");
                $("input[id*='AsyncFileUploadForServantFamily']").css("background-color", "");
                $("input[id$='hdnPictureIdForGuest']").val("");
                $("img[id$='imgDisplayForServantFamily']").hide();
                $("#divdummyClassForServantFamily").addClass("dummy");

                $("[id$='txtIdGT']").val(gid);
                //// $("[id$='hdnEID']").val();

                $("[id$='txtGuestName']").val($.trim($(elm).closest("tr").find(".GuestName").html()));
                $("[id$='txtGuestFatherName']").val($.trim($(elm).closest("tr").find(".GuestFatherName").html()));
                $("[id$='txtGuestGender']").val($.trim($(elm).closest("tr").find(".GuestGender").html()));
                $("[id$='txtGuestCNIC']").val($.trim($(elm).closest("tr").find(".GuestCNIC").html()));
                $("[id$='txtGuestDoB']").val($.trim($(elm).closest("tr").find(".GuestDoB").html()));
                $("[id$='txtGuestAddress']").val($.trim($(elm).closest("tr").find(".GuestAddress").html()));
                $("[id$='txtGuestAge']").val($.trim($(elm).closest("tr").find(".GuestAge").html()));
                $("[id$='txtGuestOccupation']").val($.trim($(elm).closest("tr").find(".GuestOccupation").html()));
                $("[id$='txtGuestnationality']").val($.trim($(elm).closest("tr").find(".GuestNationality").html()));

                $("[id$='txtGuestMarkIdentification']").val($.trim($(elm).closest("tr").find(".GuestIdentification").html()));

                $("[id$='txtGuestValidFrom']").val($.trim($(elm).closest("tr").find(".GuestValidFrom").html()));
                $("[id$='txtGuestValidTo']").val($.trim($(elm).closest("tr").find(".GuestValidTo").html()));
                $("[id$='ddlGuestSecurityClearance']").val($.trim($(elm).closest("tr").find(".GuestSecurity").html()));
                $("[id$='ddlGuestclearanceLevel']").val($.trim($(elm).closest("tr").find(".GuestCLevel").html()));
                $("[id$='txtGuestMobile']").val($.trim($(elm).closest("tr").find(".GuestMobile").html()));
                $("[id$='ddRelationType']").text($.trim($(elm).closest("tr").find(".GuestRelation").html()));

                var str = $(elm).closest("tr").find(".phto img").attr("src");

                var last = str.substring(str.lastIndexOf("/") + 1, str.length);

                if (last.split('.')[0] != "") {
                    $("#imgDisplayForServantFamily").attr("src", str);
                    $("input[id$='hdnPictureIdForServantFamily']").val(last.split('.')[0])
                    $("#imgDisplayForServantFamily").show();
                    $("#divdummyClassForServantFamily").removeClass("dummy");
                }
                else {
                    $("#imgDisplayForServantFamily").hide();
                    $("#divdummyClassForServantFamily").addClass("dummy");
                }

            }



            function getGuestResultByCNIC() {
                var SCNIC = $("input[id$='txtGuestCNIC']").val();
                if ($("input[id$='txtIdGT']").val() == "") {
                    if ($("input[id$='txtGuestCNIC']").val().indexOf('_') < 0) {


                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "../RMS/RMSwebmethods.aspx/GetGuestResultByCNIC",
                            data: "{'SCNIC':'" + SCNIC + "'}",
                            success: onsuccessGetGuestResult,
                            error: onErrorGetGuestResult
                        });
                        return false;

                    }



                    else
                        return false;

                }


            }

            function onsuccessGetGuestResult(msg) {
                var data = msg.d;
                var result = data.GetGuestCountTable[0].Counts;
                if (parseInt(result) > 0) {
                    alert("Guest already exist!");
                    // $("input[id$='txtNIC']").val("");
                    return false;
                }
            }

            function onErrorGetGuestResult() {


            }


            function InactiveGuestRecord(SID) {

                if (confirm("Are you sure you wish to Inactive this Record?")) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../RMS/RMSWebMethod.aspx/InactiveGuestRecord",
                        data: "{'SID':'" + SID + "'}",
                        success: onsuccessInactiveGuestRecord
                    });

                    return false;
                }
                else
                    return false;
            }


            function onsuccessInactiveGuestRecord(msg) {
                //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
                showSuccessMsg("User has been Inactivate Successfully!");
                getGuests('', $.trim($("[id$='hdnEID']").val()));
                getResidents();
                return false;
            }



            //---------------------------------------------Activate Visitor Record------------------------------------------
            function ActivateGuestRecord(SID) {

                if (confirm("Are you sure you wish to Activate this User?")) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../RMS/RMSWebMethod.aspx/ActivateGuestRecord",
                        data: "{'SID':'" + SID + "'}",
                        success: onsuccessActivateGuestRecord
                    });

                    return false;
                }
                else
                    return false;
            }


            function onsuccessActivateGuestRecord(msg) {
                //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
                showSuccessMsg("User has been Activated Successfully!");
                getGuests('', $.trim($("[id$='hdnEID']").val()));
                getResidents();
                return false;
            }

            //----------------------------------------Black List Visistor---------------------------------------------------------------------------------------

            function BlackListGuestRecord(SID) {
                if (confirm("Are you sure you wish to Black List this User?")) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../RMS/RMSWebMethod.aspx/BlackListGuestRecord",
                        data: "{'SID':'" + SID + "'}",
                        success: onsuccessBlackListGuest
                    });

                    return false;
                }
                else
                    return false;
            }


            function onsuccessBlackListGuest(msg) {
                //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
                showSuccessMsg("User has been Black Listed Successfully!");
                getGuests('', $.trim($("[id$='hdnEID']").val()));
                getResidents();
                return false;
            }









            //----------------------------------------------Start Get Employee Result on the basis of CNIC------------------------------------

            function getEmployeeResultByCNIC() {
                var CNIC = $("input[id$='txtNIC']").val();
                if ($("input[id$='txtId']").val() == "") {
                    if ($("input[id$='txtNIC']").val().indexOf('_') < 0) {


                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "../RMS/RMSwebmethods.aspx/GetEmpResultByCNIC",
                            data: "{'CNIC':'" + CNIC + "'}",
                            success: onsuccessGetEmployeeResult,
                            error: onErrorGetEmployeeResult
                        });
                        return false;

                    }



                    else
                        return false;

                }


            }

            function onsuccessGetEmployeeResult(msg) {

                var data = msg.d;
                var result = data.GetEmpCountTable[0].Counts;
                if (parseInt(result) > 0) {
                    alert("Resident already exist!");
                    $("input[id$='txtNIC']").val("");
                    return false;
                }
            }

            function onErrorGetEmployeeResult() {


            }
            //----------------------------------------------End Get Employee Result on the basis of CNIC------------------------------------
            //---------- HR NO# existing id check-----------------------------------------------------

            function getEmployeeResultByHRNo() {
                var ServiceNo = $("input[id$='txtPNO']").val();
                if ($("input[id$='txtId']").val() == "") {
                    if ($("input[id$='txtPNO']").val().indexOf('_') < 0) {


                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "../RMS/RMSwebmethods.aspx/getEmployeeResultByHRNo",
                            data: "{'ServiceNo':'" + ServiceNo + "'}",
                            success: onsuccessGetEmployeeResultByHRNo,
                            error: onErrorGetEmployeeResultByHRNo
                        });
                        return false;

                    }



                    else
                        return false;

                }


            }

            function onsuccessGetEmployeeResultByHRNo(msg) {

                var data = msg.d;
                var result = data.GetEmpCountTable[0].Counts;
                if (parseInt(result) > 0) {
                    alert("HR No# already exist!");
                    $("input[id$='txtPNO']").val("");
                    return false;
                }
            }

            function onErrorGetEmployeeResultByHRNo() {


            }

            //----------------------------------------------End Get Employee Result on HRNo#------------------------------------
            
            //------------------------------------------------------start  get servant family result on the basis of CNIC--------------

            function getServantFamilyResultByCNIC() {
                var SFCNIC = $("input[id$='txtNICFMS']").val();
                if ($("input[id$='txtIdFMS']").val() == "") {
                    if ($("input[id$='txtNICFMS']").val().indexOf('_') < 0) {


                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "../RMS/RMSwebmethods.aspx/GetServantFamilyResultByCNIC",
                            data: "{'SFCNIC':'" + SFCNIC + "'}",
                            success: onsuccessGetServantFamilyResult,
                            error: onErrorGetservantfamilyResult
                        });
                        return false;

                    }



                    else
                        return false;

                }


            }

            function onsuccessGetServantFamilyResult(msg) {
                var data = msg.d;
                var result = data.GetServantfamilyCountTable[0].Counts;
                if (parseInt(result) > 0) {
                    alert("Servant family's member  already exist!");
                    // $("input[id$='txtNIC']").val("");
                    return false;
                }
            }

            function onErrorGetservantfamilyResult() {


            }



            //--------------------------------------------------End of servant family result-----------------
            //------------------------------------------------------start  get Employee family result on the basis of CNIC--------------

            function getEmployeeFamilyResultByCNIC() {
                var EFCNIC = $("input[id$='txtNICFM']").val();
                if ($("input[id$='txtIdFM']").val() == "") {
                    if ($("input[id$='txtNICFM']").val().indexOf('_') < 0) {


                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "../RMS/RMSwebmethods.aspx/GetEmployeeFamilyResultByCNIC",
                            data: "{'EFCNIC':'" + EFCNIC + "'}",
                            success: onsuccessGetEmployeeFamilyResult,
                            error: onErrorGetemployeefamilyResult
                        });
                        return false;

                    }



                    else
                        return false;

                }


            }

            function onsuccessGetEmployeeFamilyResult(msg) {
                var data = msg.d;
                var result = data.GetEmployeeFamilyCountTable[0].Counts;
                if (parseInt(result) > 0) {
                    alert("Employee family's member  already exist!");
                    // $("input[id$='txtNIC']").val("");
                    return false;
                }
            }

            function onErrorGetemployeefamilyResult() {


            }



            //--------------------------------------------------End of Employee family result-----------------

            //------------------------------------------------------start  get servant  result on the basis of CNIC--------------

            function getServantResultByCNIC() {
                var SCNIC = $("input[id$='txtNICST']").val();
                if ($("input[id$='txtIdST']").val() == "") {
                    if ($("input[id$='txtNICST']").val().indexOf('_') < 0) {


                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "../RMS/RMSwebmethods.aspx/GetServantResultByCNIC",
                            data: "{'SCNIC':'" + SCNIC + "'}",
                            success: onsuccessGetServantResult,
                            error: onErrorGetservantResult
                        });
                        return false;

                    }



                    else
                        return false;

                }


            }

            function onsuccessGetServantResult(msg) {
                var data = msg.d;
                var result = data.GetServantCountTable[0].Counts;
                if (parseInt(result) > 0) {
                    alert("Servant already exist!");
                    // $("input[id$='txtNIC']").val("");
                    return false;
                }
            }

            function onErrorGetservantResult() {


            }



            //--------------------------------------------------End of servant  result-----------------




            //   $(document).ready(function () { $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true }); });
            function readCookie(name) {
                var nameEQ = name + "=";
                var ca = document.cookie.split(';');
                for (var i = 0; i < ca.length; i++) {
                    var c = ca[i];
                    while (c.charAt(0) == ' ') c = c.substring(1, c.length);
                    if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length, c.length);
                }
                return null;
            }
            function uploadStarted() {
                $get("imgDisplay").style.display = "none";
            }
            function uploadComplete2(sender, args) {

                var a = $("input[id$='txtNIC']").val();
                if (a == '') {
                    alert('please Enter CNIC First');
                    return;

                }
                else {
                    //alert(a+ "ha ja" )

                    $("#photoEmp").hide();

                    $("#videoEmp").hide();
                    var name = readCookie("tabs").replace("url=", "");
                    //alert(name + " Kuch nai bhai");
                    var imgDisplay = $get("imgDisplay");
                    imgDisplay.src = "../images/loader.gif";
                    imgDisplay.style.cssText = "";
                    var img = new Image();
                    img.onload = function () {
                        imgDisplay.style.cssText = "height:100px;width:100px";
                        imgDisplay.src = img.src;
                    };

                    $("#divdummyClass").removeClass("dummy");


                    img.src = "<%=ResolveUrl(UploadFolderPath) %>" + name + ".jpg";// args.get_fileName();
                    $("input[id$='hdnPictureId']").val(name);
                }
            }


            function uploadStartedForFamily() {

                $get("imgDisplayForFamily").style.display = "none";
            }
            function uploadCompleteForFamily(sender, args) {

                //var a = $("input[id$='txtimangeName']").val();
                //alert(a+ "ha ja" )

                var a = $("input[id$='txtNICFM']").val();
                if (a == '') {
                    alert('please Enter CNIC First');
                    return;

                }
                else {
                    var name = readCookie("tabsForFamily").replace("urlForFamily=", "");

                    var imgDisplay = $get("imgDisplayForFamily");
                    imgDisplay.src = "../images/loader.gif";
                    imgDisplay.style.cssText = "";
                    var img = new Image();
                    img.onload = function () {
                        imgDisplay.style.cssText = "height:100px;width:100px";
                        imgDisplay.src = img.src;
                    };

                    $("#divdummyClassForFamily").removeClass("dummy");


                    img.src = "<%=ResolveUrl(UploadFolderPathForFamily) %>" + name + ".jpg";// args.get_fileName();

                    // alert(name + " Kuch nai bhai" +img.src);
                    $("input[id$='hdnPictureIdForFamily']").val(name);
                }
            }

            function uploadStartedForServant() {

                $get("imgDisplayForServant").style.display = "none";
            }
            function uploadCompleteForServant(sender, args) {

                var a = $("input[id$='txtNICST']").val();
                //alert(a+ "ha ja" )
                if (a == '') {
                    return;

                }

                else {
                    var name = readCookie("tabsForServant").replace("urlForServant=", "");

                    var imgDisplay = $get("imgDisplayForServant");
                    imgDisplay.src = "../images/loader.gif";
                    imgDisplay.style.cssText = "";
                    var img = new Image();
                    img.onload = function () {
                        imgDisplay.style.cssText = "height:100px;width:100px";
                        imgDisplay.src = img.src;
                    };

                    $("#divdummyClassForServant").removeClass("dummy");


                    img.src = "<%=ResolveUrl(UploadFolderPathForServant) %>" + name + ".jpg";// args.get_fileName();

        // alert(name + " Kuch nai bhai" +img.src);
        $("input[id$='hdnPictureIdForServant']").val(name);
    }
}


function uploadStartedForServantFamily() {

    $get("imgDisplayForServantFamily").style.display = "none";
}
function uploadCompleteForServantFamily(sender, args) {

    var a = $("input[id$='txtGuestCNIC']").val();
    //alert(a+ "ha ja" )
    if (a == '') {
        return;

    }
    else {
        var name = readCookie("tabsForServantFamily").replace("urlForServantFamily=", "");

        var imgDisplay = $get("imgDisplayForServantFamily");
        imgDisplay.src = "../images/loader.gif";
        imgDisplay.style.cssText = "";
        var img = new Image();
        img.onload = function () {
            imgDisplay.style.cssText = "height:100px;width:100px";
            imgDisplay.src = img.src;
        };

        $("#divdummyClassForServantFamily").removeClass("dummy");


                    img.src = "<%=ResolveUrl(UploadFolderPathForServantFamily) %>" + name + ".jpg";// args.get_fileName();

                    // alert(name + " Kuch nai bhai" +img.src);
                    $("input[id$='hdnPictureIdForServantFamily']").val(name);
                }
            }

            function hideFMS() { }

            function getResidents() {

                $("#fieldsetPersonalGrd").show();
                $("#fieldsetPersonal").hide();
                $("#fieldsetFM").hide();
                $("#fieldsetServant").hide();

                //var CNICResult = "";
                //if ($("input[id$='txtCardNIC']").val().trim() != "") {
                //    if ($("input[id$='txtCardNIC']").val().length > 12) {
                //        var str = $("input[id$='txtCardNIC']").val();
                //        str = str.replace(/\-/g, '');
                //        var string = str;
                //        var insert = "-";
                //        var position = "10";

                //        var result = [string.slice(0, 5), '-', string.slice(5)].join('');
                //        result = [result.slice(0, 13), '-', result.slice(13)].join('');
                //        var CNICResult = result;
                //    }

                //}


                $("#divFMS").hide();
                $.post("../RMS/CallBack/ResidentsHandler.aspx", {
                    NIC: $("#txtCardNIC").val(),
                    Rank: $("[id$='ddlRankSearch']").val(),
                    Dept: $("[id$='ddlDepartmentSearch']").val(),
                    Desg: $("[id$='ddlDesignationSearch']").val(),
                    Name: $("#txtNameSearch").val(),
                    Status: $("[id$='ddlStatusSearch']").val()
                }).done(function (data) {
                    var response = data;
                    var start = data.indexOf("#StartResident#") + 15;
                    var end = data.indexOf("#EndResident#");
                    $("#tbodyResidents").html(response.substring(start, end));

                    if ($("#tbodyResidents tr").length == 0) {
                        $("#tbodyResidents").html("<tr><td class='noRecordFound' colspan='19'>No Record Found</td></tr>");
                    }

                    //  alert($("#tbodyVisitors tr").length);
                    if ($("select[id$='ddlStatusSearch']").val() == "Active") {

                        $(".ResidentInActive").css("display", "inline-block");
                        $(".ResidentActive").css("display", "none");


                    }
                    else if ($("select[id$='ddlStatusSearch']").val() == "Inactive") {

                        $(".ResidentInActive").css("display", "none");
                        $(".ResidentActive").css("display", "inline-block");
                    }

                    else {
                        // for (i = 0; i <= $("#tbodyVisitors tr").length; i++)
                        $("#tbodyResidents tr").each(function () {
                            // var data= $(this).find(".newImage").load("../RMS/CallBack/Handler.ashx?EID=58");
                            // $('.newImage').html('<img src="data:image/png;base64,' + data + '" />');
                            if ($(this).find('.status').html() == "Active") {
                                $(this).find(".ResidentInActive").css("display", "inline-block");
                                $(this).find(".ResidentBlackList").css("display", "inline-block");
                                $(this).find(".ResidentActive").css("display", "none");
                            }
                            else if ($(this).find('.status').html() == "InActive") {
                                $(this).find(".ResidentActive").css("display", "inline-block");
                                $(this).find(".ResidentBlackList").css("display", "inline-block");
                                $(this).find(".ResidentInActive").css("display", "none");
                            }

                            else {
                                $(this).find(".ResidentBlackList").css("display", "none");
                                $(this).find(".ResidentBlackList").parent().parent().css("color", "Red");
                                $(this).find(".ResidentBlackList").parent().parent().css("font-weight", "bold");
                                $(this).find(".ResidentActive").css("display", "inline-block");
                                $(this).find(".ResidentInActive").css("display", "inline-block");
                            }


                        });
                        // alert($("#tbodyVisitors tr").find('.status').html());
                    }
                });
            }

            function showHideImageForFamilyMembers() {

                $("div[id*='AsyncFileUploadForFamily']").css("width", "400px");
                $("input[id*='AsyncFileUploadForFamily']").val("");
                $("div[id*='AsyncFileUploadForFamily']").css("margin-top", "-34px");
                $("input[id*='AsyncFileUploadForFamily']").css("background-color", "");
                $("input[id$='hdnPictureIdForFamily']").val("");
                $("img[id$='imgDisplayForFamily']").hide();
                $("#divdummyClassForFamily").addClass("dummy");
            }

            function getFamilyMembers(ResidantStatus, eid, callFrom) {


                $("#fieldsetPersonalGrd").hide();
                //  alert('calling');
                //   var Rasidant_Status_Name = $(this).closest(".trclass").find(".RaStatusName").html();
                // alert(Rasidant_Status_Name);

                //  var currentRow = $(this).closest("tr");    // Find the row
                if (ResidantStatus == 'Out Living') {
                    alert('This Employee is Non-Residant');
                    return;
                }
                // var text = $(this).closest("tr").find(".RaStatusName").html();// Find the text
                //alert(ResidantStatus);

                //$(this).find("td:gt(0)").each(function () {
                //    alert($(this).html());
                //});

                clearFamilyMember();
                $("[id$='hdnEID']").val(eid);
                $.post("../RMS/CallBack/FamilyMembersHandler.aspx", { EID: eid, Status: '' }).done(function (data) {
                    var response = data;
                    var start = data.indexOf("#StartFM#") + 9;
                    var end = data.indexOf("#EndFM#");
                    $("#tbodyFM").html(response.substring(start, end));

                    if ($("#tbodyFM tr").length == 0) {
                        $("#tbodyFM").html("<tr><td class='noRecordFound' colspan='11'>No Record Found</td></tr>");
                    }

                    $("#fieldsetFM").show();
                    $("#fieldsetPersonal").hide();
                    $("#fieldsetServant").hide();
                    if (callFrom == "Grid") {
                        $("#btnAddFM").show();
                    }
                    // for (i = 0; i <= $("#tbodyVisitors tr").length; i++)
                    $("#tbodyFM tr").each(function () {
                        //  alert($(".ownerName").html());
                        //$("#lgndFamilyMemberDetail").html($(".ownerName").html() + "`s Family Members Detail");
                        // $("#lgndFamilyMember").html("Add/Update Family Member of " + $(".ownerName").html())

                        $("#lgndFamilyMember").html("Add/Update Family Member of " + "<span style='color:blue'>" + $(".ownerName").html() + "</span>")
                        $("#lgndFamilyMemberDetail").html("Family Members Detail of " + "<span style='color:blue'>" + $(".ownerName").html() + "</span>")

                        if ($(this).find('.status').html() == "Active") {
                            $(this).find(".ResidentFamilyMemberInActive").css("display", "inline-block");
                            $(this).find(".ResidentFamilyMemberBlackList").css("display", "inline-block");
                            $(this).find(".ResidentFamilyMemberActive").css("display", "none");
                        }
                        else if ($(this).find('.status').html() == "InActive") {
                            $(this).find(".ResidentFamilyMemberActive").css("display", "inline-block");
                            $(this).find(".ResidentFamilyMemberBlackList").css("display", "inline-block");
                            $(this).find(".ResidentFamilyMemberInActive").css("display", "none");
                        }

                        else {
                            $(this).find(".ResidentFamilyMemberBlackList").css("display", "none");
                            $(this).find(".ResidentFamilyMemberBlackList").parent().parent().css("color", "Red");
                            $(this).find(".ResidentFamilyMemberBlackList").parent().parent().css("font-weight", "bold");
                            $(this).find(".ResidentFamilyMemberActive").css("display", "inline-block");
                            $(this).find(".ResidentFamilyMemberInActive").css("display", "inline-block");
                        }


                    });
                    //$(elem).closest("tr").after("<tr class='familymember'><td colspan='17'><div style='padding: 5px;color: #005978;font-weight: bold;font-style: italic;'>Family Members</div> " + response.substring(start, end) + "</td></tr>");
                });
                $("div[id*='AsyncFileUploadForFamily']").css("width", "400px");
                $("div[id*='AsyncFileUploadForFamily']").css("margin-top", "-34px");
                $("input[id*='AsyncFileUploadForFamily']").val("");
                $("input[id*='AsyncFileUploadForFamily']").css("background-color", "");
                $("input[id$='hdnPictureIdForFamily']").val("");
                $("img[id$='imgDisplayForFamily']").hide();
                $("#divdummyClassForFamily").addClass("dummy");



                // alert($("#tbodyVisitors tr").find('.status').html());


            }




            function getGuests(ResidantStatus, eid, callFrom) {

                $("#fieldsetPersonalGrd").hide();

                if (ResidantStatus == 'Out Living') {
                    alert('This Employee is Non-Residant');
                    return;
                }

                //  $("#fieldsetGuest").show();
                $("#trCloseforGuest").hide();
                $("[id$='hdnEID']").val(eid)
                $.post("../RMS/CallBack/GuestsHandler.aspx", { EID: eid }).done(function (data) {
                    var response = data;
                    //var start = data.indexOf("#StartGuest#") + 14;
                    //var end = data.indexOf("#EndGuest#");
                    //$("#divGuestInfo").html(response.substring(start, end));

                    var start = data.indexOf("#StartGuestDet#") + 17;
                    var end = data.indexOf("#EndGuestDet#");
                    $("#tbodyGuest").html(response.substring(start, end));


                    $("#tbodyGuest tr").each(function () {

                        // $("#lgndGuestDetail").html("<span style='color:blue'>"+$(".ownerName").html() + "`s</span>"+ " Guest Detail");

                        $("#lgndAddUpdateGuest").html("Add/Update Guest/Guest Family of " + "<span style='color:blue'>" + $(".HostName").html() + "</span>")
                        $("#lgndGuestDetail").html("Guest Detail of " + "<span style='color:blue'>" + $(".HostName").html() + "</span>")

                        if ($(this).find('.status').html() == "Active") {
                            $(this).find(".tdGuestInActive").css("display", "inline-block");
                            $(this).find(".tdGuestBlackList").css("display", "inline-block");
                            $(this).find(".tdGuestActive").css("display", "none");
                        }
                        else if ($(this).find('.status').html() == "InActive") {
                            $(this).find(".tdGuestActive").css("display", "inline-block");
                            $(this).find(".tdGuestBlackList").css("display", "inline-block");
                            $(this).find(".tdGuestInActive").css("display", "none");
                        }

                        else {
                            $(this).find(".tdGuestBlackList").css("display", "none");
                            $(this).find(".tdGuestBlackList").parent().parent().css("color", "Red");
                            $(this).find(".tdGuestBlackList").parent().parent().css("font-weight", "bold");
                            $(this).find(".tdGuestActive").css("display", "inline-block");
                            $(this).find(".tdGuestInActive").css("display", "inline-block");
                        }


                    });
                    //start = data.indexOf("#StartFMS#") + 10;
                    //end = data.indexOf("#EndFMS#");
                    //$("#tbodyFMS").html(response.substring(start, end));

                    //if ($("#tbodyFMS tr").length == 0) {
                    //    $("#tbodyFMS").html("<tr><td class='noRecordFound' colspan='9'>No Record Found</td></tr>");
                    //}

                    $("#fieldsetGuest").show();
                    $("#fieldsetPersonal").hide();
                    $("#fieldsetFM").hide();
                    $("#divGuestFamily").hide();
                    if (callFrom == "Grid") {
                        $("#btnAddFM").show();
                    }

                    $("div[id*='AsyncFileUploadForServantFamily']").css("width", "400px");
                    $("input[id*='AsyncFileUploadForServantFamily']").val("");
                    $("div[id*='AsyncFileUploadForServantFamily']").css("margin-top", "-34px");
                    $("input[id*='AsyncFileUploadForServantFamily']").css("background-color", "");

                    //$(elem).closest("tr").after("<tr class='familymember'><td colspan='17'><div style='padding: 5px;color: #005978;font-weight: bold;font-style: italic;'>Family Members</div> " + response.substring(start, end) + "</td></tr>");
                });
            }



            function getServants(ResidantStatus, eid, callFrom) {


                /////Edit by As
                $("#fieldsetPersonalGrd").hide();

                /////-----As

                if (ResidantStatus == 'Out Living') {
                    alert('This Employee is Non-Residant');
                    return;
                }

                $("#trCloseforServant").hide();
                $("[id$='hdnEID']").val(eid)
                $.post("../RMS/CallBack/ServantsHandler.aspx", { EID: eid }).done(function (data) {
                    var response = data;
                    //var start = data.indexOf("#StartServant#") + 14;
                    //var end = data.indexOf("#EndServant#");
                    //$("#divServantInfo").html(response.substring(start, end));

                    var start = data.indexOf("#StartServantDet#") + 17;
                    var end = data.indexOf("#EndServantDet#");
                    $("#tbodyServant").html(response.substring(start, end));


                    $("#tbodyServant tr").each(function () {

                        // $("#lgndServantDetail").html("<span style='color:blue'>"+$(".ownerName").html() + "`s</span>"+ " Servant Detail");

                        $("#lgndAddUpdateServant").html("Add/Update Servant " + "<span style='color:blue'>" + $(".eidName").html() + "</span>")
                        // $("#lgndServantDetail").html("Servant Detail of " + "<span style='color:blue'>" + $(".ownerNameofServant").html() + "</span>")

                        if ($(this).find('.status').html() == "Active") {
                            $(this).find(".tdServantInActive").css("display", "inline-block");
                            $(this).find(".tdServantBlackList").css("display", "inline-block");
                            $(this).find(".tdServantActive").css("display", "none");
                        }
                        else if ($(this).find('.status').html() == "InActive") {
                            $(this).find(".tdServantActive").css("display", "inline-block");
                            $(this).find(".tdServantBlackList").css("display", "inline-block");
                            $(this).find(".tdServantInActive").css("display", "none");
                        }

                        else {
                            $(this).find(".tdServantBlackList").css("display", "none");
                            $(this).find(".tdServantBlackList").parent().parent().css("color", "Red");
                            $(this).find(".tdServantBlackList").parent().parent().css("font-weight", "bold");
                            $(this).find(".tdServantActive").css("display", "inline-block");
                            $(this).find(".tdServantInActive").css("display", "inline-block");
                        }


                    });
                    //start = data.indexOf("#StartFMS#") + 10;
                    //end = data.indexOf("#EndFMS#");
                    //$("#tbodyFMS").html(response.substring(start, end));

                    //if ($("#tbodyFMS tr").length == 0) {
                    //    $("#tbodyFMS").html("<tr><td class='noRecordFound' colspan='9'>No Record Found</td></tr>");
                    //}

                    $("#fieldsetServant").show();
                    $("#fieldsetPersonal").hide();
                    $("#fieldsetFM").hide();
                    $("#divServantFamily").hide();
                    if (callFrom == "Grid") {
                        $("#btnAddFM").show();
                    }

                    $("div[id*='AsyncFileUploadForServant']").css("width", "400px");
                    $("input[id*='AsyncFileUploadForServant']").val("");
                    $("div[id*='AsyncFileUploadForServant']").css("margin-top", "-34px");
                    $("input[id*='AsyncFileUploadForServant']").css("background-color", "");

                    //$(elem).closest("tr").after("<tr class='familymember'><td colspan='17'><div style='padding: 5px;color: #005978;font-weight: bold;font-style: italic;'>Family Members</div> " + response.substring(start, end) + "</td></tr>");
                });
            }
            function getServantFamily(sid, callFrom, Eid) {

                $("[id$='hdnEID']").val(Eid);

                $("#divServantFamily").show();
                $("[id$='txtIdST']").val(sid);
                $.post("../RMS/CallBack/ServantFamilyMembersHandler.aspx", { SID: sid }).done(function (data) {
                    var response = data;
                    var start = data.indexOf("#StartFMS#") + 10;
                    var end = data.indexOf("#EndFMS#");
                    $("#tbodyFMS").html(response.substring(start, end));


                    $("#tbodyFMS tr").each(function () {

                        $("#lgndAddServantFamilyDetail").html("Add/Update Servant Family Member of " + "<span style='color:blue'>" + $(".ownerNameofServantFamily").html() + "</span>")
                        $("#lgndSevantFamilyDetail").html("Servant`s Family Detail of " + "<span style='color:blue'>" + $(".ownerNameofServantFamily").html() + "</span>")


                        if ($(this).find('.status').html() == "Active") {
                            $(this).find(".tdServantFamilyInActive").css("display", "inline-block");
                            $(this).find(".tdServantFamilyBlackList").css("display", "inline-block");
                            $(this).find(".tdServantFamilyActive").css("display", "none");
                        }
                        else if ($(this).find('.status').html() == "InActive") {
                            $(this).find(".tdServantFamilyActive").css("display", "inline-block");
                            $(this).find(".tdServantFamilyBlackList").css("display", "inline-block");
                            $(this).find(".tdServantFamilyInActive").css("display", "none");
                        }

                        else {
                            $(this).find(".tdServantFamilyBlackList").css("display", "none");
                            $(this).find(".tdServantFamilyBlackList").parent().parent().css("color", "Red");
                            $(this).find(".tdServantFamilyBlackList").parent().parent().css("font-weight", "bold");
                            $(this).find(".tdServantFamilyActive").css("display", "inline-block");
                            $(this).find(".tdServantFamilyInActive").css("display", "inline-block");
                        }


                    });



                });




            }


            function saveResidenet()
            {
                

                var HRNO = $("input[id$='txtPNO']").val().trim();
                if (HRNO == "") {
                    alert("HR No# is required!");
                    return false;
                    //txtPNO.Focus();
                }
                
                //ddlDeptUnit
                //ddlRank
                //ddlDesignation
                //var Terminal_Type_Id = $("select[id$='ddlterminaltypeid']").val().trim();
                //var Terminal_Type_Id = $("select[id$='ddlterminaltypeid']").val().t     }
                var CNIC = $("input[Id$='txtNIC']").val().trim();
                if (CNIC == "") {
                    alert("CNIC is required!");
                    return false;
                }
                //var Rank = $("select[id$='ddlRank']").val().trim();
                //if ((Rank == "-- Select --") || (Rank == "")) {
                //    alert("Rank is required!");
                //    return false;
                //}
                var Appointment = $("select[id$='ddlDesignation']").val().trim();
                if ((Appointment == "-- Select --") || (Appointment == "")) {
                    alert("Appointment is required!");
                    return false;
                }

                var Dept = $("select[id$='ddlDeptUnit']").val().trim();
                if ((Dept == "-- Select --") || (Dept == ""))
                {
                    alert("Department is required!");
                    return false;
                }
                var ClearanceStatus = $("select[id$='ddlclearanceStatus']").val().trim();
                if ((ClearanceStatus == "-- Select --") || (ClearanceStatus == "")) {
                    alert("ClearanceStatus is required!");
                    return false;
                }
                var Gender = $("select[id$='ddlGender']").val().trim();
                if ((Gender == "-- Select --") || (Gender == "")) {
                    alert("Gender is required!");
                    return false;
                }

                



                        var Getimg = $("#photoEmp")[0].src;
                var img = "";
                if (Getimg == "") {
                    img = $.trim($("input[id$='hdnPictureId']").val());
                    
                }
                else {
                    img = Getimg;
                   
                }
               
                $("#divMsg").hide();
                if ($("input[id$='hdnPictureId']").val().indexOf(":") >= 0) {
                    $("input[id$='hdnPictureId']").val("");

                }

                if (!validate("tblPersonal")) {
                    var request = "{"
                        + "'EID':'" + $.trim($("[id$='hdnEID']").val()) + "',"
                        + "'ServiceNo':'" + $.trim($("[id$='txtPNO']").val()) + "',"
                        + "'FirstName':'" + $.trim($("[id$='txtFirstName']").val()) + "',"
                        + "'LastName':'" + $.trim($("[id$='txtLastName']").val()) + "',"
                        + "'NIC':'" + $.trim($("[id$='txtNIC']").val()) + "',"


                        + "'Rank':'" + $.trim($("[id$='ddlRank']").val()) + "',"
                        + "'ReleaseDate':'" + $.trim($("[id$='txtValidity']").val()) + "',"

                        + "'Designation':'" + $.trim($("[id$='ddlDesignation']").val()) + "',"
                        + "'CurrAddr':'" + $.trim($("[id$='txtCurrentAdd']").val()) + "',"

                        + "'Department':'" + $.trim($("[id$='ddlDeptUnit']").val()) + "',"
                        + "'PerAddr':'" + $.trim($("[id$='txtPermanentAdd']").val()) + "',"



                        + "'Mobile':'" + $.trim($("[id$='txtCellPhone']").val()) + "',"
                        + "'PhoneHome':'" + $.trim($("[id$='txtPhoneHome']").val()) + "',"


                        + "'Dob':'" + $.trim($("[id$='txtDOB']").val()) + "',"
                        + "'PhoneOffice':'" + $.trim($("[id$='txtPhoneOffice']").val()) + "',"

                        + "'clearanceStatus':'" + $.trim($("[id$='ddlclearanceStatus']").val()) + "',"
                        + "'Section':'" + $.trim($("[id$='txtSection']").val()) + "',"

                        + "'FatherName':'" + $.trim($("[id$='txtFatherName']").val()) + "',"
                        + "'MotherName':'" + $.trim($("[id$='txtMotherName']").val()) + "',"

                        + "'BloodGroup':'" + $.trim($("[id$='txtBloodGroup']").val()) + "',"
                        + "'Cadre':'" + $.trim($("[id$='ddlCadre']").val()) + "',"

                        + "'ResidentStatus':'" + $.trim($("[id$='ddlResidant']").val()) + "',"
                        + "'CardColor':'" + $.trim($("[id$='ddlCardColor']").val()) + "',"

                        + "'Transport':'" + $.trim($("[id$='ddlTransport']").val()) + "',"
                        + "'SiteAllowed':'" + $.trim($("[id$='ddlSiteAllowed']").val()) + "',"

                        + "'EmployeeIdentificationMark':'" + $.trim($("[id$='txtEmployeeIdentificationMark']").val()) + "',"

                        + "'gender':'" + $.trim($("[id$='ddlGender']").val()) + "',"
                        + "'Remarks':'" + $.trim($("[id$='txtRemarks']").val()) + "',"

                        + "'AuthType':'" + $.trim($("[id$='ResidentAuthenticationType']").val()) + "',"

                        + "'Photo':'" + img + "'}";

                        $('#photoEmp').attr('src', '');

                    //  alert(request);
                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        url: "../RMS/RMSWebMethod.aspx/SaveResident",
                        data: request,
                        success: function (data) {
                            showSuccessMsg("Information saved successfully!");
                            $("[id$='hdnEID']").val(data.d);
                            $("[id$='txtId']").val(data.d);
                            $("#divFMS").show();
                            //$("#WebCamCallEmps").hide();
                            $("WebCamCallEmp").hide = true;
                            //$("#btnAddServant").show();
                            getResidents();
                            location.reload();
                        }
                    });
                }
            }

            function clearResidenet() {
                $("div[id*='AsyncFileUpload1']").css("width", "400px");
                $("div[id*='AsyncFileUpload1']").css("margin-top", "-34px");
                $("input[id*='AsyncFileUpload1']").val("");
                $("input[id*='AsyncFileUpload1']").css("background-color", "");
                $("input[id$='hdnPictureId']").val("");
                $("img[id$='imgDisplay']").hide();
                $("#dummy").addClass("dummy");
                $("#tblPersonal input[type=text]").val("");
                $("#tblPersonal select").val("");

                $("[id$='hdnEID']").val("");

            }
            //---------------------------------------------Inactivate Employee Record------------------------------------------
            function InactiveEmployee(EID) {

                if (confirm("Are you sure to Delete this Employee ?")) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../RMS/RMSWebMethod.aspx/InactiveEmployee",
                        data: "{'EID':'" + EID + "'}",
                        success: onsuccessInactiveEmployee
                    });

                    return false;
                }
                else
                    return false;
            }


            function onsuccessInactiveEmployee(msg) {
                //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
                showSuccessMsg("Employee Deleted Successfully!");
                getResidents();
                return false;
            }



            //-----------------------------------------------end-------------------------------------------------------------


            //---------------------------------------------Activate Employee Record------------------------------------------
            function ActivateEmployee(EID) {

                if (confirm("Are you sure you wish to Activate this User?")) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../RMS/RMSWebMethod.aspx/ActivateEmployeeRecord",
                        data: "{'EID':'" + EID + "'}",
                        success: onsuccessActivateUser
                    });

                    return false;
                }
                else
                    return false;
            }


            function onsuccessActivateUser(msg) {
                //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
                showSuccessMsg("User has been Activated Successfully!");
                getResidents();
                return false;
            }


            //----------------------------------------Black List Employee---------------------------------------------------------------------------------------
            function CloseModalBlackList() {
                //  Clear_Details();
                // alert("test");
                $("#divBlackLisReasoning").jqmHide();
                $(".jqmWindow input, select").attr("disabled", false);
                return false;
            }

            function savereason() {

                var EmployeeID = $("input[id$='txtEmployeeIDS']").val();
                var BlackListReason = $("input[id$='txtReason']").val();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../RMS/RMSWebMethod.aspx/AddEmployeeBLReason",
                    data: "{'EmployeeID':'" + EmployeeID + "','BlackListReason':'" + BlackListReason + "'}",
                    success: onsuccessSaveReson
                });

            }
            var empBlackListFlag = false;
            function onsuccessSaveReson(msg) {
                empBlackListFlag = true;
                BlackListPACSResident($("input[id$='txtEmployeeIDS']").val(), true);
            }
            function BlackListPACSResident(EID, flag) {
                //$("#divBlackLisReasoning").show();

                // e.preventDefault();
                if (flag != true && flag == true) {
                    $("input[id$='txtEmployeeIDS']").val("");
                    $("#txtEmployeeIDS").val(EID);
                    $('#divBlackLisReasoning').addClass("jqmWindow");
                    //$('#divChangePassword').css("margin-left", "-44%");
                    $('#divBlackLisReasoning').css("width", "45%");
                    $('#divBlackLisReasoning').css("z-index", "15");
                    $('#divBlackLisReasoning').jqm({ modal: true, overlay: 75, trigger: false });
                    $('#divBlackLisReasoning').jqmShow();
                }
                else if (confirm("Are you sure you wish to Black List this User?")) {
                    {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "../RMS/RMSWebMethod.aspx/BlackListResidentRecord",
                            data: "{'EID':'" + EID + "'}",
                            success: onsuccessBlackListResident
                        });
                    }
                    return false;
                }


                else
                    return false;

            }


            function onsuccessBlackListResident(msg) {
                //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
                showSuccessMsg("User has been Black Listed Successfully!");
                // CloseModalBlackList();
                getResidents();
                return false;
            }

            //-----------------------------------------------end-------------------------------------------------------------


            function saveFamilyMember() {
                $("#divMsg").hide();

                var Getimg = $("#photoFM")[0].src;
                var img = "";
                if (Getimg == "") {
                    img = $.trim($("input[id$='hdnPictureIdForFamily']").val());
                
                }
                else {
                    img = Getimg;
                
                }

                if ($("input[id$='hdnPictureIdForFamily']").val().indexOf(":") >= 0) {
                    $("input[id$='hdnPictureIdForFamily']").val("");

                }
                if ($.trim($("[id$='hdnEID']").val()) == "0") {
                    showErrorMsg("Please save Personal Information first!");
                    return false;
                }
                else {
                    if (!validate("tblFamilyMember")) {
                        var EFID = $.trim($("[id$='txtIdFM']").val()) == "" ? 0 : $.trim($("[id$='txtIdFM']").val());
                        var request = "{"
                            + "'EFID':'" + EFID + "',"
                            + "'EID':'" + $.trim($("[id$='hdnEID']").val()) + "',"
                            + "'FirstName':'" + $.trim($("[id$='txtFirstNameFM']").val()) + "',"
                            + "'LastName':'" + $.trim($("[id$='txtLastNameFM']").val()) + "',"
                            + "'Relation':'" + $.trim($("[id$='ddlRelationFM']").val()) + "',"
                            //+ "'RoleId':'" + $.trim($("[id$='txtFatherHusbandFM']").val()) + "',"
                            + "'NIC':'" + $.trim($("[id$='txtNICFM']").val()) + "',"
                            + "'ddlFamilysecurityClearance':'" + $.trim($("[id$='ddlFamilysecurityClearance']").val()) + "',"
                            + "'Dob':'" + $.trim($("[id$='txtFamilyDOB']").val()) + "',"
                            + "'VisitorAdd':'" + $.trim($("[id$='txtVisitorAdd']").val()) + "',"
                            + "'Gender':'" + $.trim($("[id$='ddlFamilyGender']").val()) + "',"
                            + "'ClearanceLevel':'" + $.trim($("[id$='ddlFamilyClearanceLevel']").val()) + "',"

                            + "'ValidFrom':'" + $.trim($("[id$='txtFamilyMemberValidityFrom']").val()) + "',"
                            + "'ValidTo':'" + $.trim($("[id$='txtFamilyMemberValidityTo']").val()) + "',"
                            + "'AuthType':'" + $.trim($("[id$='FamilyMemberAuthenticationType']").val()) + "',"

                            + "'photo':'" + img + "'"
                            + "}";

                        $.ajax({
                            type: "POST",
                            dataType: "json",
                            contentType: "application/json",
                            url: "../RMS/RMSWebMethod.aspx/SaveFamilyMember",
                            data: request,
                            success: function () {
                                showSuccessMsg("Information saved successfully!");
                                $("#tblFamilyMember input[type=text]").val("");
                                $("#tblFamilyMember select").val("");
                                $("[id$='txtIdFM']").val("");
                                getFamilyMembers('', $("[id$='hdnEID']").val(), 1);
                                //  getResidents();
                                $("#btnAddFM").hide();

                                $("input[id$='txtVisitorAdd']").focus();
                            }
                        });
                    }
                }

            }

            function ShowDetails_Modal(EID, elm, flag) {

                
                $("#btnBackResident").hide();
                $("#WebCamCallEmps").hide();
                $("#btnClearResident").hide();
                

                

                editResident(EID, elm, flag);

            }
            function CloseModal() {

                $("#WebCamCallEmps").show();
                $("#btnBackResident").show();
                $("#btnClearResident").show();
                $("#fieldsetPersonalGrd").show();
                //  Clear_Details();
                // alert("test");
                $("#fieldsetPersonal").jqmHide();
                $(".jqmWindow input, select").attr("disabled", false);
                return false;
            }


            function ShowDetails_ModalForServant(SID, elm, flag) {

                $("#WebCamCallSR").hide();
                editServant(SID, elm, flag);
            }

            function CloseModalForServant() {

                $("#WebCamCallSR").show();
                //  Clear_Details();
                // alert("test");
                $("#divServantInfo").jqmHide();
                $(".jqmWindow input, select").attr("disabled", false);
                return false;
            }

            function editResident(eid, elm, flag) {
                $("#imgDisplay").show();
                $("#photoEmp").hide();
                $("#videoEmp").hide();

                //////Edit By As

                $("#fieldsetPersonalGrd").hide();
                /////----As


                if (flag == '1') {
                    //alert("testdjdjjdjd")
                    $('#fieldsetPersonal').addClass("jqmWindow");
                    $(".jqmWindow input, select").attr("disabled", true);
                    $("img[src$='Calendar.gif']").hide();
                    $('#fieldsetPersonal').css("margin-left", "-44%");
                    $('#fieldsetPersonal').css("width", "86%");
                    $('#trClose').show();
                    $("img[src$='btn_close02.png']").show();
                    $("input[id$='btnSaveResident']").hide();
                    $("div[id*='AsyncFileUpload1']").hide();
                    $('#fieldsetPersonal').jqm({ modal: true, overlay: 75, trigger: false });
                    $('#fieldsetPersonal').jqmShow();
                }
                else {
                    $('#fieldsetPersonal').css("margin-left", "0%");
                    $('#fieldsetPersonal').css("width", "97%");
                    $('#trClose').hide();
                    $("img[src$='btn_close02.png']").hide();
                    $("input[id$='btnSaveResident']").show();
                    $("div[id*='AsyncFileUpload1']").show();
                    $(".jqmWindow input, select").attr("disabled", false);
                    $("img[src$='Calendar.gif']").show();
                    $('#fieldsetPersonal').removeClass("jqmWindow");
                }
                $("div[id*='AsyncFileUpload1']").css("width", "400px");
                $("input[id*='AsyncFileUpload1']").val("");
                $("div[id*='AsyncFileUpload1']").css("margin-top", "-34px");
                $("input[id*='AsyncFileUpload1']").css("background-color", "");
                $("input[id$='hdnPictureId']").val("");
                $("img[id$='imgDisplay']").hide();
                $("#divdummyClass").addClass("dummy");


                clearFamilyMember();
                $("#tblPersonal input[type=text]").val("");
                $("#tblPersonal select").val("");
                $("[id$='hdnEID']").val(eid);
                $("#txtId").val(eid);
                $("#txtId").attr("disabled", true);
                $("#txtPNO").val($.trim($(elm).closest("tr").find(".pno").html()));
                $("#txtFirstName").val($.trim($(elm).closest("tr").find(".fn").html()));
                $("#txtLastName").val($.trim($(elm).closest("tr").find(".ln").html()));
                $("#txtNIC").val($.trim($(elm).closest("tr").find(".nic").html()));
                $("[id$='txtDOB']").val($.trim($(elm).closest("tr").find(".DOB").html()));

                $("#txtCurrentAdd").val($.trim($(elm).closest("tr").find(".cAdd").html()));
                $("[id$='ddlDeptUnit']").val($.trim($(elm).closest("tr").find(".dept").html()));
                $("#txtPermanentAdd").val($.trim($(elm).closest("tr").find(".pAdd").html()));

                $("#txtCellPhone").val($.trim($(elm).closest("tr").find(".mob").html()));

                $("#txtPhoneHome").val($.trim($(elm).closest("tr").find(".poh").html()));
                $("input[id$=txtNIC]").val($.trim($(elm).closest("tr").find(".nic").html()));


                $("[id$='ddlRank']").val($.trim($(elm).closest("tr").find(".rank").html()));
                $("[id$='ddlDesignation']").val($.trim($(elm).closest("tr").find(".desg").html()));

                $("#txtPhoneOffice").val($.trim($(elm).closest("tr").find(".pof").html()));


                $("input[id$='txtValidity']").val($.trim($(elm).closest("tr").find(".reld").html()));

                $("select[id$='ddlclearanceStatus']").val($.trim($(elm).closest("tr").find(".CStatus").html()));

                $("Select[id$='txtSection']").val($.trim($(elm).closest("tr").find(".Section").html()));
                $("input[id$='txtFatherName']").val($.trim($(elm).closest("tr").find(".FName").html()));
                $("input[id$='txtMotherName']").val($.trim($(elm).closest("tr").find(".MName").html()));

                $("Select[id$='txtBloodGroup']").val($.trim($(elm).closest("tr").find(".BGrop").html()));
                $("Select[id$='ddlCadre']").val($.trim($(elm).closest("tr").find(".Cad").html()));

                $("select[id$='ddlResidant']").val($.trim($(elm).closest("tr").find(".Sstaus").html()));
                $("Select[id$='ddlCardColor']").val($.trim($(elm).closest("tr").find(".CColor").html()));

                $("select[id$='ddlTransport']").val($.trim($(elm).closest("tr").find(".Tranp").html()));
                $("Select[id$='ddlSiteAllowed']").val($.trim($(elm).closest("tr").find(".CLevel").html()));

                $("input[id$='txtEmployeeIdentificationMark']").val($.trim($(elm).closest("tr").find(".IdtM").html()));
                $("Select[id$='ddlGender']").val($.trim($(elm).closest("tr").find(".gender").html()));
                $("input[id$='txtRemarks']").val($.trim($(elm).closest("tr").find(".Remarks").html()));
                $("input[id$='txtPhoneHome']").val($.trim($(elm).closest("tr").find(".PHome").html()));
                $("Select[id$='ResidentAuthenticationType']").val($.trim($(elm).closest("tr").find(".AuthType").html()));

                var CardPrefix = $.trim($(elm).closest("tr").find(".cardNo").html());
                CardPrefix = CardPrefix.split('-')[0];


                var str = $(elm).closest("tr").find(".newImage img").attr("src");

                var last = str.substring(str.lastIndexOf("/") + 1, str.length);

                if (last.split('.')[0] != "") {
                    $("#imgDisplay").attr("src", str);
                    $("input[id$='hdnPictureId']").val(last.split('.')[0])
                    $("#imgDisplay").show();
                    $("#divdummyClass").removeClass("dummy");
                }
                else {
                    $("#imgDisplay").hide();
                    $("#divdummyClass").addClass("dummy");
                }

                $("#fieldsetPersonal").show();
                $("#fieldsetFM").hide();
                $("#txtPhoneHome").focus();
                $("#fieldsetServant").hide();
                
                getRanks($(elm).closest("tr").find(".rank").html());

            }
            function editFM(eid, efid, elm) {

                $("#imgDisplayForFamily").show();
                $("#photoFM").hide();
                $("#videoFM").hide();

              
                $("#RecaptureFM").hide();
                $("#WebCamCallFM").show();

               
                $("#tblFamilyMember input[type=text]").val("");
                $("#tblFamilyMember select").val("");
                $("[id$='txtIdFM']").val(efid);
                $("[id$='hdnEID']").val(eid);


                $("[id$='txtFirstNameFM']").val($.trim($(elm).closest("tr").find(".firstName").html()));
                $("[id$='txtLastNameFM']").val($.trim($(elm).closest("tr").find(".lastName").html()));
                $("[id$='ddlRelationFM']").val($.trim($(elm).closest("tr").find(".relation").html()));
                $("[id$='txtNICFM']").val($.trim($(elm).closest("tr").find(".nic").html()));

                $("[id$='txtVisitorAdd']").val($.trim($(elm).closest("tr").find(".addr").html()));

                $("[id$='txtFamilyDOB']").val($.trim($(elm).closest("tr").find(".DOB").html()));
                $("[id$='ddlFamilysecurityClearance']").val($.trim($(elm).closest("tr").find(".SClearance").html()));

                $("[id$='ddlFamilyGender']").val($.trim($(elm).closest("tr").find(".FGender").html()));
                $("[id$='ddlFamilyClearanceLevel']").val($.trim($(elm).closest("tr").find(".FClearanceLevel").html()));

                $("[id$='txtFamilyMemberValidityFrom']").val($.trim($(elm).closest("tr").find(".VFrom").html()));
                $("[id$='txtFamilyMemberValidityTo']").val($.trim($(elm).closest("tr").find(".VTo").html()));
                $("[id$='FamilyMemberAuthenticationType']").val($.trim($(elm).closest("tr").find(".FMAuthType").html()));


                //var CardPrefix = $.trim($(elm).closest("tr").find(".cardNo").html());
                //CardPrefix = CardPrefix.split('-')[0];
                //$("select[id$='ddlFamilyCardCategory']").val(CardPrefix);

                var str = $(elm).closest("tr").find(".phto img").attr("src");

                var last = str.substring(str.lastIndexOf("/") + 1, str.length);

                if (last.split('.')[0] != "") {
                    $("#imgDisplayForFamily").attr("src", str);
                    $("input[id$='hdnPictureIdForFamily']").val(last.split('.')[0])
                    $("#imgDisplayForFamily").show();
                    $("#divdummyClassForFamily").removeClass("dummy");
                }
                else {
                    $("#imgDisplayForFamily").hide();
                    $("#divdummyClassForFamily").addClass("dummy");
                }

                $("#fieldsetFM").show();
                //$("#fieldsetPersonal").hide();            
            }

            function editFMS(eid, sid, elm) {

                $("div[id*='AsyncFileUploadForServantFamily']").css("width", "400px");
                $("input[id*='AsyncFileUploadForServantFamily']").val("");
                $("div[id*='AsyncFileUploadForServantFamily']").css("margin-top", "-34px");
                $("input[id*='AsyncFileUploadForServantFamily']").css("background-color", "");
                // $("input[id$='hdnPictureIdForServantFamily']").val("");
                $("img[id$='imgDisplayForServantFamily']").hide();
                $("#divdummyClassForServantFamily").addClass("dummy");


                $("#tblFMSForm input[type=text]").val("");
                $("#tblFMSForm select").val("");
                $("[id$='txtIdFMS']").val(sid);
                $("[id$='hdnEID']").val(eid);

                $("[id$='txtFirstNameFMS']").val($.trim($(elm).closest("tr").find(".firstName").html()));
                $("[id$='txtLastNameFMS']").val($.trim($(elm).closest("tr").find(".lastName").html()));
                $("[id$='txtNICFMS']").val($.trim($(elm).closest("tr").find(".nic").html()));
                $("[id$='txtProfessionFMS']").val($.trim($(elm).closest("tr").find(".prof").html()));
                $("[id$='txtCellNoFMS']").val($.trim($(elm).closest("tr").find(".mob").html()));
                $("[id$='ddlRelationFMS']").val($.trim($(elm).closest("tr").find(".relation").html()));
                $("[id$='txtPOWFMS']").val($.trim($(elm).closest("tr").find(".pow").html()));
                $("[id$='txtCardNoFMS']").val($.trim($(elm).closest("tr").find(".cardNo").html()));

                var str = $(elm).closest("tr").find(".phto img").attr("src");

                var last = str.substring(str.lastIndexOf("/") + 1, str.length);

                if (last.split('.')[0] != "") {
                    $("#imgDisplayForServantFamily").attr("src", str);
                    $("input[id$='hdnPictureIdForServantFamily']").val(last.split('.')[0])
                    $("#imgDisplayForServantFamily").show();
                    $("#divdummyClassForServantFamily").removeClass("dummy");
                }
                else {
                    $("#imgDisplayForServantFamily").hide();
                    $("#divdummyClassForServantFamily").addClass("dummy");
                }

            }
            function saveServant() {


                var Getimg = $("#photoSR")[0].src;
                var img = "";
                if (Getimg == "") {
                    img = $.trim($("input[id$='hdnPictureIdForServant']").val());
                    
                }
                else {
                    img = Getimg;
                    
                }



                //alert($.trim($("[id$='hdnPictureIdForServant']").val()));
                if ($("input[id$='hdnPictureIdForServant']").val().indexOf(":") >= 0) {
                    $("input[id$='hdnPictureIdForServant']").val("");

                }
                $("#divMsg").hide();
                if (!validate("tblServant")) {
                    var SID = $.trim($("[id$='txtIdST']").val()) == "" ? 0 : $.trim($("[id$='txtIdST']").val());
                    var request = "{"
                        + "'SID':'" + SID + "',"
                        + "'EID':'" + $.trim($("[id$='hdnEID']").val()) + "',"
                        + "'BCNo':'" + $.trim($("[id$='txtBCNumber']").val()) + "',"
                        + "'FirstName':'" + $.trim($("[id$='txtFirstNameST']").val()) + "',"
                        + "'LastName':'" + $.trim($("[id$='txtLastNameST']").val()) + "',"
                        + "'NIC':'" + $.trim($("[id$='txtNICST']").val()) + "',"

                        + "'DOB':'" + $.trim($("[id$='txtDOBST']").val()) + "',"
                        + "'PerAddr':'" + $.trim($("[id$='txtPermanentAddST']").val()) + "',"
                        + "'FH':'" + $.trim($("[id$='txtFH']").val()) + "',"
                        + "'MarkofIdentification':'" + $.trim($("[id$='txtMarkofIdentification']").val()) + "',"
                        + "'Mobile':'" + $.trim($("[id$='txtCellPhoneST']").val()) + "',"
                        + "'servantSecurity':'" + $.trim($("[id$='ddlServantSecurityClearance']").val()) + "',"
                        + "'ClearanceLevel':'" + $.trim($("[id$='ddlServantlearanceLevel']").val()) + "',"

                        + "'ValidTo':'" + $.trim($("[id$='txtServantValidTo']").val()) + "',"
                        + "'ValidFrom':'" + $.trim($("[id$='txtServantValidFrom']").val()) + "',"

                        + "'AuthType':'" + $.trim($("[id$='ServantAuthenticationType']").val()) + "',"

                        + "'Photo':'" + img + "'"
                        + "}";
                    // alert(request);
                    $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json",
                        url: "../RMS/RMSWebMethod.aspx/SaveServant",
                        data: request,
                        success: function (data) {
                            showSuccessMsg("Information saved successfully!");

                            $("[id$='txtIdST']").val(data.d);
                            getServants('', $.trim($("[id$='hdnEID']").val()));
                            getResidents();
                            ClearServantTable();
                            // alert($("[id$='txtIdST']").val());
                        }
                    });
                }
            }

            function editServant(sid, elm, flag) {


                $("#imgDisplayForServant").show();
                $("#photoSR").hide();
                $("#videoSR").hide();

                if (flag == '1') {
                    $('#divServantInfo').addClass("jqmWindow");
                    $(".jqmWindow input, select").attr("disabled", true);
                    $("img[src$='Calendar.gif']").hide();
                    $('#divServantInfo').css("margin-left", "-44%");
                    $('#divServantInfo').css("width", "86%");
                    $('#trCloseforServant').show();
                    $("#divServantSaveClearButtons").hide();
                    $("div[id*='AsyncFileUploadForServant']").hide();

                    $('#divServantInfo').jqm({ modal: true, overlay: 75, trigger: false });
                    $('#divServantInfo').jqmShow();
                }
                else {
                    $('#divServantInfo').css("margin-left", "0%");
                    $('#divServantInfo').css("width", "97%");
                    $('#trCloseforServant').hide();

                    $("#divServantSaveClearButtons").show();
                    $("div[id*='AsyncFileUploadForServant']").show();
                    $(".jqmWindow input, select").attr("disabled", false);
                    $("img[src$='Calendar.gif']").show();
                    $('#divServantInfo').removeClass("jqmWindow");
                    $('#divServantInfo').show();
                }


                $("div[id*='AsyncFileUploadForServant']").css("width", "400px");
                $("input[id*='AsyncFileUploadForServant']").val("");
                $("div[id*='AsyncFileUploadForServant']").css("margin-top", "-34px");
                $("input[id*='AsyncFileUploadForServant']").css("background-color", "");
                $("input[id$='hdnPictureIdForServant']").val("");
                $("img[id$='imgDisplayForServant']").hide();
                $("#divdummyClassForServant").addClass("dummy");

                $("[id$='txtIdST']").val(sid);
                // $("[id$='hdnEID']").val();

                $("[id$='txtFirstNameST']").val($.trim($(elm).closest("tr").find(".firstName").html()));
                $("[id$='txtLastNameST']").val($.trim($(elm).closest("tr").find(".lastName").html()));
                $("[id$='txtNICST']").val($.trim($(elm).closest("tr").find(".nic").html()));

                $("[id$='txtBCNumber']").val($.trim($(elm).closest("tr").find(".BC").html()));

                $("[id$='txtMarkofIdentification']").val($.trim($(elm).closest("tr").find(".Identification").html()));

                $("[id$='txtServantValidFrom']").val($.trim($(elm).closest("tr").find(".VFrom").html()));
                $("[id$='txtServantValidTo']").val($.trim($(elm).closest("tr").find(".VTo").html()));
                $("[id$='ddlServantSecurityClearance']").val($.trim($(elm).closest("tr").find(".SClearance").html()));
                $("[id$='ddlServantlearanceLevel']").val($.trim($(elm).closest("tr").find(".ClearanceL").html()));

                $("[id$='txtCurrentAddST']").val($.trim($(elm).closest("tr").find(".curAddr").html()));
                $("[id$='txtDOBST']").val($.trim($(elm).closest("tr").find(".dob").html()));
                $("[id$='txtPermanentAddST']").val($.trim($(elm).closest("tr").find(".PerAdd").html()));
                $("[id$='txtFH']").val($.trim($(elm).closest("tr").find(".fh").html()));


                $("[id$='txtCellPhoneST']").val($.trim($(elm).closest("tr").find(".mob").html()));
                $("[id$='ServantAuthenticationType']").val($.trim($(elm).closest("tr").find(".SAuthType").html()));




                var str = $(elm).closest("tr").find(".phto img").attr("src");

                var last = str.substring(str.lastIndexOf("/") + 1, str.length);

                if (last.split('.')[0] != "") {
                    $("#imgDisplayForServant").attr("src", str);
                    $("input[id$='hdnPictureIdForServant']").val(last.split('.')[0])
                    $("#imgDisplayForServant").show();
                    $("#divdummyClassForServant").removeClass("dummy");
                }
                else {
                    $("#imgDisplayForServant").hide();
                    $("#divdummyClassForServant").addClass("dummy");
                }

            }

            //----------------------------------------------------------Clear and Delete Servant Record --------------------------------------------------------------------
            function ClearServantTable() {
                $("#tblServant input[type='text']").val('');
                $("div[id*='AsyncFileUploadForServant']").css("width", "400px");
                $("input[id*='AsyncFileUploadForServant']").val("");
                $("div[id*='AsyncFileUploadForServant']").css("margin-top", "-34px");
                $("input[id*='AsyncFileUploadForServant']").css("background-color", "");
                $("input[id$='hdnPictureIdForServant']").val("");
                $("img[id$='imgDisplayForServant']").hide();
                $("select[id$='ddlReligionST']").val("");
                $("#divdummyClassForServant").addClass("dummy");
            }

            //-----------------------------------------------Inactive Servant Record-----------------------------------------------------------------------------------------------
            function InactiveServantRecord(SID) {

                if (confirm("Are you sure you wish to Inactive this Record?")) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../RMS/RMSWebMethod.aspx/InactiveServantRecord",
                        data: "{'SID':'" + SID + "'}",
                        success: onsuccessInactiveServantRecord
                    });

                    return false;
                }
                else
                    return false;
            }


            function onsuccessInactiveServantRecord(msg) {
                //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
                showSuccessMsg("User has been Inactivate Successfully!");
                getServants('', $.trim($("[id$='hdnEID']").val()));
                getResidents();
                return false;
            }


            //---------------------------------------------Activate Visitor Record------------------------------------------
            function ActivateServantRecord(SID) {

                if (confirm("Are you sure you wish to Activate this User?")) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../RMS/RMSWebMethod.aspx/ActivateServantRecord",
                        data: "{'SID':'" + SID + "'}",
                        success: onsuccessActivateServantRecord
                    });

                    return false;
                }
                else
                    return false;
            }


            function onsuccessActivateServantRecord(msg) {
                //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
                showSuccessMsg("User has been Activated Successfully!");
                getServants('', $.trim($("[id$='hdnEID']").val()));
                getResidents();
                return false;
            }

            //----------------------------------------Black List Visistor---------------------------------------------------------------------------------------

            function BlackListServantRecord(SID) {
                if (confirm("Are you sure you wish to Black List this User?")) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../RMS/RMSWebMethod.aspx/BlackListServantRecord",
                        data: "{'SID':'" + SID + "'}",
                        success: onsuccessBlackListServant
                    });

                    return false;
                }
                else
                    return false;
            }


            function onsuccessBlackListServant(msg) {
                //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
                showSuccessMsg("User has been Black Listed Successfully!");
                getServants('', $.trim($("[id$='hdnEID']").val()));
                getResidents();
                return false;
            }



            //-----------------------------------------------------------End Delete Servant--------------------------------------------------
            function saveServantFamilyMember() {

                if ($("input[id$='hdnPictureIdForServantFamily']").val().indexOf(":") >= 0) {
                    $("input[id$='hdnPictureIdForServantFamily']").val("");

                }
                $("#divMsg").hide();
                if ($.trim($("[id$='txtIdST']").val()) == "" || $.trim($("[id$='txtIdST']").val()) == "0") {
                    showErrorMsg("Please save Servant Information first!");
                    return false;
                }
                else {
                    if (!validate("tblFMSForm")) {
                        var SFID = $.trim($("[id$='txtIdFMS']").val()) == "" ? 0 : $.trim($("[id$='txtIdFMS']").val());
                        var request = "{"
                            + "'SFID':'" + SFID + "',"
                            + "'SID':'" + $.trim($("[id$='txtIdST']").val()) + "',"
                            + "'EID':'" + $.trim($("[id$='hdnEID']").val()) + "',"
                            + "'FirstName':'" + $.trim($("[id$='txtFirstNameFMS']").val()) + "',"
                            + "'LastName':'" + $.trim($("[id$='txtLastNameFMS']").val()) + "',"
                            + "'Relation':'" + $.trim($("[id$='ddlRelationFMS']").val()) + "',"
                            + "'NIC':'" + $.trim($("[id$='txtNICFMS']").val()) + "',"
                            + "'Profession':'" + $.trim($("[id$='txtProfessionFMS']").val()) + "',"
                            + "'Mobile':'" + $.trim($("[id$='txtCellNoFMS']").val()) + "',"
                            + "'PlaceofWork':'" + $.trim($("[id$='txtPOWFMS']").val()) + "',"
                            + "'Photo':'" + $.trim($("[id$='hdnPictureIdForServantFamily']").val()) + "'"
                            + "}";

                        $.ajax({
                            type: "POST",
                            dataType: "json",
                            contentType: "application/json",
                            url: "../RMS/RMSWebMethod.aspx/SaveFamilyMemberServant",
                            data: request,
                            success: function () {
                                showSuccessMsg("Information saved successfully!");
                                //$("#tblFMSForm input[type=text]").val("");
                                $("#tblFMSForm select").val("");

                                getServantFamily($.trim($("[id$='txtIdST']").val()), "", $("[id$='hdnEID']").val());
                                // getFamilyMembers($("[id$='txtIdST']").val(), 1);
                                ClearServantFamilyTable();
                            }
                        });
                    }
                }
            }
            //------------------------------------------------Clear and Delete Servant Family Member Record-----------------------------------------------------------------------------------------
            function ClearServantFamilyTable() {
                $("#tblFMSForm input[type='text'], select").val('');

                $("div[id*='AsyncFileUploadForServantFamily']").css("width", "400px");
                $("input[id*='AsyncFileUploadForServantFamily']").val("");
                $("div[id*='AsyncFileUploadForServantFamily']").css("margin-top", "-34px");
                $("input[id*='AsyncFileUploadForServantFamily']").css("background-color", "");
                $("input[id$='hdnPictureIdForServantFamily']").val("");
                $("img[id$='imgDisplayForServantFamily']").hide();
                //$("select[id$='ddlReligionST']").val("");
                $("#divdummyClassForServantFamily").addClass("dummy");

            }
            function clearSearchCriteria() {
                $("#tblSearchCriteria input[type=text]").val("");
                $("#tblSearchCriteria select").val("");
            }

            function InactiveServantFamilyRecord(SFID) {

                if (confirm("Are you sure you wish to Inactive this Record?")) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../RMS/RMSWebMethod.aspx/InactiveServantFamilyRecord",
                        data: "{'SFID':'" + SFID + "'}",
                        success: onsuccessInactiveServantFamilRecord
                    });

                    return false;
                }
                else
                    return false;
            }


            function onsuccessInactiveServantFamilRecord(msg) {
                //$("#divMsg").html("Record Inactived Successfully!").removeClass("error").addClass("success").show();
                showSuccessMsg("User Inactivated Successfully!");
                getServantFamily($.trim($("[id$='txtIdST']").val()));
                return false;
            }






            //---------------------------------------------Activate ServantFamily Record------------------------------------------
            function ActivateServantFamilyRecord(SFID) {

                if (confirm("Are you sure you wish to Activate this User?")) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../RMS/RMSWebMethod.aspx/ActivateServantFamilyRecord",
                        data: "{'SFID':'" + SFID + "'}",
                        success: onsuccessDeleteServantFamilys
                    });

                    return false;
                }
                else
                    return false;
            }


            function onsuccessDeleteServantFamilys(msg) {
                //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
                showSuccessMsg("User has been Activated Successfully!");
                getServantFamily($.trim($("[id$='txtIdST']").val()));
                return false;
            }

            //----------------------------------------Black List Visistor---------------------------------------------------------------------------------------

            function BlackListServantFamilyRecord(SFID) {
                if (confirm("Are you sure you wish to Black List this User?")) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../RMS/RMSWebMethod.aspx/BlackListServantFamilyRecord",
                        data: "{'SFID':'" + SFID + "'}",
                        success: onsuccessBlackListServantFamily
                    });

                    return false;
                }
                else
                    return false;
            }


            function onsuccessBlackListServantFamily(msg) {
                //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
                showSuccessMsg("User has been Black Listed Successfully!");
                getServantFamily($.trim($("[id$='txtIdST']").val()));
                return false;
            }


            //-----------------------------------------------End-------------------------------------------------------------------------------------------------------------

            function showHideImageForFamilyMembers() {

                $("div[id*='AsyncFileUpload1']").css("width", "400px");
                $("input[id*='AsyncFileUpload1']").val("");
                $("input[id*='AsyncFileUpload1']").css("background-color", "");
                $("input[id$='hdnPictureId']").val("");
                $("img[id$='imgDisplay']").hide();
                $("#divdummyClass").addClass("dummy");
            }


            function addNewEmployee() {
                //$("select[id$='ddlRank']").html("");
                //$("select[id$='ddlRank']").text("");
                $('#fieldsetPersonal').css("margin-left", "0%");
                $('#fieldsetPersonal').css("width", "97%");
                $('#trClose').hide();
                $("img[src$='btn_close02.png']").hide();
                $("input[id$='btnSaveResident']").show();
                $("div[id*='AsyncFileUpload1']").show();
                $('#fieldsetPersonal').removeClass("jqmWindow");
                $(".jqmWindow input, select").attr("disabled", false);
                $("img[src$='Calendar.gif']").show();
                $("#fieldsetPersonalGrd").hide();
                $("#fieldsetFM").hide();
                $("[id$='hdnEID']").val("0");
                $("div[id*='AsyncFileUpload1']").css("width", "400px");
                $("input[id*='AsyncFileUpload1']").val("");
                $("div[id*='AsyncFileUpload1']").css("margin-top", "-34px");
                $("input[id*='AsyncFileUpload1']").css("background-color", "");
                $("input[id$='hdnPictureId']").val("");
                $("img[id$='imgDisplay']").hide();
                $("#divdummyClass").addClass("dummy");

                $("#fieldsetPersonal").show();
                //$("#fieldsetFM").show();
                $("#tblPersonal input[type=text]").val("");
                $("input[id$='hdnPictureId']").val("")
                $("#tblPersonal select").val("");
                $("#tblFamilyMember input[type=text]").val("");
                $("#tblFamilyMember select").val("");
            }
            function addFamilyM() {
                $("#fieldsetFM").show();
                $("#fieldsetServant").hide();
                $("#tblFamilyMember input[type=text]").val("");
                $("#tblFamilyMember select").val("");
                $("[id$='txtIdST']").val("0");
                getFamilyMembers('', $("[id$='hdnEID']").val(), 1);

            }

            function AddServant() {
                $("#fieldsetFM").hide();
                $("#fieldsetServant").show();
                $("div[id*='AsyncFileUploadForServant']").css("width", "400px");
                $("input[id*='AsyncFileUploadForServant']").val("");
                $("div[id*='AsyncFileUploadForServant']").css("margin-top", "-34px");
                $("input[id*='AsyncFileUploadForServant']").css("background-color", "");
                $("input[id$='hdnPictureIdForServant']").val("");
                $("img[id$='imgDisplayForServant']").hide();
                $("#divdummyClassForServant").addClass("dummy");
                $("#tblServant input[type=text]").val("");
                $("#tblServant select").val("");

                $("[id$='txtIdST']").val("0");

            }
            function clearFamilyMember() {
                $("div[id*='AsyncFileUploadForFamily']").css("width", "400px");
                $("div[id*='AsyncFileUploadForFamily']").css("margin-top", "-34px");
                $("input[id*='AsyncFileUploadForFamily']").val("");
                $("input[id*='AsyncFileUploadForFamily']").css("background-color", "");
                $("input[id$='hdnPictureIdForFamily']").val("");
                $("img[id$='imgDisplayForFamily']").hide();
                $("#divdummyClassForFamily").addClass("dummy");
                $("#tblFamilyMember input[type=text]").val("");
                $("#tblFamilyMember select").val("");

                $("[id$='txtIdFM']").val("");
            }


            //------------------------------------------------Inactive Family Member-----------------------------------------------------------

            function InactiveEmployeeFamilyRecord(EFID) {

                if (confirm("Are you sure you wish to Inactive this Record?")) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../RMS/RMSWebMethod.aspx/InactiveEmployeeFamilyRecord",
                        data: "{'EFID':'" + EFID + "'}",
                        success: onsuccessInactiveEmployeeFamilRecord
                    });

                    return false;
                }
                else
                    return false;
            }


            function onsuccessInactiveEmployeeFamilRecord(msg) {
                //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
                showSuccessMsg("User has been Inactivated Successfully!");
                getFamilyMembers('', $("[id$='hdnEID']").val(), 1);
                return false;
            }


            //---------------------------------------------Activate Visitor Record------------------------------------------
            function ActivateEmployeeFamilyMember(EFID) {

                if (confirm("Are you sure you wish to Activate this User?")) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../RMS/RMSWebMethod.aspx/ActivateEmployeeFamilyRecord",
                        data: "{'EFID':'" + EFID + "'}",
                        success: onsuccessActivateEmployeeFamilyMember
                    });

                    return false;
                }
                else
                    return false;
            }


            function onsuccessActivateEmployeeFamilyMember(msg) {
                //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
                showSuccessMsg("User has been Activated Successfully!");
                getFamilyMembers('', $("[id$='hdnEID']").val(), 1);
                return false;
            }

            //----------------------------------------Black List Visistor---------------------------------------------------------------------------------------

            function BlackListEmployeeFamilyMember(EFID) {
                if (confirm("Are you sure you wish to Black List this User?")) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../RMS/RMSWebMethod.aspx/BlackListEmployeeFamilyRecord",
                        data: "{'EFID':'" + EFID + "'}",
                        success: onsuccessBlackListEmployeeFamilyMember
                    });

                    return false;
                }
                else
                    return false;
            }


            function onsuccessBlackListEmployeeFamilyMember(msg) {
                //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
                showSuccessMsg("User has been Black Listed Successfully!");
                getFamilyMembers('', $("[id$='hdnEID']").val(), 1);
                return false;
            }


            //---------------------------------------------------------------End-----------------------------------------------------------------------

            //function editFamilyMember(eid,efid, status) {
            //    window.location = "../RMS/AddResident.aspx?EID=" + eid + "&&EFID=" + efid + "&&Status=" + status + "&&E=F";
            //}



            //-----------------------------------------------Get Rankas on the basis of change the category dropdown list-------------------------------------------------------------
            var rankIds = '';
            function getRanks(rankId) {
                //$("select[id$='ddlRank']").html("");
                //$("select[id$='ddlRank']").text("");
                rankIds = rankId;
                var catVal = $("select[id$='ddlCategory']").val();

                if (catVal.trim() != "") {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../RMS/RMSWebMethod.aspx/getRanks",
                        data: "{'catVal':'" + catVal + "'}",
                        success: onsuccessGetRanks
                    });
                }
            }

            function onsuccessGetRanks(msg) {

                var data = msg.d;
                var catop = "";
                catop += "<option value=''>--Select--</option>";
                for (var i = 0; i < data.RanksDetail.length; i++) {
                    //   catop += "<option value=''>--Select--</option>";
                    catop += "<option value='" + data.RanksDetail[i].Rank_ID + "'>" + data.RanksDetail[i].Rank_Name + "</option>";
                }
                if (rankIds != '') {

                    $("select[id$='ddlRank']").append(catop);
                    $("select[id$='ddlRank']").val(rankIds);

                }

                else
                    $("select[id$='ddlRank']").append(catop);

                //  $("select[id$='ddlRank'] option:first").before("<option>hi</option>");

                getDesignation();


            }

            function getDesignation() {

                var catVal = $("select[id$='ddlCategory']").val();

                if (catVal == '1' || catVal == '2') {
                    catVal = '1,2';
                }
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../RMS/RMSWebMethod.aspx/getDesignation",
                    data: "{'catVal':'" + catVal + "'}",
                    success: onsuccessGetDesignation
                });
            }

            function onsuccessGetDesignation(msg) {

                $("select[id$='ddlDesignation']").html("");
                $("select[id$='ddlDesignation']").text("")
                var data = msg.d;
                var catop = "";
                catop += "<option value=''>--Select--</option>";
                for (var i = 0; i < data.DesignationDetail.length; i++) {
                    catop += "<option value='" + data.DesignationDetail[i].Designation_ID + "'>" + data.DesignationDetail[i].designation + "</option>";
                }
                $("select[id$='ddlDesignation']").append(catop);
            }

            //////Edit by As
           function  BackResidenet(){
               getResidents();
            }

            function BackFamilyMember() {
                getResidents();
            }

            function BackServant() {
                getResidents();
            }
            function BackGuest() {

                $("#fieldsetGuest").hide();
                getResidents();
            }

//////////////////////////////Employee WebCam///////////////

            var width = 320; // We will scale the photo width to this
            var height = 0; // This will be computed based on the input stream
            var streaming = false;
            var video = null;
            var canvas = null;
            var photo = null;
            var startbuttonEmp = null;
            var startbuttonFM = null;
            var startbuttonSR = null;
            var startbuttonGU = null;


            function startupEmp() {
                $("#imgDisplay").hide();
                $("#startbuttonEmp").show();
                $("#WebCamCallEmps").hide();

                $("#videoEmp").show();
                video = document.getElementById('videoEmp');
                canvas = document.getElementById('canvasEmp');
                photo = document.getElementById('photoEmp');
                startbuttonEmp = document.getElementById('startbuttonEmp');

                navigator.mediaDevices.getUserMedia({
                    video: true,
                    audio: false
                })
                    .then(function (stream) {
                        video.srcObject = stream;
                        video.play();
                    })
                    .catch(function (err) {
                        console.log("An error occurred: " + err);
                    });

                video.addEventListener('canplay', function (ev) {
                    if (!streaming) {
                        height = video.videoHeight / (video.videoWidth / width);

                        if (isNaN(height)) {
                            height = width / (4 / 3);
                        }

                        video.setAttribute('width', width);
                        video.setAttribute('height', height);
                        canvas.setAttribute('width', width);
                        canvas.setAttribute('height', height);
                        streaming = true;
                    }
                }, false);

                startbuttonEmp.addEventListener('click', function (ev) {
                    takepictureEmp();
                    ev.preventDefault();
                }, false);

                clearphotoEmp();
            }


            function clearphotoEmp() {
                var context = canvas.getContext('2d');
                context.fillStyle = "#AAA";
                context.fillRect(0, 0, canvas.width, canvas.height);

                var data = canvas.toDataURL('image/png');
                photo.setAttribute('src', data);
            }

            function takepictureEmp() {
                $("#startbuttonEmp").hide();
                $("#Recaptures").show();
                $("#photoEmp").show();
                $("#videoEmp").hide();
                var context = canvas.getContext('2d');
                if (width && height) {
                    canvas.width = width;
                    canvas.height = height;
                    context.drawImage(video, 0, 0, width, height);

                    var data = canvas.toDataURL('image/png');
                    photo.setAttribute('src', data);
                } else {
                    clearphotoEmp();
                }
            }

            function WebCamCallEmp() {
                startupEmp();
            }

            function Recapture() {
                $("#imgDisplay").hide();
                $("#photoEmp").hide();
                
                $("#startbuttonEmp").show();
                $("#Recaptures").hide();
                $("#WebCamCallEmp").hide();

                $("#videoEmp").show();
            }
           ///////////////////////// ////////////////////////End Family Web Cam//////
            
            //////////////////////////////////////////////////////////////

            function startupFMs() {
                $("#imgDisplay").hide();
                $("#startbuttonFM").show();
                $("#WebCamCallFM").hide();

                $("#videoEmp").show();
                video = document.getElementById('videoFM');
                canvas = document.getElementById('canvasFM');
                photo = document.getElementById('photoFM');
                startbuttonFM = document.getElementById('startbuttonFM');

                navigator.mediaDevices.getUserMedia({
                    video: true,
                    audio: false
                })
                    .then(function (stream) {
                        video.srcObject = stream;
                        video.play();
                    })
                    .catch(function (err) {
                        console.log("An error occurred: " + err);
                    });

                video.addEventListener('canplay', function (ev) {
                    if (!streaming) {
                        height = video.videoHeight / (video.videoWidth / width);

                        if (isNaN(height)) {
                            height = width / (4 / 3);
                        }

                        video.setAttribute('width', width);
                        video.setAttribute('height', height);
                        canvas.setAttribute('width', width);
                        canvas.setAttribute('height', height);
                        streaming = true;
                    }
                }, false);

                startbuttonFM.addEventListener('click', function (ev) {
                    takepictureFMs();
                    ev.preventDefault();
                }, false);

                clearphotoFMs();
            }


            function clearphotoFMs() {
                var context = canvas.getContext('2d');
                context.fillStyle = "#AAA";
                context.fillRect(0, 0, canvas.width, canvas.height);

                var data = canvas.toDataURL('image/png');
                photo.setAttribute('src', data);
            }

            function takepictureFMs() {
                $("#startbuttonFM").hide();
                $("#RecaptureFM").show();
                $("#photoFM").show();
                $("#videoFM").hide();
                var context = canvas.getContext('2d');
                if (width && height) {
                    canvas.width = width;
                    canvas.height = height;
                    context.drawImage(video, 0, 0, width, height);

                    var data = canvas.toDataURL('image/png');
                    photo.setAttribute('src', data);
                } else {
                    clearphotoFMs();
                }
            }

            function WebCamCallFMs() {
                $("#videoFM").show();
                $("#imgDisplayForFamily").hide();
                startupFMs();

            }

            function RecaptureFMs() {
                $("#imgDisplayForFamily").hide();
                $("#photoFM").hide();

                $("#startbuttonFM").show();
                $("#RecaptureFM").hide();
                $("#WebCamCallFM").hide();

                $("#videoFM").show();
            }

            ///////////////////////////////////////Servant Web Cam///////////
            /////////////////////////////////////////////////////////////////

            function startupSRs() {
                $("#imgDisplayForServant").hide();
                $("#startbuttonSR").show();
                $("#WebCamCallSR").hide();

                $("#videoSR").show();
                video = document.getElementById('videoSR');
                canvas = document.getElementById('canvasSR');
                photo = document.getElementById('photoSR');
                startbuttonSR = document.getElementById('startbuttonSR');

                navigator.mediaDevices.getUserMedia({
                    video: true,
                    audio: false
                })
                    .then(function (stream) {
                        video.srcObject = stream;
                        video.play();
                    })
                    .catch(function (err) {
                        console.log("An error occurred: " + err);
                    });

                video.addEventListener('canplay', function (ev) {
                    if (!streaming) {
                        height = video.videoHeight / (video.videoWidth / width);

                        if (isNaN(height)) {
                            height = width / (4 / 3);
                        }

                        video.setAttribute('width', width);
                        video.setAttribute('height', height);
                        canvas.setAttribute('width', width);
                        canvas.setAttribute('height', height);
                        streaming = true;
                    }
                }, false);

                startbuttonSR.addEventListener('click', function (ev) {
                    takepictureSRs();
                    ev.preventDefault();
                }, false);

                clearphotoSRs();
            }


            function clearphotoSRs() {
                var context = canvas.getContext('2d');
                context.fillStyle = "#AAA";
                context.fillRect(0, 0, canvas.width, canvas.height);

                var data = canvas.toDataURL('image/png');
                photo.setAttribute('src', data);
            }

            function takepictureSRs() {
                $("#startbuttonSR").hide();
                $("#RecaptureSR").show();
                $("#photoSR").show();
                $("#videoSR").hide();
                var context = canvas.getContext('2d');
                if (width && height) {
                    canvas.width = width;
                    canvas.height = height;
                    context.drawImage(video, 0, 0, width, height);

                    var data = canvas.toDataURL('image/png');
                    photo.setAttribute('src', data);
                } else {
                    clearphotoSRs();
                }
            }

            function WebCamCallSRs() {
                $("#imgDisplayForServant").hide();
                $("#videoSR").show();
                startupSRs();
                
            }

            function RecaptureSRs() {
                $("#imgDisplayForFamily").hide();
                $("#photoSR").hide();

                $("#startbuttonSR").show();
                $("#RecaptureSR").hide();
                $("#WebCamCallSR").hide();

                $("#videoSR").show();
            }

/////////////////////////////////////Guest Web Cam///////////////////////////
            ///////////////////////////////////////////////////////
            function startupGUs() {
                $("#imgDisplayForServantFamily").hide();
                $("#startbuttonGU").show();
                $("#WebCamCallGU").hide();

                $("#videoGU").show();
                video = document.getElementById('videoGU');
                canvas = document.getElementById('canvasGU');
                photo = document.getElementById('photoGU');
                startbuttonGU = document.getElementById('startbuttonGU');

                navigator.mediaDevices.getUserMedia({
                    video: true,
                    audio: false
                })
                    .then(function (stream) {
                        video.srcObject = stream;
                        video.play();
                    })
                    .catch(function (err) {
                        console.log("An error occurred: " + err);
                    });

                video.addEventListener('canplay', function (ev) {
                    if (!streaming) {
                        height = video.videoHeight / (video.videoWidth / width);

                        if (isNaN(height)) {
                            height = width / (4 / 3);
                        }

                        video.setAttribute('width', width);
                        video.setAttribute('height', height);
                        canvas.setAttribute('width', width);
                        canvas.setAttribute('height', height);
                        streaming = true;
                    }
                }, false);

                startbuttonGU.addEventListener('click', function (ev) {
                    takepictureGUs();
                    ev.preventDefault();
                }, false);

                clearphotoGUs();
            }


            function clearphotoGUs() {
                var context = canvas.getContext('2d');
                context.fillStyle = "#AAA";
                context.fillRect(0, 0, canvas.width, canvas.height);

                var data = canvas.toDataURL('image/png');
                photo.setAttribute('src', data);
            }

            function takepictureGUs() {
                $("#startbuttonGU").hide();
                $("#RecaptureGU").show();
                $("#photoGU").show();
                $("#videoGU").hide();
                var context = canvas.getContext('2d');
                if (width && height) {
                    canvas.width = width;
                    canvas.height = height;
                    context.drawImage(video, 0, 0, width, height);

                    var data = canvas.toDataURL('image/png');
                    photo.setAttribute('src', data);
                } else {
                    clearphotoGUs();
                }
            }

            function WebCamCallGUs() {
                startupGUs();
            }

            function RecaptureGUs() {
                $("#imgDisplayForServantFamily").hide();
                $("#photoGU").hide();

                $("#startbuttonGU").show();
                $("#RecaptureGU").hide();
                $("#WebCamCallGU").hide();

                $("#videoGU").show();
            }


            ///////////////////////Age Calculate


            $("#txtGuestDoB").change(function () {
                var dateString = ($("#txtGuestDoB").val());
                console.log(dateString);
                var today = new Date();
                var birthDate = new Date(dateString);
                var age = today.getFullYear() - birthDate.getFullYear();
                var m = today.getMonth() - birthDate.getMonth();
                if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
                    age--;
                }
                console.log("Age=" + age);

                
                $('#<%=txtGuestAge.ClientID%>').val(age);

                return age;


            });

                //------------------------------------------------------------------------End-----------------------------------------------------------------------------------
        </script>
            </div>
            </div>
    </asp:Content>