

<!DOCTYPE html>
<%@ page import="dbaccess.*,java.util.*,com.ibm.json.java.*, java.io.PrintWriter;"%>
<html>
  <head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>Waypoints in directions</title>
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


function initialize() {
directionsDisplay = new google.maps.DirectionsRenderer();
var nagpur = new google.maps.LatLng(21.1457854, 79.0881336); 
var mapOptions = {
zoom: 6,
center: nagpur
}
map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
directionsDisplay.setMap(map);
}


google.maps.event.addDomListener(window, 'load', initialize);

    </script>
  </head>
  <body>
    <p id="tp1"> Seeder Distance :  </p>
    <p id="tp2"> Total Distance :  </p>
    <div id="map-canvas" style="float:left;width:70%;height:100%;"></div>
    <div id="control_panel" style="float:right;width:30%;text-align:left;padding-top:20px">
    <div style="margin:20px;border-width:2px;">
    <br>
    <br>
    <br>
    <br>
     <div id="status">
    </div> 
    </div>
    <div id="directions_panel" style="margin:20px;background-color:#FFEE77;"></div>
    </div>
  </body>
</html>

