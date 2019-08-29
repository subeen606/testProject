<%@page import="dto.ProductDto"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ProductDto dto = (ProductDto)request.getAttribute("StoreDto");
	String pImg = dto.getProductImage();
	System.out.println("img:"+pImg);
	int count = StringUtils.countMatches(pImg, ",");
	System.out.println("count:"+count);
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
	margin-top: 5%;
	margin-bottom: 10%;
	margin-left: auto;
	margin-right: auto;
	width: 70%;
	height:auto;
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

input :text{
	width: 99%;
	height: auto;	
}
img{
	width: 150px;
	height: 150px;
}
.filebox{
text-align: center; 
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
.filebox label { display: inline-block; padding: .5em .75em; color: #999; font-size: inherit; line-height: normal; vertical-align: middle; background-color: #fdfdfd; border: 1px solid #ebebeb; border-bottom-color: #e2e2e2; border-radius: .25em; } 
.filebox input[type="file"] { /* 파일 필드 숨기기 */ position: absolute; width: 1px; height: 1px; padding: 0; margin: -1px; overflow: hidden; clip:rect(0,0,0,0); border: 0; }


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


<div align="center">

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
<p class="pageCaption">상품 상세정보</p>
<form action="/TAMINO/AdminCtrl">
	<input type="hidden" name="command" value="update">
	<input type="hidden" name="seq" value="<%=dto.getSeq()%>">
	<table id="table1">
	<col width="80"><col width="225"><col width="225">
	<tr>
		<th colspan="3"><p>상품 Detail</p></th>
	</tr>
	<!-- 상품명 -->
	<tr> 
		<th>상품명</th>
		<td colspan="2"><%=dto.getProductName() %></td>
	</tr>
	<!-- 가격 -->
	<tr>
		<th>가격</th>
		<td colspan="2"><%=dto.getPrice()%></td>
	</tr>
	<!-- 상품분류 -->
	<tr>
		<th>분류</th>
		<td colspan="2">
			<%=dto.getCode() %>
		</td>
	</tr>
	<!-- 재고수 -->
	<tr>
		<th>재고수</th>
		<%
			if(dto.getCode().equals("의류")){
				%>
				<td colspan="2">Small:<%=dto.getCount_s() %>개&nbsp;Medium:<%=dto.getCount_m() %>개&nbsp;Large:<%=dto.getCount_l() %>개</td>
				<%
			}
			else{
				%>
				<td colspan="2"><%=dto.getCount_o()%>개</td>
				<%
			}
		%>
	</tr>
	<!-- 상품이미지 -->
	<tr>
		<td colspan="3">
			<br>
			<%
			for(int i = 0; i < 2; i++){
				%>
				<div class="filebox" style="width: 50%; height: auto; float: left;" >
					<label>이미지<%=i+1 %></label>
					<br>
					<%
					if(pImg.split(",")[i].equals("")||pImg.split(",")[i]==null){
						%>
						<img alt="" src="#">
						<%
					}
					else{
						%>
						<img alt="" src="/TAMINO/product/<%=pImg.split(",")[i] %> ">
						<%
					}
					%>	
				</div>
				<%	
			}
			%>
		</td>	
	</tr>
		<tr>
		<td colspan="3">
			<br>
			<%
			for(int i = 2; i < 4; i++){
				%>
				<div class="filebox" style="width: 50%; height: auto; float: left;" >
					<label>이미지<%=i+1 %></label>
					<br>
					<%
					if(pImg.split(",")[i].equals("")||pImg.split(",")[i]==null){
						%>
						<img alt="" src="#">
						<%
					}
					else{
						%>
						<img alt="" src="/TAMINO/product/<%=pImg.split(",")[i] %> ">
						<%
					}
					%>	
				</div>
				<%	
			}
			%>
		</td>	
	</tr>
	<!-- 상품 상세설명 -->
	<tr>
		<th colspan="3">상세설명</th>
	</tr>
	<tr>
		<td colspan="3">
			<%-- <textarea rows="10" cols="70" name="content" readonly="readonly"><%=dto.getProductExplain() %></textarea> --%>
			<%=dto.getProductExplain() %>
		</td>
	</tr>
	<tr>
		<td colspan="3">
			<p>
			<input type="submit" value="수정하기" class="adminbtns" style="float: left;"id="updateBtn">
			<button type="button" id="backBtn" class="adminbtns" style="float: right;" onclick="javascript:history.back();">뒤로가기</button>
			</p>	
		</td>
	</tr>
	</table>
</form>
</div> 



<%-- 
<form action="/TAMINO/AdminCtrl">
	<input type="hidden" name="command" value="update">
	<input type="hidden" name="seq" value="<%=dto.getSeq()%>">
	<table border="1">
	<col width="80"><col width="225"><col width="225">
	<tr>
		<th colspan="3"><p>상품 Detail</p></th>
	</tr>
	<!-- 상품명 -->
	<tr> 
		<th>상품명</th>
		<td><%=dto.getProductName() %></td>
	</tr>
	<!-- 가격 -->
	<tr>
		<th>가격</th>
		<td><%=dto.getPrice()%></td>
	</tr>
	<!-- 상품분류 -->
	<tr>
		<th>분류</th>
		<td>
			<%=dto.getCode() %>
		</td>
	</tr>
	<!-- 재고수 -->
	<tr>
		<th>재고수</th>
		<%
			if(dto.getCode().equals("의류")){
				%>
				<td colspan="2">Small:<%=dto.getCount_s() %>개&nbsp;Medium:<%=dto.getCount_m() %>개&nbsp;Large:<%=dto.getCount_l() %>개</td>
				<%
			}
			else{
				%>
				<td colspan="2"><%=dto.getCount_o()%>개</td>
				<%
			}
		%>
	</tr>
	<!-- 상품이미지 -->
	<tr>
		<th colspan="3">
			<br>
			<%
			for(int i = 0; i < 2; i++){
				%>
				<div class="filebox" style="width: 50%; height: auto; float: left;" >
					<label>이미지<%=i+1 %></label>
					<br>
					<%
					if(pImg.split(",")[i].equals("")||pImg.split(",")[i]==null){
						%>
						<img alt="" src="#">
						<%
					}
					else{
						%>
						<img alt="" src="./product/<%=pImg.split(",")[i] %> ">
						<%
					}
					%>	
				</div>
				<%	
			}
			%>
		</th>	
	</tr>
		<tr>
		<th colspan="3">
			<br>
			<%
			for(int i = 2; i < 4; i++){
				%>
				<div class="filebox" style="width: 50%; height: auto; float: left;" >
					<label>이미지<%=i+1 %></label>
					<br>
					<%
					if(pImg.split(",")[i].equals("")||pImg.split(",")[i]==null){
						%>
						<img alt="" src="#">
						<%
					}
					else{
						%>
						<img alt="" src="./product/<%=pImg.split(",")[i] %> ">
						<%
					}
					%>	
				</div>
				<%	
			}
			%>
		</th>	
	</tr>
	<!-- 상품 상세설명 -->
	<tr>
		<th><br><br>상세설명</th>
	</tr>
	<tr>
		<td colspan="3">
			<textarea rows="10" cols="70" name="content" readonly="readonly"><%=dto.getProductExplain() %></textarea>
			<%=dto.getProductExplain() %>
		</td>
	</tr>
	<tr>
		<td colspan="3">
			<p>
			<input type="submit" value="수정하기" style="float: right;"id="updateBtn">
			<button type="button" style="float: left;" onclick="javascript:history.back();">뒤로가기</button>
			</p>	
		</td>
	</tr>
	</table>
</form>
</div>
 --%>
 
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
});



</script>
</body>
</html>