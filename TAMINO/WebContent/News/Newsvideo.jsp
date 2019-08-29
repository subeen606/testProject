
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
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=DM+Serif+Text|Roboto+Condensed&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/TAMINO/News/Navibar.css?after">
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR|Roboto|Roboto+Mono|Viga&display=swap" rel="stylesheet">
<style type="text/css">
body{
 background-color: black; 
font-family: 'Roboto', sans-serif;
}

#box1{
overflow:hidden;
  width: 60%;
   height:auto;
   margin: 0 auto;
   margin-top: 200px;
   margin-bottom: 50px;
/*    padding-bottom: 50px;
  border: solid 2px; */
 border-color: red;  
padding-top: 100px;
}

#box2{
overflow:hidden;
  width: 1000px;
   height:auto;
   margin: 0 auto;
   margin-top: 50px;
   margin-bottom: 50px;
   padding-bottom: 50px;
/*   border: solid 2px;
 border-color: blue;  */
 text-align: center;

}
.box3 {

float:left; /* 옆으로 붙게 */
margin: 20px auto;
margin-left:10px;
margin-right:10px;
  width:480px;
  height:400px;
 
/*  border-color: gray;  */

}
.minititle{
text-shadow: -1px 0 #F2F1F6, 0 1px #F2F1F6, 1px 0 #F2F1F6, 0 -1px #F2F1F6;
-moz-text-shadow: -1px 0 #F2F1F6, 0 1px #F2F1F6, 1px 0 #F2F1F6, 0 -1px #F2F1F6;
-webkit-text-shadow: -1px 0 #F2F1F6, 0 1px #F2F1F6, 1px 0 #F2F1F6, 0 -1px #F2F1F6;
}
.imgDiv:hover{
filter:blur(3px);
-webkit-filter:blur(3px);
}
   /* 큰 video */
.bigbox{

 overflow:hidden;
 position: relative;
margin: 0 auto;
width: 100%;
height: 100%;
/*  border: solid 1px;
border-color: aqua; */
margin-bottom: 100px;
text-align: center;
}   
   

.content{
font-size: 20px;
color: white;
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
color: white;
cursor: pointer;
}

#video{
font-size: 40px;
color: #e77e4d;
}



#title{
color: white;
font-size: 30px;
}

.news_img{ /* 큰화면 video */
width: 100%;
height: 55%;
}


#load{
color: white;
font-size: 30px;

}

/* 이미지 올라가는 효과 */
  .imgBoxDiv{

      width: 475px;
      height: 375px;
      position: relative;
      cursor: pointer;
      overflow: hidden;
      box-shadow: 2px 2px 8px 0px #000;
    }
    .imgDiv{
      width: 100%;
      height: 100%;
      position: absolute;
      z-index:0;
      -webkit-transition:all .5s ease;
      transition: all .5s ease;
      bottom:0px;
      overflow: hidden;
     }

     .imgBoxDiv:hover .imgDiv{
       bottom: 60px;
     }

     .imgDescDiv{
      width: 99%; 
      height: 70px;
      padding-top:12px;
      margin-left:2px;
      color:black;
      z-index:-1;
      background: rgba(175,225,255,0.2);
      position: absolute;
      bottom:0px;
      font-size: 20px;
    }



/* 모달 */
  .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
           background-color: white;
           background-color: rgba( 255, 255, 255, 0.5 );
          
        }

        /* Modal Content/Box */
        .modal-content {
        	padding-top:100px;
            text-align:center;
            
            border: 1px solid #888;
         	width: 100%; /* Could be more or less, depending on screen size */ 
            height: 75%;
        }
        /* The Close Button */
        .close {
            color: black;
           
            font-size: 50px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: white;
            text-decoration: none;
            cursor: pointer;
        }

.captions{
	font-size: 30pt;
	margin-left: 3rem;
}


</style>

</head>
<body>

<%
List<NewsDto> list = (List<NewsDto>)request.getAttribute("newslist");
%> 

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

<form action="/TAMINO/AdminCtrl" method="post">
<input type="hidden" name="command" value="addvideo">



<div id="box1">

<div class="minimenu"><div class="menu" id="photo"><p class="captions">PHOTOS</p></div><div class="menu" id="video"><p class="captions">VIDEOS</p></strong></div></div>

<div id="box2">

<!-- video첫번째칸 -->
<div class="bigbox">
<% NewsDto fdto = list.get(0); 
	if(fdto.getDel() == 0){  
%>	
 <!-- Trigger/Open The Modal -->
    <div><%=fdto.getContent() %></div>
    
 	<p id="title"><%=fdto.getTitle() %></p>
<% } %>
</div>	<!-- bigbox -->

<%
for(int i = 1;i < list.size(); i++){
	NewsDto dto = list.get(i);
		if(dto.getDel() == 0){  
		%>	
<div class="box3" style="display: none;">
 <!-- Trigger/Open The Modal -->
    <a class="btn">
	    <div class="imgBoxDiv">
	    <div class="imgDiv">
	    	<img src="./upload/<%=dto.getFilename() %>" width="475" height="375" alt="">
	    </div>
	    <div class="imgDescDiv"><p class="minititle"><%=dto.getTitle() %></p></div>
	    </div>
    </a>
 	

    
    <!-- The Modal -->
<div class="modal">    
    <div class="modal-content">
      <!-- Modal content -->
        <span class="close">&times;</span>                                                               
        <p><%=dto.getContent() %></p>
    </div>
</div>	  
	</div>  <!-- box3 -->   
	<% 
	}
}
%>	

</div>	<!-- div2 -->

<div align="center">
<a href="#" id="load">View More Videos</a>
</div>

</div>  <!-- div1 -->

</form>



   


<script type="text/javascript">

//Modal을 가져옵니다.
var modals = document.getElementsByClassName("modal");                       
//Modal을 띄우는 클래스 이름을 가져옵니다.
var btns = document.getElementsByClassName("btn");
//Modal을 닫는 close 클래스를 가져옵니다.
var spanes = document.getElementsByClassName("close");
var funcs = [];

//Modal을 띄우고 닫는 클릭 이벤트를 정의한 함수
function Modal(num) {
return function() {
 // 해당 클래스의 내용을 클릭하면 Modal을 띄웁니다.
 btns[num].onclick =  function() {
     modals[num].style.display = "block";
     console.log(num);
 };

 // <span> 태그(X 버튼)를 클릭하면 Modal이 닫습니다.
 spanes[num].onclick = function() {
     modals[num].style.display = "none";
 };
};
}

//원하는 Modal 수만큼 Modal 함수를 호출해서 funcs 함수에 정의합니다.
for(var i = 0; i < btns.length; i++) {
funcs[i] = Modal(i);
}

//원하는 Modal 수만큼 funcs 함수를 호출합니다.
for(var j = 0; j < btns.length; j++) {
funcs[j]();
}

//Modal 영역 밖을 클릭하면 Modal을 닫습니다.
window.onclick = function(event) {
if (event.target.className == "modal") {
   event.target.style.display = "none";
}
};


$(function () {
		
	
	$("#photo").mouseover(function() {		
		$(this).css("color", "#e77e4d");
	});
	$("#photo").mouseout(function() {
		$(this).css("color", "white");
	});
	
	$("#photo").mousedown(function() {
		location.href = "/TAMINO/newscontrol?command=list";
	});
	
});



$(function () { /* 갯수대로 자르기 */

	$(".box3").slice(0,4).show();
	$("#load").click(function(e) {
		e.preventDefault();
		$(".box3:hidden").slice(0,4).show();
		
		if($(".box3:hidden").length==0){
			$("#load").hide();
		}
	});
});
</script>



</body>
</html>