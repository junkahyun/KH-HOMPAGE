<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="/WEB-INF/tlds/c.tld" %> 
<%@ taglib prefix="fn" 		uri="/WEB-INF/tlds/fn.tld" %>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>KH정보교육원 - 회원가입</title>
<jsp:include page="/WEB-INF/jsp/common/meta.jsp"/>
<script src="${pageContext.request.contextPath}/resources/js/signature/signature_pad.js"></script>
<script type="text/javascript">
window.name ="Parent_window";
var idCheck = false;
// isStdt 0:flag가 일반회원 1:검사되지 않음 2:통과
let isStdt = 0;
let bool = true;
var signature_pad = document.getElementById('signature_pad');

jQuery(function(){
	fnOnMenu(7, 1);
});

function checkAgree(){ // 이용약관 동의여부 체크
	bool = $("#clause_agree").prop('checked');
	//$("#alert_clause_agree").css('display', (!bool) ? 'block' : 'none');
	return bool;
}

/*
 * 약관체크여부 & 서명작성 여부 유효성 검사하는 함수
 */
function fnValidate(){
	if(checkAgree() === false){
		alert('약관동의를 체크해주세요.');
		return;
	}
	if (signaturePad.isEmpty()) {
	    return alert("서명을 완료해주세요.");
	}
	fnUserFrm();
}

/*
 * 작성된 값 전송하는 함수
 */
function fnUserFrm(){
	var data = signaturePad.toDataURL('image/png');
	document.getElementById('user_signature').value = data.split(',')[1];
	document.vnoform.action = "${pageContext.request.contextPath}/login/insertStdtCheckTest.kh";
	document.vnoform.submit();
}
</script>
<style>
#join_clause span{padding:20px 0 15px 0;}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/common/top.jsp"/>
<div id="content_sub" onmouseover="fnPrevDept();">
	<div id="content_sub_wrap">
		<jsp:include page="/WEB-INF/jsp/login/left.jsp"/>
		<div id="content_right">
			<div class="subject">
				<span>회원가입</span>
				<p><img src="${pageContext.request.contextPath}/resources/images/common/point_home.jpg"><img src="${pageContext.request.contextPath}/resources/images/common/point_depth.jpg">마이페이지<img src="${pageContext.request.contextPath}/resources/images/common/point_depth.jpg">회원가입</p>
			</div>
			<div class="content_visual" style="background: url('${pageContext.request.contextPath}/resources/images/sub07/sub07_01_img01.jpg'); background-repeat: no-repeat; background-position: bottom;">
				<p class="subject_comment">반갑습니다. KH정보교육원에 오신걸 환영합니다.</p>
				<p class="subject_subcomment">Membership</p>
			</div>
			<div id="login">
				<p class="login_title">
					<span>KH정보교육원을 찾아주셔서 감사합니다.</span>
					회사는 회원가입, 상담, 서비스 신청 등을 위해 아래와 같은 개인정보를 수집하고 있습니다.<br>
					회원가입을 원하실 경우 내용 확인 후 동의해 주시기 바랍니다.
				</p>
					<jsp:include page="/WEB-INF/jsp/login/stdtClauseAgreement.jsp" />
					<div class="agree_Identity">
						<input type="checkbox" checked="checked" id="clause_agree">
						<span>본인은 KH정보교육원의 상기 동의서 및 서약서 내용에 동의하여 서명합니다. (필수)</span>
						<!-- <span class="join_hidden" id="alert_clause_agree" style="display: none;">KH정보교육원 정보보호정책에 동의가 필요합니다.</span> -->
					</div>
				<div id="join_frm">
					<div class="bar" style="width:30px;"></div>
					<p class="login_title" style="padding:unset;">
						<span>전자서명</span>
					</p>
					<!-- 서명 테스트 부분 입니다. -->
					<div id="canvas_wrap">
					<canvas id="signature_pad" width="445" height="250" style="left: 0; border:1px solid #ececec; position:absolute; top:30px; left:176px;">
						<p class="">위 내용에 동의하시면<br>화면에 서명해 주세요</p>
					</canvas>
					<br>
					<button id="reset_signatrue" style="width: 72px;">
					<img src="${pageContext.request.contextPath}/resources/images/login/reset_btn.png" style="width:22px;"><br>서명초기화</button> 
					</div><!--canvas_wrap-->
					<!-- 가상주민번호 서비스 팝업 페이지에서 사용자가 인증을 받으면 암호화된 사용자 정보는 해당 팝업창으로 받게됩니다.
					 따라서 부모 페이지로 이동하기 위해서는 다음과 같은 form이 필요합니다. -->
					<form name="vnoform" method="post">
						<input type="hidden" name="enc_data">								
						<input type="hidden" name="isStdt" value="1">
						<input type="hidden" name="khinfoResult" value="${params.khinfoResult}">
						<input type="hidden" name="stdtName" value="${params.stdtName}">	
						<input type="hidden" name="stdtMobile" value="${params.stdtMobile}">									
						<input type="hidden" id="user_signature" name="user_signature"/>
					</form>
					<!------------ start script ------------>
					<script>
					var signature_pad = document.getElementById('signature_pad');
					    signature_pad.getContext("2d");
					
					var signaturePad = new SignaturePad(signature_pad, {
						  backgroundColor: 'rgb(255, 255, 255)' // PNG,SVG로 저장시에만 배경색이 사라집니다. JPEG로 저장할시에 배경색이 필요합니다.
					});
					
					document.getElementById('reset_signatrue').addEventListener('click', function () {
						   signaturePad.clear();
					});
					</script>
					<!------------ end script ------------>
					
					<div class="join_ok" style="margin-top:30px;">
						<a onClick="fnValidate();">회원가입 진행하기</a>
						<!-- 아이핀 인증 안보이게 수정됨 -->
						<a style="display:none;" onClick="return checkAgree()" href="javascript:fnIpinPopup();">아이핀 인증하기</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/jsp/common/right.jsp"/>
</div>
<jsp:include page="/WEB-INF/jsp/common/bottom.jsp"/>
</body>
</html>