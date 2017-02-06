<%@ page import="java.util.ArrayList" %>
<%@ page import="WayfinderDBController.RouteDA" %>
<%@ page import="WayfinderModel.Path" %>
<%@ page import="WayfinderModel.Waypoint" %>
<%@ page import="WayfinderDBController.WaypointDA" %>
<%--
  Created by IntelliJ IDEA.
  User: User
  Date: 12/13/2016
  Time: 9:41 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%--%>

<%--%>--%>
<html><head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <meta http-equiv="Expires" content="Sat, 01 Dec 2001 00:00:00 GMT">
    <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
    <script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <link href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="..\css\qq.css" rel="stylesheet" type="text/css">

    <style>
        .topPart{
            margin: 0 auto;
            padding-top:0;
        }

        #map-canvas
        {
            margin-left: auto;
            margin-right: auto;
            width: 500px;
            height: 350px;
            border: 2px;
            border-color: #0f0f0f;
            display: block;
        }
        @media (min-width:350px)
        {
            #map-canvas
            {
                margin-left: auto;
                margin-right: auto;
                width: 350px;
                height: 210px;
                border: 2px;
                display: block;
            }
        }
        @media (min-width:1000px)
        {
            #map-canvas
            {
                margin-left: auto;
                margin-right: auto;
                width: 500px;
                height: 300px;
                border: 2px;
                display: block;
            }
        }
    </style>

    <%
        response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
        response.setHeader("Pragma","no-cache"); //HTTP 1.0
        response.setDateHeader ("Expires", -1); //prevents caching at the proxy server
        ArrayList<Path> pathList = (ArrayList) session.getAttribute("pathList");
        ArrayList<Waypoint> waypointList = (ArrayList) session.getAttribute("waypointList");
        System.out.println(session.getAttribute("current"));


        int x = (Integer) session.getAttribute("nextPoint")-1;
        ArrayList <String> waypointIdList = (ArrayList<String>) session.getAttribute("selectedRoute");
        String name = WaypointDA.getWaypoint(waypointIdList.get(x)).getName();
        String id = WaypointDA.getWaypoint(waypointIdList.get(x)).getId();

        session.setAttribute("id", id);
        String redirectAddr = "/changeServlet?originId="+id;
        session.setAttribute("new", "no");
    %>

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
                    <a href="#">Home</a>
                </li>
                <li class="active">
                    <a href="WayfinderLanding.jsp">Wayfinder</a>
                </li>
                <li>
                    <a href="#">Diabetes Monitor</a>
                </li>
                <li>
                    <a href="login.jsp">Virtual Chat</a>
                </li>
            </ul>
        </div>
    </div>
</div>
<div class="section text-center topPart">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1>Step 4: Wayfinding</h1>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <p>Review your current location or move on!
                    <br>
                </p>
            </div>
        </div>
    </div>
</div>
<div class="section">
    <div class="container">
        <div class="row">
            <div class="col-xs-12">
                <img id="map-canvas" src="/img/<%=id%>.jpg">
            </div>
        </div>
        <div class="row">
            <div class="col-xs-6 text-left">
                <h2>Current Waypoint:</h2>
                <h3><%=name%></h3>
                <br>
                <a class="btn btn-primary" href="WayfinderFeedback.jsp">Leave Feedback</a>
                <br>
                <br>
                <a class="btn btn-primary" href="<%=redirectAddr%>">Change Destination</a>
                <br>
            </div>
            <div class="col-xs-6 text-right">
                <br>
                <a class="btn btn-primary" href="WayfinderStep4Route.jsp">Continue</a>
            </div>
        </div>
    </div>
</div>
<div class="section" style="padding-top: 0;">
    <div class="container">
        <div class="row">

        </div>
    </div>
</div>
</body>

</html>