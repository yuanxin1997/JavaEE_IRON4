<%--
  Created by IntelliJ IDEA.
  User: PawandeepSingh
  Date: 14/12/16
  Time: 9:26 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
</head>
<body>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">

<link rel='stylesheet prefetch' href='http://fonts.googleapis.com/css?family=Roboto:400,100,300,500,700,900|RobotoDraft:400,100,300,500,700,900'>
<link rel='stylesheet prefetch' href='http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css'>

<link rel="stylesheet" href="../assetsPawandeep/Logincss/style.css">

<div class="container">

    <div class="card"></div>
    <div class="card">
    <h1 class="title">Login</h1>
    <form action="/Dashboard" method="post">
        <div class="input-container">
            <input type="text" id="username" required="required" name="username"/>
            <label for="username">Username</label>
            <div class="bar"></div>
        </div>
        <div class="input-container">
            <input type="password" id="password" required="required" name="password"/>
            <label for="password">Password</label>
            <div class="bar"></div>
        </div>
        <div class="button-container">
            <button><span>Login</span></button>
        </div>
        <div class="footer"><a href="#">Forgot your password?</a></div>
    </form>
</div>
</div>


<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>


</body>
</html>
