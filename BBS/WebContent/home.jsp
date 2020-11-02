<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="Text/html; charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>Hello World!</title>

<style type="text/css">
div#side_left {
	width: 300px;
	height: 60%;
	float: left;
	margin: 10px;
}

#mid_content {
	width: 300px;
	height: 60%;
	float: left;
	margin: 10px;
}

#side_right {
	width: 300px;
	height: 60%;
	float: left;
	margin: 10px;
}

#photo_box {
	width: 90%;
	height: 45%;
	float: left;
	margin: 30px;
}

.photo {
	width: 100%;
	height: 220px;
}
</style>
</head>
<body>
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	%>
	
	<nav class="navbar navbar-default" style="background-color: #E4EFFF">
		<div class="navbar-header">
			<img src="images/worldwide.png" width="30" height="30" align="left">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="home.jsp">
				<span style="font-weight: bold; font-size: 1.5em; color: #333333">Hello World</span>
			</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<%
			if (userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">접속하기<span class='caret'></span></a>
				
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
			} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">접속하기<span class="caret"></span></a>
				
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
						<li><a href="profile.jsp?userID=<%=userID %>">마이페이지</a></li>
					</ul>
				</li>
			</ul>
			<%
			}
			%>
		</div>
	</nav>
	
	<div class="container" style="width: 1000px">
		<div class="jumbotron" style="background-color: #F7F9FF">
			<div class="container" style="background-color: #F7F9FF">
				<h1>Hello World</h1>
				<p>여행지 후기 공유 사이트입니다.</p>
				<%
				if (userID == null) {
				%>
				<p><a class="btn btn-primary btn-pull" href="login.jsp" role="button">서비스 이용하기</a></p>
				<%
				} else {
				%>
				<p><a class="btn btn-primary btn-pull" href="main.jsp" role="button">서비스 이용하기</a></p>
				<%
				}
				%>
			</div>
		</div>
	</div>
	<div class="container" style="width: 1000px">
		<div id="myCarousel" class="carousel slide" data-ride="carousel" style="width: 970px">
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
				<li data-target="#myCarousel" data-slide-to="3"></li>
				<li data-target="#myCarousel" data-slide-to="4"></li>
			</ol>
			<div class="carousel-inner">
				<div class="item active">
					<img src="images/galaxy.png" style="width: 970px; height: 600px">
				</div>
				<div class="item">
					<img src="images/travel1.jpg" style="width: 970px; height: 600px">
				</div>
				<div class="item">
					<img src="images/travel2.jpg" style="width: 970px; height: 600px">
				</div>
				<div class="item">
					<img src="images/travel3.jpg" style="width: 970px; height: 600px">
				</div>
				<div class="item">
					<img src="images/travel4.jpg" style="width: 970px; height: 600px">
				</div>
			</div>
			<a class="left carousel-control" href="#myCarousel" data-slide="prev">
				<span class="glyphicon glyphicon-chevron-left"></span>
			</a>
			<a class="right carousel-control" href="#myCarousel" data-slide="next">
				<span class="glyphicon glyphicon-chevron-right"></span>
			</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>