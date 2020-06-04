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
<script src="${pageContext.request.contextPath}/resources/js/validate/validatePhoneNum.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/validate/validateValue.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/app/css/join.css?${currentDate}" />
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
#certifyNumber{color:black; left:0; margin-left:5%;}
h2{color:#9797a7; line-height:120%;font-weight:400; text-align:center; margin:0 auto; margin-top:5%;font-size: 0.85em;}
.agree_Box ul li.check_01{position:relative;width: 95.8%;}
.agree_Box ul li.check_01:first-child{border-bottom: 1px solid #e6e9ec;}
.agree_Box{width: 100%;}
.popup_layer {display:none;  position:fixed; _position:absolute; top:0; left:0; width:100%; height:100%; z-index:10000;}
.popup_layer .popup_layer_bg {position:absolute; top:0; left:0; width:100%; height:100%; background:#000; opacity:.5; filter:alpha(opacity=50);}
.popup_layer .popup_layer_cont {background:#fff; width: 92%;}
</style>

</head>
<body>
<div class="join_wrapper">
	<div class="join_wrapper_in">
		<div class="sub_top sub_box">
			<div class="back_btn" onClick="location.href='${pageContext.request.contextPath}/app/login.mkh'">
				<img src="${pageContext.request.contextPath}/app/images/sub/sub_back_btn.png" alt="뒤로가기버튼" style="position:absolute;top:0;left:0;"/>
			</div>
			<h1 class="title">회원가입</h1>
		</div><!-- //sub_top -->
			<div class="join_content">
				<div class="join_visual">
					<img src="${pageContext.request.contextPath}/app/images/join/join_bg.jpg" alt="회원가입페이지 이미지" />
				</div><!-- //login_visual -->
				<div class="visual_bg"></div>
				<div class="popup_layer" id="loading">
					<div class="popup_layer_bg"></div>
					<div class="popup_layer_cont" style="background: none; height: 155px; width: 180px;">
						<img src="${pageContext.request.contextPath}/resources/images/sub06/sub06_loading.gif" alt="now loading....">
					</div>
				</div>
				<div class="join_box">
					<input type="radio" id="member_flag_studnet" name="member" checked="checked" value="P" style="margin-left:6.7%;">
					<label for="member_flag_studnet">수강생(예비)</label>
					<!-- <input type="radio" id="member_flag_normal" name="member"  value="U">
					<label for="member_flag_normal">일반회원</label> -->	
				</div>
				<div class="studnet_on">
					<p style="color:#fa5c3f; text-align:center; line-height:120%;">본인인증을 위해 문의등록 시<br>사용한 이름과 연락처를 입력해 주세요.</p>
				</div>
				<div id="joinshow_member" class="joinshow_member">
					<input type="text" id="name" placeholder="이름" class="spacing">
					<input type="tel" id="mobile" placeholder="휴대폰" maxlength="13" class="spacing" style="border-top:1px solid #e6e9ec; position:relative;">
					<button id="Identity_verification_member">본인인증</button>
					<div class="send_sms" style="display: none;">
						<input type="text" id="certifyNumber" class="time" style="width: 94%;padding: unset;"/>
						<span class="time" id="availableTime"></span> 
						<button id="check_member">확인</button>
					</div>
				</div><!-- //joinshow_member-->
				<div id="joinshow_normal" class="joinshow_normal">
					<div class="agree_Box">
						<ul>
							<li class="check_01" id="check_01" onclick="openPDF('check_01_img',1);">
								<p>KH정보교육원 이용약관</p>
								<a><img src="${pageContext.request.contextPath}/app/images/join/check_off.png" alt="on_off" id="check_01_img" name="check" class="check off"></a>
							</li>
							<li class="check_01" style="border-top:0;" id="check_02" onclick="openPDF('check_02_img',2);">
								<p>개인정보 보호정책</p>
								<a><img src="${pageContext.request.contextPath}/app/images/join/check_off.png" alt="on_off" id="check_02_img" name="check" class="check off"></a>
							</li>
						</ul>
					</div><!--//agree_Box-->
				</div>
				<h2 class="joinshow_normal">본인은 위 이용약관 및 개인정보 취급방침에 동의합니다.</h2>
				<div class="next_page" id="nextDiv"><p>다음</p></div>
			</div><!-- //join_content -->
		</div><!-- //join_wrapper_in-->
	</div><!-- //join_wrapper -->
	<form action="${pageContext.request.contextPath}/app/joinMemberStepTwo.mkh" method="post" name="frm">
		<input type="hidden" name="member_flag" id="member_flag"/>
		<input type="hidden" name="stdtName">
		<input type="hidden" name="stdtMobile">
		<input type="hidden" name="khinfoResult" id="khinfoResult">
	</form>
</body>


<script>
let mobile = document.getElementById('mobile');
let identity_member = document.getElementById('Identity_verification_member');
let nextDiv = document.getElementById('nextDiv');
let check_member = document.getElementById('check_member');
let isStdt = 1;
let buttonCheck = false; 
let confirmCheck = false; 

(function(){
	$('.joinshow_normal').attr('style','display:none;');
	fnRadioClick();
})();

/*
 * 회원구분 radio버튼 클릭시 보여지는 항목 세팅하는 함수
 */
function fnRadioClick(){
	const member_normal = document.getElementById('member_flag_normal');
	const member_studnet = document.getElementById('member_flag_studnet');
	
	$('#member_flag_normal').on('click',function(){
		isStdt = 0;
		$('.studnet_on').attr('style','display:none;');
		$('.joinshow_member').attr('style','display:none;');
		$('.joinshow_normal').attr('style','display:block;');
	});
	$('#member_flag_studnet').on('click',function(){
		isStdt = 1;
		$('.studnet_on').attr('style','display:block;');
		$('.joinshow_member').attr('style','display:block;');
		$('.joinshow_normal').attr('style','display:none;');
	});
		
}
/*
 * 일반회원 약관동의서 체크 부분 주석처리
 */
/*
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
}*/

/* function openPDF(img_name, index){
	let imgClassName = $('#'+img_name+'').attr('class');
	changeColor(imgClassName, img_name, index);
} */

/*
 * 전화번호 입력 시 자동으로 - 붙혀주는 keydown 이벤트
 */
mobile.addEventListener('keydown',function(event){
	var code = event.keyCode;
	if (code == 8 || code == 46) {
		return false;
	}		

	var value = $("#mobile").val();
	if (value.length == 3) {
		$("#mobile").val(value + "-");
	}
	if (value.length == 8) {
		$("#mobile").val(value + "-");
	}
});

/*
 * 본인인증 버튼 click시 발생하는 이벤트
 */
identity_member.addEventListener('click',function(){
	if(is_Empty($('#name').val()) === false){
		alert('빈칸을 입력해주세요.');
		return false;
	}
	if(is_Empty($('#mobile').val()) === false){
		alert('빈칸을 입력해주세요.');
		return false;
	}
	sendValidNumber();
});

/*
 * 다음 버튼 click시 발생하는 이벤트
 */
nextDiv.addEventListener('click',function(){
	//예비 수강생인 경우
	if($('input[name=member]:checked').val() === 'P'){
		if(fnValidation() === true){
			document.frm.stdtName.value = document.getElementById('name').value;
			document.frm.stdtMobile.value = document.getElementById('mobile').value;
			fnSubmit();
		}
		return;
	}
	//일반회원인 경우
	else{
		if(fnValidation() === true){
			fnSubmit();
		}
		return;
	}
});

function setValue(result){
	document.getElementById("khinfoResult").value = result;
}

/*
 * 수강생 회원가입 가능 여부 체크하는 함수
 */
function sendValidNumber(){
	
	let formData = {'stdtName':$('#name').val(),'stdtMobile':$('#mobile').val(), 'member_flag':'P'};							
	
	$.ajax({
		url:'${pageContext.request.contextPath}/login/getQuestNo.kh',
		dataType: 'json',
		type:'post',
		data:formData,
		beforeSend	: function(){$("#loading").show();}})
		.success(function(data,textStatus){
			$('#loading').hide();
			let params = data['params'];
			const param_result = params.result;
			
			if(param_result.indexOf(":") !== -1){
				if(confirm('입력하신 이름과 휴대폰번호로 회원가입이 되어있습니다. \n기존아이디를 사용하여 새롭게 회원가입을 진행하시겠습니까? \n※이전 수강정보는 사라집니다.') === true){
					setValue(param_result);
					alert('인증번호를 전송하였습니다');
					$('.send_sms').show('fast');
		      		$('#Identity_verification_member').hide(); 
		      		showValidTime('availableTime', 'certifyNumber', 'check_member', 'Identity_verification_member');
					sendValidateNumber();
				}
				else{
					alert('로그인 화면으로 이동합니다.');
					window.location.href = '${pageContext.request.contextPath}/app/login.mkh';
				}
				return;
			}
			else if(param_result === "-1"){
				alert('입력하신 이름과 휴대폰번호로 이미 수강생등록이 되어있습니다. \n로그인 해주시기 바랍니다.');
				window.location.href = '${pageContext.request.contextPath}/app/login.mkh';
				return;
			}
			else if(param_result === "0"){
				alert('지금은 "수강생(예비)"으로 가입하실수 없습니다. \n\n입학상담선생님의 확인이 필요합니다. \n담당 선생님께 확인 후 회원가입 진행부탁드립니다. \n(대표번호 : 1544-9970)');
				$('#name').val('').focus();
				$('#mobile').val('');
				return;
			}
			else if(param_result === "1" || "2"){
				setValue(param_result);
				alert('인증번호를 전송하였습니다');
				$('.send_sms').show('fast');
	      		$('#Identity_verification_member').hide(); 
	      		showValidTime('availableTime', 'certifyNumber', 'check_member', 'Identity_verification_member');
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
	let smsReceiver = "";
	
	smsReceiver = "[";
	smsReceiver += "{"; 
	smsReceiver += "\"category\":\"기타\", ";
	smsReceiver += "\"recv_name\":\"" + $('#name').val() + "\", \"mobile\":\"" + $('#mobile').val() + "\"";
	smsReceiver += "}";
    smsReceiver += "]";
	
	form_data = {'mode':'insert',
		         'category':'기타',
		         'mobile':'15449970',
		         'title':'KH 휴대폰 인증번호입니다.',
		         'smsReceiver':smsReceiver};
	$.ajax({
		url:'${pageContext.request.contextPath}/login/sendPwdMsg.kh',
		dataType: 'json',
		type:'post',
		data:form_data,
		success:function(data,textStatus){
			if(data.checknum !== undefined){
				buttonCheck = true;
			}
			else{
				alert('인증번호 전송에 실패하였습니다. 정보를 다시 입력해주세요.');
				document.getElementById('name').value = "";
				document.getElementById('mobile').value = "";
			} 
		}
		,error:function (jqXHR, textStatus, errorThrown) {
			alert('오류가 발생했습니다\n[' + textStatus + ']\n' + errorThrown);
		}
	});
}

/*
 * 본인인증 버튼 click시 발생하는 이벤트
 */
check_member.addEventListener('click',function(){
	$.ajax({
		url:'${pageContext.request.contextPath}/login/checkPwdMsg.kh',
		dataType: 'json',
		type:'post',
		data:{realNum : $('#certifyNumber').val()}})
		.success(function(data,textStatus){
			if(data.result === '1'){
				confirmCheck = true;
				alert('인증이 완료되었습니다.');
				clearInterval(timeReversal);
				$('#check_member').hide();
				$('#availableTime').hide();
				$('#certifyNumber').attr('disabled',true);
			}
			else{
				alert(data.erro_message);
			}
		})
		.error(function (jqXHR, textStatus, errorThrown) {
			alert('오류가 발생했습니다\n[' + textStatus + ']\n' + errorThrown);
		}); 
});

/*
 * 전체 입력 값 유효성 검사하는 함수
 */
function fnValidation(){
	if(isStdt === 1){
		if(is_Empty($('#name').val()) === false){
			alert('빈칸을 입력해주세요.');
			return false;
		}
		if(is_Empty($('#mobile').val()) === false){
			alert('빈칸을 입력해주세요.');
			return false;
		}
		if(buttonCheck === false ){
			alert('본인인증을 진행해주세요.');
			return false;
		}
		if(confirmCheck === false){
			alert('본인인증을 완료해주세요.');
			return false;
		} 
	}
	if(isStdt === 0){
		const nameCheckLeng = document.getElementsByName('check').length;
		const nameCheck = document.getElementsByName('check');
		for(var i=0; i<nameCheckLeng; i++){
			if(nameCheck[i].getAttribute('Class') !== 'check on'){
				alert('약관동의를 체크해 주세요.');
				return false;
			}
		}
	}
	return true;
}

/*
 * 입력값 전송하는 함수
 */
function fnSubmit(){
	document.frm.member_flag.value = $('input[name=member]:checked').val();
	document.frm.submit();
}
</script>
</html>