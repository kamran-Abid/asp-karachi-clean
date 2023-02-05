<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="Visitors.aspx.cs" Inherits="RMS_Visitors" %>

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
            <legend>Visitor Search Criteria</legend>
            <table class="form">
                <tr>
                    <td class="right" style="width: 10%;">Card/NIC:</td>
                    <td style="width: 22%;">
                        <input type="text"  id="txtCardNIC" />
                    </td>
                    <td class="right" style="width: 10%;">Name:</td>
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
                        <input type="button" id="btnSearch" class="btn" value="Search" onclick="getVisitors();" />
                        <input type="button" id="btnClear" class="btn" value="Clear" onclick="clearResidentForm()" />
                    </td>
                </tr>
            </table>
        </fieldset>
        <div style="padding: 10px;">
        <input type="button" id="btnAddNew" class="btn" value="Add Visitor" onclick="addNewVisitor();" />
    </div>
        <fieldset id="fieldsetGrd" style="width: 97%;">
        <legend>Visitors</legend>
        <div style="padding-bottom:20px;max-width:1208px;max-height:440px;overflow: auto;">            
            <table class="dataTable">
                <thead>
                    <tr>
                        <th>Action</th>
                        <th>Edit</th>
                        <th>Card #</th>
                        <th style="display:none;">First Name</th>
                        <th  style="display:none;">Last Name</th>  
                        <th>Name</th>           
                        <th>NIC</th>
                        <th  style="display:none;">Phone</th>                        
                        <th style="display:none;">Mobile</th>                        
                        <th style="display:none;">Address</th>
                        <th style="display:none;">Job/Study</th>
                        <th>Visit Purpose</th>
                        <th style="display:none;">Visit Days</th>
                        <th>Issue Date</th>
                        <th>Valid Upto</th>
                        <th style="display:none;">Reference Name</th>
                        <th style="display:none;">Relation</th>
                        <th style="display:none;">Rank</th>
                        <th>Reference</th> 
                        <th>Status</th>
                         <th>Photo</th> 
                        <th>Detail</th> 
                    </tr>
                </thead>
                <tbody id="tbodyVisitors" style="background-color:white;">
                    <tr>
                        <td colspan="19">&nbsp;</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </fieldset>
        <fieldset id="fieldsetForm" style="display:none;">
            <legend>Personal</legend>
            <table id="tblVisitor" class="form">
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



 </div>
                        <div class="dummy" id="divdummyClass" style="float: right; margin-right: 100px;">  
                             <img id = "imgDisplay" alt="" src="" style = "display:none;height:100px;width:100px;"/>

                        </div>
                    </td>
                </tr>                
                <tr>
                    <td class="right">First Name:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtFirstName" class="req alpha"  />
                    </td>
                </tr>
                <tr>
                    <td class="right">Last Name:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtLastName"  class="req alpha" />
                    </td>
                </tr>
                <tr>
                    <td class="right">NIC:<span class="reqSpan">*</span></td>
                    <td>
                        <input type="text" id="txtNIC"  class="req cnic" onblur="getVisitorResultByCNIC();"/>
                    </td>                    
                </tr>
                <tr>
                    <td class="right"  style="width: 20%;">Visit Purpose:</td>
                    <td  style="width: 30%;">
                        <input type="text" id="txtVisitPurposr"  />                        
                    </td>                    
                    <td class="right"  style="width: 20%;">Address:</td>
                    <td  style="width: 30%;">
                        <input type="text" id="txtAddress"  />
                    </td>

                </tr>
                <tr>
                    <td class="right">Job/Study Location:</td>
                    <td>
                        <input type="text" id="txtJobStudyLoc"  />
                    </td>
                    <td class="right">Phone #:</td>
                    <td>
                        <input type="text" id="txtPhone" class="phone"  />
                    </td>
                </tr>
                <tr>
                    <td class="right">Issue Date:<span class="reqSpan">*</span></td>
                    <td>
                        
                            <asp:TextBox ID="txtIssueDate" CssClass="date req"  runat="server" style="width:60%;float: left; margin-right: 5px;" onblur="getDayFromTwoDates();"></asp:TextBox>
                         <rjs:popcalendar ID="Popcalendar2" Separator="/" Format="mm dd yyyy" Control="txtIssueDate" runat="server"
                                Font-Names="Tahoma"  />
                    </td>
                    <td class="right">Cell #:</td>
                    <td>
                        <input type="text" id="txtCellNo" class="cell"  />
                    </td>
                </tr>
                <tr>
                    <td class="right">Validity Date:<span class="reqSpan">*</span></td>
                    <td>
                        
                            <asp:TextBox ID="txtValidityDate" CssClass="date req"   runat="server" style="width:60%;float: left; margin-right: 5px;" onblur="getDayFromTwoDates();" ></asp:TextBox>
                         <rjs:popcalendar ID="Popcalendar1" Separator="/" Format="mm dd yyyy" Control="txtValidityDate" runat="server"
                                Font-Names="Tahoma" />
                    </td>                    
                    <td colspan="2" style="text-align:right; padding-right:10px;">
                        <input type="radio" checked="checked" name="EmpRef" id="chkWithRef" value="Employee Reference" onclick="enableDisableRef('E')" /><label for="chkWithRef">Employee Reference</label> 
                        <input type="radio" name="EmpRef" id="chkWithoutRef" value="Without Reference" onclick="enableDisableRef('D')"  /><label for="chkWithoutRef">Without Reference</label>

                    </td>

                </tr>
                <tr>
                    <td class="right">Days:</td>
                    <td>
                        <input type="text" id="txtDays" disabled="disabled"  />
                    </td>

                    <td class="right"><div id="divReferName">Name: <span id="spnName" class="reqSpan" >*</span></div></td>
                    <td>
                        <input type="text" id="txtReferenceName" disabled="disabled" />

                         <asp:HiddenField ID="hfCustomerId" runat="server" />
                    <%--    <asp:HiddenField ID="ddlType" Value="1" runat="server" />--%>
                    </td>
                </tr>
                <tr>
                    <td style="display:none"class="right">Service Code/PNO:</td>
                    <td style="display:none">
                        <input type="text" id="txtPNO"  />
                    </td>
                     <td class="right">Card No:</td>
                    <td>
                        <input type="text" id="txtCardNo" disabled="disabled"  />
                    </td>
                    <td class="right">Relation:</td>
                    <td>
                        <asp:DropDownList ID="ddlRelation" runat="server" >                        
                    </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                   <td colspan="2">&nbsp;</td>
                    <td class="right">Rank:</td>
                    <td>
                       <asp:DropDownList ID="ddlRank" runat="server">                            
                        </asp:DropDownList>
                    </td>
                </tr>

                  <tr>
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
                </tr>
            </table>
             <div class="btn-wrapper" style="padding-top: 20px;">
            <input type="button" id="btnSaveVisitors" class="btn" value="Save" onclick="saveVisitors();" />
             <input type="button" id="btnClearVisitors" class="btn" value="New" onclick="ClearVisitor();" />
        </div>
        </fieldset>
       

    
    <script type="text/javascript">
        //------------------------------------------------------start  get Visitor result on the basis of CNIC--------------

        function getVisitorResultByCNIC() {
            var VCNIC = $("input[id$='txtNIC']").val();
            if ($("input[id$='txtId']").val() == "") {
                if ($("input[id$='txtNIC']").val().indexOf('_') < 0) {


                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../RMS/RMSwebmethods.aspx/GetVisitorResultByCNIC",
                        data: "{'VCNIC':'" + VCNIC + "'}",
                        success: onsuccessGetVisitorResult,
                        error: onErrorGetvisitorResult
                    });
                    return false;

                }



                else
                    return false;

            }


        }

        function onsuccessGetVisitorResult(msg) {
            var data = msg.d;
            var result = data.GetVisitorCountTable[0].Counts;
            if (parseInt(result) > 0) {
                alert("Visitor already exist!");
             $("input[id$='txtNIC']").val("");
                return false;
            }
        }

        function onErrorGetvisitorResult() {


        }



        //--------------------------------------------------End of Visitor result-----------------

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
                        url: '<%=ResolveUrl("~/RMS/RMSwebmethods.aspx/GetVisitorReferenceName") %>',
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
                            alert(response.responseText);
                        },
                        failure: function (response) {
                            alert(response.responseText);
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

            //var a = $("input[id$='txtimangeName']").val();
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

        function getVisitors() {
            $("#fieldsetGrd").show();
            $("#fieldsetForm").hide();
            $("#tbodyVisitors").html("");
            $.post("../RMS/CallBack/VisitorsHandler.aspx", { NIC: $("#txtCardNIC").val(), Name: $("#txtNameSearch").val(), Status: $("[id$='ddlStatusSearch']").val() }).done(function (data) {
                var response = data;
                var start = data.indexOf("#StartVisitors#") + 15;
                var end = data.indexOf("#EndVisitors#");
                $("#tbodyVisitors").html(response.substring(start, end));

                if ($("#tbodyVisitors tr").length == 0) {
                    $("#tbodyVisitors").html("<tr><td class='noRecordFound' colspan='19'>No Record Found</td></tr>");
                }
                //  alert($("#tbodyVisitors tr").length);
                if ($("select[id$='ddlStatusSearch']").val() == "Active") {
                 
                    $(".tdVisitorInActive").css("display", "inline-block");
                    $(".tdVisitorActive").css("display", "none");


                }
                else if ($("select[id$='ddlStatusSearch']").val() == "Inactive") {
                  
                    $(".tdVisitorInActive").css("display", "none");
                    $(".tdVisitorActive").css("display", "inline-block");
                }
                else {
                    // for (i = 0; i <= $("#tbodyVisitors tr").length; i++)
                    $("#tbodyVisitors tr").each(function () {
                        
                        if ($(this).find('.status').html() == "Active") {
                            $(this).find(".tdVisitorInActive").css("display", "inline-block");
                            $(this).find(".tdVisitorBlackList").css("display", "inline-block");
                            $(this).find(".tdVisitorActive").css("display", "none");
                        }
                        else if ($(this).find('.status').html() == "InActive") {
                            $(this).find(".tdVisitorActive").css("display", "inline-block");
                            $(this).find(".tdVisitorBlackList").css("display", "inline-block");
                            $(this).find(".tdVisitorInActive").css("display", "none");
                        }

                        else {
                            $(this).find(".tdVisitorBlackList").css("display", "none");
                            $(this).find(".tdVisitorBlackList").parent().parent().css("color", "Red");
                            $(this).find(".tdVisitorBlackList").parent().parent().css("font-weight", "bold");
                            $(this).find(".tdVisitorActive").css("display", "inline-block");
                            $(this).find(".tdVisitorInActive").css("display", "inline-block");
                        }


                    });
                    // alert($("#tbodyVisitors tr").find('.status').html());
                }
            });
            
        }
        function ShowDetails_Modal(VID, elm, flag) {



            editVisitor(VID, elm, flag);

        }
        function CloseModal() {
            //  Clear_Details();
            // alert("test");
            $("#fieldsetForm").jqmHide();
            $(".jqmWindow input, select").attr("disabled", false);
            return false;
        }

        function ClearVisitor() {
            $("div[id*='AsyncFileUpload1']").css("width", "400px");
            $("div[id*='AsyncFileUpload1']").css("margin-top", "-34px");
            $("input[id*='AsyncFileUpload1']").val("");
            $("input[id*='AsyncFileUpload1']").css("background-color", "");
            $("input[id$='hdnPictureId']").val("");
            $("img[id$='imgDisplay']").hide();
            $("#dummy").addClass("dummy");
            $("#tblVisitor input[type=text]").val("");
            $("#tblVisitor select").val("");

            $("[id$='txtEmpID']").val("");

        }


        function editVisitor(vid, elm,flag) {
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
                $("input[id$='btnSaveVisitors']").hide();
                $("div[id*='AsyncFileUpload1']").hide();
                $('#fieldsetForm').jqm({ modal: true, overlay: 75, trigger: false });
                $('#fieldsetForm').jqmShow();
            }
            else {
                $('#fieldsetForm').css("margin-left", "0%");
                $('#fieldsetForm').css("width", "97%");
                $('#trClose').hide();
                $("img[src$='btn_close02.png']").hide();
                $("input[id$='btnSaveVisitors']").show();
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
            $("[id$='txtFirstName']").val($.trim($(elm).closest("tr").find(".fn").html()));
            $("[id$='txtLastName']").val($.trim($(elm).closest("tr").find(".ln").html()));
            $("[id$='txtNIC']").val($.trim($(elm).closest("tr").find(".nic").html()));
            $("[id$='txtVisitPurposr']").val($.trim($(elm).closest("tr").find(".vPurpose").html()));
            $("[id$='txtAddress']").val($.trim($(elm).closest("tr").find(".Addr").html()));
            $("[id$='txtJobStudyLoc']").val($.trim($(elm).closest("tr").find(".prof").html()));
            $("[id$='txtPhone']").val($.trim($(elm).closest("tr").find(".phone").html()));
            $("[id$='txtIssueDate']").val($.trim($(elm).closest("tr").find(".issueDt").html()));
            $("[id$='txtCellNo']").val($.trim($(elm).closest("tr").find(".mobile").html()));
            $("[id$='txtValidityDate']").val($.trim($(elm).closest("tr").find(".vldDate").html()));
            $("[id$='txtDays']").val($.trim($(elm).closest("tr").find(".vDays").html()));
            $("[id$='txtReferenceName']").val($.trim($(elm).closest("tr").find(".refName").html()));
           // $("[id$='txtPNO']").val($.trim($(elm).closest("tr").find(".cardNo").html()));
            $("[id$='ddlRelation']").val($.trim($(elm).closest("tr").find(".rel").html()));
            $("[id$='txtCardNo']").val($.trim($(elm).closest("tr").find(".cardNo").html()));
            $("[id$='ddlRank']").val($.trim($(elm).closest("tr").find(".rank").html()));
            $("[id$='ddlDesignation']").val($.trim($(elm).closest("tr").find(".desgId").html()));
            $("[id$='txtAddressRef']").val($.trim($(elm).closest("tr").find(".refAdd").html()));
            $("[id$='txtEmpID']").val($.trim($(elm).closest("tr").find(".empID").html()));

            if($.trim($(elm).closest("tr").find(".refName").html()) !="")
            {
                $("#chkWithRef").attr("checked", "checked");
                $("#txtReferenceName").removeAttr("disabled"); 
            }
            else
            {                
                $("#chkWithoutRef").attr("checked", "checked");
                $("#txtReferenceName").attr("disabled", "disabled");
            }

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
        function saveVisitors() {

            if ($("input[id$='hdnPictureId']").val().indexOf(":") >= 0) {
                $("input[id$='hdnPictureId']").val("");

            }
            if ($("[id$='txtReferenceName']").val() == "" && $("input[id$='chkWithRef']").is(":checked") == true) {
                alert("Enter Reference or click on Without Reference!");
                return false;
            }

            if ($("[id$='txtEmpID']").val() == "" && $("input[id$='chkWithRef']").is(":checked") == true) {
                alert("Enter Reference or click on Without Reference!");
                return false;
            }
            if (!validate("fieldsetForm")) {
                var vId = $.trim($("[id$='txtId']").val()) == "" ? 0 : $.trim($("[id$='txtId']").val());
                var refName = "";
                if ($("#chkWithRef").is(":checked"))
                {
                    refName = $("#txtReferenceName").val();
                }
                var request = "{"
                    + "'VID':'" + vId + "',"
                    + "'FirstName':'" + $.trim($("[id$='txtFirstName']").val()) + "',"
                    + "'LastName':'" + $.trim($("[id$='txtLastName']").val()) + "',"
                    + "'NIC':'" + $.trim($("[id$='txtNIC']").val()) + "',"
                    + "'VisitPurpose':'" + $.trim($("[id$='txtVisitPurposr']").val()) + "',"
                    + "'Addr':'" + $.trim($("[id$='txtAddress']").val()) + "',"
                    + "'Profession':'" + $.trim($("[id$='txtJobStudyLoc']").val()) + "',"
                    + "'Phone':'" + $.trim($("[id$='txtPhone']").val()) + "',"
                    + "'IssueDt':'" + $.trim($("[id$='txtIssueDate']").val()) + "',"
                    + "'Mobile':'" + $.trim($("[id$='txtCellNo']").val()) + "',"
                    + "'ValidUpto':'" + $.trim($("[id$='txtValidityDate']").val()) + "',"
                    + "'ReferenceName':'" + refName + "',"
                    + "'VisitDays':'" + $.trim($("[id$='txtDays']").val()) + "',"
                    //+ "'Religion':'" + $.trim($("[id$='txtPNO']").val()) + "',"
                    + "'Relation':'" + $.trim($("[id$='ddlRelation']").val()) + "',"
                    + "'Rank':'" + $.trim($("[id$='ddlRank']").val()) + "',"
                    + "'ReferenceAdd':'" + $.trim($("[id$='txtAddressRef']").val()) + "',"
                    + "'Photo':'" + $.trim($("[id$='hdnPictureId']").val()) + "',"
                    + "'Designation':'" + $.trim($("[id$='ddlDesignation']").val()) + "',"
                     + "'empID':'" + $.trim($("[id$='txtEmpID']").val()) + "'"

              
                    + "}";

                $.ajax({
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json",
                    url: "../RMS/RMSWebMethod.aspx/SaveVisitor",
                    data: request,
                    success: function (data) {
                        showSuccessMsg("Information saved successfully!");
                         getVisitors();
                        $("#txtId").val(data.d);
                    }
                });
            }
          
        }

        function startRefresh() {
            setTimeout(startRefresh, 1000);
            getVisitors();
        }
        function addNewVisitor() {

            $('#fieldsetForm').css("margin-left", "0%");
            $('#fieldsetForm').css("width", "97%");
            $('#trClose').hide();
            $("img[src$='btn_close02.png']").hide();
            $("input[id$='btnSaveVisitors']").show();
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

            $("#tblVisitor input[type=text]").val("");
            $("input[id$='hdnPictureId']").val("")
            $("#tblVisitor select").val("");
        }
        function enableDisableRef(elem) {
            if(elem=="E")
            {
                $("#txtReferenceName").addClass("req");
                $("#spnName").text("*")
                $("#txtReferenceName").removeAttr("disabled");
                $("select[id$='ddlRelation']").attr("disabled", false)
                $("select[id$='ddlRank']").attr("disabled", true)
                $("select[id$='ddlDesignation']").attr("disabled", true)
                $("#txtAddressRef").attr("disabled", true);
            }
            else
            {
                $("#spnName").text("")
                $("#txtReferenceName").removeClass("req");
                $("#txtReferenceName").attr("disabled", "disabled");
                $("select[id$='ddlRelation']").attr("disabled", true)
                $("select[id$='ddlRank']").attr("disabled", true)
                $("select[id$='ddlDesignation']").attr("disabled", true)
                $("#txtAddressRef").attr("disabled", true);
                emptyFieldsOfReference();
            }


        }



        //---------------------------------------------Delete Visitor Record------------------------------------------
        function InActiveVisitor(VID) {

            if (confirm("Are you sure you wish to Inactive this Record?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../RMS/RMSWebMethod.aspx/InActiveVisitorRecord",
                    data: "{'VID':'" + VID + "'}",
                    success: onsuccessInActiveVisitorRecord
                });

                return false;
            }
            else
                return false;
        }


        function onsuccessInActiveVisitorRecord(msg) {
            //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("User has been Inactivated Successfully!");
            getVisitors();
            return false;
        }

        //---------------------------------------------Activate Visitor Record------------------------------------------
        function ActivatePACSVisitor(VID) {

            if (confirm("Are you sure you wish to Activate this User?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../RMS/RMSWebMethod.aspx/ActivateVisitorRecord",
                    data: "{'VID':'" + VID + "'}",
                    success: onsuccessDeleteVisitors
                });

                return false;
            }
            else
                return false;
        }


        function onsuccessDeleteVisitors(msg) {
            //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("User has been Activated Successfully!");
            getVisitors();
            return false;
        }

        //----------------------------------------Black List Visistor---------------------------------------------------------------------------------------

        function BlackListPACSVisitor(VID) {
            if (confirm("Are you sure you wish to Black List this User?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../RMS/RMSWebMethod.aspx/BlackListVisitorRecord",
                    data: "{'VID':'" + VID + "'}",
                    success: onsuccessBlackListVisitor
                });

                return false;
            }
            else
                return false;
        }


        function onsuccessBlackListVisitor(msg) {
            //$("#divMsg").html("Record deleted Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("User has been Black Listed Successfully!");
            getVisitors();
            return false;
        }


        //-------------------------------------------------Get Day from two dates----------------------------------------------------------


        function getDayFromTwoDates()
        {
            if ($("input[id$='txtIssueDate']").val().trim() != "" && $("input[id$='txtValidityDate']").val() != "")
                {
            var oneDay = 24 * 60 * 60 * 1000; // hours*minutes*seconds*milliseconds
            var firstDate = new Date($("input[id$='txtIssueDate']").val());
            var secondDate = new Date($("input[id$='txtValidityDate']").val());

            var diffDays = Math.round(Math.abs((firstDate.getTime() - secondDate.getTime()) / (oneDay)));
            $("input[id$='txtDays']").val(diffDays);
           // alert(diffDays);
            }
        }

    </script>
</asp:Content>

