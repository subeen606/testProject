
<%@page import="dto.MemberDto"%>
<%@page import="dto.NewsDto"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>newsdetail</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=DM+Serif+Text|Roboto+Condensed&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/TAMINO/News/Navibar.css?after">
<style type="text/css">
body{
background-color: black;
}

#box1{/* 가장큰 div */
overflow:hidden;
width: 60%;
height:auto;
margin: 0 auto;
margin-top: 200px;
margin-bottom: 50px;
padding-bottom: 50px;
border: solid 2px;
border-color: red;
}

#box2{/* 기사 사진 제목 포함 div*/
overflow:hidden;
width: 1100px;
height:auto;
margin: 0 auto;
margin-top: 50px;
margin-bottom: 50px;
padding-bottom: 50px;
/* border: solid 2px;
border-color: blue; */
}
.type01{
width: 100%;
}
#tex{
padding: 50px;
font-size: 18px; 
}
.news_img{
width: 500px;
}
#title{
font-size: 40px;
}
#back{
font-size: 30px;
}
/* 다른 뉴스 보기 */
#box3{
text-align:center;
overflow:hidden;
width: 1100px;
height:auto;
margin: 0 auto;
margin-top: 50px;
margin-bottom: 50px;
padding-bottom: 50px;
/* border: solid 2px;
border-color: yellow; */

}

.box4 {
float:left; /* 옆으로 붙게 */
width:360px;
height: 550px;
/* border-color: gray;
 */
 cursor: pointer;
}
   
.box5 {
overflow:hidden;
height : 500px;
position: relative;
float: left;
margin:20px;
/* border: solid 7px;
border-color: green; */
background-color: white;

}
.news_img2{ 
width: 100%;
height: 55%;
}   
p{
color: white;
}
#morenews{
color: white;
}


/* 미니 메뉴바 부분 */
.minimenu{
width:300px;
/* border: solid; */
text-align: center;
margin: auto;
}
#photo{
float: left;
font-size: 40px;
color: red;
}
#video{
font-size: 40px;
color: white;
cursor: pointer;
}
a{ 
text-decoration:none 
}
hr{
border-color: red;
background-color: red;
}
.text{
padding-left: 10px;
padding-right: 10px;
}

</style>

</head>
<body>

    
<%

Object ologin = session.getAttribute("login");
MemberDto mdto = null;
mdto = (MemberDto)ologin;

NewsDto dto = (NewsDto)request.getAttribute("dto");

List<NewsDto> list = (List<NewsDto>)request.getAttribute("detaillist");

List<NewsDto> flist = (List<NewsDto>)request.getAttribute("fdetaillist");
%>
<div class="header" style="background-color: rgba(255,255,255,0.5)">
		<div class="header_container">
			<div class="header_content">
				<div class="logo">
						<a href="/TAMINO/AdminCtrl?command=Main_Page"><img src="/TAMINO/image/logo.png"></a>
				</div>
				
				<div class="navbar">
						<a href="/TAMINO/newscontrol?command=list">NEWS</a>
						<a href="/TAMINO/ScheduleCtrl?command=schedule">SCHEDULE</a>
						<a href="/TAMINO/StoreCtrl?command=StoreMain">STORE</a>
						<%
							if(mdto != null){
								%>
								<a href="/TAMINO/MemberCtrl?command=logout">LOGOUT</a>
								<%
							}
							else{
								%>
								<a href="/TAMINO/MemberCtrl?command=login">LOGIN</a>
								<%								
							}
						%>
						
				</div>
				
			</div>
		</div>
	
</div>


<div id="box1">
<div class="minimenu"><div class="menu" id="photo"><strong>Photos</strong></div><div class="menu" id="video"><strong>Videos</strong></div></div>


<a href="/TAMINO/newscontrol?command=list"><p id="back"> < Back to News </p></a>  <!-- list로 가기 -->
<hr>
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
<th colspan="2"> 
<p id="tex" class="content" align="left"><%=dto.getContent() %></p>
</th>
</tr>
</table>

</div>

<br><br><br>

<div id="box3">

<h1 id="morenews">More News On Tamino</h1>
<br>
<hr>
<br>
<%
int j = list.size();
if(j>=3){
	for(int i = 0;i < 3; i++){
		NewsDto ndto = list.get(i);
		//글자수 자르기
			String txt = ndto.getContent();
			if(txt.length() >= 180){
			    txt = txt.substring(0,180)+"...";
			    }
			%> 
			<div class="box4">
			<div class="box5" _seq=<%=ndto.getNews_seq() %>>
				<img class="news_img2" src="./upload/<%=ndto.getFilename() %>">
				<div class="text">
					<h2><%=ndto.getTitle() %></h2>
					<p style="color: black;" align="left"><%=txt %></p><!-- 글자수 제한 -->
				 </div>
		  </div>
		  </div>
		<% 
		}
}else if(j<3){
	for(int i = 0;i < 3; i++){
		NewsDto fdto = flist.get(i);
		//글자수 자르기
			String txt = fdto.getContent();
			if(txt.length() >= 180){
			    txt = txt.substring(0,180)+"...";
			    }
		if(flist.size()>=3){
	%>
		<div class="box4"> 
		<div class="box5" _seq=<%=fdto.getNews_seq() %>>
			<img class="news_img2" src="./upload/<%=fdto.getFilename() %>">
			<div class="text">
				<h2><%=fdto.getTitle() %></h2>
				<p style="color: black;" align="left"><%=txt %></p><!-- 글자수 제한 -->
				
			 </div>
		</div>
		</div>	

	<%
		}
	}
}
%>	


</div>

</div>



<script type="text/javascript">

$(function () {
	
	$(".box5").mousedown(function() {
	//	alert("mousedown");
		location.href = "/TAMINO/newscontrol?command=detail&seq=" + $(this).attr("_seq");
	});
	$(".box5").mouseover(function() {		
		$(this).css("background", "#e0e0e0");
	});
	$(".box5").mouseout(function() {
		$(this).css("background", "#ffffff");
		
	});
	
	
	
	/* minimenu */
	$("#video").mouseover(function() {		
		$(this).css("color", "red");
	});
	$("#video").mouseout(function() {
		$(this).css("color", "white");
	});
	
	$("#video").mousedown(function() {
		location.href = "/TAMINO/newscontrol?command=videolist";
	});
	

});


</script>


</body>
</html>