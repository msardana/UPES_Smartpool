<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="css/anoceanofsky.css" />
<title>Welcome to Smart Poolers</title>

<script type="text/javascript">

function validateForm() {
    var x = document.forms["feedback"]["data"].value;
    if (x == null || x == "") {
        alert("A Feedback must be filled out");
        return false;
    }
}


</script>

</head>

<body>
<%
 
String userName = null;
String email = null;
Cookie[] cookies = request.getCookies();
if(cookies !=null){
for(Cookie cookie : cookies){
  if(cookie.getName().equals("user")) userName = cookie.getValue();
  if(cookie.getName().equals("email")) email = cookie.getValue();
}
}
if(userName == null) response.sendRedirect("login.jsp");
            %>




    <div id="page">
        <div class="topNaviagationLink"><a href="welcome.jsp">Home</a></div>
           <div class="topNaviagationLink"><a href="myspace.jsp" > My Space</a></div>
        <div class="topNaviagationLink"><a href="seeder.jsp">Provide A Ride</a></div>
        <div class="topNaviagationLink"><a href="leecher.jsp">Find A Ride</a></div>
        <div class="topNaviagationLink"><a href="feedback.jsp">Feedback</a></div>
	    <div class="topNaviagationLink"><a href="contactus.jsp">Contact Us</a></div>
        <div class="topNaviagationLink"><a href="logout.jsp">Log Out</a></div>
	</div>
    <div id="mainPicture">
    	<div class="picture">
        	<div id="headerTitle">Welcome to Smart Poolers</div>
            <div id="headerSubtext">Powered by Bluemix</div>
        </div>
    </div>
        <div class="contentBox">
    	<div class="innerBox">
        	<div class="contentTitle">Provide a Feedback : </div>
          <div class="contentText"><p>Please do let know how we could serve you  better. We value your opinion and would like to hear from you. <br><br> 
          	<form  name="feedback"  action="addFeedback.jsp;"  onsubmit="return validateForm()"  method="get">
          		<textarea rows="4" cols="50" name="data" id="data">

				</textarea>
				<br><br>
				<input type="submit" value="Send Feedback"> 
			</form>
          </p><br />
</div>

        
</body>
</html>
