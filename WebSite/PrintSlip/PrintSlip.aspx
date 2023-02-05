<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="PrintSlip.aspx.cs" Inherits="PrintSlip_PrintSlip" %>

<asp:Content ID="Content3" ContentPlaceHolderID="head" runat="Server">
        <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <%--<link href="../Bootstrap-4/bootstrap.min.css" rel="stylesheet" />--%>
  <%--  <link href="jquery-ui.min.css" rel="stylesheet" />--%>
    <%--<link href="../TimePicker/jquery.timepicker.min.css" rel="stylesheet" />--%>
  <%--  <link href="../TimePicker/clockpicker.css" rel="stylesheet" />--%>


    <%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
        TagPrefix="rjs" %>

    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

    <style>
     
nav ul {
	list-style: none;
	margin: 0;
	padding: 0;
   
}
nav ul li {
   font-size:13px;
}
nav ul li a {
	display: block;
	padding: 10px 15px;
	color: #fff;
	text-decoration: none;
	-webkit-transition: 0.2s linear;
	-moz-transition: 0.2s linear;
	-o-transition: 0.2s linear;
	transition: 0.2s linear;
    
}
nav ul li a:hover {
	background: #1d4f71;
	color: #fff;
     text-decoration: none;
}
nav ul li a .fa {
	width: 16px;
	text-align: center;
	margin-right: 5px;
	float:right;
}
nav ul ul {
	background: rgba(0, 0, 0, 0.2);
}
nav ul li ul li a {
	
	border-left: 4px solid transparent;
	padding: 10px 20px;
}
nav ul li ul li a:hover {

	border-left: 4px solid #3498db;
}
    </style>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="col-lg-1 col-md-1">

           
           <nav style="background-color:#25244f">
	<ul>
      
		<%--<li><a href='../Report_Guest/ExpiredDateVisitor.aspx'>Expired Guest List</a></li>
		<li><a href='../Report_Constractor/ExpairContractor.aspx'>Expired Contractor List</a></li>
       
		<li><a href='../ReportsLabor/ExpairLaborReports.aspx'>Expired Labor List</a></li>--%>
        <li><a href='../RMS/Residents.aspx'>Add Guest</a></li>
		<li><a href='../RMS/Contractor_Information.aspx'>Add Contractor</a></li>
		
		<li><a href='../RMS/Contractor_Labor.aspx'>Add Labor</a></li>
       
	</ul>
</nav> 
               

        </div>

      <div class="col-lg-7 col-md-7">
    <fieldset id="empfieldset">
        <legend style="width:auto">Employee Search Criteria</legend>
        <table  class="table" style="width: 100%">
            <tr>
                <td style="width:12%">Card/CNIC/P No:</td>
                <td>
                    <asp:TextBox  class="form-control" ID="txtEmpCNIC" Style="width: 70%" runat="server" ClientIDMode="Static"></asp:TextBox>
                   
                    </td> 
                 <td style="width:12%">Employee Name</td>
                <td>
                    <asp:TextBox Style="width: 100%"  class="form-control" ID="txtEmpName" runat="server" ClientIDMode="Static"></asp:TextBox>
                </td>
                 <td>
                    <input class="btn btn-primary" type="button" id="btnsearchemployee" value="Search" />
                </td>
                <td  style="width:12%; display:none">Department/Unit:</td>
                <td> <asp:DropDownList Style="width: 100%;  display:none" class="form-control" ID="ddlDepartmentSearch" runat="server"  ClientIDMode="Static"></asp:DropDownList>
              </td>

                
             </tr>
            <tr>

                 <td style="width:12px; display:none">Designation:</td>
                <td> <asp:DropDownList Style="width: 70%; display:none" class="form-control" ID="ddDesignation" runat="server"  ClientIDMode="Static"></asp:DropDownList>
              </td>
           
            </tr>        
        </table>
    </fieldset>


    <fieldset>
        <legend style="width:auto">Guest Search Criteria</legend>
        <table class="form" style="width: 100%">
            <tr>
                <td style="width:10%" >Visitor Type:</td>
                <td>
                    <asp:DropDownList Style="width: 90%" class="form-control" ID="ddtype" runat="server" ClientIDMode="Static"></asp:DropDownList>
               </td>
                <td style="width:10%" >Enter CNIC:</td>
                <td>
                    <asp:TextBox class="form-control" ID="txtcnic" runat="server" ClientIDMode="Static"></asp:TextBox>
             
                </td>
               
            </tr>
            <tr>
                <td style="display:none">Validity Hours</td>
                <td style="display:none">                
                    <asp:DropDownList  ClientIDMode="Static" class="form-control" Style="width: 90%" ID="ddhours" runat="server"></asp:DropDownList> 
                   
               </td>
                  <td style="display:none">Validity Minutes</td>
                 <td style="display:none"><asp:DropDownList ClientIDMode="Static" class="form-control" Style="width: 90%" ID="ddmunits" runat="server"></asp:DropDownList></td> 

                

            </tr>
            <tr>
                 <td style="width:15%; display:none"" >Raletion Type:</td>
                <td style="width: 90%; display:none">
                    <asp:DropDownList Style="width: 90%; display:none" class="form-control" ID="txtrelation" runat="server" ClientIDMode="Static"></asp:DropDownList>
                </td>
                 <td style="width:15%" >Purpose of visit:</td>
                <td>
                    <asp:TextBox  class="form-control" ID="txtpurpose" ClientIDMode="Static" runat="server"></asp:TextBox>
                </td>
                 <td style="width:12%" >Validity Date:</td>
                <td>
                    <asp:TextBox ID="ToDateFrom" CssClass="date req textboxSize" ClientIDMode="Static" runat="server" Style="width: 90%; float: left; margin-right: 5px;"></asp:TextBox>
                </td>
                <td>
                    <rjs:PopCalendar ID="Popcalendar2" Separator="/" Format="mm dd yyyy" Control="ToDateFrom" runat="server"
                        Font-Names="Tahoma" />
                </td>
               


               
              

            </tr>
            <tr>
                 
                
                  <td style="width:10%">Veh No:</td>
                <td>
                    <asp:TextBox class="form-control" ID="txtvehicalno" ClientIDMode="Static" runat="server"></asp:TextBox>

                </td>
                 <td>
                    
                </td>
                <td>
                    <input class="btn btn-primary" type="button" id="btnSearch" value="Search" />
                </td>

            </tr>
            <br />
            <tr>
                <td></td>
                 <td></td>
                 <td></td>
                <td></td>
                
            </tr>
        </table>
    </fieldset>
          <table >

          </table>

    <div class="row">
        <div class="col-lg-5 col-md-5">
        <div id="printemp" style="float: left;width: auto">
        
        <fieldset id="feildsetemp">
            <legend style="width:auto">Employee Detail</legend>
       

        <table id="employeedetail" class="table">
            <tr>
                <td>Name</td>
                <td colspan="3" id="empname"></td>
            </tr>
             <tr>
                <td>Department</td>
                <td id ="empdep"></td>
            </tr>
             <tr>
                <td>Designation</td>
                <td id="empdesg"></td>
            </tr>
             <tr>
                <td>Address</td>
                <td id="empadd"></td>
            </tr>

        </table>
             </fieldset>
    </div>
            </div>

         <div class="col-lg-7 col-md-7">
        <fieldset id="fieldsetguest">
        <legend  style="width:auto">Visitor Detail
        </legend>
        <div id="printarea" style="float: left; width: auto">
            <table id="sliptable">
                <tr>
                    <td id="type" colspan="3" style="text-align: center"></td>
                </tr>
                <tr>
                    <td>Date:</td>
                    <td id="todaydate"></td>
                    <td>Time:</td>
                    <td id="currenttime"></td>
                </tr>

                <tr>

                    <td>Name:</td>
                    <td colspan="2" id="name"></td>
                    <td></td>
                    <td rowspan="4">
    
                        <img id="image" alt="No Image" style="width: 150px; height: 150px;"/>
                    </td>


                </tr>

                <tr>
                    <td>CNIC:</td>
                    <td id="cnic"></td>
                    <td>Veh No:</td>
                    <td colspan="1" id="vehno"></td>
                </tr>
               
                <tr>
                    <td>Guest Address:</td>
                    <td id="Address"></td>
                    <td></td>
                    <td></td>

                </tr>
                <tr>
                    <td colspan="2">Relationship:</td>
                    <td id="RalationShip"></td>
                </tr>
                <tr>
                    <td colspan="2">Purpose of visit</td>
                    <td id="Purpose"></td>
                </tr>
                <tr>
                    <td>Validaity Date:</td>
                    <td id="Validaity"></td>
                </tr>
            </table>
        </div>
        <div>
        </div>
         </fieldset>
                </div>

      
        </div>
    

       
      
</div>

    
<div class="col-lg-4 col-md-4">
    <div class="row">
        <div class="col-lg-12 col-md-12">
       <fieldset>
           <legend style="width:auto">Active Visitor</legend>
             <table id="uvisTable" style="width:90%">  
                                <thead id="" class="thead-dark">  
                                    <tr>  
                                         <th>Slip No</th>  
                                        <th>Guest Name</th>  
                                        <th>CNIC</th>  
                                        <th>Host PNo</th>
                                        <th>Action</th>

                                    </tr>  
                                </thead>  
                                <tbody id="tBody" class="table-striped text-nowrap"> </tbody> 
                        </table>    
       </fieldset>
            </div>
</div>
    <div class="row">
        <div class="col-lg-12 col-md-12">
            <table>
                <tr>
                     <td>Total Active Visitor</td>
                     <td> <asp:Label EnableViewState="true" ClientIDMode="Static" CssClass="form-control" ID="lblactiveVisitor" runat="server" Text="" BackColor="#339933"></asp:Label> </td>
                    <td><asp:Button class="btn btn-success" ID="Button1" runat="server" Text="Search Active's Visitor" /></td>
                    
                     </tr>
                <tr>
                     <td>Visitors Entry Expired </td>
                     <td>
                         <asp:Label EnableViewState="true" ClientIDMode="Static" CssClass="form-control" ID="lblexpiredVisitor" runat="server" Text="" BackColor="#FF3300"></asp:Label> </td>
              <td><a class="btn btn-success" href="../Report_Guest/ExpiredDateVisitor.aspx">Search Expired Visitor</a></td>
                </tr>
            </table>

        </div>

    </div>
    <div class="row">
        <div class="col-lg-12 col-md-12">
 

            <div class="camera">
            <video id="videoBC" style ="height:150px;width:150px;">Video stream not available.</video>
        </div>
       
        <canvas id="canvasBC" style="display:none"></canvas>
       <%-- <div class="output">
            <img id="photoBC" alt="The screen capture will appear in this box." style ="height:130px;width:150px;">
        </div>--%>
        <div>
             <div>
                 <input type="button" class="btn btn-primary" id="startbuttonBC" value="Capture" />
                  <input type="button" class="btn btn-primary" id="RecaptureBC" onclick="RecaptureBCs();" value="ReCapture" />
                  
             </div>
            <input type="button" class="btn btn-primary" value="WebCam" id="WebCamCallBC" onclick="WebCamCallBCs();"/>
        </div>

        </div>

    </div>
    <br />
     <div class="row">    
        
            <div class="col-lg-4 col-md-4">
               <input class="btn btn-primary" type="button" id="Prints" value="Print"/>
           </div>
        </div>
    </div>
</div>
 

   <%--  <script src="../js/jquery-1.11.2.js"></script>
 
    <script src="../TimePicker/clockpicker.js"></script>
    <script src="jquery-ui.min.js"></script>--%>
  <script src="../js/bootstrap.min.js"></script>
  <%--  <script src="../Bootstrap-4/bootstrap.min.js"></script>--%>
    <script src="PrintSlip.js"></script>
  
</asp:Content>

