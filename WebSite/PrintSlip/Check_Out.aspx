<%@ Page Title="" Language="C#" MasterPageFile="~/PACS.master" AutoEventWireup="true" CodeFile="Check_Out.aspx.cs" Inherits="PrintSlip_Check_Out" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

            <link href="../Content/bootstrap.min.css" rel="stylesheet" />
   
    <link href="jquery-ui.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="container">
<fieldset>
    
    <legend style="width:auto">Search Visitor</legend>
    <div class="row">
        <div class="col-lg-12 col-md-12">
            <table class="table" style="width: 50%">
                <tr>
                   
                    <td><input placeholder="Enter CNIC" style="width:100%" class="form-control" type="text" name="cnic" id="txtSearch_cnic" /></td>
                    <td><input class="btn btn-primary" value="Search" type="button" name="btnsearch" id="btnsearch_cnic" /></td>
                </tr>
            </table>
        </div>

    </div>
    </fieldset>
    <div class="row">
        <div class="col-lg-6 col-md-6">
            <fieldset>
                <legend style="width:auto">Visitor Detail</legend>
                <table class="table table-responsive table-striped" id="guestdetail">
                    <thead class="thead-dark">                    <tr>
                        <th colspan="2" style="text-align:center; color:white; background-color:black" id="slip_No"></th>
                    </tr>
                  </thead>

                    <tr>
                        <td>Visitor Name: </td>
                        <td id="v_name">  </td>
                    </tr>
                    <tr>
                        <td>Visitor CNIC: </td>
                        <td id ="vcnic">  </td>
                    </tr>
                     <tr>
                        <td>Date of visit: </td>
                        <td id="vvdate">  </td>
                    </tr>
                     <tr>
                        <td >Time</td>
                        <td id="vtime">  </td>
                    </tr>
                    <tr>
                        <td>Validity Date: </td>
                        <td id="vvddate">  </td>
                    </tr>

                     <tr>
                        <td>To See: </td>
                        <td id="hname">  </td>
                    </tr>
                     <tr>
                        <td>Host designation: </td>
                        <td id="hdes">  </td>
                    </tr>
                     <tr>
                        <td>Host Department: </td>
                        <td id="hdep">  </td>
                    </tr>
                     <tr>
                        <td> Host Address: </td>
                        <td id="haddress">  </td>
                    </tr>
                     <tr>
                        <td> Visit Purpose: </td>
                        <td id="vpurpose">  </td>
                    </tr>
                     <tr>
                        <td>Relation: </td>
                        <td id="vrelation">  </td>
                    </tr>
                     <tr>
                        <td>Guest Type: </td>
                        <td id="gtype">  </td>
                    </tr>
                     <tr>
                        <td>Vehical Number: </td>
                        <td id="vnmbr">  </td>
                    </tr>
                    
                     
                </table>
            </fieldset>
        </div>
        <div>
            <input class="btn btn-primary" type="button" value="Check-Out" id="Checkout" name="check" />
        </div>
    </div>
    </div>


     <script src="../js/jquery-1.11.2.js"></script>
    <script src="../js/jquery.min.js"></script>
    <script src="jquery.js"></script>
   
    <script src="jquery-ui.min.js"></script>
  <script src="../js/bootstrap.min.js"></script>
    <script src="Check_out.js"></script>

</asp:Content>

