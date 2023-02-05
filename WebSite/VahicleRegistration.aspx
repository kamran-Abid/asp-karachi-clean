<%@ Page Title="" Language="C#" MasterPageFile="~/PVACSMaster.master" AutoEventWireup="true" CodeFile="VahicleRegistration.aspx.cs" Inherits="VahicleRegistration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
       <style>
        td {
    padding-top: .3em;
    padding-bottom: .3em;

}

select {
    height:22px;

}
    </style>
    
    <link href="css/dataTable.css" rel="stylesheet" />
    <table style="width:100%;margin-top:0%;">
        <tr>
                <td>
                    <div class="sussessMessageDiv" id="divSuccessMsg" style="display: none">
                    </div>
                     <div class="ErrorMessageDiv" id="ErrorMessageDiv" style="display: none">
                    </div>
                </td>
            </tr>
        <tr>
            <td>
               <fieldset style="margin-top:-3%;" >
                   <legend>Add/Modified Members</legend>
               
                    <table  style="font-family: Calibri; font-size: 11pt;width:100%;" >
                    <tr>
                        <td style="width:140px;text-align:left;">
                            <asp:Label ID="lblMNamemberName" Text="Name:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 400px;">
                            <asp:TextBox ID="txtPlaceName" Width="60%"  runat="server" BackColor="White" ></asp:TextBox>
                        </td>
                         <td style="width:140px;text-align:left;">
                            <asp:Label ID="Label1" Text="Type:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 400px;">
                           <asp:DropDownList  Width="50.6%" ID="ddlType" runat="server">
                               <asp:ListItem Value="0">-- Select --</asp:ListItem>
                               <asp:ListItem Value="1">Resident</asp:ListItem>
                               <asp:ListItem Value="2">Non Resident</asp:ListItem>
                           </asp:DropDownList>
                        </td>
                        <td rowspan="3">
                            <asp:Image ID="img_Member" runat="server" Height="96px" Width="104px" BorderColor="#003366"
                                                        BorderStyle="Dotted" AlternateText="No Image" ImageUrl="~/images/noImageAvailable.png" />
                           <label style="text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Member</label> 
                        </td>
                       </tr>

                        <tr>
                        <td style="width:140px;text-align:left;">
                            <asp:Label ID="Label2" Text="CNIC No:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 400px;">
                            <asp:TextBox ID="txtCNICNo" Width="60%"  runat="server" BackColor="White" ></asp:TextBox>
                        </td>
                         <td style="width:140px;text-align:left;">
                            <asp:Label ID="Label3" Text="Rank/Occupation:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 400px;">
                           <asp:DropDownList  Width="50.6%" ID="ddlRank" runat="server">
                              
                           </asp:DropDownList>
                        </td>
                        
                       </tr>

                         <tr>
                        <td style="width:140px;text-align:left;">
                            <asp:Label ID="Label4" Text="Service No:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 400px;">
                            <asp:TextBox ID="txtServiceNo" Width="60%"  runat="server" BackColor="White" ></asp:TextBox>
                        </td>
                         <td style="width:140px;text-align:left;">
                            <asp:Label ID="Label5" Text="Photo:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 400px;">
                          <asp:FileUpload ID="FileUpload_image" runat="server" Height="22px" />
                                                    <asp:Button ID="btn_upload" runat="server" Height="22px" OnClick="btn_upload_Click"
                                                        Text="Upload" Width="64px" />
                                                    <asp:Button ID="btn_remove" style="display:none;" runat="server" Height="22px" OnClick="btn_remove_Click"
                                                        Text="Remove" />
                        </td>
                        
                       </tr>



                         <tr>
                        <td style="width:140px;text-align:left;">
                            <asp:Label ID="Label6" Text="Official Address:" runat="server"></asp:Label>
                        </td>
                        <td colspan="3">
                            <asp:TextBox ID="txtOfficialAddress" Width="68.5%"  runat="server" BackColor="White" ></asp:TextBox>
                        </td>
                         <td rowspan="3">
                            <asp:Image ID="img_driver1" runat="server" Height="70px" Width="104px" BorderColor="#003366"
                                                        BorderStyle="Dotted" AlternateText="No Image" ImageUrl="~/images/noImageAvailable.png" />
                           <label style="text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Driver 1</label> 
                        </td>
                       </tr>

                        <tr>
                        <td style="width:140px;text-align:left;">
                            <asp:Label ID="Label7" Text="Home Address:" runat="server"></asp:Label>
                        </td>
                        <td colspan="4">
                            <asp:TextBox ID="txtHomeAddress" Width="68.5%"  runat="server" BackColor="White" ></asp:TextBox>
                        <br />
                        <br/></td>
                        
                       </tr>
                        


                         <tr>
                        <td style="width:140px;text-align:left;">
                            <asp:Label ID="Label8" Text="Vehicle No:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 400px;">
                            <asp:TextBox ID="txtVehicleNo" Width="60%"  runat="server" BackColor="White" ></asp:TextBox>
                        </td>
                         <td style="width:140px;text-align:left;">
                            <asp:Label ID="Label9" Text="Make:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 400px;">
                           <asp:TextBox ID="txtMake" Width="50%"  runat="server" BackColor="White" ></asp:TextBox>
                        </td>
                        
                       </tr>

                        <tr>
                        <td style="width:140px;text-align:left;">
                            <asp:Label ID="Label10" Text="Model:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 400px;">
                            <asp:TextBox ID="txtModel" Width="60%"  runat="server" BackColor="White" ></asp:TextBox>
                        </td>
                         <td style="width:140px;text-align:left;">
                            <asp:Label ID="Label11" Text="Color:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 400px;">
                           <asp:TextBox ID="txtColor" Width="50%"  runat="server" BackColor="White" ></asp:TextBox>
                        </td>
                        <td rowspan="3">
                            <asp:Image ID="img_driver2" runat="server" Height="70px" Width="104px" BorderColor="#003366"
                                                        BorderStyle="Dotted" AlternateText="No Image" ImageUrl="~/images/noImageAvailable.png" />
                           <label style="text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Driver 2</label> 
                        </td>
                       </tr>

                         <tr>
                        <td style="width:140px;text-align:left;">
                            <asp:Label ID="Label12" Text="Engine No:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 400px;">
                            <asp:TextBox ID="TextBox1" Width="60%"  runat="server" BackColor="White" ></asp:TextBox>
                        </td>
                         <td style="width:140px;text-align:left;">
                            <asp:Label ID="Label13" Text="Chassis No:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 400px;">
                           <asp:TextBox ID="TextBox2" Width="50%"  runat="server" BackColor="White" ></asp:TextBox>
                        </td>
                        
                       </tr>

                       
                       <tr>
                        <td style="width:140px;text-align:left;">
                            <asp:Label ID="Label14" Text="Authorized Drive 1:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 400px;">
                            <asp:TextBox ID="txtAuthorizedDriver1" Width="60%"  runat="server" BackColor="White" ></asp:TextBox>
                        </td>
                         <td style="width:140px;text-align:left;">
                            <asp:Label ID="Label15" Text="Driver 1 CNIC No:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 400px;">
                           <asp:TextBox ID="txtDrv1CNIC" Width="31%"  runat="server" BackColor="White" ></asp:TextBox>
                            <asp:FileUpload ID="FileUploadDriver1" Width="35%" runat="server" Height="22px" />
                                                    &nbsp;<asp:Button ID="btnUploadPictureDriver1" runat="server" Height="22px" 
                                                        Text="Upload" Width="64px" OnClick="btnUploadPictureDriver1_Click" />
                        </td>
                       
                       </tr>

                          <tr>
                        <td style="width:140px;text-align:left;">
                            <asp:Label ID="Label16" Text="Authorized Drive 2:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 400px;">
                            <asp:TextBox ID="txtAuthorizedDriver2" Width="60%"  runat="server" BackColor="White" ></asp:TextBox>
                        </td>
                         <td style="width:140px;text-align:left;">
                            <asp:Label ID="Label17" Text="Driver 2 CNIC No:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 400px;">
                           <asp:TextBox ID="txtDrv2CNIC" Width="31%"  runat="server" BackColor="White" ></asp:TextBox>
                            <asp:FileUpload ID="FileUploadDriver2" Width="35%" runat="server" Height="22px" />
                                                    &nbsp;<asp:Button ID="btnUploadPictureDriver2" runat="server" Height="22px" 
                                                        Text="Upload" Width="64px" OnClick="btnUploadPictureDriver2_Click" />
                        </td>
                         <td rowspan="3">
                            <asp:Image ID="img_driver3" runat="server" Height="70px" Width="104px" BorderColor="#003366"
                                                        BorderStyle="Dotted" AlternateText="No Image" ImageUrl="~/images/noImageAvailable.png" />
                           <label style="text-align:center;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Driver 3</label> 
                        </td>
                       </tr>
                          <tr>
                        <td style="width:140px;text-align:left;">
                            <asp:Label ID="Label18" Text="Authorized Drive 3:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 400px;">
                            <asp:TextBox ID="txtAuthorizedDriver3" Width="60%"  runat="server" BackColor="White" ></asp:TextBox>
                        </td>
                         <td style="width:140px;text-align:left;">
                            <asp:Label ID="Label19" Text="Driver 3 CNIC No:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 400px;">
                           <asp:TextBox ID="txtDrv3CNIC" Width="31%"  runat="server" BackColor="White" ></asp:TextBox>
                            <asp:FileUpload ID="FileUploadDriver3" Width="35%" runat="server" Height="22px" />
                                                    &nbsp;<asp:Button ID="btnUploadPictureDriver3" runat="server" Height="22px" 
                                                        Text="Upload" Width="64px" OnClick="btnUploadPictureDriver3_Click" />
                        </td>
                        
                       </tr>

                        <tr>
                        <td  align="left">
                            <asp:TextBox ID="txtID" Style="display: none;" runat="server"></asp:TextBox>
                        </td>
                        
                   
                        <td align="left">
                            <asp:Button ID="btnSave" Text="Add" Style="background-color: #273D5F; color: White;"
                                Width="75px" OnClientClick="return SavePlace();" runat="server" />
                        
                            <asp:Button ID="btnClearPlace" Text="Clear" Style="background-color: #273D5F; color: White;"
                                Width="75px" OnClientClick="return ClearPlace();" runat="server" />
                        
                            <asp:Button ID="btnUpdate" Text="Update" Style="background-color: #273D5F; color: White;
                                display: none;" Width="75px" OnClientClick="return UpdatePlace();" runat="server" />
                        </td>
                    </tr>
                </table>
                </fieldset>
            </td>
        </tr>

    </table>
</asp:Content>

