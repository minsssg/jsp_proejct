<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.nio.file.Path" %>
<%@ page import="java.nio.file.Paths" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.stream.Stream" %>
<%@ page import="java.util.stream.Collectors" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.IOException" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<jsp:useBean id = "user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userName" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="Text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1" >
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<link rel="stylesheet" href="css/main_ui.css">
<title>Hello World!</title>
</head>
<body>
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
	}
	
	int pageNumber = 1;
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	System.out.println("PageNumber: " + pageNumber);
	%>
	
	<nav class="navbar navbar-default" style="background-color: #E4EFFF">
		<div class="navbar-header">
			<img src="images/worldwide.png" width="30" height="30" align="left">
			<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
					aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>	
			</button>
			<a class="navbar-brand" href="main.jsp">
				<span style="font-weight: bold; font-size: 1.5em; color: #333333">
					Hello World
				</span>
			</a>
		</div>
		<div class="collapse navbar-collapse"
			 id="bs-example-navbar-collapse-1">
			<div class="col-lg-1" class="form-group" style="padding: 8px">
				<select name="opt" class="form-control">
					<option value="0">이름</option>
					<option value="1">이름</option>
				</select>	 
		</div>
		
		<form method="get" action="main.jsp">
			<div class="col-lg-3" class="form-group" style="padding: 8px;">
				<input type="text" class="form-control" placeholder="검색내용"
					   name="userName" maxlength="20"></input>
			</div>
			
			<div class="col-lg-1" style="padding: 8px;">
				<input type="submit" class="btn btn-primary form-control" value="검색"></input>
			</div>
		</form>
		<%
		if (userID != null) {
		%>
		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">접속하기
					<span class="caret"></span>
				</a>
				<ul class="dropdown-menu">
					<li><a href="logoutAction.jsp">로그아웃</a></li>
					<li><a href="profile.jsp?userID=<%=userID%>">마이페이지</a></li>
				</ul>
			</li>
		</ul>
		<%
		}
		%>
		</div>
	</nav>
	
	<div class="container" style="background-color: #F7F9FF; border-radius: 2em">
		<div class="jumbotron" style="background-color: #F7F9FF">
			<div class="container" style="background-color: #F7F9FF">
				<%
				BbsDAO bbsDAO = new BbsDAO();
				ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
				
				String userName = null;
				userName = user.getUserName();
				System.out.println("USERNAME: " + userName);
				int bbscount = 0;
				if (userName != null) {
					bbscount = bbsDAO.bbsCount(userName);
				} else {
					bbscount = bbsDAO.bbsCount();
				}
				%>
				<h1>게시물<p>(<%=bbscount %>건)</p></h1>
				<%
				if (userName != null) {
					System.out.println("UserName: " + userName);
					list = bbsDAO.searchList(userName, pageNumber);
				}
				if (bbscount == 0) {
				%>
					<h3>'<%=userName %>'에 대한 검색 내용이 없습니다.</h3>
				<%
				}
				%>
				<div class="row">
				<%
				for (int i = 0; i < list.size(); i++) {
					String date = list.get(i).getBbsDate();
					String dir_path = application.getRealPath("/images/" + list.get(i).getUserID() + "/") + list.get(i).getBbsDate();
					System.out.println("dir_path: " + dir_path);
					Stream<Path> walk = Files.list(Paths.get(dir_path));
					List<String> walks = walk.filter(Files::isRegularFile)
							.map(x->x.toString()).collect(Collectors.toList());
					
					String[] files = new String[walks.size()];
					int n = 0;
					for (String temp: walks) {
						String[] paths = temp.split("\\\\"); // '\\'이 아닌 '\\\\'으로 써야 한다. weird 
						System.out.println("사진: " + paths[paths.length - 1]);
						files[n++] = paths[paths.length - 1];
					}
					// File dir = new File(dir_path);
					
				%>
					<div class="col-md-4">
						<div class="thumbnail" style="background-color:#DEE1E8; border-bottom-right-radius:3em">
						<% if(files.length > 0) { %>
							<div id="myCarousel<%=i %>" class="carousel slide" data-ride="carousel" style="width:100%; text-align: right; display: block; margin: 0 auto">
								<ol class="carousel-indicators">
									<%
									for (int j = 0; j < files.length; j++) {
									%>
									<li id="slide<%=i %><%=j %>" data-target="#myCarousel<%=i %>" data-slide-to="<%=j %>"></li>
									<%
									}
									%>
								</ol>
								<div class="carousel-inner" style="width: 300px; height: 200px;">
									<%
									for (int j = 0; j < files.length; j++) {
										System.out.println("images/" + list.get(i).getUserID() + "/" + date + "/" + files[j]);
									%>
									<div id="item<%=i %><%=j %>" class="item">
										<img src="images/<%=list.get(i).getUserID() + "/" + date + "/" + files[j] %>" style="width: 300px; height: 200px">
									</div>
									<%
									}
									%>
								</div>
								<a class="left carousel-control" href="#myCarousel<%=i %>" data-slide="prev"><span class="glyphicon glyphicon-chevron-left"></span></a>
								<a class="right carousel-control" href="#myCarousel<%=i %>" data-slide="next"><span class="glyphicon glyphicon-chevron-right"></span></a>
							</div>
							<% } else { %>
							<img class='photo' src="images/global.jpg" align="Middle" style="width: 300px; height: 200px">
							<% } %>
							<div class="caption">
								<img src="images/user.png" class="img-circle" width="10%" height="10%" style="float: left; margin-right: 10px;">
								<p class="text-info" style="margin-top: 10px"><a href="view.jsp?bbsID=<%=list.get(i).getBbsID() %>"><%=list.get(i).getUserName() %></a></p>
								<p><%=list.get(i).getBbsTitle() %></p>
							</div>
						</div>
					</div>
				<% } %>
				</div>
			</div>
			<% 
			int pageNum;
			System.out.println("BbsCount: " + bbscount);
			
			if (bbscount == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('데이터베이스 오류가 발생했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			
			if (bbscount % 6 == 0) {
				pageNum = (bbscount/6);
			} else {
				pageNum = (bbscount/6) + 1;
			}
			System.out.println("PageNumber: " + pageNum);
			%>
			<div class="page" align="center">
				<ul class="pagination">
				<%
				for (int i = 0; i < pageNum; i++) {
					if (userName != null) {
				%>
					<li><a href="main.jsp?userName=<%=userName %>&pageNumber=<%=i+1 %>"><%=i+1 %></a></li>
				<%
					} else {
				%>
					<li><a href="main.jsp?pageNumber=<%=i+1 %>"><%=i+1 %></a></li>
				<%
					}
				}
				%>
				</ul>
			</div>
		</div>
	</div>
	<script>
		<% for (int i = 0; i < list.size(); i++) { %>
		var li = document.getElementById("slide<%=i%>0");
		var img = document.getElementById("item<%=i%>0");
		
		if (li != null && img != null) {
			li.setAttribute("class", "active");
			img.setAttribute("class", "item active");
		}
		<%} %>
	</script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>