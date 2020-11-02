<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="Text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>Hello World</title>
</head>
<body>
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
	%>
	<script>
		location.href='home.jsp';
	</script>
	<%
	}
	%>
	
	<nav class="navbar navbar-default" style="background-color: #E4EFFF">
		<div class="navbar-header">
			<img src="images\worldwide.png" width="30" height="30" align="left">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="home.jsp"> <span
				style="font-family: sans-serif; font-weight: bold; font-size: 1.5em; color: #333333">
					Hello World </span></a>
		</div>
	</nav>

	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4" style="padding-top: 80px">
			<div class="jumbotron"
				style="padding-top: 20px; background-color: #F7F9FF ;text-align: center">
				<form method="post" action="loginAction.jsp">
					<h3>로그인 화면</h3>
					<img src="images/user.png" class="user" alt="user" style="width: 50%">

					<div class="form-group" style="padding-top: 50px">
						<input type="text" class="form-control" placeholder="아이디"
							name="userID" maxlength="20"></input>
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호"
							name="userPassword" maxlength="20">
					</div>
					<input type="submit" class="btn btn-primary form-control"
						value="로그인">
					<div style="padding-top: 8px">
						<a href="join.jsp">회원가입</a>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>