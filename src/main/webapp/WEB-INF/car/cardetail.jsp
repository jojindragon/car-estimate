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
#cart {
	cursor: pointer;
}
</style>
</head>
<body>
<div class="modal" id="updateModal" style="top: 250px;">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title"><b>정보 수정</b></h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
      <form action="./upload" method="post"  enctype="multipart/form-data">
      		<input type="hidden" value="${dto.idx}" name="idx"/>
      		<input type="hidden" value=${dto.sidephoto} name="sidephoto"/>
      		<input type="hidden" value=${dto.frontphoto} name="frontphoto"/>
	        <table class="uptable">
	        	<tbody>
	        		<tr>
	        			<th width="80">차량명</th>
	        			<td>
	        				<input type="text" id="name" name="name" placeholder="차량명"
	        				 class="form-control" value="${dto.name}" required="required">
	        			</td>
	        		</tr>
	        		<tr>
	        			<th width="80">가격</th>
	        			<td>
	        				<input type="number" id="price" name="price" placeholder="차량 가격"
	        				 value="${dto.price}" min="1000000" step="10000"
	        				 class="form-control" required="required">
	        			</td>
	        		</tr>
	        		<tr>
	        			<th width="80">수량</th>
	        			<td>
	        				<input type="number" id="cnt" name="cnt" placeholder="차량 가격"
	        				 value="${dto.cnt}"
	        				 class="form-control" required="required">
	        			</td>
	        		</tr>
	        		<tr>
	        			<th width="80">차량 유형</th>
	        			<td>
	        				<input type="text" id="type" name="type" placeholder="차량 유형"
	        				 value="${dto.type}" class="form-control" required="required">
	        			</td>
	        		</tr>
	        		<tr>
	        			<th width="50">외장 색깔</th>
	        			<td>
	        				<input type="color" id="excolor" name="excolor"
	        				 value="${dto.excolor}" class="form-control"
	        				 style="width: 50px;">
	        			</td>
	        		</tr>
	        		<tr>
	        			<th width="50">내장 색깔</th>
	        			<td>
	        				<input type="color" id="incolor" name="incolor"
	        				 value="${dto.incolor}" class="form-control"
	        				 style="width: 50px;">
	        			</td>
	        		</tr>
	        		<tr>
	        			<th width="80">옆면 사진</th>
	        			<td>
	        				<input type="file" id="supload" name="supload" class="form-control"
	        				 accept="image/*">
	        			</td>
	        		</tr>
	        		<tr>
	        			<th width="80">앞면 사진</th>
	        			<td>
	        				<input type="file" id="fupload" name="fupload" class="form-control"
	        				 accept="image/*">
	        			</td>
	        		</tr>
	        		
	        	</tbody>
	        </table>
	        <button type="submit" class="btn btn-sm btn-info"
	         style="margin-top: 20px;">수정</button>
        </form>
      </div>
    </div>
  </div>
</div>
<jsp:include page="../../layout/title.jsp"/>
<div class="info">
	<div style="float: right;margin: 10px;">
	<c:if test="${sessionScope.loginstatus!=null && dto.cnt > 0}">
		<i class="bi bi-basket3" id="cart">장바구니 담기</i>&nbsp;
		<button class="btn btn-sm btn-outline-success purchase">구매</button>
	</c:if>
	<c:if test="${sessionScope.admin}">
		<button type="button" class="btn btn-sm btn-outline-info"
		 data-bs-toggle="modal" data-bs-target="#updateModal">정보 수정</button>
		<button type="button" class="btn btn-sm btn-outline-danger cardel">차량 삭제</button>
	</c:if>
	</div>
	<h1><b>${dto.name}</b></h1>
	<h5 style="font: 0.8em;">
	남은수량: <c:if test="${dto.cnt > 0}">${dto.cnt}</c:if>
	<c:if test="${dto.cnt == 0}">
		<p style="color: red;">[품절]</p>
	</c:if>
	</h5>
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
		<img src="${carurl}/car/${dto.sidephoto}"
		 onerror="this.src='../noimage.png'"/>
		<div class="next">&gt;</div>
	</div>
	<p style="color: gray;margin-left: 100px;">본 차량의 이미지는 실제와 다를 수 있습니다.</p>
</div>
<script type="text/javascript">
// 사진 변경 이벤트
let chk = false;
$(".next").click(function() {
	let photo = `${carurl}/car/${dto.sidephoto}`;
	if(!chk) {
		photo = `${carurl}/car/${dto.frontphoto}`;
	}
	chk = !chk;
	$(this).siblings().attr("src", photo);
});

//사진 삭제
$(".cardel").click(function() {
	let ans = confirm("정말 삭제하시겠습니까?");
	if(ans) {
		//alert(${dto.idx});
		$.ajax({
			type: "get",
			dataType: "text",
			data: {"idx":${dto.idx}},
			url: "./deletecar",
			success: function() {
				location.href="../";
			}
		});
	}
});

// 장바구니 이벤트
$("#cart").click(function() {
	$.ajax({
		type: "get",
		dataType: "json",
		data: {"idx":${dto.idx}},
		url: "./checkcart",
		success: function(res) {
			let idx = ${dto.idx};
			let ans = false;
			if(res.result == "success") {
				$("#cart").removeClass("bi-basket3");
				$("#cart").addClass("bi-basket3-fill");
				$("#cart").css("color", "gold");
				
				$.ajax({
					type: "get",
					dataType: "json",
					data: {"idx":${dto.idx}},
					url: "./incart",
					success: function() {
						location.reload();
					}
				});
				
			} else {
				ans = confirm("이미 장바구니에 담았습니다.\n제거하겠습니까?");
			}
			
			if(ans) {
				$.ajax({
					type: "get",
					dataType: "json",
					data: {"idx":${dto.idx}},
					url: "./outcart",
					success: function() {
						location.reload();
					}
				});
			}
		}
	});
	
});

//구매 버튼
$(".purchase").click(function() {
	let ans = confirm("구매하시겠습니까?");
	
	if(ans) {
		//alert(${dto.idx});
		$.ajax({
			type: "get",
			dataType: "text",
			data: {"idx":${dto.idx}},
			url: "./getcar",
			success: function() {
				location.reload();
			}
		});
	}
});
</script>
</body>
</html>