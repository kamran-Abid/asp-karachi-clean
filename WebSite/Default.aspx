<%@ Page Title="Welcome to NLC PACS" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Home" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .watermark {
            /*position: fixed;*/
            bottom: 610px;
            right: 1024px;
            opacity: 10;
            z-index: 99;
            color: white;
            padding-left: 120px; 
        }
        .auto-style1 {
            width: 300px;
            height: 135px;
            margin-left: 0px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div>
        <table>
            <tr>
                <td class="watermark">
                    &nbsp;<img src="images/logoNLC.png" class="auto-style1" /></td>
                <td>
                    <h1 style="color:#0026ff;margin-top: 20px; font-weight:bold;">&nbsp;&nbsp;&nbsp;Personnel Access Control System</h1>
                </td>
            </tr>
        </table>

        <table>
           <%-- <tr>
                <td style="padding-left: 300px; padding-top: 20px">
                    <img src="images/visitor-management-icon.png" style="width: 70px; height: 70px" />
                </td>
                <td style="padding-top: 8px;"><a href="#" style="color: #344B6C; text-decoration: none; cursor: pointer; padding-left: 20px; font-weight: 600">Visitor Management System</a></td>
            </tr>--%>
            
            
            
            <tr>
                <td style="padding-left: 175px; padding-top: 5px">
                    <a href="../RMS/Residents.aspx"><img src="images/Home2.png" style="width: 140px; height: 140px;" /></a></td>
                <td></td>
                <td><a href="../RMS/Residents.aspx"><b style="font-weight:bold; width:100px; height:100px; font-size:x-large;">Residence Management System</b></a></td>
                <td style="padding-left: 175px; padding-top: 30px">
                    <a href="../Visitor_Registration_Form.aspx"><img src="images/UserManagement2.png" style="width: 140px; height: 140px;" /></a>
                </td>
                 <td></td>
                <td><a href="../Visitor_Registration_Form.aspx"><b  style="font-weight:bold; width:100px; height:100px; font-size:x-large;">Visitor Management System</b></a></td>
                <%--</td>
                <td style="padding-top: 20px;"><a href="#" style="color: #344B6C; text-decoration: none; cursor: pointer; padding-left: 20px; font-weight: 600">Residence Management System</a></td>--%>
            </tr>
            <tr>
                <td style="padding-left: 175px; padding-top: 5px;">
                    <a href="../Setting Forms/AddPlaces.aspx"><img src="images/Settings2.png" style="width: 140px; height: 140px;" /></a>
                </td>
                 <td></td>
                <td><a href="../Setting Forms/AddPlaces.aspx"><b style="font-weight:bold; width:100px; height:100px; font-size:x-large; text-decoration:none;">   Setting Forms</b></a></td>
                <td style="padding-left: 175px; padding-top: 20px;">
                    <a href="../PACS_Report/VACS-REPORT.aspx"><img src="images/Reports2.png" style="width: 140px; height: 140px;" /></a>
                </td>
                 <td></td>
                <td><a href="../PACS_Report/VACS-REPORT.aspx"><b style="font-weight:bold; width:100px; height:100px; font-size:x-large;">            Reports</b></a></td>
            </tr>

            <%--<tr>
                /PACS_Report/VACS-REPORT.aspx
                <td style="padding-left: 300px; padding-top: 20px">
                    <img src="images/Reports.jfif" style="width: 100px; height: 100px" />
                </td>
                <td style="padding-top: 20px;"><a href="#" style="color: #344B6C; text-decoration: none; cursor: pointer; padding-left: 20px; font-weight: 600">Reports</a></td>
            </tr>
            <tr>
                <td style="padding-left: 300px; padding-top: 20px">
                    <img src="images/vacs.jpeg" style="width: 100px; height: 100px" />
                </td>
                <td style="padding-top: 20px;"><a href="#" style="color: #344B6C; text-decoration: none; cursor: pointer; padding-left: 20px; font-weight: 600">VACS Settings</a></td>
            </tr>
            <tr>
                <td style="padding-left: 300px; padding-top: 20px">
                    <img src="images/fingersearch.jpg" style="width: 100px; height: 100px" />
                </td>
                <td><a href="../Setting Forms/Fingers.aspx"></a>Finger Search</td>
            </tr>--%>
        </table>

    </div>
</asp:Content>

