<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="/WEB-INF/tlds/c.tld" %> 
<%@ taglib prefix="fn" 		uri="/WEB-INF/tlds/fn.tld" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.11.2.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/khsubs.css" />
<title>KH정보교육원 - 주민번호등록</title>
<style>
@import url('https://fonts.googleapis.com/css?family=Noto+Sans+KR:300&display=swap');
* { margin: 0; padding: 0; font-family: 'Noto Sans KR', sans-serif;}
.hr { border: 0; margin: 0; padding: 0; height: 1px; background: #e4e4e4; width: 100%; min-width: 1200px; }
ul, li { list-style: none;}
img { border: 0; }
a { TEXT-DECORATION: none;}
</style>
</head>
<body>
<div id="Wrap">
	<div class="Wrap_in">
		<div class="top_logo">
			<img src="/resources/images/common/top_logo_s.jpg" style="display: inline;">
		</div><!--//top_logo-->
		<c:if test="${result == 1}">
		<div class="meNual_visual">
			<p class="meNual" id="success" style="margin-bottom: 20px;">감사합니다. </p>
			<p class="one_Chance" id="success_message" style="margin-bottom: 40px;">등록이 완료되었습니다.</p>
			<div class="send_Btn">
				<button id="hompage">홈페이지 방문하기</button>
			</div>
		</div><!--//menual_visual-->
		</c:if>
		
		<c:if test="${result == 0 || result == -1}">
		<div class="meNual_visual">
			<p class="meNual" id="fail" style="margin-bottom: 20px;">오류발생!</p>
			<p class="one_Chance" id="fail_message" style="margin-bottom: 40px;" >잘못된 경로로 접근하였습니다.</p>
			<div class="send_Btn" id="hompage">
				<button>홈페이지 방문하기</button>
			</div>
		</div><!--//menual_visual-->
		</c:if>
	<p class="Copyright">Copyright © KHIEI</p>
	</div><!--//Wrap_in-->
</div><!--//Wrap-->
<script>
(function(){
	if('${result}' === "1"){
		alert('수강생 등록이 완료되었습니다.\n개강일 전까지 예습을 필수로 진행하시길 바랍니다.\n궁금한 사항은 담당 입학선생님에게 전화를 주시거나\n1544-9970으로 전화주시기 바랍니다.');
	}
	if('${result}' === "-1"){
		alert('수강생으로 등록이 되어있지 않습니다. 담당 입학선생님에게 전화를 주시거나, 1544-9970으로 전화주시기 바랍니다.');
	}
	if('${result}' === "0"){
		alert('수강생 등록에 실패하였습니다.');
	}
})();

document.getElementById('hompage').addEventListener('click',function(){
	window.location.href = '${pageContext.request.contextPath}/main/main.kh';
})
</script>
</body>
</html>