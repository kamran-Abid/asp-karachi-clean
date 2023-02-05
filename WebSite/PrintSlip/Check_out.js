$(document).ready(function () {

    //$('#txtSearch_cnic').bind('keyup paste', function () {
    //    this.value = this.value.replace(/[^0-9]/g, '');
    //});

    $("#txtSearch_cnic").keypress(function (e) {
        //if the letter is not digit then display error and don't type anything
        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
            //display error message
           /// $("#errmsg").html("Digits Only").show().fadeOut("slow");
            return false;
        }
    });



    $("#guestdetail").hide();
    $("#Checkout").hide();

    $("#btnsearch_cnic").click(function () {


        var cnic = ($("#txtSearch_cnic").val());
        if (cnic == "") {
            showSuccessMsg("Please Enter Guest CNIC!");
            return false
        }
        var objData = {
            'cnic': cnic
        }

        $.ajax({
            type: 'POST',
            url: "Check_Out.aspx/Search_cnic",
            dataType: 'json',
            data: JSON.stringify(objData),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: OnGetMessages,
            failure: function (jqXHR, textStatus, errorThrown) {
                alert("HTTP Status: " + jqXHR.status + "; Error Text: " + jqXHR.responseText); // Display error message  
            }

        });
    });
    function OnGetMessages(msg) {

        var data = msg.d;
        console.log(data);

        if (data.length == 0) {
            showSuccessMsg(" Visitor Not Found");
            return;
        }
        else {

            $.each(data, function (index, node) {
                $("#guestdetail").show();
                $("#Checkout").show();
                if (node.name == "") {
                    showSuccessMsg("Employee  Found");
                }
                else {

                    var slipno = node.id;
                    var spno = "Slip No# " + slipno;
                    
                    $("#slip_No").text(spno);
                    $("#v_name").text(node.visitorname).val();
                    $("#vcnic").text(node.cnic).val();
                    $("#vvdate").text(node.date).val();
                    $("#vtime").text(node.time_in).val();
                    $("#vvddate").text(node.validitdate).val();
                    $("#hname").text(node.hostname).val();
                    $("#hdes").text(node.designation).val();
                    $("#hdep").text(node.department).val();
                    $("#haddress").text(node.currddr).val();
                    $("#vpurpose").text(node.visit_purpose).val();
                    $("#vrelation").text(node.relations).val();
                    $("#gtype").text(node.usertype).val();
                    $("#vnmbr").text(node.vehical_number).val();
                }
            });
        }
    }


    $("#Checkout").click(function () {

        var cnic = ($("#txtSearch_cnic").val());

        dataobj = {
            'cnic': cnic
        }

        $.ajax({
            type:'POST',
            url: "Check_Out.aspx/checkout",
            dataType: 'json',
            data: JSON.stringify(dataobj),
            contentType: "application/json; charset=utf-8",
            success: function () {
                showSuccessMsg("Checked Out Successfully");
                location.reload();
            },
            failure: function (jqXHR, textStatus, errorThrown) {
                alert("HTTP Status: " + jqXHR.status + "; Error Text: " + jqXHR.responseText); // Display error message  
            }

        });
    });
});