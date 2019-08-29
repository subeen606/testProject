
<%@page import="dto.OrderListDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<OrderListDto> list = new ArrayList<>();
	list = (List<OrderListDto>)request.getAttribute("list");
	int oCount = (int)request.getAttribute("oCount");
	String fText = (String)request.getAttribute("fText");
	String sel = (String)request.getAttribute("sel");
	String sel_[] = {"이메일","전화번호","상품명"};
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=DM+Serif+Text|Roboto+Condensed&display=swap" rel="stylesheet">
<style type="text/css">
body{
	margin: 0px;
	width: 100%;
	min-height:100%;
	position:absolute;
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
#deleteBtn,#writeBtn{
	width:100px;
	height:30px;
	font-size:1em;
	background-color: #2B3A40;
	color: white;
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
</style>
</head>
<body>

<div id="box1" align="center">
<table style="vertical-align: middle;">
<col width="5%"><col width="20%"><col width="20%">
<col width="30%"><col width="10%"><col width="15%">
<tr class="title">
	<th>주문번호</th>
	<th>Email</th>
	<th>전화번호</th>
	<th>상품명</th>
	<th>개수</th>
	<th>총금액</th>
</tr>
<%
 if(list==null || list.size()==0){
	 %>
	 <tr>
	 	<th colspan="6">주문내역이 없습니다.</th>
	 </tr>
	 <%
 }
 else{
	 for(OrderListDto dto : list){
		 %>
		 <tr class="detail" seq="<%=dto.getOderlist_seq() %>">
		 	<th><%=dto.getOderlist_seq() %></th>
		 	<th><%=dto.getOrder_email() %></th>
		 	<th><%=dto.getOrder_phonenumber() %></th>
		 	<th><%=dto.getProduct_name() %></th>
		 	<th><%=dto.getProduct_count() %></th>
		 	<th><%=dto.getProduct_count()*dto.getProduct_price() %></th>
		 </tr>
		 <%
		 }
	 }
%>

<!-- 검색바 -->
<tr>
	<th colspan="6" style="border: none;">
		<select id="_findSel">
			<%
			for(int i=0; i<sel_.length; i++){
				if(sel_[i].equals(sel)){
					%>
						<option selected="selected" value="<%=sel%>"><%=sel %></option>
					<%
				}
				else{
					%>
						<option value="<%=sel_[i] %>"><%=sel_[i] %></option>
					<%
				}
			}
			%>
		</select>
		<input type="text" placeholder="검색어를 입력해주세요."style="width: 300px" id="_findText">
		<button type="button" onclick="findFunc()">검색</button>
	</th>
</tr>
<!-- footer -->
<tr>
	<th colspan="6" style="border: none">
		<%
		int pageNum = (oCount / 11)+1;
		for(int i=1; i<pageNum+1; i++){
			%>
			<a href="/TAMINO/AdminCtrl?command=order_findlist&page=<%=i-1%>&sel=<%=sel%>&fText=<%=fText%>"><%=i %></a>
			<%
		}
		%>
	</th>
</tr>
</table>
</div>

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

<script type="text/javascript">

function findFunc() {
	var sel =  $("#_findSel").val();
	var fText = $("#_findText").val();
	/* alert("sel:"+sel+",fText:"+fText); */
	if(fText.trim() == ""){
		location.href = "/TAMINO/AdminCtrl?command=order_list&page=0";
	}
	else{
		location.href = "/TAMINO/AdminCtrl?command=order_findlist&page=0&sel="+sel+"&fText="+fText;
	}
}
$(document).ready(function() {
	
	
	
	$(".detail").on("click",function(){
     var seq = $(this).attr("seq");	
		location.href = "/TAMINO/AdminCtrl?command=Order_Detail&seq="+seq;
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