<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
	<link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&family=Gaegu&family=Jua&family=Nanum+Pen+Script&family=Playwrite+AU+SA:wght@100..400&family=Single+Day&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body *{
            font-family: 'Jua';
        }
        
        #showimg{
        	width: 120px;
        	height: 140px;
        	border: 1px solid gray;
        }
        
        .profilelargephoto{
        	width: 150px;
        	height: 150px;
        	border:1px solid gray;
        	border-radius: 100px;
        }
        .changecamera {
        	position: absolute;
    		top: 10px;
	    	right: 10px;
    		font-size: 20px;
    		cursor: pointer;
	    	color: black; 
        }
        .receipt {
        	width: 400px;
        	margin: auto;
        	padding: 20px;
        	border: 1px solid #ddd;
        	border-radius: 10px;
        	font-family: 'Arial', 'sans-serif';
        	background-color: #f9f9f9;
        }
        .receiptShow {
        	text-decoration: underline;
        	cursor: pointer;
        	font-size: 1em;
        	color: black;
        }
        .receiptShow:hover {
        	font-size: 1.3em;
        	color: orange;
        }
     </style>
</head>
<body>

<!-- 수정 Modal -->
<div class="modal" id="myUpdateModal">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">회원정보 수정</h4>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
        <h6>닉네임 수정</h6>
        <input type="text" class="form-control" id="nickname"
         value="${dto.nickname}">
        <h6>핸드폰 수정</h6>
        <input type="text" class="form-control" id="phone"
         value="${dto.phone}">
        <h6>주소 수정</h6>
        <input type="text" class="form-control" id="addr"
         value="${dto.addr}">
        <br>
        <button type="button" class="btn btn-sm btn-success"
         id="btnupdate" data-bs-dismiss="modal">수정</button>
        
        <script>
        	$("#btnupdate").click(function(){
        		$.ajax({
        			type:"post",
        			dataType:"text",
        			data:{"nickname":$("#nickname").val(),"phone":$("#phone").val(),
        				"addr":$("#addr").val(),"id":${dto.id}},
        			url:"./update",
        			success:function(){
        				location.reload();
        			}
        		
        		});
        	});
        
        </script>
      </div>
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<!-- 프로필 -->
<jsp:include page="../../layout/title.jsp"/>
<table style="margin: 50px auto;">
    <tr>
        <td style="text-align: center; vertical-align: top;">
            <div style="position: relative;">
                <img src="${naverurl}/user/${dto.profile}" class="profilelargephoto"
                 onerror="this.src='../noimage.png'">
                <input type="file" id="fileupload" style="display: none;">
                <i class="bi bi-camera-fill changecamera"></i>
            </div>
        </td>
        <td style="vertical-align: top; padding-left: 30px;">
            <h6>회원명 : ${dto.nickname}</h6>
            <h6>아이디 : ${dto.userId}</h6>
            <h6>핸드폰 : ${dto.phone}</h6>
            <h6>주소 : ${dto.addr}</h6>
            <h6>생성일 : 
                <fmt:formatDate value="${dto.createday}" pattern="yyyy-MM-dd HH:mm"/>
            </h6>
            <br><br>
            <button type="button" class="btn btn-sm btn-outline-danger"
             onclick="userdel(${dto.id})">회원탈퇴</button>
             
            <button type="button" class="btn btn-sm btn-outline-info"
             data-bs-toggle="modal" data-bs-target="#myUpdateModal">회원정보수정</button>
        </td>
    </tr>
</table>

<script>
/* 프로필 관련 이벤트들 */
$(".changecamera").click(function(){
	$("#fileupload").trigger("click");
});
		
//프로필 변경 이벤트
$("#fileupload").change(function(e){
	let form=new FormData();
	form.append("upload",e.target.files[0]);
	form.append("id",${dto.id});
		
	$.ajax({
		type:"post",
		dataType:"text",
		data:form,
		url:"./changeprofile",
		processData:false,
		contentType:false,
		success:function(){
			location.reload();
		}
	});
});
function userdel(num){
	let ans=confirm("정말 탈퇴하시겠습니까?");
	if(ans){
		$.ajax({
			type:"get",
			dataType:"text",
			data:{"id":num},
			url:"./mypagedel",
			success:function(){
				location.href='../';
			}
		});
	}
}
</script>	
<!-- 장바구니 -->
<div style="display: flex; justify-content: center; align-items: center;margin: 0;">
	<div style="margin: auto;width: 750px;">
		<h4 style="background-color: lightgray; text-align: center; padding: 10px; border-radius: 5px;"><b>장바구니목록</b></h4>
		<div class="result"></div>
	</div>
</div>
<!-- 영수증 부르기 -->
<div style="display: flex; justify-content: center; align-items: center;">
    <span class="receiptShow">영수증 보기</span>
</div>
<div class="receipt">
    <h2 style="text-align: center; color: #333; border-bottom: 1px solid #ddd; padding-bottom: 10px;">영수증 내역</h2>
    <p style="text-align: center; color: #888; font-size: 12px;">감사합니다!</p>
    <c:forEach var="rc" items="${receipt}" varStatus="status">
        <div style="margin-bottom: 20px; padding: 10px; border: 1px solid #eee; border-radius: 5px;">
            <p style="margin: 5px 0; font-size: 16px;">
            	<strong>구매 차량:</strong> ${rc.name}
            </p>
            <p style="margin: 5px 0; font-size: 16px;">
            	<strong>지불한 가격:</strong> 
            	<fmt:formatNumber value="${rc.price}" type="number"/>원
            </p>
            <p style="margin: 5px 0; font-size: 16px;">
            	<strong>구매일자:</strong>
            	<fmt:formatDate value="${rc.purchaseday}" pattern="yyyy-MM-dd HH:mm"/>
            </p>
        </div>
        <hr>
    </c:forEach>
</div>

<script type="text/javascript">
cartlist();
$(".receipt").hide();

$(".receiptShow").click(function() {
	$(".receipt").toggle();
});

// 장바구니 해제
$(document).on("click", ".cartdel", function() {
	let idx = $(this).attr("idx");
	
	$.ajax({
		type: "get",
		dataType: "text",
		data: {"idx":idx},
		url: "../car/outcart",
		success: function() {
			cartlist();
		}
	});
});

function cartlist() {
   	$.ajax({
   		type: "get",
   		dataType: "json",
   		url: "./mypagecart",
   		success: function(res) {
   			console.log(res);
   			if(res.length == 0) {
   				$(".result").html("장바구니가 비었습니다.");
   			} else {
   				let s=`
   				<table class="table table-bordered" style="text-align: center;">
   					<thead>
   						<tr>
   							<th width="100">차량명</th>
   							<th width="100">가격</th>
   							<th width="80">타입</th>
   							<th width="80">견적보기</th>
   							<th width="100">장바구니 해제</th>
   						</tr>
   					</thead>
   					<tbody>`;
   				
   				$.each(res, function(i, item) {
   					let price = Math.floor(Number(`\${item.price}`)/10000).toLocaleString();
   					s+=`
   					<tr>
   						<td>\${item.name}</td>
   						<td>\${price}만원~</td>
   						<td>\${item.type}</td>
   						<td>
   							<button type="button" class="btn btn-sm btn-dark"
   							 onclick="location.href='../car/detail?idx=\${item.idx}'">보러가기</button>
   						</td>
   						<td align="center">
   							<span class="cartdel" style="color: red;cursor: pointer;" idx="\${item.idx}">제거</span>
   						</td>
   					</tr>
   					`;
   				});

   				 s+="</tbody></table>";
    			$(".result").html(s);
   			}
		}
	});
}
</script>
</body>
</html>