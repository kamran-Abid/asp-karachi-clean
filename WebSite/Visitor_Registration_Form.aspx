

<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="Visitor_Registration_Form.aspx.cs" Inherits="Visitor_Registration_Form" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>




<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        label {
            /*padding-left:10px;
            padding-right:5px;*/
            align-content: center;
            color: #0c5d52;
        }

        .center {
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .form-input {
            width: 150px;
            padding: 10px;
            background: #e0e2e1;
            border: 0.5px;
        }

            .form-input input {
                display: none;
            }

            .form-input label {
                display: block;
                width: 100%;
                height: 50px;
                line-height: 50px;
                text-align: center;
                background: #23395a;
                color: #fff;
                font-size: 15px;
                font-family: "Open Sans",sans-serif;
                text-transform: Uppercase;
                font-weight: 600;
                border-radius: 10px;
                cursor: pointer;
            }

            .form-input img {
                width: 158px;
                display: none;
                margin-top: 10px;
            }
            
        
                
               
        
                
               
                
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager runat="server"></asp:ScriptManager>

     <%--Timer for headcount--%>
    <div style="display:none;">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
        <asp:Timer ID="HeadCountTimer" runat="server" Interval="60000"></asp:Timer><%--OnTick="HeadCountTimer_Tick"--%>
    </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <%--Timer for headcount--%>

    <div id="Searchdiv" style="overflow: auto; width:99%; height: 100%;" runat="server"> 
            <fieldset id="Fieldset1" runat="server" style="width: 97%">
            <legend>Search Visitor</legend>
                <table id="Searchtbl" class="dataTable1" style="width:95%;">
                    <tr>
                        <td style="width:30%; float:left;"><asp:Label ID="searchlbl" runat="server" Text="Enter Unique ID # or CNIC # to Search" ></asp:Label></td>
                        <td style="width:30%; float:left;"><asp:TextBox ID="searchTxt" Placeholder="Enter CNIC with Dashes(-) OR ID" runat="server"></asp:TextBox></td>
                        <td style="width:20%; float:left;"><asp:Button ID="btnSearchVisitor" runat="server" OnClientClick="return SearchVisitor();" Text="Search Visitor" Style="width: 180px; height: 35px; background-color: forestgreen; color: #fff; font-family: OpenSans,sans-serif; font-size: 15px; text-transform: Uppercase; font-weight: 600; border-radius: 10px;float:left; border-radius:15px;  cursor: pointer;"/></td>
                        <td style="width:10%; float:left;"><asp:Button ID="BtnClear" runat="server" OnClientClick="return cleartbl();" Text="Clear" Style="width: 180px; height: 35px; background-color: forestgreen; color: #fff; font-family: OpenSans,sans-serif; font-size: 15px; text-transform: Uppercase; font-weight: 600; border-radius: 10px;float:left; border-radius:15px;  cursor: pointer;"/></td>
                    </tr>
                    </table>
        </fieldset>
        </div>
    
        <div id="div1" style="overflow: auto; width:99%; height: 100%;" runat="server"> 
            <fieldset id="Fieldset2" runat="server" style="width: 97%">
            <legend>Personal Info</legend>
               <%-- <h5><span class="reqSpan">Note: Fields marked with asterisk (* ) are required.</span></h5>--%>
                <table id="Personalbl" class="dataTable1" style="width:100%;">
                    <tr>
                        <%--<span class="reqSpan">*</span>--%>
                        <td style=""><asp:Label ID="Label21" runat="server" Text="ID"></asp:Label></td>
                        <td><asp:TextBox ID="TextBox19" runat="server" onblur="getVisitorByID()"></asp:TextBox></td>
                        <td style=""></td>
                        <td style=" float:right;"><input type="file"  onclick="upload()" id="f_UploadImage"/></td>
                        <td  colspan="2" rowspan="4"><img id="myUploadedImg" style="width:150px; height:150px; margin-left: 34%;" alt="" /></td>
                    </tr>
                    <tr>
                        <td style=""><asp:Label ID="lblFullName" runat="server">Name:<span class="reqSpan">*</span></asp:Label></td>
                        <td><asp:TextBox ID="tbFullName" runat="server"></asp:TextBox></td>
                        <td style=""><asp:Label ID="lblFatherName" runat="server" Text="Father Name:"></asp:Label></td>
                        <td style=""><asp:TextBox ID="tbFatherName" runat="server"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td style=""><asp:Label ID="lblCNIC" runat="server">CNIC:<span class="reqSpan">*</span></asp:Label></td>
                        <%--<td style="">
                        <input type="text" runat="server" id="TxtCNIC" class="req" onblur="getVisitorByCNIC();" />--%>
                        <td><asp:TextBox ID="TxtCNIC" runat="server"  onblur="getVisitorByCNIC()"></asp:TextBox>
                <ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender1" runat="server"
                 MaskType="Number" Mask="99999-9999999-9" TargetControlID="TxtCNIC"
                 MessageValidatorTip="true" ClearMaskOnLostFocus="false"/></td>
                        <td style=""><asp:Label ID="Label1" runat="server" Text="DoB:"></asp:Label></td>
                        <td style=""><asp:TextBox ID="TextBox1" runat="server" TextMode="Date"></asp:TextBox></td>
                        
                    </tr>
                    <tr>
                       <%-- remove RFV  from Address--%>
                        <td style=" "><asp:Label ID="Label2" runat="server" Text="Address:"></asp:Label></td> 
                        <td><asp:TextBox ID="TextBox8" runat="server" Width="330px"></asp:TextBox></td>
                        <td style=" "><asp:Label ID="Label13" runat="server" Text="Mobile #" ></asp:Label></td>
                        <td style=" "><asp:TextBox ID="TextBox9" runat="server"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td style=" "><asp:Label ID="Label10" runat="server" Text="Organization:"></asp:Label></td>
                        <td><asp:TextBox ID="TextBox4" runat="server"></asp:TextBox></td>
                          <td style=" "><asp:Label ID="Label9" runat="server" Text="Email ID:"></asp:Label></td>
                        <td style=" "><asp:TextBox ID="TextBox3" runat="server"></asp:TextBox></td>
                        <td style=" "><asp:Label ID="Label18" runat="server" Visible="false">Visitor Employee:<span class="reqSpan">*</span></asp:Label></td>
                        <td style=" "><asp:TextBox ID="TextBox10" Visible="false" runat="server"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td style=" "><asp:Label ID="Label8" runat="server" Visible="false" Text="Passport No:"></asp:Label></td>
                        <%--Remove RFV From Passport no.--%>
                        <td><asp:TextBox ID="TextBox2" Visible="false" runat="server"></asp:TextBox></td>
                      
                            
                    </tr>
                </table>
            </fieldset>
        </div>
        

        <div id="ReqInfo" style="overflow: visible; width:99%; height: 100%;" runat="server"> 
            <fieldset id="Fieldset5" runat="server" style="width: 97%">
                <legend>Employee/Host Information</legend>
                 <input type="hidden" id="fname1" name="fname1" />
                <table id="Reqtbl" class="dataTable1"">
                <tr>
                   <td><asp:Label ID="Label3" runat="server" Text="Employee:"></asp:Label></td>
                   <td><asp:DropDownList ID="DropDownList1" runat="server"  Width="270px" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                   </td>
                   <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="Label11" runat="server" Text="Designation:"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                   <td>
                            <%--<asp:TextBox ID="TextBox7" runat="server"></asp:TextBox>--%>
                   <asp:DropDownList ID="DDLDesignation" runat="server" Width="270px"></asp:DropDownList>
                      </td>  
                    <td class="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Department: &nbsp;&nbsp;&nbsp;</td>
                    <td>
                        <asp:DropDownList ID="ddlDeptUnit" runat="server" Width="270px">                            
                        </asp:DropDownList>
                    </td>
                </tr>
                    <tr>
                        <td><asp:Label ID="Label5" runat="server" Text="Visit Purpose:" Width="140px"></asp:Label></td>
                    <%--<td><asp:DropDownList ID="DropDownList3" runat="server" 
                    Style="background-color: Lavender;font-family: Calibri;"></asp:DropDownList></td>--%>
                    <td><asp:TextBox ID="VisitPurpose" runat="server" Width="255px"></asp:TextBox></td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label6" runat="server" Text="Visit Date:"></asp:Label></td>
                        <td><asp:TextBox ID="TextBox5" runat="server" TextMode="Date" Width="260px"></asp:TextBox></td>
                        
                        </tr>
                    <tr>
                        <td><asp:Label ID="Label4" Visible="false" runat="server" Text="Floor:"></asp:Label></td>
                        <td><asp:DropDownList ID="DropDownList2" Visible="false" runat="server" 
                    Style="background-color: Lavender;font-family: Calibri;" onchange="return getCompaniesName();"></asp:DropDownList></td>
                        <td><asp:Label ID="Label7" Visible="false" runat="server" Text="Company Name:" ></asp:Label></td>
                        <td>
                            <%--<asp:TextBox ID="TextBox6" runat="server"></asp:TextBox>--%>
                        <%--<asp:DropDownList ID="DDLCompany" runat="server" 
                    Style="background-color: Lavender;font-family: Calibri;" AppendDataBoundItems="true" Enabled="false"></asp:DropDownList>--%>
                            <select class="form-control" id="DDLCompany" style="display:none" disabled="disabled" name="departmentsDropdown"></select></td>
                        
                    </tr>
                </table>
            </fieldset>
        </div>
    <div id="Div2" style="overflow: auto; width:99%; height: 100%;" runat="server"> 
                <fieldset id="Fieldset4" runat="server" style="width: 97%">
                    <legend>Time and Work Area Info</legend>
                    <table id="timetbl" class="dataTable1" style="width:95%;">
                        <tr>
                            <td><asp:Label ID="Label22" runat="server" Width="30px" Text="Visit Area:"></asp:Label></td>
                            <%--<asp:TextBox ID="TextBox11" runat="server"></asp:TextBox>--%>
                            <td >
                            <%--<asp:DropDownList ID="DDLVisitArea" runat="server" 
                    Style="background-color: Lavender;font-family: Calibri;"></asp:DropDownList>--%>
                                <asp:TextBox ID="VisitArea" runat="server" Width="270px"></asp:TextBox>
                            </td>
                            <td></td>
                            <%--<td style="width:12%; float:left;"><asp:Label ID="Label23" runat="server" Text="Visit Duration"></asp:Label>:</td>
                            <td style="width:7%; float:left;"><asp:Label ID="Label19" runat="server" Text="Time In"></asp:Label></td>
                            <td style="width:15%; float:left;"><asp:TextBox ID="TextBox13" runat="server" TextMode="Time"></asp:TextBox></td>
                            <td style="width:7%; float:left;"><asp:Label ID="Label20" runat="server" Text="To" Visible="false"></asp:Label></td>
                            <td style="width:15%; float:left;"><asp:TextBox ID="TextBox18" runat="server" TextMode="Time" Visible="false"></asp:TextBox></td>--%>
                        </tr>
                    </table>
                </fieldset>
            </div>
    <div id="div1_1" style="overflow: auto; width:99%; height: 100%;" runat="server"> 
            <fieldset id="Fieldset3" runat="server" style="width: 97%">
                <legend>Vehicle Details</legend>
               
                <input type="hidden" id="fname2" name="fname2" />
                <table id="Vehicletbl" class="dataTable1" style="width:95%;">
                    <tr>
                        
                        <td>
                            <asp:Label ID="Label14" Text="Veh No#:" Width="80px" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox14" runat="server" Width="270px"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="Label17" Text="Color:" Width="38px" runat="server"></asp:Label>
                        </td>
                        <td>
                            <%--<asp:TextBox ID="TextBox17" runat="server"></asp:TextBox>--%>
                            <asp:DropDownList ID="DDLCarColor" runat="server" Width="270px"></asp:DropDownList>
                        </td>
                        <td>
                            
                        </td>
                        <td>
                            
                        </td>
                        
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label15" Text="Make:" Visible="false"  Width="87px"  runat="server"></asp:Label>
                        </td>
                        <%--<td style="width:20%; float:left;">
                            <asp:TextBox ID="TextBox15" runat="server"></asp:TextBox>
                        </td>--%>
                        <td>
                            <asp:DropDownList ID="DDLCarMake" Visible="false" Width="269px" runat="server" 
                    Style="background-color: Lavender;font-family: Calibri;"  onchange="getCarVariant();"></asp:DropDownList>
                            </td>
                    </tr>
                    <tr>                         <%--Varaint--%>

                        <td class="auto-style2">
                            <asp:Label ID="Label19" Text="Variant:" Visible="false" runat="server"></asp:Label>
                        </td>
                        <%--<td style="width:20%; float:left;">
                            <asp:TextBox ID="TextBox15" runat="server"></asp:TextBox>
                        </td>--%>
                        <td>
                            
                            <%--<asp:DropDownList ID="DDLVarient" runat="server" 
                    Style="background-color: Lavender;font-family: Calibri;"  AppendDataBoundItems="true" Enabled="false"></asp:DropDownList>--%>
                            <select  style="display:none" class="form-control" id="DDLVarient" name="departmentsDropdown"></select>
                            </td>
                        <td>
                            <asp:Label ID="Label16" Text="Model:" Visible="false" runat="server"></asp:Label>
                        </td>
                        <td style="width:20%; float:left;">
                            <asp:DropDownList ID="DDLCModel" runat="server" Visible="false"
                    Style="background-color: Lavender;font-family: Calibri;"></asp:DropDownList>
                            <%--<asp:TextBox ID="TextBox16" runat="server"></asp:TextBox>--%>
                        </td>
                        <td style="width:12%; float:left;">
                            <asp:Label ID="Label12" Visible="false" Text="Driving Licence(Optional):" runat="server"></asp:Label>
                        </td>
                        <td style="width:20%; float:left;">
                            <asp:TextBox ID="TextBox12" Visible="false" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>
        
    <div class="SaveBtn">
        <table style="width:100%">
            <tr>
                <td align="center">
                <asp:Button ID="Button1" Text="Save Visitor Data" Style="width: 200px; height: 50px; background-color:forestgreen; color: #fff; font-family: OpenSans,sans-serif; border-radius:15px;  font-size: 15px; text-transform: Uppercase; font-weight: 600; cursor: pointer;"
                    OnClientClick="return SaveVisitorbtn();" runat="server" /> <%--OnClick="Button1_Click"--%>
            </td>

            </tr>
        </table>

    </div>
        <script type="text/javascript">
        var config = {
            '.chosen-select': {},
        }
        for (var selector in config) {
            $(selector).chosen(config[selector]);
        }
    </script>
    <script>
        function upload() {
            function readURL(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    //reader.onload = function (e) { $('#myUploadedImg').attr('src', e.target.result); }//MediaUploader/Visitor/59.jpg
                    reader.onload = function (e) { $('#myUploadedImg').attr('src', e.target.result); }
                    reader.readAsDataURL(input.files[0]);
                }
            }

            $("#f_UploadImage").change(function (e) {
                var fileName = e.target.files[0].name;
                if (fileName != '') {
                    getExtension = fileName.substr((fileName.lastIndexOf('.') + 1));
                    if (getExtension == 'jpg' || getExtension == 'JPG') {
                        var filesize = e.target.files[0].size;
                        if (filesize < 2097152) { readURL(this); }
                        else {
                            alert('file is to big....');
                            return;
                        }
                    }
                    else {
                        alert(' file not valid');
                        return false;
                    }
                }
                else { alert('please select image file.....'); }
            });
        }

        function sendFile(id) {
            var formData = new FormData();
            if (document.getElementById("f_UploadImage").value != "") {
                // you have a file
                formData.append('file', $('#f_UploadImage')[0].files[0]);
                formData.append('id', id);
                formData.append('type', 'Visitor');
                $.ajax({
                    type: 'post',
                    url: 'fileUploader.ashx',
                    data: formData,
                    success: function (status) {
                        if (status != 'error') {
                            //  alert('sendfile function successful');
                            //my_path = "MediaUploader/" + status;
                            //$("#myUploadedImg").attr("src", my_path);
                            creatbyte(id);
                        }
                    },
                    processData: false,
                    contentType: false,
                    error: function () {
                        alert('Error ! ');
                        //sweetAlert("Oops...", "Internet Error! File is not uploaded... sendFile!", "error");
                    }
                });
            }
            else {
                // alert();
                // nextTab();

            }
        }

        function creatbyte(idz) {
            $.ajax({
                type: "POST",
                url: "Visitor_Registration_Form.aspx/creat_byte",
                data: "{id: '" + id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                cache: false,
                success: function (msg) {

                    alert('Successfully saved');
                    //swal("Good job!", "Successfully saved", "success")
                    //nextTab();
                },
                error: function () {
                    alert('Error In saving Record!');
                    // sweetAlert("Oops...", "Internet Error! creatbyte byte can not be created!", "error");
                }
            });
        }

        function nextTab() {
            $(".tab_act").next().trigger("click");

        }

        function getCarVariant() {
            var ProjectID = $("select[id$='DDLCarMake']").val();
            if (ProjectID == "" || ProjectID == "--Select--" || ProjectID == "0") {
                document.getElementById("DDLVarient").disabled = true;
                return;
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Staff_Registration_Search.aspx/getCarVariant",
                data: "{'ProjectID':'" + ProjectID + "'}",
                success: onsuccessgetCarVariant,
                error: onerrorCarVariant
            });
            return false;
        }
        function onsuccessgetCarVariant(msg) {
            var data = msg.d;
            var s = '<option value="0">--Select--</option>';

            for (var i = 0; i < data.VariantDetails.length; i++) {
                s += '<option value="' + data.VariantDetails[i].CarVariant_ID + '">' + data.VariantDetails[i].Var_Variant + '</option>';
            }

            $("#DDLVarient").html(s);

            document.getElementById("DDLVarient").disabled = false;
            var name = { text: $('#txtCarVariant').val() };

            document.getElementById('DDLVarient').value = document.getElementById('fname2').value;
            document.getElementById('DDLVarient').disabled = false;
        }

        function onerrorCarVariant() {
            document.getElementById('DDLVarient').disabled = true;
            //alert("Error In Loading Variant Name!");
            return false;
        }

        function getVisitorByID() {
            var uniqueID = $("input[id$=TextBox19]").val();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Visitor_Registration_Form.aspx/GetVisitorByUID",
                data: "{'uniqueID':'" + uniqueID + "'}",
                success: onsuccessGetVisitorbyUID,
                error: onErrorGetVisitorbyUID
            });
            return false;
        }

        function onsuccessGetVisitorbyUID(msg) {

            var data = msg.d;
            if (data.GetVisitorCountTable.length > 0) {
                /*alert("Press Enter for ID");*/
                return false;
            }
        }

        function onErrorGetVisitorbyUID() {


        }

        function getVisitorByCNIC() {
            var CNIC = $("input[id$='TxtCNIC']").val();
            //if ($("input[id$='txtId']").val() == "") {
            //if ($("input[id$='TxtCNIC']").val().indexOf('_') < 0) {


            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Visitor_Registration_Form.aspx/GetVisitorByCNIC",
                data: "{'CNIC':'" + CNIC + "'}",
                success: onsuccessGetVisitor,
                error: onErrorGetVisitor
            });
            return false;
            //}
            //else
            //    return false;
            //}
        }

        function onsuccessGetVisitor(msg) {

            var data = msg.d;
            //var result = data.GetVisitorCountTable.length;
            if (data.GetVisitorCountTable.length > 0) {
                alert("Visitor already exist!");
                $("input[id$='TxtCNIC']").val("");
                return false;
            }
        }

        function onErrorGetVisitor() {


        }



        function getCompaniesName() {

            var ProjectID = $("select[id$='DropDownList2']").val();
            if (ProjectID == "" || ProjectID == "--Select--" || ProjectID == "0") {
                document.getElementById("DDLCompany").disabled = true;
                return;
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Staff_Registration_Search.aspx/getCompanyName",
                data: "{'ProjectID':'" + ProjectID + "'}",
                success: onsuccessgetCompaniesName,
                error: onerrorCompaniesName
            });
            return;
        }
        function onsuccessgetCompaniesName(msg) {
            var data = msg.d;
            var s = '<option value="0">--Select--</option>';

            for (var i = 0; i < data.CompanyDetails.length; i++) {
                s += '<option value="' + data.CompanyDetails[i].Company_ID + '">' + data.CompanyDetails[i].Company_Name + '</option>';
            }

            $("#DDLCompany").html(s);
            var name = { text: $('#txtCompany').val() };

            document.getElementById('DDLCompany').value = document.getElementById('fname1').value;
            document.getElementById('DDLCompany').disabled = false;

        }

        function onerrorCompaniesName() {
            document.getElementById("DDLCompany").disabled = true;
            //alert("Error In Loading Company Name!");
            return false;
        }



        function cleartbl() {
            $("input[id$='searchTxt']").val("");
            $("input[id$='TextBox19']").val("");
            $("input[id$='tbFullName']").val("");
            $("input[id$='tbFatherName']").val("");
            $("input[id$='TxtCNIC']").val("");
            $("input[id$='TextBox1']").val("");
            $("input[id$='TextBox8']").val("");
            $("input[id$='TextBox4']").val("");
            $("select[id$='DDLDesignation']").val("");
            $("select[id$='ddlDeptUnit']").val("");
            $("input[id$='TextBox10']").val("");
            $("input[id$='TextBox2']").val("");
            $("input[id$='TextBox3']").val("");
            $("input[id$='TextBox9']").val("");

            $("select[id$='DDLCarMake']").val("");
            $("Input[id$='TextBox14']").val("");
            $("select[id$='DDLCarColor']").val("");
            $("select[id$='DDLVarient']").val("");
            $("select[id$='DDLCModel']").val("");
            $("Input[id$='TextBox12']").val("");

            $("select[id$='DropDownList1']").val("");
            $("select[id$='DropDownList2']").val("");
            //$("select[id$='DropDownList3']").val("");
            $("input[id$='VisitPurpose']").val("");
            $("select[id$='DDLCompany']").val("");
            $("input[id$='TextBox5']").val("");
            $("input[id$='VisitArea']").val("");
            //("select[id$='DDLVisitArea']").val("");
            document.getElementById('myUploadedImg').removeAttribute('src');//Image removal for no data found record
            //$("input[id$='TextBox19']").val("");
            //$("input[id$='tbFullName']").val("");
            //$("input[id$='tbFatherName']").val("");
            //$("input[id$='TxtCNIC']").val("");
            //$("input[id$='TextBox1']").val("");
            //$("input[id$='TextBox8']").val("");
            //$("input[id$='TextBox4']").val("");
            //$("input[id$='TextBox7']").val("");
            //$("input[id$='TextBox10']").val("");
            //$("input[id$='TextBox2']").val("");
            //$("input[id$='TextBox3']").val("");
            //$("input[id$='TextBox9']").val("");
            //$("Input[id$='TextBox12']").val("");
            //$("Input[id$='TextBox14']").val("");
            //$("Input[id$='TextBox15']").val("");
            //$("Input[id$='TextBox16']").val("");
            //$("Input[id$='TextBox17']").val("");
            //$("select[id$='DropDownList1']").val("");
            //$("select[id$='DropDownList2']").val("");
            //$("select[id$='DropDownList3']").val("");
            //$("inpupt[id4='VisitPurpose']").val(");
            //$("input[id$='TextBox6']").val("");
            //$("input[id$='TextBox5']").val("");
            //$("input[id$='TextBox11']").val("");
            //$("input[id$='TextBox13']").val("");
            //$("input[id$='TextBox18']").val("");

        }
        function SaveVisitorbtn() {
            var UniqueID = $("input[id$='TextBox19']").val();
            var FullName = $("input[id$='tbFullName']").val();
            var FatherName = $("input[id$='tbFatherName']").val();
            var Cnic = $("input[id$='TxtCNIC']").val();
            var Dob = $("input[id$='TextBox1']").val();
            var address = $("input[id$='TextBox8']").val();
            var Organization = $("input[id$='TextBox4']").val();
            var Designation = $("select[id$='DDLDesignation']").val();
            var Department = $("select[id$='ddlDeptUnit']").val();
            var EmpNo = $("input[id$='TextBox10']").val();
            var PassportNo = $("input[id$='TextBox2']").val();
            var Email = $("input[id$='TextBox3']").val();
            var MobNo = $("input[id$='TextBox9']").val();

            var Cmake = $("select[id$='DDLCarMake']").val();
            var CRegNo = $("Input[id$='TextBox14']").val();
            var CColor = $("select[id$='DDLCarColor']").val();
            var CVarient = $("select[id$='DDLVarient']").val();
            var CModel = $("select[id$='DDLCModel']").val();
            var DLic = $("Input[id$='TextBox12']").val();

            var Employee = $("select[id$='DropDownList1']").val();
            var Floor = $("select[id$='DropDownList2']").val();
            //var Purpose_v = $("select[id$='DropDownList3']").val();
            var Purpose_v = $("input[id$='VisitPurpose']").val();
            var Comp_name = $("select[id$='DDLCompany']").val();
            var DoVisit = $("input[id$='TextBox5']").val();
            //var VisitArea = $("select[id$='DDLVisitArea']").val();
            var VisitArea = $("input[id$='VisitArea']").val();
            //var VisitFrom = $("input[id$='TextBox13']").val();
            //var VisitTo = $("input[id$='TextBox18']").val();

            //var img_data = input.files[0];
            //var img_data = $("FileUpload[id$='FileUpload1']").val();
            //var img_arr = []
            //var dataEnc = "";
            //for (var i = 0; i <= FileUpload1.length; i++) {
            //    img_arr.push(FileUpload1[i].charCodeAt(0).toString(2));
            //}
            //for (var j = 0; j < img_arr.length; j++) {
            //    var pad = padding_left(img_arr[j], '0', 8);
            //    dataEnc += pad + '';
            //}

            // Validator on ID is added by Umair Khan
            //if (UniqueID == "") {
            //    alert("Please Enter ID!");
            //    return;
            //}
            if (FullName == "") {
                alert("Name is Required");
                return;
            }
            //if (FatherName == "") {
            //    alert("Please Enter Father Name!");
            //    return;
            //}

            if (Cnic == "" || Cnic == "_____-_______-_") {
                alert("CNIC is Required!");
                return;
            }
            //if (Dob == "") {
            //    alert("Please Enter Date of Birth Number!");
            //    return;
            //}
            if (address == "") {
                alert("Please Enter Address Number!");
                return;
            }
            //if (Organization == "") {
            //    alert("Please Enter Organization Number!");
            //    return;
            //}
            //if (Designation == "" || Designation == 0 || Designation == "--Select--") {
            //    alert("Please Select Designation!");
            //    return;
            //}


            if (EmpNo == "") {
                alert("Please Enter Visitor Employee Number!");
                return;
            }

            //if (PassportNo == "") {
            //    alert("Please Enter Passport Number of Visit!");
            //    return;
            //}
            //if (Email == "") {
            //    alert("Please Enter valid Email Address!");
            //    return;
            //}
            //if (MobNo == "") {
            //    alert("Mobile# is Required");
            //    return;
            //}


            //if (Cmake == "" || Cmake == "--Select--" || Cmake == "0") {
            //    alert("Please Select Car Maker!");
            //    return;
            //}
            //if (CRegNo == "") {
            //    alert("Please Enter Car Registration Number!");
            //    return;
            //}
            //if (CColor == "" || CColor == "--Select--" || CColor == "0") {
            //    alert("Please Select Car Color!");
            //    return;
            //}
            //if (CVarient == "" || CVarient == "--Select--" || CVarient == "0") {
            //    alert("Please Select Car Variant!");
            //    return;
            //}

            //if (Employee == "" || Employee == "--Select--" || Employee == "0") {
            //    alert("Please Select Employee/Host Name!");
            //    return;
            //}
            //if (Floor == "" || Floor == "--Select--" || Floor == "0") {
            //    alert("Please Select Floor Details!");
            //    return;
            //}
            if (Purpose_v == "" || Purpose_v == "--Select--" || Purpose_v == "0") {
                alert("Please Select Purpose of Visit!");
                return;
            }
            //if (Comp_name == "" || Comp_name == "--Select--" || Comp_name == "0") {
            //    alert("Please Select Company Name!");
            //    return;
            //}
            //if (DoVisit == "") {
            //    alert("Please Enter Date of Visit!");
            //    return;
            //}
            //if (VisitArea == "" || VisitArea == "--Select--" || VisitArea == "0") {
            //    alert("Please Select Visit/Work Area!");
            //    return;
            //}

            //data: "{'Unique_ID':'" + UniqueID + "','FullName':'" + FullName + "','FatherName':'" + FatherName + "','CNIC':'" + Cnic + "','DOB':'" + Dob + "','address':'" + address + "','MobileNO':'" + MobNo + "','Parent_Org':'" + Parent_org + "','Designation':'" + Designation + "','EmpNo':'" + EmpNo + "','PassportNo':'" + PassportNo + "','Email':'" + Email + "','DrivLic':'" + DLic + "','CReg':'" + CRegNo + "','CMake':'" + Cmake + "','Cmodel':'" + CModel + "','CColor':'" + CColor + "','Person_v':'" + Person_v + "','Place_v':'" + Place_v + "','Purpose_v':'" + Purpose_v + "','CompanyName':'" + Comp_name + "','DoVisit':'" + DoVisit + "','VisitArea':'" + VisitArea + "'}",


            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Visitor_Registration_Form.aspx/saveVisitor",
                data: "{'UniqueID':'" + UniqueID + "','FullName':'" + FullName + "','FatherName':'" + FatherName + "','Cnic':'" + Cnic + "','Dob':'" + Dob + "','address':'" + address + "','Organization':'" + Organization + "','Designation':'" + Designation + "','Department':'" + Department + "',,'EmpNo':'" + EmpNo + "','PassportNo':'" + PassportNo + "','Email':'" + Email + "','MobNo':'" + MobNo + "','Cmake':'" + Cmake + "','CRegNo':'" + CRegNo + "','CColor':'" + CColor + "','CVarient':'" + CVarient + "','CModel':'" + CModel + "','DLic':'" + DLic + "','Employee':'" + Employee + "','Floor':'" + Floor + "','Purpose_v':'" + Purpose_v + "','Comp_name':'" + Comp_name + "','DoVisit':'" + DoVisit + "','VisitArea':'" + VisitArea + "'}",
                success: onsuccessSaveVisitor,
                error: onretrieveSaveVisitorError
            });

        }
        function onsuccessSaveVisitor(msg) {
            var massege = msg.d;
            //if (message.val() == "")
            //{
            //    alert("Error In Saving Data!");
            //    return false;
            //}
            sendFile(massege);
            alert("Data Successfully Saved!");

            cleartbl();
            location.reload();
            return false;
        }
        function onretrieveSaveVisitorError() {
            alert("Error In Saving Data!");
            return false;
        }
        //data: "{'FullName':'" + FullName + "','FatherName':'" + FatherName + "','CNIC':'" + Cnic + "','DOB':'" + Dob + "','CompanyName':'" + Comp_name + "','DoVisit':'" + DoVisit + "','address':'" + address + "'}",
        function SearchVisitor() {
            var Cnic = $("input[id$='searchTxt']").val();
            if (Cnic == "") {
                alert("Search Box is Empty!");
                return;
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Visitor_Registration_Form.aspx/SearchVisitor",
                data: "{'CNIC':'" + Cnic + "'}",
                success: onsuccessSearchVisitor,
                error: onretrieveSearchVisitorError
            });
            return false;
        }
        function onsuccessSearchVisitor(msg) {
            var data = msg.d;
            cleartbl();
            if (data.ProjDetails.length > 0) {
                alert("Successfully Found!");

                $("input[id$='TextBox19']").val(data.ProjDetails[0].Uniq_Code);
                $("input[id$='tbFullName']").val(data.ProjDetails[0].Full_Name);
                $("input[id$='tbFatherName']").val(data.ProjDetails[0].Father_Name);
                $("input[id$='TxtCNIC']").val(data.ProjDetails[0].CNIC);
                $("input[id$='TextBox1']").val(data.ProjDetails[0].DoB);
                $("input[id$='TextBox8']").val(data.ProjDetails[0].Address);
                $("input[id$='TextBox4']").val(data.ProjDetails[0].VisitorOrganization);
                $("select[id$='DropDownList1']").val(data.ProjDetails[0].Person_To_Visit);
                $("select[id$='DDLDesignation']").val(data.ProjDetails[0].Designation);
                $("select[id$='ddlDeptUnit']").val(data.ProjDetails[0].Department);
                $("input[id$='TextBox10']").val(data.ProjDetails[0].EmpNo);
                $("input[id$='TextBox2']").val(data.ProjDetails[0].PassportNo);
                $("input[id$='TextBox3']").val(data.ProjDetails[0].Email);
                $("input[id$='TextBox9']").val(data.ProjDetails[0].PhoneNo);

                $("select[id$='DDLCarMake']").val(data.ProjDetails[0].Cmake);
                getCarVariant();
                //$("select[id$='DDLCarMake']").val($("#txtCarMake" + rowNo).html().trim());
                //getCarVariant();
                $("select[id$='DDLVarient']").val(data.ProjDetails[0].CVariant);
                $("input[id$='fname2']").val(data.ProjDetails[0].CVariant);

                $("Input[id$='TextBox14']").val(data.ProjDetails[0].CReg);
                $("select[id$='DDLCarColor']").val(data.ProjDetails[0].CColor);
                $("select[id$='DDLVarient']").val(data.ProjDetails[0].CVariant);
                $("select[id$='DDLCModel']").val(data.ProjDetails[0].Cmodel);
                $("Input[id$='TextBox12']").val(data.ProjDetails[0].DrivLic);

                $("select[id$='DropDownList1']").val(data.ProjDetails[0].Person_To_Visit);
                $("select[id$='DropDownList2']").val(data.ProjDetails[0].Place_To_Visit);
                getCompaniesName();
                $("select[id$='DDLCompany']").val(data.ProjDetails[0].Company_ID);
                $("input[id$='fname1']").val(data.ProjDetails[0].Company_ID);

                //$("select[id$='DropDownList3']").val(data.ProjDetails[0].Purpose_To_Visit);
                $("input[id$='VisitPurpose']").val(data.ProjDetails[0].Purpose_To_Visit);

                $("select[id$='DDLCompany']").val(data.ProjDetails[0].Company_ID);
                $("input[id$='TextBox5']").val(data.ProjDetails[0].DateofVisit);
                //$("select[id$='DDLVisitArea']").val(data.ProjDetails[0].VisitArea);
                $("input[id$='VisitArea']").val(data.ProjDetails[0].VisitArea);

                if (data.ProjDetails[0].ImageName == 'null') {  //image icon fixing
                    document.getElementById('myUploadedImg').removeAttribute('src');
                } else {
                    document.getElementById('myUploadedImg').src = data.ProjDetails[0].ImageName;
                }


                document.getElementById('myUploadedImg').src = data.ProjDetails[0].ImageName;
                var reader = new FileReader();
                reader.onload = function (e) { $('#myUploadedImg').attr(data.ProjDetails[0].ImageName, e.target.result); }
                //alert('all data loaded!');
                //$("input[id$='TextBox13']").val(data.ProjDetails[0].TimeIn);
            }
            else {
                alert("No Data found!");
            }


            return false;
        }
        function onretrieveSearchVisitorError() {
            alert("No Data found!");
            return false;
        }
    </script>

      <script>
          function upload() {
              function readURL(input) {
                  if (input.files && input.files[0]) {
                      var reader = new FileReader();
                      //reader.onload = function (e) { $('#myUploadedImg').attr('src', e.target.result); }//MediaUploader/Visitor/59.jpg
                      reader.onload = function (e) { $('#myUploadedImg').attr('src', e.target.result); }
                      reader.readAsDataURL(input.files[0]);
                  }
              }

              $("#f_UploadImage").change(function (e) {
                  var fileName = e.target.files[0].name;
                  if (fileName != '') {
                      getExtension = fileName.substr((fileName.lastIndexOf('.') + 1));
                      if (getExtension == 'jpg' || getExtension == 'JPG') {
                          var filesize = e.target.files[0].size;
                          if (filesize < 2097152) { readURL(this); }
                          else {
                              alert('file is to big....');
                              return;
                          }
                      }
                      else {
                          alert(' file not valid');
                          return false;
                      }
                  }
                  else { alert('please select image file.....'); }
              });
          }

          function sendFile(id) {
              var formData = new FormData();
              if (document.getElementById("f_UploadImage").value != "") {
                  // you have a file
                  formData.append('file', $('#f_UploadImage')[0].files[0]);
                  formData.append('id', id);
                  formData.append('type', 'Visitor');
                  $.ajax({
                      type: 'post',
                      url: 'fileUploader.ashx',
                      data: formData,
                      success: function (status) {
                          if (status != 'error') {
                              //  alert('sendfile function successful');
                              //my_path = "MediaUploader/" + status;
                              //$("#myUploadedImg").attr("src", my_path);
                              creatbyte(id);
                          }
                      },
                      processData: false,
                      contentType: false,
                      error: function () {
                          alert('Error ! ');
                          //sweetAlert("Oops...", "Internet Error! File is not uploaded... sendFile!", "error");
                      }
                  });
              }
              else {
                  // alert();
                  // nextTab();

              }
          }

          function creatbyte(idz) {
              $.ajax({
                  type: "POST",
                  url: "Visitor_Registration_Form.aspx/creat_byte",
                  data: "{id: '" + id + "'}",
                  contentType: "application/json; charset=utf-8",
                  dataType: "json",
                  async: true,
                  cache: false,
                  success: function (msg) {

                      alert('Successfully saved');
                      //swal("Good job!", "Successfully saved", "success")
                      //nextTab();
                  },
                  error: function () {
                      alert('Error In saving Record!');
                      // sweetAlert("Oops...", "Internet Error! creatbyte byte can not be created!", "error");
                  }
              });
          }

          function nextTab() {
              $(".tab_act").next().trigger("click");

          }

          function getCarVariant() {
              var ProjectID = $("select[id$='DDLCarMake']").val();
              if (ProjectID == "" || ProjectID == "--Select--" || ProjectID == "0") {
                  document.getElementById("DDLVarient").disabled = true;
                  return;
              }

              $.ajax({
                  type: "POST",
                  contentType: "application/json; charset=utf-8",
                  url: "Staff_Registration_Search.aspx/getCarVariant",
                  data: "{'ProjectID':'" + ProjectID + "'}",
                  success: onsuccessgetCarVariant,
                  error: onerrorCarVariant
              });
              return false;
          }
          function onsuccessgetCarVariant(msg) {
              var data = msg.d;
              var s = '<option value="0">--Select--</option>';

              for (var i = 0; i < data.VariantDetails.length; i++) {
                  s += '<option value="' + data.VariantDetails[i].CarVariant_ID + '">' + data.VariantDetails[i].Var_Variant + '</option>';
              }

              $("#DDLVarient").html(s);

              document.getElementById("DDLVarient").disabled = false;
              var name = { text: $('#txtCarVariant').val() };

              document.getElementById('DDLVarient').value = document.getElementById('fname2').value;
              document.getElementById('DDLVarient').disabled = false;
          }

          function onerrorCarVariant() {
              document.getElementById('DDLVarient').disabled = true;
              //alert("Error In Loading Variant Name!");
              return false;
          }

          function getVisitorByID() {
              var uniqueID = $("input[id$=TextBox19]").val();
              $.ajax({
                  type: "POST",
                  contentType: "application/json; charset=utf-8",
                  url: "Visitor_Registration_Form.aspx/GetVisitorByUID",
                  data: "{'uniqueID':'" + uniqueID + "'}",
                  success: onsuccessGetVisitorbyUID,
                  error: onErrorGetVisitorbyUID
              });
              return false;
          }

          function onsuccessGetVisitorbyUID(msg) {

              var data = msg.d;
              if (data.GetVisitorCountTable.length > 0) {
                  /*alert("Press Enter for ID");*/
                  return false;
              }
          }

          function onErrorGetVisitorbyUID() {


          }

          function getVisitorByCNIC() {
              var CNIC = $("input[id$='TxtCNIC']").val();
              //if ($("input[id$='txtId']").val() == "") {
              //if ($("input[id$='TxtCNIC']").val().indexOf('_') < 0) {


              $.ajax({
                  type: "POST",
                  contentType: "application/json; charset=utf-8",
                  url: "Visitor_Registration_Form.aspx/GetVisitorByCNIC",
                  data: "{'CNIC':'" + CNIC + "'}",
                  success: onsuccessGetVisitor,
                  error: onErrorGetVisitor
              });
              return false;
              //}
              //else
              //    return false;
              //}
          }

          function onsuccessGetVisitor(msg) {

              var data = msg.d;
              //var result = data.GetVisitorCountTable.length;
              if (data.GetVisitorCountTable.length > 0) {
                  alert("Visitor already exist!");
                  $("input[id$='TxtCNIC']").val("");
                  return false;
              }
          }

          function onErrorGetVisitor() {


          }



          function getCompaniesName() {

              var ProjectID = $("select[id$='DropDownList2']").val();
              if (ProjectID == "" || ProjectID == "--Select--" || ProjectID == "0") {
                  document.getElementById("DDLCompany").disabled = true;
                  return;
              }
              $.ajax({
                  type: "POST",
                  contentType: "application/json; charset=utf-8",
                  url: "Staff_Registration_Search.aspx/getCompanyName",
                  data: "{'ProjectID':'" + ProjectID + "'}",
                  success: onsuccessgetCompaniesName,
                  error: onerrorCompaniesName
              });
              return;
          }
          function onsuccessgetCompaniesName(msg) {
              var data = msg.d;
              var s = '<option value="0">--Select--</option>';

              for (var i = 0; i < data.CompanyDetails.length; i++) {
                  s += '<option value="' + data.CompanyDetails[i].Company_ID + '">' + data.CompanyDetails[i].Company_Name + '</option>';
              }

              $("#DDLCompany").html(s);
              var name = { text: $('#txtCompany').val() };

              document.getElementById('DDLCompany').value = document.getElementById('fname1').value;
              document.getElementById('DDLCompany').disabled = false;

          }

          function onerrorCompaniesName() {
              document.getElementById("DDLCompany").disabled = true;
              // alert("Error In Loading Company Name!");
              return false;
          }



          function cleartbl() {
              $("input[id$='searchTxt']").val("");
              $("input[id$='TextBox19']").val("");
              $("input[id$='tbFullName']").val("");
              $("input[id$='tbFatherName']").val("");
              $("input[id$='TxtCNIC']").val("");
              $("input[id$='TextBox1']").val("");
              $("input[id$='TextBox8']").val("");
              $("input[id$='TextBox4']").val("");
              $("select[id$='DDLDesignation']").val("");
              $("select[id$='ddlDeptUnit']").val("");
              $("input[id$='TextBox10']").val("");
              $("input[id$='TextBox2']").val("");
              $("input[id$='TextBox3']").val("");
              $("input[id$='TextBox9']").val("");

              $("select[id$='DDLCarMake']").val("");
              $("Input[id$='TextBox14']").val("");
              $("select[id$='DDLCarColor']").val("");
              $("select[id$='DDLVarient']").val("");
              $("select[id$='DDLCModel']").val("");
              $("Input[id$='TextBox12']").val("");

              $("select[id$='DropDownList1']").val("");
              $("select[id$='DropDownList2']").val("");
              //$("select[id$='DropDownList3']").val("");
              $("input[id$='VisitPurpose']").val("");
              $("select[id$='DDLCompany']").val("");
              $("input[id$='TextBox5']").val("");
              $("input[id$='VisitArea']").val("");
              //$("select[id$='DDLVisitArea']").val("");
              document.getElementById('myUploadedImg').removeAttribute('src');//Image removal for no data found record
              //$("input[id$='TextBox19']").val("");
              //$("input[id$='tbFullName']").val("");
              //$("input[id$='tbFatherName']").val("");
              //$("input[id$='TxtCNIC']").val("");
              //$("input[id$='TextBox1']").val("");
              //$("input[id$='TextBox8']").val("");
              //$("input[id$='TextBox4']").val("");
              //$("input[id$='TextBox7']").val("");
              //$("input[id$='TextBox10']").val("");
              //$("input[id$='TextBox2']").val("");
              //$("input[id$='TextBox3']").val("");
              //$("input[id$='TextBox9']").val("");
              //$("Input[id$='TextBox12']").val("");
              //$("Input[id$='TextBox14']").val("");
              //$("Input[id$='TextBox15']").val("");
              //$("Input[id$='TextBox16']").val("");
              //$("Input[id$='TextBox17']").val("");
              //$("select[id$='DropDownList1']").val("");
              //$("select[id$='DropDownList2']").val("");
              ////$("select[id$='DropDownList3']").val("");
              //$("input[id$='VisitPurpose']").val("");
              //$("input[id$='TextBox6']").val("");
              //$("input[id$='TextBox5']").val("");
              //$("input[id$='TextBox11']").val("");
              //$("input[id$='TextBox13']").val("");
              //$("input[id$='TextBox18']").val("");

          }
          function SaveVisitorbtn() {
              var UniqueID = $("input[id$='TextBox19']").val();
              var FullName = $("input[id$='tbFullName']").val();
              var FatherName = $("input[id$='tbFatherName']").val();
              var Cnic = $("input[id$='TxtCNIC']").val();
              var Dob = $("input[id$='TextBox1']").val();
              var address = $("input[id$='TextBox8']").val();
              var Organization = $("input[id$='TextBox4']").val();
              var Designation = $("select[id$='DDLDesignation']").val();
              var Department = $("select[id$='ddlDeptUnit']").val();
              var EmpNo = $("input[id$='TextBox10']").val();
              var PassportNo = $("input[id$='TextBox2']").val();
              var Email = $("input[id$='TextBox3']").val();
              var MobNo = $("input[id$='TextBox9']").val();

              var Cmake = $("select[id$='DDLCarMake']").val();
              var CRegNo = $("Input[id$='TextBox14']").val();
              var CColor = $("select[id$='DDLCarColor']").val();
              var CVarient = $("select[id$='DDLVarient']").val();
              var CModel = $("select[id$='DDLCModel']").val();
              var DLic = $("Input[id$='TextBox12']").val();

              var Employee = $("select[id$='DropDownList1']").val();
              var Floor = $("select[id$='DropDownList2']").val();
              //var Purpose_v = $("select[id$='DropDownList3']").val();
              var Purpose_v = $("input[id$='VisitPurpose']").val();
              var Comp_name = $("select[id$='DDLCompany']").val();
              var DoVisit = $("input[id$='TextBox5']").val();
              //var VisitArea = $("select[id$='DDLVisitArea']").val();
              var VisitArea = $("input[id$='VisitArea']").val();
              //var VisitFrom = $("input[id$='TextBox13']").val();
              //var VisitTo = $("input[id$='TextBox18']").val();

              //var img_data = input.files[0];
              //var img_data = $("FileUpload[id$='FileUpload1']").val();
              //var img_arr = []
              //var dataEnc = "";
              //for (var i = 0; i <= FileUpload1.length; i++) {
              //    img_arr.push(FileUpload1[i].charCodeAt(0).toString(2));
              //}
              //for (var j = 0; j < img_arr.length; j++) {
              //    var pad = padding_left(img_arr[j], '0', 8);
              //    dataEnc += pad + '';
              //}

              // Validator on ID is added by Umair Khan
              //if (UniqueID == "") {
              //    alert("Please Enter ID!");
              //    return;
              //}
              if (FullName == "") {
                  alert("Name is Required");
                  return;
              }
              //if (FatherName == "") {
              //    alert("Please Enter Father Name!");
              //    return;
              //}

              if (Cnic == "" || Cnic == "_____-_______-_") {
                  alert("CNIC is Required!");
                  return;
              }
              //if (Dob == "") {
              //    alert("Please Enter Date of Birth Number!");
              //    return;
              //}
              if (address == null) {
                  address == "";
                  //alert("Please Enter Address Number!");
                  //return;
              }
              //if (Organization == "") {
              //    alert("Please Enter Organization Number!");
              //    return;
              //}
              //if (Designation == "" || Designation == 0 || Designation == "--Select--") {
              //    alert("Please Select Designation!");
              //    return;
              //}


              if (EmpNo == "") {
                  alert("Please Enter Visitor Employee Number!");
                  return;
              }

              //if (PassportNo == "") {
              //    alert("Please Enter Passport Number of Visit!");
              //    return;
              //}
              //if (Email == "") {
              //    alert("Please Enter valid Email Address!");
              //    return;
              //}
              //if (MobNo == "") {
              //    alert("Mobile# is Required!");
              //    return;
              //}


              //if (Cmake == "" || Cmake == "--Select--" || Cmake == "0") {
              //    alert("Please Select Car Maker!");
              //    return;
              //}
              //if (CRegNo == "") {
              //    alert("Please Enter Car Registration Number!");
              //    return;
              //}
              //if (CColor == "" || CColor == "--Select--" || CColor == "0") {
              //    alert("Please Select Car Color!");
              //    return;
              //}
              //if (CVarient == "" || CVarient == "--Select--" || CVarient == "0") {
              //    alert("Please Select Car Variant!");
              //    return;
              //}

              //if (Employee == "" || Employee == "--Select--" || Employee == "0") {
              //    alert("Please Select Employee/Host Name!");
              //    return;
              //}
              if (Floor == "" || Floor == "--Select--") {
                  //alert("Please Select Floor Details!");
                  //return;
                  Floor = "";
              }
              if (Purpose_v == "" || Purpose_v == "--Select--") {
                  //alert("Please Select Purpose of Visit!");
                  //return;
                  Purpose_v = "";
              }
              if (Comp_name == "" || Comp_name == "--Select--") {
                  //alert("Please Select Company Name!");
                  //return;
                  Comp_name = "";
              }
              //if (DoVisit == "") {
              //    alert("Please Enter Date of Visit!");
              //    return;
              //}
              //if (VisitArea == ""  || VisitArea == "0") {
              //    //alert("Please Select Visit/Work Area!");
              //    //return;
              //    VisitArea = "";
              //}

              //data: "{'Unique_ID':'" + UniqueID + "','FullName':'" + FullName + "','FatherName':'" + FatherName + "','CNIC':'" + Cnic + "','DOB':'" + Dob + "','address':'" + address + "','MobileNO':'" + MobNo + "','Parent_Org':'" + Parent_org + "','Designation':'" + Designation + "','EmpNo':'" + EmpNo + "','PassportNo':'" + PassportNo + "','Email':'" + Email + "','DrivLic':'" + DLic + "','CReg':'" + CRegNo + "','CMake':'" + Cmake + "','Cmodel':'" + CModel + "','CColor':'" + CColor + "','Person_v':'" + Person_v + "','Place_v':'" + Place_v + "','Purpose_v':'" + Purpose_v + "','CompanyName':'" + Comp_name + "','DoVisit':'" + DoVisit + "','VisitArea':'" + VisitArea + "'}",

              //alert("inside save but beofre post")
              $.ajax({
                  type: "POST",
                  contentType: "application/json; charset=utf-8",
                  url: "Visitor_Registration_Form.aspx/saveVisitor",
                  data: "{'UniqueID':'" + UniqueID + "','FullName':'" + FullName + "','FatherName':'" + FatherName + "','Cnic':'" + Cnic + "','Dob':'" + Dob + "','address':'" + address + "','Organization':'" + Organization + "','Designation':'" + Designation + "','Department':'" + Department + "', 'EmpNo':'" + EmpNo + "','PassportNo':'" + PassportNo + "','Email':'" + Email + "','MobNo':'" + MobNo + "','Cmake':'" + Cmake + "','CRegNo':'" + CRegNo + "','CColor':'" + CColor + "','CVarient':'" + CVarient + "','CModel':'" + CModel + "','DLic':'" + DLic + "','Employee':'" + Employee + "','Floor':'" + Floor + "','Purpose_v':'" + Purpose_v + "','Comp_name':'" + Comp_name + "','DoVisit':'" + DoVisit + "','VisitArea':'" + VisitArea + "'}",
                  success: onsuccessSaveVisitor,
                  error: onretrieveSaveVisitorError
              });

          }
          function onsuccessSaveVisitor(msg) {
              var massege = msg.d;
              if (message.val() == "") {
                  alert("Error In Saving Data!");
                  return false;
              }
              sendFile(massege);
              alert("Data Successfully Saved!");

              cleartbl();
              location.reload();
              return false;
          }
          function onretrieveSaveVisitorError() {
              alert("Error In Saving Data!");
              return false;
          }
          //data: "{'FullName':'" + FullName + "','FatherName':'" + FatherName + "','CNIC':'" + Cnic + "','DOB':'" + Dob + "','CompanyName':'" + Comp_name + "','DoVisit':'" + DoVisit + "','address':'" + address + "'}",
          function SearchVisitor() {
              var Cnic = $("input[id$='searchTxt']").val();
              if (Cnic == "") {
                  alert("Search Box is Empty!");
                  return;
              }
              $.ajax({
                  type: "POST",
                  contentType: "application/json; charset=utf-8",
                  url: "Visitor_Registration_Form.aspx/SearchVisitor",
                  data: "{'CNIC':'" + Cnic + "'}",
                  success: onsuccessSearchVisitor,
                  error: onretrieveSearchVisitorError
              });
              return false;
          }
          function onsuccessSearchVisitor(msg) {
              var data = msg.d;
              cleartbl();
              if (data.ProjDetails.length > 0) {
                  alert("Successfully Found!");

                  $("input[id$='TextBox19']").val(data.ProjDetails[0].Uniq_Code);
                  $("input[id$='tbFullName']").val(data.ProjDetails[0].Full_Name);
                  $("input[id$='tbFatherName']").val(data.ProjDetails[0].Father_Name);
                  $("input[id$='TxtCNIC']").val(data.ProjDetails[0].CNIC);
                  $("input[id$='TextBox1']").val(data.ProjDetails[0].DoB);
                  $("input[id$='TextBox8']").val(data.ProjDetails[0].Address);
                  $("input[id$='TextBox4']").val(data.ProjDetails[0].VisitorOrganization);
                  $("select[id$='DropDownList1']").val(data.ProjDetails[0].Person_To_Visit);
                  $("select[id$='DDLDesignation']").val(data.ProjDetails[0].Designation);
                  $("select[id$='ddlDeptUnit']").val(data.ProjDetails[0].Department);
                  $("input[id$='TextBox10']").val(data.ProjDetails[0].EmpNo);
                  $("input[id$='TextBox2']").val(data.ProjDetails[0].PassportNo);
                  $("input[id$='TextBox3']").val(data.ProjDetails[0].Email);
                  $("input[id$='TextBox9']").val(data.ProjDetails[0].PhoneNo);

                  $("select[id$='DDLCarMake']").val(data.ProjDetails[0].Cmake);
                  getCarVariant();
                  //$("select[id$='DDLCarMake']").val($("#txtCarMake" + rowNo).html().trim());
                  //getCarVariant();
                  $("select[id$='DDLVarient']").val(data.ProjDetails[0].CVariant);
                  $("input[id$='fname2']").val(data.ProjDetails[0].CVariant);

                  $("Input[id$='TextBox14']").val(data.ProjDetails[0].CReg);
                  $("select[id$='DDLCarColor']").val(data.ProjDetails[0].CColor);
                  $("select[id$='DDLVarient']").val(data.ProjDetails[0].CVariant);
                  $("select[id$='DDLCModel']").val(data.ProjDetails[0].Cmodel);
                  $("Input[id$='TextBox12']").val(data.ProjDetails[0].DrivLic);

                  $("select[id$='DropDownList1']").val(data.ProjDetails[0].Person_To_Visit);
                  $("select[id$='DropDownList2']").val(data.ProjDetails[0].Place_To_Visit);
                  getCompaniesName();
                  $("select[id$='DDLCompany']").val(data.ProjDetails[0].Company_ID);
                  $("input[id$='fname1']").val(data.ProjDetails[0].Company_ID);

                  //$("select[id$='DropDownList3']").val(data.ProjDetails[0].Purpose_To_Visit);
                  $("input[id$='VisitPurpose']").val(data.ProjDetails[0].Purpose_To_Visit);
                  $("select[id$='DDLCompany']").val(data.ProjDetails[0].Company_ID);
                  $("input[id$='TextBox5']").val(data.ProjDetails[0].DateofVisit);
                  //$("select[id$='DDLVisitArea']").val(data.ProjDetails[0].VisitArea);
                  $("input[id$='VisitArea']").val(data.ProjDetails[0].VisitArea);
                  if (data.ProjDetails[0].ImageName == 'null') {  //image icon fixing
                      document.getElementById('myUploadedImg').removeAttribute('src');
                  } else {
                      document.getElementById('myUploadedImg').src = data.ProjDetails[0].ImageName;
                  }


                  document.getElementById('myUploadedImg').src = data.ProjDetails[0].ImageName;
                  var reader = new FileReader();
                  reader.onload = function (e) { $('#myUploadedImg').attr(data.ProjDetails[0].ImageName, e.target.result); }
                  //alert('all data loaded!');
                  //$("input[id$='TextBox13']").val(data.ProjDetails[0].TimeIn);
              }
              else {
                  alert("No Data found!");
              }


              return false;
          }
          function onretrieveSearchVisitorError() {
              alert("No Data found!");
              return false;
          }
      </script>
    </asp:Content>
