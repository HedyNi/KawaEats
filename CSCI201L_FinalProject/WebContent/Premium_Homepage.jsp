<!DOCTYPE html>
<html lang="en">
<head>
  <title>Premium_Homepage</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
   <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="simple-sidebar.css" rel="stylesheet">
  <style>
  .rbtn
  {
  	margin-left: 70px'
  }
  #map{
      height:500px;
      width: 100%;
      border:1px solid black;
      border-radius:25px;
    }
    /* Remove the navbar's default margin-bottom and rounded borders */ 
    .navbar {
      margin-bottom: 0;
      border-radius: 0;
    }
    
    /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
    .row.content {height: 450px}
    
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
    #restaurantInfo{
    	overflow-y:scroll;
    }
    #url img{
    	height: 50px;
    	width: 50px;
    	border-radius: 50%;
    }
    #logo img{
    	width: 15%;
    	height: 15%;
    }
   
    </style>
    <script>
    var userData = JSON.parse(localStorage.userData);
	console.log(userData);
	
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
        			document.getElementById("restaurantInfo").innerHTML = "<li class='sidebar-brand'><a href='#'><h2 font-color: white style = 'margin-left: 30px'>Restaurant<h2></a></li>";
        			for(var i=0;i<restObject.length;i++){
        				var k = new Object();
        				var coords = {};
        				coords.lat = restObject[i].lat;
        				coords.lng = restObject[i].lng;
        				k.coords = coords;
        				k.iconImage = 'https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png';
        				k.content = '<h3>' + restObject[i].name + '</h3><br/>';
        				k.content += '<h4>' + restObject[i].address + '</h4><br/>';
        				k.content += '<h5>' + restObject[i].description + '</h5>';
        				
        				document.getElementById("restaurantInfo").innerHTML += "<li><h3>" + restObject[i].name + "</h3>";
        				document.getElementById("restaurantInfo").innerHTML += "<h4>" + restObject[i].address + "</h4>";
        				document.getElementById("restaurantInfo").innerHTML += "<h5>" + restObject[i].description + "</h5><br/>";
        				document.getElementById("restaurantInfo").innerHTML += "<a href='viewCurParty.html?currentRestaurant=" + restObject[i].name + "'><button style = 'margin-left:70px' class = 'btn btn-success'>View</button></a>";
        				document.getElementById("restaurantInfo").innerHTML += "<a href='CreateParty.html?currentRestaurant=" + restObject[i].name + "'><button style = 'margin-left:70px' class = 'btn btn-success'>Create</button></a><br/><br>";
        				//document.getElementById("restaurantInfo").innerHTML += "-------------------------------------";
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
        <li><a href="#">Lonely</a></li>
        <li><a href="#">Never</a></li>
        <li><a href="#">Hungry</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><div id="url"></div></li>
      </ul>
    </div>
  </div>
</nav>


<div class = "container-fluid text -center">
	<div id = "wrapper">
		<div id="sidebar-wrapper">
			<ul class="sidebar-nav">
	            <div id = "restaurantInfo"></div>        
	        </ul>
		</div>
		<div id = "page-content-wrapper">
			<div class="container-fluid">
				<div class="col-sm-2"></div>
			    <div class="col-sm-8 text-left"> 
			      <br/>
			      	<span id="logo"><img src="WudiLogo.png"></span>
			      	<div class="col-sm-7 text-left" style="margin-top: 35px;"> 
			      		<input id="searchText" name="searchText" type="text" placeholder="Peform a search. "><br/>
			      		<br>
			      		<a href="#menu-toggle" class="btn btn-info" id="menu-toggle">Show Restaurants</a>
			      	</div> 
			      	<div class="col-sm-3 text-left" style="margin-top: 35px;">
			      		<select name="searchType" id="searchType" style="height: 30px">
						  <option value="Name">Name</option>
						  <option value="Type">Type</option>
						  <option value="Address">Address</option>
						  <option value="Nearby">Nearby restaurants</option>
						</select><br />
						<br>
						
						<button id = "searchbutton" onclick = "return changeMap()" class="btn btn-success">Search</button>
			      	</div>
			   
				      
					
					<br>
					
					<div class="clear"></div>
					<div id="contexterror"></div>
					<br/>
			      <hr>
			      <div id="map"></div>
			    </div>
				
			</div>
		</div>
		
	</div>
	
	

</div>



<!-- <div class="container-fluid text-center">
<div id = "wrapper">
 
  <div class="row content">
  <div id="page-content-wrapper">   
    <div class="col-sm-8 text-left"> 
      <h1>This is the homepage.</h1>
      <form name="search" method="get" onSubmit="return validate()">
      <div id="contexterror"></div>
      
      	<div class="col-sm-5 text-left"> 
      		<input id="searchText" name="searchText" type="text" placeholder="Peform a search. "><br/>
      	</div> 
      	<div class="col-sm-2 text-left"></div>
      	<div class="col-sm-1 text-right">
	      	<select name="searchType" id="searchType">
			  <option value="Name">Name</option>
			  <option value="Type">Type</option>
			  <option value="Address">Address</option>
			  <option value="Nearby">Nearby restaurants</option>
			</select>
		</div>
		<div class="clear"></div>
		<br/>
      	<input name="submit" type="submit" value="Go!">
      </form>
      <hr>
      <h3>Google Map should go here.</h3>
      <a href="#menu-toggle" class="btn btn-secondary" id="menu-toggle">Toggle Menu</a>
      <button onclick="return changeMap()">Let's change the map.</button>
      <div id="lat"></div>
      <div id="map"></div>
    </div>
     Restaurant information starts here!
     
	     <div id="sidebar-wrapper">
	            <ul class="sidebar-nav">
	            	<div id = "restaurantInfo"></div>           
	            </ul>
	        </div>
	    
    </div>
    <div id="sidebar-wrapper">
	            <ul class="sidebar-nav">
	            	<div id = "restaurantInfo"></div>
	               
	                
	            </ul>
	        </div>
  </div>
   
</div>
</div> -->

<script>


	function validate()
	{
		  if(document.getElementById("searchText").value.trim().length == 0)
		  {
		   document.getElementById("contexterror").innerHTML = "Please enter something. ";
		  }
		  else
		  {
		   document.getElementById("contexterror").innerHTML = "";
		   changeMap();
		  }
	}

		/* if(document.search.searchText.value == ""){
			document.getElementById("contexterror").innerHTML = "Please enter something. ";
			return false;
		}
		else{
			document.getElementById("contexterror").innerHTML = "";
			return true;
		}
	}*/
	function display(){
		sessionStorage.setItem("displayUser", sessionStorage.currentUser);
	}
	var user = JSON.parse(sessionStorage.currentUser);
	var url = user.imageURL;
	document.getElementById("url").innerHTML += "<a href='Profile.jsp' onclick='return display()'><img src=" + url + "></a>";
	/* var temp = document.getElementById("url");
	temp.href = "Profile.jsp"; */
	sessionStorage.setItem("displayUser",sessionStorage.getItem("currentUser"));
</script>
 <!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Menu Toggle Script -->
    <script>
    $("#menu-toggle").click(function(e) {
        e.preventDefault();
        $("#wrapper").toggleClass("toggled");
    });
    </script>
<footer class="container-fluid text-center">
  <p>KawaEats@Inc.</p>
</footer>
</body>
</html>