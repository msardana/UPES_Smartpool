<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/anoceanofsky.css" />
<title>logout</title>
</head>
<body>

<script src="fb.js">
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
//Load the SDK asynchronously
(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js";
  fjs.parentNode.insertBefore(js, fjs);
}
(document, 'script', 'facebook-jssdk'));

</script>
<script type="text/javascript">

logout();

</script>
<%
  Cookie loginCookie = null;
        Cookie[] cookies = request.getCookies();
        if(cookies != null){
        for(Cookie cookie : cookies){
            if(cookie.getName().equals("user")){
                loginCookie = cookie;
                break;
            }
        }
        }
        if(loginCookie != null){
            loginCookie.setMaxAge(0);
            response.addCookie(loginCookie);
        }
 %>
 
 <h1> you have been logged out of the application </h1>
  click here to go <a href="login.jsp"> Back to home page </a>
</body>
</html>