<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="CardIssueOrReturn.aspx.cs" Inherits="CardIssueOrReturn" %>

 <%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <link href="css/dataTable.css" rel="stylesheet" />
    <table style="width: 100%; margin-top: 0%;">

        <tr>
            <td>
                <fieldset>
                    <legend>Add/Modified Card Issue/Return</legend>

                    <table id="tblCaste" style="font-family: Calibri; font-size: 11pt; width: 100%;">

                         <tr>
                    <td colspan="4">
                        <p style="color:maroon; font-weight:bold;">Please Enter Person Type and CNIC Or Card No!</p>
                    </td>

                </tr>
                         <tr>
                              <td style="width: 140px; text-align: left;">Person Type:<span class="reqSpan">*</span>
                            </td>
                            <td style="width: 600px;">
                               <asp:DropDownList ID="ddlPersonType" runat="server">
                                     <asp:ListItem Value="">--Select--</asp:ListItem>
                                   <asp:ListItem Value="Employee">Resident</asp:ListItem>
                                    <asp:ListItem Value="EmployeeFamily">Resident Family</asp:ListItem>
                                    <asp:ListItem Value="Servant">Servant</asp:ListItem>
                                    <asp:ListItem Value="ServantFamily">Servant Family</asp:ListItem>
                                   <asp:ListItem Value="NonResident">Non Resident</asp:ListItem>
                                    <asp:ListItem Value="Visitor">PACS Visitor</asp:ListItem>
                                     <asp:ListItem Value="mctx_visitor">Visitor</asp:ListItem>
                                   
                               </asp:DropDownList>
                            </td>


                    <td>Enter CNIC:</td>
                    <td>
                        <asp:TextBox ID="nic" placeholder="Enter minimum 3 digits" class="numeric cnic" runat="server" autocomplete="off"></asp:TextBox></td>

                  
                    
                        </tr>
                        <tr>
                             <td>Enter Card No:</td>
                    <td>
                        <asp:TextBox ID="txtCardNo" runat="server" autocomplete="off"></asp:TextBox></td>

                            <td align="left">
                                <asp:TextBox ID="txtID" Text="0" Style="display: none;" runat="server"></asp:TextBox>
                            </td>


                            <td align="left">
                                <asp:Button ID="btnSearch" Text="Search" CssClass="btn" OnClientClick="return NewSearchPersonforCardIssueOrReturn1();" runat="server" />

                               
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>

    </table>

    <div id="divPersonInfo">
        <fieldset>
            <legend>Card Person Info</legend>
        
         <table id="tblDivPersonCardInfo" style="font-family: Calibri; font-size: 11pt; width: 100%;">
            <tr>
                <td>Card No:</td>
                <td> <asp:TextBox ID="txtDisplayCardNo" runat="server" autocomplete="off"></asp:TextBox></td>
                 <td>Name:</td>
                <td> <asp:TextBox ID="txtDisplayName" runat="server" autocomplete="off"></asp:TextBox></td>
                 <td>CNIC:</td>
                <td> <asp:TextBox ID="txtDisplayCNIC" runat="server" autocomplete="off"></asp:TextBox></td>
                <td><asp:TextBox ID="txtPID" Text="0" Style="display: none;" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                
                 <td>Card Type:</td>
                <td> <asp:DropDownList ID="ddlDisplayCardType" runat="server" autocomplete="off">
                    <asp:ListItem value=''>--Select--</asp:ListItem>
                    <asp:ListItem value='1'>Card Issue</asp:ListItem>
                    <asp:ListItem value='2'>Card Return</asp:ListItem>
                    <asp:ListItem value='3'>Duplicate Card Issue</asp:ListItem>
                    <asp:ListItem value='4'>Duplicate Card Return</asp:ListItem>

                     <asp:ListItem value='5'>Card Lost</asp:ListItem>
                    <asp:ListItem value='6'>Duplicate Card Lost</asp:ListItem>
                     </asp:DropDownList></td>
                 <td>Person Type:</td>
                <td> <asp:TextBox ID="txtDisplayPersonType" runat="server" autocomplete="off">


                     </asp:TextBox></td>
                 <td > Date:<span class="reqSpan">*</span></td>
                    <td >
                        
                           <asp:TextBox ID="txtCardDate" CssClass="date disable_past_dates req"  runat="server" style="width:60%;float: left; margin-right: 5px;"></asp:TextBox>
                         <rjs:popcalendar ID="Popcalendar2" Separator="/" Format="mm dd yyyy" Control="txtCardDate" runat="server" 
                                Font-Names="Tahoma" />
                     <%--   To-Today="true"--%>
                    </td>
                <td>
                <input type='button' onclick='UpdatePersonCard()'; class='btn' value='save' id='btnSave'/></td>
            </tr>
        </table>
            </fieldset>
    </div>
    <div id="divCasteDetails">
        <fieldset id="fldCasteDetails" >
            <legend>Person Details</legend>
             <div style="overflow: auto; width: 100%;">
                  
            <table id="tblPersonDetail" class="dataTable">
            </table>
                 </div>
        </fieldset>
    </div>

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
           // SearchPersonforCardIssueOrReturn();

        });

        function dataTable() {
            oTable = $("#tblPersonDetail").dataTable();
        }


        function NewSearchPersonforCardIssueOrReturn1() {
          
            var PersonType = $("select[id$='ddlPersonType']").val();
            var cnic = $("input[id$='nic']").val();
            var cardNo = $("input[id$='txtCardNo']").val();
            if (PersonType == "") {
                alert("Please Select Person Type!");
                return false;
            }
            if (cnic == "" && cardNo == "") {
                alert("Please Enter Person Card No. Or CNIC!");
                return false;
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "CardIssueOrReturn.aspx/SearchPerson",
                data: "{'PersonType':'" + PersonType + "','cnic':'" + cnic + "','cardNo':'" + cardNo + "'}",
                success: onsuccessSearchPersonforCardIssueOrReturn
            });
            return false;
        }
        function onsuccessSearchPersonforCardIssueOrReturn(msg) {
          
            var data = msg.d;
           
            if (data != null) {

                $("input[id$='txtDisplayCardNo']").val(data.Table[0].CardNumber);
                $("input[id$='txtDisplayName']").val(data.Table[0].Name);
                $("input[id$='txtDisplayCNIC']").val(data.Table[0].NIC);
                $("select[id$='ddlDisplayCardType']").val(data.Table[0].Type_id);
                $("input[id$='txtDisplayPersonType']").val(data.Table[0].PersonType);
                $("input[id$='txtCardDate']").val(data.Table[0].Date);
                $("input[id$='txtID']").val(data.Table[0].card_issueOrReturn_id);
                $("input[id$='txtPID']").val(data.Table[0].PID);
                SearchPersonforCardIssueOrReturnHistory();
            }
            else {
                alert("No Record Found!");
}
                return false;
            

        }
       
        function SearchPersonforCardIssueOrReturnHistory() {
            var PersonType = $("select[id$='ddlPersonType']").val();
            var cnic = $("input[id$='nic']").val();
            var cardNo = $("input[id$='txtCardNo']").val();
            if (PersonType == "") {
                alert("Please Select Person Type");
                return false;
            }
                
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "CardIssueOrReturn.aspx/SearchPersonCardHistory",
                data: "{'PersonType':'" + PersonType + "','cnic':'" + cnic + "','cardNo':'" + cardNo + "'}",
                success: onsuccessSearchPersonforCardIssueOrReturnHistory
            });
            return false;
        }
        function onsuccessSearchPersonforCardIssueOrReturnHistory(msg) {
            
            var data = msg.d;
if(data!=null){
            if (oTable != null) {
                oTable.fnClearTable();
                oTable.fnDestroy();
            }
            var tbl = "";
            tbl += "<thead>";
            tbl += "<tr>";
            tbl += "<th style='text-align:center;'>sr.</th>";
            tbl += "<th style='text-align:center;display:none;'>Black Listing ID</th>";
            tbl += "<th style='text-align:center;display:none;'>Person ID</th>";
            tbl += "<th style='text-align:center; white-space:nowrap;'>Card No</th>"; 
            tbl += "<th style='white-space:nowrap; text-align:left;'>Name</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>CNIC No.</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Card Type</th>";
          //  tbl += "<th style='white-space:nowrap; text-align:left;display:none'>Black List Date</th>";
            tbl += "<th style='text-align:center;'>Person Type</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Action Date</th>";
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            j = 0;
           // alert(data.Table[0].PID);
            //alert("There are " + Object.keys(data.Table).length + " languages.")

            var cardTypeID = "";
            for (var i = 0; i < Object.keys(data.Table).length; i++) {
                j++;
                //cardTypeID = data.Table[i].Type_id
                tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
                tbl += "<td id='txtDelete' align='center'> " + j + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.Table[i].card_issueOrReturn_id + "</td>";
                tbl += "<td style='cursor:Pointer;display:none;' id='txtPID" + i + "' align='center'>" + data.Table[i].PID + "</td>";
                tbl += "<td style='cursor:Pointer;' id='txtCardNo' align='center'>" + data.Table[i].CardNumber + "</td>";
                

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtName" + i + "'>" + data.Table[i].Name + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtNIC" + i + "'>" + data.Table[i].NIC + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' >" + data.Table[i].Type_Name + "</td>";
                //tbl += "<td style='text-align:left; white-space:nowrap;display:none' id='txtcommentsDate" + i + "'>" + data.Table[i].commentsDate + " </td>";



                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtPersonType" + i + "'>" + data.Table[i].PersonType + " </td>";

               // tbl += '<td><input name="ctl00$ContentPlaceHolder1$txtCardDate" type="text" id="ContentPlaceHolder1_txtCardDate" class="date disable_past_dates req" calendar="ContentPlaceHolder1_Popcalendar2" format="mm/dd/yyyy" dir="ltr" autocomplete="off" onfocus="__PopCalSetFocus(this, event);" style="width:60%;float: left; margin-right: 5px;"><span id="ContentPlaceHolder1_Popcalendar2" style="display:none" assembly="RJS.Web.WebControl.PopCalendar.Net.2008.dll" assemblyversion="8.0.2926.19199" popcalendarjsversion="1.0.1" popcalendarfunctionsjsversion="1.0.0"></span><span id="ContentPlaceHolder1_Popcalendar2_Control" onclick="__PopCalShowCalendar(&quot;ContentPlaceHolder1_txtCardDate&quot;,this)" style="cursor:pointer;"><img src="/PopCalendar2008/Calendar.gif" border="0" align="absmiddle"></span><link href="/PopCalendar2008/CSS/Classic.css" type="text/css" rel="stylesheet"></td>'
                tbl += "<td style='text-align:right; white-space:nowrap;' >"+data.Table[i].Date+"  </td>";
                tbl += "</tr>";
              //  $("#ddlPersonCardType" + i).val(cardTypeID);
            }
           
    //  dataTable();
}
else {

    tbl += "<tr><td style='cursor:default;background-color:white;' class='noRecordFound' colspan='10'>No Record Found</td></tr>";
}
tbl += "</tbody>";
tbl += "</table>";
$("#tblPersonDetail").html(tbl);
dataTable();
            return false;
        }

        function getRowID(rowID) {
            $("table[id$='tblPersonDetail'] tr").css("background-color", "white");
            $("#trmain" + rowID).css("background-color", "#6798c1");

        }


        

        function EditRecord(rowNo) {
            var ID = $("#txtID" + rowNo).html().trim();
           
            $("input[id$='txtID']").val(ID);

            var Caste_Name = $("#txtName" + rowNo).html().trim();
            $("select[id$='ddlPersonType']").val(Caste_Name);

           
            return false;
        }
        function UpdatePersonCard(rowNo) {

            
            //var ID = $("input[id$='txtID']").val();
           
            var card_issueOrReturn_id = $("input[id$='txtID']").val();
            var PID = $("input[id$='txtPID']").val();
            var Date = $("input[id$='txtCardDate']").val();
            var PersonType = $("input[id$='txtDisplayPersonType']").val();
            var CardTypeID = $("select[id$='ddlDisplayCardType']").val();
            var CardTypeName = $("select[id$='ddlDisplayCardType'] option:selected").text().trim();
            

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "CardIssueOrReturn.aspx/InsertUpdatePersonCard",
                    data: "{'PID':'" + PID + "','Date':'" + Date + "','PersonType':'" + PersonType + "','CardTypeID':'" + CardTypeID + "','CardTypeName':'" + CardTypeName + "','card_issueOrReturn_id':'" + card_issueOrReturn_id + "'}",
                    success: onsuccessUpdatePersonCard
                });
           
        }
        function onsuccessUpdatePersonCard() {
          //  $("#divMsg").html("Record Updated Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record Save/Updated successfully!");
            SearchPersonforCardIssueOrReturnHistory();
           // $("select[id$='ddlPersonType']").val("");
            //SearchPersonforCardIssueOrReturn();

            
           
            return false;
        }
    </script>
</asp:Content>

