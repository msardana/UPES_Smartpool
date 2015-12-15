<%@page import="dbaccess.DataLoader"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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

String mobile = request.getParameter("mob");

DataLoader d = new DataLoader();

String name = d.findParticipant(email);
if(name==null)
{
d.loadParticipantData(email, null, userName, "M");
}
%>

Thanks for sharing your ride. We have taken your request and will pass on your contact details to members needing ride on your way.

<a href="login.jsp"> Go back to Home </a>

</body>
</html>