<%@page import="dto.ScheduleDto"%>
<%@page import="java.util.List"%>
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
<%
List<ScheduleDto> list = (List<ScheduleDto>)request.getAttribute("scheduleList");
int pages = (int)request.getAttribute("pages");
if(pages == 0){
	pages = 1;
}
%>
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
	margin: 10% 0 0 15%;
	width: 70%;
	height:auto;
	padding-bottom: 50px;

}
table {
    width: 80%;
    border-top: 1px solid #444444;
    border-collapse: collapse;
}
th, td {
    border-bottom: 1px solid #444444;
    padding: 10px;
   
  
}
tr.detail:hover { 
	background-color: lightyellow; 
	cursor: pointer;
} 
.title{
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
	margin-left: 10%;
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
<form id="schedulefrm" onsubmit="return check()">
<input type="hidden" name="command" value="ScheduleDelete">

<div id="box1" align="center">
<p class="pageCaption" align="left">Schedule 목록</p>
<table>
	<col width="30"><col width="70"><col width="200"><col width="150"><col width="150">
	<tr class="title">
		<th>
			<input type="checkbox" name="alldel">
		</th>
		<th>번호</th>
		<th>공연명</th>
		<th>일시</th>
		<th>장소</th>
	</tr>

	<%if(list.size() == 0){%>
		<tr>
			<td colspan="5" align="center">현재 입력된 스케줄이 없습니다.</td>
		</tr>
	<%}else {
		for(int i = 0; i < list.size(); i++){
			ScheduleDto dto = list.get(i);
			String when = convertDateTime(dto.getSchedule_date(), dto.getSchedule_time());
		%>
	<tr class="detail">
		<td>
			<input type="checkbox" name="delcheck" value="<%=dto.getSeq() %>">
		</td>
		<td align="center"><%=i+1 %></td>
		<td class="clicktitle" seq="<%=dto.getSeq() %>">&nbsp;&nbsp;&nbsp;&nbsp;<%=dto.getSchedule_title() %></td>
		<td align="center"><%=when %></td>
		<td><%=dto.getSchedule_place() %></td>
	</tr>
		<%
		}
	}
	%>

<!-- 검색바 -->
<tr>
	<th colspan="5" style="border: none;">
		<select name="search_category" style="width: 100px; height: 25px;">
			<option selected="selected" value="선택">선택</option>
			<option value="공연명">공연명</option>
			<option value="내용">내용</option>
			<option value="장소">장소</option>
			<option value="공연일시">공연일시</option>
		</select>
		<input type="search" name="search_txt" style="width: 300px; height: 25px;">
		<button type="button" class="adminbtns" style="width: 80px; transform: translate(0px, 2px);" id="searchBtn">검색</button>
	</th>
</tr>
<tr>
<!-- footer -->
<tr>
	<th colspan="5" style="border: none">
		<%
		for(int i = 1; i <= pages; i++){
			%>
			<a style="text-decoration: none; color: black" href="/TAMINO/AdminCtrl?command=AdminSchedule&page=<%=i %>" ><%=i %></a>
			<%
		}
		%>
	</th>
</tr>
<tr>
	<td colspan="5" style="border: none;">
	<button id="deleteBtn" type="submit" class="adminbtns"  style="float: left; width: 120px;">삭제하기</button>
	<button id="writeBtn" class="adminbtns"  style="float: right; width: 120px;" type="button">작성하기</button>
	</td>
</tr>
</table>
</div>
</form>



<%-- 
<form id="schedulefrm">
<input type="hidden" name="command" value="ScheduleDelete">
<table>
	<tr>
		<th>
			<input type="checkbox" name="alldel">
		</th>
		<th>번호</th>
		<th>공연명</th>
		<th>일시</th>
		<th>장소</th>
	</tr>

	<%if(list.size() == 0){%>
		<tr>
			<td colspan="5" align="center">현재 입력된 스케줄이 없습니다.</td>
		</tr>
	<%}else {
		for(int i = 0; i < list.size(); i++){
			ScheduleDto dto = list.get(i);
			String when = convertDateTime(dto.getSchedule_date(), dto.getSchedule_time());
		%>
	<tr>
		<td>
			<input type="checkbox" name="delcheck" value="<%=dto.getSeq() %>">
		</td>
		<td><%=i+1 %></td>
		<td class="clicktitle" seq="<%=dto.getSeq() %>"><%=dto.getSchedule_title() %></td>
		<td><%=when %></td>
		<td><%=dto.getSchedule_place() %></td>
	</tr>
		<%
		}
	}
	%>
	
<tr>
	<td colspan="3" align="left">
		<button type="button" id="deleteBtn">삭제하기</button>
	</td>
	<td colspan="2" align="right">
		<button type="button" id="writeBtn">작성하기</button>
	</td>
</tr>
</table>
</form>


<form id="searchfrm">
<input type="hidden" name="command" value="ScheduleSearch">
<select name="search_category">
	<option value="선택">선택</option>
	<option value="공연명">공연명</option>
	<option value="내용">내용</option>
	<option value="장소">장소</option>
	<option value="공연일시">공연일시</option>
</select>
<input type="search" name="search_txt">
<button type="button" id="searchBtn">검색</button>
</form>

<div class="pages">
<%for(int i = 1; i <= pages; i++){%>
	<a href="/TAMINO/AdminCtrl?command=AdminSchedule&page=<%=i %>" ><%=i %></a>
<%
}
%>
</div>
 --%>
<script type="text/javascript">
function check() {
	
	var checklen = $("input:checkbox[name='delcheck']:checked").length;
	if(checklen == 0 ){
		alert("삭제할 게시글을 선택해 주세요");
		return false;
	}
	else {
		
		return true;
	}
}


$(function () {
	$("#writeBtn").click(function() {
		location.href = "/TAMINO/AdminCtrl?command=ScheduleWrite"
	});
	

	
	$("#searchBtn").click(function () {
		var search_category = $("select[name=search_category]").val();
		var search_txt = $("input[name=search_txt]").val();
		alert("search_category:"+search_category+", search_txt:"+search_txt);
		location.href = "/TAMINO/AdminCtrl?command=ScheduleSearch&search_category="+search_category+"&search_txt="+search_txt;
	});
	
	
	$("input:checkbox[name='alldel']").change(function() {
		if($("input:checkbox[name='alldel']").is(":checked")){
			//alert("체크");
			$("input:checkbox[name='delcheck']").each(function () {
				$(this).attr("checked", true);
			});
		}else{
			//alert("체크 해제");
			$("input:checkbox[name='delcheck']").each(function () {
				$(this).attr("checked", false);
			});
		}
	});

	
	
	
	$(".clicktitle").click(function() {
		location.href = "/TAMINO/AdminCtrl?command=ScheduleDetail&seq=" + $(this).attr("seq");
	});
	
	$("#writeBtn").click(function() {
		location.href = "/TAMINO/AdminCtrl?command=ScheduleWrite"
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