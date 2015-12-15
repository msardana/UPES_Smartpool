<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml">
<head>
<title>SmartPoolers</title>
<link rel="stylesheet" type="text/css" href="css/anoceanofsky.css" />
<meta charset="UTF-8">
</head>
<body>
	<br><br><br><br>
	    <div id="mainPicture">
    	<div class="picture">
        	<div id="headerTitle">Welcome to Smart Poolers</div>
            <div id="headerSubtext">Powered by Bluemix</div>
        </div>
    </div>
<script>
  // This is called with the results from from FB.getLoginStatus().
   window.fbAsyncInit = function() {
  FB.init({
    appId      : '1496631547237874',
    cookie     : true,  // enable cookies to allow the server to access 
                        // the session
    xfbml      : true,  // parse social plugins on this page
    version    : 'v2.0' // use version 2.0
  });
   };
   
// Load the SDK asynchronously
   (function(d, s, id) {
     var js, fjs = d.getElementsByTagName(s)[0];
     if (d.getElementById(id)) return;
     js = d.createElement(s); js.id = id;
     js.src = "//connect.facebook.net/en_US/sdk.js";
     fjs.parentNode.insertBefore(js, fjs);
   }
   (document, 'script', 'facebook-jssdk'));

    checkLoginState();


   function statusChangeCallback(response) {
	    console.log('statusChangeCallback');
	  //  alert("statusChangeCallback");
	    console.log(response);
	    // The response object is returned with a status field that lets the
	    // app know the current login status of the person.
	    // Full docs on the response object can be found in the documentation
	    // for FB.getLoginStatus().
	    if (response.status === 'connected') {
	      // Logged into your app and Facebook.
	      testAPI();
	    } else if (response.status === 'not_authorized') {
	      // The person is logged into Facebook, but not your app.
	      
	    } else {
	      // The person is not logged into Facebook, so we're not sure if
	      // they are logged into this app or not.
	      
	    }
	  }

	  // This function is called when someone finishes with the Login
	  // Button.  See the onlogin handler attached to it in the sample
	  // code below.
	  function checkLoginState() {
	 //  alert("checkLoginState");
	    FB.getLoginStatus(function(response) {
	   
	    	
	      statusChangeCallback(response);
	    });
	  }


	  // Now that we've initialized the JavaScript SDK, we call 
	  // FB.getLoginStatus().  This function gets the state of the
	  // person visiting this page and can return one of three states to
	  // the callback you provide.  They can be:
	  //
	  // 1. Logged into your app ('connected')
	  // 2. Logged into Facebook, but not your app ('not_authorized')
	  // 3. Not logged into Facebook and can't tell if they are logged into
	  //    your app or not.
	  //
	  // These three cases are handled in the callback function.

	  FB.getLoginStatus(function(response) {
	    statusChangeCallback(response);
	  });



	  

	  // Here we run a very simple test of the Graph API after login is
	  // successful.  See statusChangeCallback() for when this call is made.
	  function testAPI() {
	    console.log('Welcome!  Fetching your information.... ');
	    FB.api('/me', function(response) {
	    	
	    	document.getElementById("username").value = response.name;
	    	document.getElementById("email").value = response.email;
	    	document.getElementById("gender").value = response.gender;
	    	
	   // 	alert(response.name);
	    //    alert(response.email);
	    //    alert(response.gender);
	    	document.forms[0].submit();
	        
	        //     document.getElementById('status').innerHTML =
	    //      'Thanks for logging in, ' + response.name + '!';
	    //    document.getElementById('applink').setAttribute("style", "visibility: visible");
	   
	        //     setCoookies(response.name);
	        
	   //   response.sendRedirect("welcome.html");
	      
	 //     node a = document.createElement("a");
	  //    document.body.appendChild(a);
	      
	  
	    });
//	    FB.api('/posts', function(response) {
	 //   	document.getElementById('update').innerHTML = response.});
	  }
	  
	  function logout() {
	  FB.logout(function(response) {
	  });
	  
	  
	  
	  }
	  

</script>

<!--
  Below we include the Login Button social plugin. This button uses
  the JavaScript SDK to present a graphical Login button that triggers
  the FB.login() function when clicked.
-->

<p align="center">
<label>At Present we only support login using FaceBook account, We are working on more options for you</label>
<br>
<fb:login-button scope="public_profile,email,user_friends" size="large" onlogin="checkLoginState();">
</fb:login-button>

<form style="display: hidden" action="welcome.jsp" method="POST" id="form">
  <input type="hidden" id="username" name="username" value="">
  <input type="hidden" id="email" name="email" value="">
    <input type="hidden" id="gender" name="gender" value="">
</form>

</body>
</html>
