<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="BlackListing.aspx.cs" Inherits="BlackListing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <link href="css/dataTable.css" rel="stylesheet" />
    <table style="width: 100%; margin-top: 0%;">

        <tr>
            <td>
                <fieldset>
                    <legend>Add/Modified Black Listing</legend>

                    <table id="tblCaste" style="font-family: Calibri; font-size: 11pt; width: 100%;">
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


                            <td align="left">
                                <asp:TextBox ID="txtID" Style="display: none;" runat="server"></asp:TextBox>
                            </td>


                            <td align="left">
                                <asp:Button ID="btnSearch" Text="Search" CssClass="btn" OnClientClick="return SeachBlackListing();" runat="server" />

                               
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </td>
        </tr>

    </table>
    <div id="divCasteDetails">
        <fieldset id="fldCasteDetails" >
            <legend>Black Listing Details</legend>
             <div style="overflow: auto; width: 100%;">
                  
            <table id="tblBlackListingDetails" class="dataTable">
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
           // SeachBlackListing();

        });

        function dataTable() {
            oTable = $("#tblBlackListingDetails").dataTable();
        }

        function SaveBlackListing() {
            var i = 0;
            if ($("#tblBlackListingDetails tr").length - 1 > 1) {
                for (i = 0; i < $("#tblBlackListingDetails tr").length - 1; i++) {

                    if ($("#txtName" + i).html().toUpperCase().trim() == $("select[id$='ddlPersonType']").val().toUpperCase().trim()) {
                        alert("Caste " + $("select[id$='ddlPersonType']").val() + " is already added!");
                        $("select[id$='ddlPersonType']").val("");
                        return false;
                    }
                    // alert("test")
                }
            }
            if (!validate("tblCaste")) {
                var Caste_Name = $("select[id$='ddlPersonType']").val().trim();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "BlackListing.aspx/SeachBlackListing",
                    data: "{'Caste_Name':'" + Caste_Name + "'}",
                    success: onsuccessSeachBlackListing
                });
            }
            return false;
        }
        function onsuccessSaveBlackListing(msg) {
            //$("#divMsg").html("Record Successfully Saved!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record saved successfully!");
            
            SeachBlackListing();
            return false;
        }
       
        function SeachBlackListing() {
            var PersonType = $("select[id$='ddlPersonType']").val();
            if (PersonType == "") {
                alert("Please Select Person Type");
                return false;
            }
                
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "BlackListing.aspx/SeachBlackListingDetail",
                data: "{'PersonType':'" + PersonType + "'}",
                success: onsuccessSeachBlackListing
            });
            return false;
        }
        function onsuccessSeachBlackListing(msg) {
            
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
            tbl += "<th style='white-space:nowrap; text-align:left;width:26%;'>Black List Reference</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;display:none'>Black List Date</th>";
            tbl += "<th style='text-align:center;'>Person Type</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Save/Update</th>";
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            j = 0;
           // alert(data.Table[0].PID);
            //alert("There are " + Object.keys(data.Table).length + " languages.")

           
            for (var i = 0; i < Object.keys(data.Table).length; i++) {
                j++;

                tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
                tbl += "<td id='txtDelete' align='center'> " + j + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.Table[i].BlackListingID + "</td>";
                tbl += "<td style='cursor:Pointer;display:none;' id='txtPID" + i + "' align='center'>" + data.Table[i].PID + "</td>";
                tbl += "<td style='cursor:Pointer;' id='txtCardNo' align='center'>" + data.Table[i].CardNumber + "</td>";
                

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtName" + i + "'>" + data.Table[i].Name + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtNIC" + i + "'>" + data.Table[i].NIC + "</td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' ><input type='text' id='txtComments" + i + "' value='" + data.Table[i].comments + "'></td>";
                tbl += "<td style='text-align:left; white-space:nowrap;display:none' id='txtcommentsDate" + i + "'>" + data.Table[i].commentsDate + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtPersonType" + i + "'>" + data.Table[i].PersonType + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'><input type='button' onclick='UpdateBlackListing(" + i + ")'; class='btn' value='save' id='btnSave'> </td>";
                tbl += "</tr>";
            }
           
    //  dataTable();
}
else {

    tbl += "<tr><td style='cursor:default;background-color:white;' class='noRecordFound' colspan='10'>No Record Found</td></tr>";
}
tbl += "</tbody>";
tbl += "</table>";
$("#tblBlackListingDetails").html(tbl);
dataTable();
            return false;
        }

        function getRowID(rowID) {
            $("table[id$='tblBlackListingDetails'] tr").css("background-color", "white");
            $("#trmain" + rowID).css("background-color", "#6798c1");

        }


        

        function EditRecord(rowNo) {
            var ID = $("#txtID" + rowNo).html().trim();
            $("input[id$='txtID']").val(ID);

            var Caste_Name = $("#txtName" + rowNo).html().trim();
            $("select[id$='ddlPersonType']").val(Caste_Name);

           
            return false;
        }
        function UpdateBlackListing(rowNo) {

            
         
            var BlackListingID = $("#txtID" + rowNo).html().trim();
            var BlackListComments = $("#txtComments" + rowNo).val().trim();
            var PersonType = $("#txtPersonType" + rowNo).html().trim();
            var PersonID = $("#txtPID" + rowNo).html();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "BlackListing.aspx/InsertUpdateBlackListing",
                    data: "{'BlackListingID':'" + BlackListingID + "','BlackListComments':'" + BlackListComments + "','PersonType':'" + PersonType + "','PersonID':'" + PersonID + "'}",
                    success: onsuccessUpdateBlackListing
                });
           
        }
        function onsuccessUpdateBlackListing() {
          //  $("#divMsg").html("Record Updated Successfully!").removeClass("error").addClass("success").show();
            showSuccessMsg("Record Updated successfully!");
           // $("select[id$='ddlPersonType']").val("");
            SeachBlackListing();

            
           
            return false;
        }
    </script>
</asp:Content>

