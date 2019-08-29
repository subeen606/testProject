<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css?family=DM+Serif+Text|Roboto+Condensed&display=swap" rel="stylesheet">
<style type="text/css">

body{

	width: 100%;
	height: 100%;
	margin: 0px;
	font-family: 'Roboto Condensed', sans-serif;
	
	/* font-family:'Lobster', cursive; */
}

.header{
	width: 100%;
	height: 15%;
	top:0;
	left:0;
	position: absolute;
	background-color: black;
	text-align: center;
	max-height: 150px;
	
}
.header img{
	margin-top: 1.5%;
}
.body{
	width: 100%;
	height: 70%;
}

.footer{
	width: 100%;
	height: 15%;
	bottom:0;
	left:0;
	position: absolute;
	background-color: black;
	box-sizing: border-box;
	max-height: 150px;
    text-align: center;
    overflow: hidden;
    z-index: -1000;
}
.footer a{
	margin-right: 15px;
	margin-left: 15px;
}
.footer img{
	margin-top: 2.5%;
	opacity: 0.5;
}
.footer img:hover{
	opacity: 1;
}

#videobcg{
	position: fixed;
	top: 0px;
	left: 0px;	
	min-width: 100%;
	min-height: 100%;
	width: auto;
	height:	auto;
	z-index: -1000;
	overflow: hidden;
}
</style>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>
<!-- header -->
<div class="header">
	<a href="/TAMINO/AdminCtrl?command=Main_Page"><img alt="" src="/TAMINO/image/logo.png"></a>
</div>
<!-- body -->
<div class="body">
	<video id="videobcg" preload="auto" autoplay="true" muted="muted" loop="loop" volume="15">
	<source src="/TAMINO/image/TAMINO.mp4" type="video/mp4">
</div>

<!-- footer -->
<div class="footer">
		<a style="margin-left: 15px; margin-right: 15px;" href="http://instagram.com/TAMINOamir" target="_blank"><img src="/TAMINO/image/instagrammain.png"  class="iconBox" style="width: 40px; height: 35px;"></a>
		<a style="margin-left: 0px; margin-right: 15px; " href="https://www.facebook.com/taminoamir/?ref=br_rs" target="_blank"><img src="/TAMINO/image/facebookmain.png"  class="iconBox" style="width: 40px; height: 35px;"></a>
		<a style="margin-left: 0px; margin-right: 15px; " href="https://twitter.com/taminoamir" target="_blank"><img src="/TAMINO/image/twittermain.png"  class="iconBox" style="width: 40px; height: 35px;"></a>
		<a style="margin-left: 0px; margin-right: 15px; " href="https://www.youtube.com/channel/UCzoO5qFoT-7w7o7f1QqhOpA" target="_blank"><img src="/TAMINO/image/youtubemain.png"  class="iconBox" style="width: 40px; height: 35px;"></a>
</div>
<script type="text/javascript">
$(document).ready(function() {
	$("body").keydown(function(key) {
		if(key.keyCode == 13){
			location.href = "/TAMINO/AdminCtrl?command=Main_Page"
		}
	});
});
</script> 
</body>
</html>