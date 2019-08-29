
<%@page import="dto.ProductDto"%>
<%@page import="dto.NewsDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.ScheduleDto"%>
<%@page import="java.util.List"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Object ologin = session.getAttribute("login");
	MemberDto mdto = null;
	mdto = (MemberDto)ologin;
	
	List<ScheduleDto> sList = new ArrayList<>();
	List<NewsDto> nList = new ArrayList<>();
	List<ProductDto> pList = new ArrayList<>();
	
	sList = (List<ScheduleDto>)request.getAttribute("scheduleList");
	nList = (List<NewsDto>)request.getAttribute("newslist");
	pList = (List<ProductDto>)request.getAttribute("productlist");
	
	System.out.println("sList.size():"+sList.size()+", nList.size():"+nList.size()+", pList.size():"+pList.size());
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=DM+Serif+Text|Roboto+Condensed&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/TAMINO/Main/Navibar.css?after">
<style type="text/css">
body{
	/* background-image : url('/TAMINO/image/TAMINO_amir.jpg');
	background-repeat: no-repeat;
	background-size: cover; */
	margin: 0px;
	top:0;
	left:0;
	width: 100%; 
	font-family: 'Roboto Condensed', sans-serif;
	/*  font-family: 'Cutive Mono', monospace;  */
}
.backgroundImg{
	top:0;
	left:0;
	width: 100%;
	height: 100%;
	position:fixed;
	z-index: -1000;
}
.sideBar{
	background-color: rgba(0, 0, 0, 0.3);
}
.sideBar a{
	text-decoration: none;
	color: white;
	font-size: 30px;
	
}
.menubar a {
	text-decoration: none;
	color: white;
	font-size: 25px;
}
.loginbar a {
	text-decoration: none;
	color: white;
	font-size: 25px;
}
a:hover {
	font-weight: bold;
	color: #EA9A56;

}
button{
	border: 5px solid black;
}
button:hover{
	background-color: black;
	color: white;
	cursor: pointer;
}

.iconBox{
	opacity: 0.5;
}

.iconBox:hover {
	opacity: 1; 
	cursor: pointer;
}
</style>
</head>
<body>
<!-- background img -->
<div class="backgroundImg">
	<img alt="" src="/TAMINO/image/Tamino_Main.png" style="width: 100%; height: 100%;">
</div>

<!-- header -->
<div class="header" style="background-color: rgba(255,255,255,0.5)">
		<div class="header_container">
			<div class="header_content">
				<div class="logo">
						<a><img src="/TAMINO/image/logo.png"></a>
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




<!-- body -->
	<div style="width: 50%; height: 60%; left:25%; top:20%; position: absolute;" align="center">
		<img alt="" src="/TAMINO/image/Tamino_LikeAt.jpg" style="width: 100%; height: 100%;">
	</div>
	<div style="width: 50%; left: 25%; top: 80%; position: absolute; background-color: rgba(255,255,255,0.5)" align="center">
		<h2>Live at Ancienne Belgique</h1>
	</div>
	
	<div style="width: 100%; top:100%;  position: absolute;">
	
		<!-- Listen -->
		<div style="width: 100%; height: 350px; padding-top:6%; background-color: rgba(255,255,255,0.5)" align="center">
			<button type="button" style="width: 300px; height: 100px;" onclick="location.href='/TAMINO/Main/Main_Listen.jsp'"><h1>LISTEN</h1></button>
		</div>
		
		<!-- Sign Up -->
		<div style="width: 100%; height: 350px; padding-top:1%; background-color: rgba(255,255,255,0.6); color: rgba(0,0,0,0.6)" align="center">
			<h1 style="font-size: 50px;">WE WANT YOU TO HAVE IT ALL</h1>
			<h3>Join the mailing list to receive the latest music news, tour dates, and pre-sale</h3><h3>information.</h3>
			<button type="button" style="width: 150px; height: 60px;" onclick="location.href='/TAMINO/MemberCtrl?command=login'"><h3>SIGN UP</h3></button>
		</div>
		
		<!-- Tour Dates -->
		
		<div style="width: 100%; height: 1400px; padding-top:5%; background-color: rgba(255,255,255,0.7); color: rgba(0,0,0,0.7)" align="center">
			<h1 style="font-size: 50px;">UPCOMING SCHEDULE DATES</h1>
			<%

					if(sList.size()==0 || sList==null){
						%>
						<div style="width: 70%; height:100%; border-bottom:1px solid black; margin-top: 15%;" align="center" >
							<h1>등록된 일정이</h1>		
							<h1>존재하지 않습니다.</h1>
						</div>
						<%
					}
					else{
						for(int i=0; i<sList.size(); i++){
							if(i==3){
								break;
							}
						%>
						<div style="width: 70%; height:20%; border-bottom:1px solid black; margin-top: 10px" align="left">
							<div style="width: 20%;  display: inline-block; float: left;" >
							<h1><%=sList.get(i).getSchedule_date() %></h1>
							</div>
							<div style="width: 60%; display: inline-block; float: left">
							<h1><%=sList.get(i).getSchedule_place() %></h1>
							<h2><%=sList.get(i).getSchedule_title() %></h2>
							<%
								if(sList.get(i).getSchedule_content().length()>250){
									%>
									<h3><%=sList.get(i).getSchedule_content().substring(0,250) %></h3>
									<h3><%=sList.get(i).getSchedule_content().substring(250, sList.get(i).getSchedule_content().length()) %></h3>
									<% 
								}
								else{
									%>
									<h3><%=sList.get(i).getSchedule_content() %></h3>
									<%
								}
							%>
							</div>
							<div style="width: 20%;   display: inline-block; float: left" align="center">
							<button type="button" style="margin-top:21.440px; width: 150px; height: 75px;" onclick="window.open('<%=sList.get(i).getTicketLink()%>')"><h3>TICKETS</h3></button>
							</div>
						</div>
						<%
						}
						%>
						<button type="button" style="margin-top:5%; width: 300px; height: 100px;" onclick="location.href='/TAMINO/ScheduleCtrl?command=schedule'"><h1>VIEW MORE</h1></button>
						<%
					}
				
			%>
				
		</div> 
		<!-- LATEST NEWS -->
		<div style="width: 100%; height: 1200px; padding-top:4%; background-color: rgba(255,255,255,0.8); color: rgba(0,0,0,0.8)" align="center">
			<h1 style="font-size: 50px;">LATEST NEWS</h1>
			<%
					if(nList.size()==0 || nList==null){
						%>
						<div style="width: 70%; height:100%; border-bottom:1px solid black; margin-top: 15%;" align="center" >
							<h1>등록된 뉴스가</h1>		
							<h1>존재하지 않습니다.</h1>
						</div>
						<%
					}
					else{
						%>
						<div style="width: 70%; height:60%;  margin-top: 6%" align="center">
						<%
						for(int i=0; i<nList.size(); i++){
							if(i==3){
								break;
							}
						%>
							<div style="width: 30%; height:100%; display: inline-block; float: left;   margin: 0px 1% 0px 1%" >
								<div style="width: 100%; height: 45%;"align="center" >
									<img alt="" src="/TAMINO/upload/<%=nList.get(i).getFilename()%>" style="width: 100%;height: 100%;">
								</div>
								<div style="width: 100%; max-height: 20%; " align="center">
								<h2><%=nList.get(i).getTitle() %></h2>
								</div>
								<div style="width: 100%; max-height: 30%;">
									<%
									if(nList.get(i).getContent().length()>600){
										%>
										<%=nList.get(i).getContent().substring(0, 597) %>...
										<%
									}
									else{
										%>
										<%=nList.get(i).getContent() %>
										<%
									}
									%>
										
								</div>
								<div style="width: 100%; height: 5%" align="center">
									<h3><%=nList.get(i).getNews_date().substring(0,10) %></h3>
								</div>
								
							</div>
						<%
						}
						%>
						</div>
						<button type="button" style="margin-top:1%; width: 300px; height: 100px;" onclick="location.href='/TAMINO/newscontrol?command=list'"><h1>VIEW MORE</h1></button>
						<%
					}
			%>

		</div>
		<!-- Store -->
		<div style="width: 100%; height: 1000px; padding-top:2%; background-color: rgba(255,255,255,0.9); color: rgba(0,0,0,0.9)" align="center">
			<h1 style="font-size: 50px;">STORE</h1>
			<%
				if(pList.size()==0 || pList==null){
					%>
					<div style="width: 70%; height:100%; border-bottom:1px solid black; margin-top: 15%;" align="center" >
						<h1>등록된 상품이</h1>		
						<h1>존재하지 않습니다.</h1>
					</div>
					<%
				}
				else{
					%>
					<div style="width: 70%; height:40%;  margin-top: 4%" align="center">
						<%
						for(int i=0; i<pList.size();i++){
							if(i==4){
								break;
							}
							else{
								%>
								<div style="width: 22%; height:100%; display: inline-block; float: left;   margin: 0px 1% 0px 1%" >
								<img alt="" src="/TAMINO/product/<%=pList.get(i).getProductImage().split(",")[0] %>" style="width: 100%;height: 100%">
								</div>
								<%
							}
							
						}
						%>
					</div>
					<div style="width: 70%; max-height: 5%;" align="center"><h1>Get great products now!</h1></div>
					<button type="button" style="margin-top:3.5%; width: 300px; height: 100px;" onclick="location.href='/TAMINO/StoreCtrl?command=StoreMain'"><h1>SHOP NOW</h1></button>
					<%
				}
			%>
		</div>
		<!-- footer -->
		<div style="width: 100%; height: 400px; padding-top:2%; background-color: black; color: white" align="center">
			<h1 style="font-size: 50px;">TAMINO</h1>
			
			<div id="iconDiv" style="width: 15%; height:10%;  margin-top: 3%; margin-bottom: 3%;" align="center">
				<a style="margin-left: 15px; margin-right: 15px;" href="http://instagram.com/TAMINOamir" target="_blank"><img src="/TAMINO/image/instagrammain.png"  class="iconBox" style="width: 40px; height: 35px;"></a>
				<a style="margin-left: 0px; margin-right: 15px; " href="https://www.facebook.com/taminoamir/?ref=br_rs" target="_blank"><img src="/TAMINO/image/facebookmain.png"  class="iconBox" style="width: 40px; height: 35px;"></a>
				<a style="margin-left: 0px; margin-right: 15px; " href="https://twitter.com/taminoamir" target="_blank"><img src="/TAMINO/image/twittermain.png"  class="iconBox" style="width: 40px; height: 35px;"></a>
				<a style="margin-left: 0px; margin-right: 15px; " href="https://www.youtube.com/channel/UCzoO5qFoT-7w7o7f1QqhOpA" target="_blank"><img src="/TAMINO/image/youtubemain.png"  class="iconBox" style="width: 40px; height: 35px;"></a>
			</div>
			
			<h3>© 2019 Tamino. All Rights Reserved.</h3>
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
				$(".sideBar").css("width","18%");
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