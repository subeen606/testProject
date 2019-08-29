<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
response.sendRedirect("/TAMINO/newscontrol?command=list");  //넘겨줄 데이터를 적어준다.
%>

</body>
</html>