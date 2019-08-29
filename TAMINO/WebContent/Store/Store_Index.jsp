<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="/TAMINO/Store/css/Store_Index.css?after">
<link rel="stylesheet" href="/TAMINO/Store/css/MyPageOverlay.css">
<link href="https://fonts.googleapis.com/css?family=DM+Serif+Text|Roboto+Condensed&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:100,300,400|Roboto|Roboto+Mono|Viga&display=swap" rel="stylesheet">
</head>
<body>
<%
	String currId = "guest";
	if( request.getSession().getAttribute("login") != null ){
		MemberDto loginDto = (MemberDto)request.getSession().getAttribute("login");
		currId = loginDto.getEmail();
	}
%>
<input type="hidden" value="<%=currId %>" id="currId"> 
<div class="header">
		<div class="header_container">
			<div class="header_content">
				<div class="logindiv">
						<a id="cart"><img src="/TAMINO/image/cart.png" width="20px" height="20px"></a>
						<a id="login" href="/TAMINO/MemberCtrl?command=login">LOGIN</a>
						<a id="mypage" onclick="openNav()">MY PAGE</a>
				</div>
				<div class="logo">
						<a href="/TAMINO/StoreCtrl?command=StoreMain"><img src="/TAMINO/image/storelogo.png"></a>
				</div>
				
				<div class="navbar">
						<a href="/TAMINO/StoreCtrl?command=ProductList&category=all">ALL</a>
						<a href="/TAMINO/StoreCtrl?command=ProductList&category=clothing">CLOTHIING</a>
						<a href="/TAMINO/StoreCtrl?command=ProductList&category=accsesory">ACCESORIES</a>
						<a href="/TAMINO/StoreCtrl?command=ProductList&category=vinyl">VINYL</a>
						<a href="/TAMINO/StoreCtrl?command=ProductList&category=etc">ETC</a>
				</div>
				
			</div>
		</div>
	
</div>

<div id="myNav" class="overlay">
<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
	<div class="overlay-content">
		<p>MY PAGE</p>
    	<a href="/TAMINO/MemberCtrl?command=myInfo&email=<%=currId %>">회원정보 수정</a>
    	<a href="/TAMINO/MemberCtrl?command=MyOrderList">주문내역</a>
  	</div>

</div>


<div class="slideshow-container">

<div class="mySlides fade">
  <img src="/TAMINO/image/home1.jpg" style="width:100%">
  <div class="text">THE DEBUT ALBUM 'AMIR' IS OUT NOW</div>
</div>

<div class="mySlides fade">
  <img src="/TAMINO/image/home2.jpg" style="width:100%">
  <div class="text">LISTEN 'Cigar'</div>
</div>

<div class="mySlides fade">
  <img src="/TAMINO/image/home3.jpg" style="width:100%">
  <div class="text">The new 'Sound of the Nile'</div>
</div>

<div class="mySlides fade">

  <img src="/TAMINO/image/home4.jpg" style="width:100%">
  <div class="text">All eyes on Tamino</div>
</div>

</div>
<br>

<div class="footer">
	<a href="http://instagram.com/taminoamir" target="_blank"><img src="/TAMINO/image/instagram.png" style="width: 30px; height: 30px;"></a>
	<a href="https://twitter.com/taminoamir" target="_blank"><img src="/TAMINO/image/twitter.png" style="width: 30px; height: 30px;"></a>
	<a href="https://www.facebook.com/taminoamir/?ref=br_rs" target="_blank"><img src="/TAMINO/image/facebook.png" style="width: 30px; height: 30px;"></a>
	<a href="https://www.youtube.com/channel/UCzoO5qFoT-7w7o7f1QqhOpA" target="_blank"><img src="/TAMINO/image/youtube.png" style="width: 30px; height: 30px;"></a>
</div>


<script type="text/javascript">
$(function () {
	if($("#currId").val() != "guest"){
		//alert($("#login").attr("href"));
		$("#login").text("LOGOUT");
		$("#login").attr("href", "/TAMINO/MemberCtrl?command=logout");
		$("#mypage").css("display", "block");
	}
	
	$("#cart").click(function() {
		if($("#currId").val() == "guest"){/* 로그인 하지 않은 경우 */
			alert("장바구니는 로그인 후 이용 가능합니다.");
			

		}else{
			$("#cart").attr("href", "/TAMINO/StoreCtrl?command=goCart");
		}
	});
});
</script>

<script>
var slideIndex = 0;
showSlides();

function showSlides() {
  var i;
  var slides = document.getElementsByClassName("mySlides");

  for (i = 0; i < slides.length; i++) {
    slides[i].style.display = "none"; 
  }
  slideIndex++;
  if (slideIndex > slides.length) {slideIndex = 1} 
 
  slides[slideIndex-1].style.display = "block"; 

  setTimeout(showSlides, 3000); // Change image every 2 seconds
}
</script>

<script>
function openNav() {
  document.getElementById("myNav").style.width = "100%";
}

function closeNav() {
  document.getElementById("myNav").style.width = "0%";
}
</script>
     


<script src="/TAMINO/Store/scrollevent.js"></script>
</body>
</html>