<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>logout</title>
</head>
<body>
	<% 
	System.out.println(session.getAttribute("userID"));
	session.invalidate();
	%>
	<script>
		location.href = 'home.jsp'
	</script>
</body>
</html>