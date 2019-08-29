<%@page import="dto.StoreQnADto"%>
<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemberDto logindto = (MemberDto)session.getAttribute("login");
	StoreQnADto dto = (StoreQnADto)request.getAttribute("QnADetail");
	String product_name = request.getAttribute("product_name")+"";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="/TAMINO/Store/css/Store_QnA.css">
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:100,300,400|Roboto|Roboto+Mono|Viga&display=swap" rel="stylesheet">
<style type="text/css">
.modal{
	display: none;
	position: fixed;
	z-index: 1;
	background-color: rgb(0,0,0,0);
	/* padding-top: 5%; */
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
}

.modal_content{
	  background-color: #fff;
	  margin: auto;
	  padding: 20px;
	  border: 1px solid #888;
	  width: 70%;
	  height: 430px;
}

.close{
	float: right;
	display: inline-block;
	size: 15px 15px;
	cursor: pointer;
	margin-left: 15px;
	margin-right: 20px;
}
</style>
</head>
<body>

<div align="center">
<table border="1" class="modaltable">
<col width="200"><col width="500">
	<tr>
		<th>제목</th>
		<td>
			<%=dto.getQna_title() %>
		</td>
	</tr>
	<tr>
		<th>작성자</th>
		<td>
			<%=dto.getQna_email() %>
		</td>
	</tr>
	
	<tr>
		<th>상품명</th>
		<td><%=product_name %></td>
	</tr>
	
	<tr>
		<th>분류</th>
		<td>
			<%=dto.getQna_category() %>
		</td>
	</tr>
	<tr>
		<th>내용</th>
		<td align="center">
			<textarea name="qna_content" rows="10" style="width: 95%" readonly="readonly"><%=dto.getQna_content() %></textarea>
		</td>
	</tr>
	
	<tr>
	
		<td colspan="2">
			<button type="button" id="backBtn" class="detailBtn" style="float: left;">돌아가기</button>
		
		<%if(logindto != null && logindto.getEmail().equals(dto.getQna_email())){%>
			
				<button type="button" id="updateBtn" class="detailBtn" style="float: right;">수정하기</button>
				<button type="button" id="deleteBtn" class="detailBtn" style="float: right;">삭제하기</button>
			
		<%	
		}
		%>
		</td>
	</tr>
</table>
</div>

<div id="modal_layer1" class="modal">
	<div id="modal_layer2" class="modal_content">
		<div class="close" id="close_span"><img src="/TAMINO/image/close.png" width="15px" height="15px"></div>
		
		<form id="updatefrm">
			<input type="hidden" name="product_seq" value="<%=dto.getQna_product_seq() %>">
			<input type="hidden" name="qna_seq" value="<%=dto.getQna_seq() %>">
			<input type="hidden" name="qna_email" value="<%=dto.getQna_email() %>">
			<table border="1" class="modaltable" >
			<col width="200"><col width="400">
				<tr>
					<th>제목</th>
					<td>
						<input type="text" id="QnAtitle_txt" name="qna_title" value="<%=dto.getQna_title() %>">
					</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>
						<%=dto.getQna_email() %>
					</td>
				</tr>
				
				<tr>
					<th>상품명</th>
					<td><%=product_name %></td>
				</tr>
				
				<tr>
					<th>분류</th>
					<td>
						<select name="qna_category">
							<option value="notselect">분류선택</option>
							<option value="배송문의">배송문의</option>
							<option value="상품문의">상품문의</option>
							<option value="기타">기타</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td align="center">
						<textarea name="qna_content" rows="10" style="width: 95%"><%=dto.getQna_content() %></textarea>
					</td>
				</tr>
				
				<tr>
					<td colspan="2" align="center"> 
						<button type="button" id="writeBtn">수정완료</button>
					</td>
				</tr>
			
			</table>
		</form>
		
	</div>	
</div>

<script type="text/javascript">
$(function () {
	$("#backBtn").click(function() {
		location.href = "/TAMINO/StoreCtrl?command=QnAList&seq=" + <%=dto.getQna_seq() %> + "&product_seq=" + <%=dto.getQna_product_seq() %>;
	});
	
	$("#updateBtn").click(function() {
		$("#modal_layer1").css("display", "block");
		$("select[name=qna_category]").val("<%=dto.getQna_category() %>").attr("selected", "selected");
	});
	
	$("#writeBtn").click(function () {
		if($.trim($("#QnAtitle_txt").val()) == "" || $.trim($("textarea[name=qna_content]").val()) == ""){
			alert("제목과 내용은 필수로 입력해주십시오");
			return;
		}
		if($("select[name=qna_category]").val() == "notselect"){
			alert("분류를 선택해주세요");
			return;
		}
		
		var formData = $("#updatefrm").serialize();
		$.ajax({
			type: 'get',
			url: '/TAMINO/StoreCtrl?command=updateQnA',
			data: formData, 
			datatype : 'json',
			success: function () {
				alert("성공");
				location.href = "/TAMINO/StoreCtrl?command=QnAList&product_seq="+<%=dto.getQna_product_seq() %>;
			},
			error: function () {
				alert("에러");
			}
		})
		
	});
	
	$("#close_span").click(function () {
		$("#modal_layer1").css("display", "none");
	});
	
	$("#deleteBtn").click(function() {
		location.href = "/TAMINO/StoreCtrl?command=deleteQnA&seq=" + <%=dto.getQna_seq() %> + "&product_seq=" + <%=dto.getQna_product_seq() %>;
	});
});
</script>
</body>
</html>