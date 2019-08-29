<%@page import="dto.MemberDto"%>
<%@page import="dto.StoreQnADto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
public String arrow(int depth){
	String rs = "<img src='./image/arrow.png' width='20px' height='20px'>&nbsp;&nbsp;";
	String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;";
	
	String ts = "";
	for(int i = 0; i < depth; i++){
		ts += nbsp;
	}
	return depth==0?"":ts+rs;
}
%>
<%
List<StoreQnADto> list = (List<StoreQnADto>)request.getAttribute("QnAList");
int pages = (int)request.getAttribute("pages");

MemberDto logindto = (MemberDto)session.getAttribute("login");
String product_seq = request.getAttribute("product_seq") + "";
String product_name = request.getAttribute("product_name") + "";
System.out.println("product_seq");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link rel="stylesheet" href="/TAMINO/Store/css/Store_QnA.css?after">
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
<%
	String currId = "guest";
	if( request.getSession().getAttribute("login") != null ){
		MemberDto loginDto = (MemberDto)request.getSession().getAttribute("login");
		currId = loginDto.getEmail();
	}

%>
<input type="hidden" value="<%=currId %>" id="currId"> 
<div align="center">
<div class="qnacaption">Q&A Board</div>
<table border="1" class="qnatable">
<col width="50px"><col width="150px"><col width="500px"><col width="200px"><col width="150px">
	<thead>
	<tr>
		<th>No.</th><th>분류</th><th>제목</th><th>작성자</th><th>작성일</th>
	</tr>
	</thead>
	<% if(list.size() == 0 || list == null){%>
		<tr>
			<td colspan="5" align="center">작성된 QnA가 없습니다.</td>
		</tr>
	<%	
	}else{
		for(int i=0; i<list.size(); i++){
			StoreQnADto dto = list.get(i);
		%>
			<tr class="boardrow">
				<td align="center"><%=i+1 %></td>
				<%if(dto.getQna_del() == 1){%>
					<td colspan="4" class="Deltitle">삭제된 게시글</td>
				<%
				}else{%>
					<td align="center"><%=dto.getQna_category() %></td>
					<td class="QnAtitle" seq=<%=dto.getQna_seq() %> writeId="<%=dto.getQna_email() %>" parent=<%=dto.getQna_parent() %>>
						<%=arrow(dto.getQna_depth()) %><%=dto.getQna_title() %>
					</td>
					<td align="center"><%=dto.getQna_email() %></td>
					<td align="center"><%=dto.getQna_wdate().subSequence(0, 10) %></td>
				<%
				}
				%>
			</tr>
		<%
		}
	}
	%>
	<tr class="last_tr">
		<td colspan="5" align="right">
			<button type="button" class="writeModal">작성하기</button>
		</td>
	</tr>
</table>
</div>
<div class="pages">
<%for(int i = 1; i <= pages; i++){%>
	<a href="/TAMINO/StoreCtrl?command=QnAList&page=<%=i %>&product_seq=<%=product_seq %>"><%=i %></a>
<%
}
%>
</div>

<div id="modal_layer1" class="modal">
	<div id="modal_layer2" class="modal_content">
		<div class="close" id="close_span"><img src="/TAMINO/image/close.png" width="15px" height="15px"></div>
		
		<form id="QnAfrm">
			<input type="hidden" name="product_seq" value="<%=product_seq %>">
			<input type="hidden" name="qna_email" value="<%=currId %>">
			<table class="modaltable">
			<col width="200"><col width="400">
				<tr>
					<th>제목</th>
					<td>
						<input type="text" id="QnAtitle_txt" name="qna_title" placeholder="제목을 입력하세요">
					</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>
						<% if(logindto == null){%>
							익명
						<%
						}else{%>
							<%=currId %>
						<%	
						}
						%>	
					</td>
				</tr>
				
				<tr>
					<th>상품명</th>
					<td><%=product_name %></td>
				</tr>
				
				<tr>
					<th>분류</th>
					<td>
						<select name="qna_category" class="qnaselect">
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
						<textarea id="qnatextarea" name="qna_content" rows="8" style="width: 95%"></textarea>
					</td>
				</tr>
				
				<tr>
					<td colspan="2" align="center"> 
						<button type="button" id="writeBtn">작성하기</button>
					</td>
				</tr>
			
			</table>
		</form>
		
	</div>	
</div>


<script type="text/javascript">
$(function () {

	$(".writeModal").click(function() {
		if($("#currId").val() == "guest"){/* 로그인 하지 않은 경우 */
			alert("QnA작성은 로그인 후 하실 수 있습니다.");
		}else{
			$("#modal_layer1").css("display", "block");
		}
		
	});
	
	$("#close_span").click(function () {
		$("#modal_layer1").css("display", "none");
		$("#QnAtitle_txt").val("");
		$("select[name=qna_category]").val("notselect").attr("selected", "selected");
		$("textarea[name=qna_content]").val("");
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
		
			var formData = $("#QnAfrm").serialize();
			$.ajax({
				type: 'get',
				url: '/TAMINO/StoreCtrl?command=QnAInsert',
				data: formData, 
				datatype : 'json',
				success: function () {
					//alert("성공");
					location.href = "/TAMINO/StoreCtrl?command=QnAList&product_seq="+<%=product_seq %>;
				},
				error: function () {
					alert("에러");
				}
			})
	});
	
	$(".QnAtitle").click(function () {
		var allow ="";
		var seq = $(this).attr("seq");
		
		if($(this).attr("writeId") == "admin"){
			var myId = $("#currId").val();
			var parent_seq = $(this).attr("parent");
			
			$.ajax({
				type:'get',
				url: '/TAMINO/StoreCtrl?command=myReply',
				async:false,
				data: {"parent_seq": parent_seq, "myId" : myId},
				datatype: 'json',
				success: function (data) {
					//alert("성공");
					console.log(data);
					allow = data.trim();
				},
				error: function () {
					alert("에러");
				}						
			});
			
				console.log("ajax 완료: " + allow);
			if(allow === "ok"){
				location.href = "/TAMINO/StoreCtrl?command=QnADetail&seq=" + seq;	
			}else if(allow === "no"){
				alert("본인이 작성한 글의 답변만 열람 가능합니다.");				
			}
			
			
		}else if($(this).attr("writeId") != "admin"){
			if($("#currId").val() != $(this).attr("writeId")){
				alert("본인이 작성한 글만 열람 가능합니다.");
				return;
			}else {
				location.href = "/TAMINO/StoreCtrl?command=QnADetail&seq="+$(this).attr("seq");	
			}
		}
		
		
		
		
	});
	
	$(".Deltitle").click(function () {
		alert("삭제된 게시글은 열람할 수 없습니다");
		return;
	});
	
});

</script>
</body>
</html>