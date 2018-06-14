<!DOCTYPE html>
<html lang="en">
<head>
  <title>User Profile</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style>
    /* Set height of the grid so .sidenav can be 100% (adjust if needed) */
    .row.content {height: 1000px}
    
    /* Set gray background color and 100% height */
    .sidenav {
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
      .row.content {height: auto;} 
    }
  </style>
  <script src = "https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script>
  	

  	
  	function setDisplay(sth)
  	{
  		console.log(sth);
  		sessionStorage.setItem("displayUser", sth);
  		$(location).attr('href', 'Profile.jsp');
  	}
  	//load previous messages
  	
  	
  	
 
	var socket;
	function connectToServer() 
	{
		var displayUser = sessionStorage.getItem("displayUser");
		var currentUser = sessionStorage.getItem("currentUser");
		var userData = localStorage.getItem("userData");
		console.log(displayUser);
		
	  	displayUser = $.parseJSON(displayUser);
	  	//displayUser = $.parseJSON(displayUser);
	  	currentUser = $.parseJSON(currentUser);
	  	userData = $.parseJSON(userData);
	  	var username = displayUser.username;
	  	var fromUser =  currentUser.username;
	  	var imageURL = displayUser.imageURL;
	  	var friends = displayUser.friends;
	  	var cuisine = displayUser.cuisine; 
	  	var messages = displayUser.messages;
	  	console.log(userData);
	  	console.log(currentUser);
	  	console.log(displayUser);
	  	console.log(messages);
	  	
	  	var abc = JSON.stringify(currentUser);
	  	document.getElementById("url").innerHTML = "<a href = 'Profile.jsp'><img src='" + currentUser.imageURL + "' class='img-circle' height='50' width='50'></a>";
	  	document.getElementById("url").setAttribute("onclick", "sessionStorage.setItem('displayUser', '" + abc + "')");
		document.getElementById("pic").innerHTML = "<img src= '"+ displayUser.imageURL+ "' class='img-circle' height='150' width='150'>"
	  	document.getElementById("name").innerHTML = username;
	  	document.getElementById("phone").innerHTML = displayUser.phone;
	  	document.getElementById("email").innerHTML = displayUser.email;
		for (var i = 0; i< displayUser.interested.length; i++)
	  	{
	  		document.getElementById("interested").innerHTML += displayUser.interested[i]+" ";
	  	}
		
		 for (var i = 0; i< messages.length;i++)
	  	{
	  		var temp = messages[i].split('@');
	  		var msg = temp[0];
	  		var fromUser = temp[1];
	  		
	  		var imageURL = "";
	  		
	  		for (var j = 0; j< userData.users.length; j++)
	  		{
	  			if (userData.users[j].username == fromUser)
	  			{
	  				imageURL = userData.users[j].imageURL;
	  			}
	  		}
	  		document.getElementById("previous").innerHTML  += "<div class='col-sm-2 text-center'><img src= '"+ imageURL
	  		+ "' class='img-circle' height='65' width='65'></div>"+ "<div class='col-sm-10'><h4>"+ fromUser + "</h4><p>"
	  		+ msg + "</p><br></div>";
	  		document.getElementById("numOfMessages").innerHTML = messages.length;
	  		
	  	} 
	  	if (displayUser.username == currentUser.username)
	  	{
	  		document.getElementById("leave").style.display = "none";
	  		document.getElementById("message").style.display = "none";
	  		document.getElementById("submit").style.display = "none";
	  		document.getElementById("friendtag").innerHTML = "My Friends";
	  	}
	  	else
  		{
	  		document.getElementById("friendtag").innerHTML = displayUser.username+"'s Friends";
  		}
	  	for (var i = 0; i< displayUser.friends.length; i++)
	  	{
	  		var newDisplay;
	  		console.log(displayUser.friends);
	  		
			for (var j = 0; j< userData.users.length; j++)
	  		{
	  			if (userData.users[j].username == displayUser.friends[i])
	  			{
	  				newDisplay = userData.users[j];
	  				console.log(newDisplay);
	  			}
	  		}
			
			newDisplay = JSON.stringify(newDisplay);
			var node = document.createElement("LI");
		    var textnode = document.createTextNode(displayUser.friends[i]);
		    var link = document.createElement("a");
		    link.setAttribute("href","Profile.jsp");
		    link.innerHTML = displayUser.friends[i];
		    node.setAttribute("onclick", "sessionStorage.setItem('displayUser', '" + newDisplay + "')");
		    console.log(sessionStorage.displayUser);
		    node.className = "list-group-item";
		    
		    //textnode.appendChild(link);
		    //node.appendChild(textnode);
		    node.appendChild(link);
		    document.getElementById("friendlist").appendChild(node);
	  		/* document.getElementById("friendlist").innerHTML += "<li class='list-group-item' id = "+ newid+"><a href= 'Profile.jsp'>"+ displayUser.friends[i]+ "</a></li>";
	  		document.getElementById(newid).onclick = sessionStorage.setItem(displayUser,newDisplay); */
	  	}
	  	
	  	
	  	
		socket = new WebSocket("ws://localhost:8080/CSCI201L_FinalProject/ws");
		socket.onopen = function(event) {
			
		}
		socket.onmessage = function(event) {
			var json = $.parseJSON(event.data);
			var toUser = json.to;
			var fromUser = json.from;
			var newMsg = json.message;
			if (toUser == displayUser.username)
			{
				
		  		var imageURL = "";
		  		for (var j = 0; j< userData.users.length; j++)
		  		{
		  			if (userData.users[j].username == fromUser)
		  			{
		  				imageURL = userData.users[j].imageURL;
		  			}
		  		}
		  		
		  		document.getElementById("mychat").innerHTML  += "<div class='col-sm-2 text-center'><img src= '"+ imageURL
		  		+ "' class='img-circle' height='65' width='65'></div>"+ "<div class='col-sm-10'><h4>"+ fromUser + "</h4><p>"
		  		+ newMsg + "</p><br></div>";
		  		messages[messages.length] = newMsg+"@"+fromUser;
		  		displayUser.messages = messages;
		  		for (var k = 0; k< userData.users.length; k++)
		  		{
		  			if (displayUser.username == userData.users[k].username)
		  			{
		  				userData.users[k] = displayUser;
		  			}
		  		}
		  		var temp1 = JSON.stringify(displayUser);
		  		sessionStorage.removeItem("displayUser");
		  		localStorage.removeItem("userData");
		  		sessionStorage.setItem("displayUser", temp1);
		  		if (displayUser.username == currentUser.username)
		  		{
		  			sessionStorage.removeItem("currentUser");
		  			sessionStorage.setItem("currentUser", temp1);
		  		}

		  		console.log(sessionStorage.getItem("displayUser"));
		  		console.log(sessionStorage.getItem("currentUser"));
		  		console.log(userData);
		  		var temp2 = JSON.stringify(userData);
		  		localStorage.setItem("userData", temp2);
		  		console.log(temp2);
		  		console.log(localStorage.getItem("userData"));
		  		
				document.getElementById("numOfMessages").innerHTML = messages.length;
				
				if (displayUser.username == currentUser.username)
				{
					alert("You got a new message!");
				}
				else if(fromUser != currentUser.username)
				{
					alert(displayUser.username+" got a new message!");
				}
			}
			//"<div class='col-sm-2 text-center'><img src='bandmember.jpg' class='img-circle' height='65' width='65'></div>"+
	        //"<div class='col-sm-10'><h4>Anja</h4><p>Keep up the GREAT work! I am cheering for you!! Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p><br></div>";
			
		}
		socket.onclose = function(event) {
			document.getElementById("mychat").innerHTML += "Disconneted";
		}
	}
	function sendMessage() {
		var displayUser = sessionStorage.getItem("displayUser");
		var currentUser = sessionStorage.getItem("currentUser");
		var userData = localStorage.getItem("userData");
		
	  	displayUser = $.parseJSON(displayUser);
	  	currentUser = $.parseJSON(currentUser);
	  	userData = $.parseJSON(userData);
		var message = document.getElementById("message").value;
		var myobject = {
				to: displayUser.username,
				from: currentUser.username,
				message: message	
		};
		myobject = JSON.stringify(myobject);
		console.log(myobject);
		socket.send(myobject);
		return false;
	}
		</script>
</head>
<body onload="connectToServer()">
<nav class="navbar navbar-inverse" style="margin-bottom: 0px">
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
        <li><a href="#">Never</a></li>
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
  
<div class="container-fluid">
  <div class="row content">
    <div class="col-sm-3 sidenav">
      <h4 style = "font-size: 40px; text-align: center">Menu</h4><br><br>
      <ul class="nav nav-pills nav-stacked">
         <div class="panel panel-default">
      <div class="panel-heading">
        <h4 class="panel-title">
          <a  href="Premium_Homepage.jsp">Home Page</a>
        </h4>
      </div>
      </div>
       <!--  <li><a href="#section2">See My Friends</a></li> -->

        <div class="panel-group">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h4 class="panel-title">
          <a data-toggle="collapse" href="#collapse1" id = "friendtag"></a>
        </h4>
      </div>
      <div id="collapse1" class="panel-collapse collapse">
        <ul class="list-group" id = "friendlist">
        	

        </ul>

      </div>
    </div>
  </div>
        
      </ul><br>
      <div class="input-group">
        <input type="text" class="form-control" placeholder="Search Blog..">
        <span class="input-group-btn">
          <button class="btn btn-default" type="button">
            <span class="glyphicon glyphicon-search"></span>
          </button>
        </span>
      </div>
    </div>

    <div class="col-sm-9" style = "display: padding-left: 50px">
    	<h2>User Profile</h2>
    	<div class = "col-sm-15">
	 		<span clsss = "col-sm-1 " id = "pic"></span>
	 		<div class = "col-sm-8 " style = "float: right">
		    	<h4>Name: <span id =  "name" ></span><br></h4>
		    	<h4>Phone: <span id = "phone"></span><br></h4>
		    	<h4>Email: <span id = "email"></span><br></h4>
		    	<h4>Interested cuisine: <span id = "interested"></span></h4><br><br>
	    	</div>
    	</div>
    	
    	
    	

      
      <form name="chatform" role="form" onsubmit= "return sendMessage()">
      	<h4 id = "leave" style="float: left">Leave a Message:</h4>
        <div class="form-group">
        	
          <textarea id = "message" class="form-control" rows="3" required></textarea>
        </div>
        <button type="submit" class="btn btn-success" id = "submit">Submit</button>
      </form>
      <br><br>

      
      <p><span class="badge" id = "numOfMessages">0</span> Messages</p><br>
      
      <div class="row">
      	<div id= "previous"></div>
      	<div id = "mychat"></div>
      
      </div>
    </div>
  </div>
</div>

<footer class="container-fluid">
  <p style="text-align: center">KawaEats@Inc.</p>
</footer>

</body>
</html>