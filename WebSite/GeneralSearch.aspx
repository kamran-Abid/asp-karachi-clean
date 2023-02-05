<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="GeneralSearch.aspx.cs" Inherits="GeneralSearch" %>

<%-- <%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>--%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


  

 
    <fieldset style="width:95%;">
        <legend>General Search Criteria</legend>
        <div  >
        <table id="tblCNICWiseReport" class="form">

             <tr>
                    <td colspan="5">
                        <p style="color:maroon; font-weight:bold;">Please Enter CNIC Or Card No!</p>
                    </td>

                </tr>
        <tr>
            <td class="right">Enter CNIC NO:</td>
            <td >
                <asp:TextBox ID="txtCNICNo" CssClass="cnic"  runat="server"></asp:TextBox>
            </td>
          <td>Enter Card No:</td>
                    <td>
                        <asp:TextBox ID="txtCardNo" runat="server" onkeyup="checkCnic()"  autocomplete="off"></asp:TextBox></td>
                    <td>


         
                
                <asp:Button ID="btnSearch" Text="Search"  CssClass="btn"  OnClientClick="return getPerson();" runat="server" />

                
            </td>
        </tr>
    </table>
             </div>
</fieldset>
   


    
        <fieldset id="fldPersonDetails" style="width:95% ;">
            <legend>Person Details</legend>
            <div id="divPersonDetails" style="overflow: auto;width:100%">
            <table id="tblPersonDetails" class="dataTable">
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
          //  getPerson();

        });

        function checkCnic() {
            if ($("input[id$='txtCNICNo']").val() != "") {
                $("input[id$='txtCNICNo']").val("");
            }
        }

        function dataTable() {
            oTable = $("#tblPersonDetails").dataTable();
        }

       
        function getPerson() {
            //if (!validate("tblCNICWiseReport")) {
            var CNIC = $("input[id$='txtCNICNo']").val().trim();
            var CardNo = $("input[id$='txtCardNo']").val();
            if (CNIC == "" && CardNo == "") {
                alert("Please Enter CNIC Or Card Number!");
                return false;
            }

           
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "GeneralSearch.aspx/getPersonRecord",
                data: "{'CNIC':'" + CNIC + "','CardNo': '" + CardNo + "'}",
                success: onsuccessgetPerson
            });
           // }
            return false;
        }
        function onsuccessgetPerson(msg) {
            debugger;
            var data = msg.d;
           

            //alert(data.Table[0].NIC);
            if (oTable != null) {
                oTable.fnClearTable();
                oTable.fnDestroy();
            }
            var tbl = "";
            tbl += "<thead>";
            tbl += "<tr>";
            
            tbl += "<th style='text-align:left; white-space:nowrap; display:nones;'>Card No.</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Person Name</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>CNIC NO</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Owner Name</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Owner CNIC</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Person Type</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Person Status</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Person Picture</th>";
          

            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            if (data == null)
            {
                tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' >";
                tbl += "<td colspan='7' style='text-align:left; white-space:nowrap;color:Maroon;font-weight:bold;text-align:center;' id='txtPersonName" + 0 + "'>No Record Found</td>";
                tbl += "</tr>";
            }
            else
            {
                if (data.Table[0].Name != "No Record Found"){
                    for (var i = 0; i < data.Table.length; i++) {
                        tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' >";

                        tbl += "<td style='text-align:left; white-space:nowrap; display:nones;' id='txtID" + i + "'>" + data.Table[i].CardNumber + "</td>";

                        tbl += "<td style='text-align:left; white-space:nowrap;' id='txtPersonName" + i + "'>" + data.Table[i].Name + "</td>";
                        tbl += "<td style='text-align:left; white-space:nowrap;' id='dkkd" + i + "'>" + data.Table[i].NIC + "</td>";

                        tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.Table[i].OwnerName + "</td>";
                        tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.Table[i].ownerNic + "</td>";
                        tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.Table[i].PersonType + " </td>";

                        tbl += "<td style='text-align:left; white-space:nowrap;' id='txtStatus" + i + "'>" + data.Table[i].UserStatus + "</td>";
                        //tbl += "<td style='text-align:right; white-space:nowrap;display:none;' id='txtPictureww" + i + "'>" + data.Table[i].Picture + " </td>";
                        tbl += "<td style='text-align:center;' id='txtPicture" + i + "' class='CNICEmpImage'><img src='../RMS/CallBack/GetImageDatafromDB.aspx?PrimaryKeyIDValue=" + data.Table[i].PID + "&tableName=" + data.Table[i].tableName + "&ImagecolumnName=NewPhoto&PrimaryKeyColumnName=" + data.Table[i].PrimaryKeyColumnName + "' height='50px' width='50px'></td>";

                        //tbl += "<td class='CNICEmpImage'><img src='../RMS/CallBack/GetImageDatafromDB.aspx?PrimaryKeyIDValue=49&tableName=Employee&ImagecolumnName=NewPhoto&PrimaryKeyColumnName=EID' height='50px' width='50px'></td>";

                        tbl += "</tr>";
                    }
                
                }
                else {
                    tbl += "<tr id='trmain' style='cursor:default;background-color:white;' >";
                    tbl += "<td style='text-align:center; white-space:nowrap;color:maroon;font-weight:bold;' colspan='7'>No Record Found!</td>";
                    tbl += "</tr>";
                }
            }
            tbl += "</tbody>";
            tbl += "</table>";
            $("#tblPersonDetails").html(tbl);
          //dataTable();
            return false;
        }

        function getRowID(rowID) {
            $("table[id$='tblPersonDetails'] tr").css("background-color", "white");
            $("#trmain" + rowID).css("background-color", "#6798c1");

        }
        
            
    </script>
</asp:Content>

