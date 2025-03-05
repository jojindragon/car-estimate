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
        body *{
            font-family: 'Jua';
        }
        
        #showimg{
        	width: 120px;
        	height: 140px;
        	border: 1px solid gray;
        }
        
        .tab1 tbody th{
        	background-color: #f0f8ff;
        }
     </style>
     <script>
     	let jungbok=false;
     	
     	$(function(){
     		//중복버튼 이벤트
     		$("#btnidcheck").click(function(){
     			let myid=$("#myid").val();
     			$.ajax({
     				type:"get",
     				dataType:"json",
     				data:{"myid":myid},
     				url:"./idcheck",
     				success:function(res){
     					if(res.result=='success'){
     						jungbok=true;
     						alert("사용가능한 아이디입니다");     						
     					}else{
     						jungbok=false;
     						alert("존재하는 아이디입니다\n다시 입력해주세요");
     						$("#myid").val("");
     					}
     				}
     			});
     			
     		});
     		
     		//아이디를 입력시 중복변수 다시 false로...
     		$("#myid").keyup(function(){
     			jungbok=false;
     		});
     	});
     	
     	function check(){
     		
     		let p1=$("#mpass").val();
     		if(p1!=p2){
     			alert("비밀번호가 맞지 않습니다");
     			return false;
     		}
     		
     		if(!jungbok){
     			alert("중복체크 버튼을 눌러주세요");
     			return false;
     		}
     		
     	}
     </script>
</head>
<body>
<jsp:include page="../../layout/title.jsp"/>
<div style="margin: 10px 30px;width: 500px;">
	<form action="./insert" method="post" enctype="multipart/form-data" onsubmit="return check()">
		<table class="table table-bordered tab1">
			<tbody>
				<tr>
					<th>이름</th>
					<td class="input-group">
						<input type="text" name="mname" class="form-control"
						required="required">
					</td>
				</tr>
				<tr>
					<th>아이디</th>
					<td class="input-group">
						<input type="text" name="myid" id="myid" class="form-control"
						required="required">
						<button type="button" class="btn btn-sm btn-danger"
						id="btnidcheck">중복체크</button>
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td class="input-group">
						<input type="password" name="mpass" id="mpass" class="form-control"
						placeholder="비밀번호" required="required">
					</td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td class="input-group">
						<input type="text" name="nickname" class="form-control">
					</td>
				</tr>
				<tr>
					<th>핸드폰</th>
					<td class="input-group">
						<input type="text" name="mhp" class="form-control"
						required="required">					
					</td>
				</tr>
				<tr>
					<th>주 소</th>
					<td colspan="2">
						<input type="text" name="maddr" class="form-control">
					</td>
				</tr>
				<tr>
					<td colspan="3" align="center">
						<button type="submit" class="btn btn-sm btn-success">회원가입</button>
					</td>
				</tr>
			</tbody>		
		</table>
	</form>
</div>
</body>
</html>