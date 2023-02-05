

<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="card.aspx.cs" Inherits="card" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style>
       
        @media print {
              
#txtHeaderFront {
    background-color: red !important;
    -webkit-print-color-adjust: exact; 
}}

@media print {
    #txtHeaderFront {
    color: white !important;
}}
    </style>
        <fieldset>
            <legend>Searh</legend>
            <table>
                <tr>
                    <td colspan="6">
                        <p style="color:maroon; font-weight:bold;">Please Enter CNIC Or Card No!</p>
                    </td>

                </tr>
                <tr>
                    <td>Enter CNIC:</td>
                    <td>
                        <asp:TextBox ID="nic" placeholder="Enter minimum 3 digits" class="numeric cnic" runat="server" autocomplete="off"></asp:TextBox></td>

                    <td>Enter Card No:</td>
                    <td>
                        <asp:TextBox ID="txtCardNo" runat="server" autocomplete="off"></asp:TextBox></td>
                    <td>
                        <input type="button" value="Search" onclick="getdata();" style="border-radius:10px;background-color:#0b9444;border:solid 1px;font-size:medium;color:white" />
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlColors" runat="server" Width="200px" Style="margin-left: 60px" onclick="changecolor()">
                            <asp:ListItem Text="Select color" Value="0"></asp:ListItem>
                            <asp:ListItem Text="Yellow" Value="1"></asp:ListItem>
                            <asp:ListItem Text="Blue" Value="2"></asp:ListItem>
                            <asp:ListItem Text="Purple" Value="3"></asp:ListItem>
                            <asp:ListItem Text="Red" Value="4"></asp:ListItem>
                            <asp:ListItem Text="Brown" Value="5"></asp:ListItem>
                            <asp:ListItem Text="Sky Blue" Value="6"></asp:ListItem>
                            <asp:ListItem Text="Green" Value="7"></asp:ListItem>
                        </asp:DropDownList>

                    </td>
                    <td>
                        <asp:DropDownList ID="Ddlcat" runat="server" Width="200px" Style="margin-left: 60px" onclick="changecolor2()">
                            <asp:ListItem Text="Select category" Value="0"></asp:ListItem>
                            <asp:ListItem Text="PAKISTAN NAVY" Value="1"></asp:ListItem>
                            <asp:ListItem Text="RESIDENT ENTRY PASS" Value="2"></asp:ListItem>
                            <asp:ListItem Text="SERVANT ENTRY PASS" Value="3"></asp:ListItem>
                            <asp:ListItem Text="NRC ENTRY PASS" Value="4"></asp:ListItem>
                            <asp:ListItem Text="VISITOR ENTRY PASS" Value="5"></asp:ListItem>
                            <asp:ListItem Text="TEMPORARY PASS" Value="6"></asp:ListItem>
                        </asp:DropDownList>

                    </td>
                </tr>
            </table>
        </fieldset>




 


     <fieldset>
           <div  style="width:68%;text-align:center;padding-left:10%">
               <div style="float:left">
                                  <table>
                   <tr>
                       <td>
          <div id="printarea" style="float:left;border:3px solid rebeccapurple ">
                            <table id="tblFrontSit" style="height:306px;width:204px; ">
                                <tr>
                                    <td colspan="2">
                                        <%--<asp:TextBox ID="txtHeaderFront" runat="server" Style="background-color: purple; text-align: center;" Font-Bold="true" Height="30px" Width="200px" ForeColor="black" ReadOnly="true"></asp:TextBox>--%>
                                   
                                        <span  id="spanHeaderFront" style=" text-align: center;font-size:medium ;color:white;height:30px;width:204px" ></span>
                                         </td></tr>
                                         <tr> <td colspan="1" id="tdNightStay" style="font-size:small;font-weight:bold;vertical-align:top; display:none;text-align:center">Night Stay</td>

                                             <td colspan="1" id="tdDuplicate" style="font-size:small;font-weight:bold;vertical-align:top; display:none;text-align:center;color:maroon;">Duplicate</td>
                                         </tr>
                                    
                                
                                <tr id="trPicture">
                                 <td ><span  style="background-color: red; font-weight: bold; font-size: small; color: white;vertical-align:top;text-align:left" id="tdYear"></span></td>
                                    <td  id="tdPicture"></td>
                                      <%--<td>&nbsp;</td>--%>
                                      
                                   
                               
                                </tr>
                                <tr >
                                    <%--<td style="color:red;font-size:12px;width:30px;text-align:left" id="tdDOE"></td>
                                     <td style="color:red;font-size:12px;width:30px;text-align:left" id="tddoe"></td>--%>
                                     
                                    <%--<td>&nbsp;</td>--%>
                                    <td colspan="2" style="color:red;font-size:12px;width:30px;text-align:center" id="tdDOE"></td>
                                   
                                </tr>
                           <%--  <tr>
                                    
                                     
                                </tr>--%>
                                <tr>
                                    <td id="tdNameColumn" style="font-size:small; padding-left:0px;vertical-align:top; "></td>
                                    <%--<td >&nbsp;</td>--%>
                                    <td id="tdName" style="font-size:small; vertical-align:top"></td>
                                </tr>

                                  <tr>
                                    <td id="tdRelationColumn" style="font-size:small;padding-left:0px;vertical-align:top" ></td>
                                    <%--<td >&nbsp;</td>--%>
                                    <td id="tdRelation" style="font-size:small; vertical-align:top"></td>
                                </tr>
                                <tr>
                                    <td id="tdServantOfColumn" style="font-size:small;vertical-align:top;padding-left:0px"></td>
                                    <%--<td>&nbsp;</td>--%>
                                    <td id="tdServantOf" style="font-size:small; vertical-align:top"></td>
                                </tr>
                                  

                                 <tr>
                                    <td id="tdPNoColumn" style="font-size:small;padding-left:0px;vertical-align:top"></td>
                                    <%--<td >&nbsp;</td>--%>
                                    <td id="tdPNo" style="font-size:small;vertical-align:top"></td>
                                </tr>

                                  <tr>
                                    <td id="tdPRankColumn" style="font-size:small;padding-left:0px;vertical-align:top"></td>
                                   <%--<td>&nbsp;</td>--%>
                                    <td id="tdRank" style="font-size:small;vertical-align:top"></td>
                                </tr>
                                

                            </table>
                                   
                            </div>
                       </td>
                       
                   </tr>
                   <tr>
                       <td>
                                 <div style="float:left;">

            <input id="btnprint" type="button" onclick="PrintDiv()" value="FrontPrint" style="border-radius:10px;background-color:#0b9444;border:solid 1px;font-size:medium;color:white;bottom:2px;"  />
        </div>
                       </td>
                   </tr>
               </table>
          
               </div>
               
               <div style="float:right">
                       
                           <table>
                               <tr>
                                   <td>

          
                             <div id="printarea1" style="float:right;border:3px solid rebeccapurple">
                            <table style="height:306px;width:204px; line-height:16px !important;" >
                                <tr>
                                    <td colspan="2">
                                        <span id="txtHeaderBack" style="font-size:medium ; color:white; height:30px; width:204px" ></span>
                                    </td>
                                </tr>
                                <%--<tr>

                                                    <ul style="margin-left:2%">INSTRUCTIONS</ul>   
                                    <ol>
                                        <li style="font-size:x-small">This card is non-transferrable.</li>
                                        <li style="font-size:x-small">Loss is to be reported to NSU immediately.</li>
                                        <li style="font-size:x-small"> The holder of this pass is authorized to <br />
                                         enter in NRC being resident.</li>
                                        <li style="font-size:x-small">This pass is to be returned to NSU if resident <br />
                                         leaves/expelled out from NRC.</li>
                                        <li style="font-size:x-small">If found, please post this card at below mentioned <br />
                                        address.</li>
                                                     
                                       </ol>
                                    <ul>
                                                      <ul style="margin-left:8% ; font-size:small">NSU</ul>   <br />
                                                     <ul style="font-size:small ">Sector E-8 ISLAMABAD</ul> 

                                    </ul>
                                                     

                                 
                                </tr>--%>
                             
                                <tr>
                                    <td id="tdCardNoColumn" style="font-size:small;padding-left:10px;text-align:left">

                                    </td>
                                    <%--<td>&nbsp;</td>--%>
                                    <td id="tdCardNo" style="font-size:small;text-align:left"></td>
                                </tr>
                                 <tr>
                                    <td id="tdIssueDateColumn" style="font-size:small;width:39%;padding-left:10px;text-align:left">

                                    </td>
                                    <%--<td>&nbsp;</td--%>
                                    <td id="tdIssueDate" style="font-size:small;text-align:left"></td>
                                </tr>
                                 <tr>
                                    <td id="tdCNICColumn" style="font-size:small;padding-left:10px;text-align:left">

                                    </td>
                                    <%--<td>&nbsp;</td>--%>
                                    <td id="tdCNIC" style="font-size:small;text-align:left"></td>
                                </tr>
                                 <tr>
                                    <td id="tdMobileNoColumn" style="font-size:small;padding-left:10px;text-align:left">

                                    </td>
                                    <%--<td>&nbsp;</td>--%>
                                    <td id="tdMobileNo" style="font-size:small;text-align:left"></td>
                                </tr>
                                 <tr>
                                    <td id="tdAddressColumn" style="font-size:small;width:inherit;vertical-align:top;padding-left:10px;text-align:left">

                                    </td>
                                    <%--<td>&nbsp;</td>--%>
                                    <td id="tdAddress" style="font-size:x-small; width:150px;text-align:left" aria-multiline="true"></td>
                                </tr>
                                   <tr>
                                    <td colspan="2">
                                     
                                         <span style="padding-left:14%;font-size:small">INSTRUCTION</span>
                                       <div style="width:90%;line-height:1; text-align:left;">    
                                   <span style="font-size:x-small;padding-left:10px;">1. This card is non-transferrable.</span><br style="clear:both;" />
                                   <span style="font-size:x-small;padding-left:10px;">2. Lost card to be reported to NSU <span style="padding-left:23px;">immediately.</span></span><br style="clear:both;" />
                                   <span style="font-size:x-small;padding-left:10px;">3. The holder of this pass is
                                       <br /><span style="padding-left:23px;"> authorized to 
                                      enter in NRC</span> <br /><span style="padding-left:23px;">being resident.</span></span><br style="clear:both;" />
                                   
                                       <span style="font-size:x-small;padding-left:10px;">4. This pass is to be returned to NSU, <span style="padding-left:23px;">if 
                                       resident leaves/expelled out from  <span style="padding-left:23px;">NRC.</span></span></span>
                                       </div>     
                                        
                                      

                                    </td>
                                </tr>
                            </table>
                    
            </div>
                               </td>
                               </tr>
                               <tr>
                                   <td>
                                                <div>



            <input id="btnprint1" type="button" onclick="PrintDiv1()" value="BackPrint" style="border-radius:10px;background-color:#0b9444;border:solid 1px;font-size:medium;color:white" />
       
        </div>
                                   </td>
                               </tr>
                           </table>
                    
        
                       </div>     
         
        <div>
                   <asp:CheckBox ID="chkNightStay" Text="Night Stay" runat="server" />
             <asp:CheckBox ID="chkDuplicate" Text="Duplicate" runat="server" />
               </div>
                  
                  </div>
                           </fieldset>
  
      
        

<script type="text/javascript">

    $(document).ready(function () {
        $("input[id$='chkNightStay']").click(function () {
            if ($("input[id$='chkNightStay']").is(":checked")) {
                $("#tdNightStay").show();
            }
            else {
                $("#tdNightStay").hide();
            }
        });

        $("input[id$='chkDuplicate']").click(function () {
            if ($("input[id$='chkDuplicate']").is(":checked")) {
                $("#tdDuplicate").show();
            }
            else {
                $("#tdDuplicate").hide();
            }
        });
    });
    function getdata() {

        var CNIC = $("input[id$='nic']").val();
        var CardNo = $("input[id$='txtCardNo']").val();
        $.ajax({
            type: "POST",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            url: "card.aspx/getdata",
            data: "{ 'Nic': '" + CNIC + "','CardNo': '" + CardNo + "'}",
            success: OnGetMessages,
             error: OnretrieveError2
        });
    }

    function OnretrieveError2() {
        alert("Please Enter Correct CNIC Or Card No!");
        return false;
    }
    function OnGetMessages(msg) {
      
        //alert(msg);
        var data = msg.d;
        //alert(data.Table[0].CardHeader);
        $("#spanHeaderFront").text(data.Table[0].CardHeader);
        $("#txtHeaderBack").text(data.Table[0].CardHeader);
       // $("input[id$='txtHeaderBack']").val(data.Table[0].CardHeader);
        var td = '';
        td += "<img src='../RMS/CallBack/GetImageDatafromDB.aspx?PrimaryKeyIDValue=" + data.Table[0].EID + "&tableName=" + data.Table[0].TableName + "&ImagecolumnName=NewPhoto&PrimaryKeyColumnName=" + data.Table[0].PrimaryColumnName + "' height='60px' width='80px'>";
        $("#tdPicture").html(td);
        $("#tdYear").html(data.Table[0].CurrentYear);

        $("#tdDOE").html(data.Table[0].DOEColumn + ' ' + data.Table[0].YearColumn);
        $("#tdSecurityOfficer").html(data.Table[0].SecurityOfficerColumn);


        $("#tdNameColumn").html(data.Table[0].NameColumn);
        $("#tdName").html(data.Table[0].CardMemberName);

        $("#tdRelationColumn").html(data.Table[0].RelationColmn);
        $("#tdRelation").html(data.Table[0].RelationPersonName);

        $("#tdServantOfColumn").html(data.Table[0].ServantOfColumn);
        $("#tdServantOf").html(data.Table[0].OwnerName);


        $("#tdPNoColumn").html(data.Table[0].POColumn);
        $("#tdPNo").html(data.Table[0].ServiceNo);
        $("#tdPRankColumn").html(data.Table[0].RankColumn);
        $("#tdRank").html(data.Table[0].Rank_Name);


        $("#tdCardNoColumn").html(data.Table[0].cardNoColumn);
        $("#tdCardNo").html(data.Table[0].cardNo);
        $("#tdIssueDateColumn").html(data.Table[0].IssueDateColumn);
        $("#tdIssueDate").html(data.Table[0].IssueDate);


        $("#tdCNICColumn").html(data.Table[0].CNICColumn);
        $("#tdCNIC").html(data.Table[0].CNIC);
        $("#tdMobileNoColumn").html(data.Table[0].MobileNoColumn);
        $("#tdMobileNo").html(data.Table[0].CellNo);

        $("#tdAddressColumn").html(data.Table[0].AddressColumn);
        $("#tdAddress").html(data.Table[0].Currentaddress);
        
        //ServantOfColumn
        ///*converting json date into date*/
        //var dateString = data.settings[0].created_date.substr(6);
        //var currentTime = new Date(parseInt(dateString));
        //var month = currentTime.getMonth() + 1;
        //var day = currentTime.getDate();
        //var year = currentTime.getFullYear();
        //var date = day + "/" + month + "/" + year;
        /////////////////////////////////////////////////
        //debugger;
        //// $("#Image").text(data.settings[0].Photo);
        //var card=data.settings[0].CardNumber;
        //var card_type = card.split('-');


        //if (card_type[0] == "OFM") {
        //    $("#name").text(data.settings[0].FamilyMemberName);
        //    $("#relationship").text(data.settings[0].Relation_Name);
        //    $("#fname").text(data.settings[0].FirstName);
        //    $("#poNo").text(data.settings[0].ServiceNo);
        //    $("#rank").text(data.settings[0].Rank_Name);
        //    $("#cardno").text(data.settings[0].CardNumber);
        //    $("#issuedate").text(date);
        //    $("#Cnic").text(data.settings[0].NIC);
        //    $("#mobile").text(data.settings[0].Mobile);
        //    $("#Address").text(data.settings[0].vaddr);
        //}
        //else if (card_type = "CIV") {
        //    $("#b").css("display", "block");
        //    $("#DOB").text(data.settings[0].NRID);
        //}
    }

    function PrintDiv() {
        var divToPrint = document.getElementById('printarea');
        var popupWin = window.open('', '_blank', 'width=200,height=200,location=no,left=200px');
        popupWin.document.open();
        popupWin.document.write('<html><body onload="window.print()">' + divToPrint.innerHTML + '</html>');
        popupWin.document.close();
    }

    function PrintDiv1() {
        var divToPrint = document.getElementById('printarea1');
        var popupWin = window.open('', '_blank', 'width=200,height=300,location=no,left=200px');
        popupWin.document.open();
        popupWin.document.write('<html><body onload="window.print()">' + divToPrint.innerHTML + '</html>');
        popupWin.document.close();
    }
   
      function changecolor() {
            //get the dropdownlist value here
            var objdrpdwn = document.getElementById('<%= ddlColors.ClientID %>');
            var selectedvalue = objdrpdwn.options[objdrpdwn.selectedIndex].text;
            if (selectedvalue == "Yellow") {
                document.getElementById("spanHeaderFront").style.backgroundColor = "yellow";
                document.getElementById("spanHeaderFront").style.color = "black";
                document.getElementById("txtHeaderBack").style.backgroundColor = "yellow";
                document.getElementById("txtHeaderBack").style.color = "black";
            }
            if (selectedvalue == "Blue") {
                document.getElementById("spanHeaderFront").style.backgroundColor = "navy";
                document.getElementById("spanHeaderFront").style.color = "white";
                document.getElementById("txtHeaderBack").style.backgroundColor = "navy";
                document.getElementById("txtHeaderBack").style.color = "white";
            }
            if (selectedvalue == "Purple") {
                document.getElementById("spanHeaderFront").style.backgroundColor = "purple";
                document.getElementById("spanHeaderFront").style.color = "white";
                document.getElementById("txtHeaderBack").style.backgroundColor = "purple";
                document.getElementById("txtHeaderBack").style.color = "white";
            }
            if (selectedvalue == "Red") {
                document.getElementById("spanHeaderFront").style.backgroundColor = "red";
                document.getElementById("spanHeaderFront").style.color = "white";
                document.getElementById("txtHeaderBack").style.backgroundColor = "red";
                document.getElementById("txtHeaderBack").style.color = "white";
            }

            if (selectedvalue == "Brown") {
                document.getElementById("spanHeaderFront").style.backgroundColor = "maroon";
                document.getElementById("spanHeaderFront").style.color = "white";
                document.getElementById("txtHeaderBack").style.backgroundColor = "maroon";
                document.getElementById("txtHeaderBack").style.color = "white";
            }
            if (selectedvalue == "Sky Blue") {
                document.getElementById("spanHeaderFront").style.backgroundColor = "skyblue";
                document.getElementById("spanHeaderFront").style.color = "white";
                document.getElementById("txtHeaderBack").style.backgroundColor = "skyblue";
                document.getElementById("txtHeaderBack").style.color = "white";
            }
            if (selectedvalue == "Green") {
                document.getElementById("spanHeaderFront").style.backgroundColor = "green";
                document.getElementById("spanHeaderFront").style.color = "white";
                document.getElementById("txtHeaderBack").style.backgroundColor = "green";
                document.getElementById("txtHeaderBack").style.color = "white";
            }
           
      }
    //test
    function changecolor2() {
        //get the dropdownlist value here
        var objdrpdwn = document.getElementById('<%= Ddlcat.ClientID %>');
        var selectedvalue = objdrpdwn.options[objdrpdwn.selectedIndex].text;
        if (selectedvalue == "PAKISTAN NAVY") {
            document.getElementById("spanHeaderFront").innerHTML = "PAKISTAN NAVY";
           // document.getElementById("tdPicture").hidden = true;
          //  document.getElementById("trPicture").hidden = true;
           // document.getElementById("spanHeaderFront").style.color = "black";
            document.getElementById("txtHeaderBack").innerHTML = "PAKISTAN NAVY";
           // document.getElementById("txtHeaderBack").style.color = "black";
        }
        if (selectedvalue == "RESIDENT ENTRY PASS") {
            document.getElementById("spanHeaderFront").innerHTML = "RESIDENT ENTRY PASS";
           // document.getElementById("spanHeaderFront").style.color = "white";
            document.getElementById("txtHeaderBack").innerHTML = "RESIDENT ENTRY PASS";
           // document.getElementById("txtHeaderBack").style.color = "white";
        }
        if (selectedvalue == "SERVANT ENTRY PASS") {
            document.getElementById("spanHeaderFront").innerHTML = "SERVANT ENTRY PASS";
           // document.getElementById("spanHeaderFront").style.color = "white";
            document.getElementById("txtHeaderBack").innerHTML = "SERVANT ENTRY PASS";
           // document.getElementById("txtHeaderBack").style.color = "white";
        }
        if (selectedvalue == "NRC ENTRY PASS") {
            document.getElementById("spanHeaderFront").innerHTML = "NRC ENTRY PASS";
            //document.getElementById("spanHeaderFront").style.color = "white";
            document.getElementById("txtHeaderBack").innerHTML = "NRC ENTRY PASS";
           // document.getElementById("txtHeaderBack").style.color = "white";
        }

        if (selectedvalue == "VISITOR ENTRY PASS") {
            document.getElementById("spanHeaderFront").innerHTML = "VISITOR ENTRY PASS";
//document.getElementById("spanHeaderFront").style.color = "white";
            document.getElementById("txtHeaderBack").innerHTML = "VISITOR ENTRY PASS";
           // document.getElementById("txtHeaderBack").style.color = "white";
        }
        if (selectedvalue == "TEMPORARY PASS") {
            document.getElementById("spanHeaderFront").innerHTML = "TEMPORARY PASS";
           // document.getElementById("spanHeaderFront").style.color = "white";
            document.getElementById("txtHeaderBack").innerHTML = "TEMPORARY PASS";
           // document.getElementById("txtHeaderBack").style.color = "white";
        }
       

    }
</script>

    </asp:Content>
