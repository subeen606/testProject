
<%@page import="dto.NewsDto"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin_newsdetail</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=DM+Serif+Text|Roboto+Condensed&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:100,300,400|Roboto|Roboto+Mono|Viga&display=swap" rel="stylesheet">
<style type="text/css">
body{
	margin: 0px;
	width: 100%;
	min-height: 100%;
	position: absolute;
	font-family: 'Roboto Condensed', sans-serif;
	
}
#box1{/* 가장큰 div */
overflow:hidden;
width: 60%;
height:auto;
margin: 0 auto;
margin-top: 200px;
padding-left:30px;
margin-bottom: 50px;
padding-bottom: 50px;
border: solid 5px;
border-color: #9EACB3; *
/* background-color: #9EACB3; */
}
#box2{/* 기사 사진 제목 포함 div*/
overflow:hidden;
width: 80%;
height:auto;
margin: 0 auto;
margin-top: 50px;
padding-bottom: 50px;
/* border: solid 2px;
border-color: blue; */
background-color: white;
}
#btndiv{
text-align: right;
margin-right: 20px;
}
/* .btn1{
margin-top:15px;
width:100px;
height:30px;
font-size:1em;
background-color: #2B3A40;
color: white;
cursor: pointer;
} */
.type01{
width: 100%;
}
.news_img{
width: 700px;
}
#title{
font-size: 40px;
}
#back{
font-size: 20px;
}
#content{
font-size: 18px;
}
.news_img2{  
width: 100%;
height: 55%;
}   
#morenews{
color: black;
}
.sideBar{
	background-color: rgba(0,0,0,0.5);
}
.sideBar a{
	text-decoration: none;
	color: black;
	font-size: 30px;	
}
.sideMenu a{
	font-size: 40px;
}
.sideMenu a:hover{
	font-weight: bold;
	color: #EA9A56;
}
.menubar a {
	text-decoration: none;
	color: white;
	font-size: 25px;
}

.menubar a:hover {
	font-weight: bold;
	color: #EA9A56;
}
.sideMenu ul{
	list-style: none;
}
.sideMenu ul ul{
	display: none;
}
.sideMenu ul li:hover ul{
	display: block;
}
.inani{
	-webkit-animation:slide-in-left 0.6s 0s 1 ease-in forwards;
	animation:slide-in-left 0.6s 0s 1 ease-in forwards;
}
.outani{
	-webkit-animation:slide-out-left 0.6s 0s 1 ease-in forwards;
	animation:slide-out-left 0.6s 0s 1 ease-in forwards;
}
@-webkit-keyframes slide-in-left{0%{-webkit-transform:translateX(-500px);transform:translateX(-500px);opacity:0}100%{-webkit-transform:translateX(0);transform:translateX(0);opacity:1}}@keyframes slide-in-left{0%{-webkit-transform:translateX(-500px);transform:translateX(-500px);opacity:0}100%{-webkit-transform:translateX(0);transform:translateX(0);opacity:1}}
@-webkit-keyframes slide-out-left{0%{-webkit-transform:translateX(0);transform:translateX(0);opacity:1}100%{-webkit-transform:translateX(-500px);transform:translateX(-500px);opacity:0}}@keyframes slide-out-left{0%{-webkit-transform:translateX(0);transform:translateX(0);opacity:1}100%{-webkit-transform:translateX(-500px);transform:translateX(-500px);opacity:0}}
.spinner-master * {transition:all 0.3s;-webkit-transition:all 0.3s;box-sizing:border-box;}

.spinner-master {position:relative;margin-top:15px ;height:40px;width:40px;}

.spinner-master input[type=checkbox] {display:none;}
.spinner-master label {cursor:pointer;position:absolute;z-index:99;height:100%;width:100%;top:10px;left:0;}

.spinner-master .spinner {position:absolute;height:5px;width:100%;background-color:#000;}

.spinner-master .diagonal.part-1 {position:relative;float:left;}
.spinner-master .horizontal {position:relative;float:left;margin-top:6px;}
.spinner-master .diagonal.part-2 {position:relative;float:left;margin-top:6px;}

.spinner-master input[type=checkbox]:checked ~ .spinner-spin > .horizontal {opacity: 0;}
.spinner-master input[type=checkbox]:checked ~ .spinner-spin > .diagonal.part-1 {transform:rotate(405deg);-webkit-transform:rotate(405deg);margin-top:10px;}
.spinner-master input[type=checkbox]:checked ~ .spinner-spin > .diagonal.part-2 {transform:rotate(-405deg);-webkit-transform:rotate(-405deg);margin-top:-16px;}

.adminbtns{
	box-sizing: border-box;
	width: 10%;
	height: 35px;
	background-color: #79a8a9;
	color: #fff;
	font-family: 'Noto Sans KR:300', sans-serif;
	font-size: 13pt;
	border: none;
	border-radius: 10px;
	padding: 10px;
	line-height: 0px;
	cursor: pointer;
	margin-right: 1rem;
}

.adminbtns:hover{
	background-color: #1f4e5f;
	color: #fff;
}

.backA{
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 30pt;
	text-decoration: none;
	color: black;
}

.backA:hover{
	color: #79a8a9;
}
</style>

</head>
<body>
<!-- Side Menu Bar -->
	<div class="sideBar" style="width: 0%; height:100%; top:0%; /* border: 1px solid black; */ position: absolute; margin: 0;">
		<div class="sideMenu" style="width: 60%; position: inherit; top: 33%; left: 12%; visibility:hidden;"  align="center">
		<ul>
			<li>
				<h1><a href="/TAMINO/AdminCtrl?command=Main_Page">Main</a></h1>
				<h1><a href="/TAMINO/AdminCtrl?command=ProductList&page=0">Product</a></h1>
				<ul>
					<li><h3><a href="/TAMINO/AdminCtrl?command=order_list&page=0">OrderList</a></h3></li>
					<li><h3><a href="/TAMINO/AdminCtrl?command=QnAList">Q&A</a></h3></li>
					<li><h3><a href="/TAMINO/AdminCtrl?command=Statistics">Statistics</a></h3></li>
				</ul>
			</li>
			<li><h1><a href="/TAMINO/AdminCtrl?command=Member_list&page=0">Member</a></h1></li>
			<li><h1><a href="/TAMINO/AdminCtrl?command=AdminSchedule">Schedule</a></h1></li>
			<li>
				<h1><a href="#" class="News">News</a></h1> 
				<ul>
					<li><h3><a href="/TAMINO/AdminCtrl?command=AdminPhoto">Photo</a></h3></li>
					<li><h3><a href="/TAMINO/AdminCtrl?command=Adminvideo">Video</a></h3></li>
				</ul>
			</li>
		</ul>	
		</div>
		<div style="width: 10%; height: 7%; position: inherit; /* border: 1px solid black; */ left: 100%; top: 46.5%;">
			<div class="spinner-master">
			  <input type="checkbox" id="spinner-form" />
			  <label for="spinner-form" class="spinner-spin">
			    <div class="spinner diagonal part-1"></div>
			    <div class="spinner horizontal"></div>
			    <div class="spinner diagonal part-2"></div>
			  </label>
			</div>
		</div>	
	</div>


    
<%
NewsDto dto = (NewsDto)request.getAttribute("dto");

List<NewsDto> list = (List<NewsDto>)request.getAttribute("detaillist");
%>


<div id="box1">

<a class="backA" href="/TAMINO/AdminCtrl?command=AdminPhoto"><p id="back"> &#10094; &nbsp; 뒤로가기 </p></a>  <!-- list로 가기 -->

<div id="btndiv">
<button type="button" class="adminbtns" onclick="updateNews('<%=dto.getNews_seq() %>')">수정</button>
<button type="button" class="adminbtns" onclick="deleteNews('<%=dto.getNews_seq() %>')">삭제</button>
</div>


<div id="box2">
<table class="type01">
<col width="600"><col width="200">


<tr>
	<th colspan="2"><p id="title"><%=dto.getTitle() %></p></th> <!-- 제목 -->
</tr>

<tr>
	<td></td>
	<th><p><%=(dto.getNews_date()).substring(0,10) %></p></th>
</tr>

<tr>
	<td></td>
	<th><p>조회수 <%=dto.getNews_readcount() %></p></th>
</tr>

<tr>
<div id="image">
 <th colspan="2"><img class="news_img" src="./upload/<%=dto.getFilename() %>"></th>
</div>
</tr>

<tr>
<th colspan="2" align="left"><p id="content"><%=dto.getContent() %></p>
</th>
</tr>
</table>

</div>


</div>








<script type="text/javascript">

function updateNews( seq ) {
	location.href = "/TAMINO/AdminCtrl?command=photoupdate&seq=" + seq;
}
function deleteNews( seq ) {
	location.href = "/TAMINO/AdminCtrl?command=photodelete&seq=" + seq;
}

$(function () {
	
	var i = 0;
	$("#spinner-form").on("click",function(){
		i++;
		if(i%2==1){
			setTimeout(function() {
				/* $(".sideBar").removeClass('inani'); */
				$(".sideBar").addClass("inani");
				$(".sideBar").css("width","13%");
				$(".sideMenu").css("visibility","visible");
			}, 300)
			}
			
			else{
				$(".sideBar").removeClass('inani');
				$(".sideBar").addClass("outani");
				setTimeout(function() {
					$(".sideBar").removeClass('outani');
					$(".sideMenu").css("visibility","hidden");
					$(".sideBar").css("width","0%");
				}, 600)
			}
	});

});


</script>


</body>
</html>