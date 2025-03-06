<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>502 jsp study</title>
<link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&family=Gaegu&family=Jua&family=Nanum+Pen+Script&family=Playwrite+AU+SA:wght@100..400&family=Single+Day&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
<style>
body *{
	font-family: 'Jua';
}
.form {
	font-family: 'Jua';
	background-color: #f4f4f4;
	margin: 0;
	padding: 20px;
}
form {
	background: #fff;
	padding: 20px;
	border-radius: 5px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	max-width: 500px;
	margin: auto;
}
label {
	display: block;
	margin-bottom: 8px;
	font-weight: bold; 
}
.photo {
	font-size: 1.3em;
	cursor: pointer;
}
.photo:hover {
	color: pink;
}
img {
	width: 50px;
	height: 50px;
	margin-left: 50px;
	border: 1px solid #ccc;
	border-radius: 10px;
}
</style>
</head>
<script type="text/javascript">
$(function() {
	// 옆면 사진
	$(".p1").click(function() {
		$("#sidephoto").trigger("click");
	});
	
	// 앞면 사진
	$(".p2").click(function() {
		$("#frontphoto").trigger("click");
	});
});

function check() {
	let f1 = $("#sidephoto")[0];
	let f2 = $("#frontphoto")[0];
	
	if(f1.files.length === 0) {
		$(".result").text("옆면 사진을 선택하세요.");
		$(".result").css("color", "red");
		return false;
	}
	
	if(f2.files.length === 0) {
		$(".result").text("앞면 사진을 선택하세요.");
		$(".result").css("color", "red");
		return false;
	}
}

function preview1(tag) {
	let f = tag.files[0];
	
	if(!f.type.match("image.*")) {
		$(".result").text("이미지 파일만 가능합니다.");
		$(".result").css("color", "red");
		return;
	}
	
	if(f) {
		let reader = new FileReader();
		reader.onload = function(e) {
			$("#showimg1").attr("src", e.target.result);
			$(".result").text("");
		}
		
		reader.readAsDataURL(f);
	}
}

function preview2(tag) {
let f = tag.files[0];
	
	if(!f.type.match("image.*")) {
		$(".result").text("이미지 파일만 가능합니다.");
		$(".result").css("color", "red");
		return;
	}
	
	if(f) {
		let reader = new FileReader();
		reader.onload = function(e) {
			$("#showimg2").attr("src", e.target.result);
			$(".result").text("");
		}
		
		reader.readAsDataURL(f);
	}
}

</script>
<body>
<jsp:include page="../../layout/title.jsp"/>
<div class="form">
	<form action="./insert" method="post" enctype="multipart/form-data"
	 onsubmit="return check()">
	 	<h2><b>차량 등록</b></h2><br>
		<label for="name">차량 명칭</label>
		<input type="text" id="name" name="name"
		 class="form-control" style="width: 250px;"
		 maxlength="50" placeholder="차량 명칭"
		 required="required"/>
		<br>
		 
		<label for="price">차량 가격</label>
		<input type="number" id="price" name="price"
		 class="form-control" min="100000"
		 placeholder="500,000 단위" step="10000"
		 style="width: 250px;" required="required"/><br>
		 
		<label for="type">차량 유형</label>
		<input type="text" id="type" name="type"
		 class="form-control" style="width: 250px;"
		 maxlength="20" placeholder="차량 유형"
		 required="required"/><br>
		 
		<label for="excolor">외장 색깔</label>
		<input type="color" id="excolor" name="excolor"
		 class="form-control" style="width: 100px;"
		 placeholder="외장 색깔" value="#d4d4d4"/>
		<br>
		 
		<label for="incolor">내장 색깔</label>
		<input type="color" id="incolor" name="incolor"
		 class="form-control" style="width: 100px;"
		 placeholder="외장 색깔"/><br>
		 
		<!-- 사진 -->
		<label for="sidephoto">옆면 사진</label>&nbsp;
		<i class="bi bi-camera2 photo p1"></i>
		<img src="" id="showimg1" onerror="this.src='../noimage.png'"/>
		<input type="file" id="sidephoto" name="supload"
		 style="display: none;" onchange="preview1(this)"
		 accept="image/*"/><br><br>
		
		<label for="frontphoto">앞면 사진</label>&nbsp;
		<i class="bi bi-camera2 photo p2"></i>
		<img src="" id="showimg2" onerror="this.src='../noimage.png'"/>
		<input type="file" id="frontphoto" name="fupload"
		 style="display: none;" onchange="preview2(this)"
		 accept="image/*"/><br><br>
		
		<div class="input-group" style="width: 150px;">
			<label for="cnt">수량</label>&nbsp;&nbsp;
			<input type="number" id="cnt" name="cnt"
			 class="form-control" min="1" placeholder="물량"
			 style="float: right;" required="required"/>
		</div><br>
		
		<span class="result"></span>
		<button type="submit" class="btn btn-outline-info"
		 style="float: right;">제출</button><br>
	</form>
</div>
</body>
</html>