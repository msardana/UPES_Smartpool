<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="css/anoceanofsky.css" />
<title>Welcome to SmartPoolers</title>
</head>

<body>

<%

 String userName = null;
  String email = null;
  String mobileno = null;
  String gender = null;
  String name = null;
Cookie[] cookies = request.getCookies();
if(cookies !=null){
for(Cookie cookie : cookies){
    if(cookie.getName().equals("user")) userName = cookie.getValue();
    if(cookie.getName().equals("email")) email = cookie.getValue();
}
}

// direct request to this page
if(userName == null &&  request.getParameter("username").toString() == null) 
{
response.sendRedirect("login.jsp");
} 
// request coming from login page
if(userName == null &&  request.getParameter("username").toString() != null)
{ 
             userName = request.getParameter("username").toString();         
             email = request.getParameter("email").toString();
            Cookie loginCookie = new Cookie("user",userName);
            Cookie emailCookie = new Cookie("email", email);
            //setting cookie to expiry in 30 mins
            loginCookie.setMaxAge(30*60);
            response.addCookie(loginCookie);
            response.addCookie(emailCookie);


//check if the user is first time or registered user
dbaccess.DataLoader d = new dbaccess.DataLoader();
name = d.findParticipant(email);
// If not registered, forward the request to register
if(name==null)
{
%>
<jsp:forward page="register.jsp"/>
<%
}
}

//request coming from register page
if(userName != null && request.getParameter("mobileno") != null)
{
            userName = request.getParameter("username").toString();         
             email = request.getParameter("email").toString();
             mobileno = request.getParameter("mobileno").toString();
             gender = request.getParameter("gender").toString();
         
         dbaccess.DataLoader d = new dbaccess.DataLoader();    
 d.loadParticipantData(email, mobileno, userName, gender);
 }
 
 %>
 
    <div id="page">
        <div class="topNaviagationLink"><a href="welcome.jsp">Home</a></div>
        <div class="topNaviagationLink"><a href="myspace.jsp" > My Space</a></div>
        <div class="topNaviagationLink"><a href="seeder.jsp">Provide A Ride</a></div>
        <div class="topNaviagationLink"><a href="seeder_del.jsp"> Delhi Special Car Pool</a></div>
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
        	<div class="contentTitle">Smart Poolers</div>
          <div class="contentText"><p>Thank you for using Smart Poolers, the most dynamic and real-time ride sharing portal. </p><br />
</div>

        
</body>
</html>
