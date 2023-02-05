<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="BusinessCommunity.aspx.cs" Inherits="Setting_Forms_BusinessCommunity" %>

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
                   <legend>Business Community</legend>
               
                    <table  style="font-family: Calibri; font-size: 11pt;width:100%;" >
                    <tr>
                        <td style="width:140px;text-align:left;">
                            <asp:Label ID="lblBusinessName" Text="Business Name:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 600px;">
                            <asp:TextBox ID="txtBusinessName" Width="95%"   class="alphanumeric" runat="server" BackColor="White" ></asp:TextBox>
                        </td>
                        
                       
                        <td  align="left">
                           <asp:TextBox ID="txtID" style="display:none;"  runat="server"></asp:TextBox>
                        </td>
                        
                   
                        <td align="left">
                            <asp:Button ID="btnSave" Text="Add" CssClass="btn" OnClientClick="return SaveBusinessCommunity();" runat="server" />

                             <asp:Button ID="btnUpdate" Text="Update" style="display:none;" CssClass="btn" OnClientClick="return UpdateBusinessCommunity();" runat="server" />
                        
                            <asp:Button ID="btnClearBusinessCommunity" Text="Clear" CssClass="btn" OnClientClick="return ClearBusinessCommunity();" runat="server" />
             </td>
                    </tr>
                </table>
                </fieldset>
            </td>
        </tr>

    </table>
     <div id="divGetBusinessDetails"  >
            <fieldset id="fldGetBusinessDetails" >
                <legend>Business Details</legend>
                 <div style="overflow: auto; width: 100%;">
                  
            
                
                  <table id="tblBusinessCommunityDetails" class="dataTable">
                </table>
            </div>         
	</fieldset>
        </div>

      <script type="text/javascript">
         var oTable;

       //  $(document).ajaxStart(blockUI).ajaxStop(unblockUI);

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
        getBusinessCommunity();
        
    });
    
      function dataTable() {
          oTable = $("#tblBusinessCommunityDetails").dataTable();
      }
   
      function SaveBusinessCommunity()
      {
      //    alert('calling');
          var BusinessCommunity = $("input[id$='txtBusinessName']").val().trim();
          if (BusinessCommunity == "")
            {
                alert("Please Enter Business Name!");
                return false;
          }
                $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/SaveBusinessCommunity",
                data: "{'BusinessName':'" +BusinessCommunity + "'}",
                success: onsuccessSaveBusinessCommunity,
                error: onretrieveSaveFAError
                });
        return false; 
      }
      function onsuccessSaveBusinessCommunity(msg)
      {
          $("#divSuccessMsg").show();
          $("#divSuccessMsg").html("");
          $("#divSuccessMsg").html("Record Successfully Saved!");
          $("#divSuccessMsg").fadeOut(6000);
          $("input[id$='txtBusinessName']").val("");
          ClearBusinessCommunity();
       getBusinessCommunity();
        return false;
      }
      function onretrieveSaveFAError(msg)
      {
          
        alert("Error In Saving Data!");
        return false; 
      }
      function ClearBusinessCommunity()
      {
          $("input[id$='txtBusinessName']").val("");
          $("input[id$='txtID']").val("");
          $("input[id$='btnUpdate']").hide();
          $("input[id$='btnSave']").show();
        return false;
      }
      function getBusinessCommunity()
      {
      //   alert('calling');
        $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "Settingwebmethods.aspx/getBusinessCommunity",
            data: "{}", 
            success: onsuccessgetBusinessCommunity,
            error: onretrievegetBusinessCommunity
        });
        return false; 
      }
      function onsuccessgetBusinessCommunity(msg)
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
                tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>BusinessName ID</th>";
                tbl += "<th style='text-align:left; white-space:nowrap; '>BusinessCommunityName </th>";
                
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
                for (var i = 0; i < data.BusinessCommunityDetail.length; i++) {
                    tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
                    tbl += "<td id='txtDelete' align='center'> <input  type='image' src='../images/Cross2.png' onclick='return DeleteBusinessNameRecord(" + i + ");'> </td>";
                            tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord("+i+");'><img src='../images/Edit.png'></td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.BusinessCommunityDetail[i].ID + "</td>";
                            
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtBusinessCommunityName" + i + "'>" + data.BusinessCommunityDetail[i].BusinessName + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.BusinessCommunityDetail[i].CreatedBy + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.BusinessCommunityDetail[i].created_date + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.BusinessCommunityDetail[i].ModifyBy + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.BusinessCommunityDetail[i].modified_date + " </td>";
                      tbl += "</tr>";
                }   
                tbl += "</tbody>";
                tbl += "</table>";
                $("#tblBusinessCommunityDetails").html(tbl);
              // dataTable();
                return false; 
      }

      function getRowID(rowID) {
          $("table[id$='BusinessCommunityDetails'] tr").css("background-color", "white");
          $("#trmain" + rowID).css("background-color", "#6798c1");

      }
      function onretrievegetBusinessCommunity()
      {
        alert("Error In Loading Details!");
        return false;
      }

      function DeleteBusinessNameRecord(rowNo) {
          
          var ID = $("#txtID" + rowNo).html();
          //alert(ID);
          if (confirm("Are you sure you wish to delete this Record?")) {
              $.ajax({
                  type: "POST",
                  contentType: "application/json; charset=utf-8",
                  url: "Settingwebmethods.aspx/DeleteBusinessCommunity",
                  data: "{'ID':'" + ID + "'}",
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
          getBusinessCommunity();
          return false;

      }

      function OnretrievePhysicianError(msg) {
          getBusinessCommunity();
         // alert(msg.responseText);
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

          var Business_Name = $("#txtBusinessCommunityName" + rowNo).html().trim();
          $("input[id$='txtBusinessName']").val(Business_Name);
          
          $("input[id$='btnUpdate']").show()
          $("input[id$='btnSave']").hide()
          return false;
      }
      function UpdateBusinessCommunity()
      {
         
          var ID = $("input[id$='txtID']").val();

          var BusinessCommunity = $("input[id$='txtBusinessName']").val();
          debugger;
          if (BusinessCommunity == "")
            {
                alert("Please Enter Business Name!");
                return false;
          }
          //var i = 0;
          //if ($("#tblFamilyCategoryDetails tr").length - 1 > 1) {
          //    for (i = 0; i < $("#tblFamilyCategoryDetails tr").length - 1; i++) {

          //        if ($("#txtFamilyCategoryName" + i).html().toUpperCase().trim() == $("input[id$='txtFamilyCategoryName']").val().toUpperCase().trim()) {
          //            alert("FamilyCategory " + $("input[id$='txtFamilyCategoryName']").val() + " is already added!");
          //            //$("input[id$='txtFamilyCategoryName']").val("");
          //            return false;
          //        }
          //        // alert("test")

          //    }
          //}
          //alert('calling');
        $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "Settingwebmethods.aspx/UpdateBusinessCommunity",
            data: "{'BusinessName':'" + BusinessCommunity + "','ID':'" + ID + "'}",
            success: onsuccessUpdateBusinessCommunity,
            error: OnretrieveUpdateBusinessCommunity
        });
        return false; 
      }
      function onsuccessUpdateBusinessCommunity()
      {
          $("#divSuccessMsg").show();
          $("#divSuccessMsg").html("");
          $("#divSuccessMsg").html("Record Successfully Updated!");
          $("#divSuccessMsg").fadeOut(6000);
          $("input[id$='UpdateBusinessCommunity']").val("");
          ClearBusinessCommunity();
          getBusinessCommunity();
        return false;
      }
      function OnretrieveUpdateBusinessCommunity()
      {
        alert("Error In Updating Record!");
        return false;
      } 
    </script>

</asp:Content>
