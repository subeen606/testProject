<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>

<!-- <a href="./AdminCtrl?command=AdminSchedule">관리자모드 스케줄</a> -->
<button id="scheduleBtn">관리자모드 스케줄</button>

<button type="button" id="productBtn">관리자모드 상품</button>

<button type="button" id="qnaBtn">관리자모드 Q&A</button>


<script type="text/javascript">
$("#scheduleBtn").click(function () {
	location.href = "/TAMINO/AdminCtrl?command=AdminSchedule";
});

$("#productBtn").click(function() {
	location.href = "/TAMINO/AdminCtrl?command=ProductList&page=0";
});

$("#qnaBtn").click(function () {
	location.href = "/TAMINO/AdminCtrl?command=QnAList"
});
</script>

</body>
</html>