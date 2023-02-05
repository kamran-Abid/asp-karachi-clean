<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="familycatagory.aspx.cs" Inherits="Setting_Forms_familycatagory" %>

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
                   <legend>Family Category</legend>
               
                    <table  style="font-family: Calibri; font-size: 11pt;width:100%;" >
                    <tr>
                        <td style="width:140px;text-align:left;">
                            <asp:Label ID="lblCategoryName" Text="Category Name:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 600px;">
                            <asp:TextBox ID="txtFamilyCategoryName" Width="95%"   class="alphanumeric" runat="server" BackColor="White" ></asp:TextBox>
                        </td>
                        
                       
                        <td  align="left">
                           <asp:TextBox ID="txtID"  style="display:none;" runat="server"></asp:TextBox>
                        </td>
                        
                   
                        <td align="left">
                            <asp:Button ID="btnSave" Text="Add" CssClass="btn" OnClientClick="return Savefamilycatagory();" runat="server" />

                             <asp:Button ID="btnUpdate" Text="Update" style="display:none;" CssClass="btn" OnClientClick="return Updatefamilycatagory();" runat="server" />
                        
                            <asp:Button ID="btnClearfamilycatagory" Text="Clear" CssClass="btn" OnClientClick="return Clearfamilycatagory();" runat="server" />
             </td>
                    </tr>
                </table>
                </fieldset>
            </td>
        </tr>

    </table>
     <div id="divGetFamilyDetails"  >
            <fieldset id="fldGetFamilyDetails" >
                <legend>Family Details</legend>
                 <div style="overflow: auto; width: 100%;">
                  
            
                
                  <table id="tblFamilyCategoryDetails" class="dataTable">
                </table>
            </div>         
	</fieldset>
        </div>


     <script type="text/javascript">
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
           getfamilycatagory();
        
    });
    
      function dataTable() {
          oTable = $("#tblFamilyCategoryDetails").dataTable();
      }
   
         function Savefamilycatagory() {
             //    alert('calling');
             var FamilyCategory = $("input[id$='txtFamilyCategoryName']").val().trim();
             if (FamilyCategory == "") {
                 alert("Please Enter Category Name!");
                 return false;
             }
             var i = 0;
             if ($("#tblFamilyCategoryDetails tr").length - 1 > 1) {
                 for (i = 0; i < $("#tblFamilyCategoryDetails tr").length - 1; i++) {

                     if ($("#txtFamilyCategoryName" + i).html().toUpperCase().trim() == $("input[id$='txtFamilyCategoryName']").val().toUpperCase().trim()) {
                         alert("FamilyCategory " + $("input[id$='txtFamilyCategoryName']").val() + " is already added!");
                         $("input[id$='txtFamilyCategoryName']").val("");
                         return false;
                     }
                     // alert("test")

                 }

                 $.ajax({
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "Settingwebmethods.aspx/Savefamilycatagory",
                     data: "{'CategoryName':'" + FamilyCategory + "'}",
                     success: onsuccessSavefamilycatagory,
                     error: onretrieveSaveFAError
                 });
                 return false;
             }
         }
      function onsuccessSavefamilycatagory(msg)
      {
          $("#divSuccessMsg").show();
          $("#divSuccessMsg").html("");
          $("#divSuccessMsg").html("Record Successfully Saved!");
          $("#divSuccessMsg").fadeOut(6000);
         // $("input[id$='txtCategoryName']").val("");
          Clearfamilycatagory()
          getfamilycatagory();
        return false;
      }
      function onretrieveSaveFAError(msg)
      {
          
        alert("Error In Saving Data!");
        return false; 
      }
      function Clearfamilycatagory()
      {
          $("input[id$='txtFamilyCategoryName']").val("");
          $("input[id$='txtID']").val("");
          $("input[id$='btnUpdate']").hide();
          $("input[id$='btnSave']").show();
        return false;
      }
      function getfamilycatagory()
      {
       //   alert('calling');
        $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "Settingwebmethods.aspx/getFamilyDetail",
            data: "{}", 
            success: onsuccessgetfamilycatagory,
            error: onretrievegetfamilycatagory
        });
        return false; 
      }
      function onsuccessgetfamilycatagory(msg)
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
                tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>CategoryName ID</th>";
                tbl += "<th style='text-align:left; white-space:nowrap; '>FamilyCategoryName </th>";
                
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
              for (var i = 0; i < data.familycatagoryDetail.length; i++) {
                    tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
                    tbl += "<td id='txtDelete' align='center'> <input  type='image' src='../images/Cross2.png' onclick='return DeleteCategoryNameRecord(" + i + ");'> </td>";
                            tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord("+i+");'><img src='../images/Edit.png'></td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtID" + i + "'>" + data.familycatagoryDetail[i].ID + "</td>";
                            
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtFamilyCategoryName" + i + "'>" + data.familycatagoryDetail[i].FamilyCategoryName + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.familycatagoryDetail[i].CreatedBy + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.familycatagoryDetail[i].created_date + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.familycatagoryDetail[i].ModifyBy + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.familycatagoryDetail[i].modified_date + " </td>";
                      tbl += "</tr>";
                }   
                tbl += "</tbody>";
                tbl += "</table>";
                $("#tblFamilyCategoryDetails").html(tbl);
               dataTable();
                return false; 
      }

      function getRowID(rowID) {
          $("table[id$='tblFamilyCategoryDetails'] tr").css("background-color", "white");
          $("#trmain" + rowID).css("background-color", "#6798c1");

      }
      function onretrievegetfamilycatagory()
      {
        alert("Error In Loading Details!");
        return false;
      }

      function DeleteCategoryNameRecord(rowNo) {
          
          var ID = $("#txtID" + rowNo).html();

          if (confirm("Are you sure you wish to delete this Record?")) {
              $.ajax({
                  type: "POST",
                  contentType: "application/json; charset=utf-8",
                  url: "Settingwebmethods.aspx/Deletefamilycatagory",
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
          getfamilycatagory();
          return false;

      }

      function OnretrievePhysicianError(msg) {
          getfamilycatagoryRecord();
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

          var Category_Name = $("#txtFamilyCategoryName" + rowNo).html().trim();
          $("input[id$='txtFamilyCategoryName']").val(Category_Name);
         
          $("input[id$='btnUpdate']").show()
          $("input[id$='btnSave']").hide()
          return false;
      }
      function Updatefamilycatagory()
      {
         // alert('calling');
          var ID = $("input[id$='txtID']").val();

          var CategoryName = $("input[id$='txtFamilyCategoryName']").val();
          debugger;
          if (CategoryName == "")
            {
                alert("Please Enter Family Category Name!");
                return false;
          }
          var i = 0;
          if ($("#tblFamilyCategoryDetails tr").length - 1 > 1) {
              for (i = 0; i < $("#tblFamilyCategoryDetails tr").length - 1; i++) {

                  if ($("#txtFamilyCategoryName" + i).html().toUpperCase().trim() == $("input[id$='txtFamilyCategoryName']").val().toUpperCase().trim()) {
                      alert("FamilyCategory " + $("input[id$='txtFamilyCategoryName']").val() + " is already added!");
                      //$("input[id$='txtFamilyCategoryName']").val("");
                      return false;
                  }
                  // alert("test")

              }
              $.ajax({
                  type: "POST",
                  contentType: "application/json; charset=utf-8",
                  url: "Settingwebmethods.aspx/Updatefamilycatagory",
                  data: "{'CategoryName':'" + CategoryName + "','ID':'" + ID + "'}",
                  success: onsuccessUpdatefamilycatagory,
                  error: OnretrieveUpdatefamilycatagory
              });
              return false; 
          }
       
      }
      function onsuccessUpdatefamilycatagory()
      {
          $("#divSuccessMsg").show();
          $("#divSuccessMsg").html("");
          $("#divSuccessMsg").html("Record Successfully Updated!");
          $("#divSuccessMsg").fadeOut(6000);
         // $("input[id$='txtCategoryName']").val("");
          Clearfamilycatagory();
          getfamilycatagory();
        return false;
      }
      function OnretrieveUpdatefamilycatagory()
      {
        alert("Error In Updating Record!");
        return false;
      } 
     </script>



</asp:Content>

