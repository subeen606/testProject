<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<button type="button" onclick="goInfo()">회원정보 수정</button>
<button type="button">주문내역 확인</button>
<script type="text/javascript">
function goInfo() {
	location.href =  "/TAMINO/MemberCtrl?command=myInfo&email=abc@abc.com"
}
</script>
</body>
</html>