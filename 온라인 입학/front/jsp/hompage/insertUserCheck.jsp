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
<script src="${pageContext.request.contextPath}/resources/js/validate/validatePhoneNum.js"></script>
<style>
.customStyleSelectBox{width: 20px;}
</style>
<script>
window.name ="Parent_window";
var idCheck = false;
// isStdt 0:flag가 일반회원 1:검사되지 않음 2:통과
let isStdt = 0; 
let bool = true;
jQuery(function(){
	fnOnMenu(7, 1);
	isStdt=1;
});

function fnFlagChange(){ // 회원구분 변경 시 변수 및 버튼 변경
	var flag = $('input[name=member_flag]:checked').val();
	
	if(flag === 'P'){
		isStdt=1;
		$('#join_table_member').attr('style','display:block;');
		$('#join_table_normal').attr('style','display:none;');
	} else if(flag === 'U'){
		isStdt=0;
		$('#join_table_normal').attr('style','display:block;');
		$('#join_table_member').attr('style','display:none;');
	}
}


function checkAgree(){ // 이용약관 동의여부 체크
	bool = $("#clause_agree").prop('checked');
	//$("#alert_clause_agree").css('display', (!bool) ? 'block' : 'none');
	return bool;
}

function fnValidate(){
	console.log(isStdt);
	/* 수강생인 경우 */
	if(isStdt === 1){
	    if($('#member_name').val() === ''/*  || $('#Identity_number').val() === '' */){
			alert('빈칸을 입력해주세요.');
			return;
		}  
		const length = document.getElementsByName('mobile').length;
		for(var i=0; i<length; i++){
			let mobileValue = document.getElementsByName('mobile')[i].value;
			if(mobileValue === ''){
				alert('빈칸을 입력해주세요.');
				return;
			}
		}
		if(buttonCheck === false){
			alert('본인인증을 진행해주세요.');
			return;
		}
		if(confirmCheck === false){
			alert('본인인증을 완료해주세요.');
			return;
		}  
		
	}
	if(isStdt === 0 && checkAgree() === false){
		alert('약관동의를 체크해주세요.');
		return;
	}
	fnUserFrm();
}

function fnUserFrm(){ // 일반회원 회원가입 진행
	document.vnoform.isStdt.value = isStdt;
	document.vnoform.stdtName.value = $('#member_name').val();
	document.vnoform.stdtMobile.value = $('#mobile0').val()+"-"+$('#mobile1').val()+"-"+$('#mobile2').val();
	document.vnoform.action = "${pageContext.request.contextPath}/login/insertUserFrm.kh";
	document.vnoform.submit();
}

/* function fnIpinPopup(){ // 아이핀 팝업 오픈
	if(checkAgree() === false){
		alert('약관동의를 체크해주세요.');
		return;
	}
	if ("${params.sEncData}".length < 5) {
		alert("아이핀 인증에 에러가 발생했습니다. 관리자에 문의하세요. 에러코드 : ${params.sEncData}");
		return;
	}
	window.open('', 'popupIPIN2', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
	document.form_ipin.target = "popupIPIN2";
	document.form_ipin.action = "https://cert.vno.co.kr/ipin.cb";
	document.form_ipin.submit();
} */
</script>
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
				<p class="login_title" style="padding:50px 0 0">
					<span>KH정보교육원을 찾아주셔서 감사합니다.</span>
					회사는 회원가입, 상담, 서비스 신청 등을 위해 아래와 같은 개인정보를 수집하고 있습니다.<br>
					회원가입을 원하실 경우 내용 확인 후 동의해 주시기 바랍니다.
				</p>
			</div>
				<div id="join_frm">
					<div class="bar"></div>
					<table class="join_table" cellpadding="0" cellspacing="0" style="margin: 20px 0 61px 0;">
						<tr>
							<th>회원 구분</th>
							<td>
								
								<input type="radio" id="member_flag_studnet" name="member_flag" value="P" onchange="fnFlagChange();" checked="checked">
								<label for="member_flag_studnet">수강생(예비)</label>&nbsp;&nbsp;
								<!-- <input type="radio" id="member_flag_normal" name="member_flag" value="U" onchange="fnFlagChange();">
								<label for="member_flag_normal">일반회원</label><br> -->
								<span class="join_hidden" id="alert_member_flag">회원구분을 확인하세요.</span>
							</td>
						</tr>
					</table>
					<div id="join_table_member">
					<table class="join_table" cellpadding="0" cellspacing="0">
						<div>
							<p class="check_Identity">본인인증을 위해 문의등록 시 사용한 이름과 연락처를 입력해 주세요.</p>
						</div>
						<tr>
							<th>이름</th>
							<td>
								<input type="text" id="member_name" style="width:235px;">
							</td>
						</tr>
						<tr>
							<th>휴대폰</th>
							<td>
								<select id="mobile0" name="mobile" style="width: 65px;">
								<option value="">선택</option>
								<option value="010">010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="016">017</option>
								<option value="016">018</option>
								<option value="016">019</option>
								</select>
								- <input type="text" id="mobile1" class="number" name="mobile" maxlength="4"> - <input type="text" id="mobile2" class="number" name="mobile" maxlength="4">
								<button class="click_Identity" id="certificateBtn">본인인증</button>
							</td>
						</tr>
						<tr>
							<th>인증번호</th>
							<td>
								<input type="text" id="Identity_number" class="Identity_number" style="float:left;">
								<span class="time" id="availableTime"></span>
								<button class="click_Identity" style="padding:5px 28px;" id="confirmBtn">확인</button>
							</td>
						</tr>
					</table>
				</div><!--//join_table_member-->
				<div id="join_table_normal" style="display: none;">
					<div id="join_clause">
					<jsp:include page="/WEB-INF/jsp/login/clauseAgreement.jsp" />
						<div class="agree_Identity">
							<input type="checkbox" checked="checked" id="clause_agree">
							<span>본인은 위 이용약관 및 개인정보취급방침에 동의합니다.</span>
							<!-- <span class="join_hidden" id="alert_clause_agree" style="display: none;">KH정보교육원 정보보호정책에 동의가 필요합니다.</span> -->
						</div>
					</div><!--//join_table_normal-->
				</div>	
				<div class="join_ok">
					<a onclick="fnValidate();">회원가입 진행하기</a>
					<!-- <a style="display:none;" onclick="fnIpinPopup();">아이핀 인증하기</a> -->
				</div>
				</div>
			</div>
		</div>
		<jsp:include page="/WEB-INF/jsp/common/right.jsp"/>
	</div>
	<form name="form_ipin" method="post">
		<input type="hidden" name="m" value="pubmain"><!-- 필수 데이타로, 누락하시면 안됩니다. -->
	    <input type="hidden" name="enc_data" value="${params.sEncData}"><!-- 위에서 업체정보를 암호화 한 데이타입니다. -->
	    <input type="hidden" name="url" value="/login/insertUserFrm.kh">
	</form>
	
	<!-- 가상주민번호 서비스 팝업 페이지에서 사용자가 인증을 받으면 암호화된 사용자 정보는 해당 팝업창으로 받게됩니다.
		 따라서 부모 페이지로 이동하기 위해서는 다음과 같은 form이 필요합니다. -->
	<form name="vnoform" method="post">
		<input type="hidden" name="enc_data"><!-- 인증받은 사용자 정보 암호화 데이타입니다. -->
		<input type="hidden" name="isStdt"><!-- 인증받은 사용자 정보 암호화 데이타입니다. -->
		<input type="hidden" name="stdtName">
		<input type="hidden" name="stdtMobile">
		<input type="hidden" name="khinfoResult" id="khinfoResult">
	</form>
</div>
<jsp:include page="/WEB-INF/jsp/common/bottom.jsp"/>
</body>
<script>
var smsReceiver; 
var form_data; 
var buttonCheck = false; 
var confirmCheck = false;

/*
 * 본인인증 버튼 click시 발생하는 이벤트
 */
document.getElementById('certificateBtn').addEventListener('click', function (){
	checkInputValue();
}); 

/** 
 * 입력한 값 빈칸여부 체크하는 함수
 */
function checkInputValue(){
	const userName = document.getElementById('member_name').value;
	const length = document.getElementsByName('mobile').length;
	let userMobile = '';
	
	if(userName === ''){
		alert('빈칸을 입력해주세요.');
		return;
	}
	for(var i=0; i<length; i++){
		let mobileValue = document.getElementsByName('mobile')[i].value;
		if(mobileValue === ''){
			alert('빈칸을 입력해주세요.');
			return;
		}
		else{//번호에 - 붙힘
			if(i === 2){
				userMobile += mobileValue;	
			}
			else{
				userMobile += mobileValue+'-';
			}
		}
	} 
	sendValidNumber(userName,userMobile);
}

function setValue(result){
	document.getElementById("khinfoResult").value = result;
}

/**
 * 입력한 input칸 초기화하는 함수
 */
function resetOption(){
	$('#member_name').val('').focus();
	$('#mobile0').val('').attr('selected','selected');
	$("#span_mobile0").html($("#mobile0 option:selected").html()).parent().addClass('changed');
	$('#mobile1').val('');
	$('#mobile2').val('');
}

/*
 * 수강생 회원가입 가능 여부 체크하는 함수
 */
function sendValidNumber(userName,userMobile){
	let formData = {
			"stdtName"    : userName,
			"stdtMobile"  : userMobile, 
			"member_flag" : "P"
	};							
	
	$.ajax({
		url:'${pageContext.request.contextPath}/login/getQuestNo.kh',
		dataType: 'json',
		type:'post',
		data:formData})
		.success(function(data,textStatus){
			let params = data['params'];
			const param_result = params.result;
			
			/* 회원가입이 되어있는 경우 */
			if(param_result.indexOf(":") !== -1){
				//재가입을 진행하는 경우
				if(confirm('입력하신 이름과 휴대폰번호로 회원가입이 되어있습니다. \n기존아이디를 사용하여 새롭게 회원가입을 진행하시겠습니까? \n※이전 수강정보는 사라집니다.') === true){
					setValue(param_result);
					
					//인증번호 전송
					sendValidateNumber();
				}
				//재가입을 진행하지 않는 경우
				else{
					alert('로그인 화면으로 이동합니다.');
					window.location.href = '${pageContext.request.contextPath}/login/login.kh';
				}
			}
			/* 수료생이 회원가입을 시도하는 경우 */
			else if(param_result === "-1"){
				alert('입력하신 이름과 휴대폰번호로 이미 수강생등록이 되어있습니다. \n로그인 해주시기 바랍니다.');
				window.location.href = '${pageContext.request.contextPath}/login/login.kh';
			}
			/* 일반인이 회원가입을 시도하는 경우 */
			else if(param_result === "0"){
				alert('지금은 "수강생(예비)"으로 가입하실수 없습니다. \n\n입학상담선생님의 확인이 필요합니다. \n담당 선생님께 확인 후 회원가입 진행부탁드립니다. \n(대표번호 : 1544-9970)');
				
				//입력값 초기화
				resetOption();
				return;
			}
			/* 회원가입을 처음 하는 경우 */
			else if(param_result === "1" || "2"){
				setValue(param_result);
				$('#certificateBtn').css('cursor','progress');
				
				//인증번호 전송
				sendValidateNumber();
			}
		})
		.error(function (jqXHR, textStatus, errorThrown){
			alert('오류가 발생했습니다\n[' + textStatus + ']\n' + errorThrown);
		});
}

/*
 * 인증번호 전송하는 함수
 */
function sendValidateNumber(){
	let mobile = $('#mobile0').val()+"-"+$('#mobile1').val()+"-"+$('#mobile2').val();
	
	smsReceiver = "[";
	smsReceiver += "{"; 
	smsReceiver += "\"category\":\"기타\", ";
	smsReceiver += "\"recv_name\":\"" + $('#member_name').val() + "\", \"mobile\":\"" + mobile + "\"";
	smsReceiver += "}";
    smsReceiver += "]";
	
	form_data = {"mode":"insert",
		         "category":"기타",
		         "mobile":"15449970",
		         "title":"KH 휴대폰 인증번호입니다.",
		         "smsReceiver":smsReceiver};
	$.ajax({
		url:'${pageContext.request.contextPath}/login/sendPwdMsg.kh',
		dataType: 'json',
		type:'post',
		data:form_data,
		success:function(data,textStatus){
			$('#certificateBtn').css('cursor','pointer');
			if(data.checknum === undefined){
				alert('인증번호 전송에 실패하였습니다. 정보를 다시 입력해주세요.');
				$('#mobile0').val('').attr('selected','selected');
				$("#span_mobile0").html($("#mobile0 option:selected").html()).parent().addClass('changed');
				document.getElementById('member_name').value = "";
				const length = document.getElementsByName('mobile').length;
				for(var i=0; i<length; i++){
					document.getElementsByName('mobile')[i].value = "";
				}
			}
			else{
				alert('인증번호를 전송하였습니다');
				buttonCheck = true;
	      		showValidTime('availableTime', '', '', 'certificateBtn');
			}
			
		}
		,error:function (jqXHR, textStatus, errorThrown) {
			alert('오류가 발생했습니다\n[' + textStatus + ']\n' + errorThrown);
		}
	});
}

/*
 * 인증번호 확인 버튼 click시 발생하는 이벤트
    입력한 값과 문자로 전송된 값이 일치하는 지 체크
 */
document.getElementById('confirmBtn').addEventListener('click', function (){
	if($('#Identity_number').val() !== ''){
		$.ajax({
			url:'${pageContext.request.contextPath}/login/checkPwdMsg.kh',
			dataType: 'json',
			type:'post',
			data:{realNum : $('#Identity_number').val()}})
			.success(function(data,textStatus){
				if(data.result === "1"){
					confirmCheck = true;
					alert('인증이 완료되었습니다.');
					clearInterval(timeReversal);
					$("#Identity_number").prop('disabled',true).val('인증이 완료되었습니다.');
					$("#availableTime").empty();
					$("#confirmBtn").hide();
				}
				else{
					alert(data.erro_message);
				}
			})
			.error(function (jqXHR, textStatus, errorThrown) {
				alert('오류가 발생했습니다\n[' + textStatus + ']\n' + errorThrown);
			});
	}
	else{
		alert('인증번호를 입력해주세요.');
		return;
	}
}); 
</script>
</html>