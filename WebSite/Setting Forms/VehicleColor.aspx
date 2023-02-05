<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="VehicleColor.aspx.cs" Inherits="Setting_Forms_VehicleColor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width:100%;margin-top:0%;vertical-align:top;">
      
        <tr>
            <td>
               <fieldset>
                   <legend>Vehicle Color</legend>
               
                    <table  style="font-family: Calibri; font-size: 11pt;width:100%;" >
                    <tr>
                        
                      
                        <td>
                             <asp:Label ID="lblColor" Text="Color:" runat="server"></asp:Label>
                        </td>
                       
                        <td  align="left">
                            <asp:TextBox ID="txtcolor"  runat="server" placeholder="Enter Vehicle Color Name"></asp:TextBox>
                        </td>
                        
                   
                        <td align="left">
                              <asp:Button ID="btnSave" Text="Save" CssClass="btn" OnClientClick="return SaveColor();" runat="server" />
                            <asp:Button ID="clear" Width="10%" runat="server" class="btn" Text="Clear" OnClick="ClearAll" />
                            <%--<asp:Button ID="btnClear" Text="Clear" CssClass="btn" OnClientClick="return SearchFingers();" runat="server" />--%>
                        </td>
                    </tr>
                </table>
                </fieldset>
            </td>
        </tr>

    </table>
     <div id="divGetfinger"  >
            <fieldset id="fldGetDepartmentDetails" >
                <legend>Color  Details</legend>
                 <div style="overflow: auto; width: 100%;">
                  
            
                
                  <table id="tblRecord" class="dataTable">
                </table>
            </div>         
	</fieldset>
        </div>

    <script type="text/javascript">
        $(document).ready(function () {
            getColor();

        });



        function SaveColor() {
            var Color = $("input[id$='txtcolor']").val().trim();

            if (Color == "") {
                alert("Please Enter Color!");
                return false;
            }

            var i = 0;
            if ($("tblRecord tr").length - 1 > 1) {
                for (i = 0; i < $("tblRecord tr").length - 1; i++) {

                    if ($("#txtcolor" + i).html().toUpperCase().trim() == $("input[id$='txtcolor']").val().toUpperCase().trim()) {
                        alert("Color " + $("input[id$='txtcolor']").val() + "  already exists!");
                        $("input[id$='txtcolor']").val("");
                        return false;
                    }
                    // alert("test")
                }
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/SaveColor",
                data: "{'Color':'" + Color + "'}",
                success: onsuccesssaveColor,
                error: onsaveError
            });
            return false;
        }
        function onsuccesssaveColor() {
            $("input[id$='txtcolor']").val("");
            getColor();
        }

        function onsaveError() {
            alert("Error In Save!");
            return false;
        }

        function getColor() {
           
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/getColor",
                data: "{}",
                success: onsuccessgetDepartment,
                error: onretrievegetDepartment
            });
            return false;
        }
        function onsuccessgetDepartment(msg) {

            var data = msg.d;
            //if (oTable != null) {
            //    oTable.fnClearTable();
            //    oTable.fnDestroy();
            //}
            var tbl = "";
            tbl += "<thead>";
            tbl += "<tr>";
      
            tbl += "<th style='white-space:nowrap; text-align:center;'>ID</th>";
            tbl += "<th style='white-space:nowrap; text-align:center;'>Color Name</th>";
            
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            for (var i = 0; i < data.GetColorData.length; i++) {
                tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
            
                tbl += "<td style='text-align:center; white-space:nowrap;' id='txtModBy" + i + "'>" + data.GetColorData[i].id + " </td>";
                tbl += "<td style='text-align:center; white-space:nowrap;' id='txtModDate" + i + "'>" + data.GetColorData[i].TransportColour + " </td>";
                tbl += "</tr>";
            }
            tbl += "</tbody>";
            tbl += "</table>";
            $("#tblRecord").html(tbl);
         //   dataTable();
            return false;
        }


        function onretrievegetDepartment() {
            alert("Error In Loading Details!");
            return false;
        }
    </script>
</asp:Content>

