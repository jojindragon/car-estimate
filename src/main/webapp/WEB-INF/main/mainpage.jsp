<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>차량 카탈로그</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
<style>
list {
	font-family: 'Arial', 'sans-serif';
	margin: 20px;
	text-align: center
}
.tags {
	display: flex;
	justify-content: left;
	margin: 10px;
	gap: 30px;
	font-size: 18px;
	font-weight: bold;
}
.tag-item {
	text-decoration: none;
	color: gray;
	padding: 10px 15px;
	border-bottom: 3px solid transparent;
	transition: border-bottom 0.3s ease;
	cursor: pointer;
}
.tag-item:hover {
	border-bottom: 3px solid gray;
}
.tag-item.active {
	color: black;
	border-bottom: 3px solid black;
}
/* 차량 리스트 디자인 */
.car-list {
	margin: 10px;
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 15px;
	justify-items: center;
}
.car-item {
	text-align: center;
	border: 1px solid #ddd;
	padding: 10px;
	border-radius: 8px;
	box-shadow: 0 3px 5px rgba(0, 0, 0, 0.1);
	width: 90%;
	height: 300px;
	transition: transform 0.3s, box-shadow 0.3s;
}
.car-item:hover {
	transform: translateY(-5px);
	box-shadow: 0 6px 10px rgba(0, 0, 0, 0.15);
}
.car-img {
	width: 100%;
	height: auto;
	border-radius:10px;
	transition: opacity 0.5 ease, transform 0.5s ease;
}

.car-name {
	font-size: 1.2em;
	font-weight: bold;
	margin-bottom: 5px;
}
.car-price {
    font-size: 1em;
    color: #ccc;
}
.action-links {
    margin-top: 20px;
    font-size: 0.8rem;
    display: none;
}
.action-links a {
    margin: 0 3px;
    color: black;
    text-decoration: none;
    font-size: 1.5em;
}

#check {
	cursor: pointer;
	margin-right: 10px;
	float: right;
}
div.estimate {
	justify-content: center;
	gap: 30px;
}
.box {
	border: 1px dashed black;
	border-radius: 5px;
	
}
.box img {
	width: 100px;
	height: 100px;
}
</style>
</head>
<body>
<jsp:include page="../../layout/title.jsp"/>
<br><br><br>
<div class="list">
	<div class="type-list">
		<i class="bi bi-check-circle" id="check">모델 비교</i>
		<nav class='tags'>
		<c:forEach var="tag" items="${typelist}" varStatus="status">
			<a tag="${tag}" class="tag-item ${status.first ? 'active':'' }">${tag}</a>
		</c:forEach>
		</nav>
	</div>
	<hr style="color: #d4d4d4;">
	<!-- 견적 비교  -->
	<div class="estimate input-group">
		<div class="box" id="box1">
			<img src="." onerror="this.src='../noimage.png'"/>
		</div>
		<div class="box" id="box2">
			<img src="." onerror="this.src='../noimage.png'"/>
		</div>
		<div class="box" id="box3">
			<img src="." onerror="this.src='../noimage.png'"/>
		</div>
	</div>
	<!-- 차량 리스트 -->
	<div class="car-list"></div>
</div>
<script type="text/javascript">
carlist($(".tag-item.active").attr("tag"));

$(".tag-item").click(function() {
	$(".tag-item").removeClass("active");
	$(this).addClass("active");
	
	//console.log(type);
	carlist($(this).attr("tag"));
});

// 차량 비교 이벤트
let chk = false;
$(".estimate").hide();
$("#check").click(function() {
	if(!chk) {
		$(this).removeClass("bi-check-circle");
		$(this).addClass("bi-check-circle-fill");
		chk = true;
		$(".estimate").show().addClass("show");
	} else {
		$(this).removeClass("bi-check-circle-fill");
		$(this).addClass("bi-check-circle");
		chk=false;
		$(".estimate").hide().removeClass("show");
	}
	
});

//차량 이미지 전환
$(document).on("mouseenter", ".car-item", function() {
	const img = $(this).find(".car-img");
	const a = $(this).find(".action-links");
	//alert(img.attr("src"));
	img.attr("src", img.attr("front"));
	a.css("display", "block");
});

$(document).on("mouseleave", ".car-item", function() {
	const img = $(this).find(".car-img");
	const a = $(this).find(".action-links");
	img.attr("src", img.attr("side"));
	a.css("display", "none");
});

// 차량 리스트 출력
function carlist(type) {
	$.ajax({
		type: "get",
		dataType: "json",
		data: {"type":type},
		url: "./carlist",
		success: function(res) {
			let s = "";
			
			$.each(res, function(i, item) {
				let price = Math.floor(Number(`\${item.price}`)/10000).toLocaleString();
				let side = `${carurl}/car/\${item.sidephoto}`;
				let front = `${carurl}/car/\${item.frontphoto}`;
				
				s+=`
				<div class="car-item">
					<img src="\${side}" class="car-img"
					 onerror="this.src='../noimage.png'"
					 side="\${side}" front="\${front}"/>
					<br><br><br>
					<div class="car-name">\${item.name}</div>
					<div class="car-price">\${price}만원~</div>
					<div class="action-links">
		            	<a href="./car/detail?idx=\${item.idx}"><b>견적 내기 &gt;</b></a>
		        	</div>
				</div>
				`;
			});
			
			$(".car-list").html(s);
		}
	});
}
</script>
</body>
</html>