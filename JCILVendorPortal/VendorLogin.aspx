<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VendorLogin.aspx.cs" Inherits="JCILVendorPortal.VendorLogin" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Vendor Portal</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="css/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="js/Login.js"></script>
    <link href="css/font-awesome.css" rel="stylesheet" />
    <link href="http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,400,600" rel="stylesheet" />
    <script src="js/jquery-1.7.2.min.js"></script>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <link href="css/pages/signin.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(document).ready(function () {
            $("#password").keyup(function (event) {
                if (event.keyCode == 13) {
                    $("#btn_Login").click();
                }
            });
        });
    </script>
    <script type="text/javascript">
        function checkDec(el) {
            var ex = /^[0-9]+\.?[0-9]*$/;
            if (ex.test(el.value) == false) {
                el.value = el.value.substring(0, el.value.length - 1);
            }
        }
    </script>
    <style>
        body {
            background: url("Images/login-bg.jpg") no-repeat center center;
            background-size: cover;
        }
        .navbar-inner {
            background: none !important;
            -moz-border-radius: 0;
            -webkit-border-radius: 0;
            border-radius: 0;
            height: 74px;
            padding-top: 6px;
            -webkit-box-shadow: none !important;
            box-shadow: none !important;
        }
        input {
            height: 15px;
            color: #fff !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="navbar navbar-fixed-top">
            <div class="navbar-inner">
                <div class="container">
                    <img src="" />
                </div>
            </div>
        </div>
        <div class="account-container">
            <div class="content clearfix">
                <div class="l_part_top">
                    <div class="l_part_wrap">
                        <div class="logo">
                            <center> <img src="Images/logo.png" alt="Jay Chemicals"> </center>
                        </div>
                    </div>
                </div>
                <br />
                <div class="login-fields">
                    <div class="field">
                        <label for="username">Username</label>
                        <input type="text" id="username" name="username" value="" style="color: #fff;" placeholder="Username" class="login username-field" />
                    </div>
                    <div class="field">
                        <label for="passwordcaption">Password:</label>
                        <input type="password" id="password" name="password" value="" style="color: #fff;" onkeydown="return (event.keyCode!=13);" onkeyup="checkDec(this);" placeholder="Password" class="login password-field" />
                    </div>
                </div>
                <div class="login-actions">                    
                    <input type="button" id="btn_Login" style="background-color: #fff; border: none; border-radius: 0; color: #8e8d8d !important; text-transform: uppercase; width: 100%;" value="Login" class="button btn btn-success btn-large" onclick="return CheckLogIn();" />

                </div>
                <!-- .actions -->





            </div>
            <!-- /content -->

        </div>
        <!-- /account-container -->



        <%--<div class="login-extra">
	<a href="#">Reset Password</a>
</div> <!-- /login-extra -->--%>


        <script src="js/jquery-1.7.2.min.js"></script>
        <script src="js/bootstrap.js"></script>

        <script src="js/signin.js"></script>
    </form>
    <%--<div class="navbar navbar-fixed-top">
	
	<div class="navbar-inner">
		
		<div class="container">
			
			
			
				
			
			
	
		</div> <!-- /container -->
		
	</div> <!-- /navbar-inner -->
	
</div> <!-- /navbar -->--%>
</body>

</html>
