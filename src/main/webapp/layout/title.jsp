<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>title</title>
<link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&family=Gaegu&family=Jua&family=Nanum+Pen+Script&family=Playwrite+AU+SA:wght@100..400&family=Single+Day&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
<style>
body *{
	font-family: 'Arial', 'sans-serif';
}
.title {
	display: flex;
	justify-content: space-between;
	height: 100px;
	align-items: center;
	padding: 10px 20px;
	background-color: #f8f9fa;
	border-bottom: 1px solid #ddd;
}

.menu ul {
	list-style: none;
	padding: 0;
	margin: 0;
	display: flex;
}

.menu li {
	margin-right: 20px;
}
.menu a {
	text-decoration: none;
	color: #333;
	font-weight: bold;
	cursor: pointer;
}

.logo img{
	width: 80px;
	height: 80px;
	border: 1px solid #f8f9fa;
	border-radius: 100px;
	opacity: 80%;
	cursor: pointer;
}

.auth {
	margin-left: 10px;
	color: #333;
	cursor: pointer;
}
</style>
</head>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<body>
<div class="title">
	<nav class="menu">
		<ul>
			<li><a>메뉴1</a></li>
			<li><a>메뉴2</a></li>
			<li><a>메뉴3</a></li>
		</ul>
	</nav>
	
	<div class="logo">
		<img src="${root}/logo.png"/>
	</div>
	
	<div class="auth">
		<span>회원가입</span>
		<span>로그인</span>
		<span>로그아웃</span>
	</div>
</div>
</body>
</html>