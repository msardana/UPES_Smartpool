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
     
    <title>Seeder Page</title>
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
  //    var summaryPanel = document.getElementById('directions_panel');
  //    summaryPanel.innerHTML = '';
      // For each route, display summary information.
      for (var i = 0; i < route.legs.length; i++) {
      //  var routeSegment = i + 1;
//        summaryPanel.innerHTML += '<b>Route : ' + '</b><br>';
	
  //      summaryPanel.innerHTML += route.legs[i].start_address + ' to ';
	document.getElementById('StartLocation').value = route.legs[i].start_address;
//        summaryPanel.innerHTML += route.legs[i].end_address + '<br>';
	document.getElementById('EndLocation').value = route.legs[i].end_address;
//        summaryPanel.innerHTML += route.legs[i].distance.text + '<br><br>';
	document.getElementById('Distance').value = route.legs[i].distance.value/1000;
      }
    }
  });
}

function validateForm() {
        
    var x = document.forms["seeder"]["VehicleNumber"].value;
    if (x == null || x == "") {
        alert("Vehicle Number field must be filled out");
        return false;
    }
    
    var x = document.forms["seeder"]["StartLocation"].value;
    if (x == null || x == "") {
        alert("Start Location field must be filled out");
        return false;
    }

    var x = document.forms["seeder"]["EndLocation"].value;
    if (x == null || x == "") {
        alert("End Location field must be filled out");
        return false;
    }

    var x = document.forms["seeder"]["dtp_input1"].value;
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

    <form  name="seeder"  action="addParticipant.jsp"  onsubmit="return validateForm()"  method="get">

     <label> Name : <%= userName %> </label> <br><br>
     <label>Email Id : <%= email %> </label> <br><br>
		 <br>
			<label> Number of Seats :</label> <select name="Seats"><option selected>1</option>
					<option>2</option>
					<option>3</option>
					<option>4</option>
					<option>5</option>
			</select> 
   <br>
   <label> Vehicle Number: </label> <input type="text" name="VehicleNumber" size="40" id="VehicleNumber">
    <br>
    <br>
    <label>Start location:</label>  <input type="text" name="StartLocation" size="40" id="StartLocation"/>
    <br>
    <label>End location:</label> <input type="text" name="EndLocation" size="40" id="EndLocation"/>
    <p align="center">
      <input type="button" onclick="calcRoute();" value="Show Route">
      </p>
      <br>    
     <label> If the route shown in the map is correct, please provide your start date, time and frequency and click Add Request</label>
      <br>
   <div class="form-group">
                <label for="dtp_input1" class="col-md-2 control-label">Start Time</label>
                <div class="input-group date form_datetime1 col-md-5" data-date="2014-07-01T05:25:07Z" data-date-format="dd MM yyyy - HH:ii p" data-link-field="dtp_input1">
                    <input class="form-control" size="40" type="text" value="" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
					<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
                </div>
            </div>
            <input type="hidden" id="dtp_input1" name="startTime" value="" />
            <br>
            <p align="center">
             <label> add request for the next  :</label> <select id="weeks" name="weeks"><option selected>1</option>
					<option>2</option>
					<option>3</option>
					<option>4</option>
			</select> <label> weeks on the following days </label>
    <input type="hidden"  size="8" id="Distance" type="hidden" name="Distance" value="0">
    <br>
    <input type="checkbox" name="sunday" value="1" id="sunday"> Sun 
    <input type="checkbox" name="monday" value="2" id = "monday"> Mon 
    <input type="checkbox" name="tuesday" value="3" id = "tuesday"> Tue
    <input type="checkbox" name="wednesday" value="4" id = "wednesday"> Wed 
    <input type="checkbox" name="thursday" value="5" id = "thursday"> Thu 
    <input type="checkbox" name="friday" value="6" id = "friday"> Fri
    <input type="checkbox" name="saturday" value="7" id = "saturday"> Sat 
    <p align="center"> <br>
    <input type="submit" value="Add Request">
    </p>
    </form>
    
    </div>
    <div id="directions_panel" style="margin:40px;background-color:#FFEE77;"></div>
    
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

