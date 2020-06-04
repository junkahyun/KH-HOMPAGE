<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="/WEB-INF/tlds/c.tld" %> 
<%@ taglib prefix="fn" 		uri="/WEB-INF/tlds/fn.tld" %>
<%@ page import="com.kh.common.LoginConstants"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>With KH</title>
<jsp:include page="/WEB-INF/jsp/app/common/meta.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/app/css/login.css?${currentDate}" />
<script type="text/javascript" charset="utf-8" src="/app/js/SHA256.js"></script>
<style>
input:focus::-webkit-input-placeholder,
textarea:focus::-webkit-input-placeholder { /* WebKit browsers */
  color:transparent;
}
 
input:focus:-moz-placeholder,
textarea:focus:-moz-placeholder { /* Mozilla Firefox 4 to 18 */
  color:transparent;
}
 
input:focus::-moz-placeholder,
textarea:focus::-moz-placeholder { /* Mozilla Firefox 19+ */
  color:transparent;
}
 
input:focus:-ms-input-placeholder,
textarea:focus:-ms-input-placeholder { /* Internet Explorer 10+ */
  color:transparent;
}
.login_wrapper{height:100%}
.login_wrapper_in{height:100%}
.login_input_id{border:1px solid #e6e9ec; width:85%; margin:0 auto;background:url(/app/images/join/bar.jpg) no-repeat; background-position-x:center; background-position-y:center; margin-top:4%;}
.login_input_id input{border:none; width:30%; margin:3%;}
.footer{width:100%;background:#0c0451;padding:8% 0; text-align:center; } 
.footer p{color:#fff;} 
.footer:hover{background:#c8ceda;}
</style>
</head>
<body>
<!-- <div class="login_wrapper">
<div class="login_wrapper_in">
	<div class="sub_top sub_box">
		<h1 class="title">수강생등록</h1>
	</div>
		<div class="login_visual">
			감사합니다<br>등록이 완료되었습니다.
		</div>
	<div class="footer" id="hompage">
		<p class="send_btn">홈페이지 방문하기</p>
	</div>
	</div>//login_wrapper_in
</div>//login_wrapper -->
</body>
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
	window.location.href = '${pageContext.request.contextPath}/mobile2017/main.kh';
})();

/* document.getElementById('hompage').addEventListener('click',function(){
	window.location.href = 'https://www.iei.or.kr/mobile2017/main.kh';
}) */
</script>
</body>
</html>