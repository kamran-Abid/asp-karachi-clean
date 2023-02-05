var names = "";
var address = "";
var todaydate = "";
var todaytime = "";
var to_see = "";
var vtype = "";
var VID = "";
var status = "";
var relation = "";
var empnames = "";
var empaddress = "";
var empdep = "";
var empdesg2 = "";
var empid = "";
var Vistortype;
var departments;
var hours = "";
var munaits = "";
var RalationShip = "";


$(document).ready(function () {
    $("#feildsetemp").hide();
    $("#fieldsetguest").hide();
    $("#RecaptureBC").hide();
    $("#startbuttonBC").hide();
    $("#photoBC").hide();
    $("#WebCamCallBC").hide();


    $("#sliptable").hide();
    $("#employeedetail").hide();
    $("#Prints").hide();
    GetAllCountExpiredVistor();
    GetAllActiveVisitor();
    GetAllVisitorlog();

    $('.sub-menu ul').hide();
    $(".sub-menu a").click(function () {
        $(this).parent(".sub-menu").children("ul").slideToggle("100");
        $(this).find(".right").toggleClass("fa-caret-up fa-caret-down");
    });
    $('#txtEmpCNIC').bind('keyup paste', function () {
        this.value = this.value.replace(/[^0-9]/g, '');
    });

    $('#txtcnic').bind('keyup paste', function () {
        this.value = this.value.replace(/[^0-9]/g, '');
    });
    $("#btnSearch").click(function () {
        var urls = "";
        vtype = $.trim($("#ddtype option:selected").val());

        if (vtype == 'Guest') {

            urls = "PrintSlip.aspx/GetGuest";
        }
        if (vtype == 'Contractor') {
            urls = "PrintSlip.aspx/GetContractor";
        }
        if (vtype == 'Labour-Contractor Employee') {
            urls = "PrintSlip.aspx/GetLabor";
        }

        var cnic = ($("#txtcnic").val());

        if (cnic == "") {
            showSuccessMsg("Please Enter Guest CNIC!");
            return false
        }
        if (vtype == "") {
            showSuccessMsg("Please Select Guest Type!");
            return false
        }

        var postData = { 'nic': cnic };
        $.ajax({
            type: "POST",
            url: urls,
            data: JSON.stringify(postData),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: OnGetMessages,
            failure: function (jqXHR, textStatus, errorThrown) {
                alert("HTTP Status: " + jqXHR.status + "; Error Text: " + jqXHR.responseText); // Display error message  
            }
        });
    });

    $("#txtrelation").change(function () {


        relation = ($("#txtrelation option:selected").text());
        $("#RalationShip").text(relation).val();
    });


    $("#txtpurpose").change(function () {
        var purpose = ($("#txtpurpose").val());
        $("#Purpose").text(purpose).val();
    });

    $("#txtvehicalno").change(function () {
        var vehno = ($("#txtvehicalno").val());
        $("#vehno").text(vehno).val();
    });
    $("#ToDateFrom").change(function () {
        var fromdate = ($("#ToDateFrom").val());
        $("#Validaity").text(fromdate).val();
    });
    function OnGetMessages(msg) {
        var data = msg.d;
        if (data.length == 0) {
            showSuccessMsg(vtype + " Not Found");
            return;
        }

        else {
            $("#sliptable").show();
            $("#fieldsetguest").show();
            $("#Prints").show();
            $("#WebCamCallBC").show();

            var type = ($("#ddtype option:selected").val());
            var urls = "";
            var imgurl = ""
            if (type == 'Guest') {
                imgurl = "PrintSlip.aspx/GetGuestImages"
            }
            if (type == 'Contractor') {
                imgurl = "PrintSlip.aspx/GetContractorImages"
            }
            if (type == 'Labour-Contractor Employee') {
                imgurl = "PrintSlip.aspx/GetLaborImages"
            }

            $.each(data, function (index, node) {

                if (node.name == "") {
                    showSuccessMsg(" Guest Not Found");
                }
                else {
                    $("#sliptable").show();
                    $("#fieldsetguest").show();
                    $("#cnic").text($("#txtcnic").val());
                    $("#Address").text(node.address).val();
                    $("#name").text(node.name).val();
                    $("#RalationShip").text(node.relation).val();

                    RalationShip = node.relation;
                    names = node.name;
                    address = node.address;
                    VID = node.gid;
                    status = node.status;
                    todaydate = new Date().toLocaleDateString()
                    todaytime = new Date().toLocaleTimeString();
                    $("#todaydate").text(todaydate).val();
                    $("#currenttime").text(todaytime).val();

                    var imgData = {
                        'nic': ($("[id$='txtcnic']").val())

                    }

                    $.ajax({
                        type: "POST",
                        url: imgurl,
                        data: JSON.stringify(imgData),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {

                            $("#image").attr("src", 'data:image/png;base64,' + data.d);

                        },
                        failure: function (jqXHR, textStatus, errorThrown) {
                            alert("HTTP Status: " + jqXHR.status + "; Error Text: " + jqXHR.responseText); // Display error message  
                        }
                    });
                }
            });
        }
    }
    $("#Prints").click(function () {
        saveLogReports();

    });

    $("#empfieldset").on('click', '#btnsearchemployee', function () {

        var empdep = ($("#ddlDepartmentSearch").val());
        var empname = ($("#txtEmpName").val());
        var empdesg = ($("#ddDesignation").val());

        var empcnic = ($("#txtEmpCNIC").val());


        if (empcnic == "") {
            showSuccessMsg("Please Enter Employee CNIC or PNo");
            return false
        }
        var postData = {
            'empdep': empdep,
            'empname': empname,
            'empcnic': empcnic,
            'empdesg': empdesg,
        };

        console.log(postData);


        $.ajax({
            type: "POST",
            url: "PrintSlip.aspx/GetEmployeeDetails",
            data: JSON.stringify(postData),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                data = response.d;
                if (data.length == 0) {
                    $("#employeedetail").hide();
                    $("#feildsetemp").hide();

                    var vals = "";
                    $("#empname").text(vals);
                    $("#empdep").text(vals);
                    $("#empadd").text(vals);
                    $("#empdesg").text(vals);
                    showSuccessMsg("Employee Not Found");
                    return;
                }
                else {
                    $("#employeedetail").show();
                    $("#feildsetemp").show();
                    $.each(data, function (index, node) {
                        if (node.empname == "") {
                            showSuccessMsg("Employee Not Found");
                        }
                        else {
                            $("#empname").text(node.empname).val();
                            $("#empdep").text(node.department).val();
                            $("#empadd").text(node.empaddress).val();
                            $("#empdesg").text(node.empdesgination).val();
                            empnames = node.empname;
                            console.log(empnames);
                            empdep = data.empdep;
                            empdesg2 = node.empdesgination;
                            console.log(empdesg);
                            empaddress = node.empaddress;
                            empid = node.eid;
                            departments = node.department
                        }

                    });
                }
            },
            failure: function (jqXHR, textStatus, errorThrown) {
                alert("HTTP Status: " + jqXHR.status + "; Error Text: " + jqXHR.responseText); // Display error message  
            }
        });
    });
    ////////Save Log Reports
    function saveLogReports() {


        var Getimg = $("#image")[0].src;


        var valdate = $.trim($("[id$='ToDateFrom']").val());
        //if (relation == "") {
        //    showSuccessMsg("Please Select Relationship!");
        //    return false
        //}

        if (valdate == "") {
            showSuccessMsg("Please Select Validity Date!");
            return false
        }
        var perpose = ($("[id$='txtpurpose']").val());
        if (perpose == "") {
            showSuccessMsg("Please Enter Purpose of visite!");
            return false
        }


        //hours = ($("#ddhours option:selected").text());
        // if (hours == "") {
        //     showSuccessMsg("Please Select Validity hours!");
        //     return false
        // }

        // munaits = ($("#ddmunits option:selected").text());
        // if (munaits == "") {
        //     showSuccessMsg("Please Select Validity Minutes!");
        //     return false
        // }

        var todate = $.trim($("[id$='ToDateFrom']").val());

        var datetimevalidity = todate + " " + "23" + ":" + "59" + ":" + "00";

        /////console.log(datetimevalidity);


        var postData = {
            'userType': vtype,
            'date': todaydate,
            'Timein': todaytime,
            'EmployeeId': empid,
            'VID': VID,
            'Address': address,
            'Relation': relation,
            'VehNo': $.trim($("[id$='txtvehicalno']").val()),
            'visit_purpose': $.trim($("[id$='txtpurpose']").val()),
            'Department': departments,
            'status': status,
            'CNIC': $.trim($("[id$='txtcnic']").val()),
            'ValiditDate': datetimevalidity,
            'VISITOR_NAME': names,
            'img': Getimg,
        };
        $.ajax({
            type: "POST",
            url: "PrintSlip.aspx/SaveVisterLog",
            data: JSON.stringify(postData),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data) {
                GetAllCountExpiredVistor();
                GetAllActiveVisitor();
                GetAllVisitorlog();
                printSlip(data.d);
            },
            failure: function (jqXHR, textStatus, errorThrown) {
                alert("HTTP Status: " + jqXHR.status + "; Error Text: " + jqXHR.responseText); // Display error message  
            }
        });
    }

    $("#txtvehicalno").change(function () {
        var vehno = ($("#txtvehicalno").val());
        $("#vehno").text(vehno).val();
    });
});///////end document ready function GetAllVisitorlog

/////Print Slip
function printSlip(slipno) {
    var header = "<html><head></head><body>";
    var footer = "</div></body></html>";
    var divs = "<div style='float:center;border:3px solid rebeccapurple; width: 45%; margin-left:28%'>";
    var table = "<table style='width: 100%; height:50%;'><tr><td colspan='4'><p style='text-align: center; line-height: 5px;'><u>KRL</u></p></td></tr>";
    var tr1 = "<tr><td colspan='4'><p style='text-align: center; line-height: 0px;'><u>" + vtype + " Slip</u></p></td></tr>";
    var tr2 = "<tr><td colspan='4' style='font-size:14px;'><p style='text-align: center'><u>Slip No#  " + slipno + " </u></p></td></tr>";
    var tr3 = "<tr><td><p style='font-size:12px; line-height: 0px;'>Date: " + todaydate + "</p></td><td><p style='font-size:12px;'>Time: " + todaytime + "</p></td></tr>";
    var images = $("[id$='image']").prop('src');

    var tr_img = "<tr><td><p style='font-size:12px; line-height: 0px;'>Name: " + names + "</p></td><td rowspan='4'><img src=" + images + " alt='' style='width: 80px; height: 80px;'/> </td></tr>";
    var cnic = $.trim($("[id$='cnic']").val());
    var tr4 = "<tr><td><p style='font-size:12px;line-height: 0px;'>CNIC: " + cnic + "</p></td></tr>";
    var tr5 = "<tr><td><p style='font-size:12px;line-height: 6px;'>To See: " + empnames + "</p></td><td></td><td></td></tr>";
    var tr6 = "<tr><td><p style='font-size:12px;line-height: 6px;'>Designation: " + empdesg2 + "</p></td><td></td><td></td></tr>";

    var tr15 = "<tr><td><p style='font-size:12px;line-height: 6px;'>Departments: " + departments + "</p></td><td></td><td></td></tr>";

    var tr7 = "<tr><td><p style='font-size:12px;line-height: 0px;'>Address: " + address + "</p></td><td></td><td></td></tr>";
    var tr8 = "<tr><td><p style='font-size:12px;line-height: 0px;'> Relationship: " + RalationShip + "</p></td><td></td><td></td></tr>";
    var Purpose = $.trim($("[id$='txtpurpose']").val());
    var tr9 = "<tr><td><p style='font-size:12px; line-height: 0px;'>Purpose of Visit: " + Purpose + "</p></td><td></td><td></td></tr>";
    var Validaity = $.trim($("[id$='ToDateFrom']").val());
    var tr10 = "<tr><td><p style='font-size:12px;line-height: 6px; '>Validity to: " + Validaity + "</p></td><td></td><td></td></tr>";
    //// var tr11 = "<tr><td><p style='font-size:12px; line-height: 6px;'>Validity To Time: " + hours + ":" + munaits + ":" + "00" + "</p></td><td></td><td></td></tr>";
    var vehno = $.trim($("[id$='txtvehicalno']").val());
    var tr12 = "<td><p style='font-size:12px; line-height: 6px;'>Veh No: " + vehno + "</p></td><td></td><td></td></tr></table>";
    var rec = "<br><div style='float:right;margin-right:30px;'><p style='text-decoration: overline;line-height: 0px;'>Receptionist:</p ></div> <br>";
    var sign = "<p style='font-size:8px; text-decoration: overline; line-height: 5px;'>Signature of receving officer with data and time<p/><p style='font-size:12px;'>Note:<p/>";
    var descriptions = "<p style='font-size:10px; line-height: 10px;'>That attached notice slip will be signed and timed by the receiving officer <br> on termination of visit the visitor will please hand it over to the reception <br>officer who issued the slip <p/>";
    var add = "<p style='font-size:12px; line-height: 0px;'>Location:(" + empaddress + ")<p/>";
    var oldstr = document.body.innerHTML;

    document.body.innerHTML = header + divs + table + tr1 + tr2 + tr3 + tr_img + tr4 + tr7 + tr8 + tr9 + tr10 + tr12 + tr5 + tr6 + tr15 + rec + sign + descriptions + add + footer;
    window.print();

    document.body.innerHTML = oldstr;
    location.reload();
    return false;

    //let w = window.open('', 'PRINT', 'height=2000,width=1000');
    //w.document.open();
    //w.document.write("<html><head></head><body>");
    //w.document.write("<div style='float:left;border:3px solid rebeccapurple; width: auto;'>")
    //w.document.write("<table style='width: 100%;'>");

    //w.document.write("<tr>");
    //w.document.write("<td colspan='4'><p style='text-align: center'><u>KRL</u></p></td>");
    //w.document.write("</tr>");

    //w.document.write("<tr>");
    //w.document.write("<td colspan='4'><p style='text-align: center'><u>" + vtype + " Slip</u></p></td>");
    //w.document.write("</tr>");

    //w.document.write("<tr>");
    //w.document.write("<td colspan='4' style='font-size:14px;'><p style='text-align: center'><u>Slip No#  " + slipno + " </u></p></td>");
    //w.document.write("</tr>");

    //w.document.write("<tr>");
    //w.document.write("<td><p style='font-size:12px;'>Date: " + todaydate + "</p></td>");
    //w.document.write("<td><p style='font-size:12px;'>Time: " + todaytime + "</p></td>");
    //w.document.write("</tr>");
    //w.document.write("<tr>");
    //w.document.write("<td><p style='font-size:12px;'>Name: " + names + "</p></td>");
    //var images = $("[id$='image']").prop('src');
    //w.document.write("<td rowspan='4'> <img src=" + images + " alt='' style='width: 80px; height: 80px;'> </td>");
    //w.document.write("</tr>");
    //w.document.write("<tr>");
    //var cnic = $.trim($("[id$='cnic']").val());
    //w.document.write("<td><p style='font-size:12px;'>CNIC: " + cnic + "</p></td>");
    //w.document.write("</tr>");
    //w.document.write("<tr>");
    //w.document.write("<td><p style='font-size:12px;'>To See: " + empnames + "</p></td>");
    //w.document.write("<td></td>");
    //w.document.write("<td></td>");
    //w.document.write("</tr>");

    //w.document.write("<tr>");
    //w.document.write("<td><p style='font-size:12px;'>Designation: " + empdesg + "</p></td>");
    //w.document.write("<td></td>");
    //w.document.write("<td></td>");
    //w.document.write("</tr>");


    //w.document.write("<tr>");

    //w.document.write("<td><p style='font-size:12px;'>Address: " + address + "</p></td>");
    //w.document.write("<td></td>");
    //w.document.write("<td></td>");
    //w.document.write("</tr>");


    //w.document.write("<tr>");

    //w.document.write("<td><p style='font-size:12px;'> Relationship: " + relation + "</p></td>");
    //w.document.write("<td></td>");
    //w.document.write("<td></td>");
    //w.document.write("</tr>");

    //w.document.write("<tr>");
    //var Purpose = $.trim($("[id$='txtpurpose']").val());
    //w.document.write("<td><p style='font-size:12px;'>Purpose of Visit: " + Purpose + "</p></td>");
    //w.document.write("<td></td>");
    //w.document.write("<td></td>");
    //w.document.write("</tr>");

    /////w.document.write("<tr>");
    //var Validaity = $.trim($("[id$='ToDateFrom']").val());
    //w.document.write("<tr><td><p style='font-size:12px;'>Validity to: " + Validaity + "</p></td>");
    //w.document.write("<td></td>");
    //w.document.write("<td></td>");
    //w.document.write("</tr>");

    //w.document.write("<tr>");

    //w.document.write("<td><p style='font-size:12px;'>Validity To Time: " + hours + ":" + munaits + ":" + "00" + "</p></td>");
    //w.document.write("<td></td>");
    //w.document.write("<td></td>");
    //w.document.write("</tr>");


    //w.document.write("<tr>");
    //var vehno = $.trim($("[id$='txtvehicalno']").val());
    //w.document.write("<td><p style='font-size:12px;'>Veh No: " + vehno + "</p></td>");
    //w.document.write("<td></td>");
    //w.document.write("<td></td>");
    //w.document.write("</tr>");


    //w.document.write("</table>")
    //w.document.write("<br>");
    //w.document.write("<div style='float:right;margin-right:30px;'><p style='text-decoration: overline;'>Receptionist:</p ></div> ");
    //w.document.write("<br>");

    //w.document.write("<p style='font-size:8px; text-decoration: overline;'>Signature of receving officer with data and time<p/>");
    //w.document.write("<p style='font-size:12px;'>Note:<p/>");

    //w.document.write("<p style='font-size:10px;'>That attached notice slip will be signed and timed by the receiving officer <br> on termination of visit the visitor will please hand it over to the reception <br>officer who issued the slip <p/>");

    //////var gtno = $.trim($("[id$='Gate_No']").val());
    //w.document.write("<p style='font-size:12px;'>Location:(" + empaddress + ")<p/>");

    //w.document.write("</div></body></html>");

    //w.document.close();
    //w.print();
    //w.close();

}
/////////////Count All Active Visitors

function GetAllActiveVisitor() {

    $.ajax({
        type: "POST",
        url: "PrintSlip.aspx/GetAllActiveVisitor",
        data: '{}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (msg) {
            if (msg.d == 0) {
                let visitorcount = 0;
                $("#lblactiveVisitor").text(visitorcount).val();
            }
            else {
                $("#lblactiveVisitor").text(msg.d).val();

            }
        },
        failure: function (jqXHR, textStatus, errorThrown) {
            alert("HTTP Status: " + jqXHR.status + "; Error Text: " + jqXHR.responseText); // Display error message  
        }

    });
}

/////////////////////////Get All visitor Time Expired  count
function GetAllCountExpiredVistor() {

    $.ajax({
        type: "POST",
        url: "PrintSlip.aspx/GetAllCountExpiredVistor",
        data: '{}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (msg) {
            if (msg.d == 0) {
                let visitorcountexp = 0;
                $("#lblexpiredVisitor").text(visitorcountexp).val();
            }
            else {
                $("#lblexpiredVisitor").text(msg.d).val();

            }
        },
        failure: function (jqXHR, textStatus, errorThrown) {
            alert("HTTP Status: " + jqXHR.status + "; Error Text: " + jqXHR.responseText); // Display error message  
        }

    });
}
//////////////////// Get Checkout guest////////////////////////

function GetAllVisitorlog() {

    if ($.fn.DataTable.isDataTable('#uvisTable')) {
        $('#uvisTable').DataTable().destroy();
    }
    $('#uvisTable tbody').empty();

    $.ajax({
        type: "POST",
        url: "PrintSlip.aspx/GetAllVisitor",
        dataType: "json",
        contentType: "application/json",
        success: function (response) {

            $.each(response.d, function (index, value) {
                var tr = ""
                if (value.isexpared == 0) {

                    tr = "<tr style='color: red'>";
                    tr += "<td>" + value.id + "</td>";
                    tr += "<td>" + value.v_name + "</td>";
                    tr += "<td>" + value.cnic + "</td>";
                    tr += "<td>"  + value.hostpno + "</td>";
                    tr += "<td>" + "<input class='btn btn-primary' type='button' id='" + value.id + "' onclick='checkout(" + value.cnic + ")' value='Out'>" + "</td>" + "</tr>";
                    $("#tBody").append(tr);
                }
                else {
                    tr = "<tr>";
                    tr += "<td>" + value.id + "</td>";
                    tr += "<td>" + value.v_name + "</td>";
                    tr += "<td>" + value.cnic + "</td>";
                    tr += "<td>" + value.hostpno + "</td>";
                    tr += "<td>" + "<input class='btn btn-primary' type='button' id='" + value.id + "' onclick='checkout(" + value.cnic + ")' value='Out'>" + "</td>" + "</tr>";
                    $("#tBody").append(tr);

                }

            });
            $("#uvisTable").DataTable({
                deferRender: true,
                scrollY: 200,
                scrollCollapse: true,
                scroller: true,

            });
        },
        failure: function (jqXHR, textStatus, errorThrown) {
            alert("HTTP Status: " + jqXHR.status + "; Error Text: " + jqXHR.responseText); // Display error message  
        }
    });

}////////




////////////////////////Check out//////////////////////////////

function checkout(checkout_cnic) {
    var cnic_obj = {
        'cnic': checkout_cnic

    }
    $.ajax({
        type: 'POST',
        url: "PrintSlip.aspx/checkout",
        dataType: 'json',
        data: JSON.stringify(cnic_obj),
        contentType: "application/json; charset=utf-8",
        success: function () {
            showSuccessMsg("Checked Out Successfully");
            GetAllCountExpiredVistor();
            GetAllActiveVisitor();
            GetAllVisitorlog();
        },
        failure: function (jqXHR, textStatus, errorThrown) {
            alert("HTTP Status: " + jqXHR.status + "; Error Text: " + jqXHR.responseText); // Display error message  
        }

    });
}







///////////////////////////////////////////////////////




////////////////////////WebCam Business Comm ///////
var width = 320; // We will scale the photo width to this
var height = 0; // This will be computed based on the input stream
var streaming = false;
var video = null;
var canvas = null;
var photo = null;
var startbuttonBC = null;
function startupBCs() {
    $("#imgDisplay").hide();
    $("#startbuttonBC").show();
    $("#WebCamCallBC").hide();


    $("#videoBC").show();
    video = document.getElementById('videoBC');
    canvas = document.getElementById('canvasBC');
    photo = document.getElementById('image');
    startbuttonBC = document.getElementById('startbuttonBC');

    navigator.mediaDevices.getUserMedia({
        video: true,
        audio: false
    })
        .then(function (stream) {
            video.srcObject = stream;
            video.play();
        })
        .catch(function (err) {
            console.log("An error occurred: " + err);
        });

    video.addEventListener('canplay', function (ev) {
        if (!streaming) {
            height = video.videoHeight / (video.videoWidth / width);

            if (isNaN(height)) {
                height = width / (4 / 3);
            }

            video.setAttribute('width', width);
            video.setAttribute('height', height);
            canvas.setAttribute('width', width);
            canvas.setAttribute('height', height);
            streaming = true;
        }
    }, false);

    startbuttonBC.addEventListener('click', function (ev) {
        takepictureBCs();
        ev.preventDefault();
    }, false);

    clearphotoBCs();
}


function clearphotoBCs() {
    var context = canvas.getContext('2d');
    context.fillStyle = "#AAA";
    context.fillRect(0, 0, canvas.width, canvas.height);

    var data = canvas.toDataURL('image/png');
    photo.setAttribute('src', data);
}

function takepictureBCs() {
    $("#startbuttonBC").hide();
    $("#RecaptureBC").show();
    $("#photoBC").show();
    $("#videoBC").hide();
    var context = canvas.getContext('2d');
    if (width && height) {
        canvas.width = width;
        canvas.height = height;
        context.drawImage(video, 0, 0, width, height);

        var data = canvas.toDataURL('image/png');
        photo.setAttribute('src', data);
    } else {
        clearphotoBCs();
    }
}

function WebCamCallBCs() {
    $("#startbuttonBC").show();
    $("#imgDisplay").hide();
    $("#videoGU").show();
    startupBCs();
}

function RecaptureBCs() {
    $("#imgDisplay").hide();
    $("#photoBC").hide();

    $("#startbuttonBC").show();
    $("#RecaptureBC").hide();
    $("#WebCamCallBC").hide();

    $("#videoBC").show();
}

