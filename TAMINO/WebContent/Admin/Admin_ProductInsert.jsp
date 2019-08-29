<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css?family=DM+Serif+Text|Roboto+Condensed&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:100,300,400|Roboto|Roboto+Mono|Viga&display=swap" rel="stylesheet">
<style type="text/css">
body{
	margin: 0px;
	width: 100%;
	min-height: 100%;
	position: absolute;
	font-family: 'Noto Sans KR', sans-serif;
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

.filebox{
text-align: center;  
}

input :text{
	width: 99%;
	height: auto;
}
img{
	width: 150px;
	height: 150px;
}
:text {
	width: 50px;
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
.filebox label { display: inline-block; padding: .5em .75em; color: #999; font-size: inherit; line-height: normal; vertical-align: middle; background-color: #fdfdfd; cursor: pointer; border: 1px solid #ebebeb; border-bottom-color: #e2e2e2; border-radius: .25em; } 
.filebox input[type="file"] { /* 파일 필드 숨기기 */ position: absolute; width: 1px; height: 1px; padding: 0; margin: -1px; overflow: hidden; clip:rect(0,0,0,0); border: 0; }

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
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
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
<div id="box1" align="center">
<p class="pageCaption">상품 등록</p>
<form action="/TAMINO/AdminCtrl?command=addProduct" method="post" enctype="multipart/form-data">
<table id="table1">
<col width="80"><col width="225"><col width="225">
<tr>
	<th colspan="3"><p>상품등록창</p></th>
</tr>
<!-- 상품명 -->
<tr> 
	<th>상품명</th>
	<td colspan="2"><input type="text" name="title"></td>
	<!-- 상품사진 -->
	 
</tr>
<!-- 가격 -->
<tr>
	<th>가격</th>
	<td colspan="2"><input type="text" name="price"></td>
</tr>
<!-- 상품분류 -->
<tr>
	<th>분류</th>
	<td colspan="2">
		<select name="pCode">
			<option selected="selected">선택</option>
			<option>의류</option>
			<option>악세사리</option>
			<option>앨범</option>
			<option>기타</option>
		</select>
	</td>
</tr>
<!-- 재고수+사이즈 -->
<tr>
	<th>재고수</th>  
	<td colspan="2">
		<input type="text" name="pCount_s" class="closeTd" placeholder="SIZE_S" style="display: none;">
		<input type="text" name="pCount_m" class="closeTd" placeholder="SIZE_M" style="display: none;">
		<input type="text" name="pCount_l" class="closeTd" placeholder="SIZE_L" style="display: none;">	
	
		<input type="text" class="otherTd" name="pCount_o" placeholder="SIZE_O" placeholder="재고수" style="display: inline-block;">
	</td>
</tr>
<!-- 상품 사이즈 -->
<!-- <tr>
	<th>사이즈</th>
	<td>
		<select name="pSize">
			<option selected="selected">해당없음</option>
			<option>Small</option>
			<option>Medium</option>
			<option>Large</option>
		</select>
	</td>
</tr>  -->
<!-- 상품 이미지 -->
<tr>
	<br>
	<td colspan="3">
		<%
		for(int i=0; i<2 ; i++){
			%>
		<div class="filebox" style="width: 50%; height: auto; float: left;" >
			<label for="product_img<%=i+1 %>">이미지<%=i+1 %></label>
			<input type="file" id="product_img<%=i+1 %>" name="fileload<%=i+1%>">
			<br>
			<img alt="" src="#" id="img<%=i+1%>">
		</div>
			<%
		}
		
		%>
	</td>
</tr>
<tr>
		<td colspan="3">
		
		<%
		for(int i=2; i<4 ; i++){
			%>
		<div class="filebox" style="width: 50%; height: auto; float: left;" >
			<label for="product_img<%=i+1 %>">이미지<%=i+1 %></label>
			<input type="file" id="product_img<%=i+1 %>" name="fileload<%=i+1%>">
			<br>
			<img alt="" src="#" id="img<%=i+1%>">
		</div>
			<%
		}
		
		%>
	</td>
</tr>
<!-- 사진 미리보기 -->	
<script>
		<%
			for(int i=0; i<4; i++){
				%>
				function fileCheck(obj) {
					pathpoint = obj.value.lastIndexOf('.');
					filepoint = obj.value.substring(pathpoint+1,obj.length);
					filetype = filepoint.toLowerCase();
					if(filetype=='jpg'||filetype=='gif'||filetype=='png'||filetype=='jpeg'||filetype=='bmp'){
						/* 정상파일 */
					}
					else{
						alert("이미지 파일만 선택할 수 있습니다.");
						/* parentObj = obj.parentNode
						node = parentObj.replaceCh */ild(obj.cloneNode(true), obj);
						return;

					}
					if(filetype=='bmp'){
						upload = confirm('BMP 파일은 웹상에서 사용하기엔 적절하지 않습니다. \n 그래도 계속 하시겠습니까?');
						if(!upload) return;
					}
					
					
				}
				
				function readURL<%=i+1%>(input) {
					 if (input.files && input.files[0]) {
					  var reader = new FileReader();
					  
					  reader.onload = function (e) {
					   $('#img<%=i+1%>').attr('src', e.target.result);  
					  }
					  
					  reader.readAsDataURL(input.files[0]);
					  }
					}
					  
					$("#product_img<%=i+1%>").on("change",function(){
						/* alert("들어옵니당."); */
					   fileCheck(this);
					   readURL<%=i+1%>(this);
					});
							
				<%
			}
		%>
</script>


<!-- 상품 상세설명 -->
<tr>
	<th colspan="3">상세설명</th>
</tr>
<tr>
	<td colspan="3">
		<textarea rows="10" cols="70" name="content"></textarea>
	</td>
</tr>
<tr>
	<td colspan="3">
		<p>
		<input type="submit" id="writeBtn" value="상품등록" class="adminbtns" style="float: left; "disabled="disabled">
		<button type="button" id="backBtn" class="adminbtns" style="float: right;" onclick="javascript:history.back();">뒤로가기</button>
		</p>	
	</td>
</tr>
</table>
</form>
</div> 
<%-- 
<div align="center">
<form action="../AdminCtrl?command=addProduct" method="post" enctype="multipart/form-data">
<table border="1">
<col width="80"><col width="225"><col width="225">
<tr>
	<th colspan="3"><p>상품등록창</p></th>
</tr>
<!-- 상품명 -->
<tr> 
	<th>상품명</th>
	<td><input type="text" name="title"></td>
	<!-- 상품사진 -->
	 
</tr>
<!-- 가격 -->
<tr>
	<th>가격</th>
	<td><input type="text" name="price"></td>
</tr>
<!-- 상품분류 -->
<tr>
	<th>분류</th>
	<td>
		<select name="pCode">
			<option selected="selected">의류</option>
			<option>악세사리</option>
			<option>앨범</option>
			<option>기타</option>
		</select>
	</td>
</tr>
<!-- 재고수+사이즈 -->
<tr>
	<th>재고수</th> 
	<td colspan="3"  id="closeTd" style="display: none;">
		<input type="text" name="pCount_s"  placeholder="Small재고">
		<input type="text" name="pCount_m"  placeholder="Medium재고">
		<input type="text" name="pCount_l"  placeholder="Large재고">	
	</td>
	<td colspan="3"  id="otherTd" style="display: block;">
		<input type="text" name="pCount_o" placeholder="재고수">
	</td>
</tr>
<!-- 상품 사이즈 -->
<!-- <tr>
	<th>사이즈</th>
	<td>
		<select name="pSize">
			<option selected="selected">해당없음</option>
			<option>Small</option>
			<option>Medium</option>
			<option>Large</option>
		</select>
	</td>
</tr>  -->
<!-- 상품 이미지 -->
<tr>
	<br>
	<th colspan="3">
		<%
		for(int i=0; i<2 ; i++){
			%>
		<div class="filebox" style="width: 50%; height: auto; float: left;" >
			<label for="product_img<%=i+1 %>">이미지<%=i+1 %></label>
			<input type="file" id="product_img<%=i+1 %>" name="fileload<%=i+1%>">
			<br>
			<img alt="" src="#" id="img<%=i+1%>">
		</div>
			<%
		}
		
		%>
	</th>
</tr>
<tr>
		<th colspan="3">
		
		<%
		for(int i=2; i<4 ; i++){
			%>
		<div class="filebox" style="width: 50%; height: auto; float: left;" >
			<label for="product_img<%=i+1 %>">이미지<%=i+1 %></label>
			<input type="file" id="product_img<%=i+1 %>" name="fileload<%=i+1%>">
			<br>
			<img alt="" src="#" id="img<%=i+1%>">
		</div>
			<%
		}
		
		%>
	</th>
</tr>
<!-- 사진 미리보기 -->	
<script>
		<%
			for(int i=0; i<4; i++){
				%>
				function fileCheck(obj) {
					pathpoint = obj.value.lastIndexOf('.');
					filepoint = obj.value.substring(pathpoint+1,obj.length);
					filetype = filepoint.toLowerCase();
					if(filetype=='jpg'||filetype=='gif'||filetype=='png'||filetype=='jpeg'||filetype=='bmp'){
						/* 정상파일 */
					}
					else{
						alert("이미지 파일만 선택할 수 있습니다.");
						/* parentObj = obj.parentNode
						node = parentObj.replaceCh */ild(obj.cloneNode(true), obj);
						return;

					}
					if(filetype=='bmp'){
						upload = confirm('BMP 파일은 웹상에서 사용하기엔 적절하지 않습니다. \n 그래도 계속 하시겠습니까?');
						if(!upload) return;
					}
					
					
				}
				
				function readURL<%=i+1%>(input) {
					 if (input.files && input.files[0]) {
					  var reader = new FileReader();
					  
					  reader.onload = function (e) {
					   $('#img<%=i+1%>').attr('src', e.target.result);  
					  }
					  
					  reader.readAsDataURL(input.files[0]);
					  }
					}
					  
					$("#product_img<%=i+1%>").on("change",function(){
						/* alert("들어옵니당."); */
					   fileCheck(this);
					   readURL<%=i+1%>(this);
					});
							
				<%
			}
		%>
</script>


<!-- 상품 상세설명 -->
<tr>
	<th><br><br>상세설명</th>
</tr>
<tr>
	<td colspan="3">
		<textarea rows="10" cols="70" name="content"></textarea>
	</td>
</tr>
<tr>
	<td colspan="3">
		<p>
		<input type="submit" value="상품등록" style="float: left; "disabled="disabled">
		<button type="button" style="float: right;" onclick="javascript:history.back();">뒤로가기</button>
		</p>	
	</td>
</tr>
</table>
</form>
</div>

 --%>

<script type="text/javascript">
$(document).ready(function() {
	var titleCheck = false;
	var priceCheck = false;
	var codeCheck = false;
	var textAreaCheck = false;
	var pCountCheck = false;
	/* var imgCheck = false; */
	
	$("input[name=title]").on("change",function(){	//상품명제한
		var pName = $(this).val();
		/* alert("pName:"+pName); */
		if(pName.length>50 || pName.length<1){
			alert("상품명은 1~15자사이로 해주세요!");
			$(this).val("");
			$(this).focus();
			titleCheck = false;
			return;
		}
		titleCheck = true;
		if(titleCheck && priceCheck && codeCheck && pCountCheck && textAreaCheck){
			$(":submit").attr("disabled",false);
		}

	});
	$("input[name=price]").on("change",function(){	//가격제한
		var price = $(this).val();
		/* alert("pName:"+pName); */
		if(price.length>8){
			alert("가격은 100.000.000 아래로 가능합니다.");
			$(this).val("");
			$(this).focus();
			priceCheck = false;
			return;
		}
		
		else if(/[^0123456789]/g.test(price)){
			alert("숫자만 입력 가능합니다.");
			$(this).val("");
			$(this).focus();
			priceCheck =false;
			return;
		}
		priceCheck = true;
		if(titleCheck && priceCheck && codeCheck && pCountCheck && textAreaCheck ){
			$(":submit").attr("disabled",false);
		}

	});
	
	
	$("input[name=pCount_s], input[name=pCount_m], input[name=pCount_l], input[name=pCount_o]").on("change",function(){	//재고수
		/* alert("변화감지"); */
		var pCount = $(this).val();
		/* alert("pCount:"+pCount);  */
		if(pCount.length>5){
			alert("재고수는 0~99999까지 가능합니다.");
			$(this).val(pCount.substr(0, 5));
			$(this).focus();
			pCountCheck = false;
			return;
		}
		else if(/[^0123456789]/g.test(pCount)){
			alert("숫자만 입력 가능합니다.");
			$(this).val("");
			$(this).focus();
			pCountCheck = false;
			return;
		}
		pCountCheck = true;
		if(titleCheck && priceCheck && pCountCheck &&  codeCheck && textAreaCheck ){
			$(":submit").attr("disabled",false);
		}

	}); 
	
	
	$("textarea").on("change",function(){
		var content = $(this).val();
		if(content.length<1){
			alert("내용은 꼭 기입해주세요!");
			
			$(this).val("");
			$(this).focus();
			textAreaCheck = false;
			return;
			
		}
		textAreaCheck =true;
		if(titleCheck && priceCheck &&  codeCheck  && pCountCheck &&  textAreaCheck ){
			$(":submit").attr("disabled",false);
		}

	});
	
	
	$("select").on("change",function(){
		var select = $(this).val();
		if(select.trim()=="선택"){
			codeCheck = false;
		}
		else {
			if(select=="의류"){
				$(".closeTd").css("display","inline-block");
				$(".otherTd").css("display","none");
			}
			else{
				$(".otherTd").css("display","inline-block");
				$(".closeTd").css("display","none");
			}
			codeCheck = true;
			if(titleCheck && priceCheck &&  codeCheck && pCountCheck &&  textAreaCheck ){
				$(":submit").attr("disabled",false);
			}
		}
	});

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
    
