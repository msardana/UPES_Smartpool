<%@page import="dbaccess.DataLoader"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/anoceanofsky.css" />
 <title>add Feedback request</title>
</head>
<body>

<%



String userName=null;
String email=null;
String data = request.getParameter("data");
Cookie[] cookies = request.getCookies();
if(cookies !=null){
for(Cookie cookie : cookies){
   if(cookie.getName().equals("user")) userName = cookie.getValue();
   if(cookie.getName().equals("email")) email = cookie.getValue();
}
}
if(userName == null) response.sendRedirect("login.jsp");

DataLoader d = new DataLoader();
d.loadFeedbackData(email, data);


%>

<H2>Thanks for providing a Feedback. We have noted down your suggestion and we shall do our best to make the application more suitable to your needs.</H2>   

<a href="welcome.jsp"> Go back to Home </a>

</body>
</html>