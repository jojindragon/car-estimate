<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&family=Gaegu&family=Jua&family=Nanum+Pen+Script&family=Playwrite+AU+SA:wght@100..400&family=Single+Day&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
<style>
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
#showimg {
	width: 120px;
	height: 140px;
	border: 1px solid gray;
	border-radius: 10px;
}
.btn-danger {
	margin: 5px;
	float: right;
}
span.result {
	maring-top: 10px;
	color: red;
	font-family: 'Gaegu';
	display: none;
} 
</style>
</head>
<script type="text/javascript">
let chk1 = false; // 아이디 중복 상태
let chk2 = false; // 닉네임 중복 상태

$(function() {
	// 아이디 유효성 검사
	$("#btnIdCheck").click(function() {
		let userId = $("#userId").val();
		
		if(userId.trim().length < 5) {
			$("#idChk").text("아이디는 5글자 이상입니다.");
			$("#idChk").css("display", "block");
			$("#idChk").css("color", "red");
			chk1 = false;
			return;
		}
		
		$.ajax({
			type: "get",
			dataType: "json",
			data: {"userId":userId},
			url: "./idcheck",
			success: function(res) {
				if(res.result == "success") {
					chk1 = true;
					$("#idChk").text("사용 가능한 아이디입니다.");
					$("#idChk").css("display", "block");
					$("#idChk").css("color", "green");					
				} else {
					chk1 = false;
					$("#idChk").text("사용할 수 없는 아이디입니다.");
					$("#idChk").css("display", "block");
					$("#idChk").css("color", "red");
					$("#userId").val();
				}
				
			}
		});
		
	});
	
	// 닉네임 중복 검사
	$("#btnNickCheck").click(function() {
		let nickname = $("#nickname").val();
		
		if(nickname.trim() == "") {
			$("#nickChk").html("닉네임을 작성하세요!");
			$("#nickChk").css("display", "block");
			$("#nickChk").css("color", "red");
			chk2 = false;
			return;
		}
		
		$.ajax({
			type: "get",
			dataType: "json",
			data: {"nickname":nickname},
			url: "./nickcheck",
			success: function(res) {
				if(res.result == "success") {
					chk2 = true;
					$("#nickChk").text("사용 가능한 닉네임입니다.");
					$("#nickChk").css("display", "block");
					$("#nickChk").css("color", "green");					
				} else {
					chk2 = false;
					$("#nickChk").text("사용할 수 없는 닉네임입니다.");
					$("#nickChk").css("display", "block");
					$("#nickChk").css("color", "red");
					$("#nickname").val();
				}
			}
		});
		
	});
	
	$("#userId").keyup(function() {
		chk1 = false;
		$("#idChk").css("display", "none");
	});
	$("#nickname").keyup(function() {
		chk2 = false;
		$("#nickChk").css("display", "none");
	});
});

function check() {
	let p1 = $("#password").val();
	let p2 = $("#pwd2").val();
	
	if(p1 != p2) {
		$("#pwdChk").text("비밀번호가 맞지 않습니다.");
		$("#pwdChk").css("display", "block");
		$("#pwdChk").css("color", "red");
		return false;
	}
	
	if(!chk1 || !chk2) {
		$("#pwdChk").text("아이디 및 닉네임 검사를 해주세요.");
		$("#pwdChk").css("display", "block");
		$("#pwdChk").css("color", "red");
		return false;
	}
	
}
</script>
<body>
<jsp:include page="../../layout/title.jsp"/>
<div class="form">
	<form action="./register" method="post" enctype="multipart/form-data"
	 onsubmit="return check()">
		<label for="userId">아이디</label>
		<input type="text" id="userId" name="userId"
		 class="form-control"
		 maxlength="20" placeholder="User ID를 입력하세요."
		 required="required"/>
		<button type="button" class="btn btn-sm btn-danger"
		 id="btnIdCheck">체크</button>
		<span class="result" id="idChk"></span>
		<br><br>
		 
		<label for="password">비밀번호</label>
		<input type="password" id="password" name="password"
		 class="form-control"
		 maxlength="20" placeholder="비밀번호를 입력하세요."
		 required="required"/><br>
		 
		<label>비밀번호 확인</label>
		<input type="password" id="pwd2" name="pwd2"
		 class="form-control"
		 maxlength="20" placeholder="비밀번호 확인"
		 required="required"/><br>
		 
		<label for="nickname">닉네임</label>
		<input type="text" id="nickname" name="nickname"
		 class="form-control"
		 maxlength="20" placeholder="닉네임을 입력하세요."
		 required="required"/>
		<button type="button" class="btn btn-sm btn-danger"
		 id="btnNickCheck">체크</button>
		<span class="result" id="nickChk"></span>
		<br><br>
		
		<label for="profile">프로필</label>&nbsp;
		<i class="bi bi-camera2 photo"></i><br>
		<img src="" id="showimg" onerror="this.src='../noimage.png'"/>
		<input type="file" id="profile" name="upload"
		 style="display: none;"/><br><br>
		
		<label for="phone">핸드폰 번호</label>
		<input type="text" id="phone" name="phone"
		 class="form-control"
		 placeholder="010-xxxx-xxxx"/><br>
		
		<label for="phone">주소</label>
		<input type="text" id="addr" name="addr"
		 class="form-control"
		 placeholder="주소를 입력하세요."/><br><br>
		
		<span class="result" id="pwdChk"></span>
		<button type="submit" class="btn btn-outline-info"
		 style="float: right;">제출</button><br>
	</form>
</div>
</body>
</html>