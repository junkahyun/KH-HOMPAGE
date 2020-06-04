<%@ page import="com.kh.utils.Utils"%>
<%@ page import="java.util.HashMap" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="/WEB-INF/tlds/c.tld" %> 
<%@ taglib prefix="fn" 		uri="/WEB-INF/tlds/fn.tld" %>
<%@ taglib prefix="fmt"		uri="/WEB-INF/tlds/fmt.tld" %>
<%@ taglib prefix="utils"	uri="/WEB-INF/tlds/utils.tld" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>With KH</title>
<jsp:include page="/WEB-INF/jsp/app/common/meta.jsp"/>
<script src="${pageContext.request.contextPath}/resources/js/signature/signature_pad.js?202002190000"></script>
<style>
	.sub_content{background:#fff;}
	.popup_layer { display:none; position:fixed; _position:absolute; top:0; left:0; width:100%; height:100%; z-index:10000;}
	.popup_layer .popup_layer_bg {position:absolute; top:0; left:0; width:100%; height:100%; background:#000; opacity:.5; filter:alpha(opacity=50);}
	.popup_layer .popup_layer_cont { position:absolute; left:25%; top:25%; background:#fff; width: 92%;}
	.next_page{width:100%; background:#0c0451; padding:5% 0; text-align:center;}
	/* .next_page{background:#c8ceda; } */
	.next_page p{color:#fff;}
    .check_01 a{cursor:pointer;}
    .check_01 .hide{display:none;}
	.agree_Box h2{color:#9797a7; line-height:120%;font-weight:400; text-align:center; margin:0 auto; margin-top:5%;}
	.agree_Box ul li.check_01{margin:0 auto; border:1px solid #e6e9ec; position:relative;}
	.agree_Box ul li.scroll_need{/* height:300px; */ overflow-y:scroll;overflow-x:hidden;}
	.check_01 ul.hide{width:100%; margin-top:3%; /*border-top:1px solid #e6e9ec;*/}
	.sub_content_title{padding:5% 5% 0 5%; border:0;}
	.m-signature-pad {width: auto;margin:5%;}
	.m-signature-pad-bodycanvas { left: 0;top: 0;width: 100%;height: 100%;border-radius: 4px;}
	.Sign{text-align:center; color:#9797a7;line-height:120%;}
	#signature_pad{width:100%;height:100%;} 
	.reset_click{text-align:center; width:100%;}
	.next_page{margin-top:5%;}
	.reset_click img{margin-right:1%;}
</style>
</head>
<body>
	<div class="popup_layer" id="loading">
		<div class="popup_layer_bg"></div>
		<div class="popup_layer_cont" style="background: none; height: 155px; width: 180px;">
			<img src="${pageContext.request.contextPath}/resources/images/sub06/sub06_loading.gif" alt="now loading....">
		</div>
	</div>
	<div class="sub_wrapper">
		<div class="modify_wrapper">
			<div class="sub_top sub_box">
				<div class="back_btn" onClick="javascript:location.href='${pageContext.request.contextPath}/app/joinMemberStepOne.mkh'">
					<img src="${pageContext.request.contextPath}/app/images/sub/sub_back_btn.png" alt="뒤로가기버튼" />
				</div>
				<h1 class="sub_title">회원가입</h1>
			</div><!-- //sub_top -->
			<div class="sub_content">
				<div class="sub_content_title">
					<h2>아래의 내용에 동의해주세요.</h2>
					<p>KH정보교육원 회원가입을 위해 개인정보 수집·이용 및<br>내부규정에 대한 동의가 필요합니다.</p>
				</div>
				<!--<div class="sub_modifybox sub_box">
				</div><!-- //sub_modifybox -->	
				<div class="agree_Box">
					<ul>
						<li class="check_01" id="check_01" onclick="openPDF('check_01_img',3);">
							<p>개인정보 수집 · 이용 및 제공에 관한 동의서</p>
							<a><img src="${pageContext.request.contextPath}/app/images/join/check_off.png" alt="on_off" id="check_01_img" name="check" class="check off"></a>
						</li>
						<li class="check_01" style="border-top:0;" id="check_02" onclick="openPDF('check_02_img',4);">
							<p>개별 구직활동 제한 동의서</p>
							<a><img src="${pageContext.request.contextPath}/app/images/join/check_off.png" alt="on_off" id="check_02_img" name="check" class="check off"></a>
						</li>
						<li class="check_01" style="border-top:0;" id="check_03" onclick="openPDF('check_03_img',5);">
							<p>온라인 동영상 유출 금지 서약서</p>
							<a><img src="${pageContext.request.contextPath}/app/images/join/check_off.png" alt="on_off" id="check_03_img" name="check" class="check off"></a>
						</li>
						<li class="check_01" style="border-top:0;" id="check_04" onclick="openPDF('check_04_img',6);">
							<p>불법 소프트웨어 복제 및 사용 금지에 관한 동의서</p>
							<a><img src="${pageContext.request.contextPath}/app/images/join/check_off.png" alt="on_off" id="check_04_img" name="check" class="check off"></a>
						</li>
						<li class="check_01" style="border-top:0;" id="check_05" onclick="openPDF('check_05_img',7);">
							<p>훈련생 출결 및 제적규정</p>
							<a><img src="${pageContext.request.contextPath}/app/images/join/check_off.png" alt="on_off" id="check_05_img" name="check" class="check off"></a>
						</li>
					</ul>
				 <h2>본인은 KH정보교육원의 상기 동의서 및 <br>서약서 내용에 동의하여 서명합니다. (필수)</h2>
				</div><!--//agree_Box-->
				<div id="signature-pad" class="m-signature-pad" style="background:#fafbfc">
				<div class="m-signature-pad-body">
					<p class="Sign">위 내용에 동의하시면<br>화면에 서명해 주세요</p>
					 <canvas id="signature_pad"></canvas>
					</div>
				</div>
				<div class="reset_click">
					<img src="${pageContext.request.contextPath}/app/images/join/reset_btn.png" class="reset_btn">
					<span id="signature_clear">서명초기화</span>
				</div>
				<div class="next_page" id="nextBtn">
					<p>모두 동의하고 계속 진행</p>
				</div>
			</div><!-- //sub_content -->
		</div><!-- //modify_wrapper -->
		<form action="${pageContext.request.contextPath}/app/joinMemberStepThree.mkh" name="frm" method="post">
			<input type="hidden" name="khinfoResult" value="${params.khinfoResult}">	
			<input type="hidden" id="user_signature" name="user_signature"/>
			<input type="hidden" name="member_flag" value="${params.member_flag}"/>
			<input type="hidden" name="stdtName" value="${params.stdtName}"/>
			<input type="hidden" name="stdtMobile" value="${params.stdtMobile}"/>
		</form>
	</div><!-- //sub_wrapper -->
	<jsp:include page="/WEB-INF/jsp/app/main/menu.jsp" />
</body>
<script>
const signature_pad = document.getElementById('signature_pad');
const nextBtn = document.getElementById('nextBtn');

(function(){
    resizeCanvas();
})();

/*
 * 서명 패드 사이즈 자동 조절하는 함수
 */
function resizeCanvas() {
    var ratio =  Math.max(window.devicePixelRatio || 1, 1);
    signature_pad.width = signature_pad.offsetWidth * ratio;
    signature_pad.height = (signature_pad.offsetWidth * ratio)/2;
    signature_pad.getContext("2d").scale(ratio, ratio);
}

var signaturePad = new SignaturePad(signature_pad, {
	//backgroundColor: 'rgb(250, 251, 252)' // PNG,SVG로 저장시에만 배경색이 사라집니다. JPEG로 저장할시에 배경색이 필요합니다.
});

/*
 * 서명 초기화 버튼 click시 발생하는 이벤트
 */
document.getElementById('signature_clear').addEventListener('click', function () {
   signaturePad.clear();
});

/*
 * 체크표시 색상 변경하는 함수
 */
function changeColor(imgClassName,imgId,num){
	if(imgClassName === 'check off'){
		$('#'+imgId+'').attr('src','${pageContext.request.contextPath}/app/images/join/check_on.png');
		$('#'+imgId+'').attr('class','check on');
		window.open('${pageContext.request.contextPath}/app/clauseAgree.mkh?num='+num+'','_target','');
	}
	else if(imgClassName === 'check on'){
		$('#'+imgId+'').attr('src','${pageContext.request.contextPath}/app/images/join/check_off.png');
		$('#'+imgId+'').attr('class','check off');
	}
}

/*
 * 동의서 pdf 여는 함수
 */
function openPDF(img_name, index){
	let imgClassName = $('#'+img_name+'').attr('class');
	changeColor(imgClassName, img_name, index);
}

/*
 * '모두 동의하고 계속 진행'버튼 click시 발생하는 이벤트
 */
nextBtn.addEventListener('click', function () {
	fnValidate();
});

/*
 * 약관체크여부 & 서명작성 여부 유효성 검사하는 함수
 */
function fnValidate(){ 
	const nameCheckLeng = document.getElementsByName('check').length;
	const nameCheck = document.getElementsByName('check');
	for(var i=0; i<nameCheckLeng; i++){
		if(nameCheck[i].getAttribute('Class') !== 'check on'){
			return alert("약관동의를 체크해 주세요.");
		}
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
	document.frm.user_signature.value = data.split(',')[1];
	document.frm.submit();
}

</script>
</html>