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
.usermanage {
	font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
    margin-top: 100px;
    height: auto;
}
.table-container {
    width: 90%;
    max-width: 1200px;
    overflow-x: auto; /* 테이블이 너무 클 경우 가로 스크롤 허용 */
    background-color: #ffffff;
    border-radius: 8px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    padding: 20px;
}
/* 테이블 스타일 */
.data-table {
    width: 100%;
    border-collapse: collapse;
    text-align: left;
}

.data-table th {
	text-align: center;
    padding: 10px;
    border: 1px solid #ddd;
}

.data-table thead {
    background-color: #333;
    color: #fff;
}

.data-table td {
    padding: 10px;
    border: 1px solid #ddd;
}

.data-table tbody tr:nth-child(even) {
    background-color: #f2f2f2;
}

.data-table tbody tr:hover {
    background-color: #eaeaea;
    transition: background-color 0.3s ease;
}
.result span {
	cursor: pointer;
}
.result img {
	border: 1px solid black;
	border-radius: 100px;
	width: 50px;
	height: 50px;
}
</style>
</head>
<body>
<jsp:include page="../../layout/title.jsp"/>
<div class="usermanage">
	<div class="table-container">
		<table class="data-table">
			<thead>
				<tr>
					<th>닉네임</th>
					<th>아이디</th>
					<th>핸드폰</th>
					<th width="80">관리자 여부</th>
					<th>계정 생성일</th>
					<th width="80">관리자 임명</th>
					<th width="80">제거</th>
				</tr>
			</thead>
			<tbody class="result"></tbody>
		</table>
	</div>
</div>
<script type="text/javascript">
userlist();

// 어드민 부여
$(document).on("click", ".admin", function() {
	let id = $(this).attr("num");
	$.ajax({
		type: "post",
		dataType: "text",
		data: {"id":id},
		url: "./setadmin",
		success: function() {
			userlist();
		}
	});
	
});

// 계정 삭제
$(document).on("click", ".del", function() {
	let id = $(this).attr("num");
	let ans = confirm("삭제하시겠습니까?");
	
	if(ans) {
		$.ajax({
			type: "get",
			dataType: "text",
			data: {"id":id},
			url: "./delete",
			success: function() {
				userlist();
			}
		});
	}
	
});

function userlist() {
	$.ajax({
		type: "get",
		dataType: "json",
		url: "./userlist",
		success: function(res) {
			let s="";
			
			$.each(res, function(i, item) {
				s+= `
				<tr>
					<td>
						<img src="${naverurl}/user/\${item.profile}" onerror="this.src='../noimage.png'"/>
						\${item.nickname}
					</td>
					<td>\${item.userId}</td>
					<td>\${item.phone}</td>
					<td align="center">\${item.admin}</td>
					<td align="center">
						\${item.createday}
					</td>
					<td align="center">
						<span class="admin" style="color: orange;" num="\${item.id}">부여</span>
					</td>
					<td align="center">
						<span class="del" style="color: red;" num="\${item.id}">퇴출</span>
					</td>
				</tr>
				`;
			});
			
			$(".result").html(s);
		}
	});
}
</script>
</body>
</html>