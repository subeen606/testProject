<%@page import="java.text.DecimalFormat"%>
<%@page import="dto.OrderListDto"%>
<%@page import="java.util.List"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="/TAMINO/Store/css/Store_List.css">
<link rel="stylesheet" href="/TAMINO/Store/css/MyPageOverlay.css">
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR|Roboto|Roboto+Mono|Viga&display=swap" rel="stylesheet">
<style type="text/css">
body{
font-family: 'Noto Sans KR', sans-serif;
width:100%; 

background-size: 100%;
background-repeat: no-repeat;
}

#box1{
width: 60%;
height:auto;
margin: 0 auto;
margin-top: 130px;
margin-bottom: 100px;
padding-bottom: 200px;
/* border: solid 1px;
border-color: red; */
}
.table1 {
	width: 100%;
    border-top: 1px solid #6C6C6C;
    border-collapse: collapse;
}
.table2{
	width: 50%;
    border-top: 1px solid #6C6C6C;
    border-collapse: collapse;
}
  th, td {
    border-bottom: 1px solid #6C6C6C;
     padding: 10px; 
}
.lines{
border-right: 1px solid #B4B4B4;
} 
.title{
background-color: #EAEAEA;
}
	
.btn2{
border: none;
margin-top:15px;
width:300px;
height:50px;
font-size:1.5em;
background-color: black;
color: white;
}

#newbtn{
border: none;
width:120px;
height:30px;
font-size:1em;
background-color: black;
color: white;
margin-bottom: 8px;
}

.adbtn{
border: none;
width:120px;
height:30px;
font-size:1em;
background-color: black;
color: white;
line-height: 2px;
}
#phone{
width:200px;
height:30px;
color:black;
margin:auto;
font-size:1em;
}

input {
width:200px;
height:30px;
color:black;
margin:auto;
font-size:1em;
outline: none;
}

#request{
width:600px;
height:35px;
font-size:1em;
}
#mbox{
    border-bottom: 1px solid #6C6C6C;
    border-collapse: collapse;
    text-align: right;
}
 
#memo{
width:400px;
height:30px;
}	
.cardimg{
width:30px;
height:20px;
}
#cardinput{
text-align: left;
border: solid 1px;
margin-left: 60px;
}

#cardbig{
margin-top:50px;
width:400px;
height:230px;
}
#selboxDirect{
width: 600px
}
#pline{
    border-left: 1px solid #6C6C6C;
}
.box5{
float:left;
width: 550px;
height: 400px;
margin-left: 3rem;
} 

.box5#box6{
float:left;
width: 400px;
height: 400px;

}

.address#sample2_address{
	width: 300px;
	line-height: 2px;
}

.steptext{
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 11pt;
}
.btn2{
	width: 40%;
	font-family: 'Noto Sans KR', sans-serif;
	cursor: pointer;
}

.btn2#btn3:hover{
	background-color: indianred;
}

.btn2#btn4:hover{
	background-color: #008c9e;
}

 
</style>
<%
//로그인 정보 얻어오기
Object ologin = session.getAttribute("login");
MemberDto mem = null;
mem = (MemberDto)ologin;

%>
<%
	String currId = "guest";
	if( request.getSession().getAttribute("login") != null ){
		MemberDto loginDto = (MemberDto)request.getSession().getAttribute("login");
		currId = loginDto.getEmail();
	}
%>
<!-- 네비게이션바 -->


<!--주소  -->

<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
</div>

 
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function sample2_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample2_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample2_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample2_postcode').value = data.zonecode;
                document.getElementById("sample2_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample2_detailAddress").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 400; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
</script>

<!--주소  -->


</head>
<body>





<!-- 네비게이션바 -->
<div class="header">
		<div class="header_container">
			<div class="header_content">
				<div class="logindiv">
						<a id="cart"><img src="/TAMINO/image/cart.png" width="20px" height="20px"></a>
						<a id="login" href="/TAMINO/StoreCtrl?command=login">LOGIN</a>
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


<form action="/TAMINO/ordercontrol?command=addorder" method="post">

<div id="box1">	<!-- 전체 div -->

<img height="250px" width="100%" src="../image/shop.jpg">

<h1>주문/결제</h1>
<br><br>
<div id="box2" align="right">
<pre class="steptext">01장바구니><strong>02주문/결제</strong>>03주문완료 </pre>
</div>

<%
/* 장바구니 정보 불러오기 */
List<OrderListDto> list = (List<OrderListDto>)session.getAttribute(mem.getEmail());

//전화번호 자르기
String phoneNum[] = { "010","011","016","017","018","019","070"};

String phone = mem.getPhoneNumber();
String phone1 = phone.split("-")[0];
String phone2 = phone.split("-")[1];
String phone3 = phone.split("-")[2];

String pickNum = phone1; 

//주소 자르기
String address = mem.getAddress();
String address1 = address.split("-")[0];
String address2 = address.split("-")[1];
String address3 = address.split("-")[2];
String address4 = address.split("-")[3];
%>



<h3>배송지 정보</h3>
<hr>
<input type="hidden" name="order_email" value="<%=mem.getEmail() %>">

<div>   <!--  -->
<button type="button" id="newbtn">+새로운주소</button>
<table class="table1">
	<col width="20%"><col width="80%">
	<tr>
		<th>이름</th><td><input type="text" class="address" name="order_name" value="<%=mem.getUserName() %>"></td>
	</tr>
	
	<tr>
		<th>연락처</th>
		<%
		%>
		<td><select id="phone" name="order_phonenumber1" >
			<%
				for(int i=0; i<phoneNum.length; i++){
					if(phoneNum[i].equals(pickNum)){
						%>
						<option value="<%=phoneNum[i]%>" selected="selected"><%=phoneNum[i] %></option>
						<%
					}
					else{
						%>
						<option value="<%=phoneNum[i]%>"><%=phoneNum[i] %></option>
						<%
					}
				}
			%>
			</select> 
		 - <input type="text" class="address" name="order_phonenumber2"  maxlength="4" value="<%=phone2 %>" numberOnly> - <input type="text" class="address"  name="order_phonenumber3" maxlength="4" value="<%=phone3 %>" numberOnly>
		</td>
	</tr>
	<tr>
		<th rowspan="3">주소</th><td><input type="text" id="sample2_postcode" class="address" name="order_address1" placeholder="우편번호" value="<%=address1 %>" numberOnly readonly="readonly">
	<input type="button" onclick="sample2_execDaumPostcode()" class="adbtn" id="postbtn" value="우편번호 찾기"></td>
	</tr>
	<tr>
		<td><input type="text" id="sample2_address" class="address" name="order_address2" placeholder="주소" value="<%=address2 %>" readonly="readonly"></td>
	</tr>
	<tr>
		<td><input type="text" id="sample2_detailAddress" name="order_address3" class="address" placeholder="상세주소" value="<%=address3 %>">
	<input type="text" id="sample2_extraAddress" class="address" name="order_address4" placeholder="참고항목" value="<%=address4 %>" readonly="readonly"></td>
	</tr>
	<tr>
		<th>배송 메모</th>
		<td><select id="request" name="order_request1" class="address">
		<option value="배송 전에 미리 연락 바랍니다.">배송 전에 미리 연락 바랍니다.</option>
		<option value="부재시 경비실에 맡겨 주세요.">부재시 경비실에 맡겨 주세요.</option>
		<option value="부재시 전화 주시거나 문자 남겨 주세요.">부재시 전화 주시거나 문자 남겨 주세요.</option> 
		<option value="">직접입력 </option>
		</select></td>
	</tr>
	<tr><td></td><td><input type="text" id="selboxDirect" name="order_request2" class="address" placeholder="직접입력"></td></tr>
</table>
</div>
<br><br>


<h3>주문상품 정보</h3>
<hr>

<div align="center">
<table class="table1" width="100%">
<col width="15%"><col width="40%"><col width="10%"><col width="10%"><col width="20%">
	
	<tr class="title">
		<th colspan="2">상품정보</th><th>사이즈</th><th>수량</th><th>상품금액</th> <!-- 나중에 지우기 -->
	</tr>
	
	<input type="hidden" name="listsize" value="<%=list.size() %>">
	
	<%
	DecimalFormat df = new DecimalFormat("###,###");  //
	
		for(int i = 0;i < list.size(); i++){
			OrderListDto dto = list.get(i);
			String image[] = dto.getProduct_image().split(",");
			String _price = df.format(dto.getProduct_price());	//
		%>
		<input type="hidden" name="product_seq<%=i %>" value="<%=dto.getProduct_seq() %>">
		<input type="hidden" name="product_price<%=i %>" value="<%=dto.getProduct_price()%>">
		<tr>
			<th class="lines">
				<input type="hidden" name="product_image<%=i %>" value="<%=dto.getProduct_image() %>">
				<img src="/TAMINO/product/<%=image[0]%>" width="150px" height="150px">
			</th>
			<td class="lines">
				<input type="hidden" name="product_name<%=i %>" value="<%=dto.getProduct_name() %>">
				<%=dto.getProduct_name() %>
			</td>
			<td class="lines" align="center">
				<input type="hidden" name="product_size<%=i %>" value="<%=dto.getProduct_size() %>">
				<%=dto.getProduct_size() %>
			</td>
			<td class="lines" align="center">
				<input type="hidden" name="product_count<%=i %>" value="<%=dto.getProduct_count()%>">
				<%=dto.getProduct_count()%>
			</td>
			<td align="center">
				<input type="hidden" name="product_price<%=i %>" value="<%=dto.getProduct_price()%>">
				<%=_price%>
			</td>
		</tr>
		
		<%
	}
	%> 
	
</table>
</div> 

<%
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

<hr>
<div align="center" class="title">
<table id="mbox" class="table1">
<col width="500"><col width="250"><col width="250">
	<tr>
	<th rowspan="2"></th><td>상품금액</td><td><%=_sum %>원</td>
	</tr> 
	
	<tr >
	<td>배송비</td><td>(+) 2,500원</td>
	<tr>
	
	<tr>
	<th colspan="2"><h2>총 주문금액</h2></th><td><h2><%=_allsum %>원</h2></td>
	</tr>
</table>
</div>
<br><br>


<h3>결제</h3>
<hr>
<div class="box5" >
<table class="table" id="cardinput">
	<col width="50%"><col width="50%">
	<tr class="title"><th colspan="2">신용/직불카드</th></tr>
	<tr class="title"><th colspan="2"><img class="cardimg" src="../image/visa.png"><img class="cardimg" src="../image/mastercard.jpg"><img class="cardimg" src="../image/jcb.png"></th></tr>
	<tr class="title"><td colspan="2">카드 명의자 이름(영문)</td></tr>
	<tr><td colspan="2"><input type="text" id="cardname"  onkeyup="this.value=this.value.replace(/[^a-zA-Z]/g,'');"></td></tr>
	<tr class="title"><td colspan="2">신용/직불카드 번호</td></tr>
	<tr><td colspan="2"><input type="text" id="cardnumber" maxlength="16" numberOnly></td></tr>
	<tr class="title"><td>카드 유효기간</td>  <td> cvc/cvv</td></tr>
	<tr><td><input type="text" placeholder="mm/yy" maxlength="4" id="carddate" numberOnly></td><td><input type="password" maxlength="3" id="cvc"></td></tr>
</table>
</div> 

<div class="box5" id="box6">
<img id="cardbig" src="../image/cvc.png" style="margin-left: 10px">
</div>

<div align="center" style="margin-top: 13rem;">
<button class="btn2" id="btn3" style="margin-right: 5rem;">취소</button><input type="submit" class="btn2" id="btn4" value="결제하기">
</div>

</div><!-- 전체 div -->
</form>

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


 <script language="javascript"> 

 $(function confirmtest(){
	 $("#btn3").mousedown(function() {
		 location.href = "/TAMINO/StoreCtrl?command=goCart";
	});
 });
 $(function(){
$("#selboxDirect").hide();
$("#request").change(function() {
               //직접입력을 누를 때 나타남
		if($("#request").val() == "") {
			$("#selboxDirect").show();
		}  else {
			$("#selboxDirect").hide();
		}
	}) 
}); 

 "#carddate" 

</script>

<script type="text/javascript">
$(function () {
	
	$("#newbtn").mousedown(function() {
		$(".address").val(""); //새로운주소
	});
	
	$("#newbtn").mouseover(function() {		
		$(this).css("background", "#AAABD3");
	});
	$("#newbtn").mouseout(function() {		
		$(this).css("background", "black");
	});
	$(".btn2").mouseover(function() {		
		$(this).css("background", "#AAABD3");
	});
	$(".btn2").mouseout(function() {		
		$(this).css("background", "black");
	});
	$("#postbtn").mouseover(function() {		
		$(this).css("background", "#AAABD3");
	});
	$("#postbtn").mouseout(function() {		
		$(this).css("background", "black");
	});
	
	$("input:text[numberOnly]").on("keyup", function() {
	    $(this).val($(this).val().replace(/[^0-9]/g,""));
	});

	
	$("#btn4").mousedown(function() {
		if($("#cardname").val()==""){
			alert("카드 명의자 이름을 입력해주세요");
			return;
		}else if($("#cardnumber").val()==""){
			alert("신용/직불카드 번호를 입력해주세요");
			return;
		}else if($("#carddate").val()==""){
			alert("카드 유효기간을 입력해주세요");
			return;
		}else if($("#cvc").val()==""){
			alert("cvc/cvv를 입력해주세요");
			return;
		}
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

<script src="scrollevent.js"></script>
</body>
</html>