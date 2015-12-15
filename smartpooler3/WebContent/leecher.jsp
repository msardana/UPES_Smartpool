

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
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
    <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
    <link rel="stylesheet" type="text/css" href="css/anoceanofsky.css" />
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
        margin-left: -300px;
        z-index: 5;
        background-color: #fff;
        padding: 5px;
        border: 1px solid #999;
      }
    </style>
    
     <script src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script>
     <script type="text/javascript">   
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

function calcRoute() {
	
//	alert("i am in calc route");
	
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

function findProviders(){	
	
	var xmlhttp = new XMLHttpRequest();  
        
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

     var x = document.forms["leecher"]["startTime"].value;
     if (x == null || x == "") {
         alert("Start Time field must be filled out");   
         return false;
     }
     
     var currentDate = new Date();
    
     if(Date.parse(x.replace(/-/g, '/')) < currentDate)
    	 {
    	 alert("Start date and Time must be in future");   
    	 return false;
    	 }

	
     
	
	  
	// alert("I got in");  
	 
	var leecherStartTime = document.getElementById("dtp_input1").value;
	var timeTol = document.getElementById("tolerance").value;
	var seats = document.getElementById("seats").value;
	
	//alert(timeTol);
   
    
    
    xmlhttp.open("GET", "FindActiveRouteInfo?leecherStartTime="+ leecherStartTime +"&tolerance=" + timeTol + "&seats=" + seats, false);  
   
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
    document.getElementById("match_panel").innerHTML += "<label> We found the following matches for your search <label>";
    document.getElementById("match_panel").innerHTML +="<br></br>";
  
    var count=0;
   for(var j=0; j<(jsonObject.routeInfo).length; j++)
 {
	var  seederSource=jsonObject.routeInfo[j].source;
    var seederDestination = jsonObject.routeInfo[j].destination;
    var seederEmail = jsonObject.routeInfo[j].email;
    var distance = jsonObject.routeInfo[j].distance;
    var mobileno = jsonObject.routeInfo[j].mobileno;
   var starttime = jsonObject.routeInfo[j].starttime;
    var name = jsonObject.routeInfo[j].name;
   var total=0;    
   // Added by Manesh to ensure Leecher route is atleast 20% of Seeder Distance
   var distanceLeecher=0;
 //   alert ("calling matchRoute");
//    alert( seederSource);
//    alert(distance);
 //   myFunction();
    (function (lseederSource, lseederDestination, lseederEmail, ldistance, lmobileno, lstarttime, ltotal, lname, ldistanceLeecher)
    		{
    	
//    	alert("inside calcTotalRoute");
//   	 alert ("local seeder Source");
//   alert(lseederSource);
   	  var leecherSource = document.getElementById("StartLocation").value;
   	  var leecherDestination = document.getElementById("EndLocation").value;
   	   
   	  

//   	  alert("leecher Destination");
//   	  alert(leecherDestination);
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
         
//   	  alert("before calling direction services");
   	  directionsService.route(request, function(response, status) {
   	    
   		if (status == google.maps.DirectionsStatus.OK) {
     	      
     	      var route = response.routes[0];
     	     
     	      
     	   
     	      // For each route, display summary information.
     	      for (var i = 0; i < route.legs.length; i++) {
     	    	  
     	        ltotal += parseInt(route.legs[i].distance.value);
     	      };
     	      
     	      // Added by Manesh to ensure Leecher route is atleast 20% of Seeder Distance
     	      ldistanceLeecher = parseInt(route.legs[1].distance.value);
     	      
     	      
     	      //******************converts total distance in meters to Kilometers ******************
     	  //    totalDistance = totalDistance/1000;
     	  //    summaryPanel.innerHTML += totalDistance;
   		}
     	//    document.getElementById('Distance').value = totalDistance;
     	//    alert("total distance is " + total);
  		
     	
     		//leg2 denotes the distance from Leecher Source to Destination
     		
     		
     	    ltotal = ltotal/1000;
     	    ldistanceLeecher = ldistanceLeecher/1000;
     	    
    	
    	
    	    //Manesh : This if ensures Deviation is not more than 10% and that Leecher route is atleast 20% of Seeder Distance
     	    if (Boolean(ltotal <= (ldistance*1.1) && ldistanceLeecher >= (ldistance*0.2))){
     	   	//if (Boolean(ltotal <= (ldistance*1.1)))
     	   	//	document.getElementById("match_panel").innerHTML +="<input type=\"radio\" name=\"op1\" data-seederSource = \"" + lseederSource + "\" data-seederDestination = \"" +  lseederDestination +"\"  data-leecherSource= \"" + leecherSource +"\" data-leecherDestination = \"" + leecherDestination + "\">";
         	
     	   	
     	   	document.getElementById("match_panel").innerHTML += "<b>" + lname + " </b> will be travelling from <b>" + lseederSource + "</b> to <b>"+ lseederDestination + "</b> at <b>"  +  lstarttime +  "</b>. Mobile number is <b>" + lmobileno + "</b> and email id is <b>" + lseederEmail +"</b>.";
         		document.getElementById("match_panel").innerHTML +="<br></br>";
         		totalMatches = totalMatches+1;
         	}
         	
   		
   	  });

   
    	
    		}) (seederSource, seederDestination, seederEmail, distance, mobileno, starttime,total, name, distanceLeecher);

    count = count+1;
    if(count = (jsonObject.routeInfo).length -1 && totalMatches == 0)
    	{
    //	document.getElementById("match_panel").innerHTML = "<label> Sorry we didnt find any match for your route </label>";
    	}
 }
   
}

function showRoute()
{
	alert ("in show route");
	   var radio = document.getElementsByName('op1');
	    for(i=0;i<radio.length;i++)
	    {
	        if(radio[i].checked){
	        	alert(radio[i].data-seedeerSource);
	        	showRouteInternal(radio[i].data-seedeerSource);
	        }
	    }   
	    
	   return false;
	
	
	}

function showRouteInternal (source, destination, waypoint1, waypoint2 )
{
var waypts = [];

 waypts.push({
     location:waypoint1,
     stopover:true});
 waypts.push({
     location:waypoint2,
     stopover:true});


//******************I am setting optimizeWaypoints to false, so that the logic does not Treat a Leecher going from point A to B, the same as the one going from B to A  ******************

var request = {
 origin: source,
 destination: destination,
 waypoints: waypts,
 optimizeWaypoints: false,
 travelMode: google.maps.TravelMode.DRIVING
};

directionsService.route(request, function(response, status) {
if (status == google.maps.DirectionsStatus.OK) {
directionsDisplay.setDirections(response);
 

}
});
}

google.maps.event.addDomListener(window, 'load', initialize);

</script>

  </head>
  <body>
  <div id="page">
        <div class="topNaviagationLink"><a href="welcome.jsp">Home</a></div>
        <div class="topNaviagationLink"><a href="myspace.jsp" > My Space</a></div>
        <div class="topNaviagationLink"><a href="seeder.jsp">Provide A Ride</a></div>
        <div class="topNaviagationLink"><a href="leecher.jsp">Find A Ride</a></div>
        <div class="topNaviagationLink"><a href="feedback.jsp">Feedback</a></div>
	    <div class="topNaviagationLink"><a href="contactus.jsp">Contact Us</a></div>
        <div class="topNaviagationLink"><a href="logout.jsp">Log Out</a></div>
	</div>
  
     <div id="map-canvas" style="float:left;width:65%;height:100%;"></div>
    <div id="control_panel" style="float:right;width:33%;text-align:left;padding-top:10px"> 
    
    <form name="leecher">


     <label> Name : <%= userName %></label><br><br>
     <label> Email Id : <%= email %></label><br><br>
		<br><br><br><br>
		<label>	Number of Seats :</label> <select name="Seats" id="seats"><option selected>1</option>
					<option>2</option>
					<option>3</option>
					<option>4</option>
					<option>5</option>
	
			</select> 
			<br>
    <br>
    <br>
    <label>Start location:</label> <input type="text" name="StartLocation" size="40" id="StartLocation">
    <br>
    <label>End location: </label><input type="text" name="EndLocation" size="40" id="EndLocation">
      <p align="center">
           
      <input type="button" onclick="calcRoute();" value="Show Route">
      <br>
      </p>
    <label>  If the route shown in the map is correct, please provide your start date and time click Find Ride Providers</label> 
   <div class="form-group" >
                <label for="dtp_input1" class="col-md-2 control-label">Start Time</label>
                <div class="input-group date form_datetime1 col-md-5" data-date="2014-07-01T05:25:07Z" data-date-format="dd MM yyyy - HH:ii p" data-link-field="dtp_input1">
                    <input class="form-control" size="20" type="text" value="" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
					<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
                </div>
            </div>
            <input type="hidden" id="dtp_input1" name="startTime" value="" />
            <br>
            <br>
            
           <label>	Find in +/-  :</label> <select id="tolerance" name="timeTol"><option selected>1</option>
					<option>2</option>
					<option>3</option>
					<option>4</option>
					<option>5</option> 
	
			</select> <label>hours</label>
            <br>
        <p align="center">
    <input type="button" value="Find Ride Provider" onclick ="findProviders();" />
    </p>
    <input  id="Distance" type="hidden" value="0">
    
    </form>
    <div id="match_panel"></div>
    
   
   
    </div> 
     
<script type="text/javascript" src="jquery/jquery-1.8.3.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
<script type="text/javascript" src="js/locales/bootstrap-datetimepicker.fr.js" charset="UTF-8"></script>

<script type="text/javascript">
    $('.form_datetime1').datetimepicker({
      //  language:  'uk',
        weekStart: 1,
       todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0,
       showMeridian: 1
    });
    $('.form_datetime2').datetimepicker({
     //   language:  'uk',
        weekStart: 1,
        todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0,
        showMeridian: 1
    });
</script>
  
  </body>
</html>

