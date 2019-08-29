<%@page import="dto.StoreQnADto"%>
<%@page import="dto.OrderListDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
List<OrderListDto> TodayOrderList = new ArrayList<>();
List<StoreQnADto> TodayQnAList = new ArrayList<>();
TodayOrderList = (List<OrderListDto>)request.getAttribute("TodayOrderList");
TodayQnAList = (List<StoreQnADto>)request.getAttribute("TodayQnAList"); 

System.out.println("TodayOrderList.size():"+TodayOrderList.size()+", TodayQnAList.size():"+TodayQnAList.size());
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
/* .backgroundImg{
	width: 100%;
	height: 100%;
	position: fixed;
	margin: 0;
}
 */
 .bodyDiv{
 	width: 70%;
 	height: 100%;
 	margin: 0 auto;
 	left: 15%;
 	text-align: center;
 	margin-top: 100px;
 	margin-bottom: 100px;
 }
 .bodyDiv div{
 	width: 100%;
 	height: 50%;
 	
 	display: inline-block;
 	float: left;
 	margin: 0 auto;
 	/* padding-bottom: 50px; */
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
tr.detail:hover { 
	background-color: lightyellow; 
	cursor: pointer;
} 
tr.detail2:hover { 
	background-color: lightyellow; 
	cursor: pointer;
}
tr.moreview:hover{
		background-color: lightyellow; 
	cursor: pointer;
} 
tr.moreview2:hover{
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
<!-- <div class="backgroundImg">
	<img alt="" src="/Tamino/image/Admin_Main.png" style="width: 100%; height: 100%;">
</div> -->
<div class="bodyDiv">

	<!-- 오늘의 주문내역 -->
	<div>
		<table>
			<col width="7.5%"><col width="10%"><col width="10%">
			<col width="42.5%"><col width="15%"><col width="5%"><col width="10%">
			<tr>
				<th colspan="7">오늘의 주문내역</th>
			</tr>
			<tr class="title">
				<th>주문번호</th>
				<th>주문자</th>
				<th>전화번호</th>
				<th>주소</th>
				<th>상품명</th>
				<th>수량</th>
				<th>총가격</th>
			</tr>
<%
	 if(TodayOrderList==null || TodayOrderList.size()==0){
		 %>
		 <tr>
		 	<th colspan="7" rowspan="8">구매내역이 없습니다.</th>
		 </tr>
		 <%
	 }
	 else{
		 for(int i=0; i<TodayOrderList.size(); i++){
			 if(i<7){
			 %>
			 <tr class="detail" seq="<%=TodayOrderList.get(i).getOderlist_seq()%>">
			 	<td><%=TodayOrderList.get(i).getOderlist_seq() %></td>
			 	<td><%=TodayOrderList.get(i).getOrder_email() %></td>
			 	<td><%=TodayOrderList.get(i).getOrder_phonenumber() %></td>
			 	<td><%=TodayOrderList.get(i).getOrder_address() %></td>
			 	<td><%=TodayOrderList.get(i).getProduct_name() %></td>
			 	<td><%=TodayOrderList.get(i).getProduct_count()%></td>
			 	<td><%=TodayOrderList.get(i).getProduct_price() %></td>
			 </tr>
			 <%
			 }
			 else if(i==7){
				 %>
				 <tr class="moreview">
				 	<th colspan="7" style="border: none;">
				 		<h3>...</h3>더보기
				 	</th>
				 </tr>
				 <%
			 }
		 }
	 }
%> 
		</table>
	</div>
	
	<!-- 오늘의 Q&A 게시글 -->
	<div style="margin-top: 3rem;">
		<table>
			<col width="7.5%"><col width="12.5%">
			<col width="10%"><col width="15%"><col width="50%">
			<tr>
				<th colspan="5">오늘의 Q&A게시글</th>
			</tr>
			<tr class="title">
				<th>주문번호</th>
				<th>작성자</th>
				<th>분류</th>
				<th>제목</th>
				<th>내용</th>
			</tr>
<%
	 if(TodayQnAList==null || TodayQnAList.size()==0){
		 %>
		 <tr>
		 	<th colspan="5" rowspan="8">게시글이 없습니다.</th>
		 </tr>
		 <%
	 }
	 else{
		 for(int i=0; i<TodayQnAList.size(); i++){
			 if(i<7){
			 %>
			 <tr class="detail2" seq="<%=TodayQnAList.get(i).getQna_seq()%>">
			 	<td><%=TodayQnAList.get(i).getQna_product_seq() %></td>
			 	<td><%=TodayQnAList.get(i).getQna_email() %></td>
			 	<td><%=TodayQnAList.get(i).getQna_category() %></td>
			 	<td><%=TodayQnAList.get(i).getQna_title() %></td>
			 	<td><%=TodayQnAList.get(i).getQna_content()%></td>
			 </tr>
			 <%
			 }
			 else if(i==7){
				 %>
				 <tr class="moreview2">
				 	<th colspan="5" style="border: none;">
				 		<h3>...</h3>더보기
				 	</th>
				 </tr>
				 <%
			 }
		 }
	 }
%> 			
		</table>
	</div>
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
$(document).ready(function() {
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
	
	$(".detail").on("click",function(){
		/* alert("클릭됨"); */
		var seq = $(this).attr("seq");
		location.href="/TAMINO/AdminCtrl?command=Order_Detail&seq="+seq;
	});
	
	$(".detail2").on("click",function(){
		var seq = $(this).attr("seq");
		location.href="/TAMINO/AdminCtrl?command=QnADetail&seq="+seq;
	});
	
	$(".moreview").on("click",function(){
		location.href="/TAMINO/AdminCtrl?command=order_list&page=0"
	});
	
	$(".moreview2").on("click",function(){
		location.href="/TAMINO/AdminCtrl?command=QnAList"
	});
});
</script>
</body>
</html>