<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	MemberDto memDto = (MemberDto)request.getAttribute("memDto");
	
	String phoneNum[] = { "010","011","016","017","018","019","070"};
	String pickNum = memDto.getPhoneNumber().split("-")[0];
%>   
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
/* .slideshow-container input{
	border: none;
	width: 350px;
} */
.slideshow-container input:focus {
	outline: none;
}

</style>
</head>
<body>

<div class="header">
	<div class="header-content">
		<a><img id="logoimg" src="/TAMINO/image/taminoKLEIN.png"></a> <!-- Main 링크 걸기 -->
		<div class="menu">
		<a  href="/TAMINO/AdminCtrl?command=Main_Page" id="main">MAIN</a>
		<a href="/TAMINO/StoreCtrl?command=StoreMain" id="store">STORE</a>
		<a id="mypage" onclick="openNav()">MY PAGE</a>
		</div>
		
		<div class="login">
			<a id="login">LOGIN</a>
		</div>
	</div>
</div>


<div class="infodiv" align="center" >
<p>회원정보 수정</p>
<form action="/TAMINO/MemberCtrl" method="post">
<input type="hidden" name="command" value="updateInfo">
<table class="infotable" >
	<col width="30%">
	<tr>
		<th><h3>이름</h3></th>
		<td><input type="text" name="name" style="border-bottom: 1px solid black;" placeholder="<%=memDto.getUserName()%>" value="<%=memDto.getUserName()%>"></td>
	</tr>
	<tr>
		<th><h3>비밀번호</h3></th>
		<td><input type="password" name="password" style="border-bottom: 1px solid black;" value="<%=memDto.getPassword()%>" placeholder=""></td>
	</tr>
	<tr>
		<th><h3>비밀번호 확인</h3></th>
		<td><input type="password" style="border-bottom: 1px solid black;"></td>
	</tr>
	<tr>
		<th><h3>전화번호</h3></th>
		<td>
			<select name="phonenumber1" value="<%=memDto.getPhoneNumber().split("-")[0]%>" style="width: 100px; height: 36px;">
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
			</select>-
			<input class="phone" type="text" name="phonenumber2" value="<%=memDto.getPhoneNumber().split("-")[1]%>" placeholder="<%=memDto.getPhoneNumber().split("-")[1] %>"> - <input type="text" class="phone" placeholder="<%=memDto.getPhoneNumber().split("-")[2] %>" name="phonenumber3" value="<%=memDto.getPhoneNumber().split("-")[2]%>">
		</td>
	</tr>
	<tr>
		<th rowspan="3"><h3>주소</h3></th><td colspan="2"><input type="text" id="sample2_postcode" class="address" name="address1" placeholder="우편번호" value="<%=memDto.getAddress().split("-")[0]%>">
		<input type="button" onclick="sample2_execDaumPostcode()" class="adbtn" value="우편번호 찾기"></td>
	</tr>
	<tr>
		<td><input type="search" style="width: 442px" id="sample2_address" class="address" name="address2" placeholder="주소" value="<%=memDto.getAddress().split("-")[1]%>"></td>
	</tr>
	<tr>
		<td><input type="search" id="sample2_detailAddress" name="address3" class="address" placeholder="상세주소" value="<%=memDto.getAddress().split("-")[2]%>">
		<input type="search" id="sample2_extraAddress" class="address" name="address4" placeholder="참고사항" value="<%=memDto.getAddress().split("-")[3]%>"></td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<br><br>
			<input type="submit" value="수정하기" class="btns">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<!-- <button type="button" class="btns">뒤로가기</button> -->
		</td>
	</tr>
</table>
</form>
</div>


<div id="myNav" class="overlay">
<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
	<div class="overlay-content">
		<p>MY PAGE</p>
    	<a href="/TAMINO/MemberCtrl?command=myInfo&email=<%=currId %>">회원정보 수정</a>
    	<a href="/TAMINO/MemberCtrl?command=MyOrderList">주문내역</a>
  	</div>

</div>


<br>

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