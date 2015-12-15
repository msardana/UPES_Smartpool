<%@page import="dbaccess.DataLoader, java.util.Calendar, java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
 <link rel="stylesheet" type="text/css" href="css/anoceanofsky.css" />
<title>add pooling request</title>
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

String source = request.getParameter("StartLocation");
String destination = request.getParameter("EndLocation");
String vehicleNumber = request.getParameter("VehicleNumber");
Double distance = Double.parseDouble(request.getParameter("Distance"));
// int distance = 20;
String startTime = request.getParameter("startTime");
String endTime = request.getParameter("endTime");
int seats = Integer.parseInt(request.getParameter("Seats"));
int weeks = Integer.parseInt(request.getParameter("weeks"));

boolean monday=false, tuesday=false,  wednesday=false,  thursday=false, friday=false, saturday=false, sunday=false;


if(request.getParameter("monday") != null)
{
//monday = Integer.parseInt(request.getParameter("monday"));
monday = true;
}

if(request.getParameter("tuesday") != null)
{
//	tuesday = Integer.parseInt(request.getParameter("tuesday"));
tuesday=true;
}
if(request.getParameter("wednesday") != null )
{
	wednesday = true;
//	wednesday = Integer.parseInt(request.getParameter("wednesday"));
}
if(request.getParameter("thursday") != null)
{
	thursday=true;
//	thursday= Integer.parseInt(request.getParameter("thursday"));
}
if(request.getParameter("friday") != null)
{
	friday=true;
//	frinday = Integer.parseInt(request.getParameter("friday"));
}
if(request.getParameter("saturday") != null)
{
	saturday=true;
//	saturday = Integer.parseInt(request.getParameter("saturday"));
}
if(request.getParameter("sunday") != null)
{
	sunday = true;
//	sunday = Integer.parseInt(request.getParameter("sunday"));
}



Timestamp time = Timestamp.valueOf(startTime);




DataLoader d = new DataLoader();
String id = ""+email + source+ destination +"";
d.loadRouteData1(id, email, source, destination, vehicleNumber, distance);
String activeid = ""+email + source+ destination + startTime + "";

d.loadRouteActive(id, time, endTime, seats);

Calendar cal = Calendar.getInstance();
cal.setTimeInMillis(time.getTime());

int day;

for(int i=0; i<weeks*7; i++)
{
	 cal.add(Calendar.DAY_OF_WEEK, 1);
	 day = cal.get(Calendar.DAY_OF_WEEK);
	 Timestamp stime = new Timestamp (cal.getTimeInMillis());
	 if((day==1 && sunday) || (day==2 && monday) || (day==3 && tuesday) || (day==4 && wednesday) || (day==5 && thursday) || (day==6 && friday) || (day==7 && saturday) )
	 {
		 d.loadRouteActive(id, stime, endTime, seats);
	 }
 }
%>
  <div id="page">
        <div class="topNaviagationLink"><a href="welcome.jsp">Home</a></div>
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
        	<div class="contentTitle">Smart Poolers</div>
          <div class="contentText"><p>Thanks for sharing your ride. We have taken your request and will pass on your contact details to members needing ride on your way. </p><br />
</div>
<h2>
</h2>


</body>
</html>