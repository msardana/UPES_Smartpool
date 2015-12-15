

<!DOCTYPE html>
<html>
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


  <head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>Leecher Page</title>
    <style>
      html, body, #map-canvas {
        height: 100%;
        margin: 0px;
        padding: 0px
      }
      #panel {
        position: absolute;
        top: 5px;
        left: 50%;
        margin-left: -180px;
        z-index: 5;
        background-color: #fff;
        padding: 5px;
        border: 1px solid #999;
      }
    </style>
    
     <script src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script>
    <script>
var directionsDisplay;
var directionsService = new google.maps.DirectionsService();
var map;
var total=0;

function initialize() {
  directionsDisplay = new google.maps.DirectionsRenderer();
  var nagpur = new google.maps.LatLng(21.1457854, 79.0881336); 
  var mapOptions = {
    zoom: 6,
    center: nagpur
  };
  map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
  directionsDisplay.setMap(map);
}
 google.maps.event.addDomListener(window, 'load', initialize);

 </script>
 
      <script>
    
    function findProviders()
    {
    	
    	
    	 var x = document.forms["leecher"]["Mob"].value;
         if (x == null || x == "") {
             alert("Mobile number field must be filled out");
             return false;
         }
            
         var x = document.forms["leecher"]["StartLocation"].value;
         if (x == null || x == "") {
             alert("Start Location field must be filled out");
             return false;
         }

         var x = document.forms["leecher"]["EndLocation"].value;
         if (x == null || x == "") {
             alert("End Location field must be filled out");
             return false;
         }

         var x = document.forms["leecher"]["StartTime"].value;
         if (x == null || x == "") {
             alert("Start Time field must be filled out");
             return false;
         }

    	
         
         
    	var xmlhttp = new XMLHttpRequest();  
    	  
    //    alert("I got in");  
        xmlhttp.open("GET", "FindActiveRouteInfo?"+ new Date().getTime(), false);  
       
        xmlhttp.send(null);   
  
        if (xmlhttp.readyState==4 && xmlhttp.status==200) {  
            jsonDoc = xmlhttp.responseText;
         //  alert(jsonDoc);
        } else {  
            
            alert("Error in AJAX");  
        } 
        
        jsonObject = JSON.parse(jsonDoc);   
        totalMatches = 0;
       
       document.getElementById("match_panel").innerHTML="";
        document.getElementById("match_panel").innerHTML += "We found the following matches for your search";
        document.getElementById("match_panel").innerHTML +="<br></br>";
      
       for(var j=0; j<(jsonObject.routeInfo).length; j++)
     {
    	var  seederSource=jsonObject.routeInfo[j].source;
        var seederDestination = jsonObject.routeInfo[j].destination;
        var seederEmail = jsonObject.routeInfo[j].email;
        var distance = jsonObject.routeInfo[j].distance;
        var mobileno = jsonObject.routeInfo[j].mobileno;
       var starttime = jsonObject.routeInfo[j].starttime;
       var total=0;
     //   alert ("calling matchRoute");
    //    alert( seederSource);
    //    alert(distance);
     //   myFunction();
        (function (lseederSource, lseederDestination, lseederEmail, ldistance, lmobileno, lstarttime, ltotal )
        		{
        	
//        	alert("inside calcTotalRoute");
   //   	 alert ("local seeder Source");
    //   alert(lseederSource);
       	  var leecherSource = document.getElementById("StartLocation").value;
       	  var leecherDestination = document.getElementById("EndLocation").value;
       	//  var leecherStartTime = document.getElementById("StartTime").value;
       	  

//       	  alert("leecher Destination");
//       	  alert(leecherDestination);
       	  var waypts = [];
       	  
       	      waypts.push({
       	          location:leecherSource,
       	          stopover:true});
       	      waypts.push({
       	          location:leecherDestination,
       	          stopover:true});


       	//******************I am setting optimizeWaypoints to false, so that the logic does not Treat a Leecher going from point A to B, the same as the one going from B to A  ******************

       	  var request = {
       	      origin: lseederSource,
       	      destination: lseederDestination,
       	      waypoints: waypts,
       	      optimizeWaypoints: false,
       	      travelMode: google.maps.TravelMode.DRIVING
       	  };
       	  
        //    alert("seeder start time is" + lstarttime);
             
//       	  alert("before calling direction services");
       	  directionsService.route(request, function(response, status) {
       	    if (status == google.maps.DirectionsStatus.OK) {
       	//      directionsDisplay.setDirections(response);
       	  //    alert("inside direction Services");
       	      
       	      var route = response.routes[0];
       	     
       	      
       	   
       	      // For each route, display summary information.
       	      for (var i = 0; i < route.legs.length; i++) {
       	    	  
       	        ltotal += parseInt(route.legs[i].distance.value);
       	    //    alert(i);
       	     //   alert(total);
       	      };
       	      //******************converts total distance in meters to Kilometers ******************
       	  //    totalDistance = totalDistance/1000;
       	  //    summaryPanel.innerHTML += totalDistance;
       	    }
       	//    document.getElementById('Distance').value = totalDistance;
       	//    alert("total distance is " + total);

       	    ltotal = ltotal/1000;
       	    
      // 	   alert("local seeder is" + lseederSource + "local seeder destination" + lseederDestination + "seeder distance is " + ldistance + "total distance is" + ltotal);
      	//    alert(distance);
       	    
       	   	if (Boolean(ltotal <= (ldistance*1.1))){
           		document.getElementById("match_panel").innerHTML += "EmailID "+ lseederEmail + ",  Mobile Number " + lmobileno + ", Start Time" + lstarttime ;
           		document.getElementById("match_panel").innerHTML +="<br></br>";
           		totalMatches = totalMatches+1;
           	}
           	
       	
       	//   	document.getElementById('Distance').value = total;
       	  });
//       	  alert("after calling direction services");
//       	  alert("total distance inside calctotalroute");
       	  
        	
        		}) (seederSource, seederDestination, seederEmail, distance, mobileno, starttime,total);
     }
    }
    
    

   
function calcRoute() {
	
	  var x = document.forms["leecher"]["StartLocation"].value;
	    if (x == null || x == "") {
	        alert("Start Location field must be filled out");
	        return false;
	    }

	    var x = document.forms["leecher"]["EndLocation"].value;
	    if (x == null || x == "") {
	        alert("End Location field must be filled out");
	        return false;
	    }


  var start = document.getElementById('StartLocation').value;
  var end = document.getElementById('EndLocation').value;

  var request = {
      origin: start,
      destination: end,
      travelMode: google.maps.TravelMode.DRIVING
  };
  directionsService.route(request, function(response, status) {
    if (status == google.maps.DirectionsStatus.OK) {
     directionsDisplay.setDirections(response);
      var route = response.routes[0];
      
      
      // For each route, display summary information.
      for (var i = 0; i < route.legs.length; i++) {
        
	document.getElementById('StartLocation').value = route.legs[i].start_address;
        
	document.getElementById('EndLocation').value = route.legs[i].end_address;
        
	document.getElementById('Distance').value = route.legs[i].distance.text;
      }
    }
  });
}



</script>
  </head>
  <body>
<p align="right">

   <button id="fbLogout" onclick="location.href='logout.jsp'"> logout </button>
  
  </p>
  
    <div id="map-canvas" style="float:left;width:70%;height:100%;"></div>
    <div id="control_panel" style="float:right;width:30%;text-align:left;padding-top:20px">

    <form name="leecher">

    <div style="margin:10px;border-width:2px;">

      Name : <%= userName %><br><br>
      Email Id : <%= email %><br><br>
			Number of Seats : <select name="Seats"><option selected>1</option>
					<option>2</option>
					<option>3</option>
					<option>4</option>
					<option>5</option>
					<option>6</option>
					<option>7</option>
					<option>8</option>
			</select> 
			<br><br>
    <b>Contact Number:</b>  <input type="text" name="Mob" id="Mob" size="20">
    <br>
    <br>
    <b>Start location:</b>  &nbsp&nbsp <input type="text" name="StartLocation" size="40" id="StartLocation">
  
    <br>
    <br>
    <br>
    <b>End location:</b> &nbsp&nbsp&nbsp <input type="text" name="EndLocation" size="40" id="EndLocation">
    
    <br>
    <br>
    <br>
      <input type="button" onclick="calcRoute();" value="Show Route">
      If the route shown in the map is correct, please provide your start time and Estimated End time and click Submit 
      <br>
    <br>
      <b>Start Time:</b> <input type="datetime" name="StartTime" size="40"><br><br>
      
    <input type="button" value="Find Ride Provider" onclick ="findProviders();" >
    
    <input  id="Distance" type="hidden" value="0">
    
    </form>
    
     <div id="match_panel" style="margin:20px;background-color:#FFEE77;"></div>
      
    
  
  </body>
</html>

