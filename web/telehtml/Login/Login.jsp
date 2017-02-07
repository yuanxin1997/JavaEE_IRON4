<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<link rel="icon" type="image/png" href="assets/img/favicon.png">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

	<title>Login</title>

	<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />

	<!--     Fonts and icons     -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700" />
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />

	<!-- CSS Files -->
    <link href="../../assetsPawandeep/Login/assets/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../../assetsPawandeep/Login/assets/css/material-kit.css" rel="stylesheet"/>

	<!--jQuery-->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
</head>


<body>

<%

	boolean validUser = true;
	if(! (request.getAttribute("errorMessage")==null))
	{
		validUser = false;
	}
	else
	{
		validUser = true;
	}



%>

<script>


	$(document).ready(function ()
	{
        $('#myModal').modal({backdrop: 'static', keyboard: false})
        $('#myModal').modal('show');

            //$('#btn').click();


		var validUser = <%=validUser%>

		if(!validUser)
		{
			alert('Invalid Username or Password.Please try again.');
		}
	})


</script>

<div class="wrapper">

			<%--<!-- here you can add your content -->--%>
			<%--<!-- Button trigger modal -->--%>
			<%--<button class="btn btn-primary" id="btn" data-toggle="modal" data-target="#myModal" hidden>--%>
				<%--Login--%>
			<%--</button>--%>


<!-- Modal Core -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
				<div class="row">
					<div class="card">
						<div class="header header-info text-center purple">
							<h4>Login</h4>
						</div>
						<form class="form" action="/dashboard" method="post">
							<p class="text-divider">
                            </p>
							<div class="content">
                                    <br>
								<div class="input-group">
										<span class="input-group-addon">
											<i class="material-icons">face</i>
										</span>
									<input type="text" class="form-control" id="username" placeholder="Username" name="username" required/>
								</div>

								<div class="input-group">
										<span class="input-group-addon">
											<i class="material-icons">lock_outline</i>
										</span>
									<input type="password" placeholder="Password" class="form-control" name="password" id="password" required/>
								</div>

							</div>
							<div class="footer text-center">
								<button type="submit" class="btn btn-simple btn-info btn-lg">Login</button>
							</div>

						</form>

						<div class="text-center">
							<a class="btn btn-simple btn-danger">Forget Password</a>
                                    <br>
                            <hr>
                            <a class="text-center btn btn-round btn-info"  href="/html/mainPage.html">Back to Main Page</a>
						</div>
					</div>
				</div>

			</div>


		</div>
	</div>
</div>


</body>

	<!--   Core JS Files   -->
	<script src="../../assetsPawandeep/Login/assets/js/jquery.min.js" type="text/javascript"></script>
	<script src="../../assetsPawandeep/Login/assets/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="../../assetsPawandeep/Login/assets/js/material.min.js"></script>

	<!--  Plugin for the Sliders, full documentation here: http://refreshless.com/nouislider/ -->
	<script src="../../assetsPawandeep/Login/assets/js/nouislider.min.js" type="text/javascript"></script>

	<!--  Plugin for the Datepicker, full documentation here: http://www.eyecon.ro/bootstrap-datepicker/ -->
	<script src="../../assetsPawandeep/Login/assets/js/bootstrap-datepicker.js" type="text/javascript"></script>

	<!-- Control Center for Material Kit: activating the ripples, parallax effects, scripts from the example pages etc -->
	<script src="../../assetsPawandeep/Login/assets/js/material-kit.js" type="text/javascript"></script>

</html>
