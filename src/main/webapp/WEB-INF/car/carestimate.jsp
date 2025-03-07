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
.container {
	width: 100%;
    margin-top: 100px;
    text-align: center;
    font-family: 'Arial', 'sans-serif';
}
.header {
    padding: 20px 0;
    text-align: center;
    margin-bottom: 30px;
}
.header h1 {
    margin: 0;
    font-size: 2em;
    font-weight: bold;
}
.content {
    display: flex;
    justify-content: center;
    gap: 40px;
    padding: 20px;
}
.card {
    background-color: #f8f8f8;
    border: 1px solid #ddd;
    border-radius: 8px;
    padding: 10px;
    width: 450px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}
.card img {
    width: 100%;
    height: auto;
    border-radius: 4px;
    margin-bottom: 10px;
}
.card p {
    font-size: 14px;
    color: #555;
}
.type {
	font-size: 0.8em;
	color: #ccc;
	margin-bottom: 30px;
}
.out {
	position: fixed;
	top: 60px;
	right: 100px;
	font-size: 2.5em;
	font-weight: bold;
	color: black;
	cursor: pointer;
}
</style>
</head>
<body>
<div class="container">
	<i class="bi bi-x-lg out" onclick="location.href='../'"></i>
	<div class="header">
		<h1>모델 비교</h1>
		<p></p>
	</div>
	<div class="content">
	<c:forEach var="dto" items="${list}">
		<div class="card">
			<img src="${carurl}/car/${dto.sidephoto}">
			<h2><b>${dto.name}</b></h2>
			<span class="type">차량 타입: ${dto.type}</span>
			<div class="input-group" style="justify-content: space-between;">
				<c:if test="${dto.cnt>0}">
					<p>남은 물량</p>
					<p>${dto.cnt}대</p>
				</c:if>
				<c:if test="${dto.cnt==0}">
					<p style="color: red;">[품절]</p>
				</c:if>
			</div>
			<div class="input-group" style="justify-content: space-between;">
				<p>차량 가격</p>
				<p>
					<fmt:formatNumber value="${dto.price}" type="number"/>원
				</p>
			</div>
			<hr style="margin: 10px;">
			<button type="button" class="btn btn-dark"
			 style="width: 80%;margin: auto;padding: 15px;"
			 onclick="location.href='./detail?idx=${dto.idx}'"><b>견적 내기</b></button>
		</div>
	</c:forEach>
	</div>
</div>
</body>
</html>