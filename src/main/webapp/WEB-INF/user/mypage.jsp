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
        
        .tab1 tbody th{
        	background-color: #f0f8ff;
        }
        
        .profilelargephoto{
        	width: 150px;
        	height: 150px;
        	border:1px solid gray;
        	border-radius: 100px;
        }
     </style>
     <script>
     	let jungbok=false;
     	
     	$(function(){
     		//중복버튼 이벤트
     		$("#btnidcheck").click(function(){
     			let userid=$("#userid").val();
     			$.ajax({
     				type:"get",
     				dataType:"json",
     				data:{"userid":userid},
     				url:"./idcheck",
     				success:function(res){
     					if(res.result=='success'){
     						jungbok=true;
     						alert("사용가능한 아이디입니다");     						
     					}else{
     						jungbok=false;
     						alert("존재하는 아이디입니다\n다시 입력해주세요");
     						$("#userid").val("");
     					}
     				}
     			});
     			
     		});
     		
     		$("#userid").keyup(function(){
     			jungbok=false;
     		});
     	});
     	
     	function check(){
     		
     		let p1=$("#password").val();
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
<div style="margin: 50px 600px;">
	 <img src="${naverurl}/user/${dto.profile}" class="profilelargephoto"
	  onerror="this.src='../noimage.png'" style="float: left;">
	
	<input type="file" id="fileupload" style="display: none;">
	
	 <i class="bi bi-camera-fill changecamera"
        style="position: absolute; left: 40%; transform: translateX(40px); 
                  font-size: 20px; cursor: pointer; color: black;"></i>
</div>

<!-- 프로필 사진관련 -->
<script>
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
	</script>
	<div style="display: inline-block;margin: 15px 30px;">
		<h6>회원명 : ${dto.nickname}</h6>
		<h6>아이디 : ${dto.userId}</h6>
		<h6>핸드폰 : ${dto.phone}</h6>
		<h6>주  소 : ${dto.addr}</h6>
		<h6>생성일 : 
			<fmt:formatDate value="${dto.createday}" pattern="yyyy-MM-dd HH:mm"/>
		</h6>
		<br><br>
		<button type="button" class="btn btn-sm btn-outline-danger"
		onclick="userdel(${dto.id})">회원탈퇴</button>
		
		<script>
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
		<button type="button" class="btn btn-sm btn-outline-info"
		data-bs-toggle="modal" data-bs-target="#myUpdateModal">회원정보수정</button>		
	</div>
	<!-- 장바구니 -->
	<div style="margin: 50px 200px;width: 500px;">
		<h4 style="background-color: lightgray; text-align: center; padding: 10px; border-radius: 5px;"><b>장바구니목록</b></h4>
		<div class="result"></div>
    </div>
    
    <script type="text/javascript">
    cartlist();
    
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
    				<table class="tabboard table table-bordered text-center">  
    				<table class="table">
    					<thead>
    						<tr>
    							<th width="100">차량명</th>
    							<th width="100">가격</th>
    							<th width="80">타입</th>
    							<th width="80">견적보기</th>
    						</tr>
    					</thead>
    					<tbody>`;
    				
    				$.each(res, function(i, item) {
    					s+=`
    					<tr>
    						<td>\${item.name}</td>
    						<td>\${item.price}</td>
    						<td>\${item.type}</td>
    						<td>
    							<button type="button" class="btn btn-sm btn-dark"
    							 onclick="location.href='../car/detail?idx=\${item.idx}'">보러가기</button>
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
    </tbody>
</body>
</html>