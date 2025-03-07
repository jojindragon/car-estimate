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
<script src="https://js.tosspayments.com/v2/standard"></script>
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
<!-- 차량 수정 모달 -->
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

<!-- 상품 구매 모달(toss) -->
<div class="modal" id="tossModal" style="top: 250px;">
  <div class="modal-dialog">
    <div class="modal-content">
      	<!-- 결제 UI -->
		<div id="payment-method"></div>
		<!-- 이용약관 UI -->
		<div id="agreement"></div>
		<!-- 결제하기 버튼 -->
		<button type="button" id="payment-button" class="btn btn-info"
		 style="margin: 20px;width: 200px;">결제하기</button>
 		<!-- 결제 결과 표시 영역 -->
		<span id="payment-status" style="color: red;"></span>
    </div>
  </div>
</div>


<jsp:include page="../../layout/title.jsp"/>
<div class="info">
	<div style="float: right;margin: 10px;">
	<c:if test="${sessionScope.loginstatus!=null && dto.cnt > 0}">
		<i class="bi bi-basket3" id="cart">장바구니 담기</i>&nbsp;
		<button class="btn btn-sm btn-outline-success purchase"
		 data-bs-toggle="modal" data-bs-target="#tossModal">구매</button>
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

// toss 결제 이벤트
main();

async function main() {
    const button = $("#payment-button");
    const clientKey = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm";
    const tossPayments = TossPayments(clientKey);
    const customerKey = "jDuqCTyebFXUJIQvooutT";
    /* let widgets; */

 	// 위젯 초기화
    const widgets = tossPayments.widgets({
        customerKey,
    });

    // 주문의 결제 금액 설정
    await widgets.setAmount({
        currency: "KRW",
        value: ${dto.price},
    });

    await Promise.all([
        // 결제 UI 렌더링
        widgets.renderPaymentMethods({
            selector: "#payment-method",
            variantKey: "DEFAULT",
        }),
        // 이용약관 UI 렌더링
        widgets.renderAgreement({
            selector: "#agreement",
            variantKey: "AGREEMENT",
        }),
    ]);
    /* btn2.on("click", async function () {
        if (!widgets) {
            
        }
    }); */
    
    button.on("click", async function () {
    	const oId = "order-"+${dto.idx}+Math.random().toString(36).substr(2, 9);
        try {
            // 결제 요청 실행
            await widgets.requestPayment({
                orderId: oId,
                orderName: "order-"+${dto.idx},
                successUrl: window.location.href + "&status=success",
                failUrl: window.location.href + "&status=fail"
            });
        } catch (error) {
    		$("#payment-status").html("결제가 실패했습니다. 다시 시도해주세요.");
        }
    });
    
}
//URL에서 상태값 확인
const urlParams = new URLSearchParams(window.location.search);
const status = urlParams.get("status");

// 결제 결과에 따라 메시지 표시
if (status === "success") {
    //$("#payment-status").html("<p>결제가 성공적으로 완료되었습니다!</p>");
	$.ajax({
		type: "get",
		dataType: "text",
		data: {"idx":${dto.idx}},
		url: "./getcar",
		success: function() {
			//location.reload();
			location.href="./detail?idx="+${dto.idx};
		}
	});
} else if (status === "fail") {
    alert("실패");
}
</script>
</body>
</html>