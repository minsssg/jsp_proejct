<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="EUC-KR">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
<title>FILE UPLOAD 예지</title>
<style>
.input-group-btn input[type="file"] {
	position: absolute;
	width: 0px;
	height: 0px;
	left: 0;
	top: 0;
	opacity: 0;
}
</style>
</head>
<body>
	<div class="row">
		<div class="col-sm-4" style="background-color:lavender;">.col-sm-4</div>
		<div class="col-sm-4" style="background-color:lavenderblush;">.col-sm-4</div>
		<div class="col-sm-4" style="background-color:lavender;">.col-sm-4</div>
	</div>
	<div class="container">
		<div class="jumbotron">
			<h2 style="text-align: center">Hello World</h2>
			<hr>
			<form action="uploadAction.jsp" method="post" enctype="multipart/form-data">
				<div class="form-group">
					<div class="input-group input-file" name="fileSelect">
						<span id="input_img" class="input-group-btn">
							<input type="file" accept="image/*" id="image0" name="file1" onchange="preview_image(event)">
							<button type="button" id="newFile" class="btn btn-info" onclick="check()">
								<i class="far fa-image" style="font-size: 30px;"></i>
							</button>
						</span>
						<!-- <input type="text" class="form-control" placeholder="이미지 선택"/> -->
					</div>
				</div>
				<div align="center">
					<button type="button" id="insertImage" class="btn btn-info" onclick="img_insert()" style="display:none;">+</button>
					<button type="button" id="deleteImage" class="btn btn-info" onclick="img_delete()" style="display:none;">-</button>
				</div>
				<div align="center">
					<div id="myCarousel" class="carousel slide" style="width: 50%;">
						<a id="left carousel" class="left carousel-control" href="#myCarousel" data-slide="prev" style="display: none;">
							<span class="glyphicon glyphicon-chevron-left"></span>
						</a>
						<a id="right carousel" class="right carousel-control" href="#myCarousel" data-slide="next" style="display: none;">
							<span class="glyphicon glyphicon-chevron-right"></span>
						</a>
					</div>
				</div>
				<div align="center">
					<textarea id="image_text" class="form-control" maxlength="2048" style="width: 50%; height: 350px"></textarea>
				</div>
				<input type="submit" class="btn btn-info"  value="업로드" style="float: right;">
			</form>
		</div>
	</div>
	
	<script type="text/javascript">
		var count = 0;
		function imageCount() {
			if (count == 0) {
				var myCarousel = document.getElementById('myCarousel');
				myCarousel.removeChild(myCarousel.childNodes[0]);
				myCarousel.removeChild(myCarousel.childNodes[0]);
				document.getElementById("newFile").style.display="inline";
				myCarousel.setAttribute("data-ride", "");
				myCarousel.setAttribute("class", "");
				document.getElementById("insertImage").style.display="none";
				document.getElementById("deleteImage").style.display="none";
				document.getElementById("left carousel").style.display="none";
				document.getElementById("right carousel").style.display="none";
			} else {
				document.getElementById("insertImage").style.display="inline";
				document.getElementById("deleteImage").style.display="inline";
				document.getElementById("left carousel").style.display="inline";
				document.getElementById("right carousel").style.display="inline";
			}
		}
		
		function preview_image(event) {
			var reader = new FileReader();
			var src = reader.result;
			reader.onload = function() {
				createImg();
				console.log("output_image" + count);
				var output = document.getElementById("output_image" + count);
				console.log(output);
				output.src = reader.result;
				//document.getElementById('image_del').style.display="block";
				document.getElementById("output_image" + count).style.display="inline";
				document.getElementById("newFile").style.display="none";
				count = count + 1;
				imageCount();
				console.log(count);
			}
			reader.readAsDataURL(event.target.files[0]);
		}
		
		function evntOccur(evEle, evType) {
			if (evEle.fireEvent) {
				evEle.fireEvent('on' + evType);
			} else {
				var mouseEvent = document.createEvent("MouseEvents");
				mouseEvent.initEvent(evType, true, false);
				var transCheck = evEle.dispatchEvent(mouseEvent);
				if (!transCheck) {
					console.log("클릭 이벤트 발생 실패");
				}
			}
		}
		
		function check() {
			eventOccur(document.getElementById('image' + count), 'click');
		}
		
		function createImg() {
			var div = document.createElement('div');
			var img = document.createElement('img');
			var li = document.createElement('li');
			div.setAttribute("id", "item" + count);
			div.setAttribute("class", "item");
			
			img.id = "output_image" + count;
			img.setAttribute("class", "img-thumbnail");
			img.style.display="none";
			li.setAttribute("data-target", "#myCarousel");
			li.setAttribute("data-slide-to", count);
			ifi (count == 0) {
				var myCarousel = document.getElementById('myCarousel');
				var ol = document.createElement('ol');
				var div_inner = document.createElement('div');
				ol.setAttribute('id', 'carousel_list');
				ol.setAttribute('class', 'carousel-indicators');
				div_inner.setAttribute('id', 'carousel-img-group');
				div_inner.setAttribute('class', 'carousel-inner');
				myCarousel.insertBefore(div_inner, myCarousel.childNodes[0]);
				myCarousel.insertBefore(ol, myCarousel.childNodes[0]);
				document.getElementById("myCarousel").setAttribute('data-ride', 'carousel');
				li.setAttribute("class", "active");
				div.setAttribute("class", "item active");
			}
			
			console.log(img);
			console.log(div);
			console.log(li);
			document.getElementById("carousel_list").appendChild(li);
			document.getElementById("carousel-img-group").appendChild(div);
			document.getElementById("item" + count).appendChild(img);
		}
		
		function img_insert() {
			var input = document.createElement('input');
			input.setAttribute('type', 'file');
			input.id = "image" + count;
			input.setAttribute("name", "file" + count);
			input.setAttribute("onchange", "preview_image(event)");
			console.log(input);
			document.getElementById("input_img").appendChild(input);
			document.getElementById("newFile").style.display="block";
		}
		
		function img_delete() {
			if (count > 0) {
				var ol = document.getElementById("carousel_list");
				var div = document.getElementById("carousel-img-group");
				ol.removeChild(ol.childNodes[count - 1]);
				div.removeChild(div.childNodes[count - 1]);
				
				for (var i = 0; i < div.length; i++) {
					console.log(div.childNodes[i]);
				}
				
				count = count - 1;
				console.log(count);
				imageCount();
			}
		}
	</script>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<a href="fileDownload.jsp">파일 다운로드 페이지</a>
</body>
</html>