<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
%>   

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link href="https://fonts.googleapis.com/css?family=DM+Serif+Text|Roboto+Condensed&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:100,300,400|Roboto|Roboto+Mono|Viga&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/TAMINO/Member/css/MyPage.css">
<link rel="stylesheet" href="/TAMINO/Store/css/MyPageOverlay.css">
<style type="text/css">
body{
	width: 100%;
	height: 100%;
	margin: 0;
	font-family: 'Noto Sans KR:400', sans-serif;
}
.backImg{
	width: 100%;
	height: 100%;
	margin: 0;
	z-index: -1000;
	position: fixed;
	/* background: black; */
}
.logindiv{
	width: 500px;
	height: 500px;
	top:27%;
	left: 37.5%;
	position: fixed;
}
.EPfind{
	width: 600px;
	height: 700px;
	top:17.5%;
	left: 37.5%;
	position: fixed;
	display: none;
	background-color: #fff;
}

.inani{
	-webkit-animation:swing-in-top-fwd 0.6s 0s 1 linear none;
	animation:swing-in-top-fwd 0.6s 0s 1 linear none;
}
.outani{
	-webkit-animation:swing-out-top-bck 0.6s 0s 1 linear none;
	animation:swing-out-top-bck 0.6s 0s 1 linear none;
}
.imgDiv{
	width: 700px;
	height: 850px;
	top:13.5%;
	left: 32.5%;
	position: fixed;
   /*  border: 4px solid black; */
    /* border-radius: 15px; */
   /*  box-shadow: 25px 25px 40px 2px #C6B8B8;  */
    background-color: white; 
}
.login tr{
	height: 75px;
}
.account tr{
	height: 50px;
}
th,td{
	/* border: none; */
	font-size : 15px;
}
/* 
.login input{
	border: none;
	width: 250px;
	font-size: 15px;
}

 */
.login a{
	text-decoration: none;
	color: blue;
}
.account input{
	border: none;
	width: 275px;
	font-size: 13pt;
}
.EPfind input{
	border: none;
	width: 250px;
	font-size: 13px;
}

.EPfind tr{
	height: 75px;
}
 
input:focus{
	outline: none;
}
#check{
	opacity: 0.5;
}

/* 
button{
	border: 5px solid black; 
	border: none;
	background-color: black;
	color: white;
	width: 400px;
	height: 50px;
	font-family: 'Roboto', sans-serif;
	font-size: 20px;
	transition: 0.1s;
}
button:hover {
	background-color: white;
	cursor: pointer;
	color: black;
	
}
*/

span{
	font-family: 'Noto Sans KR:400', sans-serif;
	font-size: 13pt;
}

span:hover {
	cursor: pointer;
}
.false::placeholder{
	color: red;
}
input[type=search]{
	width: 250px;
}
input[type=text]{
	width: 250px;
}
input[type=password]{
	width: 250px;
}

table.loginfrm th{
	font-family: 'Roboto', sans-serif;
	font-size: 15px;
	padding: 10px;
}

.login a#a_login{
	font-family: 'Roboto', sans-serif;
	font-size: 15pt;
	float: right;
	color: #fff;
	margin-right: 3rem;
	margin-top: 1.5rem;
	text-decoration: none;
}
@-webkit-keyframes swing-in-top-fwd{0%{-webkit-transform:rotateX(-100deg);transform:rotateX(-100deg);-webkit-transform-origin:top;transform-origin:top;opacity:0}100%{-webkit-transform:rotateX(0deg);transform:rotateX(0deg);-webkit-transform-origin:top;transform-origin:top;opacity:1}}@keyframes swing-in-top-fwd{0%{-webkit-transform:rotateX(-100deg);transform:rotateX(-100deg);-webkit-transform-origin:top;transform-origin:top;opacity:0}100%{-webkit-transform:rotateX(0deg);transform:rotateX(0deg);-webkit-transform-origin:top;transform-origin:top;opacity:1}}
@-webkit-keyframes swing-out-top-bck{0%{-webkit-transform:rotateX(0deg);transform:rotateX(0deg);-webkit-transform-origin:top;transform-origin:top;opacity:1}100%{-webkit-transform:rotateX(-100deg);transform:rotateX(-100deg);-webkit-transform-origin:top;transform-origin:top;opacity:0}}@keyframes swing-out-top-bck{0%{-webkit-transform:rotateX(0deg);transform:rotateX(0deg);-webkit-transform-origin:top;transform-origin:top;opacity:1}100%{-webkit-transform:rotateX(-100deg);transform:rotateX(-100deg);-webkit-transform-origin:top;transform-origin:top;opacity:0}}
</style>
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
<div class="backImg">
</div>

<!-- header -->
<div class="header">
	<div class="header-content">
		<a><img id="logoimg" src="/TAMINO/image/taminoKLEIN.png"></a> <!-- Main 링크 걸기 -->
		<div class="menu">
		<a href="/TAMINO/AdminCtrl?command=Main_Page" id="main">MAIN</a>
		<a href="/TAMINO/StoreCtrl?command=StoreMain" id="store">STORE</a>
		<a id="mypage" onclick="openNav()">MY PAGE</a>
		</div>
		
		<div class="login">
			<a id="login" href="/TAMINO/MemberCtrl?command=login">LOGIN</a>
		</div>
	</div>
</div>

<!-- login창 -->

	<div class="logindiv">
		<form action="/TAMINO/MemberCtrl" method="post">
			<input type="hidden" name="command" value="Member_Login">
		<table class="loginfrm">
			<col width="150px"><col width="350px">
			<tr>
				<th colspan="2"><h1>Sign in with your Account</h1></th>
			</tr>
			<tr style="height: 50px;">
				<th align="center">Email</th>
				<td>
				<input type="text" name="email" style="margin-left: 10px; padding-left: 5px; border-bottom: 1px solid black; width: 280px;">
				</td>
			</tr>
			<tr>
				<th align="center">Password</th>
				<td><input type="password" name="password" style="margin-left: 10px; padding-left: 5px; border-bottom: 1px solid black; width: 280px;"></td>
			</tr>
			<tr>
				<th colspan="2">
				<!-- <span style="margin-right: 55px;"><img id="_check" alt="" src="/Tamino/image/idCheck.jpg" style="width: 20px; height: 20px;">&nbsp;아이디 기억하기</span> -->
				<a href="#" id="_findEP" style="font-size: 13pt; font-family: 'Noto Sans KR:100', sans-serif; text-decoration: none; color: black;">Email,Pwd 찾기</a>
				</th>
			</tr>
			<tr>
				<td colspan="2" align="center"><button id="_sub" type="submit" class="btns">LOGIN</button></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><button type="button" id="_account" class="btns">ACCOUNT</button></td>
			</tr>
		</table>
		</form>
	</div>

<!-- 회원가입창 -->

<form action="/TAMINO/MemberCtrl" method="post" onsubmit="return check()">
	<input type="hidden" name="command" value="Member_Account">
<div class="account" align="center">
	<table class="account_table">
		<col width="25%"><col width="75%">
		<tr>
			<th colspan="3"><h1>Create Account</h1></th>
		</tr>
		<tr style="height: 50px;">
			<th>EMAIL</th>
			<td>
			<input type="text" name="email" id="_AccEmail" style=" padding-left: 5px; border-bottom: 1px solid black">
			
			<button type="button" id="_emailCheck" class="adbtn">중복확인</button>
			</td>
		</tr>
		<tr>
			<th>PASSWORD</th>
			<td><input type="password" id="_accPwd" name="password" style=" padding-left: 5px; border-bottom: 1px solid black"></td>
		</tr>
		<tr>
			<th>PASSWORD 확인</th>
			<td><input type="password" id="_pwdCheck" style=" padding-left: 5px; border-bottom: 1px solid black"></td>
		</tr>
		<tr>
			<th>이름</th>
			<td><input type="text" name="name" style=" padding-left: 5px; border-bottom: 1px solid black"></td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td>
				<select style="height: 30px; width: 70px;" name="phone1">
					<option selected="selected">010</option><option>011</option><option>016</option><option>019</option>
				</select>
				<input type="text" style="border-bottom: 1px solid black; width: 73px; margin-right: 5px; padding-left: 5px" name="phone2">ㅡ<input type="text" style="border-bottom: 1px solid black; width: 73px; margin-left: 5px; padding-left: 5px;" name="phone3">
			</td>
		</tr>
		<tr>
			<th rowspan="4">주소</th>
			<td style="padding-bottom: 0px;"><input type="text" id="sample2_postcode" style="; padding-left: 5px; border-bottom: 1px solid black" class="address" name="address1" placeholder="우편번호" readonly="readonly">
			
			<input style="width: 120px; font-size: 12pt;" type="button" onclick="sample2_execDaumPostcode()" class="adbtn" value="우편번호 찾기">
			</td>
		</tr>
		
		<tr>
		
			<td><input type="search" style=" padding-left: 5px; border-bottom: 1px solid black" id="sample2_address" class="address" name="address2" placeholder="주소" readonly="readonly"></td>
		</tr>
		
		<tr>
			<td><input type="search" style="padding-left: 5px; border-bottom: 1px solid black" id="sample2_detailAddress" name="address3" class="address" placeholder="상세주소" ></td>
		</tr>
		
		<tr>
			<td><input type="search" style=" padding-left: 5px; border-bottom: 1px solid black" id="sample2_extraAddress" class="address" name="address4" placeholder="참고사항" readonly="readonly" ></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<button type="submit" class="btns2">SIGN UP</button>
				<button type="button" id="_backLogin" class="btns">LOGIN</button>
			</td>
		</tr>
	</table>
</div>
</form>


<!-- ID,PWD찾기 -->
<div class="EPfind">
	<table class="EPfindtable">
		<col width="150px"><col width="350px">
			<!-- 아이디 찾기 -->
			<tr>
				<th colspan="2"><h3>Email을 잊어버리셨습니까?</h3></th>
			</tr>
			<tr style="height: 50px;">
				<th align="center">이름</th>
				<td align="left">
				<input type="text" name="name" style="margin-left: 20px; padding-left: 5px; border-bottom: 1px solid black; width: 70%;">
				</td>
			</tr>
			<tr>
				<th align="center">전화번호</th>	
				<td>
					<select style="margin-left: 20px; width:70px; height: 30px;" name="phone1">
						<option selected="selected">010</option><option>011</option><option>016</option><option>019</option>
					</select>
					<input type="text" style="border-bottom: 1px solid black; width: 73px; margin-right: 5px; padding-left: 5px" name="phone2">ㅡ<input type="text" style="border-bottom: 1px solid black; width: 73px; margin-left: 5px; padding-left: 5px;" name="phone3">
				</td>
			</tr>
			<tr>
				<th colspan="2">
					<button type="button" id="_findE"  class="btns">Find</button>
				</th>
			</tr>
			<!-- 비밀번호 찾기 -->
			<tr>
				<th colspan="2"  style="padding-top: 3rem;"><h3>비밀번호를 잊어버리셨습니까?</h3></th>
			</tr>
			<tr style="height: 50px;">
				<th align="center">EMAIL</th>
				<td align="left">
				<input type="text" name="email" style="margin-left: 20px; padding-left: 5px; border-bottom: 1px solid black; width: 70%;">
				</td>
			</tr>
			<tr>
				<th align="center">전화번호</th>	
				<td>
					<select style="margin-left: 20px; width:70px; height: 30px;" name="phone1">
						<option selected="selected">010</option><option>011</option><option>016</option><option>019</option>
					</select>
					<input type="text" style="border-bottom: 1px solid black; width: 73px; margin-right: 5px; padding-left: 5px" name="phone2">ㅡ<input type="text" style="border-bottom: 1px solid black; width: 73px; margin-left: 5px; padding-left: 5px;" name="phone3">
				</td>
			</tr>
			<tr>
				<th colspan="2">
					<button type="button" class="btns" id="_findP">Find</button>
				</th>
			</tr>
	</table>
</div>



<div id="myNav" class="overlay">
<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
	<div class="overlay-content">
		<p>MY PAGE</p>
    	<a href="/TAMINO/MemberCtrl?command=myInfo&email=<%=currId %>">회원정보 수정</a>
    	<a href="/TAMINO/MemberCtrl?command=MyOrderList">주문내역</a>
  	</div>

</div>


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


<script type="text/javascript">
$(function () {
	if($("#currId").val() != "guest"){
		//alert($("#login").attr("href"));
		$("#login").text("LOGOUT");
		$("#login").attr("href", "/TAMINO/StoreCtrl?command=logout");
	}else{
		$("#mypage").attr("onclick", "");
		
		$("#mypage").on("click", function () {
			alert("로그인을 해주십시오");
			
			return ;
		});
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



var E = false;
var P = false;
var N = false;
var Phone = false;
var A = false;

function check() {
	/* alert("E:"+E+"P:"+P+"N:"+N); */
	
	if(E && P && N && Phone &&($("#sample2_address").val().length>0 && $("#sample2_detailAddress").val().length>0)){
		return true;
	}
	else{
		if(!E){
			alert("이메일을 확인하세요.")
			$("_AccEmail").focus();
		}
		else if(!P){
			alert("비밀번호를 확인하세요.")
			$("_accPwd").focus();
		}
		else if(!N){
			alert("이름을 확인하세요.")
			$("input[name=name]").focus();
		}
		else if(!Phone){
			alert("전화번호를 확인하세요")
			$("input[name=phone2]").focus();
		}
		else if($("#sample2_address").val().length==0){
			alert("주소를 검색하세요.")
		}
		else if($("#sample2_detailAddress").val().lengh==0){
			alert("상세주소를 입력하세요")
			$("#sample2_detailAddress").focus();
		}
		
		return false;
	}
}	
	

$(document).ready(function() {
	if($("#currId").val() != "guest"){
		$("#login").text("LOGOUT");
		$("#login").attr("href", "/TAMINO/MemberCtrl?command=logout");
		$("#mypage").css("display", "block");
	}else if($("#currId").val() == "guest"){/* 로그인 하지 않은 경우 */
		
	}
	
	
	var regEmail = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	
///////////////////////////////////////////입력제한/////////////////////////////////////
	$(":text").bind("keyup",function(){	// text 공백제거
		  var str_space = /\s/; 
		  if(str_space.exec($(this).val())) { 
	        alert("	공백을 사용할수 없습니다.");
	        $(this).focus();
	        $(this).val($(this).val().replace(" ", "")); 
	        return false;
		  }
	});
	
	$(":password").bind("keyup",function(){	// pssword 공백제거
		  var str_space = /\s/; 
		  if(str_space.exec($(this).val())) {
	        alert("공백을 사용할수 없습니다.");
	        $(this).focus();
	        $(this).val($(this).val().replace(" ", "")); 
	        return false;
		  }
	});
	
	$("#sample2_detailAddress").bind("keyup",function(){	// 상세주소 공백제거
		  var str_space = /\s/; 
		  if(str_space.exec($(this).val())) {
	        alert("공백을 사용할수 없습니다.");
	        $(this).focus();
	        $(this).val($(this).val().replace(" ", "")); 
	        return false;
		  }
	});
	
	
	
	$("input[name=name]").bind("keyup",function(){	//이름 한글,영문만 사용가능
		 var regex= /[^(ㄱ-힣,a-zA-Z)]/;
		 var temp=$(this).val();
		 if(regex.test(temp)){ 
			 alert("한글,영문만 사용 가능합니다.")
			 $(this).val(temp.replace(regex,"")); 
			 }
		 });
	
	$("input[name=phone2]").bind("keyup",function(){	// 전화번호1 숫자만
		 var regex= /[^(0-9)]/;
		 var temp=$(this).val();
		 if(regex.test(temp)){ 
			 alert("숫자만 사용 가능합니다.")
			 $(this).val(temp.replace(regex,"")); 
			 }
		 });
	
	$("input[name=phone3]").bind("keyup",function(){	// 전화번호2 숫자만
		 var regex= /[^(0-9)]/;
		 var temp=$(this).val();
		 if(regex.test(temp)){ 
			 alert("숫자만 사용 가능합니다.")
			 $(this).val(temp.replace(regex,"")); 
			 }
		 });

//////////////////////////////////////////////////////////////////////////////////////
	
		
	$("#_emailCheck").on("click",function(){	// 1.이메일 체크
		var email = $("#_AccEmail").val();
		if(email == ""){
			alert("이메일을 입력해주세요");
			$("#_AccEmail").focus();
			return;
		}
		else{
			if(!regEmail.test(email)){
				alert("이메일 주소가 유효하지 않습니다.");
				$("#_AccEmail").focus();
				return;
			}
		}
		$.ajax({
			type:"GET",
			url: "/TAMINO/MemberCtrl?command=Account_emailCheck&email="+email,
			success: function(obj) {
				if(obj == "true"){
					alert("이미 존재하는 이메일 입니다.");
					$("#_AccEmail").val("");
					E = false;
				}
				else if(obj == "false"){
					alert("사용하셔도 좋습니다.")
					E = true;
				}
			},
			error:function(){
				alert("Error")
			}
		});
	});
	
	
	$("#_accPwd").on("change",function(){	// 2. 비밀번호 체크
		var a = $(this).val();
		if(a.length<5 || a.length>15){
			alert("비밀번호는 5~15자 가능합니다.")
			$(this).focus();
			P = false;
			if(a.length>15){
				$(this).val(a.substr(0,15));
			}
			
		}
		else{
			P = true;
		}
	});
	
	$("#_pwdCheck").on("change",function(){	// 2-1. 비밀번호 확인체크
		var b = $(this).val();
		if(b != $("#_accPwd").val()){
			alert("비밀번호와 다릅니다. 확인해주세요")
			$(this).focus();
			P = false;
		}
		else{
			P = true;
		}
	});
	
	$("input[name=name]").on("change",function(){ // 3. 이름 체크
		var c = $(this).val();
		if(c.length<1 || c.length>20){
			alert("이름은 1~20자 가능합니다.")
			$(this).focus();
			N = false;
		}
		else{
			N = true;
		}
	});
	
	$("input[name=phone2]").on("change",function(){	// 4-1.번호체크
		var d = $(this).val();
		if(!(d.length==3 || d.length==4)){
			alert("전화번호는 3~4자리를 입력해주세요.")
			$(this).focus();
			Phone = false;
			if(d.length>4){
				$(this).val(d.substr(0,4));
			}
		}
		else{
			Phone = true;
		}
	});
	
	$("input[name=phone3]").on("change",function(){	// 4-2.번호체크
		var d = $(this).val();
		if(!(d.length==3 || d.length==4)){
			alert("전화번호는 3~4자리를 입력해주세요.")
			$(this).focus();
			Phone = false;
			if(d.length>4){
				$(this).val(d.substr(0,4));
			}
		}
		else{
			Phone = true;
		}
	});
	

	

//////////////////////////////////////////////////////////////////////////////////////	
	
	
	
	$("#_account").on("click",function(){	//회원가입 클릭했을때
		$(":text").val("");
		$(":password").val("");
		$(".login").addClass('outani');
		$(".account").addClass('inani');
		setTimeout(function() {
			$(".account").css("display","inline");
			$(".login").css("display","none");
			$(".login").removeClass('outani');
		}, 550)
	});
	
	$("#_backLogin").on("click",function() {	// 회원가입창에서 로그인 클릭했을때
		$(":text").val("");
		$(":password").val("");
		E = false;
		P = false;
	    N = false;
		Phone = false;
		A = false;
		/* $(":search").val(""); */
		$(".account").addClass("outani");
		setTimeout(function() {
			$(".login").css("display","inline");
			$(".login").addClass("inani");
			$(".account").css("display","none");
			$(".account").removeClass('outani');
		}, 550)
	});
	
	$("#_findEP").on("click",function(){
		$(":text").val("");
		$(":password").val("");
		$(".login").addClass('outani');
		$(".EPfind").addClass('inani');
		setTimeout(function() {
			$(".EPfind").css("display","inline");
			$(".login").css("display","none");
			$(".login").removeClass('outani');
		}, 550)
	});

/////////////////////////////////////////////////////////////////////////////////////

	$("#_findE").on("click",function(){	// email 찾기 클릭
		var name = document.getElementsByName("name")[1].value;
		var phone = document.getElementsByName("phone1")[1].value+"-"+document.getElementsByName("phone2")[1].value+"-"+document.getElementsByName("phone3")[1].value
		$.ajax({
			type:"GET",
			url: "/TAMINO/MemberCtrl?command=Find_Email&name="+name+"&phone="+phone,
			success: function(obj) {
				if(obj.trim() === ""){
					alert("찾으시는 Email이 없습니다.");
				}
				else {
					alert("Email:"+obj.trim());
				}
			},
			error:function(){
				alert("Error")
			}
		});
	});
	
	$("#_findP").on("click",function(){	// Pwd 찾기 클릭
		var email = document.getElementsByName("email")[2].value;
		var phone = document.getElementsByName("phone1")[2].value+"-"+document.getElementsByName("phone2")[2].value+"-"+document.getElementsByName("phone3")[2].value
		$.ajax({
			type:"GET",
			url: "/TAMINO/MemberCtrl?command=Find_Password&email="+email+"&phone="+phone,
			success: function(obj) {
				if(obj.trim() === "false"){
					alert("등록된 회원정보가 없습니다.");
				}
				else {
					alert("임시 비밀번호를 Email로 보냈습니다.");
				} 
			},
			error:function(){
				alert("Error")
			}
		});
		
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