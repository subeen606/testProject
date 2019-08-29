
<%@page import="java.text.DecimalFormat"%>
<%@page import="dto.MemberDto"%>
<%@page import="dto.OrderListDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
MemberDto logindto = (MemberDto)session.getAttribute("login");
	String currId = "guest";
	if( request.getSession().getAttribute("login") != null ){
		MemberDto loginDto = (MemberDto)request.getSession().getAttribute("login");
		currId = loginDto.getEmail();
	}

%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
body{
font-family: 'Open Sans', sans-serif;
width:100%; 
text-align:left;
background-size: 100%;
background-repeat: no-repeat;
}
#box1{
	  width: 60%;
	    height:auto;
	   margin: 0 auto;
	   margin-top: 200px;
	   margin-bottom: 100px;
	   padding-bottom: 200px;
/* 	 border: solid 1px;
	 border-color: red; */
	}


.table1 {
	width: 80%;
    border-top: 1px solid #6C6C6C;
    border-collapse: collapse;
}
th, td {
    border-bottom: 1px solid #6C6C6C;
     padding: 10px; 
}


.newbtn{
margin-top:15px;
width:300px;
height:50px;
font-size:1.5em;
background-color: black;
color: white;
border: none;
font-family: 'Noto Sans KR', sans-serif;
}

#table1 td{
text-align: right;
}

.item{
height: 150px;
width: 150px;
}
#title1{
color: white;
background-color: #212121;
}
#title2{
background-color: #EAEAEA;
}
.steptext{
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 11pt;
}

</style>

 

<!-- 네비게이션바 -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="/TAMINO/Store/css/Store_List.css">
<link rel="stylesheet" href="/TAMINO/Store/css/MyPageOverlay.css">
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR|Roboto|Roboto+Mono|Viga&display=swap" rel="stylesheet">


</head>
<body>

<!-- 네비게이션바 -->
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


<script src="/TAMINO/Store/scrollevent.js"></script>


<%
List<OrderListDto> list = (List<OrderListDto>)request.getAttribute("orderlist");
String today = (String)request.getAttribute("_today");
today = today.substring(0, 8);
%>

<div id="box1">	<!-- 전체 div -->

<img height="250px" width="100%" src="/TAMINO/image/shop.jpg">


<br><br><br>
<h3></h3>
<h2 align="center">주문/결제가 완료되었습니다</h2>
<br><br>
<div id="box2" align="right">
<pre class="steptext">01장바구니>02주문/결제><strong>03주문완료</strong> </pre>
</div>


<%
DecimalFormat df = new DecimalFormat("###,###");  //
int sum = 0;
for(int i = 0;i < list.size(); i++){
	OrderListDto dto = list.get(i);
	int price = dto.getProduct_price();
	int countitem = dto.getProduct_count();
	sum = sum + price*countitem;

}
int allsum = sum+2500;

String _sum = df.format(sum);	//
String _allsum = df.format(allsum);	//
%>


<h3>주문상품 정보</h3>
<hr>

<div align="center">

<table class="table1">
<col width="150"><col width="450">
	
	<tr id="title1"><td colspan="2"> <%=today %></td></tr>
 	<%
	System.out.println("Store_OrderResult.jsp 넘어온 list길이"+list.size());
	for(int i = 0;i < list.size(); i++){
		OrderListDto dto = list.get(i);
		String image[] = dto.getProduct_image().split(",");
		String _price = df.format(dto.getProduct_price());	//
		%>
	<tr><th rowspan="3"><img src="/TAMINO/product/<%=image[0]%>" class="item"> </th><td><%=dto.getProduct_name() %></td></tr>
	<tr><td>[옵션]사이즈:<%=dto.getProduct_size() %></td></tr>
	<tr><td><%=_price %>원/ <%=dto.getProduct_count() %>개</td></tr>
	<%
	}
	%> 
	
	
</table>

</div> 





<div align="center">
<table class="table1" id="title2">
<col width="50%"><col width="25%"><col width="25%">
	<tr>
	<th rowspan="2"></th><th>상품가격</th><td><%=_sum %>원</td>
	</tr>
	
	<tr>
	<th>배송비</th><td>2,500원</td>
	<tr>
	
	<tr>
	<th colspan="2" ><h2>총 주문금액</h2></th><td><h2><%=_allsum %>원</h2></td>
	</tr>
</table>
</div>
<br><br>






<div align="center">
<button class="newbtn">Shop 홈으로</button>
</div>
<!-- <button class="btn">나의 주문내역</button>  --> <!-- 확인용 연결후 지우기 -->
</div><!-- 전체 div -->


<br>

<div id="myNav" class="overlay">
<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
	<div class="overlay-content">
		<p>MY PAGE</p>
    	<a href="/TAMINO/MemberCtrl?command=myInfo&email=<%=currId %>">회원정보 수정</a>
    	<a href="/TAMINO/MemberCtrl?command=MyOrderList">주문내역</a>
  	</div>

</div>

<!-- footer -->
<div class="footer">
	<a href="http://instagram.com/taminoamir" target="_blank"><img src="/TAMINO/image/instagram.png" style="width: 30px; height: 30px;"></a>
	<a href="https://twitter.com/taminoamir" target="_blank"><img src="/TAMINO/image/twitter.png" style="width: 30px; height: 30px;"></a>
	<a href="https://www.facebook.com/taminoamir/?ref=br_rs" target="_blank"><img src="/TAMINO/image/facebook.png" style="width: 30px; height: 30px;"></a>
	<a href="https://www.youtube.com/channel/UCzoO5qFoT-7w7o7f1QqhOpA" target="_blank"><img src="/TAMINO/image/youtube.png" style="width: 30px; height: 30px;"></a>
</div>





<script type="text/javascript">


$(function () {
	$(".newbtn").mousedown(function() {
		//	alert("mousedown");
			location.href = "/TAMINO/StoreCtrl?command=StoreMain";
		});
	$(".newbtn").mouseover(function() {		
		$(this).css("background", "#AAABD3");
	});
	$(".newbtn").mouseout(function() {		
		$(this).css("background", "black");
	});
	$(".btn").mousedown(function() {
		//	alert("mousedown");
			location.href = "/TAMINO/StoreCtrl?command=MyOrderList";
		});

});


</script>

<script type="text/javascript">
$(function () {
	if($("#currId").val() != "guest"){
		//alert($("#login").attr("href"));
		$("#login").text("LOGOUT");
		$("#login").attr("href", "/TAMINO/StoreCtrl?command=logout");
		$("#mypage").css("display", "block");
	}
	
	$("#cart").click(function() {
		if($("#currId").val() == "guest"){/* 로그인 하지 않은 경우 */
			alert("장바구니는 로그인 후 이용 가능합니다.");
			
			//location.href = "/TAMINO/StoreCtrl?command=login";
		}else{
			$("#cart").attr("href", "/TAMINO/StoreCtrl?command=goCart");
		}
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
     
</body>
</html>