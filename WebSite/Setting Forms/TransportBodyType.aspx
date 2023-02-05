<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="TransportBodyType.aspx.cs" Inherits="Setting_Forms_TransportBodyType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <table style="width:100%;margin-top:0%;vertical-align:top;">
      
        <tr>
            <td>
               <fieldset>
                   <legend>Vehicle Body Type</legend>
               
                    <table  style="font-family: Calibri; font-size: 11pt;width:100%;" >
                    <tr>
                        
                      
                        <td>
                             <asp:Label ID="lblBodyType" Text="BodyType:" runat="server"></asp:Label>
                        </td>
                       
                        <td  align="left">
                            <asp:TextBox ID="txtBodyType"  runat="server" placeholder="Enter Vehicle Body Type"></asp:TextBox>
                        </td>
                        
                   
                        <td align="left">
                              <asp:Button ID="btnSave" Text="Save" CssClass="btn" OnClientClick="return SaveBodyType();" runat="server" />
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
                <legend>Vehicle Body Type Details</legend>
                 <div style="overflow: auto; width: 100%;">
                  
            
                
                  <table id="tblRecord" class="dataTable">
                </table>
            </div>         
	</fieldset>
        </div>

    <script type="text/javascript">
        $(document).ready(function () {
            getBodyType();

        });



        function SaveBodyType() {
            //var i = 0;
            //if ($("tblRecord tr").length - 1 > 1) {
            //    for (i = 0; i < $("tblRecord tr").length - 1; i++) {

            //        if ($("#txtBodyType" + i).html().toUpperCase().trim() == $("input[id$='txtBodyType']").val().toUpperCase().trim()) {
            //            alert("Color " + $("input[id$='txtBodyType']").val() + "  already exists!");
            //            $("input[id$='txtBodyType']").val("");
            //            return false;
            //        }
            //        // alert("test")
            //    }
            //}
            var BodyType = $("input[id$='txtBodyType']").val().trim();

            if (BodyType == "") {
                alert("Please Enter Body Type!");
                return false;
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/SaveBodyType",
                data: "{'BodyType':'" + BodyType + "'}",
                success: onsuccesssaveColor,
                error: onsaveError
            });
            return false;
        }
        function onsuccesssaveColor() {
            $("input[id$='txtBodyType']").val("");
            getBodyType();

        }

        function onsaveError() {
            alert("Error In Save!");
            return false;
        }

        function getBodyType() {
           
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/getBodyType",
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
            tbl += "<th style='white-space:nowrap; text-align:center;'>Body Type Name</th>";
            
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            for (var i = 0; i < data.getBodyType.length; i++) {
                tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
            
                tbl += "<td style='text-align:center; white-space:nowrap;' id='txtModBy" + i + "'>" + data.getBodyType[i].id + " </td>";
                tbl += "<td style='text-align:center; white-space:nowrap;' id='txtModDate" + i + "'>" + data.getBodyType[i].TransportBodyType + " </td>";
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

