<%@page import="dto.MemberDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.OrderListDto"%>
<%@page import="java.util.Arrays"%>
<%@page import="util.UtilityClass"%>
<%@page import="dto.ProductDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
MemberDto logindto = (MemberDto)session.getAttribute("login");

ProductDto dto = (ProductDto)request.getAttribute("detail");
String fileName[] = dto.getProductImage().split(",");
System.out.println("디테일 jsp : " + Arrays.toString(fileName));

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR|Roboto|Roboto+Mono|Viga&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/TAMINO/Store/css/Product_Detail.css">
<link rel="stylesheet" href="/TAMINO/Store/css/MyPageOverlay.css">
<style type="text/css"></style>
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
<div class="super_container">
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



	<div class="detailbox">
		<div class="product-wrapper"> <!-- 슬라이드 쇼 전체 다이브 -->
		<!-- Slideshow Container -->
			<div class="slideshow-container">
			
				<% for(int i = 0; i < fileName.length; i++){
					if(!fileName[i].equals(" ")){%>
					<div class="slides fade">
						<img src="/TAMINO/product/<%=fileName[i].trim() %>" width="100%" height="100%">
					</div>
				<%
					}
				}
				 %>
				
				<a class="prev" onclick="plusSlides(-1)">&#10094;</a>
				<a class="next" onclick="plusSlides(1)">&#10095;</a>
			</div>
			
		<br>
		
			<div style="text-align: center;">
			
				<% for(int i = 0; i < fileName.length; i++){
					if(!fileName[i].equals(" ")){%>
					<span class="dot" onclick="currentSlide(<%=i + 1 %>)"></span>
				<%
					}
				}
				 %>
				 
			</div>
		</div>
		
		<form id="detailfrm">
		<input type="hidden" name="command" value="addCart">
		<input type="hidden" name="product_seq" value="<%=dto.getSeq() %>">
		<input type="hidden" name="product_code" value="<%=dto.getCode() %>">
		<input type="hidden" name="product_name" value="<%=dto.getProductName() %>">
		<input type="hidden" name="product_price" value="<%=dto.getPrice() %>">
		<input type="hidden" name="product_image" value="<%=dto.getProductImage() %>">
		<div class="product-detail">
			<!-- <div id="product_title">Flames Hoodie</div> -->
			<h2><%=dto.getProductName() %></h2>
			<h4><%=UtilityClass.PriceConvert(dto.getPrice()) %>won</h4> <br>
			
			<%if(dto.getCode().equals("의류")){%>
				<div class="sizeselect" style="margin-bottom: 10px;">
				<span style="font-size: 9pt">SIZE</span>&nbsp;&nbsp;&nbsp;
				<select name="product_size" style="height: 30px; width: 100px;">
					<option value="S">S</option>
					<option value="M">M</option>
					<option value="L">L</option>
				</select>
				</div>
			<%
			}
			%>
			
			
			<div class="quantitydiv" style="margin-bottom: 20px;">
			<span style="font-size: 9pt">QUANTITY</span>&nbsp;&nbsp;&nbsp;
				<!-- <input type="number" min="1" max="50" style="height: 30px; width: 100px;"><br> -->
				<input type="text" id="quantity" name="product_count" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" value=1>&nbsp;&nbsp;&nbsp;
				<button type="button" id="minusBtn" class="plusminusbtn">-</button>
				<button type="button" id="plusBtn" class="plusminusbtn">+</button>
			</div>
		</form>	
			<button type="button" class="moreinfo">more information</button>
				<div class="info">
					<p><%=dto.getProductExplain() %></p>
				</div>
			
			<button type="button"  id="addcart" class="cartBtn">ADD TO CART</button>
			</div>
		

</div>

<div class="qnadiv" align="center">
	<iframe class="qnaiframe" src="/TAMINO/StoreCtrl?command=QnAList&product_seq=<%=dto.getSeq() %>" style="height: 500px;"></iframe>
</div>

<div id="myNav" class="overlay">
<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
	<div class="overlay-content">
		<p>MY PAGE</p>
    	<a href="/TAMINO/MemberCtrl?command=myInfo&email=<%=currId %>">회원정보 수정</a>
    	<a href="/TAMINO/MemberCtrl?command=MyOrderList">주문내역</a>
  	</div>

</div>

<div class="footer">
	<a href="http://instagram.com/taminoamir" target="_blank"><img src="/TAMINO/image/instagram.png" width="30px" height="30px"></a>
	<a href="https://twitter.com/taminoamir" target="_blank"><img src="/TAMINO/image/twitter.png" width="30px" height="30px"></a>
	<a href="https://www.facebook.com/taminoamir/?ref=br_rs" target="_blank"><img src="/TAMINO/image/facebook.png" width="30px" height="30px"></a>
	<a href="https://www.youtube.com/channel/UCzoO5qFoT-7w7o7f1QqhOpA" target="_blank"><img src="/TAMINO/image/youtube.png" width="30px" height="30px"></a>
</div>

<script type="text/javascript">

$(function () {
	if($("#currId").val() != "guest"){
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
	
	$(".plusminusbtn").click(function() {
		var quantity = parseInt($("#quantity").val());

		if($(this).text() == "-"){
			$("#quantity").val(quantity - 1);
			
			if(parseInt($("#quantity").val()) <= 0){
				alert("최소 수량은 1개 입니다");
				$("#quantity").val(1);
			
			}
		}else if($(this).text() == "+"){
			$("#quantity").val(quantity + 1);
			if(parseInt($("#quantity").val()) > 10){
				alert("1인 당 최대 10개 까지 구매 가능합니다");
				$("#quantity").val(10);
			}
		}
	});
	
	$("#quantity").focusout(function() {
		
		if(parseInt($("#quantity").val()) <= 0){
			alert("최소 수량은 1개 입니다");
			$("#quantity").val(1);
		
		}else if(parseInt($("#quantity").val()) > 10){
			alert("1인 당 최대 10개 까지 구매 가능합니다");
			$("#quantity").val(10);
			
		}
	});
	
	$("#addcart").click(function () {
		
		if($("#currId").val() == "guest"){/* 로그인 하지 않은 경우 */
			alert("장바구니는 로그인 후 이용 가능합니다.");
			location.href = "/TAMINO/MemberCtrl?command=login";
			return;
		}
		
		var formData = $("#detailfrm").serialize();
		
			$.ajax({
				type: 'post',
				url: '/TAMINO/StoreCtrl?command=addCart',
				data: formData, 
				datatype : 'json',
				success: function () {
					var result = confirm("장바구니 추가 완료. 확인하시겠습니까?");
					if(result){
						location.href = "/TAMINO/StoreCtrl?command=goCart";
					}
				},
				error: function () {
					alert("에러");
				}
			})
	});
});

</script>
<script>
var slideIndex = 1;
showSlides(slideIndex);

function plusSlides(n){
	showSlides(slideIndex += n);
}

function currentSlide(n){
	showSlides(slideIndex = n);
}

function showSlides(n){
	var i;
	var slides = document.getElementsByClassName("slides");
	var dots = document.getElementsByClassName("dot");
	
	if(n > slides.length){
		slideIndex = 1;
	}
	if(n < 1){
		slideIndex = slides.length;
	}
	
	for(i = 0; i < slides.length; i++){
		slides[i].style.display = "none";
	}
	for(i = 0; i < dots.length; i++){
		dots[i].className = dots[i].className.replace(" active", "");
	}
	
	slides[slideIndex-1].style.display = "block";
	dots[slideIndex-1].className += " active";
	
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
<script src="/TAMINO/Store/accordion.js"></script>
</body>
</html>