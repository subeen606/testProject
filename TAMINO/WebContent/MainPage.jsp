<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
body{
	width: 100%;
	height: 100%;
	margin: 0px;
	
}
#mainBackground{
	position: fixed;
	top: 0px;
	left: 0px;	
	min-width: 100%;
	min-height: 100%;
	width: auto;
	height:	auto;
	z-index: -1000;
	overflow: hidden;
	-webkit-animation:fade-in-fwd 0.6s 0s 1 ease-in forwards;
	animation:fade-in-fwd 0.6s 0s 1 ease-in forwards;
}
.navidiv{
	width: 100%;
	height: 7%;
	position: fixed;
	padding: 0px;
	background-color: rgba(0, 0, 0, 0.3);
	font-family: "Times New Roman";
	-webkit-animation:fade-in-fwd 0.6s 0s 1 ease-in forwards;
	animation:fade-in-fwd 0.6s 0s 1 ease-in forwards;
}
.navidiv .homediv{
	width: 20%;
	height: 100%;
	padding: 0% 10% 0% 0%;
	text-align: center;
	color: white;
	float: left;
	line-height: 400%;
}
.navidiv .menubar{
	width: 10%;
	height: 100%;
	padding: 0px;
	text-align: center;
	color: white;
	float: left;
	line-height: 400%;
	font-family: "Times New Roman";
}
.navidiv .loginbar{
	width: 20%;
	height: 100%;
	padding: 0% 0% 0% 10%;
	text-align: center;
	color: white;
	float: left;
	line-height: 400%;
	
}
.homediv img{
	width: 40%;
	height: 45%;
	padding: 5% 0% 0px 0px;
}

.menubar a {
	text-decoration: none;
	color: white;
	font-size: 25px;
}
.loginbar a {
	text-decoration: none;
	color: white;
	font-size: 25px;
}
a:hover {
	font-weight: bold;
	color: #EA9A56;

}

a:hover .menubar{
	background-color: rgba(255, 255, 255, 0.3);
}

@-webkit-keyframes fade-in-fwd{0%{-webkit-transform:translateZ(-80px);transform:translateZ(-80px);opacity:0}100%{-webkit-transform:translateZ(0);transform:translateZ(0);opacity:1}}@keyframes fade-in-fwd{0%{-webkit-transform:translateZ(-80px);transform:translateZ(-80px);opacity:0}100%{-webkit-transform:translateZ(0);transform:translateZ(0);opacity:1}}
</style>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>
<img alt="" src="background.png" id="mainBackground">
<div class="navidiv">
	<div class="homediv">
		<a href="#"><img alt="" src="logo.png"></a>
	</div>
	<div class="menubar"><a href="#">NEWS</a></div>
	<div class="menubar"><a href="#">SCHEDULE</a></div>
	<div class="menubar"><a href="#">CONTACT</a></div>
	<div class="menubar"><a href="#">STORE</a></div>
	<div class="loginbar"><a href="#">LOGIN</a></div>
</div>
</body>
</html>