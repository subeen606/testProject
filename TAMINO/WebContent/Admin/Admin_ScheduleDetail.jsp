<%@page import="dto.ScheduleDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
public String convertDateTime(String date, String time){
	String year = date.substring(0, 4);
	String month = date.substring(4, 6);
	String day = date.substring(6,	8);
	String hour = time.substring(0, 2);
	String minute = time.substring(2, 4);
	
	return year + "." + month + "." + day + " " + hour + "시 " + minute + "분"; 
}
%>
<% ScheduleDto dto = (ScheduleDto)request.getAttribute("detail"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
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
	margin-top: 5%;
	margin-bottom: 10%;
	margin-left: auto;
	margin-right: auto;
	width: 70%;
	height:auto;
	padding-bottom: 50px;
}
#table1{
	border-collapse: collapse;
	border: solid 1px;
}
th, td {
	border: solid 1px;
	padding: 10px;
}
th{
	background-color: #9EACB3;
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

<div id="box1" align="center">
<p class="pageCaption" align="center">Schedule 상세정보</p>
<table id="table1">
<col width="100"><col width="500">
	<tr>
		<th>공연 명</th>
		<td><%=dto.getSchedule_title() %></td>
	</tr>
	
	<tr>
		<th>공연 일시</th>
		<td><%=dto.getSchedule_date().substring(0, 4) %>년 <%=dto.getSchedule_date().substring(4, 6) %>월 <%=dto.getSchedule_date().substring(6, 8) %>일</td>
	</tr>
	
	<tr>
		<th>공연 시간</th>
		<td><%=dto.getSchedule_time().substring(0, 2) %>시 <%=dto.getSchedule_time().substring(2, 4) %>분</td>
	</tr>
	
	<tr>
		<th>예매처</th>
		<td><%=dto.getTicketLink() %></td>
	</tr>
	
	<tr>
		<th>사진</th>
		<td>
			<img alt="" src="./poster/<%=dto.getSchedule_poster() %>" width="300px"	height="420px">
		</td>
	</tr>
	
	<tr>
		<th colspan="2">내용</th>
	</tr>
	
	<tr>
		<td colspan="2" align="center">
			<textarea rows="10" style="width: 95%" name="schedule_content" id="content_txt" readonly="readonly"><%=dto.getSchedule_content() %></textarea>
		</td>
	</tr>
	
	
	<tr>
		<th>공연 장소</th>
		<td><%=dto.getSchedule_place() %></td>
	</tr>
	
	<tr>
		<td align="center" colspan="2">
			<button type="button" class="adminbtns" style="float: left;" id="backBtn">목록으로</button>
			<button type="button" class="adminbtns" style="float: right;" id="updateBtn">수정하기</button>
		</td>
	</tr>
	
</table>
</div>



<%-- 
<table border="1">
<col width="100"><col width="500">
	<tr>
		<th>공연 명</th>
		<td><%=dto.getSchedule_title() %></td>
	</tr>
	
	<tr>
		<th>공연 일시</th>
		<td><%=dto.getSchedule_date().substring(0, 4) %>년 <%=dto.getSchedule_date().substring(4, 6) %>월 <%=dto.getSchedule_date().substring(6, 8) %>일</td>
	</tr>
	
	<tr>
		<th>공연 시간</th>
		<td><%=dto.getSchedule_time().substring(0, 2) %>시 <%=dto.getSchedule_time().substring(2, 4) %>분</td>
	</tr>
	
	<tr>
		<th>예매처</th>
		<td><%=dto.getTicketLink() %></td>
	</tr>
	
	<tr>
		<th>사진</th>
		<td>
			<img alt="" src="./poster/<%=dto.getSchedule_poster() %>" width="300px"	height="420px">
		</td>
	</tr>
	
	<tr>
		<th colspan="2">내용</th>
	</tr>
	
	<tr>
		<td colspan="2" align="center">
			<textarea rows="10" style="width: 95%" name="schedule_content" id="content_txt" readonly="readonly"><%=dto.getSchedule_content() %></textarea>
		</td>
	</tr>
	
	
	<tr>
		<th>공연 장소</th>
		<td><%=dto.getSchedule_place() %></td>
	</tr>
	
	<tr>
		<td align="center" colspan="2">
			<button type="button" id="backBtn">목록으로 돌아가기</button>
			<button type="button" id="updateBtn">수정하기</button>
		</td>
	</tr>
	
</table>
 --%>
<script type="text/javascript">
$(function () {
	$("#backBtn").click(function () {
		location.href = "/TAMINO/AdminCtrl?command=backShecduleList";
	});
	
	$("#updateBtn").click(function() {
		location.href = "/TAMINO/AdminCtrl?command=ScheduleUpdate&seq=" + <%=dto.getSeq() %>;
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