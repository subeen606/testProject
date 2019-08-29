<%@page import="dto.MemberDto"%>
<%@page import="dto.ScheduleDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
public String convertMonth(String month){
	String change = "";
	if(month.equals("01")){
		change = "JAN";
	}if(month.equals("02")){
		change = "FEB";
	}if(month.equals("03")){
		change = "MAR";
	}if(month.equals("04")){
		change = "APR";
	}if(month.equals("05")){
		change = "MAY";
	}if(month.equals("06")){
		change = "JUN";
	}if(month.equals("07")){
		change = "JUL";
	}if(month.equals("08")){
		change = "AUG";
	}if(month.equals("09")){
		change = "SEP";
	}if(month.equals("10")){
		change = "OCT";
	}if(month.equals("11")){
		change = "NOV";
	}if(month.equals("12")){
		change = "DEC";
	}
	return change;
}

%>
<%
Object ologin = session.getAttribute("login");
MemberDto mdto = null;
mdto = (MemberDto)ologin;
List<ScheduleDto> list = (List<ScheduleDto>)request.getAttribute("scheduleList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4cffb49827e0daa41ea284ad8c5c6748&libraries=services"></script>
<link href="https://fonts.googleapis.com/css?family=Rasa+DM+Serif+Text|Roboto+Condensed&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Libre+Baskerville|Merriweather|Rasa&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/TAMINO/News/Navibar.css?after">
<style type="text/css">
.modal{
	display: none;
	position: fixed;
	z-index: 1;
	background-color: rgb(0,0,0,0);
	padding-top: 10%;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
}

.modal_content{
	 background-color: rgb(255,255,255,0.8);
	  margin: auto;
	  padding: 40px;
	  border: 1px solid #888;
	  width: 60%;
	  height: 600px;
}

.close{
	float: right;
	size: 20px 20px;
	cursor: pointer;
}

body{
	background: url("./image/background.png") no-repeat center center fixed;
	-webkit-background-size: cover;
	-moz-background-size: cover;
	-o-background-size: cover;
	background-size: cover;
}

span{
	margin-bottom: 20px;
	font-family: 'Roboto Condensed', sans-serif;
}

div#schedulespans{
	margin-left: 10px;
	margin-bottom: 1.5rem;
}

span#date_span{
	font-family: 'Roboto Condensed', sans-serif;
	font-size: 20px;
	margin-bottom: 20px;
}

span#time_span{
	font-family: 'Roboto Condensed', sans-serif;
	font-size: 20px;
}

span#content_span{
	line-height: 30px;
}

.ticketBtn{
	background-color: black;
	color: #fff;
	font-size: 15px;
	border: 0px;
	padding: 10px 10px;
	width: 100px;
	cursor: pointer;
	font-style: italic;
}

table{
	/* font-family: Sitka Text; */
	font-family: 'Libre Baskerville', serif;
	color: #c7c0bb; 
	width: 60%; 
	font-size: 15pt;
	border-collapse: collapse;
	border: none;
	margin-top: 600px;
}

table tr{
	height: 50px;
	border-bottom: 1px solid black;
}

table th{
	padding-left: 30px;
}

table td{
	font-style: italic;
	padding: 15px;
}

tr:hover{
	background-color: rgb(0,0,0,0.5);
}

.click_title{
	cursor: pointer;
}
</style>
</head>
<body>

<!-- header -->
<div class="header" style="background-color: rgba(255,255,255,0.5)">
		<div class="header_container">
			<div class="header_content">
				<div class="logo">
						<a href="/TAMINO/AdminCtrl?command=Main_Page"><img src="/TAMINO/image/logo.png"></a>
				</div>
				
				<div class="navbar">
						<a href="/TAMINO/newscontrol?command=list">NEWS</a>
						<a href="/TAMINO/ScheduleCtrl?command=schedule">SCHEDULE</a>
						<a href="/TAMINO/StoreCtrl?command=StoreMain">STORE</a>
						<%
							if(mdto != null){
								%>
								<a href="/TAMINO/MemberCtrl?command=logout">LOGOUT</a>
								<%
							}
							else{
								%>
								<a href="/TAMINO/MemberCtrl?command=login">LOGIN</a>
								<%								
							}
						%>
						
				</div>
				
			</div>
		</div>
	
</div>


<div align="center">
<table  >
	<%for(int i=0; i<list.size(); i++){
		ScheduleDto dto = list.get(i);
		String year = dto.getSchedule_date().substring(0, 4);
		String month = dto.getSchedule_date().substring(4, 6);
		String day = dto.getSchedule_date().substring(6, 8);
		String hour = dto.getSchedule_time().substring(0, 2);
		String minute = dto.getSchedule_time().substring(2, 4);
		
		//System.out.println("year: " + year + " month: " + month + " day: " + day);
	%>
		<tr>
			<th align="left"><%=year %> <%=convertMonth(month) %> <%=day %></th>
			<td class="click_title" seq=<%=dto.getSeq() %> addr="<%=dto.getSchedule_place() %>" title="<%=dto.getSchedule_title() %>" 
				content="<%=dto.getSchedule_content() %>"date="<%=year %>.<%=month %>.<%=day %>" time="<%=hour %>:<%=minute %>"
				poster="<%=dto.getSchedule_poster() %>">
				<%=dto.getSchedule_title() %>&nbsp;&nbsp;
				<img alt="" src="./image/pin.png" width="20px" height="20px">
			</td>
			<td align="center">
				<button class="ticketBtn" onclick="window.open('<%=dto.getTicketLink() %>')">T I C K E T</button>
			</td>
		</tr>
			
	<%	
	}
	%>

</table>
</div>

<div id="modal_layer1" class="modal">
	<div id="modal_layer2" class="modal_content">
			<div id="schedulespans">
			<span class="close" id="close_span"><img src="./image/close.png" width="20px" height="20px"></span>
			<span id="title_span" style="font-size: 25pt"></span>
			&nbsp;&nbsp;<span id="date_span"></span>&nbsp;&nbsp;<span>/</span>&nbsp;
			<span id="time_span"></span><br>
			<span id="content_span"></span><br>
			</div>
			<div style="float: left; margin-left:10px; margin-right: 20px">
				<img id="poster_img" width="300px" height="420px">
			</div>
			<div id="map" style="width:700px;height:420px;" style="float: left;"></div>
	</div>
		
</div>


<script type="text/javascript">
$(function () {

	$(".click_title").click(function () {
		//alert("클릭");
		//alert($(this).attr("addr"));
		$("#modal_layer1").css("display", "block");
		
		$("#poster_img").attr("src", "./poster/" + $(this).attr("poster"));
		$("#title_span").text($(this).attr("title"));
		$("#date_span").text($(this).attr("date"));
		$("#time_span").text($(this).attr("time"));
		$("#content_span").text($(this).attr("content"));
		
		var geocoder = new kakao.maps.services.Geocoder();

		var callback = function(result, status) {
		    if (status === kakao.maps.services.Status.OK) {
		        console.log(result);
		        	        
		        var coords = new daum.maps.LatLng(result[0].y, result[0].x);
		        
		        var mapContainer = document.getElementById('map');
				var mapOption = {
					center: new daum.maps.LatLng(result[0].y, result[0].x),
					level: 3
				};

				var map = new kakao.maps.Map(mapContainer, mapOption); 

				var imageSrc = './image/marker.png', // 마커이미지의 주소입니다    
				imageSize = new kakao.maps.Size(50, 53), // 마커이미지의 크기입니다
				imageOption = {offset: new kakao.maps.Point(20, 60)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

				// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
				var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
				    markerPosition = coords // 마커가 표시될 위치입니다

				// 마커를 생성합니다
				var marker = new kakao.maps.Marker({
				    position: markerPosition, 
				    image: markerImage // 마커이미지 설정 
				});

				// 마커가 지도 위에 표시되도록 설정합니다
				marker.setMap(map);   

				map.relayout();
				map.setCenter(coords);
		    }
		};
				
		geocoder.addressSearch($(this).attr("addr"), callback);

	});
	
	$("#close_span").click(function () {
		$("#modal_layer1").css("display", "none");
	});
});



</script>
 
 


</body>
</html>