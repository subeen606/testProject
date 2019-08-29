

<%@page import="dto.NewsDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=DM+Serif+Text|Roboto+Condensed&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:100,300,400|Roboto|Roboto+Mono|Viga&display=swap" rel="stylesheet">
<style type="text/css">
body{
	margin: 0px;
	width: 100%;
	height: 100%;
	position: fixed;
	font-family: 'Roboto Condensed', sans-serif;
	
}
#box1{/* 가장큰 div */
	margin: 0 auto;
	width: 60%;
	height:auto;
	margin-top: 120px;
}
table {
    width: 100%;
    border-top: 1px solid #444444;
    border-collapse: collapse;
}
th, td {
    border-bottom: 1px solid #444444;
    padding: 10px;
}
tr.detail:hover { background-color: lightyellow; cursor: pointer;} 

.title{
      border-bottom: none;
}
#btndiv{
text-align: right;
}


/* 스크롤 */

 .fixed-table-container {
        width: 100%;
        height: 500px;
        position: relative;
        padding-top: 30px; /* header-bg height값 */
        border: solid 1px #444444;
    }
    .header-bg {
        background: #9EACB3;
        height: 50px; /* header-bg height값 */
        position: absolute;
        top: 0;
        right: 0;
        left: 0; 
        border-bottom: solid 1px #444444;
  
      
    }
    .table-wrapper {
        overflow-x: hidden;
        overflow-y: auto;
        height: 100%;
    }

    .th-text {
        position: absolute;
        top: 0;
        width: inherit;
        line-height: 40px; /* header-bg height값 */
        padding-top: 10px;
        padding-bottom: 10px;

       
    }
    th:first-child .th-text {
        border-left: none;
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
	width: 20%;
	height: 30px;
	background-color: #79a8a9;
	color: #fff;
	font-family: 'Noto Sans KR:300', sans-serif;
	font-size: 13pt;
	border: none;
	border-radius: 10px;
	padding: 10px;
	line-height: 0px;
	cursor: pointer;
}

.adminbtns:hover{
	background-color: #1f4e5f;
	color: #fff;
}

.pageCaption{
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 25pt;
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
List<NewsDto> list = (List<NewsDto>)request.getAttribute("newslist");

%> 



<form action="/TAMINO/AdminCtrl" method="get">
<input type="hidden" name="command" value="photowrite">

<div id="box1">
<p class="pageCaption">News 목록</p>
<div id="btndiv">
	<input type="submit" class="adminbtns" style="margin-top: 20px; width: 150px; height: 35px;" value="News작성"><!-- 관리자 일때만 -->
	</div>
<br>
    <div class="fixed-table-container">
        <div class="header-bg"></div>
        <div class="table-wrapper">  

<table class="table1">

<col width="10%"><col width="35%"><col width="55%">
<thead>
<tr class="title">
	<th width="10%"><div class="th-text">번호</div></th><th width="35%"><div class="th-text">제목</div></th><th width="55%"><div class="th-text">내용</div></th>
</tr>
</thead>

<%
if(list == null || list.size() == 0){
	%>
	<tr>
		<td colspan="3">작성된 글이 없습니다</td>
	</tr>
	<%
}else{
	for(int i = 0;i < list.size(); i++){
		NewsDto dto = list.get(i);
		//글자수 자르기
		String txt = dto.getContent();
		if(txt.length() >= 300){
		    txt = txt.substring(0,300)+"...";
		    }
		
	%>	
	<tbody>
	<tr class="detail" seq="<%=dto.getNews_seq()%>">	
		<th  style="padding-left: 30px;"><%=i + 1 %></th>
		<td >
			<%
			if(dto.getDel() == 0){
				%>	
					<%=dto.getTitle() %>
				<%
			}else{
				%>		
				<font color="#ff0000">-----  삭제된 글입니다 -----</font> 
				<%
			}
			%>
		</td>
		<td><%=txt %></td>		<!-- 글자수 제한 -->
	</tr>	
	</tbody>
	<%	
	}	
}

%>

</table>

       </div>
	
</div>


</div>

</form>

<script type="text/javascript">
$(function () {
	$(".detail").click(function() {
		location.href = "/TAMINO/AdminCtrl?command=photodetail&seq=" + $(this).attr("seq");
	});
	
	$(".btn1").mouseover(function() {		
		$(this).css("background", "#AAABD3");
	});
	$(".btn1").mouseout(function() {		
		$(this).css("background", "#2B3A40");
	});
	
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