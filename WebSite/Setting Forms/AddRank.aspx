<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="AddRank.aspx.cs" Inherits="AddRank" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   
     
  

       <table style="width:100%;margin-top:0%;vertical-align:top;">
        <tr>
                <td>
                    <div class="sussessMessageDiv" id="divSuccessMsg" style="display: none">&nbsp;
                    </div>
                     <div class="ErrorMessageDiv" id="ErrorMessageDiv" style="display: none">&nbsp;
                    </div>
                </td>
            </tr>
        <tr>
            <td>
               <fieldset>
                   <legend>Add/Modified Rank</legend>
               
                    <table  style="font-family: Calibri; font-size: 11pt;width:100%;" >
                    <tr>

                        <td style="width:140px;text-align:left;display:none">
                            <asp:Label ID="Label1" Text="Select Category:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 600px;display:none">
                            <asp:DropDownList ID="ddlCategory" runat="server">
                                <asp:ListItem Value="0" Selected="True">Select</asp:ListItem>
                                <asp:ListItem Value="1">Uniform Officers</asp:ListItem>                                 
                                <asp:ListItem Value="3">Uniform Staff</asp:ListItem>
                              
                            </asp:DropDownList>
                        </td>
                        <td style="width:140px;text-align:left;">
                            <asp:Label ID="lblRankName" Text="Rank:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 600px;">
                            <asp:TextBox ID="txtRankName" Width="95%"  placeholder="Enter Rank" runat="server" BackColor="White" ></asp:TextBox>
                        </td> 
                    </tr>
                        <tr>
                              <td colspan="3"  align="left">
                            <asp:TextBox ID="txtID" Style="display: none;" runat="server"></asp:TextBox>
                        </td>
                        
                   
                        <td align="left">
                            <asp:Button ID="btnSave" Text="Add" CssClass="btn" OnClientClick="return SaveRank();" runat="server" />
                        
                            <asp:Button ID="btnClearRank" Text="Clear" CssClass="btn" OnClientClick="return ClearRank();" runat="server" />
                        
                            <asp:Button ID="btnUpdate" Text="Update" CssClass="btn" Style="display: none;" OnClientClick="return UpdateRank();" runat="server" />
                        </td>
                        </tr>

                </table>
                </fieldset>
            </td>
        </tr>

    </table>
     <div id="divRankDetails" >
            <fieldset id="fldRankDetails">
                <legend>Ranks Details</legend>
                 <div style="overflow: auto; width: 100%;">
                  
            
                <table id="tblRankDetails" class="dataTable">
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
        getRank();
        
    });
    
      function dataTable() {
          oTable = $("#tblRankDetails").dataTable();
      }
   
      function SaveRank()
      {
          var i = 0;
          if ($("#tblRankDetails tr").length - 1>1){
          for (i = 0; i < $("#tblRankDetails tr").length - 1; i++) {

              if ($("#txtRankName" + i).html().toUpperCase().trim() == $("input[id$='txtRankName']").val().toUpperCase().trim()) {
                  alert("Rank  " + $("input[id$='txtRankName']").val() + " is already added!");
                  $("input[id$='txtRankName']").val("");
                  return false;
              }
              // alert("test")
          }
          }
          var Rank = $("input[id$='txtRankName']").val().trim();
          var Category = $("select[id$='ddlCategory']").val().trim();

          //if (Category == "0") {
          //    alert("Please Select Category!");
          //    return false;
          //}
          if (Rank == "")
            {
                alert("Please Enter Rank Name!");
                return false;
        }
        
                $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/SaveRanks",
                data: "{'Rank':'" + Rank + "','Category':'" + Category + "'}",
                success:onsuccessSaveRank,
                error:onretrieveSaveRankError 
                });
        return false; 
      }
      function onsuccessSaveRank(msg)
      {
          $("#divSuccessMsg").show();
          $("#divSuccessMsg").html("");
          $("#divSuccessMsg").html("Record Successfully Saved!");
          $("#divSuccessMsg").fadeOut(6000);
        $("input[id$='txtRankName']").val("");
        getRank();
        return false;
      }
      function onretrieveSaveRankError(msg)
      {
          
        alert("Error In Saving Data!");
        return false; 
      }
      function ClearRank()
      {
        $("input[id$='txtRankName']").val("");
         
        $("input[id$='btnUpdate']").hide();
        $("input[id$='btnSave']").attr("disabled", false);
        return false;
      }
      function getRank()
      {
        $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "Settingwebmethods.aspx/getRankDetail",
            data: "{}", 
            success:onsuccessgetRank,
            error:onretrievegetRank 
        });
        return false; 
      }
      function onsuccessgetRank(msg)
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
                tbl += "<th style='text-align:center;width:8%;'>Delete</th>";
                tbl += "<th style='text-align:center; white-space:nowrap;'>Edit</th>";
                tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Rank ID</th>";
                
                tbl += "<th style='white-space:nowrap; text-align:left;'>Rank Name</th>";
                tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Category ID</th>";
              
                tbl += "<th style='white-space:nowrap; text-align:left;display:none;'>Category</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
                for (var i = 0; i < data.RankDetail.length; i++) {                   
                    tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
                    tbl += "<td id='txtDelete' align='center'> <input  type='image' src='../images/Cross2.png' onclick='return DeleteRankRecord(" + i + ");'> </td>";
                            tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord("+i+");'><img src='../images/Edit.png'></td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.RankDetail[i].Rank_ID + "</td>";
                            
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtRankName" + i + "'>" + data.RankDetail[i].Rank_Name + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='Person_CatID" + i + "'>" + data.RankDetail[i].Person_CatID + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;display:none;' id='txtPerson_CatName" + i + "'>" + data.RankDetail[i].Person_CatName + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.RankDetail[i].created_by + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.RankDetail[i].created_date + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.RankDetail[i].modified_by + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.RankDetail[i].modified_date + " </td>";
                      tbl += "</tr>";
                }   
                tbl += "</tbody>";
                tbl += "</table>";
                $("#tblRankDetails").html(tbl);
                dataTable();
                return false; 
      }

      function getRowID(rowID) {
          $("table[id$='tblRankDetails'] tr").css("background-color", "white");
          $("#trmain" + rowID).css("background-color", "#6798c1");

      }
      function onretrievegetRank()
      {
        alert("Error In Loading Details!");
        return false;
      }

      function DeleteRankRecord(rowNo) {
          

          var Rank_ID = $("#txtID" + rowNo).html();
          
              if (confirm("Are you sure you wish to delete this Record?")) {
                  $.ajax({
                      type: "POST",
                      contentType: "application/json; charset=utf-8",
                      url: "Settingwebmethods.aspx/DeleteRank",
                      data: "{'Rank_ID':'" + Rank_ID + "'}",
                      success: onsuccessDeleteData,
                      error: OnretrievePhysicianError
                  });
              
              return false;
          }
          else
                  return false;

      }

      function onsuccessDeleteData(msg) {



          $("#divSuccessMsg").show();
          $("#divSuccessMsg").html("");
          $("#divSuccessMsg").html("Record Successfully Deleted!");
          $("#divSuccessMsg").fadeOut(6000);
          getRank();
          return false;

      }

      function OnretrievePhysicianError(msg) {
         // getRankalRecod();
          alert(msg.responseText);
          $("#ErrorMessageDiv").show();
          $("#ErrorMessageDiv").html("");
          $("#ErrorMessageDiv").html("Error in Record Deleting!" );
          $("#ErrorMessageDiv").fadeOut(6000);
          return false;
      }

      function EditRecord(rowNo)
      {
          var ID = $("#txtID"+rowNo).html().trim();
          $("input[id$='txtID']").val(ID);

          var DEPT_NAME = $("#txtRankName"+rowNo).html().trim();
          $("input[id$='txtRankName']").val(DEPT_NAME);
          var cateName = $("#Person_CatID" + rowNo).html().trim();
          $("select[id$='ddlCategory']").val(cateName);
          $("input[id$='btnUpdate']").show();
          $("input[id$='btnSave']").attr("disabled", true);
          return false;
      }
      function UpdateRank()
      {
          var Rank_ID = $("input[id$='txtID']").val();

          var Rank = $("input[id$='txtRankName']").val();
          var Category = $("select[id$='ddlCategory']").val().trim();
          var i = 0;
          if ($("#tblRankDetails tr").length - 1 > 1) {
              for (i = 0; i < $("#tblRankDetails tr").length - 1; i++) {

                  if ($("#txtRankName" + i).html().toUpperCase().trim() == $("input[id$='txtRankName']").val().toUpperCase().trim()) {
                      alert("Rank  " + $("input[id$='txtRankName']").val() + " is already added!");
                      //$("input[id$='txtRankName']").val("");
                      return false;
                  }
                  // alert("test")
              }
          }
      
          if (Rank == "")
            {
                alert("Please Enter Rank Name!");
                return false;
        }
       
        $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "Settingwebmethods.aspx/UpdateRank",
            data: "{'Rank_ID':'" + Rank_ID + "','Rank':'" + Rank + "','Category':'" + Category + "'}",
            success:onsuccessUpdateRanks,
            error:onretrieveUpdateRanks 
        });
        return false; 
      }
      function onsuccessUpdateRanks()
      {
          $("#divSuccessMsg").show();
          $("#divSuccessMsg").html("");
          $("#divSuccessMsg").html("Record Successfully Updated!");
          $("#divSuccessMsg").fadeOut(6000);
          $("input[id$='txtRankName']").val("");
          getRank();

        ClearRank();
        getRank();
        return false;
      }
      function onretrieveUpdateRanks()
      {
        alert("Error In Updating Record!");
        return false;
      }
     
    
    
    
    </script>
</asp:Content>

