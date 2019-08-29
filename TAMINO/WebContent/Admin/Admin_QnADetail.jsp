<%@page import="dto.StoreQnADto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
StoreQnADto dto = (StoreQnADto)request.getAttribute("qnadetail");
String product_name = request.getAttribute("product_name") + "";
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
	font-family: 'Noto Sans KR', sans-serif;
}
#box1{/* 가장큰 div */
	margin-top: 10%;
	margin-bottom: 10%;
	margin-left: auto;
	margin-right: auto;	
	width: 60%;
	height:auto;
	padding-bottom: 50px;
}	
#table1, #table2{
	border-collapse: collapse;
	border: solid 1px;
	float: left;
}
#table2{

}
th, td {
  	border: solid 1px;
    padding: 10px;
}
th{
	background-color: #9EACB3;
}


.replydiv{
	display: none;
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
	margin-left: 10%
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
<table id="table1" style="margin-left: 170px;">
<col width="100"><col width="300">
	<tr>
		<th colspan="2" style="height:50px; font-size: 20pt">Q&A</th>
	</tr>
	<tr>
		<th>제목</th>
		<td>
			<%=dto.getQna_title() %>
		</td>
	</tr>
	<tr>
		<th>작성자</th>
		<td>
			<%=dto.getQna_email() %>
		</td>
	</tr>
	
	<tr>
		<th>상품명</th>
		<td><%=product_name %></td>
	</tr>
	
	<tr>
		<th>분류</th>
		<td>
			<%=dto.getQna_category() %>
		</td>
	</tr>
	<tr>
		<th>내용</th>
		<td align="center">
			<textarea name="qna_content" rows="10" style="width: 95%" readonly="readonly"><%=dto.getQna_content() %></textarea>
		</td>
	</tr>
	
	<tr>
	
		<td colspan="2">
			<button type="button" class="adminbtns" style="width: 110px; float: left;" id="backBtn">돌아가기</button>
			<button type="button" class="adminbtns" style="width: 110px; float: right;" id="replyBtn">답변하기</button>
		</td>
	</tr>
</table>
 
<div class="replydiv">
<form id="replyfrm">
<input type="hidden" name="command" value="replyQnA">
<input type="hidden" name="parent_seq" value="<%=dto.getQna_seq() %>">
<input type="hidden" name="product_name" value="<%=product_name %>">
<input type="hidden" name="product_seq" value="<%=dto.getQna_product_seq() %>">
<input type="hidden" name="qna_category" value="<%=dto.getQna_category() %>">
<table id="table2" style="margin-left: 30px;">
<col width="100"><col width="300">
	<tr>
		<th colspan="2" style="height:50px; font-size: 20pt">답변작성</th>
	</tr>
	<tr>
		<th>제목</th>
		<td>
			<input type="text" name="reply_title">
		</td>
	</tr>
	<tr>
		<th>작성자</th>
		<td>
			관리자
		</td>
	</tr>
	
	<tr>
		<th>상품명</th>
		<td><%=product_name %></td>
	</tr>
	
	<tr>
		<th>분류</th>
		<td>
			<%=dto.getQna_category() %>
		</td>
	</tr>
	<tr>
		<th>내용</th>
		<td align="center">
			<textarea name="reply_content" rows="10" style="width: 95%" ></textarea>
		</td>
	</tr>
	
	<tr>
	
		<td colspan="2">
			<button type="button" class="adminbtns" style="width: 110px; float: right;" id="replywriteBtn">답변등록</button>
		</td>
	</tr>
</table>
</form>
</div>
</div>  

<%-- 
<table border="1" style="margin-left: 30px;">
<col width="100"><col width="300">
	<tr>
		<th>제목</th>
		<td>
			<%=dto.getQna_title() %>
		</td>
	</tr>
	<tr>
		<th>작성자</th>
		<td>
			<%=dto.getQna_email() %>
		</td>
	</tr>
	
	<tr>
		<th>상품명</th>
		<td><%=product_name %></td>
	</tr>
	
	<tr>
		<th>분류</th>
		<td>
			<%=dto.getQna_category() %>
		</td>
	</tr>
	<tr>
		<th>내용</th>
		<td align="center">
			<textarea name="qna_content" rows="10" style="width: 95%" readonly="readonly"><%=dto.getQna_content() %></textarea>
		</td>
	</tr>
	
	<tr>
	
		<td colspan="2">
			<button type="button" id="backBtn">돌아가기</button>
			<button type="button" id="replyBtn">답변하기</button>
		</td>
	</tr>
</table>

<div class="replydiv">
<form id="replyfrm">
<input type="hidden" name="command" value="replyQnA">
<input type="hidden" name="parent_seq" value="<%=dto.getQna_seq() %>">
<input type="hidden" name="product_name" value="<%=product_name %>">
<input type="hidden" name="product_seq" value="<%=dto.getQna_product_seq() %>">
<input type="hidden" name="qna_category" value="<%=dto.getQna_category() %>">
<table border="1" style="margin-left: 30px;">
<col width="100"><col width="300">
	<tr>
		<th>제목</th>
		<td>
			<input type="text" name="reply_title">
		</td>
	</tr>
	<tr>
		<th>작성자</th>
		<td>
			관리자
		</td>
	</tr>
	
	<tr>
		<th>상품명</th>
		<td><%=product_name %></td>
	</tr>
	
	<tr>
		<th>분류</th>
		<td>
			<%=dto.getQna_category() %>
		</td>
	</tr>
	<tr>
		<th>내용</th>
		<td align="center">
			<textarea name="reply_content" rows="10" style="width: 95%" ></textarea>
		</td>
	</tr>
	
	<tr>
	
		<td colspan="2">
			<button type="button" id="replywriteBtn">답변등록</button>
		</td>
	</tr>
</table>
</form>
</div> --%>

<script type="text/javascript">
$(function () {
	$("#backBtn").click(function () {
		location.href = "/TAMINO/AdminCtrl?command=QnAList";
	});
	
	$("#replyBtn").click(function () {
		$(".replydiv").css("display", "block");
	});
	
	$("#replywriteBtn").click(function () {
		$("#replyfrm").attr("action", "/TAMINO/AdminCtrl").submit();
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