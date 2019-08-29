<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
Calendar cal = Calendar.getInstance();
int year = cal.get(Calendar.YEAR);
int month = cal.get(Calendar.MONTH)+1;
int date = cal.get(Calendar.DATE);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<link href="https://fonts.googleapis.com/css?family=DM+Serif+Text|Roboto+Condensed&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:100,300,400|Roboto|Roboto+Mono|Viga&display=swap" rel="stylesheet">
<style type="text/css">
body{
	margin: 0px;
	width: 100%;
	min-height: 100%;
	position: absolute;
	font-family: 'Roboto Condensed', sans-serif;
	
}
#box1{/* 가장큰 div */
	margin-top: 5%;
	margin-bottom: 10%;
	margin-left: auto;
	margin-right: auto;
	width: 70%;
	height:auto;
}
#table1{
	margin: 0 auto;
	border-collapse: collapse;
	border: solid 1px;
}
th, td {
  	border: solid 1px;
    padding: 10px;
}
th{
	background-color: #9EACB3;
}

.sideBar{
	background-color: rgba(0,0,0,0.5);
}
.sideBar a{
	text-decoration: none;
	color: black;
	font-size: 30px;	
}
.sideMenu a{
	font-size: 40px;
}
.sideMenu a:hover{
	font-weight: bold;
	color: #EA9A56;
}
.menubar a {
	text-decoration: none;
	color: white;
	font-size: 25px;
}

.menubar a:hover {
	font-weight: bold;
	color: #EA9A56;
}
.sideMenu ul{
	list-style: none;
}
.sideMenu ul ul{
	display: none;
}
.sideMenu ul li:hover ul{
	display: block;
}
.inani{
	-webkit-animation:slide-in-left 0.6s 0s 1 ease-in forwards;
	animation:slide-in-left 0.6s 0s 1 ease-in forwards;
}
.outani{
	-webkit-animation:slide-out-left 0.6s 0s 1 ease-in forwards;
	animation:slide-out-left 0.6s 0s 1 ease-in forwards;
}
@-webkit-keyframes slide-in-left{0%{-webkit-transform:translateX(-500px);transform:translateX(-500px);opacity:0}100%{-webkit-transform:translateX(0);transform:translateX(0);opacity:1}}@keyframes slide-in-left{0%{-webkit-transform:translateX(-500px);transform:translateX(-500px);opacity:0}100%{-webkit-transform:translateX(0);transform:translateX(0);opacity:1}}
@-webkit-keyframes slide-out-left{0%{-webkit-transform:translateX(0);transform:translateX(0);opacity:1}100%{-webkit-transform:translateX(-500px);transform:translateX(-500px);opacity:0}}@keyframes slide-out-left{0%{-webkit-transform:translateX(0);transform:translateX(0);opacity:1}100%{-webkit-transform:translateX(-500px);transform:translateX(-500px);opacity:0}}
.spinner-master * {transition:all 0.3s;-webkit-transition:all 0.3s;box-sizing:border-box;}

.spinner-master {position:relative;margin-top:15px ;height:40px;width:40px;}

.spinner-master input[type=checkbox] {display:none;}
.spinner-master label {cursor:pointer;position:absolute;z-index:99;height:100%;width:100%;top:10px;left:0;}

.spinner-master .spinner {position:absolute;height:5px;width:100%;background-color:#000;}

.spinner-master .diagonal.part-1 {position:relative;float:left;}
.spinner-master .horizontal {position:relative;float:left;margin-top:6px;}
.spinner-master .diagonal.part-2 {position:relative;float:left;margin-top:6px;}

.spinner-master input[type=checkbox]:checked ~ .spinner-spin > .horizontal {opacity: 0;}
.spinner-master input[type=checkbox]:checked ~ .spinner-spin > .diagonal.part-1 {transform:rotate(405deg);-webkit-transform:rotate(405deg);margin-top:10px;}
.spinner-master input[type=checkbox]:checked ~ .spinner-spin > .diagonal.part-2 {transform:rotate(-405deg);-webkit-transform:rotate(-405deg);margin-top:-16px;}

.adminbtns{
	box-sizing: border-box;
	width: 20%;
	height: 30px;
	background-color: #79a8a9;
	color: #fff;
	font-family: 'Noto Sans KR:300', sans-serif;
	font-size: 13pt;
	border: none;
	border-radius: 10px;
	padding: 10px;
	line-height: 0px;
	cursor: pointer;
}

.adminbtns:hover{
	background-color: #1f4e5f;
	color: #fff;
}

.pageCaption{
	font-family: 'Noto Sans KR', sans-serif;
	font-size: 25pt;
}

</style>


<body>
<!-- Side Menu Bar -->
	<div class="sideBar" style="width: 0%; height:100%; top:0%; /* border: 1px solid black; */ position: absolute; margin: 0;">
		<div class="sideMenu" style="width: 60%; position: inherit; top: 33%; left: 12%; visibility:hidden;"  align="center">
		<ul>
			<li>
				<h1><a href="/TAMINO/AdminCtrl?command=Main_Page">Main</a></h1>
				<h1><a href="/TAMINO/AdminCtrl?command=ProductList&page=0">Product</a></h1>
				<ul>
					<li><h3><a href="/TAMINO/AdminCtrl?command=order_list&page=0">OrderList</a></h3></li>
					<li><h3><a href="/TAMINO/AdminCtrl?command=QnAList">Q&A</a></h3></li>
					<li><h3><a href="/TAMINO/AdminCtrl?command=Statistics">Statistics</a></h3></li>
				</ul>
			</li>
			<li><h1><a href="/TAMINO/AdminCtrl?command=Member_list&page=0">Member</a></h1></li>
			<li><h1><a href="/TAMINO/AdminCtrl?command=AdminSchedule">Schedule</a></h1></li>
			<li>
				<h1><a href="#" class="News">News</a></h1> 
				<ul>
					<li><h3><a href="/TAMINO/AdminCtrl?command=AdminPhoto">Photo</a></h3></li>
					<li><h3><a href="/TAMINO/AdminCtrl?command=Adminvideo">Video</a></h3></li>
				</ul>
			</li>
		</ul>	
		</div>
		<div style="width: 10%; height: 7%; position: inherit; /* border: 1px solid black; */ left: 100%; top: 46.5%;">
			<div class="spinner-master">
			  <input type="checkbox" id="spinner-form" />
			  <label for="spinner-form" class="spinner-spin">
			    <div class="spinner diagonal part-1"></div>
			    <div class="spinner horizontal"></div>
			    <div class="spinner diagonal part-2"></div>
			  </label>
			</div>
		</div>	
	</div>

<div id="box1">
<p class="pageCaption" align="center">Schedule 입력</p>
<form id="scheduleform" action="../AdminCtrl?command=ScheduleInsert" method="post" enctype="multipart/form-data">
<input type="hidden" name="command" value="ScheduleWrite">
<table id="table1">
<col width="100"><col width="500">
	<tr>
		<th>공연 명</th>
		<td><input type="text" name="schedule_title" id="title_txt" style="box-sizing: border-box; width: 90%"></td>
	</tr>
	
	<tr>
		<th>공연 일시</th>
		<td>
			<select name="schedule_year" id="year_txt">
				<%for(int i=year; i<year+5; i++){ %>
					<option value="<%=i %>"><%=i %>년</option>
				<%
				}
				%>
			</select>
		
			<select name="schedule_month" id="month_txt">
				<%for(int i=month; i<=12; i++){ %>
					<option value="<%=i %>"><%=i %>월</option>
				<%
				}
				%>
			</select>
			
			<select name="schedule_date" id="date_txt">
				<%for(int i=date; i<=31; i++){ %>
					<option value="<%=i %>"><%=i %>일</option>
				<%
				}
				%>
			</select>
		</td>
	</tr>
	
	<tr>
		<th>공연 시간</th>
		<td>
			<select name="schedule_hour" id="hour_txt">
				<%for(int i=0; i<24; i++){ %>
					<option value="<%=i %>"><%=i %>시</option>
				<%
				}
				%>
			</select>
		
			<select name="schedule_minute" id="minute_txt">
				<%for(int i=0; i<=50; i+=10){ %>
					<option value="<%=i %>"><%=i %>분</option>
				<%
				}
				%>
			</select>
		</td>
	</tr>
	
	<tr>
		<th>예매처</th>
		<td><input type="text" name="ticketlink" id="ticket_txt" style="box-sizing: border-box; width: 90%"></td>
	</tr>
	
	<tr>
		<th>사진</th>
		<td>
			<input type="file" name="poster_file" >
		</td>
	</tr>
	
	<tr>
		<th colspan="2">내용</th>
	</tr>
	
	<tr>
		<td colspan="2" align="center">
			<textarea rows="10" style="width: 95%" name="schedule_content" id="content_txt" ></textarea>
		</td>
	</tr>
	
	
	<tr>
		<th colspan="2" >공연 장소</th>
	</tr>
	<tr>	
		<td colspan="2" align="center">
			<input type="text" id="postcode_txt" placeholder="우편번호" style="height: 25px;">
			<input type="text" id="address_txt" name="schedule_place" style="height: 25px;" placeholder="주소">
			<input type="button" id="addressBtn" class="adminbtns" onclick="sample3_execDaumPostcode()" value="주소 찾기"><br>
			
			
			<!-- <input type="text" id="detailAddress_txt" placeholder="상세주소"> -->
			<!-- <input type="text" id="extraAddress_txt" placeholder="참고항목"> -->
			
			
			<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 0;position:relative">
			<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
			</div>
		</td>
	</tr>
	
	<tr>
		<td colspan="2" align="center">
			<input type="submit" class="adminbtns" id="writeBtn" value="작성하기">
		</td>
	</tr>
	
</table>
</form>
</div>



<%-- 
<form id="scheduleform" action="../AdminCtrl?command=ScheduleInsert" method="post" enctype="multipart/form-data">
<input type="hidden" name="command" value="ScheduleWrite">
<table border="1">
<col width="100"><col width="500">
	<tr>
		<th>공연 명</th>
		<td><input type="text" name="schedule_title" id="title_txt" style="box-sizing: border-box; width: 90%"></td>
	</tr>
	
	<tr>
		<th>공연 일시</th>
		<td>
			<select name="schedule_year" id="year_txt">
				<%for(int i=year; i<year+5; i++){ %>
					<option value="<%=i %>"><%=i %>년</option>
				<%
				}
				%>
			</select>
		
			<select name="schedule_month" id="month_txt">
				<%for(int i=month; i<=12; i++){ %>
					<option value="<%=i %>"><%=i %>월</option>
				<%
				}
				%>
			</select>
			
			<select name="schedule_date" id="date_txt">
				<%for(int i=date; i<=31; i++){ %>
					<option value="<%=i %>"><%=i %>일</option>
				<%
				}
				%>
			</select>
		</td>
	</tr>
	
	<tr>
		<th>공연 시간</th>
		<td>
			<select name="schedule_hour" id="hour_txt">
				<%for(int i=0; i<24; i++){ %>
					<option value="<%=i %>"><%=i %>시</option>
				<%
				}
				%>
			</select>
		
			<select name="schedule_minute" id="minute_txt">
				<%for(int i=0; i<=50; i+=10){ %>
					<option value="<%=i %>"><%=i %>분</option>
				<%
				}
				%>
			</select>
		</td>
	</tr>
	
	<tr>
		<th>예매처</th>
		<td><input type="text" name="ticketlink" id="ticket_txt" style="box-sizing: border-box; width: 90%"></td>
	</tr>
	
	<tr>
		<th>사진</th>
		<td>
			<input type="file" name="poster_file" >
		</td>
	</tr>
	
	<tr>
		<th colspan="2">내용</th>
	</tr>
	
	<tr>
		<td colspan="2" align="center">
			<textarea rows="10" style="width: 95%" name="schedule_content" id="content_txt" ></textarea>
		</td>
	</tr>
	
	
	<tr>
		<th colspan="2" >공연 장소</th>
	</tr>
	<tr>	
		<td colspan="2" align="center">
			<input type="text" id="postcode_txt" placeholder="우편번호">
			<input type="text" id="address_txt" name="schedule_place" placeholder="주소">
			<input type="button" onclick="sample3_execDaumPostcode()" value="주소 찾기"><br>
			
			
			<!-- <input type="text" id="detailAddress_txt" placeholder="상세주소"> -->
			<!-- <input type="text" id="extraAddress_txt" placeholder="참고항목"> -->
			
			
			<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 0;position:relative">
			<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
			</div>
		</td>
	</tr>
	
	<tr>
		<td colspan="2" align="center">
			<input type="submit" value="작성하기">
		</td>
	</tr>
	
</table>
</form>
 --%>
<script type="text/javascript">
$(function () {
	
	$("select[name='schedule_year']").on("change", function () {
		//alert($("select[name='schedule_year']").val());
		if($("select[name='schedule_year']").val() > <%=year %>){
			setMonth();
			setDay();
		}else if($("select[name='schedule_year']").val() == <%=year %>){
			resetMonth();
		}
	});
	
	$("select[name='schedule_month']").on("change", function () {
		//alert($("select[name='schedule_month']").val());
			setDay();
	});
	
	function setMonth(){	
		var str = "";
		for(i=1; i<13; i++){
			str += "<option value='" + i + "'>" + i + "월</option>";
		}
		
		$("select[name='schedule_month']").html(str);

	}
	
	function resetMonth(){	
		var str = "";
		for(i=<%=month %>; i<13; i++){
			str += "<option value='" + i + "'>" + i + "월</option>";
		}
		
		$("select[name='schedule_month']").html(str);

	}
	
	function setDay(){
		// 년도와 달을 통해서 마지막 날짜를 구한다
		
		var year = $("select[name='schedule_year']").val() +"";
		var month = $("select[name='schedule_month']").val() +"";
		var lastday = (new Date(year, month, 0)).getDate();
		
		// alert(lastday);
		
		var str = "";
		for(i = 1; i <= lastday; i++){
			str += "<option value='" + i + "'>" + i + "일</option>";
		}
		
		$("select[name='schedule_date']").html(str);
	}
	/* 
	$("#writeBtn").click(function () {
		$("#scheduleform").attr({"action":"ScheduleCtrl?command=ScheduleWrite", "method":"post"}).submit();
	});
	 */
});


var element_wrap = document.getElementById('wrap');

function foldDaumPostcode() {
    // iframe을 넣은 element를 안보이게 한다.
    element_wrap.style.display = 'none';
}

function sample3_execDaumPostcode() {
    // 현재 scroll 위치를 저장해놓는다.
    var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
    new daum.Postcode({
        oncomplete: function(data) {
            // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
    //        var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

    /*
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
                document.getElementById("extraAddress_txt").value = extraAddr;
            
            } else {
                document.getElementById("extraAddress_txt").value = '';
            }
    */

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postcode_txt').value = data.zonecode;
            document.getElementById("address_txt").value = addr;
            // 커서를 상세주소 필드로 이동한다.
     //       document.getElementById("detailAddress_txt").focus();

            // iframe을 넣은 element를 안보이게 한다.
            // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
            element_wrap.style.display = 'none';

            // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
            document.body.scrollTop = currentScroll;
        },
        // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
        onresize : function(size) {
            element_wrap.style.height = size.height+'px';
        },
        width : '100%',
        height : '100%'
    }).embed(element_wrap);

    // iframe을 넣은 element를 보이게 한다.
    element_wrap.style.display = 'block';
}

</script>

<script type="text/javascript">
$(function () {
	var i = 0;
	$("#spinner-form").on("click",function(){
		i++;
		if(i%2==1){
			setTimeout(function() {
				/* $(".sideBar").removeClass('inani'); */
				$(".sideBar").addClass("inani");
				$(".sideBar").css("width","13%");
				$(".sideMenu").css("visibility","visible");
			}, 300)
			}
			
			else{
				$(".sideBar").removeClass('inani');
				$(".sideBar").addClass("outani");
				setTimeout(function() {
					$(".sideBar").removeClass('outani');
					$(".sideMenu").css("visibility","hidden");
					$(".sideBar").css("width","0%");
				}, 600)
			}
	});
});

</script>



</body>
</html>