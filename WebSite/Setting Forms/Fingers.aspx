<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="Fingers.aspx.cs" Inherits="Fingers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <table style="width:100%;margin-top:0%;vertical-align:top;">
      
        <tr>
            <td>
               <fieldset>
                   <legend>Finger Data</legend>
               
                    <table  style="font-family: Calibri; font-size: 11pt;width:100%;" >
                    <tr>
                        <td style="width:140px;text-align:left;">
                            <asp:Label ID="lblUserCategory" Text="Category:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 600px;">
                            <asp:DropDownList ID="UserCategory" runat="server">
                               <%-- <asp:ListItem Value="--Select--" Text="--Select--"></asp:ListItem>--%>
                                <asp:ListItem Value="Employee" Text="Employee" ></asp:ListItem>
                                <%--<asp:ListItem Value="EmployeeFamily" Text="EmployeeFamily" ></asp:ListItem>
                                <asp:ListItem Value="EmployeeServent" Text="EmployeeServent" ></asp:ListItem>
                                <asp:ListItem Value="EmployeeGuest" Text="EmployeeGuest" ></asp:ListItem>
                                <asp:ListItem Value="BuissenessCommunity" Text="BuissenessCommunity" ></asp:ListItem>
                                <asp:ListItem Value="Contractor" Text="Contractor" ></asp:ListItem>
                                <asp:ListItem Value="ContractorLabor" Text="ContractorLabor" ></asp:ListItem>--%>
                            </asp:DropDownList>
                         
                        </td>
                        <td>
                             <asp:Label ID="lblCNIC" Text="CNIC:" runat="server"></asp:Label>
                        </td>
                       
                        <td  align="left">
                            <asp:TextBox ID="txtCNIC"  runat="server" maxlength = "13" placeholder="Enter  CNIC without Dashes(-)" placeholder-align="center" onkeydown = "return (!(event.keyCode>=65) && event.keyCode!=32);"></asp:TextBox>
                        </td>
                        
                   
                        <td align="left">
                            <asp:Button ID="btnSearch" Text="Search" CssClass="btn" OnClientClick="return SearchFingers();" runat="server" />
                            <asp:Button ID="clear" Width="10%" runat="server" class="btn" Text="Clear" OnClick="ClearAll" />
                        </td>
                    </tr>
                </table>
                </fieldset>
            </td>
        </tr>

    </table>
     <div id="divGetfinger"  >
            <fieldset id="fldGetDepartmentDetails" >
                <legend>Finger  Details</legend>
                 <div style="overflow: auto; width: 100%;">
                  
            
                
                  <table id="tblFingerData" class="dataTable">
                </table>
            </div>         
	</fieldset>
        </div>

    <script type="text/javascript">


        function SearchFingers() {
            var UserCategory = $("select[id$='UserCategory']").val().trim();

            if (UserCategory == "") {
                alert("Please Select User Category!");
                return false;
            }

            var txtCNIC = $("input[id$='txtCNIC']").val().trim();

            if (txtCNIC == "") {
                alert("Please Enter CNIC");
                return false;
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Settingwebmethods.aspx/getFingerData",
                data: "{'UserCategory':'" + UserCategory + "','CNIC':'" + txtCNIC + "'}",
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
      
            tbl += "<th style='white-space:nowrap; text-align:center;'>CNIC</th>";
            tbl += "<th style='white-space:nowrap; text-align:center;'>User Name</th>";
            tbl += "<th style='white-space:nowrap; text-align:center;'>Finger Index</th>";
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            for (var i = 0; i < data.GetFingerData.length; i++) {
                tbl += "<tr id='trmain" + i + "' style='cursor:default;background-color:white;' onclick='getRowID(" + i + ");'>";
            
                tbl += "<td style='text-align:center; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.GetFingerData[i].CNIC + " </td>";
                tbl += "<td style='text-align:center; white-space:nowrap;' id='txtModBy" + i + "'>" + data.GetFingerData[i].Name + " </td>";
                tbl += "<td style='text-align:center; white-space:nowrap;' id='txtModDate" + i + "'>" + data.GetFingerData[i].FingerIndex + " </td>";
                tbl += "</tr>";
            }
            tbl += "</tbody>";
            tbl += "</table>";
            $("#tblFingerData").html(tbl);
         //   dataTable();
            return false;
        }


        function onretrievegetDepartment() {
            alert("Error In Loading Details!");
            return false;
        }
    </script>
</asp:Content>

