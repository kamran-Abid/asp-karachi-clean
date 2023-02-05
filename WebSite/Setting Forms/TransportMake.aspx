<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="TransportMake.aspx.cs" Inherits="Setting_Forms_TransportMake" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width:100%;margin-top:0%;vertical-align:top;">
      
        <tr>
            <td>
               <fieldset>
                   <legend>Vehicle Make</legend>
               
                    <table  style="font-family: Calibri; font-size: 11pt;width:100%;" >
                    <tr>
                        
                      
                        <td>
                             <asp:Label ID="lblMake" Text="Make:" runat="server"></asp:Label>
                        </td>
                       
                        <td  align="left">
                            <asp:TextBox ID="txtMake"  runat="server" placeholder="Enter Vehicle Make"></asp:TextBox>
                        </td>
                        
                   
                        <td align="left">
                              <asp:Button ID="btnSave" Text="Save" CssClass="btn" OnClientClick="return SaveMake();" runat="server" />
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
                <legend>Vehicle Make Details</legend>
                 <div style="overflow: auto; width: 100%;">
                  
            
                
                  <table id="tblRecord" class="dataTable">
                </table>
            </div>         
	</fieldset>
        </div>

    <script type="text/javascript">
        $(document).ready(function () {
            getMake();

        });



        function SaveMake() {
            var Make = $("input[id$='txtMake']").val().trim();

            if (Make == "") {
                alert("Please Enter Make!");
                return false;
            }
            var i = 0;
            if ($("tblRecord tr").length - 1 > 1) {
                for (i = 0; i < $("tblRecord tr").length - 1; i++) {

                    if ($("#txtMake" + i).html().toUpperCase().trim() == $("input[id$='txtMake']").val().toUpperCase().trim()) {
                        alert("Make " + $("input[id$='txtMake']").val() + "  already exists!");
                        $("input[id$='txtMake']").val("");
                        return false;
                    }
                    // alert("test")
                }
            }


            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/SaveMake",
                data: "{'Make':'" + Make + "'}",
                success: onsuccesssaveMake,
                error: onsaveError
            });
            return false;
        }
        function onsuccesssaveMake() {
            $("input[id$='txtMake']").val("");
            getMake();
        }

        function onsaveError() {
            alert("Error In Save!");
            return false;
        }

        function getMake() {
           
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/getMake",
                data: "{}",
                success: onsuccessgetBodyType,
                error: onretrievegetBodyType
            });
            return false;
        }
        function onsuccessgetBodyType(msg) {

            var data = msg.d;
            //if (oTable != null) {
            //    oTable.fnClearTable();
            //    oTable.fnDestroy();
            //}
            var tbl = "";
            tbl += "<thead>";
            tbl += "<tr>";
      
            tbl += "<th style='white-space:nowrap; text-align:center;'>ID</th>";
            tbl += "<th style='white-space:nowrap; text-align:center;'>Make Name</th>";
            
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            for (var i = 0; i < data.getMake.length; i++) {
                tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
            
                tbl += "<td style='text-align:center; white-space:nowrap;' id='txtModBy" + i + "'>" + data.getMake[i].id + " </td>";
                tbl += "<td style='text-align:center; white-space:nowrap;' id='txtModDate" + i + "'>" + data.getMake[i].TransportMake + " </td>";
                tbl += "</tr>";
            }
            tbl += "</tbody>";
            tbl += "</table>";
            $("#tblRecord").html(tbl);
         //   dataTable();
            return false;
        }


        function onretrievegetBodyType() {
            alert("Error In Loading Details!");
            return false;
        }
    </script>
</asp:Content>

