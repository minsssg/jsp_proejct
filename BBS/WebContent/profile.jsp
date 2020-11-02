<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="file.FileDTO" %>
<%@ page import="file.FileDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="Text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<link rel="stylesheet" href="css/post_ui.css">
<title>Hello World!</title>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

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
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		
		User user = new UserDAO().getUser((String) request.getParameter("userID"));
		System.out.println("user: " + user.getUserID());
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

	<div class="container"
		style="background-color: #F7F9FF; border-radius: 2em">
		<div class="jumbotron" style="background-color: #F7F9FF">
			<div class="container" style="background-color: #F7F9FF">
				<div id="side_left">
					<div class="Search_BOX" id="srcb" >
						<div>
							<div id="Box_label" style="background-color: #B9C2FF">검색 창</div>		
						</div>
						<div id='srcb_container'>
							<input id="Search_Box" class="controls" type="text" placeholder="Search Box">
						</div>
					</div>
					
					<div id="googleMap"
						style="width: 100%; height: 100%; border-radius: 2em">
					</div>
				</div> 
				<div id="side_rigth" style="background-color: #DEE1E8">
					<div id="profile_box" style="border-bottom: 1.5px solid gray">
						<p style="text-align: center;">
							<img class='profile' src="images/user.png" align="Middle">
							<%=user.getUserName() %>
						</p>
					</div>
					<%if(userID.equals(user.getUserID())) { %>
					<div id="content_box">
						<p align="right">
							<button type="button" id="newFile" class="btn btn-info"
								data-toggle="modal" data-target="#myModal">수정</button>
						</p>
				
						<!-- Modal -->
						<div class="modal fade" id="myModal" role="dialog">
							<div class="modal-dialog">
								<!-- Modal content -->
								<div class="modal-content">
									<div class="modal-header">
										<h4 class="modal-title">개인정보 수정</h4>
									</div>
									<form method="post" action="modify.jsp">
										<div class="modal-body">
											<input type="hidden" name="userID" value="<%=userID%>">
											<table style="width: 100%; border-spacing: 10px;">
												<tbody>
													<tr>
														<td>이름</td>
														<td><input type="text" class="form-control" name="userName"
															placeholder="#이름"></td>
													</tr>
													<tr>
														<td>Password</td>
														<td><input type="password" class="form-control" name="userPassword"
															placeholder="#비밀번호"></td>
													</tr>
													<tr>
														<td>성별</td>
														<td>
															<div class="btn-group" data-toggle="buttons">
															<label class="btn btn-primary active"> <input
																type="radio" name="userGender" autocomplete="off" value="남자"
																checked>남자
															</label> <label class="btn btn-primary"> <input type="radio"
																name="userGender" autocomplete="off" value="여자" checked>여자
															</label>
															</div>
														</td>
													</tr>
													<tr>
														<td>전화번호</td>
														<td><input class="form-control"
															name="userPhoneNumber" type="text" placeholder="#전화번호"></td>
													</tr>
												</tbody>
											</table>
										</div>

										<div class="modal-footer">
											<button type="submit" class="btn btn-default">확인</button>
											<button type="button" class="btn btn-default"
												data-dismiss="modal">닫기</button>
										</div>
									</form>
								</div>
							</div>
						</div>
						<% } %>
						<p>ID:  <%=user.getUserID()%></p>
						<p>성별: <%=user.getUserGender()%></p>
						<p>전화번호: <%=user.getUserPhoneNumber()%></p>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<script>
		var map;
		var markers = [];
		var position;
		function initialize() {
			var mapProp = {
				center : {
					lat : 37.250943,
					lng : 127.028344
				},
				zoom : 5,
				mapTypeId : google.maps.MapTypeId.ROADMAP,
				panControl : true,
				zoomControl : true,
				mapTypeControl : true,
				scaleControl : true,
				streetViewContro : true,
				overviewMapControl : true,
				rotateControl : true,

				mapTypeControlOptions : {
					style : google.maps.MapTypeControlStyle.DROPDOWN_MENU
				}
			};

			map = new google.maps.Map(document.getElementById("googleMap"),
					mapProp);
			// Create the search box
			var srcb = document.getElementById('srcb');
			var input = document.getElementById('Search_Box');
			var searchBox = new google.maps.places.SearchBox(input);
			map.controls[google.maps.ControlPosition.TOP_LEFT].push(srcb);
			<%
			BbsDAO bbsDAO = new BbsDAO();
			System.out.println("bbsUserID: "+user.getUserID());
			ArrayList<Bbs> list = bbsDAO.getList(user.getUserID());
			for(int i = 0; i < list.size(); i++) {
			%>
			var geocoder = new google.maps.Geocoder();
			var address;
			geocoder.geocode({
				'latLng': location
			}, function(results, status){
				if (status == google.maps.GeocoderStatus.OK) {
					address = results[0].formatted_address;					
				} else {
					//alert("Geocoder Failed due to: " + status);
				}
			});
				var location = new google.maps.LatLng(<%=list.get(i).getLatitude() %>, <%=list.get(i).getLongitude()%>);
				markers[markers.length] = new google.maps.Marker({
					map: map,
					position: location,
					title: address,
					icon: "images/pinball.png"
				});
				markers[<%=i%>].addListener('click', function(event) {
					infoWindow = new google.maps.InfoWindow({content: '#글쓴이: <%=user.getUserName()%> <br>#제목: <%=list.get(i).getBbsTitle() %> <br>#내용: <%=list.get(i).getBbsContent()%><br>'
						 									+ '<a href="view.jsp?bbsID=<%=list.get(i).getBbsID()%>" class="btn btn-info">보기</a>'});
					infoWindow.close();
					infoWindow.open(map, markers[<%=i%>]);
				});
				
			<%
				}
			%>
			
			<% if(userID.equals(user.getUserID())) { %>
			map.addListener('click', function(event) {
				addMarker(event.latLng);
			});
	
			map.addListener('bounds_changed', function() {
				searchBox.setBounds(map.getBounds());
			});
			<% } %>
			
			searchBox.addListener('places_changed', function(){
				var places = searchBox.getPlaces();
	
				if(places.length == 0) {
					return;
				}
				
	
				var bounds = new google.maps.LatLngBounds();
				places.forEach(function(place){
					if(!place.geometry) {
						alert("Returned place contains no geometry");
						return;
					}
		
					var address = place.name;
					console.log(address);
					<% if(userID.equals(user.getUserID())) { %>
					addMarker(place.geometry.location, address);
					<% } %>
					if (place.geometry.viewport){
						bounds.union(place.geometry.viewport);
					} else {
						bounds.extend(place.geometry.location);
					}
				});
				map.fitBounds(bounds);
			});
		}
	
		function addMarker(location) {
			var tmp;
			var local;
			var lat = 0;
			var lng = 0;
			var infowindow;
			var marker = new google.maps.Marker({
				position: location,
				map: map,
				animation: google.maps.Animation.DROP,
				title: address
			});
			
			var geocoder = new google.maps.Geocoder();
			var address;
			geocoder.geocode({
				'latLng': location
			}, function(results, status){
				if (status == google.maps.GeocoderStatus.OK) {
					address = results[0].formatted_address;
					
					infoWindow = new google.maps.InfoWindow({content: '<form action="bbswrite.jsp" method="get" style="float: right">'
																		+'<input type="hidden" name="lat" value="'+location.lat()+'">'
																		+'<input type="hidden" name="lng" value="'+location.lng()+'">'
																		+'<input type="submit" class="btn btn-info" value="글쓰기"></form>'+'Latitude: ' + location.lat().toFixed(2) + '<br>Longitude: ' + location.lng().toFixed(2) + '<br>address: '+address	});
					infoWindow.close();
					infoWindow.open(map, marker);
										
				} else {
					alert("Geocoder Failed due to: " + status);
				}
			});
	
			var circleOptions = {
				center: location,
				clickable: false,
				fillColor: "blue",
				fillOpacity: 0.15,
				map: map,
				radius: 100,
				strokeColor: "blue",
				strokeOpacity: 0.3,
				strokeWeight: 2
			};
			
			var addCircle = new google.maps.Circle(circleOptions);	
	
			marker.addListener('click', function(){
				/* 나라 위치 가져오기 구현해야함.*/
				infoWindow.close();
				infoWindow = new google.maps.InfoWindow({content: '<form action="bbswrite.jsp" method="get" style="float: right">'
					+'<input type="hidden" name="lat" value="'+location.lat()+'">'
					+'<input type="hidden" name="lng" value="'+location.lng()+'">'
					+'<input type="submit" class="btn btn-info" value="글씨기"></form>'+'Latitude: ' + location.lat().toFixed(2) + '<br>Longitude: ' + location.lng().toFixed(2) + '<br>address: '+address	});
				infoWindow.open(map, marker);
			});
			
			marker.addListener('dblclick', function() {
				marker.setMap(null);
				addCircle.setMap(null);
			});
	
			markers.push(marker);
		}
		
		//google.maps.event.addDomListener(window, 'load', initialize);
		
	</script>
	<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDPp4Qx8r-HtUctKol3q0BAzreyyWQtws4&libraries=places&callback=initialize"></script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>