<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"  %>
<%@ page import="java.io.File" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<jsp:useBean id="file" class="file.FileDTO" scope="page"/>
<jsp:setProperty name="file" property="lat"/>
<jsp:setProperty name="file" property="lng"/>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
	<link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" href="css/custom.css">
	<link rel="stylesheet" href="css/upload.css">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	
	<title>FILE UPLOAD예제</title>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		} 
		
		if (userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해야 합니다.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		int bbsID = 0;
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if	(bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		if (!userID.equals(bbs.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		System.out.println(bbs.getBbsDate());
		String date = bbs.getBbsDate();
		
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
			<a class="navbar-brand" href="main.jsp"> <span
				style="font-weight: bold; font-size: 1.5em; color: #333333">
					Hello World </span></a>
		</div>

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			
			<div class="col-lg-1" class="form-group" style="padding: 8px">
				<select name="opt" class="form-control">
					<option value="0">이름</option>
					<option value="1">지역</option>
				</select>
			</div>

			<div class="col-lg-3" class="form-group" style="padding: 8px;">
				<input type="text" class="form-control" placeholder="검색내용"
					name="keyword" maxlength="20"></input>
			</div>

			<div class="col-lg-1" style="padding: 8px;">
				<input type="submit" class="btn btn-primary form-control" value="검색"></input>
			</div>

			<%
				if (userID != null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
						<li><a href="profile.jsp?userID=<%=userID%>">내 정보</a></li>
					</ul></li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	
	<div class="container" style="background-color: #F7F9FF; width: 800px; border-radius: 1em">
		<div class="jumbotron" style="background-color: #F7F9FF">
			<h2 style="text-align: center">Hello World</h2>
			<h3 style="text-align: center">게시물 수정</h3>
			<hr>
			<p align="right">
			<button type="button" id="newFile" class="btn btn-info" data-toggle="modal" data-target="#myModal" style="text-align:right">
				<i class="far fa-image" style="font-size: 30px;"></i>
			</button>
			</p>
			<!-- Modal -->
			<div class="modal fade" id="myModal" role="dialog">
				<div class="modal-dialog">
					<!-- Modal content -->
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times</button> 
							<h4 class="modal-title">이미지 업로드</h4>
						</div>
						<div class="modal-body">
							<table style="width: 100%; border-spacing: 5px;">
								<tbody>
								<tr id="row0">
								<%for (int i = 0; i < 4; i++) {	%>
									<td> 
										<button type="button" class="btn btn-info" onclick="check(<%=i%>)">사진 설정</button>
										<button class="btn btn-danger" onclick="delete_img(<%=i%>)">X</button>
										<img id="img<%=i%>" class="img-thumbnail" alt="사진<%=i+1%>">
									</td>			
								<%
									} 
								%>
								</tr>		
								<tr id="row1">
								<%for (int i = 4; i < 8; i++) {	%>
									<td> 
										<button type="button" class="btn btn-info" onclick="check(<%=i%>)">사진 설정</button>
										<button class="btn btn-danger" onclick="delete_img(<%=i%>)">X</button>
										<img id="img<%=i%>" class="img-thumbnail" alt="사진<%=i+1%>">
									</td>			
								<%
									} 
								%>
								</tr>
								<tr id="row2">
								<%for (int i = 8; i < 12; i++) { %>
									<td> 
										<button type="button" class="btn btn-info" onclick="check(<%=i%>)">사진 설정</button>
										<button class="btn btn-danger" onclick="delete_img(<%=i%>)">X</button>
										<img id="img<%=i%>" class="img-thumbnail" alt="사진<%=i+1%>">
									</td>			
								<%
									} 
								%>
								</tr>		
								</tbody>
							</table>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal" onclick="create_Carousel()">확인</button>
							<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>
				<div class="form-group">
					<div class="input-group input-file" name="fileSelect">
						<span id="input_img" class="input-group-btn">
						 	<!-- <input type="file" accept="image/*" id="image0" name="file1" onchange="preview_image(event)"> -->
							<!-- <button type="button" id="newFile" class="btn btn-info" onclick="check()">
								<i class="far fa-image" style="font-size: 30px;"></i>
							</button>
							 -->
							
						</span>							
						<!-- <input type="text" class="form-control" placeholder="이미지 선택"/> -->
					</div>	
				</div>
	
				<div align="center">
				<div id="myCarousel" style="width: 50%;">
					<ol id="carousel-indicators" class="carousel-indicators">
						
					</ol>
					<div id="carousel-inner" class="carousel-inner">
						
					</div>
					<a id="left carousel" class="left carousel-control" href="#myCarousel" data-slide="prev" style="display: none;">
						<span class="glyphicon glyphicon-chevron-left"></span>
					</a>
					<a id="right carousel" class="right carousel-control" href="#myCarousel" data-slide="next" style="display: none;">
						<span class="glyphicon glyphicon-chevron-right"></span>
					</a>
				</div>
			</div>		
			<form action="updateAction.jsp?bbsID=<%=bbsID %>" method="post" enctype="multipart/form-data"> 
				<table class="table table-striped" align="center" style="text-align: center; width: 50%; border: 1px solid #dddddd ; width:600px ;background-color: #F7F9FF">
					<thead>
						<tr>
							<th colspan="2"	style="backgroud-color: #eeeeee; text-align: center;">#지역명!</th>
						</tr>
					</thead>
					<tbody>
						<tr>						
							<td bgcolor= "#F7F9FF"><span style = "font-size:1.2em">제목</span>
							<input type="text" class="form-control" placeholder="#글 제목" name="bbsTitle" maxlength="50" value="<%= bbs.getBbsTitle() %>"></td>
						</tr>
						<tr>
							<td><span style = "font-size:1.2em">내용</span>
							<textarea id="image_text" class="form-control" placeholder="#글 내용" name="bbsContent" maxlength="2048" style="height: 350px"><%= bbs.getBbsContent() %></textarea></td>
						</tr>
					</tbody>
				</table>
				<%for(int i = 0; i < 12; i++) { %>
					<input type="file" accept="image/*" id="image<%=i %>" name="file<%=i %>" onchange="preview_image(event,<%=i %>)">
				<% } %>
				<input type="hidden" name="lat" value="<%= bbs.getLatitude() %>">
				<input type="hidden" name="lng" value="<%= bbs.getLongitude() %>">
				<div style="float: right;">
					<input type="submit" class="btn btn-info" value="수정">
					<a href="bbswrite.jsp" type="button" class="btn btn-info">취소</a>
				</div>
			</form>
		</div>
	</div>
	
	<script type="text/javascript">

		var count = 0;
		function imageCount(){
			if(count === 0) {
				var myCarousel = document.getElementById('myCarousel');
				myCarousel.removeChild(myCarousel.childNodes[0]);
				myCarousel.removeChild(myCarousel.childNodes[0]);
				document.getElementById('newFile').style.display="inline";
				myCarousel.setAttribute("data-ride", "");
				myCarousel.setAttribute("class", "");
				document.getElementById('insertImage').style.display="none";
				document.getElementById('deleteImage').style.display="none";
				document.getElementById('left carousel').style.display="none";
				document.getElementById('right carousel').style.display="none";
			} else {
				document.getElementById('insertImage').style.display="inline";
				document.getElementById('deleteImage').style.display="inline";
				document.getElementById('left carousel').style.display="inline";
				document.getElementById('right carousel').style.display="inline";
			}
		}
		function preview_image(event, index) {
			var reader = new FileReader();
			var src = reader.result;
			reader.onload = function() {
				console.log('img' + index);
				var output = document.getElementById('img' + index);
				console.log(output);
				output.src = reader.result;
				//document.getElementById('image_del').style.display="block";
				var image = document.getElementById('img' + index);
				image.style.display="inline-block";
				
				//document.getElementById('newFile').style.display="none";
				//count = count + 1;
				//console.log(count);
			}
			
			reader.readAsDataURL(event.target.files[0]);
		}
		
		function eventOccur(evEle, evType) {
			if(evEle.fireEvent) {
				evEle.fireEvent('on' + evType);
			} else {
				var mouseEvent = document.createEvent('MouseEvents');
				mouseEvent.initEvent(evType, true, false);
				var transCheck = evEle.dispatchEvent(mouseEvent);
				if(!transCheck) {
					console.log("클릭 이벤트 발생 실패");
				}
			}
		}
		function check(index) {
			eventOccur(document.getElementById('image'+index), 'click');
		}
		function create_Carousel() {
			clear_carousel();
			var ol = document.getElementById("carousel-indicators");
			var div = document.getElementById("carousel-inner");
			var check = 0;
			console.log(ol);
			for(var i = 0; i < 12; i++) {
				var img = document.getElementById("img" + i);
				if(img.getAttribute("src") != null) {
					var li = document.createElement("li");
					var inner_div = document.createElement("div");
					var inner_img = document.createElement("img");
					li.setAttribute("id", "li"+check);
					li.setAttribute("data-target","#myCarousel");
					li.setAttribute("data-slide-to", check);
					inner_div.setAttribute("id", "div"+check);
					inner_div.setAttribute("class", "item");
					inner_img.setAttribute("src", img.getAttribute("src"));
					inner_img.setAttribute("class", "img-thumbnail");
					inner_img.style.width="100%";
					ol.appendChild(li);
					div.appendChild(inner_div);
					inner_div.appendChild(inner_img);
					check = check + 1;
				}
			}
			
			if (check > 0){
				document.getElementById("myCarousel").setAttribute("data-ride","carousel");
				document.getElementById("myCarousel").setAttribute("class", "carousel slide");
				document.getElementById("li0").setAttribute("class","active");
				document.getElementById("div0").setAttribute("class","item active");
				document.getElementById("left carousel").style.display="inline";
				document.getElementById("right carousel").style.display="inline";
			}
		}
	
		function clear_carousel() {
			console.log("start clear");
			var ol = document.getElementById("carousel-indicators");
			var div = document.getElementById("carousel-inner");
			var num = $("li").length;
			/*for(var i = 0; i < 12; i++){
				ol.removeChild(ol.childNodes[0]);
				div.removeChild(div.childNodes[0]);
			}*/
			while(ol.hasChildNodes()){
				ol.removeChild(ol.firstChild);
				div.removeChild(div.firstChild);
			}
			document.getElementById("myCarousel").removeAttribute("data-ride");
			document.getElementById("myCarousel").removeAttribute("class");
			document.getElementById("left carousel").style.display = "none";
			document.getElementById("right carousel").style.display = "none";
		}

		function back() {
			history.back();
		}
		
		function img_insert() {
			var input = document.createElement('input');
			input.setAttribute("type", "file");
			input.id= "image" + count;
			input.setAttribute("name", "file"+count);
			input.setAttribute("onchange", "preview_image(event)");
			console.log(input);
			document.getElementById("input_img").appendChild(input);
			document.getElementById('newFile').style.display="block";
		}
		function img_delete() {
			if(count > 0) {
				var ol = document.getElementById("carousel_list");
				var div = document.getElementById("carousel-img-group");
				ol.removeChild(ol.childNodes[count-1]);
				div.removeChild(div.childNodes[count-1]);
				for(var i=0; i<div.length; i++){
					console.log(div.childNodes[i]);
				}
				count = count - 1;
				console.log(count);
				imageCount();
			}
		}
		function delete_img(index) {
			var img = document.getElementById("img"+index);
			var input = document.getElementById("image"+index);
			img.removeAttribute("src");
			input.value = null;
			console.log(input.value);
		}
	</script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>