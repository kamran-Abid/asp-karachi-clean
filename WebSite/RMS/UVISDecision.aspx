<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="UVISDecision.aspx.cs" Inherits="RMS_UVISDecision" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    
    <%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
        TagPrefix="rjs" %>

    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

    </asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <%-- <div class="container">--%>
    <div class="row">
       <div class="col-lg-6 col-md-6">
           <fieldset>
               <legend style="width:auto">UVSS Search Criteria</legend>
               <table>
                   <tr>       
                        <td style="width:12%" >Date From:</td>
                    <td>
                         <asp:TextBox ID="DateFrom" CssClass="date req textboxSize" ClientIDMode="Static" runat="server" Style="width: 90%; float: left; margin-right: 5px;"></asp:TextBox>
                    </td>
                     <td>
                    <rjs:PopCalendar ID="Popcalendar2" Separator="/" Format="mm dd yyyy" Control="DateFrom" runat="server"
                        Font-Names="Tahoma" />
                         </td>
                          <td style="width:12%" >Date To:</td>
                    <td>
                         <asp:TextBox ID="Dateto" CssClass="date req textboxSize" ClientIDMode="Static" runat="server" Style="width: 90%; float: left; margin-right: 5px;"></asp:TextBox>
                    </td>
                     <td>
                    <rjs:PopCalendar ID="Popcalendar1" Separator="/" Format="mm dd yyyy" Control="Dateto" runat="server"
                        Font-Names="Tahoma" />
                </td>
                       <td>
                       <input type="button" id="btnSearch" value="Search" class="btn btn-primary" />
                       </td>
                   </tr>
               </table>
           </fieldset>

       </div>

   </div>

    <div class="row">
        <div class="col-lg-12 col-md-12">
            <fieldset>
                   <legend style="width:auto">UVSS List</legend>
                    
                <div  style="overflow-x:auto;">
                   <table id="uvisTable" style="width:90%">  
                                <thead id="" class="thead-dark">  
                                    <tr>  
                                         
                                        <th>Log Date</th>  
                                        <th>Log Date Time</th>  
                                        <th>CameraIP</th>  
                                        <th>Sequence</th> 
                                        <th>Vehicle Number</th>
                                        <th>FOD</th>
                                        <th>PDI</th>
                                        <th>Previous</th>
                                         <th>Previous Path</th>
                                       <%-- <th>Handled</th>
                                        <th>Displayed</th>--%>
                                        <th>Location Name</th>
                                        <th>Action</th>
                                    </tr>  
                                </thead>  
                                <tbody id="tBody" class="table-striped text-nowrap"> </tbody> 
                        </table>             
                        </div>
                      </fieldset>
                  </div>
                 </div>




      <div class="row">
        <div class="col-lg-12 col-md-12">
            <fieldset>
                   <legend style="width:auto">UVSS Revised Decision List</legend>
                    
                <div  style="overflow-x:auto;">
                   <table id="uvisRemarkdTable" style="width:90%">  
                                <thead id="" class="thead-dark">  
                                    <tr>  
                                         
                                        <th>Log Date</th>  
                                        <th>Log Date Time</th>  
                                        <th>CameraIP</th>  
                                        <th>Sequence</th> 
                                        <th>Vehicle Number</th>
                                        <th>FOD</th>
                                        <th>PDI</th>
                                        <th>Previous</th>
                                         <th>Previous Path</th>
                                       <%-- <th>Handled</th>
                                        <th>Displayed</th>--%>
                                        <th>Location Name</th>
                                        <th>Revised Decision</th>
                                        <th>Revised Remarks</th>
                                    </tr>  
                                </thead>  
                                <tbody id="tBodyRemarks" class="table-striped text-nowrap"> </tbody> 
                        </table>             
                        </div>
                      </fieldset>
                  </div>
                 </div>

               <%-- Bootstrap-----------start----------- Model--%>
                        
                   <div id="myModal" class="modal fade" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">UVSS</h5>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body">
                    <table class="table">
                        <tr>
                            <td>Revised Decision</td>
                            <td>
                                <asp:DropDownList CssClass="form-control" ID="ddtype" ClientIDMode="Static" runat="server">
                     <asp:ListItem>Allowed</asp:ListItem>
                     <asp:ListItem>NotAllowed</asp:ListItem>
                   </asp:DropDownList>
                                </td>
                        </tr>
                        <tr>
                            <td>Revised Remarks </td>
                            <td>
                                <textarea id="TextArea1" cols="55" rows="2"></textarea>
                            </td>
                        </tr>
                    </table>


                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <button id="btnsave" type="button" class="btn btn-primary">Save</button>
                </div>
            </div>
        </div>
    </div>
                <%-- Bootstrap-----------END----------- Model--%>

<%--</div>--%>
    <script src="../js/bootstrap.min.js"></script>
   
   
   
   <script>
       var uvssid = "";
       $(document).ready(function () {
          
           GetUVISSList();
           GetUVISSRemarksList();

           //////////////save function///////////////////
           $("#btnsave").click(function () {

               var rremarks = ($("[id$='TextArea1']").val());
               if (rremarks == "") {
                   alert("Please Enter Revised Remarks");
                   ///showSuccessMsg("Please Enter Remarks!");
                   return false
               }

               let postData = {
                   'uvssid': uvssid,
                   'reviseddecision': $("#ddtype").val(),
                   'revisedremarks': $("#TextArea1").val()

               }
               
     
               $.ajax({
                   type: "POST",
                   url: "UVISDecision.aspx/UpdateUVSSLog",
                   data: JSON.stringify(postData),
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   success: function (data) {
                       $('#myModal').modal('hide');
                       $("#TextArea1").val("");
                       showSuccessMsg("UVSS Log Updated successfully");
                       GetUVISSList();
                       GetUVISSRemarksList();
                   },
                   failure: function (jqXHR, textStatus, errorThrown) {
                       alert("HTTP Status: " + jqXHR.status + "; Error Text: " + jqXHR.responseText); // Display error message  
                   }
               });

           });
           //////////////end save function///////////////////////


           /////////////////////////////////////// GetUVISSList///////////////
           function GetUVISSList() {

               if ($.fn.DataTable.isDataTable('#uvisTable')) {
                   $('#uvisTable').DataTable().destroy();
               }
               $('#uvisTable tbody').empty();


               $.ajax({
                   type: "POST",     
                   url: "UVISDecision.aspx/GetuvisList",
                   dataType: "json",
                   contentType: "application/json",
                   success: function (response) {
                       console.log(response.d);
                       $.each(response.d, function (index, value) {
                           var tr = "<tr>";
                           tr += "<td>" + value.Logdate + "</td>";
                           tr += "<td>" + value.logdatetime + "</td>";
                           tr += "<td>" + value.cameraip + "</td>";
                           tr += "<td>" + value.sequence + "</td>";
                           tr += "<td>" + value.vehiclenumber + "</td>";
                           tr += "<td>" + value.fod + "</td>";
                           tr += "<td>" + value.pdi + "</td>";
                           tr += "<td>" + value.previous + "</td>";
                           tr += "<td>" + value.previouspath + "</td>";
                           //tr += "<td>" + value.ishandled + "</td>";
                           //tr += "<td>" + value.isdisplayed + "</td>";
                           tr += "<td>" + value.locationname + "</td>";

                           tr += "<td>" + "<input class='btn btn-primary' type='button' id='" + value.uvssid + "' onclick='Bootstrapmodel(" + value.uvssid + ")' value='Update'>" + "</td>" + "</tr>";
                           $("#tBody").append(tr);
                       });
                       $("#uvisTable").DataTable({
                           deferRender: true,
                           scrollY: 200,
                           scrollCollapse: true,
                           scroller: true,
                           
                       });
                   }
               });
           }



       ///////////////////End UVISS List////////////////////

           ///////////Start UVISS List Remarks Decision/////
           function GetUVISSRemarksList() {

               if ($.fn.DataTable.isDataTable('#uvisRemarkdTable')) {
                   $('#uvisRemarkdTable').DataTable().destroy();
               }
               $('#uvisRemarkdTable tBodyRemarks').empty();

               $.ajax({
                   type: "POST",
                   url: "UVISDecision.aspx/GetuvisRemarksList",
                   dataType: "json",
                   contentType: "application/json",
                   success: function (response) {
                       console.log(response.d);
                       $.each(response.d, function (index, value) {
                           var tr = "<tr>";
                           tr += "<td>" + value.Logdate + "</td>";
                           tr += "<td>" + value.logdatetime + "</td>";
                           tr += "<td>" + value.cameraip + "</td>";
                           tr += "<td>" + value.sequence + "</td>";
                           tr += "<td>" + value.vehiclenumber + "</td>";
                           tr += "<td>" + value.fod + "</td>";
                           tr += "<td>" + value.pdi + "</td>";
                           tr += "<td>" + value.previous + "</td>";
                           tr += "<td>" + value.previouspath + "</td>";
                           //tr += "<td>" + value.ishandled + "</td>";
                           //tr += "<td>" + value.isdisplayed + "</td>";
                           tr += "<td>" + value.locationname + "</td>";
                           tr += "<td>" + value.reviseddecision + "</td>";
                           tr += "<td>" + value.revisedremarks + "</td>";

                           //tr += "<td>" + "<input class='btn btn-primary' type='button' id='" + value.uvssid + "' onclick='Bootstrapmodel(" + value.uvssid + ")' value='Update'>" + "</td>" + "</tr>";
                           $("#tBodyRemarks").append(tr);
                       });
                       $("#uvisRemarkdTable").DataTable({
                           deferRender: true,
                           scrollY: 200,
                           scrollCollapse: true,
                           scroller: true,

                       });
                   }
               });
           }

           /////////end UVISS List Remarks Decision/////////



           ////////////////Get by date UVISS List/////////////////
           $("#btnSearch").click(function () {
              
               if ($.fn.DataTable.isDataTable('#uvisTable')) {
                   $('#uvisTable').DataTable().destroy();
               }
               $('#uvisTable tbody').empty();
             
               let postData = {
                   'fromdate': $("#DateFrom").val(),
                   'todate': $("#Dateto").val()
               }
               console.log(postData);
            

               $.ajax({
                   type: "POST",
                   data: JSON.stringify(postData),
                   url: "UVISDecision.aspx/GetbydateuvssList",
                   dataType: "json",
                   contentType: "application/json",
                   success: function (response) {
                       console.log(response.d);
                       $.each(response.d, function (index, value) {
                           var tr = "<tr>";
                           tr += "<td>" + value.Logdate + "</td>";
                           tr += "<td>" + value.logdatetime + "</td>";
                           tr += "<td>" + value.cameraip + "</td>";
                           tr += "<td>" + value.sequence + "</td>";
                           tr += "<td>" + value.vehiclenumber + "</td>";
                           tr += "<td>" + value.fod + "</td>";
                           tr += "<td>" + value.pdi + "</td>";
                           tr += "<td>" + value.previous + "</td>";
                           tr += "<td>" + value.previouspath + "</td>";
                           //tr += "<td>" + value.ishandled + "</td>";
                           //tr += "<td>" + value.isdisplayed + "</td>";
                           tr += "<td>" + value.locationname + "</td>";

                           tr += "<td>" + "<input class='btn btn-primary' type='button' id='" + value.uvssid + "' onclick='Bootstrapmodel(" + value.uvssid + ")' value='Update'>" + "</td>" + "</tr>";
                           $("#tBody").append(tr);
                       });
                       $("#uvisTable").DataTable({
                           ///ajax: "../data/2500.txt",
                           deferRender: true,
                           scrollY: 200,
                           scrollCollapse: true,
                           scroller: true,

                       });
                   }
               });



           });
    ////////////////////End Get by date UVISS List

       });//////end document ready function

      

////////////////////////Start Bootsrap Model Show /////////////////////

       function Bootstrapmodel(vel) {
           uvssid = vel;
          //// alert(vel);
           $("#myModal").modal('show');
       }
////////////////////////////End Bootstrap Model Show
   </script>

     
   


</asp:Content>