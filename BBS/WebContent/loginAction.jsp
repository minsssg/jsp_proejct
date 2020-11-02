<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page"/>
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset="UTF-8">
<title>Hello World loginAction</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
			System.out.println("logined USERID: " + userID);
		}
		
		if (userID != null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인된 아이디 입니다.')");
			script.println("location.href='home.jsp'");
			script.println("</script>");
		}
		
		UserDAO userDAO = new UserDAO();
		System.out.println(user.getUserID() + user.getUserPassword());
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		
		if (result == 1) {
			session.setAttribute("userID", user.getUserID());
			System.out.println(session.getAttribute("userID"));
			PrintWriter script = response.getWriter();
			script.println("<script>");
			// script.println("location.href = 'main.jsp'");
			script.println("location.href='home.jsp'");
			script.println("</script>");
			System.out.println("Successed Logined!!");
		} else if (result == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀민호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>>");
			script.println("alert('존재하지 않는 아이디 입니다.')");
			script.println("history.back()");
			script.println("</script>");
		} else if (result == -2) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생하였습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>