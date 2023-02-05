<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="Declined_To_Pending.aspx.cs" Inherits="Declined_To_Pending" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:ScriptManager runat="server"></asp:ScriptManager>

    <%--<script src="../../js/jquery.dataTables.min.js" type="text/javascript"></script>--%>
    <script src="../../js/BlockUI.js" type="text/javascript"></script>
    <script src="../../js/FieldValidation.js" type="text/javascript"></script>

    <link rel="stylesheet" type="text/css" href="DataTables/datatables.min.css"/>
 
    <script type="text/javascript" src="DataTables/datatables.min.js"></script>


    <style type="text/css">
        .dataTable
        {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            border-collapse: collapse;
            border: 1px solid #999999;
            width: 100%;
            font-size: 12px;
        }
        .dataTable td, .dataTable th
        {
            border: 1px solid #999999;
            padding: 3px 5px;
            margin: 0px;
        }
        .dataTable thead th
        {
            background-color: #cccccc;
            color: #444444;
            font-weight: bold;
            text-align: left;
        }
        .dataTable thead a
        {
            text-decoration: none;
            color: #444444;
        }
        .dataTable thead a:hover
        {
            text-decoration: underline;
        }
        /* Firefox has missing border bug! https://bugzilla.mozilla.org/show_bug.cgi?id=410621 *//* Firefox 2 */html /**/ /**/ body .dataTable, x:-moz-any-link
        {
            margin: 1px;
        }
        /* Firefox 3 */html /**/ /**/ body .dataTable, x:-moz-any-link, x:default
        {
            margin: 1px;
        }
        .style2
        {
            width: 189px;
        }
        .style3
        {
            width: 149px;
        }
        .style4
        {
            width: 184px;
        }
        .style7
        {
            width: 158px;
        }
        .style8
        {
            width: 124px;
        }
        .style9
        {
            width: 266px;
        }
    </style>

    <div id="tabs" style="width:100%;">
        
        <%--<div id="AddITProj" style="width: 98%">
            <fieldset id="fldAddITProj" runat="server" style="width: 98%">
                <legend>Visitor Name</legend>
                <table style="width:100%; font-family: Calibri; font-size: 12px;">
                    <tr>
                        <td style="width:10%; float:left;">
                            <asp:Label ID="lblProjName" Text="Visitor Name:" runat="server"></asp:Label>
                        </td>
                        <td style="width:25%; float:left;">
                            <asp:TextBox ID="txtProjName" runat="server"></asp:TextBox>
                        </td>
                        <td style="width:10%; float:left;">
                            <asp:Button ID="btnSave" Text="Add" Style="background-color: #273D5F; color: White;"
                                Width="75px" OnClientClick="return SaveProj();" runat="server" />
                        </td>
                        <td style="width:10%; float:left;">
                            <asp:Button ID="btnClear" Text="Clear" Style="background-color: #273D5F; color: White;"
                                Width="75px" OnClientClick="return Clear();" runat="server" />
                        </td>
                        <td style="width:82px; float:left;">
                            <asp:Button ID="btnUpdate" Text="Update" Style="background-color: #273D5F; color: White;
                                display: none;" Width="75px" OnClientClick="return updateITProj();" runat="server" />
                        </td>
                        <td style="width:82px; float:left;">
                            <asp:TextBox ID="txtProjID" Style="display: none;" runat="server"></asp:TextBox>
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>--%>
	
        <div id="divITProjDetails" style="overflow: auto; width:99%; height: 100%;" runat="server">
            <%--width: 940px;--%>
            <fieldset id="fldITProjDetails" runat="server" style="width: 97%">
                <legend>Visitors Detail</legend>
                <table id="tblITProjDetails" class="dataTable" style="width:95%;">
                </table>
	</fieldset>
        </div>
	
    </div>

    <script type="text/javascript" language="javascript">
    var oTable;
    $(document).ready(function(){
            getITProj();
    });
      //function dataTable() {
      //    oTable = $("#tblITProjDetails").dataTable({
      //          bPaginate: true,
      //          bJQueryUI: true,
      //          oLanguage:{"sSearch":"Filter: "}               
      //      });
        //}

    function dataTable() { $("#tblITProjDetails").dataTable({}); }


      //function SaveProj()
      //{
      //  var ProjName = $("input[id$='txtProjName']").val();
      //  if(ProjName=="")
      //      {
      //          alert("Please Enter Project Name!");
      //          return false;
      //      }
      //          $.ajax({
      //          type: "POST",
      //          contentType:"application/json; charset=utf-8",
      //          url: "Declined_To_Pending.aspx/SaveITProject",
      //          data: "{'ProjName':'"+ProjName+"'}", 
      //          success:onsuccessSaveProj,
      //          error:onretrieveSaveProjError 
      //          });
      //  return false; 
      //}
      //function onsuccessSaveProj()
      //{
      //  alert("Data Successfully Saved!");
      //  $("input[id$='txtProjName']").val("");
      //  getITProj();
      //  return false;
      //}
      //function onretrieveSaveProjError()
      //{
      //  alert("Error In Saving Data!");
      //  return false; 
      //}
      function Clear()
      {
        $("input[id$='txtProjName']").val("");
        $("input[id$='btnUpdate']").hide();
        $("input[id$='btnSave']").attr("disabled", false);
        return false;
      }
      function getITProj()
      {
        $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "Declined_To_Pending.aspx/GetITProjDetails",
            data: "{}", 
            success:onsuccessgetITProj,
            error:onretrievegetITProj 
        });
        return false; 
      }
      function onsuccessgetITProj(msg)
      {
        var data = msg.d;
        if(oTable !=null)
                    {
                      oTable.fnClearTable();
                      oTable.fnDestroy();
                    }  
          var tbl = "";
                tbl += "<thead>";
                tbl += "<tr>";
                tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Visitor ID</th>";
                tbl += "<th style='text-align:left; white-space:nowrap;'>Sr#</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Visitor Name</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Company Name</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Date of Visit</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Status</th>";
                //tbl += "<th style='text-align:center; white-space:nowrap;'>Approve</th>";
                tbl += "<th style='text-align:center; white-space:nowrap;'>Pending</th>";
                tbl += "<th style='text-align:left; white-space:nowrap;'>Delete</th>";
                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
          for (var i = 0; i < data.ProjDetails.length; i++) {    
              var j = i + 1;
              tbl += "<tr>";
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtProjID"+i+"'>" + data.ProjDetails[i].V_ID + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;'id='SR#"+i+"'>" + j + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtVisitorName" + i + "'>" + data.ProjDetails[i].Full_Name + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtVisitorName" + i + "'>" + data.ProjDetails[i].Company_Name + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtdateofVisit"+i+"'>" + data.ProjDetails[i].DateofVisit + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtStatus" + i + "'>" + data.ProjDetails[i].Status + " </td>";
                            //tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return ApproveStatus("+i+");'><img src='images/Tick1.png' width='40px' height='40px'></td>";                        
                            tbl += "<td style='cursor:Pointer;' id='txtdelete' align='center' onclick='return DeclineStatus(" + i + ");'><img src='images/restore.png' width='45px' height='60px'> </td>";

                            tbl += "<td style='cursor:Pointer;' id='txtdelete' align='center' onclick='return DeleteRecord(" + i + ");'><img src='images/Cross3.png' width='45px' height='60px'> </td>";
                            tbl += "</tr>";
                }   
                tbl += "</tbody>";
                tbl += "</table>";
                $("#tblITProjDetails").html(tbl);
                dataTable();
                return false; 
      }
      function onretrievegetITProj()
      {
        alert("Error In Loading Details!");
        return false;
      }

      function DeleteRecord(rowNo) {
          var ProjID = $("#txtProjID" + rowNo).html().trim();
          $.ajax({
              type: "POST",
              contentType: "application/json; charset=utf-8",
              url: "Declined_To_Pending.aspx/DeleteVisitor",
              data: "{'Visitor_ID':'" + ProjID + "'}",
              success: onsuccessDeleteRecord,
              error: onretrieveDeleteRecord
          });
          return false;
      }
      function onsuccessDeleteRecord() {
          alert("Record Deleted Successfully!");
          location.reload();
          //getITProj();
          return false;
      }
      function onretrieveDeleteRecord() {
          alert("Error In Deleting Record!");
          return false;
      }

      //  function ApproveStatus(rowNo)
      //  {
      //      var ProjID = $("#txtProjID" + rowNo).html().trim();
      //    $("input[id$='txtProjID']").val(ProjID);
      //  $.ajax({
      //      type: "POST",
      //      contentType:"application/json; charset=utf-8",
      //      url: "Approved_Appointment.aspx/ApprovedStatus",
      //      data: "{'Visitor_ID':'" + ProjID + "'}", 
      //      success:onsuccessApprove,
      //      error:onretrieveApprove 
      //  });
      //  return false;
      //  }
      
      //function onsuccessApprove()
      //{
      //  alert("Visitor Approve Successfully!");
      //  getITProj();
      //  Clear();
      //  return false;
      //}
      //function onretrieveApprove()
      //{
      //  alert("Error In Approving Visitor!");
      //  return false;
      //}

        function DeclineStatus(rowNo)
        {
            var ProjID = $("#txtProjID" + rowNo).html().trim();
          $("input[id$='txtProjID']").val(ProjID);
        $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "Declined_To_Pending.aspx/DeclineStatus",
            data: "{'Visitor_ID':'" + ProjID + "'}", 
            success:onsuccessDecline,
            error:onretrieveDecline 
        });
        return false;
        }
      
      function onsuccessDecline()
      {
          alert("Visitor Decline Successfully!");
          location.reload();
        //getITProj();
        //Clear();
        return false;
      }
      function onretrieveDecline()
      {
        alert("Error In Declining Visitor!");
        return false;
      }
    </script>
</asp:Content>
