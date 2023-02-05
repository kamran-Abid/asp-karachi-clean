<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="Business_Community_Detail.aspx.cs" Inherits="RMS_Business_Community_Detail" %>

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
            <legend>Business Community Detail Search Criteria</legend>
            <table class="form">
                <tr>
                    <td class="right" style="width: 10%;">CNIC:</td>
                    <td style="width: 22%;">
                        <input type="text"  id="txtCardNIC" />
                    </td>
                    <td class="right" style="width: 10%;">Name:</td>
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
                        <input type="button" id="btnSearch" class="btn" value="Search" onclick="getBusinessCommunityDetails();" />
                        <input type="button" id="btnClear" class="btn" value="Clear" onclick="clearResidentForm()" />
                    </td>
                </tr>
            </table>
        </fieldset>
        <div style="padding: 10px;">
        <input type="button" id="btnAddNew" class="btn" value="Add Business Community Detail" onclick="addNewBusinessCommunityDetail();" />
    </div>
        <fieldset id="fieldsetGrd" style="width: 97%;">
        <legend>Business Community Details</legend>
        <div style="padding-bottom:20px;max-width:100%;max-height:440px;overflow: auto;">            
            <table class="dataTable">
                <thead>
                    <tr>
                        <th  style="display:none;">Action</th>
                        <th>Edit</th>
                        <th>Id</th>
                        <%--<th>Sr #</th>--%>
                        <th>Name</th>
                        <th style="display:none;">DOB</th>
                        <th>Father Name</th>
                        <th style="display:none;">Gender</th>           
                        <th>CNIC</th>
                        <th style="display:none;">Identification Mark</th>
                        <th style="display:none;">BLood Group</th>
                        <th style="display:none;">Address</th>
                        <th>Validity From</th>
                        <th>Validity To</th>
                        <th style="display:none;">Created By</th>
                        <th  style="display:none;">Created Date</th>
                        <th style="display:none;">Modified By</th>
                        <th style="display:none;">Modified Date</th>
                        <th>Clearance Level</th>
                        <th style="display:none;">Clearance Status</th>
                        <th style="display:none;">Auth Type</th>
                        <th style="display:none;">Status</th>
                        <th>Photo</th>
                        <th>Details</th>
                    </tr>
                </thead>
                <tbody id="tbodyBusinessCommunityDetails" style="background-color:white;">
                    <tr>
                        <td colspan="19">&nbsp;</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </fieldset>
        <fieldset id="fieldsetForm" style="display:none;">
            <legend>Business Community Detail Form</legend>
            <table id="tblBusinessCommunityDetail" class="form">
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

                    <td colspan="2" rowspan="5">
                         <div style="margin-right: 0px;float:right;">
                          <cc1:AsyncFileUpload OnClientUploadComplete="uploadComplete2" runat="server" ID="AsyncFileUpload1"
          Width="400px" UploaderStyle="Modern" ClientIDMode="AutoID" CompleteBackColor="White" UploadingBackColor="#CCFFFF" 
         ThrobberID="imgLoader"  OnUploadedComplete="FileUploadComplete" ToolTip="Click Here"   OnClientUploadStarted = "uploadStarted"/> 
                 <asp:HiddenField ID="hdnPictureId" runat="server" />
    <asp:Image ID="imgLoader" runat="server" ImageUrl="../images/loader.gif" /><br /><br />



 
                        <div class="dummy" id="divdummyClass" style="display:none; float: right; margin-right: 100px;">  
                            
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
                    <td class="right">Name:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtBusinessName" class="req alpha"  />
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
                    <td class="right">CNIC:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtCNIC" runat="server"  class="req" onblur="getBusinessCommunityDetailResultByCNIC();"/>
                    </td>
                </tr>
                <tr>
                    <td class="right">Designation:</td>
                    <td>
                        <input type="text" id="txtDesignation"/>
                    </td>
                </tr>
                <tr>
                    <td class="right">Father Name:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtFatherName" class="req alpha"  />
                    </td>
                    <td class="right"  style="width: 20%;">Date of Birth:</td>
                    <td  style="width: 30%;">
                        <asp:TextBox ID="txtDob" CssClass="date req"   runat="server" style="width:60%;float: left; margin-right: 5px;"></asp:TextBox>
                     <%--   <input type="text" id="txtValidFrom"  />--%>
                        <rjs:popcalendar ID="Popcalendar3" Separator="/" Format="mm dd yyyy" Control="txtDob" runat="server"
                                Font-Names="Tahoma" />                        
                    </td>
                </tr>
                <tr>
                    <td class="right"  style="width: 20%;">Address:</td>
                    <td  style="width: 30%;">
                        <input type="text" id="txtAddress"  />
                    </td>
                    <td class="right"  style="width: 20%;">Identification Mark:</td>
                    <td  style="width: 30%;">
                        <input type="text" id="txtIdentificationMark"  />                        
                    </td>
                </tr>
                <tr>
                    <td class="right" style="width: 20%;">Business Community Category:</td>
                    <td>
                        <asp:DropDownList ID="ddlBusinessCommunityCategoryName" runat="server" Width="94%">                        
                    </asp:DropDownList>
                    </td>
                    <td class="right" style="width: 20%;">Blood Group:</td>
                    <td>
                        <asp:DropDownList ID="ddlBloodGroup" runat="server" Width="94%">                        
                    </asp:DropDownList>
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
                    <td class="right">Authentication Type<span class="reqSpan">*</span></td>
                    <td>
                          <asp:DropDownList ID="BCAuthenticationType" runat="server">    
                              <asp:ListItem Value="1" Text="Card Only"></asp:ListItem>                    
                              <asp:ListItem Value="2" Text="Finger Only"></asp:ListItem>                    
                              <asp:ListItem Value="3" Text="Card Or Finger "></asp:ListItem>  
                              <asp:ListItem Value="4" Text="Card and Finger "></asp:ListItem>                    
                    </asp:DropDownList>

                        <%--From-Today="true"--%>
                    </td></tr>
            </table>
             <div class="btn-wrapper" style="padding-top: 20px;">
                  <input type="button" id="btnBackBusinessCommunityDetails" class="btn" value="Back" onclick="BackBusinessCommunityDetail();" />
           
            <input type="button" id="btnSaveBusinessCommunityDetails" class="btn" value="Save" onclick="saveBusinessCommunityDetail();" />
             <input type="button" id="btnClearBusinessCommunityDetails" class="btn" value="New" onclick="ClearBusinessCommunityDetail();" />
        </div>
        </fieldset>
       

    
    <script type="text/javascript">
        //------------------------------------------------------start  get BusinessCommunityDetail result on the basis of CNIC--------------


        $(document).ready(function () {

            $("#RecaptureBC").hide();
            $("#startbuttonBC").hide();
            $("#photoBC").hide();
            getBusinessCommunityDetails();


        });


        function getBusinessCommunityDetailResultByCNIC() {
            var VCNIC = $("input[id$='txtCNIC']").val();
            if ($("input[id$='txtId']").val() == "") {
                if ($("input[id$='txtCNIC']").val().indexOf('_') < 0) {


                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../RMS/RMSwebmethods.aspx/GetBusinessCommunityDetailResultByCNIC",
                        data: "{'VCNIC':'" + VCNIC + "'}",
                        success: onsuccessGetBusinessCommunityDetailResult,
                        error: onErrorGetBusinessCommunityDetailResult
                    });
                    return false;

                }



                else
                    return false;

            }


        }

        function onsuccessGetBusinessCommunityDetailResult(msg) {
            var data = msg.d;
            var result = data.GetBusinessCommunityDetailCountTable[0].Counts;
            if (parseInt(result) > 0) {
                alert("BusinessCommunityDetail already exist!");
                $("input[id$='txtCNIC']").val("");
                return false;
            }
        }

        function onErrorGetBusinessCommunityDetailResult() {


        }



        //--------------------------------------------------End of BusinessCommunityDetail result-----------------

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
                        url: '<%=ResolveUrl("~/RMS/RMSwebmethods.aspx/GetBusinessCommunityDetailReferenceName") %>',
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

                return;
            }
            else {
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
        }

        function clearResidentForm() {
            $("#txtCardNIC").val("");
            $("#txtNameSearch").val("");
            $("[id$='ddlStatusSearch']").val("");

        }

        function getBusinessCommunityDetails() {
            $("#fieldsetGrd").show();
            $("#fieldsetForm").hide();
            $("#tbodyBusinessCommunityDetails").html("");
            $.post("../RMS/CallBack/BusinessCommunityDetailHandler.aspx", { CNIC: $("#txtCardNIC").val(), Name: $("#txtNameSearch").val(), CStatus: $("[id$='ddlStatusSearch']").val() }).done(function (data) {
                var response = data;
                var start = data.indexOf("#StartBusinessCommunityDetails#") + 15;
                var end = data.indexOf("#EndBusinessCommunityDetails#");
                $("#tbodyBusinessCommunityDetails").html(response.substring(start, end));

                if ($("#tbodyBusinessCommunityDetails tr").length == 0) {
                    $("#tbodyBusinessCommunityDetails").html("<tr><td class='noRecordFound' colspan='19'>No Record Found</td></tr>");
                }
                //  alert($("#tbodyBusinessCommunityDetails tr").length);
                if ($("select[id$='ddlStatusSearch']").val() == "Active") {

                    $(".tdBusinessCommunityDetailInActive").css("display", "inline-block");
                    $(".tdBusinessCommunityDetailActive").css("display", "none");


                }
                else if ($("select[id$='ddlStatusSearch']").val() == "Inactive") {

                    $(".tdBusinessCommunityDetailInActive").css("display", "none");
                    $(".tdBusinessCommunityDetailActive").css("display", "inline-block");
                }
                else {
                    // for (i = 0; i <= $("#tbodyBusinessCommunityDetails tr").length; i++)
                    $("#tbodyBusinessCommunityDetails tr").each(function () {

                        if ($(this).find('.status').html() == "Active") {
                            $(this).find(".tdBusinessCommunityDetailInActive").css("display", "inline-block");
                            $(this).find(".tdBusinessCommunityDetailBlackList").css("display", "inline-block");
                            $(this).find(".tdBusinessCommunityDetailActive").css("display", "none");
                        }
                        else if ($(this).find('.status').html() == "InActive") {
                            $(this).find(".tdBusinessCommunityDetailActive").css("display", "inline-block");
                            $(this).find(".tdBusinessCommunityDetailBlackList").css("display", "inline-block");
                            $(this).find(".tdBusinessCommunityDetailInActive").css("display", "none");
                        }

                        else {
                            $(this).find(".tdBusinessCommunityDetailBlackList").css("display", "none");
                            $(this).find(".tdBusinessCommunityDetailBlackList").parent().parent().css("color", "Red");
                            $(this).find(".tdBusinessCommunityDetailBlackList").parent().parent().css("font-weight", "bold");
                            $(this).find(".tdBusinessCommunityDetailActive").css("display", "inline-block");
                            $(this).find(".tdBusinessCommunityDetailInActive").css("display", "inline-block");
                        }


                    });
                    // alert($("#tbodyBusinessCommunityDetails tr").find('.status').html());
                }
            });

        }
        function ShowDetails_Modal(VID, elm, flag) {

            $("#RecaptureBC").hide();
            $("#WebCamCallBC").hide();
            $("#WebCamCallBC").hide();
           


            
            $("#btnClearBusinessCommunityDetails").hide();
            $("#btnBackBusinessCommunityDetails").hide();
           

            editBusinessCommunityDetail(VID, elm, flag);

        }
        function CloseModal() {
            getBusinessCommunityDetails();
            $("#btnClearBusinessCommunityDetails").show();
            $("#btnBackBusinessCommunityDetails").show();
            $("#WebCamCallBC").show();
            //  Clear_Details();
            // alert("test");
            $("#fieldsetForm").jqmHide();
            $(".jqmWindow input, select").attr("disabled", false);
            return false;
        }


        function Clear() {

            $("div[id*='AsyncFileUpload1']").css("width", "400px");
            $("div[id*='AsyncFileUpload1']").css("margin-top", "-34px");
            $("input[id*='AsyncFileUpload1']").val("");
            $("input[id*='AsyncFileUpload1']").css("background-color", "");
            $("input[id$='hdnPictureId']").val("");
            // $("img[id$='imgDisplay']").hide();
            $("#dummy").addClass("dummy");
            $("#tblBusinessCommunityDetail input[type=text]").val("");
            $("#tblBusinessCommunityDetail select").val("");

            $("[id$='txtEmpID']").val("");



        }

        function ClearBusinessCommunityDetail() {
            Clear();
        }


        function editBusinessCommunityDetail(vid, elm, flag) {

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
                $("input[id$='btnSaveBusinessCommunityDetails']").hide();
                $("div[id*='AsyncFileUpload1']").hide();
                $('#fieldsetForm').jqm({ modal: true, overlay: 75, trigger: false });
                $('#fieldsetForm').jqmShow();
            }
            else {
                $('#fieldsetForm').css("margin-left", "0%");
                $('#fieldsetForm').css("width", "97%");
                $('#trClose').hide();
                $("img[src$='btn_close02.png']").hide();
                $("input[id$='btnSaveBusinessCommunityDetails']").show();
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
            $("[id$='txtBusinessName']").val($.trim($(elm).closest("tr").find(".BCDName").html()));
            $("[id$='txtDob']").val($.trim($(elm).closest("tr").find(".Dob").html()));
            $("[id$='txtFatherName']").val($.trim($(elm).closest("tr").find(".FatherName").html()));
            $("[id$='ddlGender']").val($.trim($(elm).closest("tr").find(".Gender").html()));
            $("[id$='txtCNIC']").val($.trim($(elm).closest("tr").find(".CNIC").html()));
            $("[id$='txtDesignation']").val($.trim($(elm).closest("tr").find(".Designation").html()));
            $("[id$='txtIdentificationMark']").val($.trim($(elm).closest("tr").find(".IdentificationM").html()));

            $("[id$='ddlBusinessCommunityCategoryName']").val($.trim($(elm).closest("tr").find(".BusinessCommunityCat").html()));
            $("[id$='ddlBloodGroup']").val($.trim($(elm).closest("tr").find(".BloodGroup").html()));
            $("[id$='txtAddress']").val($.trim($(elm).closest("tr").find(".Address").html()));
            $("[id$='ddlClearanceStatus']").val($.trim($(elm).closest("tr").find(".ClearanceStatus").html()));
            $("[id$='ddlLevel']").val($.trim($(elm).closest("tr").find(".ClearanceLevel").html()));
            $("[id$='txtValidFrom']").val($.trim($(elm).closest("tr").find(".ValidFrom").html()));
            $("[id$='txtValidTo']").val($.trim($(elm).closest("tr").find(".ValidTo").html()));
            $("[id$='BCAuthenticationType']").val($.trim($(elm).closest("tr").find(".AuthType").html()));
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
        function saveBusinessCommunityDetail() {

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
            if (!validate("fieldsetForm")) {
                var CId = $.trim($("[id$='txtId']").val()) == "" ? 0 : $.trim($("[id$='txtId']").val());
                var request = "{"
                    + "'CID':'" + CId + "',"
                    + "'BCDName':'" + $.trim($("[id$='txtBusinessName']").val()) + "',"
                    + "'Gender':'" + $.trim($("[id$='ddlGender']").val()) + "',"
                    + "'CNIC':'" + $.trim($("[id$='txtCNIC']").val()) + "',"
                    + "'Designation':'" + $.trim($("[id$='txtDesignation']").val()) + "',"
                    + "'FatherName':'" + $.trim($("[id$='txtFatherName']").val()) + "',"
                    + "'Dob':'" + $.trim($("[id$='txtDob']").val()) + "',"
                    + "'Address':'" + $.trim($("[id$='txtAddress']").val()) + "',"
                    + "'IdentificationM':'" + $.trim($("[id$='txtIdentificationMark']").val()) + "',"
                    + "'BusinessCommunityCat':'" + $.trim($("[id$='ddlBusinessCommunityCategoryName']").val()) + "',"
                    + "'BloodGroup':'" + $.trim($("[id$='ddlBloodGroup']").val()) + "',"
                    + "'CLearanceStatus':'" + $.trim($("[id$='ddlClearanceStatus']").val()) + "',"
                    + "'ClearanceLevel':'" + $.trim($("[id$='ddlLevel']").val()) + "',"
                    + "'ValidFrom':'" + $.trim($("[id$='txtValidFrom']").val()) + "',"
                    + "'ValidTo':'" + $.trim($("[id$='txtValidTo']").val()) + "',"
                    + "'AuthType':'" + $.trim($("[id$='BCAuthenticationType']").val()) + "',"
                    + "'Photo':'" + img + "'"
                    + "}";

                $.ajax({
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json",
                    url: "../RMS/RMSWebMethod.aspx/SaveBusinessCommunityDetailInfo",
                    data: request,
                    success: function (data) {
                        showSuccessMsg("Information saved successfully!");
                        getBusinessCommunityDetails();
                        $("#txtId").val(data.d);
                        Clear();
                    }
                });
            }

        }

        function startRefresh() {
            setTimeout(startRefresh, 1000);
            getBusinessCommunityDetails();
        }
        function addNewBusinessCommunityDetail() {

            $('#fieldsetForm').css("margin-left", "0%");
            $('#fieldsetForm').css("width", "97%");
            $('#trClose').hide();
            $("img[src$='btn_close02.png']").hide();
            $("input[id$='btnSaveBusinessCommunityDetails']").show();
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

            $("#tblBusinessCommunityDetail input[type=text]").val("");
            $("input[id$='hdnPictureId']").val("")
            $("#tblBusinessCommunityDetail select").val("");
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



        //---------------------------------------------Delete BusinessCommunityDetail Record------------------------------------------
        function InActiveBusinessCommunityDetail(VID) {

            if (confirm("Are you sure you wish to Inactive this Record?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../RMS/RMSWebMethod.aspx/InActiveBusinessCommunityDetailRecord",
                    data: "{'VID':'" + VID + "'}",
                    success: onsuccessInActiveBusinessCommunityDetailRecord
                });

                return false;
            }
            else
                return false;
        }


        function onsuccessInActiveBusinessCommunityDetailRecord(msg) {
            //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("User has been Inactivated Successfully!");
            getBusinessCommunityDetails();
            return false;
        }

        //---------------------------------------------Activate BusinessCommunityDetail Record------------------------------------------
        function ActivatePACSBusinessCommunityDetail(VID) {

            if (confirm("Are you sure you wish to Activate this User?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../RMS/RMSWebMethod.aspx/ActivateBusinessCommunityDetailRecord",
                    data: "{'VID':'" + VID + "'}",
                    success: onsuccessDeleteBusinessCommunityDetails
                });

                return false;
            }
            else
                return false;
        }


        function onsuccessDeleteBusinessCommunityDetails(msg) {
            //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("User has been Activated Successfully!");
            getBusinessCommunityDetails();
            return false;
        }

        //----------------------------------------Black List Visistor---------------------------------------------------------------------------------------

        function BlackListPACSBusinessCommunityDetail(VID) {
            if (confirm("Are you sure you wish to Black List this User?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../RMS/RMSWebMethod.aspx/BlackListBusinessCommunityDetailRecord",
                    data: "{'VID':'" + VID + "'}",
                    success: onsuccessBlackListBusinessCommunityDetail
                });

                return false;
            }
            else
                return false;
        }


        function onsuccessBlackListBusinessCommunityDetail(msg) {
            //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("User has been Black Listed Successfully!");
            getBusinessCommunityDetails();
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


        function BackBusinessCommunityDetail() {
            getBusinessCommunityDetails();
        }




        ////////////////////////WebCam Business Comm ///////
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

