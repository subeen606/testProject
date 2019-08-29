
<%@page import="dto.MemberDto"%>
<%@page import="dto.NewsDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <% 
	Object ologin = session.getAttribute("login");
	MemberDto mdto = null;
	mdto = (MemberDto)ologin;
 %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>News</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=DM+Serif+Text|Roboto+Condensed&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR|Roboto|Roboto+Mono|Viga&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/TAMINO/News/Navibar.css?after">
<style type="text/css">
body{
background-color: black;
font-family: 'Roboto', sans-serif;
}

#box1{
overflow:hidden;
  width: 1200px;
   height:auto;
   margin: 0 auto;
   margin-top: 200px;
   margin-bottom: 50px;
   padding-bottom: 50px;
/*   border: solid 2px;
 border-color: red;  */
padding-top: 100px;
}

#box2{
overflow:hidden;
  width: 1100px;
   height:auto;
   margin: 0 auto;
   margin-top: 50px;
   margin-bottom: 50px;
   padding-bottom: 50px;
/*  border: solid 2px;
 border-color: blue; */


}


.box3 {
float:left; /* 옆으로 붙게 */
  width:360px;
  height: 550px;
  cursor: pointer;
/*  border-color: gray; */
   }
   
   .box4 {
   background-color: white;
   overflow:hidden;
   height : 500px;
 position: relative;
 float: left;
 margin:20px;
/*   border: solid 7px;
 border-color: green; */
   }
   
.box4 {
  transform: scale(1);
  -webkit-transform: scale(1);
  -moz-transform: scale(1);
  -ms-transform: scale(1);
  -o-transform: scale(1);
  transition: all 0.3s ease-in-out;   /* 부드러운 모션을 위해 추가*/
}
.box4:hover {
  transform: scale(1.1);
  -webkit-transform: scale(1.1);
  -moz-transform: scale(1.1);
  -ms-transform: scale(1.1);
  -o-transform: scale(1.1);
}   
   

.news_img{ 
width: 100%;
height: 55%;
}

.text{
padding-left: 10px;
padding-right: 10px;
}


#load{
color: white;
font-size: 30px;

}


/* 미니 메뉴바 부분 */
.minimenu{
width:300px;
border: solid;
text-align: center;
margin: auto;
}

#photo{
float: left;
font-size: 40px;
color: #e77e4d;

}

#video{
font-size: 40px;
color: white;
cursor: pointer;
}

.captions{
	font-size: 30pt;
	margin-left: 3rem;
}

</style>


</head>
<body>

<!-- header -->
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

 <!-- 로그인정보 불러오기 만들기 -->

<%
List<NewsDto> list = (List<NewsDto>)request.getAttribute("newslist");
%> 




<form action="/TAMINO/AdminCtrl" method="post">
<input type="hidden" name="command" value="write">

<div id="box1">

<div class="minimenu"><div class="menu" id="photo"><p class="captions">PHOTOS</p></div><div class="menu" id="video"><p class="captions">VIDEOS</p></div></div>

<div id="box2">

<%

for(int i = 0;i < list.size(); i++){
	NewsDto dto = list.get(i);
			//글자수 자르기
			String txt = dto.getContent();
			if(txt.length() >= 180){
			    txt = txt.substring(0,180)+"...";
			    }
		if(dto.getDel() == 0){  
			
		%>
		
		
		<div class="box3" style="display: none;">
		<div class="box4" seq=<%=dto.getNews_seq() %>>
			<img class="news_img" src="./upload/<%=dto.getFilename() %>">
			<div class="text">
				<h2><%=dto.getTitle() %></h2>
				<p><%=txt %></p><!-- 글자수 제한 -->
				
			 </div>
			 
			
	  </div>
	  </div>
	  
	   
	 
	<% 
	}
}
%>	

</div>

<div align="center">
<a href="#" id="load">View More Photos</a>
</div>

</div>



</form>




<script type="text/javascript">

$(function () {
	
	$(".box4").mousedown(function() {
	//	alert("mousedown");
		location.href = "/TAMINO/newscontrol?command=detail&seq=" + $(this).attr("seq");
	});
	
	$(".box4").mouseover(function() {		
		$(this).css("background", "#e0e0e0");
	});
	$(".box4").mouseout(function() {
		$(this).css("background", "#ffffff");
		
	});
	
	
	$("#video").mouseover(function() {		
		$(this).css("color", "#e77e4d");
	});
	$("#video").mouseout(function() {
		$(this).css("color", "white");
	});
	
	$("#video").mousedown(function() {
		location.href = "/TAMINO/newscontrol?command=videolist";
	});
	
});


$(function () {

	$(".box3").slice(0,6).show();
	$("#load").click(function(e) {
		e.preventDefault();
		$(".box3:hidden").slice(0,6).show();
		
		if($(".box3:hidden").length==0){
			$("#load").hide();
		}
	});
});
</script>


</body>
</html>



