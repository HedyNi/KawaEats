<!DOCTYPE html>
<html lang="en">
<head>
  <title>Homepage</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style>
  #map{
      height:500px;
      width: 100%;
      border: 1px solid black;
      border-radius: 25px;
    }
    /* Remove the navbar's default margin-bottom and rounded borders */ 
    .navbar {
      margin-bottom: 0;
      border-radius: 0;
    }
    /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
    .row.content {height: 700px}
    
    /* Set gray background color and 100% height */
    .sidenav {
      padding-top: 20px;
      background-color: #f1f1f1;
      height: 100%;
    }
    
    /* Set black background color, white text and some padding */
    footer {
      background-color: #555;
      color: white;
      padding: 15px;
    }
    
    /* On small screens, set height to 'auto' for sidenav and grid */
    @media screen and (max-width: 767px) {
      .sidenav {
        height: auto;
        padding: 15px;
      }
      .row.content {height:auto;} 
    }
    #searchText{
    	width: 100%;
    }
    .clear{
    	clear: both;
    }
    #searchButton{
    	float: left;
    	margin-left: 300px;
    }
    #logo img{
    	/* //margin-left: 00px; */
    	width: 10%;
    	height: 10%;
    }
    </style>
    <script>
    $.ajax({
        type : 'GET',
        dataType : 'json',
        url: 'userDataFile.json',
        success : function(data) {
            console.log(data); 
            localStorage.setItem("userData", JSON.stringify(data)); 
        } 
    });
    $.ajax({
        type : 'GET',
        dataType : 'json',
        url: 'partyDataFile.json',
        success : function(data) {
            console.log(data); 
            localStorage.setItem("partyData", JSON.stringify(data)); 
        } 
    });
    
    function initMap(){
      /* // Map options */
      var options = {
        zoom:16,
        center:{lat:34.019930,lng:-118.2851}
      }

      // New map
      var map = new google.maps.Map(document.getElementById('map'), options);

      // Listen for click on map
      google.maps.event.addListener(map, 'click', function(event){
        // Add marker
        addMarker({coords:event.latLng});
      });

      // Array of markers
      var markers = [
        {
          coords:{lat:36.12345,lng:-118.2852},
          iconImage:'https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png',
          content:'<h3>USC Village</h3>'
        },
        {
          coords:{lat:42.8584,lng:-70.9300},
          content:'<h1>Amesbury MA</h1>'
        },
        {
          coords:{lat:42.7762,lng:-71.0773}
        }
      ];

      // Loop through markers
      for(var i = 0;i < markers.length;i++){
        // Add marker
        addMarker(markers[i]);
      }

      // Add Marker Function
      function addMarker(props){
        var marker = new google.maps.Marker({
          position:props.coords,
          map:map,
          //icon:props.iconImage
        });

        // Check for customicon
        if(props.iconImage){
          // Set icon image
          marker.setIcon(props.iconImage);
        }

        // Check content
        if(props.content){
          var infoWindow = new google.maps.InfoWindow({
            content:props.content
          });

          marker.addListener('click', function(){
            infoWindow.open(map, marker);
          });
        }
      }
    }
    
    function changeMap(){
    	
    	$.ajax({
            url: 'RestaurantQuery',
            data : {
    			searchType : $('#searchType').val(),
    			searchText : $('#searchText').val()
    		},
    		success: function(responseText)
    		{
    			var restArrayList = responseText;
    			if(restArrayList != ""){
    				console.log(restArrayList);
        			var restObject = jQuery.parseJSON(restArrayList);
        			
        			console.log(restArrayList);
        			
        			console.log(restObject);
        			var newMarkers = [];
        			for(var i=0;i<restObject.length;i++){
        				var k = new Object();
        				var coords = {};
        				coords.lat = restObject[i].lat;
        				coords.lng = restObject[i].lng;
        				k.coords = coords;
        				k.iconImage = 'https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png';
        				k.content = '<h3>' + restObject[i].name + '</h3>';
        				k.content += '<h4>' + restObject[i].address + '</h4><br/>';
        				k.content += "<h5 style='color: red'>Please login for detailed information. </h5>";
        				newMarkers.push(k);
        			}
        			console.log(newMarkers);
        			var options = {
     			        zoom:16,
     			        center:{lat:34.019930,lng:-118.2851}
     			      }

     			      // New map
     			      var map = new google.maps.Map(document.getElementById('map'), options);

     			      // Listen for click on map
     			      google.maps.event.addListener(map, 'click', function(event){
     			        // Add marker
     			        addMarker({coords:event.latLng});
     			      });
     			     for(var i = 0;i < newMarkers.length;i++){
     			        // Add marker
     			        addMarker(newMarkers[i]);
     			    }
     			    function addMarker(props){
    			        var marker = new google.maps.Marker({
    			          position:props.coords,
    			          map:map,
    			          //icon:props.iconImage
    			        });

    			        // Check for customicon
    			        if(props.iconImage){
    			          // Set icon image
    			          marker.setIcon(props.iconImage);
    			        }
    			        // Check content
    			        if(props.content){
    			          var infoWindow = new google.maps.InfoWindow({
    			            content:props.content
    			          });

    			          marker.addListener('click', function(){
    			            infoWindow.open(map, marker);
    			          });
    			        }
    			      }
    			}	
    			
    		}
        });
    }
    
    </script>
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAueX_jMo03h0ry6L9iuqkCHkbLacCKe38&callback=initMap"></script>
</head>
<body>

<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="#"></a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class="active"><a href="#">Never</a></li>
        <li><a href="#">Hungry</a></li>
        <li><a href="#">Never</a></li>
        <li><a href="#">Lonely</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="Login.jsp"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
        <li><a href="signup.html"><span class="glyphicon glyphicon-log-in"></span> Sign up</a></li>
      </ul>
    </div>
  </div>
</nav>
  
<div class="container-fluid text-center">    
  <div class="row content">
  <div id="logo"><img src="WudiLogo.png"></div>
  	<div class="col-sm-2">
  	</div>
    <div class="col-sm-8 text-left"> 
      <br/>
      	<div class="col-sm-5 text-left"> 
      		<input id="searchText" name="searchText" type="text" placeholder="Peform a search"><br/>
      	</div> 
      	<div class="col-sm-1 text-left">
      		<select name="searchType" id="searchType" style="height: 30px">
			  <option value="Name">Name</option>
			  <option value="Type">Type</option>
			  <option value="Address">Address</option>
			  <option value="Nearby">Nearby restaurants</option>
			</select>
      	</div>
      	<div class="col-sm-2 text-left" id="searchButton">
	      	 <button class="btn btn-success" onclick="return validate()">Search</button>
		</div>
		<div class="clear"></div>
		<div id="contexterror"></div>
		<br/>
      <hr>
      <div id="map"></div>
    </div>
  </div>
</div>
<script>
	function validate(){
		if(document.getElementById("searchText").value.trim().length == 0){
			document.getElementById("contexterror").innerHTML = "Please enter something. ";
		}
		else{
			document.getElementById("contexterror").innerHTML = "";
			changeMap();
		}
	}
</script>
<footer class="container-fluid text-center">
  <p>KawaEats@Inc.</p>
</footer>
</body>
</html>