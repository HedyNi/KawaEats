<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
* {
    box-sizing: border-box;
}


body {
    margin: 0;
    font-family: 'Acme';
    font-size: 25px;
}

#myVideo {
    position: fixed;
    right: 0;
    bottom: 0;
    min-width: 100%; 
    min-height: 100%;
}

.content {
    position: fixed;
    bottom: 150px;
    background: rgba(0, 0, 0, 0.5);
    color: #f1f1f1;
    width: 100%;
    padding: 20px;
}

#myBtn {
    width: 150px;
    font-size: 18px;
    padding: 5px;
    border: none;
    background: #000;
    color: #fff;
    cursor: pointer;
}

#myBtn:hover {
    background: #ddd;
    color: black;
}
</style>
<link href='https://fonts.googleapis.com/css?family=Acme' rel='stylesheet'>
</head>
<body>

<video autoplay muted loop id="myVideo">
  <source src="Coffee-Jet.mp4" type="video/mp4">
  Your browser does not support HTML5 video.
</video>

<div class="content">
	
  <!-- <span><h1 font-family = "Acme" style= "padding-left: 500px">KawaEats</h1></span> -->
  <div><img  src = "1.png" onClick = myFunction() style =" width: 350px; height:350px; margin-left: 750px; border-radius:50% "></div>
  <!-- <p style= "padding-left: 700px">Never Lonely Never Hungry</p> -->
  <!-- <button id="myBtn" onclick="myFunction()">Explore</button> -->
</div>

<script>
var video = document.getElementById("myVideo");
var btn = document.getElementById("myBtn");

function myFunction() {
	window.location.href = "Homepage.jsp";
}
</script>

</body>
</html>
