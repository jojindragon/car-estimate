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
.info {
	margin: 20px;
	height: 100%;
	background-color: #f8f9fa;
}
.line {
	display: flex;
	margin-top: 20px;
	justify-content: left;
}
.info img {
	margin: 30px;
	width: 500px;
}
.next {
	font-size: 2em;
	color: gray;
	width: 50px;
	height: 50px;
	text-align: center;
	line-height: 50px;
	border: 1px solid gray;
	margin-top: 150px;
	gap: 50px;
	border-radius: 100px;
	background-color: white;
	cursor: pointer;
}
.color {
	border: 1px solid black;
	border-radius: 100px;
	width: 80px;
	height: 80px;
}
</style>
</head>
<body>
<jsp:include page="../../layout/title.jsp"/>
<div class="info">
	<h1><b>${dto.name}</b></h1>
	<p>총 차량 가격</p>
	<h3>
		<b><fmt:formatNumber value="${dto.price}" type="number"/>원</b>
	</h3><br>
	<div class="line">
		<p>외장</p><div class="color" style="background-color: ${dto.excolor}"></div>
	</div>
	<div class="line">
		<p>내장</p><div class="color" style="background-color: ${dto.incolor}"></div>
	</div>
	<div class="line">
		<img src="${carurl}/car/${dto.sidephoto}"/>
		<div class="next">&gt;</div>
	</div>
	<p style="color: gray;margin-left: 100px;">본 차량의 이미지는 실제와 다를 수 있습니다.</p>
</div>
<script type="text/javascript">
let chk = false;
$(".next").click(function() {
	let photo = `${carurl}/car/${dto.sidephoto}`;
	if(!chk) {
		photo = `${carurl}/car/${dto.frontphoto}`;
	}
	chk = !chk;
	$(this).siblings().attr("src", photo);
});
</script>
</body>
</html>