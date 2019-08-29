<%@page import="dto.MemberDto"%>
<%@page import="util.UtilityClass"%>
<%@page import="dto.ProductDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
List<ProductDto> list = (List<ProductDto>)request.getAttribute("list");
if(list.size() != 0){
	System.out.println("리스트 넘어옴");
	System.out.println(list.get(0).toString());
}else{
	System.out.println("리스트 없음");
}
int pages = (int)request.getAttribute("page");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="/TAMINO/Store/css/Store_List.css">
<link rel="stylesheet" href="/TAMINO/Store/css/MyPageOverlay.css">
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR|Roboto|Roboto+Mono|Viga&display=swap" rel="stylesheet">
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


<div class="productlist_container">
		<div class="productlist">
		<%if(list.size() == 0 || list == null){%>
			<h1 align="center">COMING SOON</h1>
		<%	
		}else{
		
			for(int i = 0; i < list.size(); i++){
				ProductDto dto = list.get(i);
				System.out.println(dto.toString());
				int index = dto.getProductImage().indexOf(",");
						
				String filename = dto.getProductImage().substring(0, index);
				String price = UtilityClass.PriceConvert(dto.getPrice());
			%>
			<div class="product" seq="<%=dto.getSeq() %>" pname="<%=dto.getProductName() %>">
				
				<a class="thumnail"><img alt="" src="/TAMINO/product/<%=filename %>" style="width: 400px; height: 400px" ></a>
				<div class="productinfo">
					<span><%=dto.getProductName() %></span><br><br>
					<span><%=price %>won</span>			
				</div>
			</div>
			<%
			}
		}
		%>
		
	</div> 
		
</div>

<div class="pages">
<%for(int i = 1; i <= pages; i++){%>
	<a href="/TAMINO/StoreCtrl?command=ProductList&accesory=clothing&page=<%=i %>"><%=i %></a>
<%
}
%>
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
	<a href="http://instagram.com/taminoamir" target="_blank"><img src="/TAMINO/image/instagram.png" style="width: 30px; height: 30px;"></a>
	<a href="https://twitter.com/taminoamir" target="_blank"><img src="/TAMINO/image/twitter.png" style="width: 30px; height: 30px;"></a>
	<a href="https://www.facebook.com/taminoamir/?ref=br_rs" target="_blank"><img src="/TAMINO/image/facebook.png" style="width: 30px; height: 30px;"></a>
	<a href="https://www.youtube.com/channel/UCzoO5qFoT-7w7o7f1QqhOpA" target="_blank"><img src="/TAMINO/image/youtube.png" style="width: 30px; height: 30px;"></a>
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
	
	$(".product").click(function() {
		location.href = "/TAMINO/StoreCtrl?command=ProductDetail&seq=" + $(this).attr("seq");
	});
});

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