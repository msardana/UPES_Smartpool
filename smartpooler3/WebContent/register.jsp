<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
   <link rel="stylesheet" type="text/css" href="css/anoceanofsky.css" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Register</title>
</head>
<body>

 <div id="mainPicture">
    	<div class="picture">
        	<div id="headerTitle">Welcome to Smart Poolers</div>
            <div id="headerSubtext">Powered by Bluemix</div>
        </div>
    </div>
        <div class="contentBox">
        	<div class="contentTitle">Smart Poolers</div>
          <div class="contentText"><p>You seems to be the first time user, please provide your contact number below and click Register </p><br />
</div>

<form action="welcome.jsp" method="POST" id="form">
  <input type="hidden" id="username" name="username" value=<%=request.getParameter("username")%>>
  <input type="hidden" id="email" name="email" value=<%=request.getParameter("email")%>>
  <input type="hidden" id="gender" name="gender" value=<%=request.getParameter("gender") %>>
  <p align="center">
  <input type="text" id="mobileno" name="mobileno" value=""/>
  <input type="submit" id="submit" name="register" value= "Register"/> 
</form>


</body>
</html>