<%@page import="dto.ProductDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<ProductDto> list = new ArrayList<ProductDto>();
	list = (List<ProductDto>)request.getAttribute("list");
	if(list != null){
		System.out.println("리스트 넘어옴");
	}
	int pCount = (int)request.getAttribute("pCount");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Store Admin</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=DM+Serif+Text|Roboto+Condensed&display=swap" rel="stylesheet">
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
<p class="pageCaption" align="left">상품목록</p>
<table style="vertical-align: middle;">
<col width="2.5%"><col width="12.5%"><col width="40%">
<col width="15%"><col width="15%"><col width="15%">
<tr class="title">
	<th><input type="checkbox" id="_chk"></th>
	<th>SEQ</th>
	<th>상품명</th>
	<th>분류</th>
	<th>가격</th>
	<th>재고수</th>
</tr>
<%
	if(list==null || list.size()==0){
%>
	 <tr>
	 	<th colspan="6">등록된 상품이 없습니다.</th>
	 </tr>
	 <%
	 	}
	  else{
	 	 for(ProductDto dto : list){
	 %>
		 <tr class="detail">
		 	<th><input type="checkbox" value="<%=dto.getSeq()%>" class="check"></th>
		 	<td id="_1" align="center"><%=dto.getSeq() %></td>
		 	<td id="_2">&nbsp;&nbsp;<%=dto.getProductName() %></td>
		 	<td id="_3" align="center"><%=dto.getCode() %></td>
		 	<td id="_4" align="center"><%=dto.getPrice() %></td>
		 	<%
		 	if(dto.getCount_o()==0){
		 		%>
		 		<td id="_5">
		 			<%=dto.getProductSize().split("-")[0]%>:<%=dto.getCount_s() %>
		 			<%=dto.getProductSize().split("-")[1]%>:<%=dto.getCount_m() %>
		 			<%=dto.getProductSize().split("-")[2]%>:<%=dto.getCount_l() %>
		 		</td>
		 		<%
		 	}
		 	else{
		 		%>
		 		<td id="_6">
		 			<%=dto.getCount_o() %>
		 		</td>
		 		<%
		 	}
			%>
		 </tr>
		 <%
	 }
 }
%>
<!-- 검색바 -->
<tr>
	<th colspan="6" style="border: none;">
		<select id="_findSel"  style="width: 100px; height: 25px;">
			<option selected="selected" value="상품명">상품명</option>
			<option value="분류">분류</option>
			<option value="가격">가격</option>
		</select>
		<input type="text" placeholder="검색어를 입력해주세요." style="width: 300px; height: 20px;" id="_findText">
		<button type="button" class="adminbtns" style="width: 80px; transform: translate(0px, 2px); "  onclick="findFunc()">검색</button>
	</th>
</tr>
<tr>
<!-- footer -->
<tr>
	<th colspan="6" style="border: none">
		<%
		int pageNum = (pCount / 11)+1;
		for(int i=1; i<pageNum+1; i++){
			%>
			<a style="text-decoration: none; color: black" href="/TAMINO/AdminCtrl?command=ProductList&page=<%=i-1%>"><%=i %></a>
			<%
		}
		%>
	</th>
</tr>
<tr>
	<td colspan="6" style="border: none;">
	<button id="_del" type="button" class="adminbtns" style="width: 120px; float: left;">삭제하기</button>
	<button id="_add" class="adminbtns" style="width: 120px; float: right;" type="button">등록하기</button>
	</td>
</tr>
</table>
</div>



<%-- 
<div align="center">
<table border="1" style="vertical-align: middle;">
<col width="10"><col width="50"><col width="250">
<col width="150"><col width="150"><col width="200">
<tr>
	<th><input type="checkbox" id="_chk"></th>
	<th>SEQ</th>
	<th>상품명</th>
	<th>분류</th>
	<th>가격</th>
	<th>재고수</th>
</tr>
<%
	if(list==null || list.size()==0){
%>
	 <tr>
	 	<th colspan="6">등록된 상품이 없습니다.</th>
	 </tr>
	 <%
	 	}
	  else{
	 	 for(ProductDto dto : list){
	 %>
		 <tr>
		 	<th><input type="checkbox" value="<%=dto.getSeq()%>" class="check"></th>
		 	<th><%=dto.getSeq() %></th>
		 	<td><a href="/TAMINO/AdminCtrl?command=detail&seq=<%=dto.getSeq()%>"><%=dto.getProductName() %></a></td>
		 	<td><%=dto.getCode() %></td>
		 	<td><%=dto.getPrice() %></td>
		 	<%
		 	if(dto.getCount_o()==0){
		 		%>
		 		<td><%=dto.getProductSize().split("-")[0]%>:<%=dto.getCount_s() %>
		 			<%=dto.getProductSize().split("-")[1]%>:<%=dto.getCount_m() %>
		 			<%=dto.getProductSize().split("-")[2]%>:<%=dto.getCount_l() %>
		 		</td>
		 		<%
		 	}
		 	else{
		 		%>
		 		<td>
		 			<%=dto.getCount_o() %>
		 		</td>
		 		<%
		 	}
			%>
		 </tr>
		 <%
	 }
 }
%>
<!-- 검색바 -->
<tr>
	<th colspan="6" style="border: none;">
		<select id="_findSel">
			<option selected="selected" value="상품명">상품명</option>
			<option value="분류">분류</option>
			<option value="가격">가격</option>
		</select>
		<input type="text" placeholder="검색어를 입력해주세요."style="width: 300px" id="_findText">
		<button type="button" onclick="findFunc()">검색</button>
	</th>
</tr>
<tr>
<!-- footer -->
<tr>
	<th colspan="6" style="border: none">
		<%
		int pageNum = (pCount / 11)+1;
		for(int i=1; i<pageNum+1; i++){
			%>
			<a href="/TAMINO/AdminCtrl?command=list&page=<%=i-1%>"><%=i %></a>
			<%
		}
		%>
	</th>
</tr>
<tr>
	<td colspan="6" style="border: none;">
	<button id="_del" type="button" style="float: left;">삭제하기</button>
	<button id="_add" style="float: right;" type="button">등록하기</button>
	</td>
</tr>
</table>
</div> --%>
<script type="text/javascript">
$(document).ready(function() {
	$("#_add").on("click",function(){ //상품등록할때
		//alert("클릭");
		location.href = "/TAMINO/AdminCtrl?command=add";
	});
	
	$("#_del").on("click",function(){
		var a = $(":checkbox:checked").length;
		var b = "";
		/* alert("a:"+a); */
		if(a == 0){
			alert("항목을 체크해주세요!")
			return;
		}
		else{
			$(".check").each(function(){
				if($(this).is(":checked")){
					 b += ($(this).val())+",";
				}
			});
			
			/* alert("b:"+b); */
			location.href = "/TAMINO/AdminCtrl?command=delete&seq="+b;
		}
	});
	
	$("#_chk").on("change",function(){
		if($(this).is(":checked")){
			/* alert("체크됨"); */
			$(".check").prop('checked',true);
		}
		else{
			$(".check").prop('checked',false);
		}
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
	
	$(".detail #_1,.detail #_2,.detail #_3,.detail #_4,.detail #_5,.detail #_6").on("click",function(){
     	var seq = $(this).parent("tr").children("th").children(".check").val();
     	
		location.href = "/TAMINO/AdminCtrl?command=detail&seq="+seq;
	});
});

function findFunc() {
	var sel = $("#_findSel").val();
	var fText = $("#_findText").val();
	/* alert("sel:"+sel+", fText:"+fText); */
	location.href = "/TAMINO/AdminCtrl?command=finding&select="+sel+"&fText="+fText+"&page=0";
}
</script>


</body>
</html>