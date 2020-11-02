<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-TYpe" content="Text/html; charset=EUC-KR">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>Hello World - 회원가입</title>
</head>
<body>
	<nav class="navbar navbar-default" style="background-color: #E4EFFF">
		<div class="navbar-header">
			<img src="images/worldwide.png" width="30" height="30" align="left">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="home.jsp"><span style="font-family: sans-serif; font-weight: bold; font-size: 1.5em; color: #333333">Hello World</span></a>
		</div>
	</nav>
	
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4" style="padding-top: 80px">
			<div class="jumbotron" style="padding-top: 20px; background-color: #F7F9FF; text-align: center">
				<form method="post" action="joinAction.jsp">
					<h3 style="text-align: center;">회원가입 화면</h3>
					<img src="images/user.png" class="img-circle" alt="user" style="width: 50%; height: 50%">
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디" name="userID" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20">
					</div>
					<div class="form-group" style="text-align: center;">
						<div class="btn-group" data-toggle="buttons">
							<label class="btn btn-primary active">
								<input type="radio" name="userGender" autocomplete="off" value="남자" checked>남자
							</label>
							<label class="btn btn-primary">
								<input type="radio" name="userGender" autocomplete="off" value="여자" checked>여자
							</label>
						</div>
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="전화번호('-'을 제외)" name="userPhoneNumber" maxlength="11">
					</div>
					<input type="submit" class="btn btn-primary form-control" value="회원가입">
					<div style="padding-top: 8px">
						<a href="login.jsp">로그인하기</a>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script>
		function eventOccur(evEle, evType) {
			if (evEle.fireEvent) {
				evEle.fireEvent('on' + evType);
			} else {
				var mouseEvent = document.createEvent('MouseEvents');
				mouseEvent.initEvent(evType, true, false);
				var transCheck = evEle.dispatchEvent(mouseEvent);
				if (!transCheck) {
					console.log("클릭 이벤트 발생 실패");
				}
			}
		}
		function check(index) {
			eventOccur(document.getElementById('image' + index), 'click');
		}
		function preview_image(event, index) {
			var reader = new FileReader();
			var src = reader.result;
			reader.onload = function() {
				console.log('img' + index);
				var output = document.getElementById('img' + index);
				
				console.log(output);
				output.src = reader.result;
				var image = document.getElementById('img' + index);
				image.style.display="inline-block";
			}
			reader.readAsDataURL(event.target.files[0]);
		}
	</script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>