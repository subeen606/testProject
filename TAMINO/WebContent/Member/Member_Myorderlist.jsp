<%@page import="java.text.DecimalFormat"%>
<%@page import="dto.MyOrderListDto"%>
<%@page import="dto.OrderListDto"%>
<%@page import="java.util.List"%>
<%@page import="dto.MemberDto"%>
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
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="/TAMINO/Member/css/MyPage.css">
<link rel="stylesheet" href="/TAMINO/Store/css/MyPageOverlay.css">
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR|Roboto|Roboto+Mono|Viga&display=swap" rel="stylesheet">
<style type="text/css">
body{
font-family: 'Open Sans', sans-serif;
width:100%; 
text-align:left;
background-size: 100%;
background-repeat: no-repeat;
}
#box1{
/* background-color:#FCFCFC; */
	  width: 60%;
	    height:auto;
	   margin: 0 auto;
	   margin-top: 200px;
	   margin-bottom: 100px;
	   padding-bottom: 200px;
/* 	 border: solid 1px;
	 border-color: red; */
}
table {
	width: 80%;
    border-top: 1px solid #6C6C6C;
    border-collapse: collapse;
}
th, td {
    border-bottom: 1px solid #6C6C6C;
     padding: 10px; 
}
#title1{
color: white;
background-color: #212121;
}
.title2{
background-color: #EAEAEA;
}

.item{
height: 150px;
width: 150px;
}
.box3{
margin-bottom: 40px;
}
#_Sbtn{
	background-color: white;
}
#_Sbtn:hover{
	background-color: black;
	color: white;
	cursor: pointer;
}
</style>
</head>
<body>


<!-- 네비게이션바 -->
<input type="hidden" value="<%=currId %>" id="currId"> 
<div class="header">
	<div class="header-content">
		<a><img id="logoimg" src="/TAMINO/image/taminoKLEIN.png"></a> <!-- Main 링크 걸기 -->
		<div class="menu">
		<a   href="/TAMINO/AdminCtrl?command=Main_Page" id="main">MAIN</a>
		<a  href="/TAMINO/StoreCtrl?command=StoreMain" id="store">STORE</a>
		<a id="mypage" onclick="openNav()">MY PAGE</a>
		</div>
		
		<div class="login">
			<a id="login">LOGIN</a>
		</div>
	</div>
</div>





<div id="box1">	<!-- 전체 div -->

<h2 align="left">나의 주문내역</h2>

<%
List<MyOrderListDto> list = (List<MyOrderListDto>)request.getAttribute("orderlist");
%>
<%
	if(list.size()==0 || list ==null){
		%>
		<div style="width: 40%; height: 30%; position: absolute; left: 30%; top:40%;" align="center"> 
		<h1>현재 구매내역이 없습니다!</h1>
		<button type="button" id="_Sbtn" style="width: 400px; height: 100px; border: 3px solid black" onclick="location.href='/TAMINO/StoreCtrl?command=StoreMain'"><h1>Shoping Now</h1></button>
		</div>
		<%
	}
	else{
		for(int i = 0;i < list.size(); i++){
			MyOrderListDto dto = list.get(i);
			//구매날짜
			String orderdate = dto.getOrder_date();
			orderdate = orderdate.substring(0, 8);
			//배송상황
			String delivery = dto.getDelivery_status();
			delivery = delivery.substring(0, 1);
			
			if(delivery.equals("1")){
				delivery = "배송중";
				
			}else if(delivery.equals("2")){
				delivery = "배송완료";
			}
			%>
			<div align="center" class="box3">
			<table>
			<col width="150"><col width="450">
			<tr id="title1"><th><%=orderdate %></th><th><%=delivery %></th></tr>
			<%
			DecimalFormat df = new DecimalFormat("###,###");  //

			//사진
			String image = dto.getProduct_image();
			String[] images =image.split(",");
			//상품명
			String name = dto.getProduct_name();
			String[] names = name.split(",");
			//상품사이즈
			String size = dto.getProduct_size();
			String[] sizes = size.split(",");
			//상품가격
			String price = dto.getProduct_price();
			String[] prices = price.split(",");
			//상품개수
			String count = dto.getProduct_count();
			String[] counts = count.split(",");
			int k = 0;
			int sum = 0; //상품가격
			int countitem = 0; //상품갯수
			for(int j =0; j < names.length; j++){
				int kprice = Integer.parseInt(prices[j]);
				String _prices = df.format(kprice);
			%>
			<tr><th rowspan="3"><img src="/TAMINO/product/<%=images[j*k]%>" class="item"></th><td><%=names[j] %></td></tr>
			<tr><td>[옵션]사이즈:<%=sizes[j] %></td></tr>
			<tr><td><%=_prices %>원/ <%=counts[j] %>개</td></tr>
			<%
			k = 5;
			sum = sum + Integer.parseInt(prices[j])*Integer.parseInt(counts[j]);


			}
			int allsum = sum + 2500;

			String _sum = df.format(sum);
			String _allsum = df.format(allsum);
			%>
			<tr class="title2"><th>상품가격</th><td><%=_sum %>원</td></tr>
			<tr class="title2"><th>배송비</th><td>2,500원</td></tr>
			<tr class="title2"><th><h3>총 주문금액</h3></th><td><h3><%=_allsum %>원</h3></td></tr>
			
			</table>
			</div>
			<%
		}
	}
%>




</div> <!-- 전체 -->



<div id="myNav" class="overlay">
<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
	<div class="overlay-content">
		<p>MY PAGE</p>
    	<a href="/TAMINO/MemberCtrl?command=myInfo&email=<%=currId %>">회원정보 수정</a>
    	<a href="/TAMINO/MemberCtrl?command=MyOrderList">주문내역</a>
  	</div>

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