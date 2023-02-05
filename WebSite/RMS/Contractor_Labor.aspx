<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="Contractor_Labor.aspx.cs" Inherits="RMS_Contractor_Labor" %>

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
            <legend>Contractor Labor Information Search Criteria</legend>
            <table class="form">
                <tr>
                    <td class="right" style="width: 10%;">CNIC:</td>
                    <td style="width: 22%;">
                        <input type="text"  id="txtCardNIC" />
                    </td>
                    <td class="right" style="width: 10%;">Labor Name:</td>
                    <td style="width: 22%;">
                        <input type="text" class="alpha" id="txtNameSearch"  />
                    </td>
                    <td class="right" style="width: 10%;">Status:</td>
                    <td>
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
                        <input type="button" id="btnSearch" class="btn" value="Search" onclick="getContractorLabors();" />
                        <input type="button" id="btnClear" class="btn" value="Clear" onclick="clearResidentForm()" />
                    </td>
                </tr>
            </table>
        </fieldset>
        <div style="padding: 10px;">
        <input type="button" id="btnAddNew" class="btn" value="Add Contractor Labor" onclick="addNewContractorLabor();" />
    </div>
        <fieldset id="fieldsetGrd" style="width: 97%;">
        <legend>Contractor Labor Information Details</legend>
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
                        <th>Labor Name</th>
                        <th style="display:none;">Gender</th>           
                        <th>CNIC</th>
                        <th style="display:none;">Identification Mark</th>
                        <th style="display:none;">Place of Work</th>
                        <th style="display:none;">Address</th>
                        <th>Mobile#</th>
                        <th>Created By</th>
                        <th>Created Date</th>
                        <th style="display:none;">Modified By</th>
                        <th style="display:none;">Modified Date</th>
                        <th>Clearance Level</th>
                        <th style="display:none;">Status</th>
                        <th style="display:none;">AuthType</th>
                        <th>Photo</th>
                        <th>Details</th>
                    </tr>
                </thead>
                <tbody id="tbodyContractorLabors" style="background-color:white;">
                    <tr>
                        <td colspan="19">&nbsp;</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </fieldset>
        <fieldset id="fieldsetForm" style="display:none;">
            <legend>Contractor Labor Information Form</legend>
            <table id="tblContractorLabor" class="form">
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
                    <td class="right">Contractor Name(CEO):<span class="reqSpan">*</span></td>
                    <td>
                        <%--<input type="text" id="txtContractorName"  class="req cnic" onblur="getContractorLaborResultByCNIC();"/>--%>
                        <asp:DropDownList ID="ddlContractorName" runat="server" Width="94%">                        
                    </asp:DropDownList>
                    </td>                    
                </tr>
                <tr>
                    <td class="right">Firm Name:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtFirmName" class="req alpha"  />
                    </td>
                </tr>
                <tr>
                    <td class="right">Labor Name:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtLaborName"  class="req alpha" />
                    </td>
                </tr>
                <tr>
                    <td class="right">CNIC:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtCNIC"  runat="server" class="req" onblur="getContractorLaborResultByCNIC();"/>
                    </td>
                    <td class="right"  style="width: 20%;">Gender:</td>
                    <td  style="width: 30%;">
                        <asp:DropDownList ID="ddlGender" runat="server" Width="94%">                        
                    </asp:DropDownList>                        
                    </td>                    
                </tr>

                <tr>
                    <td class="right"  style="width: 20%;">Place of Work:</td>
                    <td  style="width: 30%;">
                        <input type="text" id="txtPlaceofWork"  />                        
                    </td>                    
                    <td class="right"  style="width: 20%;">Address:</td>
                    <td  style="width: 30%;">
                        <input type="text" id="txtAddress"  />
                    </td>

                </tr>
                <tr>
                    <td class="right">Mobile #:</td>
                    <td>
                        <input type="text" id="txtMobileNo" class="cell"  />
                    </td>
                    <td class="right"  style="width: 20%;">Identification Mark:</td>
                    <td  style="width: 30%;">
                        <input type="text" id="txtIdentificationMark"  />                        
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
                    <td class="right"  style="width: 20%;">Valid To:</td>
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
                          <asp:DropDownList ID="CLAuthenticationType" runat="server">    
                              <asp:ListItem Value="1" Text="Card Only"></asp:ListItem>                    
                              <asp:ListItem Value="2" Text="Finger Only"></asp:ListItem>                    
                              <asp:ListItem Value="3" Text="Card Or Finger "></asp:ListItem>  
                              <asp:ListItem Value="4" Text="Card and Finger "></asp:ListItem>                    
                    </asp:DropDownList>

                        <%--From-Today="true"--%>
                    </td></tr>

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
                
            </table>
             <div class="btn-wrapper" style="padding-top: 20px;">
                 <input type="button" id="btnBackContractorLabors" class="btn" value="Back" onclick="BackContractorLabor();" />
           
                 <input type="button" id="btnSaveContractorLabors" class="btn" value="Save" onclick="saveContractorLabor();" />
             <input type="button" id="btnClearContractorLabors" class="btn" value="New" onclick="ClearContractorLabor();" />
        </div>
        </fieldset>
       

    
    <script type="text/javascript">
        //------------------------------------------------------start  get ContractorLabor result on the basis of CNIC--------------
        $(document).ready(function () {
            $("#RecaptureBC").hide();
            $("#startbuttonBC").hide();
            $("#photoBC").hide();
            getContractorLabors();

        });

        function BackContractorLabor() {
            getContractorLabors();
        }



        function getContractorLaborResultByCNIC() {
            var VCNIC = $("input[id$='txtCNIC']").val();
            if ($("input[id$='txtId']").val() == "") {
                if ($("input[id$='txtCNIC']").val().indexOf('_') < 0) {


                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../RMS/RMSwebmethods.aspx/GetContractorLaborResultByCNIC",
                        data: "{'VCNIC':'" + VCNIC + "'}",
                        success: onsuccessGetContractorLaborResult,
                        error: onErrorGetContractorLaborResult
                    });
                    return false;

                }



                else
                    return false;

            }


        }

        function onsuccessGetContractorLaborResult(msg) {
            var data = msg.d;
            var result = data.GetContractorLaborCountTable[0].Counts;
            if (parseInt(result) > 0) {
                alert("ContractorLabor already exist!");
                $("input[id$='txtCNIC']").val("");
                return false;
            }
        }

        function onErrorGetContractorLaborResult() {


        }



        //--------------------------------------------------End of ContractorLabor result-----------------

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
                        url: '<%=ResolveUrl("~/RMS/RMSwebmethods.aspx/GetContractorLaborReferenceName") %>',
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
            //alert(a+ "ha ja" )
            if (a == '') {
                return;
            }
            else {
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

        function clearResidentForm() {
            $("#txtCardNIC").val("");
            $("#txtNameSearch").val("");
            $("[id$='ddlStatusSearch']").val("");

        }

        function getContractorLabors() {
            $("#fieldsetGrd").show();
            $("#fieldsetForm").hide();
            $("#tbodyContractorLabors").html("");
            $.post("../RMS/CallBack/ContractorLaborHandler.aspx", { CNIC: $("#txtCardNIC").val(), LaborName: $("#txtNameSearch").val(), CStatus: $("[id$='ddlStatusSearch']").val() }).done(function (data) {
                var response = data;
                var start = data.indexOf("#StartContractorLabors#") + 15;
                var end = data.indexOf("#EndContractorLabors#");
                $("#tbodyContractorLabors").html(response.substring(start, end));

                if ($("#tbodyContractorLabors tr").length == 0) {
                    $("#tbodyContractorLabors").html("<tr><td class='noRecordFound' colspan='19'>No Record Found</td></tr>");
                }
                //  alert($("#tbodyContractorLabors tr").length);
                if ($("select[id$='ddlStatusSearch']").val() == "Active") {

                    $(".tdContractorLaborInActive").css("display", "inline-block");
                    $(".tdContractorLaborActive").css("display", "none");


                }
                else if ($("select[id$='ddlStatusSearch']").val() == "Inactive") {

                    $(".tdContractorLaborInActive").css("display", "none");
                    $(".tdContractorLaborActive").css("display", "inline-block");
                }
                else {
                    // for (i = 0; i <= $("#tbodyContractorLabors tr").length; i++)
                    $("#tbodyContractorLabors tr").each(function () {

                        if ($(this).find('.status').html() == "Active") {
                            $(this).find(".tdContractorLaborInActive").css("display", "inline-block");
                            $(this).find(".tdContractorLaborBlackList").css("display", "inline-block");
                            $(this).find(".tdContractorLaborActive").css("display", "none");
                        }
                        else if ($(this).find('.status').html() == "InActive") {
                            $(this).find(".tdContractorLaborActive").css("display", "inline-block");
                            $(this).find(".tdContractorLaborBlackList").css("display", "inline-block");
                            $(this).find(".tdContractorLaborInActive").css("display", "none");
                        }

                        else {
                            $(this).find(".tdContractorLaborBlackList").css("display", "none");
                            $(this).find(".tdContractorLaborBlackList").parent().parent().css("color", "Red");
                            $(this).find(".tdContractorLaborBlackList").parent().parent().css("font-weight", "bold");
                            $(this).find(".tdContractorLaborActive").css("display", "inline-block");
                            $(this).find(".tdContractorLaborInActive").css("display", "inline-block");
                        }


                    });
                    // alert($("#tbodyContractorLabors tr").find('.status').html());
                }
            });

        }
        function ShowDetails_Modal(VID, elm, flag) {

            $("#WebCamCallBC").hide();
            $("#btnBackContractorLabors").hide();
            $("#btnClearContractorLabors").hide();
           




            editContractorLabor(VID, elm, flag);

        }
        function CloseModal() {
            $("#WebCamCallBC").show();
            getContractorLabors();
            $("#btnBackContractorLabors").show();
            $("#btnClearContractorLabors").show();
            //  Clear_Details();
            // alert("test");
            $("#fieldsetForm").jqmHide();
            $(".jqmWindow input, select").attr("disabled", false);
            return false;
        }

        function ClearContractorLabor() {
            $("div[id*='AsyncFileUpload1']").css("width", "400px");
            $("div[id*='AsyncFileUpload1']").css("margin-top", "-34px");
            $("input[id*='AsyncFileUpload1']").val("");
            $("input[id*='AsyncFileUpload1']").css("background-color", "");
            $("input[id$='hdnPictureId']").val("");
            $("img[id$='imgDisplay']").hide();
            $("#dummy").addClass("dummy");
            $("#tblContractorLabor input[type=text]").val("");
            $("#tblContractorLabor select").val("");

            $("[id$='txtEmpID']").val("");

        }


        function editContractorLabor(vid, elm, flag) {

            ///$("#WebCamCallBC").show();
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
                $("input[id$='btnSaveContractorLabors']").hide();
                $("div[id*='AsyncFileUpload1']").hide();
                $('#fieldsetForm').jqm({ modal: true, overlay: 75, trigger: false });
                $('#fieldsetForm').jqmShow();
            }
            else {
                $('#fieldsetForm').css("margin-left", "0%");
                $('#fieldsetForm').css("width", "97%");
                $('#trClose').hide();
                $("img[src$='btn_close02.png']").hide();
                $("input[id$='btnSaveContractorLabors']").show();
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
            $("[id$='ddlContractorName']").val($.trim($(elm).closest("tr").find(".ContractorName").html()));
            $("[id$='txtFirmName']").val($.trim($(elm).closest("tr").find(".firmName").html()));
            $("[id$='txtLaborName']").val($.trim($(elm).closest("tr").find(".LaborName").html()));
            $("[id$='txtCNIC']").val($.trim($(elm).closest("tr").find(".CNIC").html()));
            $("[id$='ddlGender']").val($.trim($(elm).closest("tr").find(".Gender").html()));
            $("[id$='txtPlaceofWork']").val($.trim($(elm).closest("tr").find(".PlaceofWork").html()));
            $("[id$='txtAddress']").val($.trim($(elm).closest("tr").find(".Address").html()));
            $("[id$='txtMobileNo']").val($.trim($(elm).closest("tr").find(".Mobile").html()));
            $("[id$='txtIdentificationMark']").val($.trim($(elm).closest("tr").find(".IdentificationM").html()));
            $("[id$='ddlClearanceStatus']").val($.trim($(elm).closest("tr").find(".ClearanceStatus").html()));
            $("[id$='ddlLevel']").val($.trim($(elm).closest("tr").find(".ClearanceLevel").html()));
            $("[id$='txtValidFrom']").val($.trim($(elm).closest("tr").find(".ValidFrom").html()));
            $("[id$='txtValidTo']").val($.trim($(elm).closest("tr").find(".ValidTo").html()));
            $("[id$='CLAuthenticationType']").val($.trim($(elm).closest("tr").find(".AuthType").html()));
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
        function saveContractorLabor() {

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
                    + "'ContractorName':'" + $.trim($("[id$='ddlContractorName']").val()) + "',"
                    + "'FirmName':'" + $.trim($("[id$='txtFirmName']").val()) + "',"
                    + "'LaborName':'" + $.trim($("[id$='txtLaborName']").val()) + "',"
                    + "'Gender':'" + $.trim($("[id$='ddlGender']").val()) + "',"
                    + "'CNIC':'" + $.trim($("[id$='txtCNIC']").val()) + "',"
                    + "'PlaceofWork':'" + $.trim($("[id$='txtPlaceofWork']").val()) + "',"
                    + "'Address':'" + $.trim($("[id$='txtAddress']").val()) + "',"
                    + "'Mobile':'" + $.trim($("[id$='txtMobileNo']").val()) + "',"
                    + "'IdentificationM':'" + $.trim($("[id$='txtIdentificationMark']").val()) + "',"
                    + "'CLearanceStatus':'" + $.trim($("[id$='ddlClearanceStatus']").val()) + "',"
                    + "'ClearanceLevel':'" + $.trim($("[id$='ddlLevel']").val()) + "',"
                    + "'ValidFrom':'" + $.trim($("[id$='txtValidFrom']").val()) + "',"
                    + "'ValidTo':'" + $.trim($("[id$='txtValidTo']").val()) + "',"
                    + "'AuthType':'" + $.trim($("[id$='CLAuthenticationType']").val()) + "',"
                    + "'Photo':'" + img + "'"
                    + "}";

                $.ajax({
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json",
                    url: "../RMS/RMSWebMethod.aspx/SaveContractorLaborInfo",
                    data: request,
                    success: function (data) {
                        showSuccessMsg("Information saved successfully!");
                        getContractorLabors();
                        $("#txtId").val(data.d);
                    }
                });
            }

        }

        function startRefresh() {
            setTimeout(startRefresh, 1000);
            getContractorLabors();
        }
        function addNewContractorLabor() {

            $('#fieldsetForm').css("margin-left", "0%");
            $('#fieldsetForm').css("width", "97%");
            $('#trClose').hide();
            $("img[src$='btn_close02.png']").hide();
            $("input[id$='btnSaveContractorLabors']").show();
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

            $("#tblContractorLabor input[type=text]").val("");
            $("input[id$='hdnPictureId']").val("")
            $("#tblContractorLabor select").val("");
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



        //---------------------------------------------Delete ContractorLabor Record------------------------------------------
        function InActiveContractorLabor(VID) {

            if (confirm("Are you sure you wish to Inactive this Record?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../RMS/RMSWebMethod.aspx/InActiveContractorLaborRecord",
                    data: "{'VID':'" + VID + "'}",
                    success: onsuccessInActiveContractorLaborRecord
                });

                return false;
            }
            else
                return false;
        }


        function onsuccessInActiveContractorLaborRecord(msg) {
            //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("User has been Inactivated Successfully!");
            getContractorLabors();
            return false;
        }

        //---------------------------------------------Activate ContractorLabor Record------------------------------------------
        function ActivatePACSContractorLabor(VID) {

            if (confirm("Are you sure you wish to Activate this User?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../RMS/RMSWebMethod.aspx/ActivateContractorLaborRecord",
                    data: "{'VID':'" + VID + "'}",
                    success: onsuccessDeleteContractorLabors
                });

                return false;
            }
            else
                return false;
        }


        function onsuccessDeleteContractorLabors(msg) {
            //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("User has been Activated Successfully!");
            getContractorLabors();
            return false;
        }

        //----------------------------------------Black List Visistor---------------------------------------------------------------------------------------

        function BlackListPACSContractorLabor(VID) {
            if (confirm("Are you sure you wish to Black List this User?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../RMS/RMSWebMethod.aspx/BlackListContractorLaborRecord",
                    data: "{'VID':'" + VID + "'}",
                    success: onsuccessBlackListContractorLabor
                });

                return false;
            }
            else
                return false;
        }


        function onsuccessBlackListContractorLabor(msg) {
            //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("User has been Black Listed Successfully!");
            getContractorLabors();
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

