<%@page import="java.util.Date"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.MemberDto"%>
<%@page import="util.UtilityClass"%>
<%@page import="dto.OrderListDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
MemberDto loginDto = null;

String currId = "guest";
if( request.getSession().getAttribute("login") != null ){
	loginDto = (MemberDto)request.getSession().getAttribute("login");
	currId = loginDto.getEmail();
}

/* List<OrderListDto> list = (List<OrderListDto>)session.getAttribute("cartlist"); */
List<OrderListDto> list = new ArrayList<OrderListDto>();

boolean sessioncheck = false;

Enumeration em = session.getAttributeNames();
while(em.hasMoreElements()) {
	String sessionName = em.nextElement().toString();
	System.out.println("세션 명: " + sessionName);
	if(!sessionName.equals("login")){
		sessioncheck = true;
		break;
	}	
}

if(sessioncheck){
	list = (List<OrderListDto>)session.getAttribute(loginDto.getEmail());
	
}

if(list.isEmpty()){
	System.out.println("카트리스트 없음");
}else{
	System.out.println("카트리스트 있음");
	System.out.println(list.size());
}


%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="/TAMINO/Store/css/Store_Cart.css">
<link rel="stylesheet" href="/TAMINO/Store/css/MyPageOverlay.css">
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR|Roboto|Roboto+Mono|Viga&display=swap" rel="stylesheet">
<style type="text/css">
.modal{
	display: none;
	position: fixed;
	z-index: 1;
	background-color: rgb(0,0,0,0);
	padding-top: 15%;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
}

.modal_content{
	  background-color: #fff;
	  margin: auto;
	  padding: 40px;
	  border: 1px solid #888;
	  width: 40%;
	  height: 400px;
	  padding-left: 60px;
}

.close{
	float: right;
	size: 20px 20px;
	cursor: pointer;
}

.imagediv{
	float: left;
	margin-right: 2rem;
}

.optiondiv{
	float: left;
}
</style>
</head>
<body>
<div class="header">
		<div class="header_container">
			<div class="header_content">
				<div class="logindiv">
						<a id="cart" href = "/TAMINO/StoreCtrl?command=goCart"><img src="/TAMINO/image/cart.png" width="20px" height="20px"></a>
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


<input type="hidden" value="<%=currId %>" id="currId"> 


<div class="cartdiv" align="center">
<div class="cartcaption">Cart</div>
<table class="cart_table" border="1">
<col width="50px"><col width="150px">

<tr>
	<td colspan="5" align="left">담긴 상품: 총 <%=list.size() %>개</td>
</tr>

<tr>
	<th>
		<input type="checkbox" name="alldel">
	</th>
	<th colspan="3">
		상품정보
	</th>
	<th>
		금액
	</th>
</tr>

<!-- 장바구니 상품 부분 -->
<%
if(loginDto != null && list.size() > 0){
	for(int i = 0; i < list.size(); i++){
		OrderListDto dto = list.get(i);
			/* if(loginDto.getEmail().equals(dto.getOder_email())){ */
				String image[] = dto.getProduct_image().split(",");%>
				<tr>
					<td align="center">
						<input type="checkbox" name="delcheck" value="<%=i %>">
					</td>
					<td>
						<img src="/TAMINO/product/<%=image[0] %>" width="150px" height="150px">
					</td>
					<td>
						상품명 : <%=dto.getProduct_name() %><br>
						SIZE : <%=dto.getProduct_size() %><br>
						수량 : <%=dto.getProduct_count() %><br>
					</td>
					<td class="findindex" findindex="<%=i %>" align="center">
						<button type="button" class="option">옵션 변경</button>
					</td>
					<td align="center" class="price">
						<%=UtilityClass.PriceConvert((dto.getProduct_price() * dto.getProduct_count())) %>won
					</td>
				</tr>
			<%
			/* } */
	  }
	
}else if(list.size() == 0 || list == null){%>
<tr>
	<td colspan="5">
		장바구니에 담긴 상품이 없습니다.
	</td>
	
</tr>
<%	
}
%>
<tr>
	<td colspan="2">
		<button type="button" id="delBtn">삭제하기</button>
	</td>
	<td colspan="3" align="right">
	주문예정 금액
	</td>
	
</tr>

<tr>
	<td colspan="5" align="right" class="total">
		상품가격<br>
		 + 배송비(2,500원)<br>
		= 00,000원
	</td>
</tr>

<tr>
	<td colspan="5" align="center">
		
		<button type="button" id="orderBtn">전체 주문하기</button>
	</td>
</tr>
</table>
</div>


<div id="modal_layer1" class="modal">
	<div id="modal_layer2" class="modal_content">
		<span class="close" id="close_span"><img src="/TAMINO/image/close.png" width="15px" height="15px"></span>
		
		<form id="updatefrm">
			<input type="hidden" name="updateindex" value="-1">
			<div class="imagediv">
				<img id="update_image" width="300px" height="300px" style="margin-top: 10px;"><br>
			</div>
			<div class="optiondiv">
			<input type="text" name="update_name" readonly="readonly"><br><br><br>
			<span style="font-size: 9pt">SIZE</span>&nbsp;&nbsp;&nbsp;
			<select name="update_size" style="height: 30px; width: 100px; display: none;">
						<option value="S">S</option>
						<option value="M">M</option>
						<option value="L">L</option>
			</select><br><br>
			
			<span style="font-size: 9pt">QUANTITY</span>&nbsp;&nbsp;&nbsp;
			<input type="text" id="quantity" name="update_count" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" value=1>&nbsp;&nbsp;&nbsp;
			<button type="button" id="minusBtn" class="plusminusbtn">-</button>
			<button type="button" id="plusBtn" class="plusminusbtn">+</button><br><br><br>
			<button type="button" id="updateBtn">수정완료</button>
			</div>
		</form>
		
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
	}else if($("#currId").val() == "guest"){/* 로그인 하지 않은 경우 */
		alert("장바구니는 로그인 후 이용 가능합니다.");
		location.href = "/TAMINO/MemberCtrl?command=login";
	}
	
	$(".option").click(function () {/* 옵션 수정 */
		var pname;
		var pimage;
		var psize;
		var pcount;
		$("input[name=updateindex]").val($(this).parent().attr("findindex"));
		$("#modal_layer1").css("display", "block");
		//alert($(this).parent().attr("findindex"));
		var findIndex = $(this).parent().attr("findindex") ;
		
		$.ajax({
			type: 'get',
			url: '/TAMINO/StoreCtrl?command=findCart',
			async: false,
			data: {"findIndex":findIndex},
			datatype: 'json',
			success: function (obj) {
				//alert("성공");
				var data = JSON.parse(obj);	
				pname = data.pname;
				console.log(pname);
				
				pimage = data.pimage;
				console.log(pimage);
				
				psize = data.psize;
				console.log(psize);
				
				pcount = data.pcount;
				console.log(pcount);

			},
			error: function () {
				alert("실패");
			}
		})
		
		var where = pimage.indexOf(",");
		pimage = pimage.substring(0, where);
		console.log("자른거: " + pimage);
		$(".pname").text(pname);
		$("input[name=update_name]").val(pname);
		$("#update_image").attr("src", "/TAMINO/product/"+pimage);
		$("#quantity").val(pcount);
		$("#updateindex").val(findIndex);
		console.log("ajax밖 : " + psize);
		
		if(psize == "해당없음"){
			/* $("select[name=update_size]").hide(); */
		}else if(psize == "S" || psize == "M" || psize == "L"){
			$("select[name=update_size]").css("display", "inline-flex");
			$("select[name=update_size] option[value='" + psize + "']").attr("selected", "selected");
		}
		
	});
	
	$(".plusminusbtn").click(function() {/* 수량버튼 */
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
	
	$("#quantity").focusout(function() {/* 수량 입력 제어 */
		if(parseInt($("#quantity").val()) <= 0){
			alert("최소 수량은 1개 입니다");
			$("#quantity").val(1);
		
		}else if(parseInt($("#quantity").val()) > 10){
			alert("1인 당 최대 10개 까지 구매 가능합니다");
			$("#quantity").val(10);
			
		}
	});
	
	$("#close_span").click(function () {
		$("#modal_layer1").css("display", "none");
		$("select[name=update_size]").css("display", "none");
	});
	
	
	$("#updateBtn").click(function () {/* 수정완료 버튼 */
		var formData = $("#updatefrm").serialize();
		$.ajax({
			type: 'post',
			url: '/TAMINO/StoreCtrl?command=updateCart',
			data: formData, 
			datatype : 'json',
			success: function () {
				//alert("수정완료");
				location.href = "/TAMINO/StoreCtrl?command=goCart";
			},
			error: function () {
				alert("에러");
			}
		})
	});
	
	
	$("input:checkbox[name='alldel']").change(function() {
		if($("input:checkbox[name='alldel']").is(":checked")){
			$("input:checkbox[name='delcheck']").each(function () {
				$(this).prop("checked", true);
			});
		}else{
			$("input:checkbox[name='delcheck']").each(function () {
				$(this).prop("checked", false);
			});
		}
	});
	
	
	$("#delBtn").click(function () {/* 장바구니 삭제 */
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
				type: 'post',
				url: '/TAMINO/StoreCtrl?command=deleteCart',
				datatype : 'json',
				data: {"delslist" : delslist},
				success: function () {
					//alert("성공");
					location.href = "/TAMINO/StoreCtrl?command=goCart";
				},
				error: function () {
					alert("에러");
				}
			})
		}
	});
	
	$("#orderBtn").click(function () {
		if(<%=list.size()%> == 0 ){
			alert("장바구니에 담긴 상품이 존재하지 않습니다");
			return;
		}
		location.href = "/TAMINO/StoreCtrl?command=allOrder";
	});
	
	var price = 0;
	for(i=0; i<$(".price").length; i++){
		price += parseInt($('.price').eq(i).text().replace(",", ""));
	}
	
	var total = addComma(price + 2500);
	price = addComma(price);
	var text = addComma(price) + "<br>+ 배송비(2,500원)" + "<br>=" + addComma(total);
	$('.total').html(text);
		
	function addComma(num) {

		  // 문자열 길이가 3과 같거나 작은 경우 입력 값을 그대로 리턴
		  if (num.length <= 3) {
		    return num;
		  }

		  // 3단어씩 자를 반복 횟수 구하기
		  var count = Math.floor((num.length - 1) / 3);

		  // 결과 값을 저정할 변수
		  var result = "";

		  // 문자 뒤쪽에서 3개를 자르며 콤마(,) 추가
		  for (var i = 0; i < count; i++) {

		    // 마지막 문자(length)위치 - 3 을 하여 마지막인덱스부터 세번째 문자열 인덱스값 구하기
		    var length = num.length;
		    var strCut = num.substr(length - 3, length);
		    // 반복문을 통해 value 값은 뒤에서 부터 세자리씩 값이 리턴됨.

		    // 입력값 뒷쪽에서 3개의 문자열을 잘라낸 나머지 값으로 입력값 갱신
		    num = num.slice(0, length - 3);

		    // 콤마(,) + 신규로 자른 문자열 + 기존 결과 값
		    result = "," + strCut + result;
		  }

		  // 마지막으로 루프를 돌고 남아 있을 입력값(value)을 최종 결과 앞에 추가
		  result = num + result;

		  // 최종값 리턴
		  return result;
		}  
	
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