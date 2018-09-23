<!DOCTYPE html>
<html lang="en">
<head>
  <title>Login</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style>
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
    #display{

     width: 30%;
     margin: auto;
     padding: 30px;
     text-align: center;
    }
  </style>
  <script>
   var userData = JSON.parse(localStorage.userData);
 console.log(userData);
 function validate(){
  if(document.signup.username.value.trim().length != 0 && document.signup.password.value.trim().length != 0){
   document.getElementById("usernameerror").innerHTML = "";
   for(var i=0;i< userData.users.length; i++){
    if(userData.users[i].username == document.signup.username.value){
     if(userData.users[i].password == document.signup.password.value){
      sessionStorage.setItem("currentUser", JSON.stringify(userData.users[i]));
      return true;
     }
     else{
      document.getElementById("passworderror").innerHTML = "<font color='red'><strong>Wrong password. </strong></font>";
      return false;
     }
    }
   }
   document.getElementById("usernameerror").innerHTML = "<font color='red'><strong>Wrong username. </strong></font>";
   return false;
  }
  else{
   if(document.signup.username.value.trim().length == 0){
    document.getElementById("usernameerror").innerHTML = "<font color='red'><strong>Please enter something. </strong></font>"; 
   }
   else{
    document.getElementById("usernameerror").innerHTML = "";
   }
   if(document.signup.password.value.trim().length == 0){
    document.getElementById("passworderror").innerHTML = "<font color='red'><strong>Please enter something. </strong></font>"; 
   }
   else{
    document.getElementById("passworderror").innerHTML = "";
   }
   return false;
  }
 }
  </script>
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
      <a class="navbar-brand" href=" "></a >
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class="active"><a href="#">Never</a ></li>
        <li><a href="#">Hungry</a ></li>
        <li><a href="#">Never</a ></li>
        <li><a href="#">Lonely</a ></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="signup.html"><span class="glyphicon glyphicon-log-in"></span>  Sign up</a ></li>
      </ul>
    </div>
  </div>
</nav>
  
<div class="container-fluid text-center">    
  <div class="row content">
    <div class="col-sm-12 text-left"> 
      <hr>
     <form name="signup" method="POST" action="Premium_Homepage.jsp" onsubmit="return validate()">
      <div id = "display">
   <h2>Username</h2>
   <input id="username" type="text" name="username" placeholder="Username"><br/>
   <div id="usernameerror"></div>
   <h2>Password</h2>
   <input id="password" type="password" name="password" placeholder="Password"><br/>
   <div id="passworderror"></div>
         <div class="clear"></div>
         <br/>
         <button type="reset" class="btn btn-info" value="Reset">Reset</button>
         <input type="submit" class="btn btn-success" value="Login">
      </div>
      </form>
    </div>
  </div>
</div>

<footer class="container-fluid text-center">
  <p>KawaEats@Inc.</p >
</footer>

</body>
</html>