<%@page import="dto.StoreQnADto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
public String arrow(int depth){
	String rs = "<img src='./image/arrow.png' width='20px' height='20px'>";
	String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;";
	
	String ts = "";
	for(int i = 0; i < depth; i++){
		ts += nbsp;
	}
	return depth==0?"":ts+rs;
}
%>
<%
List<StoreQnADto> list = (List<StoreQnADto>)request.getAttribute("QnAList");
String Spages = request.getAttribute("pages") + "";
int pages = Integer.parseInt(Spages);

String qna_category = request.getAttribute("qna_category") + "";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<title>Insert title here</title>
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
	margin: 0 auto;
	width: 60%;
	height:auto; 
	margin-top: 100px;
	margin-bottom: 200px;
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
     background-color: #9EACB3;
}
#searchBtn{
margin-left: 5px;
}
select{ 
width: 80px; 
height: 30px;
font-size:0.8em;
}
#search{ 
width: 150px;
height: 29px; 
font-size: 1em; 
}
#categoryselect{
margin-bottom: 5px;
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


<form id="qnalistfrm">
<input type="hidden" name="command" value="QnAList">

<div id="box1">
<p class="pageCaption">Store Q&A</p>
<select name="qna_category" id="categoryselect">
	<option value="분류선택">분류선택</option>
	<option value="배송문의">배송문의</option>
	<option value="상품문의">상품문의</option>
	<option value="기타">기타</option>
</select>

<table class="table1">
<col width="50px"><col width="100px"><col width="100px"><col width="400px"><col width="200px"><col width="150px">
	<tr class="title">
		<th>
			<input type="checkbox" name="alldel">
		</th>
		<th>No.</th><th>분류</th><th>제목</th><th>작성자</th><th>작성일</th>
	</tr>
	<% if(list.size() == 0 || list == null){%>
		<tr>
			<td colspan="6" align="center">작성된 QnA가 없습니다.</td>
		</tr>
	<%	
	}else{
		for(int i=0; i<list.size(); i++){
			StoreQnADto dto = list.get(i);
		%>
			<tr class="detail">
					<td align="center"><input type="checkbox" name="delcheck" value="<%=dto.getQna_seq() %>"></td>
					<td align="center"><%=i+1 %></td>
					<td align="center"><%=dto.getQna_category() %></td>
					<td class="QnAtitle" seq=<%=dto.getQna_seq() %> writeId="<%=dto.getQna_email() %>">
						<%=arrow(dto.getQna_depth()) %>&nbsp;&nbsp;<%=dto.getQna_title() %>
					</td>
					<td align="center"><%=dto.getQna_email() %></td>
					<td align="center"><%=dto.getQna_wdate().subSequence(0, 10) %></td>
				
			</tr>
		<%
		}
	}
	%>
	<tr>
		<td colspan="3" align="left">
			<button type="button" class="adminbtns" style="width: 120px;" id="deleteBtn">삭제하기</button>
		</td>
		<td colspan="1" align="center">
			<div class="pages"> 
				<%for(int i = 1; i <= pages; i++){%>
					<a style="text-decoration: none; color: black; font-weight: bold;" href="/TAMINO/AdminCtrl?command=QnAList&page<%=i %>" ><%=i %></a>
				<%
				}
				%>
			</div> 
		</td>
		<td colspan="2" align="right">
			<select name="search_category">
				<option value="선택">선택</option>
				<option value="작성자">작성자</option>
				<option value="제목">제목</option>
				<option value="내용">내용</option>
				<option value="작성일">작성일</option>
			</select>
		<input id="search" type="search" name="search_txt"><button type="button" class="adminbtns" style="transform: translate(0px, 2px);" id="searchBtn">검색</button>
		</td>
	</tr>
</table>

</div>
</form>




<%-- 
<form id="qnalistfrm">
<input type="hidden" name="command" value="QnAList">
<select name="qna_category">
	<option value="분류선택">분류선택</option>
	<option value="배송문의">배송문의</option>
	<option value="상품문의">상품문의</option>
	<option value="기타">기타</option>
</select>

<table border="1">
<col width="50px"><col width="100px"><col width="100px"><col width="400px"><col width="200px"><col width="150px">
	<tr>
		<th>
			<input type="checkbox" name="alldel">
		</th>
		<th>No.</th><th>분류</th><th>제목</th><th>작성자</th><th>작성일</th>
	</tr>
	<% if(list.size() == 0 || list == null){%>
		<tr>
			<td colspan="6" align="center">작성된 QnA가 없습니다.</td>
		</tr>
	<%	
	}else{
		for(int i=0; i<list.size(); i++){
			StoreQnADto dto = list.get(i);
		%>
			<tr>
					<td align="center"><input type="checkbox" name="delcheck" value="<%=dto.getQna_seq() %>"></td>
					<td align="center"><%=i+1 %></td>
					<td align="center"><%=dto.getQna_category() %></td>
					<td class="QnAtitle" seq=<%=dto.getQna_seq() %> writeId="<%=dto.getQna_email() %>">
						<%=arrow(dto.getQna_depth()) %>&nbsp;&nbsp;<%=dto.getQna_title() %>
					</td>
					<td align="center"><%=dto.getQna_email() %></td>
					<td align="center"><%=dto.getQna_wdate().subSequence(0, 10) %></td>
				
			</tr>
		<%
		}
	}
	%>
	<tr>
		<td colspan="6" align="left">
			<button type="button" id="deleteBtn">삭제하기</button>
		</td>
	</tr>
</table>
<select name="search_category">
	<option value="선택">선택</option>
	<option value="작성자">작성자</option>
	<option value="제목">제목</option>
	<option value="내용">내용</option>
	<option value="작성일">작성일</option>
</select>

<input type="search" name="search_txt"><button type="button" id="searchBtn">검색</button>
</form>

<div class="pages">
<%for(int i = 1; i <= pages; i++){%>
	<a href="/TAMINO/AdminCtrl?command=QnAList&page<%=i %>" ><%=i %></a>
<%
}
%>
</div>

 --%>


<script type="text/javascript">
$(function () {
	
$("select[name=qna_category]").val("<%=qna_category %>").attr("selected", "selected");
	
	$("#searchBtn").click(function() {
		$("#qnalistfrm").attr("action", "/TAMINO/AdminCtrl").submit();
	});
	
	$("select[name=qna_category]").on("change", function () {
		/* alert("변경"); */
		$("#qnalistfrm").attr("action", "/TAMINO/AdminCtrl").submit();
	});
	
	$(".QnAtitle").click(function () {
		location.href = "/TAMINO/AdminCtrl?command=QnADetail&seq="+$(this).attr("seq");
	});
	
	$("input:checkbox[name='alldel']").change(function() {
		if($("input:checkbox[name='alldel']").is(":checked")){
			//alert("체크");
			$("input:checkbox[name='delcheck']").each(function () {
				$(this).prop("checked", true);
			});
		}else{
			//alert("체크 해제");
			$("input:checkbox[name='delcheck']").each(function () {
				$(this).prop("checked", false);
			});
		}
	});
	
	$("#deleteBtn").click(function () {
		var checklen = $("input:checkbox[name='delcheck']:checked").length;
		console.log(checklen);
		if(checklen == 0 ){
			alert("선택된 항목이 없습니다.");
			return;
		}else{
			
			var dels = new Array();
			$("input:checkbox[name='delcheck']").each(function () {
				if($(this).is(":checked")){
					dels.push($(this).val());	
				}
				
			});
			
			var delslist = "";
			for(i=0; i<dels.length; i++){
				
				if(i == dels.length-1){
					delslist += dels[i];
				}else{
					delslist += dels[i] + ",";
				}
			}
			
			$.ajax({
				type: 'get',
				url: '/TAMINO/AdminCtrl?command=deleteQnA',
				datatype : 'json',
				data: {"delslist" : delslist},
				success: function ( data ) {
					//alert("성공");
					if(data.trim() === "ok"){
						location.href = "/TAMINO/AdminCtrl?command=QnAList";
					}
					
				},
				error: function () {
					alert("에러");
				}
			})
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
	
	
});

</script>

</body>
</html>