<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="Contractor_Information.aspx.cs" Inherits="RMS_Contractor_Information" %>

 <%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

  
     <link href="../css/jquery-ui.min.css" rel="stylesheet" />
    <script src="../js/jquery-ui.min.js"></script>
       <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
        <fieldset>
            <legend>Contractor Information Search Criteria</legend>
            <table class="form">
                <tr>
                    <td class="right" style="width: 10%;">CNIC:</td>
                    <td style="width: 22%;">
                        <input type="text"  id="txtCardNIC" />
                    </td>
                    <td class="right" style="width: 10%;">Firm Name:</td>
                    <td style="width: 22%;">
                        <input type="text" class="alpha" id="txtNameSearch"  />
                    </td>
                    <td class="right" style="width: 10%; display:none;">Status:</td>
                    <td  style="display:none;">
                        <asp:DropDownList ID="ddlStatusSearch" runat="server">
                        <asp:ListItem Text="All" Value=""></asp:ListItem>
                        <asp:ListItem Text="Active" Value="Active"></asp:ListItem>
                        <asp:ListItem Text="Inactive" Value="Inactive"></asp:ListItem>
                            <asp:ListItem Text="Black List" Value="BlackList"></asp:ListItem>
                    </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    
                    <td colspan="6" style="text-align: center">
                        <input type="button" id="btnSearch" class="btn" value="Search" onclick="getContractors();" />
                        <input type="button" id="btnClear" class="btn" value="Clear" onclick="clearResidentForm()" />
                    </td>
                </tr>
            </table>
        </fieldset>
        <div style="padding: 10px;">
        <input type="button" id="btnAddNew" class="btn" value="Add Contractor" onclick="addNewContractor();" />
    </div>
        <fieldset id="fieldsetGrd" style="width: 97%;">
        <legend>Contractor Information Details</legend>
        <div style="padding-bottom:20px;max-width:100%;max-height:440px;overflow: auto;">            
            <table class="dataTable">
                <thead>
                    <tr>
                        <th  style="display:none;">Action</th>
                        <th>Edit</th>
                        <th>Id</th>
                        <%--<th>Sr #</th>--%>
                        <th>Firm Name</th>
                        <th>Contractor Name</th>
                        <th style="display:none;">Gender</th>           
                        <th>CNIC</th>
                        <th style="display:none;">Firm Address</th>
                        <th style="display:none;">Resident Address</th>
                        <th>Mobile#</th>
                        <th style="display:none;">Office#</th>
                        <th style="display:none;">Identification Mark</th>
                        <th style="display:none;">Rank</th>
                        <th>Created By</th>
                        <th>Created Date</th>
                        <th style="display:none;">Modified By</th>
                        <th style="display:none;">Modified Date</th>
                        <th style="display:none;">Status</th>
                        <th style="display:none;">AuthType</th>
                        <th>Photo</th>
                        <th>Details</th>
                    </tr>
                </thead>
                <tbody id="tbodyContractors" style="background-color:white;">
                    <tr>
                        <td colspan="19">&nbsp;</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </fieldset>
        <fieldset id="fieldsetForm" style="display:none;">
            <legend>Contractor Information Form</legend>
            <table id="tblContractor" class="form">
                  <tr id="trClose">
                    <td style="text-align: right; border: none">
                        <div id="close">
                            <img src='../images/btn_close02.png' style="background: none repeat scroll 0 0 transparent;
                                border: medium none; height: 32px; margin-top: -52px; position: absolute; width: 32px;
                                cursor: pointer; right: 434px; left: 98%;" alt="Close" onclick='return CloseModal();' />
                        </div>
                    </td>
                </tr>
                <tr style="line-height:12px;" >
                    <td class="right">Id:</td>
                    <td>
                        <input type="text" id="txtId" disabled="disabled"  />
                    </td>

                    <td colspan="2" rowspan="4">
                         <div style="margin-right: 0px;float:right;">
                          <cc1:AsyncFileUpload OnClientUploadComplete="uploadComplete2" runat="server" ID="AsyncFileUpload1"
          Width="400px" UploaderStyle="Modern" ClientIDMode="AutoID" CompleteBackColor="White" UploadingBackColor="#CCFFFF" 
         ThrobberID="imgLoader"  OnUploadedComplete="FileUploadComplete" ToolTip="Click Here"   OnClientUploadStarted = "uploadStarted"/> 
                 <asp:HiddenField ID="hdnPictureId" runat="server" />
    <asp:Image ID="imgLoader" runat="server" ImageUrl="../images/loader.gif" /><br /><br />



 
                        <div class="dummy" id="divdummyClass" style=" display:none; float: right; margin-right: 100px;">  
              

                        </div>

                         <div  style="float: right; margin-right: 100px;">  
                 <img id = "imgDisplay" alt="" src="" style = "display:none;height:100px;width:100px;"/>

            <div class="camera">
            <video id="videoBC" style ="height:150px;width:150px;">Video stream not available.</video>
        </div>
       
        <canvas id="canvasBC" style="display:none"></canvas>
        <div class="output">
            <img id="photoBC" alt="The screen capture will appear in this box." style ="height:130px;width:150px;">
        </div>
        <div>
             <div>
                 <input type="button" class="btn btn-primary" id="startbuttonBC" value="Capture" />
                  <input type="button" class="btn btn-primary" id="RecaptureBC" onclick="RecaptureBCs();" value="ReCapture" />
                  
             </div>
            <input type="button" class="btn btn-primary" value="WebCam" id="WebCamCallBC" onclick="WebCamCallBCs();"/>
        </div>
        </div>


                             </div>

                    </td>
                </tr>                
                <tr>
                    <td class="right">Firm Name:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtFirmName" class="req alpha"  />
                    </td>
                </tr>
                <tr>
                    <td class="right">Contractor Name (CEO):<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtContractorName"  class="req alpha" />
                    </td>
                </tr>
                <tr>
                    <td class="right">CNIC:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtCNIC" runat="server"  class="req" onblur="getContractorResultByCNIC();"/>
                    </td>                    
                </tr>
                <tr>
                    <td class="right"  style="width: 20%;">Gender:</td>
                    <td  style="width: 30%;">
                        <asp:DropDownList ID="ddlGender" runat="server" Width="94%">                        
                    </asp:DropDownList>                        
                    </td>
                </tr>
                <tr>
                    <td class="right"  style="width: 20%;">Firm Address:</td>
                    <td  style="width: 30%;">
                        <input type="text" id="txtFirmAddress"  />                        
                    </td>                    
                    <td class="right"  style="width: 20%;">Resident Address:</td>
                    <td  style="width: 30%;">
                        <input type="text" id="txtResidentAddress"  />
                    </td>

                </tr>
                <tr>
                    <td class="right">Mobile #:</td>
                    <td>
                        <input type="text" id="txtMobileNo" class="cell"  />
                    </td>
                    <td class="right">Office #:</td>
                    <td>
                        <input type="text" id="txtOffice" class="phone"  />
                    </td>
                </tr>
                
                  <%--<tr>
                    <td colspan="2">
                    
                    </td>
                    <td class="right">Designation:</td>
                    <td>
                          <asp:DropDownList ID="ddlDesignation" runat="server">                            
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                    <asp:TextBox ID="txtEmpID" runat="server" style="display:none;"></asp:TextBox>
                    </td>
                    <td class="right">Address:</td>
                    <td>
                        <input type="text" id="txtAddressRef"  />
                    </td>
                </tr>--%>
                
                <tr>
                    <td class="right"  style="width: 20%;">Identification Mark:</td>
                    <td  style="width: 30%;">
                        <input type="text" id="txtIdentificationMark"  />                        
                    </td>                    
                    <td class="right"  style="width: 20%;">Rank/Appointment:</td>
                    <td  style="width: 30%;">
                        <input type="text" id="txtRank"  />
                    </td>
                </tr>
                <tr>
                    <td class="right"  style="width: 20%;">Clearance Status:</td>
                    <td  style="width: 30%;">
                        <asp:DropDownList ID="ddlClearanceStatus" runat="server" Width="94%">                        
                    </asp:DropDownList>                        
                    </td>
                    <td class="right"  style="width: 20%;">Clearance Level:</td>
                    <td  style="width: 30%;">
                        <asp:DropDownList ID="ddlLevel" runat="server" Width="94%">                        
                    </asp:DropDownList>                        
                    </td>                    
                </tr>
                <tr>
                    <td class="right"  style="width: 20%;">Valid From:</td>
                    <td  style="width: 30%;">
                        <asp:TextBox ID="txtValidFrom" CssClass="date req"   runat="server" style="width:60%;float: left; margin-right: 5px;"></asp:TextBox>
                     <%--   <input type="text" id="txtValidFrom"  />--%>
                        <rjs:popcalendar ID="Popcalendar2" Separator="/" Format="mm dd yyyy" Control="txtValidFrom" runat="server"
                                Font-Names="Tahoma" />                        
                    </td>
                    <td class="right"  style="width: 20%;">Valid TO:</td>
                    <td  style="width: 30%;">
                        <asp:TextBox ID="txtValidTo" CssClass="date req"   runat="server" style="width:60%;float: left; margin-right: 5px;"></asp:TextBox>
                      <%--  <input type="text" id="txtValidTo"  />--%>
                        <rjs:popcalendar ID="Popcalendar1" Separator="/" Format="mm dd yyyy" Control="txtValidTo" runat="server"
                                Font-Names="Tahoma" />                         
                    </td>
                </tr>

                      <tr>
                    <td class="right">Authentication Type<span class="reqSpan">*</span></td>
                    <td>
                          <asp:DropDownList ID="CIAuthenticationType" runat="server">    
                              <asp:ListItem Value="1" Text="Card Only"></asp:ListItem>                    
                              <asp:ListItem Value="2" Text="Finger Only"></asp:ListItem>                    
                              <asp:ListItem Value="3" Text="Card Or Finger "></asp:ListItem>  
                              <asp:ListItem Value="4" Text="Card and Finger "></asp:ListItem>                    
                    </asp:DropDownList>

                        <%--From-Today="true"--%>
                    </td></tr>

            </table>
             <div class="btn-wrapper" style="padding-top: 20px;">

                  <input type="button" id="BackSaveContractors" class="btn" value="Back" onclick="BackContractor();" />
           
            <input type="button" id="btnSaveContractors" class="btn" value="Save" onclick="saveContractor();" />
             <input type="button" id="btnClearContractors" class="btn" value="New" onclick="ClearContractor();" />
        </div>
        </fieldset>
       

    
    <script type="text/javascript">
        //------------------------------------------------------start  get Contractor result on the basis of CNIC--------------

        $(document).ready(function () {
            $("#RecaptureBC").hide();
            $("#startbuttonBC").hide();
            $("#photoBC").hide();
            getContractors();

        });

        function getContractorResultByCNIC() {
            var VCNIC = $("input[id$='txtCNIC']").val();
            if ($("input[id$='txtId']").val() == "") {
                if ($("input[id$='txtCNIC']").val().indexOf('_') < 0) {


                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../RMS/RMSwebmethods.aspx/GetContractorResultByCNIC",
                        data: "{'VCNIC':'" + VCNIC + "'}",
                        success: onsuccessGetContractorResult,
                        error: onErrorGetContractorResult
                    });
                    return false;

                }



                else
                    return false;

            }


        }

        function onsuccessGetContractorResult(msg) {
            var data = msg.d;
            var result = data.GetContractorCountTable[0].Counts;
            if (parseInt(result) > 0) {
                alert("Contractor already exist!");
                $("input[id$='txtCNIC']").val("");
                return false;
            }
        }

        function onErrorGetContractorResult() {


        }



        //--------------------------------------------------End of Contractor result-----------------

        $(document).ready(function () {
            $("#txtReferenceName").removeAttr("disabled");
            $("#fieldsetForm *").hover(function () {
                $("select[id$='ddlRank']").attr("disabled", true)
                $("select[id$='ddlDesignation']").attr("disabled", true)
                $("#txtAddressRef").attr("disabled", true);
                getDayFromTwoDates();

            })

            $("input[id$='txtReferenceName']").autocomplete({
                source: function (request, response) {
                    var Name = $("input[id$='txtReferenceName']").val().trim();

                    $.ajax({
                        url: '<%=ResolveUrl("~/RMS/RMSwebmethods.aspx/GetContractorReferenceName") %>',
                        data: "{  'Name':'" + Name + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            //var a = data.d;
                            //var b = a.split(',');

                            //alert(b[0]);
                            response($.map(data.d, function (item) {
                                return {
                                    label: item.split('&&')[0].split('**')[0],
                                    val: item
                                }
                            }))
                        },
                        error: function (response) {
                            alert('Error');
                        },
                        failure: function (response) {
                            alert('Error');
                        }
                    });
                },
                select: function (e, i) {
                    // alert(i.item.val);
                    $("input[id$='txtEmpID']").val(i.item.val.split('&&')[1].split(' ')[0]);
                    <%--  $("#<%=hfCustomerId.ClientID %>").val(i.item.val.split('&')[0]);--%>
                    $("input[id$='txtReferenceName']").val("");
                    $("input[id$='txtReferenceName']").val(i.item.val.split('&&')[0].split('#')[1]);
                   // $("select[id$='ddlRelation']").val(i.item.val.split('&Rl')[1].split(' ')[0])
                    $("select[id$='ddlRank']").val(i.item.val.split('&Rnk')[1].split(' ')[0])
                    $("select[id$='ddlDesignation']").val(i.item.val.split('&Dsg')[1].split(' ')[0])
                    $("input[id$='txtAddressRef']").val(i.item.val.split('&EmpAdd')[1].split('*')[0])
                    //$("input[id$='txtReferenceName']").val(i.item.val.split('&EmpAdd')[1].split('*')[0])
                    
                },
                minLength: 3,                
                delay: 1000

            });


        });

        function emptyFieldsOfReference() {
            $("input[id$='txtEmpID']").val("");           
            $("input[id$='txtReferenceName']").val("");            
            $("select[id$='ddlRank']").val("");
            $("select[id$='ddlDesignation']").val("");
            $("select[id$='ddlRelation']").val("");
            
            $("input[id$='txtAddressRef']").val("");
        }

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


            var a = $("input[id$='txtCNIC']").val();
            if (a == '') {

                return;}
            //alert(a+ "ha ja" )

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

        function clearResidentForm() {
            $("#txtCardNIC").val("");
            $("#txtNameSearch").val("");
            $("[id$='ddlStatusSearch']").val("");

        }

        function getContractors() {
            $("#fieldsetGrd").show();
            $("#fieldsetForm").hide();
            $("#tbodyContractors").html("");
            $.post("../RMS/CallBack/ContractorHandler.aspx", { CNIC: $("#txtCardNIC").val(), FirmName: $("#txtNameSearch").val(), CStatus: $("[id$='ddlStatusSearch']").val() }).done(function (data) {
                var response = data;
                var start = data.indexOf("#StartContractors#") + 15;
                var end = data.indexOf("#EndContractors#");
                $("#tbodyContractors").html(response.substring(start, end));

                if ($("#tbodyContractors tr").length == 0) {
                    $("#tbodyContractors").html("<tr><td class='noRecordFound' colspan='19'>No Record Found</td></tr>");
                }
                //  alert($("#tbodyContractors tr").length);
                if ($("select[id$='ddlStatusSearch']").val() == "Active") {

                    $(".tdContractorInActive").css("display", "inline-block");
                    $(".tdContractorActive").css("display", "none");


                }
                else if ($("select[id$='ddlStatusSearch']").val() == "Inactive") {

                    $(".tdContractorInActive").css("display", "none");
                    $(".tdContractorActive").css("display", "inline-block");
                }
                else {
                    // for (i = 0; i <= $("#tbodyContractors tr").length; i++)
                    $("#tbodyContractors tr").each(function () {

                        if ($(this).find('.status').html() == "Active") {
                            $(this).find(".tdContractorInActive").css("display", "inline-block");
                            $(this).find(".tdContractorBlackList").css("display", "inline-block");
                            $(this).find(".tdContractorActive").css("display", "none");
                        }
                        else if ($(this).find('.status').html() == "InActive") {
                            $(this).find(".tdContractorActive").css("display", "inline-block");
                            $(this).find(".tdContractorBlackList").css("display", "inline-block");
                            $(this).find(".tdContractorInActive").css("display", "none");
                        }

                        else {
                            $(this).find(".tdContractorBlackList").css("display", "none");
                            $(this).find(".tdContractorBlackList").parent().parent().css("color", "Red");
                            $(this).find(".tdContractorBlackList").parent().parent().css("font-weight", "bold");
                            $(this).find(".tdContractorActive").css("display", "inline-block");
                            $(this).find(".tdContractorInActive").css("display", "inline-block");
                        }


                    });
                    // alert($("#tbodyContractors tr").find('.status').html());
                }
            });

        }
        function ShowDetails_Modal(VID, elm, flag) {

            $("#WebCamCallBC").hide();
            $("#BackSaveContractors").hide(); 
            $("#btnClearContractors").hide();
            

            editContractor(VID, elm, flag);

        }
        function CloseModal() {
            $("#WebCamCallBC").show();
            $("#BackSaveContractors").show();
            $("#btnClearContractors").show();
            getContractors();
            //  Clear_Details();
            // alert("test");
            $("#fieldsetForm").jqmHide();
            $(".jqmWindow input, select").attr("disabled", false);
            return false;
        }

        function ClearContractor() {
            $("div[id*='AsyncFileUpload1']").css("width", "400px");
            $("div[id*='AsyncFileUpload1']").css("margin-top", "-34px");
            $("input[id*='AsyncFileUpload1']").val("");
            $("input[id*='AsyncFileUpload1']").css("background-color", "");
            $("input[id$='hdnPictureId']").val("");
            $("img[id$='imgDisplay']").hide();
            $("#dummy").addClass("dummy");
            $("#tblContractor input[type=text]").val("");
            $("#tblContractor select").val("");

            $("[id$='txtEmpID']").val("");

        }


        function editContractor(vid, elm, flag) {

           
            $("#imgDisplay").show();
            $("#canvasBC").hide();
            $("#photoBC").hide();
            $("#startbuttonBC").hide();

            $("#videoBC").hide();

            $("#fieldsetGrd").hide();


            $("[id$='txtEmpID']").val("");
            if (flag == '1') {
                //alert("testdjdjjdjd")
                $('#fieldsetForm').addClass("jqmWindow");
                $(".jqmWindow input, select").attr("disabled", true);
                $("img[src$='Calendar.gif']").hide();
                $('#fieldsetForm').css("margin-left", "-44%");
                $('#fieldsetForm').css("width", "86%");
                $('#trClose').show();
                $("img[src$='btn_close02.png']").show();
                $("input[id$='btnSaveContractors']").hide();
                $("div[id*='AsyncFileUpload1']").hide();
                $('#fieldsetForm').jqm({ modal: true, overlay: 75, trigger: false });
                $('#fieldsetForm').jqmShow();
            }
            else {
                $('#fieldsetForm').css("margin-left", "0%");
                $('#fieldsetForm').css("width", "97%");
                $('#trClose').hide();
                $("img[src$='btn_close02.png']").hide();
                $("input[id$='btnSaveContractors']").show();
                $("div[id*='AsyncFileUpload1']").show();
                $(".jqmWindow input, select").attr("disabled", false);
                $("img[src$='Calendar.gif']").show();
                $('#fieldsetForm').removeClass("jqmWindow");
            }


            $("#fieldsetForm input[type=text]").val("");
            $("#fieldsetForm select").val("");
            $("[id$='txtId']").val("0");
            $("#fieldsetForm").show();


            $("div[id*='AsyncFileUpload1']").css("width", "400px");
            $("input[id*='AsyncFileUpload1']").val("");
            $("div[id*='AsyncFileUpload1']").css("margin-top", "-34px");
            $("input[id*='AsyncFileUpload1']").css("background-color", "");
            $("input[id$='hdnPictureId']").val("");
            $("img[id$='imgDisplay']").hide();
            $("#divdummyClass").addClass("dummy");

            $("[id$='txtId']").val(vid);
            $("[id$='txtFirmName']").val($.trim($(elm).closest("tr").find(".firmName").html()));
            $("[id$='txtContractorName']").val($.trim($(elm).closest("tr").find(".ContractorName").html()));
            $("[id$='txtCNIC']").val($.trim($(elm).closest("tr").find(".CNIC").html()));
            $("[id$='ddlGender']").val($.trim($(elm).closest("tr").find(".Gender").html()));
            $("[id$='txtFirmAddress']").val($.trim($(elm).closest("tr").find(".FirmAddr").html()));
            $("[id$='txtResidentAddress']").val($.trim($(elm).closest("tr").find(".ResidentAddr").html()));
            $("[id$='txtMobileNo']").val($.trim($(elm).closest("tr").find(".Mobile").html()));
            $("[id$='txtOffice']").val($.trim($(elm).closest("tr").find(".OfficeNo").html()));
            $("[id$='txtIdentificationMark']").val($.trim($(elm).closest("tr").find(".IdentificationM").html()));
            $("[id$='txtRank']").val($.trim($(elm).closest("tr").find(".Rank").html()));

            $("[id$='ddlClearanceStatus']").val($.trim($(elm).closest("tr").find(".ClearanceStatus").html()));
            $("[id$='ddlLevel']").val($.trim($(elm).closest("tr").find(".ClearanceLevel").html()));
            $("[id$='txtValidFrom']").val($.trim($(elm).closest("tr").find(".ValidFrom").html()));
            $("[id$='txtValidTo']").val($.trim($(elm).closest("tr").find(".ValidTo").html()));

            $("[id$='CIAuthenticationType']").val($.trim($(elm).closest("tr").find(".AuthType").html()));


            //if($.trim($(elm).closest("tr").find(".refName").html()) !="")
            //{
            //    $("#chkWithRef").attr("checked", "checked");
            //    $("#txtReferenceName").removeAttr("disabled"); 
            //}
            //else
            //{                
            //    $("#chkWithoutRef").attr("checked", "checked");
            //    $("#txtReferenceName").attr("disabled", "disabled");
            //}

            var str = $(elm).closest("tr").find(".phto img").attr("src");

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

        }
        function saveContractor() {

            var Getimg = $("#photoBC")[0].src;
            var img = "";
            if (Getimg == "") {
                img = $.trim($("input[id$='hdnPictureId']").val());
                
            }
            else {
                img = Getimg;
                
            }


         

            if ($("input[id$='hdnPictureId']").val().indexOf(":") >= 0) {
                $("input[id$='hdnPictureId']").val("");

            }
            //if ($("[id$='txtReferenceName']").val() == "" && $("input[id$='chkWithRef']").is(":checked") == true) {
            //    alert("Enter Reference or click on Without Reference!");
            //    return false;
            //}

            //if ($("[id$='txtEmpID']").val() == "" && $("input[id$='chkWithRef']").is(":checked") == true) {
            //    alert("Enter Reference or click on Without Reference!");
            //    return false;
            //}
            if (!validate("fieldsetForm")) {
                var CId = $.trim($("[id$='txtId']").val()) == "" ? 0 : $.trim($("[id$='txtId']").val());
                //var refName = "";
                //if ($("#chkWithRef").is(":checked"))
                //{
                //    refName = $("#txtReferenceName").val();
                //}
                //var request = "{"
                //    + "'VID':'" + vId + "',"
                //    + "'FirstName':'" + $.trim($("[id$='txtFirstName']").val()) + "',"
                //    + "'LastName':'" + $.trim($("[id$='txtLastName']").val()) + "',"
                //    + "'NIC':'" + $.trim($("[id$='txtNIC']").val()) + "',"
                //    + "'VisitPurpose':'" + $.trim($("[id$='txtVisitPurposr']").val()) + "',"
                //    + "'Addr':'" + $.trim($("[id$='txtAddress']").val()) + "',"
                //    + "'Profession':'" + $.trim($("[id$='txtJobStudyLoc']").val()) + "',"
                //    + "'Phone':'" + $.trim($("[id$='txtPhone']").val()) + "',"
                //    + "'IssueDt':'" + $.trim($("[id$='txtIssueDate']").val()) + "',"
                //    + "'Mobile':'" + $.trim($("[id$='txtCellNo']").val()) + "',"
                //    + "'ValidUpto':'" + $.trim($("[id$='txtValidityDate']").val()) + "',"
                //    + "'ReferenceName':'" + refName + "',"
                //    + "'VisitDays':'" + $.trim($("[id$='txtDays']").val()) + "',"
                //    //+ "'Religion':'" + $.trim($("[id$='txtPNO']").val()) + "',"
                //    + "'Relation':'" + $.trim($("[id$='ddlRelation']").val()) + "',"
                //    + "'Rank':'" + $.trim($("[id$='ddlRank']").val()) + "',"
                //    + "'ReferenceAdd':'" + $.trim($("[id$='txtAddressRef']").val()) + "',"
                //    + "'Photo':'" + $.trim($("[id$='hdnPictureId']").val()) + "',"
                //    + "'Designation':'" + $.trim($("[id$='ddlDesignation']").val()) + "',"
                //     + "'empID':'" + $.trim($("[id$='txtEmpID']").val()) + "'"
                //    + "}";

                var request = "{"
                    + "'CID':'" + CId + "',"
                    + "'FirmName':'" + $.trim($("[id$='txtFirmName']").val()) + "',"
                    + "'ContractorName':'" + $.trim($("[id$='txtContractorName']").val()) + "',"
                    + "'Gender':'" + $.trim($("[id$='ddlGender']").val()) + "',"
                    + "'CNIC':'" + $.trim($("[id$='txtCNIC']").val()) + "',"
                    + "'FirmAddr':'" + $.trim($("[id$='txtFirmAddress']").val()) + "',"
                    + "'ResidenceAddr':'" + $.trim($("[id$='txtResidentAddress']").val()) + "',"
                    + "'Mobile':'" + $.trim($("[id$='txtMobileNo']").val()) + "',"
                    + "'OfficeNo':'" + $.trim($("[id$='txtOffice']").val()) + "',"
                    + "'IdentificationM':'" + $.trim($("[id$='txtIdentificationMark']").val()) + "',"
                    + "'Rank':'" + $.trim($("[id$='txtRank']").val()) + "',"
                    + "'CLearanceStatus':'" + $.trim($("[id$='ddlClearanceStatus']").val()) + "',"
                    + "'ClearanceLevel':'" + $.trim($("[id$='ddlLevel']").val()) + "',"
                    + "'ValidFrom':'" + $.trim($("[id$='txtValidFrom']").val()) + "',"
                    + "'ValidTo':'" + $.trim($("[id$='txtValidTo']").val()) + "',"
                    + "'AuthType':'" + $.trim($("[id$='CIAuthenticationType']").val()) + "',"
                    + "'Photo':'" + img + "'"
                    + "}";
                //alert("'ValidTo':'" + $.trim($("[id$='txtValidTo']").val()) + "'");
                $.ajax({
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json",
                    url: "../RMS/RMSWebMethod.aspx/SaveContractorInfo",
                    data: request,
                    success: function (data) {
                        showSuccessMsg("Information saved successfully!");
                        getContractors();
                        $("#txtId").val(data.d);
                    }
                });
            }

        }

        function startRefresh() {
            setTimeout(startRefresh, 1000);
            getContractors();
        }
        function addNewContractor() {

            $('#fieldsetForm').css("margin-left", "0%");
            $('#fieldsetForm').css("width", "97%");
            $('#trClose').hide();
            $("img[src$='btn_close02.png']").hide();
            $("input[id$='btnSaveContractors']").show();
            $("div[id*='AsyncFileUpload1']").show();
            $(".jqmWindow input, select").attr("disabled", false);
            $("img[src$='Calendar.gif']").show();
            $('#fieldsetForm').removeClass("jqmWindow");

            $("div[id*='AsyncFileUpload1']").css("width", "400px");
            $("input[id*='AsyncFileUpload1']").val("");
            $("div[id*='AsyncFileUpload1']").css("margin-top", "-34px");
            $("input[id*='AsyncFileUpload1']").css("background-color", "");
            $("input[id$='hdnPictureId']").val("");
            $("img[id$='imgDisplay']").hide();
            $("#divdummyClass").addClass("dummy");
            $("#fieldsetForm").show();
            $("#fieldsetGrd").hide();

            $("#tblContractor input[type=text]").val("");
            $("input[id$='hdnPictureId']").val("")
            $("#tblContractor select").val("");
        }
        //function enableDisableRef(elem) {
        //    if(elem=="E")
        //    {
        //        $("#txtReferenceName").addClass("req");
        //        $("#spnName").text("*")
        //        $("#txtReferenceName").removeAttr("disabled");
        //        $("select[id$='ddlRelation']").attr("disabled", false)
        //        $("select[id$='ddlRank']").attr("disabled", true)
        //        $("select[id$='ddlDesignation']").attr("disabled", true)
        //        $("#txtAddressRef").attr("disabled", true);
        //    }
        //    else
        //    {
        //        $("#spnName").text("")
        //        $("#txtReferenceName").removeClass("req");
        //        $("#txtReferenceName").attr("disabled", "disabled");
        //        $("select[id$='ddlRelation']").attr("disabled", true)
        //        $("select[id$='ddlRank']").attr("disabled", true)
        //        $("select[id$='ddlDesignation']").attr("disabled", true)
        //        $("#txtAddressRef").attr("disabled", true);
        //        emptyFieldsOfReference();
        //    }


        //}



        //---------------------------------------------Delete Contractor Record------------------------------------------
        function InActiveContractor(VID) {

            if (confirm("Are you sure you wish to Inactive this Record?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../RMS/RMSWebMethod.aspx/InActiveContractorRecord",
                    data: "{'VID':'" + VID + "'}",
                    success: onsuccessInActiveContractorRecord
                });

                return false;
            }
            else
                return false;
        }


        function onsuccessInActiveContractorRecord(msg) {
            //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("User has been Inactivated Successfully!");
            getContractors();
            return false;
        }

        //---------------------------------------------Activate Contractor Record------------------------------------------
        function ActivatePACSContractor(VID) {

            if (confirm("Are you sure you wish to Activate this User?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../RMS/RMSWebMethod.aspx/ActivateContractorRecord",
                    data: "{'VID':'" + VID + "'}",
                    success: onsuccessDeleteContractors
                });

                return false;
            }
            else
                return false;
        }


        function onsuccessDeleteContractors(msg) {
            //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("User has been Activated Successfully!");
            getContractors();
            return false;
        }

        //----------------------------------------Black List Visistor---------------------------------------------------------------------------------------

        function BlackListPACSContractor(VID) {
            if (confirm("Are you sure you wish to Black List this User?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../RMS/RMSWebMethod.aspx/BlackListContractorRecord",
                    data: "{'VID':'" + VID + "'}",
                    success: onsuccessBlackListContractor
                });

                return false;
            }
            else
                return false;
        }


        function onsuccessBlackListContractor(msg) {
            //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("User has been Black Listed Successfully!");
            getContractors();
            return false;
        }


        //-------------------------------------------------Get Day from two dates----------------------------------------------------------


        function getDayFromTwoDates() {
            if ($("input[id$='txtIssueDate']").val().trim() != "" && $("input[id$='txtValidityDate']").val() != "") {
                var oneDay = 24 * 60 * 60 * 1000; // hours*minutes*seconds*milliseconds
                var firstDate = new Date($("input[id$='txtIssueDate']").val());
                var secondDate = new Date($("input[id$='txtValidityDate']").val());

                var diffDays = Math.round(Math.abs((firstDate.getTime() - secondDate.getTime()) / (oneDay)));
                $("input[id$='txtDays']").val(diffDays);
                // alert(diffDays);
            }
        }



        function BackContractor() {
            getContractors();
        }


        ////////////////////////WebCam Contractor Information ///////
        var width = 320; // We will scale the photo width to this
        var height = 0; // This will be computed based on the input stream
        var streaming = false;
        var video = null;
        var canvas = null;
        var photo = null;
        var startbuttonBC = null;
        function startupBCs() {
            $("#imgDisplay").hide();
            $("#startbuttonBC").show();
            $("#WebCamCallBC").hide();

            $("#videoBC").show();
            video = document.getElementById('videoBC');
            canvas = document.getElementById('canvasBC');
            photo = document.getElementById('photoBC');
            startbuttonBC = document.getElementById('startbuttonBC');

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

            startbuttonBC.addEventListener('click', function (ev) {
                takepictureBCs();
                ev.preventDefault();
            }, false);

            clearphotoBCs();
        }


        function clearphotoBCs() {
            var context = canvas.getContext('2d');
            context.fillStyle = "#AAA";
            context.fillRect(0, 0, canvas.width, canvas.height);

            var data = canvas.toDataURL('image/png');
            photo.setAttribute('src', data);
        }

        function takepictureBCs() {
            $("#startbuttonBC").hide();
            $("#RecaptureBC").show();
            $("#photoBC").show();
            $("#videoBC").hide();
            var context = canvas.getContext('2d');
            if (width && height) {
                canvas.width = width;
                canvas.height = height;
                context.drawImage(video, 0, 0, width, height);

                var data = canvas.toDataURL('image/png');
                photo.setAttribute('src', data);
            } else {
                clearphotoBCs();
            }
        }

        function WebCamCallBCs() {
            $("#startbuttonBC").show();
            $("#imgDisplay").hide();
            $("#videoGU").show();
            startupBCs();
        }

        function RecaptureBCs() {
            $("#imgDisplay").hide();
            $("#photoBC").hide();

            $("#startbuttonBC").show();
            $("#RecaptureBC").hide();
            $("#WebCamCallBC").hide();

            $("#videoBC").show();
        }





    </script>
</asp:Content>

