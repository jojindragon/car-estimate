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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
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

.profile img{
	width: 60px;
	height: 60px;
	border: 1px solid #f8f9fa;
	border-radius: 100px;
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
<!-- 로그인창 활성화 -->
<div class="modal" id="myLoginModal" style="top: 300px;">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title"><b>회원 로그인</b></h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
      <form id="loginfrm">
	        <table class="logintab">
	        	<tbody>
	        		<tr>
	        			<th width="80">아이디</th>
	        			<td>
	        				<input type="text" id="loginid" name="loginid" placeholder="아이디"
	        				 class="form-control" required="required">
	        			</td>
	        		</tr>
	        		<tr>
	        			<th width="80">비밀번호</th>
	        			<td>
	        				<input type="password" id="loginpass" name="loginpass" placeholder="비밀번호"
	        				 class="form-control" required="required">
	        			</td>
	        		</tr>
	        	</tbody>
	        </table>
	        <button type="submit" class="btn btn-sm btn-success"
	         style="margin-top: 20px;">로그인</button>
        </form>
      </div>
    </div>
  </div>
</div>

<div class="title">
	<nav class="menu">
		<ul>
			<li><a href="${root}/">견적비교</a></li>
			<c:if test="${sessionScope.admin}">
				<li><a href="${root}/car/addform">차량 정보 등록</a></li>
				<li><a href="${root}/user/manage">회원 관리</a></li>
			</c:if>
		</ul>
	</nav>
	
	<div class="logo">
		<a href="${root}/">
		<img src="${root}/logo.png"/>
		</a>
		<!-- 로그인 상태노출 -->
		<c:if test="${sessionScope.loginstatus!=null}">
			<b>${sessionScope.loginid}</b> 님 환영합니다!
		</c:if>
	</div>
	
	<div class="auth">
		<c:if test="${sessionScope.loginstatus==null}">
			<span id="register">회원가입</span>
			<span data-bs-toggle="modal" data-bs-target="#myLoginModal"
			 style="cursor: pointer;">로그인</span>
		</c:if>
		<c:if test="${sessionScope.loginstatus!=null}">
			<span style="cursor: pointer" id="mypage">마이페이지</span>
			<span style="cursor: pointer" id="logout">로그아웃</span>
		</c:if>
	</div>
</div>
<script type="text/javascript">
	$("#register").click(function(){
		location.href="${root}/user/regifrm";
	});
	$("#mypage").click(function(){
		location.href="${root}/user/mypage";
	});
		$("#loginfrm").submit(function(e){
			e.preventDefault();
			let loginid=$("#loginid").val();
			let loginpass=$("#loginpass").val();
			
			$.ajax({
				type:"post",
				dataType:"json",
				data:{"loginid":loginid,"loginpass":loginpass},
				url:"${root}/login",
				success:function(res){
					if(res.result=='success'){
						$("#loginid").val("");
						$("#loginpass").val("");
						$(".btnclose").trigger("click");
						location.reload();
					}else{
						alert("아이디나 비밀번호가 맞지 않습니다");
						$("#loginpass").val("");
					}
				}
			});
		});
	
		$("#logout").click(function(){
			$.ajax({
				type:"get",
				dataType:"text",
				url:"${root}/logout",
				success:function(res){
					//새로고침
					location.reload();
				}
			});
		});
		
	</script>
</body>
</html>