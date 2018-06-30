<?php
ob_start();
session_start(); // start a new session or continues the previous
if( isset($_SESSION['user'])!="" ){
 header("Location: home.php"); // redirects to home.php
}
include_once 'db_connect.php';
$error = false;
if ( isset($_POST['btn-signup']) ) {

 // sanitize user input to prevent sql injection
 $name = trim($_POST['name']);
 $name = strip_tags($name);
 $name = htmlspecialchars($name);

 $email = trim($_POST['email']);
 $email = strip_tags($email);
 $email = htmlspecialchars($email);

 $pass = trim($_POST['pass']);
 $pass = strip_tags($pass);
 $pass = htmlspecialchars($pass);

 // basic name validation
 if (empty($name)) {
  $error = true;
  $nameError = "Please enter your full name.";
 } else if (strlen($name) < 3) {
  $error = true;
  $nameError = "Name must have atleat 3 characters.";
 } else if (!preg_match("/^[a-zA-Z ]+$/",$name)) {
  $error = true;
  $nameError = "Name must contain alphabets and space.";
 }

 //basic email validation
 if ( !filter_var($email,FILTER_VALIDATE_EMAIL) ) {
  $error = true;
  $emailError = "Please enter valid email address.";
 } else {
  // check whether the email exist or not
  $query = "SELECT `user_email` FROM `user` WHERE `user_email`='$email'";
  $result = mysqli_query($conn, $query);
  $count = mysqli_num_rows($result);
  if($count!=0){
   $error = true;
   $emailError = "Provided Email is already in use.";
  }
 }
 // password validation
 if (empty($pass)){
  $error = true;
  $passError = "Please enter password.";
 } else if(strlen($pass) < 6) {
  $error = true;
  $passError = "Password must have atleast 6 characters.";
 }

 // password hashing for security
$password = hash('sha256', $pass);


 // if there's no error, continue to signup
 if( !$error ) {
  
  $query = "INSERT INTO `user` (`user_name`,`user_email`,`user_password`) VALUES('$name','$email','$password')";
  $res = mysqli_query($conn, $query);
  
  if ($res) {
   $errTyp = "success";
   $errMSG = "Successfully registered, you may login now";
   unset($name);
   unset($email);
   unset($pass);
  } else {
   $errTyp = "danger";
   $errMSG = "Something went wrong, try again later...";
  }
  
 }


}
?>
	
	<!DOCTYPE html>
	<html lang="zxx" class="no-js">
	<head>
		<!-- Mobile Specific Meta -->
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<!-- Favicon-->
		<link rel="shortcut icon" href="img/fav.png">
		<!-- Author Meta -->
		<meta name="author" content="codepixer">
		<!-- Meta Description -->
		<meta name="description" content="">
		<!-- Meta Keyword -->
		<meta name="keywords" content="">
		<!-- meta character set -->
		<meta charset="UTF-8">
		<!-- Site Title -->
		<title>Car Rentals</title>

		<link href="https://fonts.googleapis.com/css?family=Poppins:100,200,400,300,500,600,700" rel="stylesheet"> 
			<!--
			CSS
			============================================= -->
			<link rel="stylesheet" href="css/linearicons.css">
			<link rel="stylesheet" href="css/font-awesome.min.css">
			<link rel="stylesheet" href="css/bootstrap.css">
			<link rel="stylesheet" href="css/magnific-popup.css">
			<link rel="stylesheet" href="css/nice-select.css">					
			<link rel="stylesheet" href="css/animate.min.css">
			<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">			
			<link rel="stylesheet" href="css/owl.carousel.css">
			<link rel="stylesheet" href="css/main.css">
		</head>
		<body>

			  <header id="header" id="home">
			    <div class="container">
			    	<div class="row align-items-center justify-content-between d-flex">
				      <div id="logo">
				        <a href="index.html"><img src="img/logo.png" alt="" title="" /></a>
				      </div>		    		
			    	</div>
			    </div>
			  </header>


			<!-- start banner Area -->
			<section class="banner-area relative" id="home">
				<div class="overlay overlay-bg"></div>	
				<div class="container">
					<div class="row fullscreen d-flex align-items-center justify-content-center">
						<div class="col-lg-5  col-md-6 header-right">
							<h4 class="text-white text-center pb-30">Sign Up Here!</h4>
								<form class="form" method="post" action="<?php echo htmlspecialchars($_SERVER['PHP_SELF']); ?>" autocomplete="off">
							<?php
									if ( isset($errMSG) ) {
									
									?>
											<div class="alert alert-<?php echo $errTyp ?>">
															<?php echo $errMSG; ?>
										</div>

									<?php
									}
									?>
							        <div class="col-md-6 wrap-right">
							    <div class="form-group row">
							        </div>
							    </div>							    
							    <div class="from-group">
									<input class="form-control txt-field" type="text" name="name" maxlength="50"  placeholder="Your name">
									<span class="text-danger"><?php echo $nameError; ?></span>
									<input class="form-control txt-field" type="email" name="email" maxlength="50"  placeholder="Email address">
									<span class="text-danger"><?php echo $emailError; ?></span>
									<input class="form-control txt-field" type="password" name="pass" maxlength="15" placeholder="password">
									<span class="text-danger"><?php echo $passError; ?></span>
							    </div>
							    <div class="form-group row">
							        <div class="col-md-12">
							            <button type="submit" class="btn btn-default btn-lg btn-block text-center text-uppercase mb-30" name="btn-signup">Register</button>
									</div>
									<div class="col-md-12 text-center">
									<a href="index.php">Sign in Here...</a>
								</div>
							    </div>
							</form>
						</div>											
					</div>
				</div>					
			</section>
			<!-- End banner Area -->		

			<script src="js/vendor/jquery-2.2.4.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
			<script src="js/vendor/bootstrap.min.js"></script>			
			<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBhOdIF3Y9382fqJYt5I_sswSrEw5eihAA"></script>
			<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>			
  			<script src="js/easing.min.js"></script>			
			<script src="js/hoverIntent.js"></script>
			<script src="js/superfish.min.js"></script>	
			<script src="js/jquery.ajaxchimp.min.js"></script>
			<script src="js/jquery.magnific-popup.min.js"></script>	
			<script src="js/owl.carousel.min.js"></script>			
			<script src="js/jquery.sticky.js"></script>
			<script src="js/jquery.nice-select.min.js"></script>	
			<script src="js/waypoints.min.js"></script>
			<script src="js/jquery.counterup.min.js"></script>					
			<script src="js/parallax.min.js"></script>		
			<script src="js/mail-script.js"></script>	
			<script src="js/main.js"></script>	
		</body>
	</html>
	<?php ob_end_flush(); ?>



