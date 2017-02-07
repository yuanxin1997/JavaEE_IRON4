<%@ page import="WayfinderModel.Waypoint" %><%--
  Created by IntelliJ IDEA.
  User: User
  Date: 2/5/2017
  Time: 2:02 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css"
          rel="stylesheet" type="text/css">
    <link href="http://pingendo.github.io/pingendo-bootstrap/themes/default/bootstrap.css"
          rel="stylesheet" type="text/css">

    <%
        Waypoint wa = (Waypoint) session.getAttribute("feedbackSelected");

        String name = wa.getName();
        String waId = wa.getId();
        String isEnabled = "Enabled";
        if(wa.getListValue().equalsIgnoreCase("1"))
            isEnabled = "Disabled";

    %>

    <script>

        $(document).ready(function()
        {
            getFeedback();
        })

        function appendTableFeedback(index, errType, isCrit, fbid, fdate, ftime){

            console.log("fbId is "+ fbid);

            var feedbackTable = $('#feedbackTable > tbody:last');
            feedbackTable.append(
                '<tr>'+
                '<td>'+ index +'</td>'+
                '<td>'+ftime+'</td>'+
                '<td>'+fdate+'</td>'+
                '<td>'+errType+'</td>'+
                '<td>'+isCrit+'</td>'+
                '<td>'+
                '<a class="btn btn-primary" onclick="dismissFeedback('+fbid+')">Dismiss</a>' +
                '</td>' +
                '</tr>'
            );

        }

        function getFeedback(){

            var url = '/wayServices/waypointFeedback/getAllFeedback/<%=waId%>';

            $.ajax({

                async:false,
                url: url,
                type: 'GET',
                datatype: 'json',
                success:function(response)
                {
                    var index=1;

                    for(var i=0; i<response.length; i++)
                    {
                        var f =response[i];
                        var errType;

                        switch(f.type) {
                            case 2:
                                errType = "Area Busy";
                                break;
                            case 3:
                                errType = "Missing QR Code";
                                break;
                            case 4:
                                errType = "Hard To Find Waypoint";
                                break;
                            default:
                                errType = "Waypoint Inaccessible";
                        }

                        appendTableFeedback(index, errType , f.crit, f.id, f.date, f.time);
                        index++;
                    }

                }


            })

        }

        function dismissFeedback(fbId) {
            if(confirm("Are you sure about deleting this feedback?")){
                alert("Feedback deleted");
                window.location = "/feedbackDismiss?from=feedback&all=no&delAllId=no&delId="+fbId;
            } else {
                alert("Feedback Delete Cancelled")
            }
        }

        function dismissFeedbackWaypoint() {

            var cnfm = prompt("To Delete all feedback here please enter name of Waypoint", "");
            console.log(cnfm + " real: <%=name%>");
            if (cnfm == "<%=name%>") {
                alert("All entries deleted from waypoint")
                window.location = "/feedbackDismiss?from=feedback&all=no&delAllId=<%=waId%>&delId=no";
            }
            else{
                alert("Feedback Delete Cancelled");
            }
        }


    </script>

</head>

<body>
<div class="navbar navbar-default navbar-static-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-ex-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand"><span>Wayfinder</span></a>
        </div>
        <div class="collapse navbar-collapse" id="navbar-ex-collapse">
            <ul class="nav navbar-nav navbar-right">
                <li class="">
                    <a href="mainPage.html">Home</a>
                </li>
                <li class="active">
                    <a href="WayfinderLanding.jsp">Wayfinder</a>
                </li>
            </ul>
        </div>
    </div>
</div>
<div class="section">
    <div class="container">
        <div class="row">
            <div class="col-md-12 text-center">
                <h1 class="text-left"><%=name%></h1>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 text-center">
                <p class="text-left">Feedback gathered of the QR waypoint.
                    <br>
                </p>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <h3>Waypoint Status: <%=isEnabled%></h3>
            </div>
            <div class="col-md-6">
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <a class="btn btn-primary" style="display: inline" onclick="setTimeout(refreshToggle(), 1000); alert('Waypoint Disabled.');"
                   href="/enableWaypoint?id=<%=waId%>" >Toggle Status</a>
            </div>
            <div class="col-md-6">
            </div>
        </div>
    </div>
</div>
<div class="section">
    <div class="container">
        <div class="row">
            <div class="col-md-12 text-right">
                <table class="table" id="feedbackTable">
                    <thead>
                    <tr>
                        <th style="width:50px">#</th>
                        <th style="width:50px">Time</th>
                        <th style="width:50px">Date</th>
                        <th>Feedback Subject</th>
                        <th style="width:230px">Critical issue</th>
                        <th style="width:130px">Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>

                <a class="btn btn-primary" style="display: inline" onclick="dismissFeedbackWaypoint()">Dismiss All</a>
                <a class="btn btn-primary" style="display: inline" href="WayfinderWaypointControl.jsp">Back</a>
            </div>
        </div>
    </div>
</div>
</body>

</html>