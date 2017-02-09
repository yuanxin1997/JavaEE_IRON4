<%@ page import="Model.Patient" %><%--
  Created by IntelliJ IDEA.
  User: PawandeepSingh
  Date: 5/2/17
  Time: 2:12 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>Patient Bill</title>


    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />


    <!-- Bootstrap core CSS     -->
    <link href="../../assetsPawandeep/Dashboard/assets/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Animation library for notifications   -->
    <link href="../../assetsPawandeep/Dashboard/assets/css/animate.min.css" rel="stylesheet"/>
    <!--  Light Bootstrap Table core CSS    -->
    <link href="../../assetsPawandeep/Dashboard/assets/css/light-bootstrap-dashboard.css" rel="stylesheet"/>
    <!--     Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,700,300' rel='stylesheet' type='text/css'>
    <link href="../../assetsPawandeep/Dashboard/assets/css/pe-icon-7-stroke.css" rel="stylesheet" />

    <%--moment JS--%>
    <script src="https://cdn.jsdelivr.net/momentjs/2.13.0/moment.min.js"></script>

    <!--jQuery-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

    <script type="text/javascript" src="../../assetsPawandeep/Dashboard/noty/packaged/jquery.noty.packaged.min.js"></script>

    <!--jquery ui-->
    <link href="../../assetsPawandeep/Dashboard/jquery-ui/jquery-ui.css" rel="stylesheet">
    <script src="../../assetsPawandeep/Dashboard/jquery-ui/jquery-ui.js"></script>
    <script src="../../assetsPawandeep/Dashboard/jquery-ui/jquery.ui.autocomplete.scroll.js"></script>
    <script src="../../assetsPawandeep/Dashboard/jquery-ui/jquery.ui.autocomplete.scroll.min.js"></script>
</head>
<%
    Patient pt = (Patient) session.getAttribute("patient");
    String name = pt.getFirstName() + " " + pt.getLastName(); ;

    String NRIC = pt.getNRIC();

    String cid = "";
    boolean conferenceEnd = false;

        cid = request.getParameter("cid");
    if(cid == null || cid.equals(""))
    {
        cid = "0";
    }


%>

<style>

    #paymentcontainer
    {
        width: 500px;
        clear: both;
    }

    #paymentcontainer input
    {
        width: 100%;
        clear: both;
    }





</style>
<script>

    var conferenceEnd = false;
    conferenceEnd = <%=conferenceEnd%>;


    var consultationid =  '<%=cid%>';

    var idint = parseInt('<%=cid%>')
    var billId;

    var patientBill = [];

    var intervalId = 0;



  function ValidateInput()
  {
      var isValid = true;
      $('#paymentContainer input').each(function ()
      {
          var element = $(this);
          if(element.val() == "")
          {
             // alert('missing fields')
              isValid =  false;
          }
      })

      return isValid;
  }


    function validatePayments()
    {


        if(ValidateInput())
        {
            alert('Payment is successfully made');
            return true

        }
        else
        {
            alert('error')
            return false;
        }
    }

    function displayBill(descriptionList,priceList,totalAmoutBeforeGST,totalAmoutAfterGST)
    {
        var size = descriptionList.length;

        var duration = descriptionList[size - 1];
        var durationPrice = priceList[size-1];


        for(var i = 0 ; i<(size-1); i++)
        {
            var description = descriptionList[i];
            var price = priceList[i];


            $('#BillTable > tbody').append
            (
                    '<tr>'+
                    '<td style="border: none; border-right:#ddd thin solid;" >'+ description +'</td>' +
                    '<td style="border: none;">'+ price +'</td>'+
                    '</tr>'
            )
        }

        $('#BillTable > tbody').append
        (
                '<tr>'+
                '<td style=" border: none; border-right:#ddd thin solid;" >'+ duration + ' minutes'+'</td>' +
                '<td style="border: none;">'+ durationPrice+'</td>'+
                '</tr>' +

                '<tr>'+
                '<td style="border-right:#ddd thin solid;" >'+ 'Total CHARGE' +'</td>' +
                '<td>'+ totalAmoutBeforeGST +'</td>'+
                '</tr>' +

                '<tr>'+
                '<td style="border: none; border-right:#ddd thin solid;" >'+ 'Amount payable before GST' +'</td>' +
                '<td style="border: none;">'+ totalAmoutBeforeGST +'</td>'+
                '</tr>' +

                '<tr>'+
                '<td style="border: none; border-right:#ddd thin solid;" >'+ 'Add 7% GST' +'</td>' +
                '<td style="border: none;">'+ totalAmoutAfterGST +'</td>'+
                '</tr>' +

                '<tr>'+
                '<td style="border-right:#ddd thin solid;" >'+ 'Total Amount payable' +'</td>' +
                '<td >'+ "$ " +totalAmoutAfterGST +'</td>'+
                '</tr>'


        )
    }

    $(document).ready(function (){

        $('#selectedBillContent').hide();

        $('#paymentContainer').hide();

        getPatientBills();

        $('#makePaymentBtn').click(function ()
        {
                $('#paymentContainer').show();
        })

            // alert('it works');
            //var modal = $('#myModal');
        var id = consultationid;

        if(!(id == '0'))
        {
            $('#myModal').modal({backdrop: 'static', keyboard: false});
            $('#myModal').modal('show');
            setTimeout(function()
            {
                $('#myModal').modal('hide');
            },3000)
        }




            console.log(id);

            var seconds = 5000;
            intervalId = setInterval(function ()
            {
                getPatientBills();
                console.log('interval');
            },seconds);

        <%--function getConsultationBill(cid) //NOW TESTING ON CID 3--%>
        <%--{--%>
            <%--$.ajax(--%>
                    <%--{--%>
                        <%--async : false,--%>
                        <%--url : '/services/bill/getpatientconsultationbill/' + cid,--%>
                        <%--type: 'GET',--%>
                        <%--datatype : 'json',--%>
                        <%--success : function (data)--%>
                        <%--{--%>
                            <%--if(!(data.BillID == null))--%>
                            <%--{--%>
                                <%--billId = data.BillID;--%>
                                <%--//console.log(data);--%>
                                <%--displayBill(data.descriptionList,data.priceList,data.totalAmtBeforeGST,data.totalAmountPayable);--%>
                                <%--$('#billidinput').val(billId);--%>
                                <%--$('#patientidinput').val('<%=NRIC%>');--%>
                                <%--$('#mainBody').replaceWith($('#selectedBill'));--%>
                                <%----%>
                                <%--$('#myModal').modal('hide');--%>
                                <%--clearInterval(intervalId);--%>
                            <%--}--%>

                            <%--//window.location.reload(1);--%>

                        <%--},--%>
                        <%--error:function () {--%>
                            <%--//$('#myModal').modal('show');--%>
                        <%--}--%>
                    <%--})--%>
        <%--}--%>


        function getPatientBills()
        {
            $('#pendingBillTable > tbody').empty();
            $('#paidBillTable > tbody').empty();
                $.ajax(
                        {
                            async : false,
                            url : '/services/bill/getpatientbills/'+'<%=NRIC%>',
                            type: 'GET',
                            datatype : 'json',
                            success : function (data)
                            {
                                patientBill = data;

                                for(var i = 0 ; i < data.length;i++)
                                {
                                    var isPaymentmade = data[i].isPaymentMade;
                                    var billid = data[i].BillID;
                                    var billdatetime = data[i].BillingDate;
                                    if(isPaymentmade)
                                    {
                                        appendPaidBillTable((i+1),billid,billdatetime)

                                    }
                                    else
                                        {
                                            appendPendingBillTable((i+1),billid,billdatetime)

                                        }
                                }



                            },
                        })
        }

        function appendPendingBillTable(index,billid , billdatetime)
        {
            $('#pendingBillTable > tbody:last').append
            (
                    ' <tr> ' +
                    '<td> '+ billid+'</td>' +
                    ' <td>'+billdatetime+'</td> ' +
                    '<td> <button id="viewbill">View</button> </td> ' +

                    '</tr>'
            )
        }

        function appendPaidBillTable(index,billid , billdatetime)
        {
            $('#paidBillTable > tbody:last').append
            (
                    ' <tr> ' +
                    '<td>'+billid+'</td>' +
                    ' <td>'+billdatetime+'</td> ' +
                    '<td> <button id="viewbill">View</button> </td> ' +
                    '</tr>'
            )
        }


        function getBill(billid)
        {
            var bill = [];
            $.ajax(
                    {
                        async : false,
                        url : '/services/bill/getbill/'+billid,
                        type: 'GET',
                        datatype : 'json',
                        success : function (data)
                        {
                            bill = data;
                        },
                    })

            return bill;
        }

        setViewBtnListener();

        //TODO : GET PATIENT PARTICULARS , INCLUDING CONSULTATION DURATION AND DATETIME
        function setViewBtnListener()
        {


            $('#patientidinput').val('<%=NRIC%>');
            console.log($('#patientidinput').val())

            console.log(patientBill);
            $('#paidBillTable').on('click','#viewbill',function ()
            {

                //$('#mainBody').hide();

                var rowStr = $(this).closest('tr').find('td:first').text(); // get selected row index
                //var rowIndex = parseInt(rowStr) - 1;
                var rowIndex = $(this).closest('td').parent()[0].sectionRowIndex; // get selected row index

                var billid = patientBill[rowIndex].BillID;
                var selectedbill = getBill(billid);
              //  console.log('slected billid ' + billid);
                $('#makePaymentBtn').hide();
                $('#paymentTitle').text("Payment already made ");


                $('#billidinput').val(billid);

                displayBill(selectedbill.descriptionList,selectedbill.priceList,selectedbill.totalAmtBeforeGST,selectedbill.totalAmountPayable)
                $('#mainBody').replaceWith($('#selectedBill'))

                console.log( ' selceted billid this time haha : ' +  $('#billidinput').val());
            })

            $('#pendingBillTable').on('click','#viewbill',function ()
            {

                var rowStr = $(this).closest('tr').find('td:first').text(); // get selected row index
//                var rowIndex = parseInt(rowStr) - 1;
                var rowIndex = $(this).closest('td').parent()[0].sectionRowIndex; // get selected row index
                var billid = patientBill[rowIndex].BillID;
               // console.log('slected billid ' + billid);
                var selectedbill = getBill(billid);

                $('#billidinput').val(billid);

                displayBill(selectedbill.descriptionList,selectedbill.priceList,selectedbill.totalAmtBeforeGST,selectedbill.totalAmountPayable)
                $('#makePaymentBtn').show();
                $('#paymentTitle').text("Payment");
                $('#mainBody').replaceWith($('#selectedBill'));

                console.log( ' selceted billid this time haha : ' +  $('#billidinput').val());

            })
        }

        $('#DisplayAllBillbtn').click(function()
        {
            window.location.reload();
            $('#myModal').empty();
        })




    })



</script>
<body>



<div class="wrapper">


    <div class="sidebar" data-color="green" >

        <!--

        Tip 1: you can change the color of the sidebar using: data-color="blue | azure | green | orange | red | purple"
        Tip 2: you can also add an image using data-image tag

    -->
        <!--SIDE BAR NAVIGATION-->
        <div class="sidebar-wrapper">
            <div class="logo">
                <a href="javascript:void(0)" class="simple-text">
                    Welcome <%=name%>
                </a>
            </div>

            <ul class="nav">

                <li id="mainClick">
                    <a href="/telehtml/Dashboard/patientDashboard.jsp">
                        <i class="pe-7s-home"></i>
                        <p>Dashboard</p>
                    </a>
                </li>

                <li id="consultationClick">
                    <a href="#">
                        <i class="pe-7s-note2"></i>
                        <p>Consultations</p>
                    </a>
                </li>

                <li  class="active">
                    <a href="#">
                        <i class="pe-7s-users"></i>
                        <p>Bills</p>
                    </a>
                </li>

            </ul>
        </div>



    </div>
    <!--END OF SIDEBAR-->

    <div class="main-panel">


        <!--TOP NAVBARS-->
        <nav class="nav navbar-default navbar-fixed">

            <div class="container-fluid">

                <!--BAR NAVIGATION HEADER-->

                <div class="navbar-header">




                </div>

                <div class="collapse navbar-collapse">

                    <!--LEFT SIDE TOP BAR NAVIGATION-->

                    <ul class="nav navbar-nav navbar-left">
                        <li>

                        </li>
                    </ul>

                    <!--RIGHT SIDE TOP BAR NAVIGATION-->
                    <%--TODO UPDATE LIKE YUAN XIN's --%>
                    <ul class="nav navbar-nav navbar-right">

                        <li class="dropdown">
                            <a href="" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                <%=name%>
                                <b class="caret"></b>
                            </a>

                            <ul class="dropdown-menu">
                                <li>
                                    <a href="/telehtml/H@Hboard/H@HBoard.jsp">Head back to main page</a>
                                </li>
                            </ul>
                        </li>
                    </ul>

                </div>


            </div>
        </nav>



        <!--MAIN BODY-->
        <div class="content" id="mainBody">
            <div class="container-fluid">

                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                                <div class="header">
                                    <H3 class="title">Pending Bills</H3>
                                </div>
                                <div class="content">
                                        <table class="table" id="pendingBillTable">
                                            <thead>
                                                <tr>
                                                    <th>Bill No.</th>
                                                    <th>Bill DateTime</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>

                                            </tbody>
                                        </table>
                                </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="header">
                                <H3 class="title">Paid Bills</H3>
                            </div>
                            <div class="content">
                                <table class="table" id="paidBillTable">
                                    <thead>
                                    <tr>
                                        <th>Bill No.</th>
                                        <th>Bill DateTime</th>
                                        <th>Action</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>


            </div>
        </div>





    </div>

</div>





</body>

<!--   Core JS Files   -->
<!--<script src="../../assetsPawandeep/Dashboard/assets/js/jquery-1.10.2.js" type="text/javascript"></script>-->
<script src="../../assetsPawandeep/Dashboard/assets/js/bootstrap.min.js" type="text/javascript"></script>

<!--  Checkbox, Radio & Switch Plugins -->
<script src="../../assetsPawandeep/Dashboard/assets/js/bootstrap-checkbox-radio-switch.js"></script>

<!--  Charts Plugin -->
<script src="../../assetsPawandeep/Dashboard/assets/js/chartist.min.js"></script>

<!--  Notifications Plugin    -->
<script src="../../assetsPawandeep/Dashboard/assets/js/bootstrap-notify.js"></script>




</html>



<!-- Modal Core -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <%--<button type="button" class="close" data-dismiss="modal" aria-hidden="true" id="closeLoadModal">&times;</button>--%>
                <h4 class="modal-title" id="myModalLabel1">Please wait a few minutes as doctor is summarizing consultation.</h4>
            </div>
            <div class="modal-body">
                Loading
            </div>
            <div class="modal-footer">
                <%--<button type="button" class="btn btn-default btn-simple" data-dismiss="modal">Close</button>--%>
                <%--<button type="button" class="btn btn-info btn-simple">Save</button>--%>
            </div>
        </div>
    </div>
</div>

<!--MAIN BODY-->
<div class="content" id="selectedBillContent">
    <div class="container-fluid" id="selectedBill">

        <button class="btn btn-round" id="DisplayAllBillbtn">
                <i class="pe-7s-angle-left"></i>
        </button>

        <div class="row">
            <div class="col-md-12">
                <div class="card">

                    <div class="header">
                        <h3 class="title">Bill for Tele-Conference</h3>
                        <p class="small">Date : </p>
                    </div>

                    <div class="content table-full-width table-responsive">
                        <table class="table table-bordered" id="BillTable">
                            <thead>
                            <tr>
                                <th>Description</th>
                                <th>Amount Payable</th>
                            </tr>
                            </thead>

                            <tbody>


                            </tbody>
                        </table>
                    </div>

                    <div class="footer">
                        <div class="stats">


                        </div>
                        <button id="makePaymentBtn">Make Payment</button>
                    </div>

                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="card">

                    <div class="header">
                        <h3 class="title" id="paymentTitle">Payment</h3>
                        <hr>
                    </div>

                    <div class="content" id="paymentContainer">

                        <form action="/payment" method="post" onsubmit="return validatePayments()">
                            <p>Personal Information</p>
                            <hr>

                            <input hidden name="billid" id="billidinput">
                            <input hidden name="patientnric" id="patientidinput">

                            <label for="firstNameinput"> First Name  </label>
                            <input type="text" name="firstName" id="firstNameinput">


                            <br>

                            <label for="lastNameinput">Last Name </label>
                            <input type="text" name="lastName" id="lastNameinput">

                            <br>

                            <label for="emailinput"> Email address: </label>
                            <input type="email" name="emailaddr" id="emailinput">



                            <hr>
                            <p>Credit Card info</p>
                            <hr>

                            <label for="cardtypeinput"> Payment Type </label>
                            <select name="cardtype" id="cardtypeinput">
                                <option value="null">--Select One--</option>
                                <option value="Amercian Express">American Express</option>
                                <option value="Discover">Discover</option>
                                <option value="Mastercard">Mastercard</option>
                                <option value="VISA">VISA</option>
                            </select>


                            <br>
                            <label for="creditcardinput"> Credit card Num </label>
                            <input type="number" name="creditcardnum" id="creditcardinput" minlength="1" maxlength="16">


                            <br>

                            <label> Expiration Date :</label>

                            <label for="monthexpireinput" ></label>
                            <input type="number" name="monthexpiredate" id="monthexpireinput" placeholder="mm" style="width: 5em">


                            /
                            <label for="yearexpireinput"></label>
                                <input type="number" name="yearexpiredate" id="yearexpireinput" PLACEHOLDER="yy" style="width: 5em">

                            <br>

                            <label for="cscinput">CSC</label>
                            <input type="number" name="cscnum" id="cscinput" style="width: 5em"><a href="/explainCSC.html" target="popup" onclick="window.open('../explainCSC.html','popup','width=450,height=300'); return false"> What is this ?</a>

                            <p>Billing Information</p>

                            <label for="companyinput"> Company (optional):</label>
                            <input name="company" type="text" size="50" id="companyinput">

                            <br>


                            <label for="address1input">Street Address: </label>
                            <input name="address1" type="text" value="" size="50" id="address1input">

                            <br>

                            <label for="address2input">Street Address (2 (Optional)):</label>
                            <input name="address2" type="text" value="" size="50" id="address2input">

                            <br>


                            <label for="stateinput">State/Province:</label>
                            <input name="state" type="text" value="" size="50" id="stateinput">

                            <br>

                            <label for="zipinput">Zip/Postal Code:</label>
                            <input name="zip" type="text" value="" size="50" id="zipinput">

                            <br>

                            <label for="countryinput"> Country:</label>
                            <input name="country" type="text" value="" size="50" id="countryinput">

                            <br>

                            <label for="phoneinput">Phone:</label>
                            <input name="phone" type="text" value="" size="50" id="phoneinput">


                            <button type="submit">Confirm Payment</button>

                        </form>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>