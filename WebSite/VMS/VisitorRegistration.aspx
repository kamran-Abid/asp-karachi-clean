<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="VisitorRegistration.aspx.cs" Inherits="VisitorRegistration" %>

 <%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
</asp:ScriptManager> 
   <script src="Webcam_Plugin/jquery.webcam.js" type="text/javascript"></script>

    <script type="text/javascript">

        var pageUrl = '<%=ResolveUrl("~/VMS/VisitorRegistration.aspx") %>';
        $(function () {
            
            jQuery("#webcam").webcam({
               
                width: 215,
                height: 150,
                mode: "save",
                swffile: '<%=ResolveUrl("~/VMS/Webcam_Plugin/jscam.swf") %>',
                debug: function (type, status) {
                    $('#camStatus').append(type + ": " + status + '<br /><br />');
                   
                    if (status === "Camera started") { window.webcam.started = true; }
                },
                onSave: function (data) {
                    $.ajax({
                        type: "POST",
                        url: pageUrl + "/GetCapturedImage",
                        data: '',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (r) {
                            $("[id*=imgCapture]").css("visibility", "visible");
                            $("[id*=imgCapture]").attr("src", r.d);
                            $("div[id$='webcam']").hide();
                            $("input[id$='btnCapture']").hide();
                            $("div[id$='divCapturingArea']").show();

                            
                        },
                        failure: function (response) {
                            alert(response.d);
                        }
                    });
                },
                onCapture: function () {
                    webcam.save(pageUrl);
                }
            });
        });
        function Capture() {
            webcam.capture();
            return false;
        }

        function getWebCam() {
            $("div[id$='divCapturingArea']").hide();
           
            $("div[id$='webcam']").show();
            $("input[id$='btnCapture']").show();
            return false;
        }


        var barcodeScannerTimer;
        var barcodeString = '';
        $(document).ready(function () {
            
            getCurrentTime();

           
            $("body").on('keypress', function (e) {
                
                barcodeString = barcodeString + String.fromCharCode(e.charCode);

                clearTimeout(barcodeScannerTimer);
                barcodeScannerTimer = setTimeout(function () {
                    processBarcode();
                }, 300);
            });

            function processBarcode() {
                console.log('inside processBarcode with barcodeString "' + barcodeString + '"');

                if (!isNaN(barcodeString) && barcodeString != '') {  // @todo this check is lame. improve.
                    //do nothing;
                } else {
                    PageMethods.MyMethod(barcodeString, onSucceed, onError);
                    //alert('barcode is invalid: ' + barcodeString);
                }

                barcodeString = ''; // reset
            }
        });


        //CallBack method when the page call success
        function onSucceed(results, currentContext, methodName) {

            alert(results);

            var arry = '';

            arry = results.split("\r");
           
            if (arry[4].match(/[\u0627-\u06D2]+/g) != null) {
                var cnic = arry[1].substring(0, arry[1].length - 2);
                cnic = cnic.substring(0, 5) + '-' + cnic.substring(5, 12) + '-' + cnic.substring(12, 13);
                $("input[id$='txtCNIC']").val(cnic);
                // $("input[id$='txtUFamilyNo']").val(arry[2]);
                if (arry[3].length > 4)
                    $("input[id$='txtDateOfBirth']").val(arry[3].substring(0, 2) + '-' + arry[3].substring(2, 4) + '-' + arry[3].substring(4, 8));
                else
                    $("input[id$='txtDateOfBirth']").val(arry[3]);
                $("input[id$='txtVisitorName']").val(arry[4]);

                $("input[id$='txtFatherName']").val(arry[5]);
                var city = arry[7];
                if (city == "")
                    city = arry[8];
                $("textarea[id$='txtAddress']").val(arry[6] + city);
            }

            else
            {
                var cnic = arry[2];
                cnic = cnic.substring(0, 5) + '-' + cnic.substring(5, 12) + '-' + cnic.substring(12, 13);
                $("input[id$='txtCNIC']").val(cnic);
                var dob = arry[4].split('-');
                var dobformate = dob[2] + '-' + dob[1] + '-' + dob[0];
                $("input[id$='txtDateOfBirth']").val(dobformate);
                $("input[id$='txtDateOfBirth']").val().split('-')[0]
                $("input[id$='txtVisitorName']").val(arry[5]);

                $("input[id$='txtFatherName']").val(arry[6]);

                $("textarea[id$='txtAddress']").val(arry[7] + arry[8]);

            }
          
            $("body").unbind("keypress");
        }
        //CallBack method when the page call fails due to internal, server error 
        function onError(results, currentContext, methodName) {
            //Do here failure event 
        }
        function getCurrentTime() {
            var currentTime = new Date()
            var hours = currentTime.getHours()
            var minutes = currentTime.getMinutes()

            if (minutes < 10)
                minutes = "0" + minutes;

            var suffix = "AM";
            if (hours >= 12) {
                suffix = "PM";
                hours = hours - 12;
            }
            if (hours == 0) {
                hours = 12;
            }
            var current_time = hours + ":" + minutes + " " + suffix;
            $("input[id$='txtTimeIn']").val(current_time);
            //  show_message("Current Your System Time is : " + current_time);
        }
    </script>
          <fieldset id="fldSetVisterReg" style="width:95%; ">
              <legend>Vister Registration </legend>
    <table id="tblVisitorReg" style="font-family: Calibri; font-size: 11pt; width: 100%;">
        <tr>
             <td rowspan="13" style="vertical-align: top;width:300px; text-align:center;">
                 
                <fieldset id="fldLastVisit" style="text-align:center;">
                    <legend>Last Visit</legend>
              
                                                     <div class="dummy" style="margin-left:17%" ></div><br />
                    <div id="divLastDate" style="text-align:left;"></div>
                    <br />
                    <div id="divTimeIn" style="text-align:left;"></div>
                    <br />
                    <div id="divTimeOut" style="text-align:left;"> </div>
                     </fieldset>
                       
            </td>
            <td style="width: 140px; text-align: left;">CNIC:<span class="reqSpan">*</span>
            </td>
            <td style="width: 500px;">
                <asp:TextBox ID="txtCNIC" onblur="getVisitorDetailOnCNIC();"  runat="server" class="req"></asp:TextBox>
                
            </td>
              <td rowspan="12" style="vertical-align: top;width:300px; text-align:center;">
               
                  <fieldset>
                      <legend>Camera Picture</legend>
                  
                                                   <div id="webcam" >
                                </div>
                            <asp:Button ID="btnCapture" CssClass="btn" Text="Capture" runat="server" OnClientClick="return Capture();" />
                        
                             <div id="divCapturingArea" style="display:none;">
                                 <asp:Image ID="imgCapture" runat="server" Style="visibility: hidden; width: 215px;
                                        height: 150px" />
                                 <br />
                                  <asp:Button ID="btnReset" Text="Reset" CssClass="btn" runat="server" OnClientClick="return getWebCam();" />
                             </div>
            
       </fieldset>
            </td>
        </tr>
        <tr>
           
            <td style="width: 240px; text-align: left;">Visitor Name:<span class="reqSpan">*</span>
            </td>
            <td style="width: 500px;">
                <asp:TextBox ID="txtVisitorName" style="text-align:right;"  class="req" runat="server"></asp:TextBox>
            </td>
          
        </tr>
        <tr>
            <td style="width: 140px; text-align: left;">Father Name:<span class="reqSpan">*</span>
            </td>
            <td style="width: 500px;">
                <asp:TextBox ID="txtFatherName" style="text-align:right;" runat="server" class="req"></asp:TextBox>
            </td>
        </tr>

        

        <tr>
            <td style="width: 140px; text-align: left;">Date Of Birth:<span class="reqSpan">*</span>
            </td>
            <td style="width: 500px; white-space:nowrap;">
                <asp:TextBox ID="txtDateOfBirth" style="float: left;margin-right: 2%;"  class="req" runat="server" ></asp:TextBox>
              
                 <%-- <rjs:popcalendar ID="rjsDOB" Separator="/" Format="mm dd yyyy" Control="txtDateOfBirth" runat="server"
                                Font-Names="Tahoma" />--%>
            </td>
        </tr>
        <tr>
            <td style="width: 140px; text-align: left;">Name:<span class="reqSpan">*</span>
            </td>
            <td style="width: 500px;">
                <asp:TextBox ID="txtEngName"  runat="server" ></asp:TextBox>
            </td>
        </tr>

        <tr>
            <td style="width: 140px; text-align: left;">
                <asp:Label ID="Label11" Text="Address:" runat="server"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtAddress"  runat="server" TextMode="MultiLine" style="direction:rtl; width:91%;height:40px;background-color: #fff; border: 1px solid #ccc;border-radius: 4px;" ></asp:TextBox>
            </td>
        </tr>

        <tr>
            <td style="width: 140px; text-align: left;">
                <asp:Label ID="Label4" Text="Phone No:" runat="server"></asp:Label>
            </td>
            <td style="width: 500px;">
                <asp:TextBox ID="txtEngPhoneNo"  runat="server" BackColor="White"></asp:TextBox>
            </td>
        </tr>

        <tr>
            <td style="width: 140px; text-align: left;">
                <asp:Label ID="Label5" Text="Time In:" runat="server"></asp:Label>
            </td>
            <td style="width: 500px;">
                <asp:TextBox ID="txtTimeIn"  runat="server" BackColor="White"></asp:TextBox>
            </td>
        </tr>

        <tr>
            <td style="width: 140px; text-align: left;">
                <asp:Label ID="Label6" Text="Time Out:" runat="server"></asp:Label>
            </td>
            <td style="width: 500px;">
                <asp:TextBox ID="txtTimeOut"  runat="server" BackColor="White"></asp:TextBox>
            </td>
        </tr>

        <tr>
            <td style="width: 140px; text-align: left;">
                <asp:Label ID="Label7" Text="Place of Visit:" runat="server"></asp:Label>
            </td>
            <td style="width: 500px;">
                <asp:DropDownList  ID="ddlPlaceOfVisit" runat="server"></asp:DropDownList>
            </td>
        </tr>

        <tr>
            <td style="width: 140px; text-align: left;">
                <asp:Label ID="Label8" Text="Resident Address:" runat="server"></asp:Label>
            </td>
            <td style="width: 500px;">
                <asp:TextBox ID="txtResidentAddress"  runat="server" BackColor="White"></asp:TextBox>
            </td>
        </tr>

        <tr>
            <td style="width: 140px; text-align: left;">
                <asp:Label ID="Label9" Text="Vehicle No:" runat="server"></asp:Label>
            </td>
            <td style="width: 500px;">
                <asp:TextBox ID="txtVehicleNo"  runat="server" BackColor="White"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 140px; text-align: left;">
                <asp:Label ID="Label10" Text="Token No:" runat="server"></asp:Label>
            </td>
            <td style="width: 500px;">
                <asp:TextBox ID="txtTokenNo"  runat="server" BackColor="White"></asp:TextBox>

            </td>
        </tr>
        <tr>
            <td align="left">
                <asp:TextBox ID="txtID" Style="display: none;" runat="server"></asp:TextBox>
            </td>
            <td align="left">&nbsp;
            </td>


            <td align="left">
                
                <asp:Button ID="btnSave" Text="Add"  CssClass="btn" onMouseOver="getCurrentTime();" OnClientClick="return SaveVisitor();" runat="server" />

                <asp:Button ID="btnClearVisitor" Text="Clear"  CssClass="btn" OnClientClick="return ClearVisitor();" runat="server" />
                <asp:Button ID="Button1" Text="Enrollement"  CssClass="btn"  runat="server" OnClick="Button1_Click" />

                <asp:Button ID="btnUpdate" Text="Update" Style="display: none;" CssClass="btn" OnClientClick="return UpdateVisitor();" runat="server" />
            </td>
        </tr>
    </table>

              </fieldset>

   
        <fieldset id="fldVisitorDetails" style="overflow: auto; width:95%; ">
            <legend>Visitors Details</legend>
             <div id="divVisitorDetails" style="overflow: auto; width:1000px; height: 300px;">
            <table id="tblVisitorDetails" class="dataTable">
            </table>
                  </div>
        </fieldset>
   

    <script type="text/javascript" language="javascript">
        var oTable;

        $(document).ajaxStart(blockUI).ajaxStop(unblockUI);

        function blockUI() {
            $.blockUI({
                message: '<img src="images/ajax-loader.gif" />',
                css: { borderStyle: 'none', backgroundColor: "Transparent" }
            });
        }
        function unblockUI() {
            $.unblockUI();
        }
        $(document).ready(function () {
            getVisitor();

        });


  
       

        function dataTable() {
            oTable = $("#tblVisitorDetails").dataTable({
                bPaginate: false,
                bJQueryUI: true,
                oLanguage: { "sSearch": "Filter: " }
            });
        }
        function getVisitorDetailOnCNIC() {
            $(".dummy").html('');
            $("input[id$='txtVisitorName']").val("");
            $("input[id$='txtFatherName']").val("");
            $("input[id$='txtDateOfBirth']").val("");
            $("textarea[id$='txtAddress']").val("");
            $("input[id$='txtTimeIn']").val("");
            $("input[id$='txtTimeOut']").val("");
            $("select[id$='ddlPlaceOfVisit'] option:selected").text("");
            $("input[id$='txtVehicleNo']").val("");
            $("input[id$='txtVehicleNo']").val("");
            $("input[id$='txtEngName']").val("");
            $("input[id$='txtEngPhoneNo']").val("");           
            $("div[id$='divLastDate']").html("")
            $("div[id$='divTimeIn']").html("")
            $("div[id$='divTimeOut']").html("")
            var CNIC = $("input[id$='txtCNIC']").val().trim();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../VMS/webmethods.aspx/getResultFromCNIC",
                data: "{'CNIC':'" + CNIC + "'}",
                success: onsuccessgetVisitorDetail
            });


        }


        function onsuccessgetVisitorDetail(msg) {
            var data = msg.d;   
            //alert(msg.VisitorDetailNew[0].PICTURE_ID);
            if (data.VisitorDetailNew.length > 0) {
                $("input[id$='txtVisitorName']").val(data.VisitorDetailNew[0].VISITOR_NAME);
                $("input[id$='txtFatherName']").val(data.VisitorDetailNew[0].FATHER_NAME);
                $("input[id$='txtDateOfBirth']").val(data.VisitorDetailNew[0].DOB);
                $("textarea[id$='txtAddress']").val(data.VisitorDetailNew[0].ADDRESS);
                $("input[id$='txtTimeIn']").val(data.VisitorDetailNew[0].TIME_IN);
                $("input[id$='txtTimeOut']").val(data.VisitorDetailNew[0].TIME_OUT);
                $("select[id$='ddlPlaceOfVisit'] option:selected").text(data.VisitorDetailNew[0].HOST);
                $("input[id$='txtVehicleNo']").val(data.VisitorDetailNew[0].VEHICLE_NUMBER);
                $("input[id$='txtVehicleNo']").val(data.VisitorDetailNew[0].TOKEN_NUMBER);
                $("input[id$='txtEngName']").val(data.VisitorDetailNew[0].NAME);
                $("input[id$='txtEngPhoneNo']").val(data.VisitorDetailNew[0].PHONE_NUMBER);
                $(".dummy").append("<img id='theImg' style='width:150px;height:130px;' src='Captures/" + data.VisitorDetailNew[0].FirtstFifteen + data.VisitorDetailNew[0].last4 + ".png' />");
                $("div[id$='divLastDate']").html("Date: " + data.VisitorDetailNew[0].DATE)
                $("div[id$='divTimeIn']").html("Time In: " + data.VisitorDetailNew[0].TIME_IN)
                $("div[id$='divTimeOut']").html("Time Out: " + data.VisitorDetailNew[0].TIME_OUT)
            }
            return false;
        }
        function SaveVisitor() {
        
            if (!validate("tblVisitorReg")) {
                var CNIC = $("input[id$='txtCNIC']").val().trim();
                var VISITOR_NAME = $("input[id$='txtVisitorName']").val().trim();


                var FATHER_NAME = $("input[id$='txtFatherName']").val().trim();
                var DOB = $("input[id$='txtDateOfBirth']").val().trim();
                var ADDRESS = $("textarea[id$='txtAddress']").val().trim();
                var TIME_IN = $("input[id$='txtTimeIn']").val().trim();
                var TIME_OUT = $("input[id$='txtTimeOut']").val().trim();
                var HOST = $("select[id$='ddlPlaceOfVisit'] option:selected").text().trim();

                var VEHICLE_NUMBER = $("input[id$='txtVehicleNo']").val().trim();
                var TOKEN_NUMBER = $("input[id$='txtVehicleNo']").val().trim();

                var DEPARTMENT = "";
                var GATE_NUMBER = "";
                var NAME = $("input[id$='txtEngName']").val().trim();

                var PHONE_NUMBER = $("input[id$='txtEngPhoneNo']").val().trim();
                var RESTRICTED = "0";
                var PICTURE_ID = "";
                if ($("img[id$='imgCapture']").attr('src') == undefined)
                    PICTURE_ID = $("img[id$='imgCapture']").attr('src').split('/')[3].split('.')[0];
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../VMS/webmethods.aspx/SaveVisitor",
                    data: "{'CNIC':'" + CNIC + "','VISITOR_NAME':'" + VISITOR_NAME + "','FATHER_NAME':'" + FATHER_NAME + "','DOB':'" + DOB + "','ADDRESS':'" + ADDRESS + "','TIME_IN':'" + TIME_IN + "','TIME_OUT':'" + TIME_OUT + "','HOST':'" + HOST + "','VEHICLE_NUMBER':'" + VEHICLE_NUMBER + "','TOKEN_NUMBER':'" + TOKEN_NUMBER + "','DEPARTMENT':'" + DEPARTMENT + "','GATE_NUMBER':'" + GATE_NUMBER + "','NAME':'" + NAME + "','PHONE_NUMBER':'" + PHONE_NUMBER + "','RESTRICTED':'" + RESTRICTED + "','PICTURE_ID':'" + PICTURE_ID + "'}",
                    success: onsuccessSaveVisitor
                });
            }
            return false;
        }
        function onsuccessSaveVisitor(msg) {            
            $("#divMsg").html("Record Saved Successfully!").removeClass("error").addClass("success").show();

            location.reload();
            //ClearVisitor();
            
            //getVisitor();
            return false;
        }        
        function ClearVisitor() {
            $("input[type='text']").val("");
            $("textarea").val("");
            $("select").val("0");

            $("input[id$='btnUpdate']").hide();
            $("input[id$='btnSave']").attr("disabled", false);
            return false;
        }
        function getVisitor() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../VMS/webmethods.aspx/getVisitorDetail",
                data: "{}",
                success: onsuccessgetVisitor
            });
            return false;
        }
        function onsuccessgetVisitor(msg) {
          
            var data = msg.d;
            if (oTable != null) {
                oTable.fnClearTable();
                oTable.fnDestroy();
            }
            var tbl = "";
            tbl += "<thead>";
            tbl += "<tr>";
            tbl += "<th style='text-align:center;width:8%;'>Delete</th>";
            tbl += "<th style='text-align:center; white-space:nowrap;display:none;'>Edit</th>";
            tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Visitor ID</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Visitor Name</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Father Name</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Date Of Birth</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Address</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Date</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Time In</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Time Out</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Place Of Visit</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Vechile No.</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Token No</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Department</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Pic ID No.</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Gate No.</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Name</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Phone No.</th>";

            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            for (var i = 0; i < data.VisitorDetail.length; i++) {
                tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
                tbl += "<td id='txtDelete' align='center'> <input  type='image' src='../images/Cross2.png' onclick='return DeleteVisitorRecord(" + i + ");'> </td>";
                tbl += "<td style='cursor:Pointer;display:none;' id='txtUpdate' align='center' onclick='return EditRecord(" + i + ");'><img src='../images/Edit.png'></td>";
                tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.VisitorDetail[i].ID + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtVisitorName" + i + "'>" + data.VisitorDetail[i].VISITOR_NAME + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.VisitorDetail[i].FATHER_NAME + "</td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.VisitorDetail[i].DOB + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.VisitorDetail[i].ADDRESS + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.VisitorDetail[i].DATE + " </td>";


                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.VisitorDetail[i].TIME_IN + "</td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.VisitorDetail[i].TIME_OUT + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.VisitorDetail[i].HOST + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.VisitorDetail[i].VEHICLE_NUMBER + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.VisitorDetail[i].TOKEN_NUMBER + "</td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.VisitorDetail[i].DEPARTMENT + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" +data.VisitorDetail[i].PICTURE_ID + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.VisitorDetail[i].GATE_NUMBER + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.VisitorDetail[i].NAME + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.VisitorDetail[i].PHONE_NUMBER + " </td>";
                tbl += "</tr>";
            }
            tbl += "</tbody>";
            tbl += "</table>";
            $("#tblVisitorDetails").html(tbl);
            dataTable();
            return false;
        }

        function getRowID(rowID) {
            $("table[id$='tblVisitorDetails'] tr").css("background-color", "white");
            $("#trmain" + rowID).css("background-color", "#6798c1");

        }
        
        function DeleteVisitorRecord(rowNo) {


            var ID = $("#txtID" + rowNo).html();

            if (confirm("Are you sure you wish to delete this Record?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../VMS/webmethods.aspx/DeleteVisitor",
                    data: "{'ID':'" + ID + "'}",
                    success: onsuccessDeleteData
                });

                return false;
            }
            else
                return false;

        }

        function onsuccessDeleteData(msg) {
            $("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
            getVisitor();
            return false;
        }


        function EditRecord(rowNo) {
            var ID = $("#txtID" + rowNo).html().trim();
            $("input[id$='txtID']").val(ID);

            var HOST_NAME = $("#txtVisitorName" + rowNo).html().trim();
            $("input[id$='txtVisitorName']").val(HOST_NAME);

            $("input[id$='btnUpdate']").show();
            $("input[id$='btnSave']").attr("disabled", true);
            return false;
        }
        function UpdateVisitor() {
            if (!validate("tblVisitorReg")) {
                var ID = $("input[id$='txtID']").val();
                var HOST_NAME = $("input[id$='txtVisitorName']").val();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../VMS/webmethods.aspx/UpdateVisitor",
                    data: "{'ID':'" + ID + "','HOST_NAME':'" + HOST_NAME + "'}",
                    success: onsuccessUpdateVisitors
                });
            }
            return false;
        }
        function onsuccessUpdateVisitors() {
            
            $("#divMsg").html("Record Updated Successfully!").removeClass("error").addClass("success").show();
            $("input[id$='txtVisitorName']").val("");
            getVisitor();

            ClearVisitor();
            getVisitor();
            return false;
        }        
    </script>
</asp:Content>

