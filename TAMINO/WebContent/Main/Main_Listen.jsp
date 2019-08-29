<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main_Listen.jsp</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=DM+Serif+Text|Roboto+Condensed&display=swap" rel="stylesheet">
<style type="text/css">
body{

	width: 100%;
	height: 100%;
	margin: 0px;
	font-family: 'Roboto Condensed', sans-serif;
}

.backgroundImg{
	top:0;
	left:0;
	width: 100%;
	height: 100%;
	position:fixed;
	z-index: -1000;
	opacity: 0.8;
}

button {
	border-radius: 10px;
	border: 2px solid black;
	background: white;
}
h3{
	margin-top: 11px;
}
</style>
</head>
<body>
<div class="backgroundImg">
	<img alt="" src="/TAMINO/image/Tamino_Main.png" style="width: 100%; height: 100%;">
</div>
<!-- listen -->
<div style="width:20%; height: 100%; position: absolute; left: 40%;">
	<div style="width: 100%; height: 30%; border: 1px solid black">
		<img alt="" src="/TAMINO/image/Tamino_LikeAt.jpg" style="width: 100%; height: 100%;">
	</div>
	
	<div style="width: 100%; height: 13%; background-color: black; color:white; padding-top: 2%;" align="center" >
		<h2>Live at Ancienne Belgique</h2>
		<h3>Available Now</h3>
	</div>
	
	<div class="listenDiv" style="width: 100%; height: 11%; background-color: white; border-bottom: 1px solid rgba(0,0,0,0.2);" align="center" onclick="window.open('https://youtu.be/aeaBJfzTKl8')">
		<img alt="" src="/TAMINO/image/Youtube_.png" style="width: 30%; height: 100%; float: left; margin-left: 3%;">
		<button type="button" style="float: right; width: 75px; height: 50px; margin-top: 8%; margin-right: 5%;"><h3>듣기</h3></button>
	</div>
	<div class="listenDiv" style="width: 100%; height: 11%; background-color: white; border-bottom: 1px solid rgba(0,0,0,0.2);" align="center" onclick="window.open('http://www.mnet.com/album/3270077')">
		<img alt="" src="/TAMINO/image/Mnet.png" style="width: 50%; height: 100%; float: left;">	
		<button type="button" style="float: right; width: 75px; height: 50px; margin-top: 8%; margin-right: 5%; padding-bottom: 2%;" ><h3>듣기</h3></button>
	</div>
	<div  class="listenDiv" style="width: 100%; height: 11%; background-color: white; border-bottom: 1px solid rgba(0,0,0,0.2);" align="center" onclick="window.open('https://www.melon.com/webplayer/mini.htm?contsIds=31819934&contsType=S')">
		<img alt="" src="/TAMINO/image/Melon_logo.png" style="width: 30%; height: 100%; float: left">
		<button type="button" style="float: right; width: 75px; height: 50px; margin-top: 8%; margin-right: 5%;" ><h3>듣기</h3></button>
	</div>																																					
	<div class="listenDiv" style="width: 100%; height: 11%; background-color: white; border-bottom: 1px solid rgba(0,0,0,0.2);" align="center" 	onclick="window.open('https://www.genie.co.kr/detail/albumInfo?axnm=81207066#')">
		<img alt="" src="/TAMINO/image/Genie_logo.png" style="width: 30%; height: 80%; margin-left:3%; margin-top:2%; float: left">
		<button type="button" style="float: right; width: 75px; height: 50px; margin-top: 8%; margin-right: 5%;"><h3>듣기</h3></button>
	</div>
	
	<!-- Exit Btn -->
	<div id="_Back" style="width: 100%; height: 11%;  background-color: white; line-height: 400%; font-size: 30px" align="center" onclick="javascript:history.back()">
		<b>BACK</b>
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	$(".listenDiv").mouseover(function() {
		$(this).css({
			'background':'#eaeaea',
			'cursor':'pointer'
			});
		$(this).children("button").css("background","black");
		$(this).children("button").css("color","white");
	});
	$(".listenDiv").mouseout(function(){
		$(this).css("background","white");
		$(this).children("button").css("background","white");
		$(this).children("button").css("color","black");
	});
	
	$("#_Back").mouseover(function() {
		$(this).css({
			'background':'black',
			'cursor':'pointer',
			'color' : 'white'
			});
	});
	
	$("#_Back").mouseout(function() {
		$(this).css({
			'background':'white',
			'color' : 'black'
			});		
	});
});
</script>
</body>
</html>