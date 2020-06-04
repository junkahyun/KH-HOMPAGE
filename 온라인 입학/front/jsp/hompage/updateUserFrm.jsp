<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="/WEB-INF/tlds/c.tld" %> 
<%@ taglib prefix="fn" 		uri="/WEB-INF/tlds/fn.tld" %>
<%@ taglib prefix="fmt"		uri="/WEB-INF/tlds/fmt.tld" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>KH정보교육원 - 회원가입</title>
<jsp:include page="/WEB-INF/jsp/common/meta.jsp"/>
<script src="${pageContext.request.contextPath}/resources/js/joinMember/schoolAuto.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/joinMember/inputSetting.js"></script>


<style>
select{cursor:pointer;}
.emer_relation_layer{ display: none; float:right; position:relative; right:122px;}
#search_schoolname_list,#search_majorname_list {position: absolute;width: 226px;height: 300px;padding: 10px;overflow-y: scroll;display: none;background: #fff;z-index: 98;border: 1px solid #ececec;text-align: left;}
#findAddress, #licensePlus, #careerPlus {
	height: 25px;
	width: 75px;
	background: #283444;
	line-height: 25px;
	text-align: center;
	display: inline-block;
	color: #fff;
	font-size: 12px;
	border: none;
	cursor: pointer;
}
.removeBtn{
	height: 25px;
	width: 75px;
	background: #283444;
	line-height: 25px;
	text-align: center;
	display: inline-block;
	color: #fff;
	font-size: 12px;
	border: none;
	cursor: pointer;
}
</style>

<script type="text/javascript">
window.name ="Parent_window";
// isStdt 0:flag가 일반회원 1:검사되지 않음 2:통과
var isStdt = 0;
var member_flag = "${userinfo.member_flag}";
jQuery(function(){
	if(member_flag === 'T' || member_flag === 'P'){
		fnOnMenu(7, 5);	
		$('.onlyStdt').show();
		$('.onlyNormal').remove();
	}	
	if(member_flag !== 'T' && member_flag !== 'P'){
		fnOnMenu(7, 1);	
		$('.onlyNormal').show();
		$('.onlyStdt').remove();
	}
	
	$(":radio[value='${userinfo.member_flag}']").attr("checked", "checked");
	fnFlagChange();
	$("#email_select option[value='${fn:split(userinfo.email, '@')[1]}']").attr("selected", "selected");
	$("#email_select").change();
	$("#mobile1 option[value='${fn:split(userinfo.mobile, '-')[0]}']").attr("selected", "selected");
	$("#mobile1").change();
	fnChangeEmail();
	$("#email2").val("${fn:split(userinfo.email, '@')[1]}");
	
	$("#checkNum").hide();
	$("#checkPwdNum").hide();
	$("#time").hide();
	$("#boxcheck").hide();
	
	/* 학교검색 자동기능 */
	fnAutoSchoolSearch();

});



function fnAutoSchoolSearch(){
	$("#comaca1").autoSearch('${pageContext.request.contextPath}');
	$("#comaca3").autoSearch('${pageContext.request.contextPath}');
}

$('#emer_relation').on('change',function(event){
	if($('#emer_relation').val() === '기타'){
		$('.emer_relation_layer').show();
	}
	else{
		$('.emer_relation_layer').hide();
	}
	
});

function fnInsertUser() {
	var orgMobile = "${userinfo.mobile}";
	var spl = orgMobile.split("-");
	var orgMobilenum = spl.join("");
	
	var mobile1 = $("#mobile1").val();
	var mobile2 = $("#mobile2").val();
	var mobile3 = $("#mobile3").val();
	var chMobile = mobile1+mobile2+mobile3;
	
	/* if(!($("input[id=boxcheck]").is(":checked")) && orgMobilenum != chMobile ){
		alert("휴대폰 인증을 해주세요.");
		return;
	}
	if($("input[id=boxcheck]").is(":checked") && $("#checkNum").val() == ""){
		alert("인증번호를 입력해주세요.");
		return;
	} */
	if($("#password").val() == ""){
		alert("비밀번호를 입력해주세요.");
		$("#password").focus();
		return;
	}
	if (f_validate()) {
		if(confirm('정보를 수정 하시겠습니까?')){
			//var stdt_no = $("#stdt_no").val();
			//if(isStdt==0 || isStdt==1) stdt_no='';
			resettingPlus();
			var	params	= {
					password			: $('#password').val(),
					member_flag         : member_flag,
					mobile				: $('#mobile1').val() + '-' + $('#mobile2').val() + '-' + $('#mobile3').val() ,
					email				: $('#email1').val() +  '@' + $('#email2').val(),
					comaca              : $('#comaca1').val()+"_"+$('#comaca3').val()+"_"+$('#comaca4').val(),
					academic            : $('#academic').val(),
					graduation_date     : $('#graduation_date').val()+"."+$('#graduation_month').val(),
					address             : "_"+$('#city').val()+"_"+$('#address_etc').val(),
					emer_tel            : $('#emer_tel0').val()+'-'+$('#emer_tel1').val()+'-'+$('#emer_tel2').val(),
					emer_relation       : $('#emer_relation').val(),
					career			    : $('#career').val(),
					govercount			: $('#govercountPlus').val(),
					license			    : $('#license').val(),
					major_sub           : $('#major_sub').val(),
					homepage			: $('#homepage').val(),
					birth				: $('#birth').val(),
					stdt_birth          : $('#birth1').val()+'.'+$('#birth2').val()+'.'+$('#birth3').val(),
					groups				: $('#groups').val(),
					interest_field		: $('#interest_field').val(),
					stdt_no				: '${userinfo.stdt_no}'
			};
			
			$.ajax({
				url			: '${pageContext.request.contextPath}/login/updateUser.kh',		
				dataType	: 'json',
				type		: 'post',
				data		: params,
				success		: function (data, textStatus) {
					window.scrollTo(0,0);
					
					if (data['result'] == '0') {
						var html = "<div class='result'><p class=\"title\">개인정보 변경에 실패하였습니다. 잠시후에 다시 시도 하십시요.</p><a href=\"${pageContext.request.contextPath}/login/updateUserFrm.kh\">확인</a></div>";
						$("#login").html(html);
					}else {
						
						var html = "<div class='result'><p class=\"title\">개인정보 수정이 완료되었습니다.</p><a href=\"${pageContext.request.contextPath}/main/main.kh\">확인</a></div>";
					
						$("#login").html(html);
					}
				},
				error		: function (jqXHR, textStatus, errorThrown) {
					alert('오류가 발생했습니다\n[' + textStatus + ']\n' + errorThrown);
				}
			});
		}
	}
}

/**
 * 입력값 점검
 */
 function f_validate() {
	var n = 0;
	$(".join_hidden").hide();

	if($.trim($($('#password')).val()) != null && $.trim($($('#password')).val()) != ""){
		if($.trim($($('#password')).val()) == '') {
			$("#alert_password").css("display", "block");
			document.getElementById("password").focus();
			n=1;
		} else if($.trim($($('#password')).val()).length < 4){
			$("#alert_password_leng").css("display", "block");
			document.getElementById("id").focus();
			return;
		} else {
			if($.trim($($('#password')).val()) != $.trim($($('#password1')).val())) {
				$("#alert_passcheck").css("display", "block");
				document.getElementById("password").focus();
				n=1;
			}
		}
	}

	if($.trim($($('#mobile1')).val()) == '' || $.trim($($('#mobile2')).val()) == '' || $.trim($($('#mobile3')).val()) == '') {
		$("#alert_mobile_null").css("display", "block");
		n=1;
	} else {
		if(!isPhoneNumber($('#mobile2').val(), 3)){
			$("#alert_mobile_check").css("display", "block");
			document.getElementById("mobile2").focus();
			n=1;
		}
		if(!isPhoneNumber($('#mobile3').val(), 4)){
			$("#alert_mobile_check").css("display", "block");
			document.getElementById("mobile3").focus();
			n=1;
		}
	}
	
	if($.trim($($('#email1')).val()) == '' || $.trim($($('#email2')).val()) == '') {
		$("#alert_email_null").css("display", "block");
		document.getElementById("email1").focus();
		n=1;
	} else if(isID($.trim($($('#email1')).val()))) {
		$("#alert_email_check").css("display", "block");
		document.getElementById("email1").focus();
		n=1;
	} else if(email2Check($.trim($($('#email2')).val()))){
		$("#alert_email_check").css("display", "block");
		n=1;
	}
	
	if('${userinfo.member_flag}' === 'P' || '${userinfo.member_flag}' === 'T'){
		if($('#major_sub').val() === ''){
			$("#alert_major_sub_null").css("display", "block");
			n=1;
		}
		if($('#academic').val() === '' || $('#comaca1').val() === '' || $('#graduation_date').val() === '' || $('#comaca3').val() === ''){
			$("#alert_academic_null").css("display", "block");
			n=1;
		}
		if($('#city').val() === ''){
			$("#alert_address_null").css("display", "block");
			n=1;
		}
		
		if($.trim($($('#emer_tel0')).val()) == '' || $.trim($($('#emer_tel1')).val()) == '' || $.trim($($('#emer_tel2')).val()) == '') {
			$("#alert_emer_check").css("display", "block");
			n=1;
		} else {
			if(!isPhoneNumber($('#emer_tel1').val(), 3)){
				$("#alert_emer_check").css("display", "block");
				n=1;
			}
			if(!isPhoneNumber($('#emer_tel2').val(), 4)){
				$("#alert_emer_check").css("display", "block");
				n=1;
			}
		}	
	}
	
	if(n!=0) return false;
	
	return true;
}

function fnChangeEmail() {
	var email = $("#email_select option:selected").val();
	
	if(email==null || email==""){
		$("#email2").val("");
		$("#email2").removeAttr("readonly");
	} else {
		$("#email2").val(email);
		$("#email2").attr("readonly", "readonly");
	}
}
function fnFlagChange(){
	var flag = member_flag;
	
	if(flag === 'T' || flag === 'P'){
		fnSelectSetting();
		fnPlusSetting();
		$("#certificationCont").show(0);
		$("#stdt_info").show(0);
		$("#join_ok2").hide(0);
		$("#join_ok").show(0);
		isStdt=1;
	} else {
		$("#certificationCont").hide(0);
		$("#stdt_info").show(0);
		$("#join_ok2").show(0);
		$("#join_ok").hide(0);
		$(".join_ok").css('padding-bottom','50px'); 
		isStdt=0;
	}
}

/* select.js 기능에 대한 개선 필요  */
function fnSelectSetting(){
	const selectSetting = function (id,value){
		$("#"+id+" option[value='"+value+"']").attr("selected", "selected");
		$("#span_"+id+"").html($("#"+id+" option:selected").html()).parent().addClass('changed');
	};
	
	const comaca = '${userinfo.comaca}'.split('_')[2];
	const graduation = '${userinfo.graduation_date}'.split('.');
	const birth = '${userinfo.stdt_birth}'.split('.');
	
	if('${userinfo.govercount}' != null && '${userinfo.govercount}' != ''){
		const govercount = '${userinfo.govercount}'.split('|').length;
		selectSetting('govercount',govercount);
	}
	selectSetting('academic','${userinfo.academic}');
	selectSetting('emer_relation','${userinfo.emer_relation}');
	selectSetting('major_sub','${userinfo.major_sub}');
	selectSetting('graduation_date',graduation[0]);
	selectSetting('graduation_month',graduation[1]);
	selectSetting('comaca4',comaca);
	selectSetting('birth1',birth[0]);
	selectSetting('birth2',birth[1]);
	selectSetting('birth3',birth[2]);
} 
/* select.js기능 개선 필요 */

/* inputSetting.js 참고 */
function fnPlusSetting(){
	if('${userinfo.license}' !== null && '${userinfo.license}' !== ''){
		let license = '${userinfo.license}'.split('|');
		if(license.length > 0){
			for(var i=0; i<license.length; i++){
				inputSetting['license'](i,license[i]);
			}
		}
	}
	if('${userinfo.career}' !== null && '${userinfo.career}' !== ''){
		let career = '${userinfo.career}'.split('|');
		if(career.length > 0){
			for(var i=0; i<career.length; i++){
				inputSetting['career'](i,career[i]);
			}
		}
	}
	if('${userinfo.govercount}' !== null && '${userinfo.govercount}' !== ''){
		let govercount = '${userinfo.govercount}'.split('|');
		if(govercount.length > 0){
			for(var i=0; i<govercount.length; i++){
				inputSetting['govercount'](i,govercount[i]);
			}
		}
	}
}

function fnGovercount(){
	let goverCount = event.target.value;
	$('.addCurrName').remove();
	if(goverCount !== ''){
		for(var i=0; i<goverCount; i++){
			inputSetting['govercount'](i,'');
		} 
	}
}

let ic = 0;
let lc = 0;
function fnCareerPlus(){
	ic++;
	inputSetting['career'](ic,'');
}

function fnLicensePlus(){
	lc++;
	inputSetting['license'](lc,'');
}

function fnIpinPopup(){ // 아이핀 팝업 오픈
	if ("${params.sEncData}".length < 5) {
		alert("아이핀 인증에 에러가 발생했습니다. 관리자에 문의하세요. 에러코드 : ${params.sEncData}");
		return;
	}
	
	window.open('', 'popupIPIN2', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
	document.form_ipin.target = "popupIPIN2";
	document.form_ipin.action = "https://cert.vno.co.kr/ipin.cb";
	document.form_ipin.submit();
}

function fnCertification(){
	var params = {
		  enc_data		: $("#enc_data").val()
		, id			: '${userinfo.id}'
	};
	
	$.ajax({
		url			: '${pageContext.request.contextPath}/login/userCertification.kh',		
		dataType	: 'json',
		type		: 'post',
		data		: params,
		success		: function (data, textStatus) {
			if(data['result'] == '0') {
				alert('인증에 실패했습니다. 관리자에게 문의해주세요.');
			} else {
				alert('인증을 성공했습니다.');
				window.location.reload();
			}
		},
		error		: function (jqXHR, textStatus, errorThrown) {
			alert('오류가 발생했습니다\n[' + textStatus + ']\n' + errorThrown);
		}
	});
}

function fnpwdCheck(){
	var mobile1 = $("#mobile1").val();
	var mobile2 = $("#mobile2").val();
	var mobile3 = $("#mobile3").val();
	var mobile = mobile1+"-"+mobile2+"-"+mobile3;
	var name = $("#name").val();
	
	var RegMobile = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;

	if(!RegMobile.test(mobile)){
		alert("올바른 전화번호를 입력해주세요.");
		$("#mobile2").empty();
		$("#mobile3").empty();
		$("#mobile2").focus();
		return;
	}
	if(mobile2 == '' || mobile3 == ''){
		alert("빈칸을 작성해주세요.");
		$("#mobile2").focus();
		return;
	}
	else{
		mobile = mobile.replace(/-/gi, "");
		
		var smsReceiver = "[";
			smsReceiver += "{"; 
			smsReceiver += "\"category\":\"기타\", ";
			smsReceiver += "\"recv_name\":\"" + name + "\", \"mobile\":\"" + mobile + "\"";
			smsReceiver += "}";
		    smsReceiver += "]";
			
		var form_data = {"mode":"insert",
				         "category":"기타",
				         "mobile":"15449970",
				         "title":"KH 휴대폰 인증번호입니다.",
				         "smsReceiver":smsReceiver};
		
		$("#checkPwd").css("cursor","progress");
		$("#boxcheck").prop("checked",true);
		
		$.ajax({
			url:"${pageContext.request.contextPath}/login/sendPwdMsg.kh",
			data:form_data,
			type:"post",
			dataType:"json",
			success:function(data,textStatus){
				$("#checkPwd").css("cursor","");
				alert("휴대폰으로 인증번호를 전송하였습니다.");
				$("#checkPwd").hide();
				
				fnCheckNum();//암호 체크
				
				tid = setInterval("fnCountDownStart()",1000);
			},
			error:function(jqXHR, textStatus, errorThrown){
				alert("오류가 발생했습니다\n["+textStatus+"]\n"+errorThrown);
			}
		});
		
	}//end of if~else-------
}
	
var SetTime = 300;
function fnCountDownStart(){
	m = Math.floor(SetTime / 60) + "분 " + ((SetTime % 60) < 10? "0"+(SetTime % 60):(SetTime % 60))+"초";
	
	var msg = m;
	
	document.all.time.innerHTML = msg;// div 영역에 보여줌 
	$("#checkPwdNum").show();
	$("#checkNum").show();
	$("#time").show();
	$("#checkNum").focus();
	
	SetTime--;// 1초씩 감소
	
	if (SetTime < 0) {// 시간이 종료 되었으면..
		clearInterval(tid);// 타이머 해제
		alert("시간이 종료되었습니다.");
		$("#boxcheck").prop("checked",false);
		SetTime = 300;
		
		$("#checkNum").hide();
		$("#checkPwdNum").hide();
		$("#time").hide();
		$("#checkPwd").show();
		$("#checkPwd").css("cursor","pointer");
	}
}
/* window.onload = function TimerStart(){ tid=setInterval("fnCountDownStart()",1000) }; */

/*휴대폰 번호 확인하기*/
function fnCheckNum(){
	$("#checkPwdNum").click(function(){
		var form_data = {"realNum":$("#checkNum").val()};
		
		$.ajax({
			url:"${pageContext.request.contextPath}/login/checkPwdMsg.kh",
			type:"post",
			dataType:"json",
			data:form_data,
			success:function(json){
				if(json.result == 1){
					clearInterval(tid);// 타이머 해제
					$("#checkNum").remove();
					$("#checkPwdNum").remove();
					$("#time").remove();
					$("#alert_mobile").text("인증이 완료되었습니다.");
					return;
				}
				else if(json.result == 0){
					alert(json.erro_message);
					$("#checkNum").val("");
					return;
				}
			},
			error:function(jqXHR, textStatus, errorThrown){
				alert("오류가 발생했습니다\n["+textStatus+"]\n"+errorThrown);
			}
			
		});
	});
}

function fnFindAddress(){
	daum.postcode.load( function () {
		new daum.Postcode({
			oncomplete: function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
				// 예제를 참고하여 다양한 활용법을 확인해 보세요.
				const addressType = data.userSelectedType;

				if (addressType == 'R') {
					$("#city").val(data.roadAddress);
				} else if (addressType == 'J') {
					$("#city").val(data.jibunAddress);
				} else {
					alert("잘못된 타입입니다. 올바른 주소를 선택해주세요.");
				}
				$("#postcode").val(data.zonecode);
			}
		}).open();
	});
}



</script>

</head>
<body>
<div class="popup_layer" id="alert">
	<div class="popup_layer_bg"></div>
	<div class="popup_layer_cont">
		<div class="popup_head">
			<span>알림</span>
			<a href="javascript:fnLayerClose();">&nbsp;</a>
		</div>
		<div class="popup_cont">
			<p id="alert_ment"></p>
			<a href="javascript:fnLayerClose();" class="button">닫기</a>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/jsp/common/top.jsp"/>
<div id="content_sub" onmouseover="fnPrevDept();">
	<div id="content_sub_wrap">
		<jsp:include page="/WEB-INF/jsp/login/left.jsp"/>
		<div id="content_right">
			<div class="subject">
				<span>개인정보수정</span>
				<p><img src="${pageContext.request.contextPath}/resources/images/common/point_home.jpg"><img src="${pageContext.request.contextPath}/resources/images/common/point_depth.jpg">마이페이지<img src="${pageContext.request.contextPath}/resources/images/common/point_depth.jpg">개인정보수정</p>
			</div>
			<c:if test="${userinfo.member_flag != 'T'}">
				<div class="content_visual" style="background: url('${pageContext.request.contextPath}/resources/images/sub07/sub07_01_img01.jpg'); background-repeat: no-repeat; background-position: bottom;">
					<p class="subject_comment">반갑습니다. KH정보교육원에 오신걸 환영합니다.</p>
					<p class="subject_subcomment">My Page</p>
				</div>
				<div id="login" style="padding-bottom: 0px;">
				<p class="login_title">
					<span>KH정보교육원을 찾아주셔서 감사합니다.</span>
					회사는 회원가입, 상담, 서비스 신청 등을 위해 아래와 같은 개인정보를 수집하고 있습니다.<br>
					회원가입을 원하실 경우 내용 확인 후 동의해 주시기 바랍니다.
				</p>	
			</c:if>
			<c:if test="${userinfo.member_flag == 'T'}">
				<p class="subject_comment">반갑습니다. KH정보교육원에 오신걸 환영합니다.</p>
<!-- 					<p class="subject_subcomment">My Page</p> -->
			<div id="login" >
				<div class="login_title" style="padding:15px 0 0;">
				<ul>
					<li class="class">[${cData.branch} ${cData.classroom}]${cData.pass_currname}</li>
					<li class="classroom">${cData.begin_date} ~ ${cData.end_date} | ${cData.begin_time} ~ ${cData.end_time}</li>
					<li>${cData.prof} 강사님 | ${cData.e_charge} 취업담임</li>
				</ul>
				</div>
			</c:if>
				<div id="join_frm">
					<div class="bar"></div>
					<p class="join_title">기본정보(필수입력)</p>
					<table class="join_table" cellpadding="0" cellspacing="0">
						<tr>
							<th>회원 구분</th>
							<td>
								<%-- <input type="radio" id="member_flag_studnet" name="member_flag" value="T" onchange="fnFlagChange();">
								<label for="member_flag_studnet">수강생</label>&nbsp;&nbsp;
								<input type="radio" id="member_flag_normal" name="member_flag" value="U" onchange="fnFlagChange();">
								<label for="member_flag_normal">일반회원</label> --%>
								${(userinfo.member_flag == "T" or userinfo.member_flag == "P")?"수강생":"일반회원"}
							</td>
						</tr>
						<tr>
							<th>아이디</th>
							<td>
								<input type="text" id="id" name="id" disabled="disabled" value="${userinfo.id}">
							</td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td>
								<input type="password" id="password" name="password">
								<span class="join_hidden" id="alert_password">필수입력사항입니다.</span>
								<span class="join_hidden" id="alert_password_leng">비밀번호는 4자 이상이어야합니다.</span>
							</td>
						</tr>
						<tr>
							<th>비밀번호 확인</th>
							<td>
								<input type="password" id="password1">
								<span class="join_hidden" id="alert_passcheck">비밀번호가 일치하지 않습니다.</span>
							</td>
						</tr>
						<tr class="onlyStdt">
							<th>학생번호</th>
							<td><input type="text" id="stdtNo" name="stdtNo" value="${userinfo.stdt_no}" disabled="disabled"></td>
						</tr>
						<tr>
							<th>이름</th>
							<td><input type="text" id="name" name="name" onkeyup="fnStdtNoOk();" value="${userinfo.name}" readonly="readonly" disabled="disabled"><span class="join_hidden" id="alert_name">필수입력사항입니다.</span></td>
						</tr>
						<tr>
							<th>휴대폰</th>
							<td>
								<select style="width: 65px;" id="mobile1" name="mobile1">
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="019">019</option>
								</select>&nbsp; -&nbsp; 
								<input type="text" style="width: 73px; margin-right: 0;" id="mobile2" name="mobile2" maxlength="4" onkeypress="numeric();" value="${fn:split(userinfo.mobile, '-')[1]}"> -
								<input type="text" style="width: 73px;" id="mobile3" name="mobile3" maxlength="4" onkeypress="numeric();" value="${fn:split(userinfo.mobile, '-')[2]}">
								<a class="btn" style="cursor: pointer;" onclick="fnpwdCheck();" id="checkPwd">인증하기</a><input type="text" style="width: 10%;" maxlength="5" id="checkNum"/><span style="color: red; font-size: 10pt;" id="time"></span>&nbsp;&nbsp;<a class="btn" style="cursor: pointer;" id="checkPwdNum">확인</a>
								<input type="checkbox" id="boxcheck" />
								<span class="join_hidden" id="alert_mobile_null">필수입력사항입니다.</span>
								<span  id="alert_mobile" style="color: blue;"></span>
								<span class="join_hidden" id="alert_mobile_check">정확한 핸드폰 번호를 입력해주세요.</span>
							</td>
						</tr>
						<tr>
							<th>이메일 주소</th>
							<td>
								<input type="text" style="width: 180px; margin-right: 0;" id="email1" name="email1" value="${fn:split(userinfo.email, '@')[0]}"> @ 
								<input type="text" style="width: 180px;" id="email2" name="email2">
								<select style="width: 140px;" id="email_select" onchange="fnChangeEmail();">
									<option value="">직접입력</option>
									<option value="naver.com">naver.com</option>
									<option value="daum.net">daum.net</option>
									<option value="hanmail.net">hanmail.net</option>
									<option value="gmail.com">gmail.com</option>
								</select>
								<span class="join_hidden" id="alert_email_null">필수입력사항입니다.</span>
								<span class="join_hidden" id="alert_email_check">정확한 이메일 주소를 입력해주세요.</span>
							</td>
						</tr>
						<tr class="onlyStdt">
							<th>비상연락망</th>
							<td>
								<select style="width: 65px;" id="emer_tel0" name="emer_tel0">
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="019">019</option>
								</select> - 
								<input type="text" style="width: 73px; margin-right: 0;" id="emer_tel1" name="emer_tel1" maxlength="4" value="${fn:split(userinfo.emer_tel,'-')[1]}"> -
								<input type="text" style="width: 73px;" id="emer_tel2" name="emer_tel2" maxlength="4" value="${fn:split(userinfo.emer_tel,'-')[2]}">
								<select style="width: 65px;" id="emer_relation" name="emer_relation">
									<option value="부">부</option>
									<option value="모">모</option>
									<option value="자매">자매</option>
									<option value="형제">형제</option>
									<option value="기타">기타</option>
								</select>
								<div class="emer_relation_layer"><input type="text" id="relation_etc" style="border:1px solid #ececec;width:95px; height:25px; padding-left:10px; box-sizing:border-box;"/></div>
								<span class="join_hidden" id="alert_emer_null">필수입력사항입니다.</span>
								<span class="join_hidden" id="alert_emer_check">정확한 핸드폰 번호를 입력해주세요.</span>
							</td>
						</tr>
						<tr class="onlyStdt">
							<th>생년월일</th>
							<td>
								<c:set var="now" value="<%=new java.util.Date()%>" />
								<c:set var="year"><fmt:formatDate value="${now}" pattern="yyyy"/> </c:set>
								<select style="width: 65px;" id="birth1" name="stdtCheck">
									<c:forEach begin="0" end="100" var="i">
									<option value="${year-i}">${year-i}</option>
									</c:forEach>
								</select>
								<select style="width: 65px;" id="birth2" name="stdtCheck">
									<c:forEach begin="1" end="12" var="i">
									<c:if test="${i <= 9}"><option value="0${i}">0${i}</option></c:if>
									<c:if test="${i > 9}"><option value="${i}">${i}</option></c:if>
									</c:forEach>
								</select>
								<select style="width: 65px;" id="birth3" name="stdtCheck">
									<c:forEach begin="1" end="31" var="i">
									<c:if test="${i <= 9}"><option value="0${i}">0${i}</option></c:if>
									<c:if test="${i > 9}"><option value="${i}">${i}</option></c:if>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr class="onlyStdt">
							<th>주소</th>
							<td>
								<input type="text" id="city" value="${fn:split(userinfo.address,'_')[0]}"/><button type="button" id="findAddress" onclick="fnFindAddress();">주소검색</button><br>
								<input type="text" id="address_etc" value="${fn:split(userinfo.address,'_')[1]}" style="width:232px; margin-top:5px;"/>
								<span class="join_hidden" id="alert_address_null">필수입력사항입니다.</span>
							</td>
						</tr>
						<tr class="onlyStdt">
							<th>학교구분</th>
							<td>
								<select id="academic" name="stdtCheck">
									<option value="" selected="selected">학교구분</option>
									<option value="고등학교 졸업">고등학교 졸업</option>
									<option value="대학(2,3년)">대학(2,3년)</option>
								    <option value="대학(4년)">대학(4년)</option>
								    <option value="대학원(석사,박사)">대학원(석사,박사)</option>
							    </select>
							    <span class="join_hidden" id="alert_academic_null">필수입력사항입니다.</span>
							</td>
						</tr>
						<tr class="onlyStdt">
							<th>학교명</th>
							<td>
							<input type="text" id="comaca1" name="stdtCheck" value="${fn:split(userinfo.comaca,'_')[0]}" placeholder="학교명" style="width: 150px; margin-right: 0;" autocomplete="off"/>
							    <!-- <a class="btn" href="javascript:fnSearchSchool();">검색</a>	    -->
							    <div id="search_schoolname_list" class="search_schoolname_list"></div>
							    <span class="join_hidden" id="alert_comaca1_null">필수입력사항입니다.</span>
							</td>
						</tr>
						<tr class="onlyStdt">
							<th>학과</th>
							<td>
								<input type="text" id="comaca3" name="stdtCheck" value="${fn:split(userinfo.comaca,'_')[1]}" placeholder="학과/인문계" style="width: 150px; margin-right: 0;"  autocomplete="off"/>
							    <div id="search_majorname_list" class="search_majorname_list"></div>
							    <span class="join_hidden" id="alert_comaca3_null">필수입력사항입니다.</span>
							</td>
						</tr>
						<tr class="onlyStdt">
							<th>졸업년도</th>
							<td>
								<select id="graduation_date" name="stdtCheck" style="width: 85px;">
									<option value="" selected="selected">졸업년도 </option>
									<c:forEach begin="0" end="40" var="i">
									<option value="${(year+1)-i}">${(year+1)-i}</option>
									</c:forEach>
							    </select>
							    <select id="graduation_month" name="stdtCheck" style="width: 80px;">
									<option value="02" selected="selected">02</option>
									<c:forEach begin="3" end="12" var="i">
										<c:if test="${i <= 9}"><option value="0${i}">0${i}</option></c:if>
										<c:if test="${i > 9}"><option value="${i}">${i}</option></c:if>
									</c:forEach>
							    </select>
							    <span class="join_hidden" id="alert_graduation_date_null">필수입력사항입니다.</span>
							    <span class="join_hidden" id="alert_graduation_month_null">필수입력사항입니다.</span>
							</td>
						</tr>
						<tr class="onlyStdt">
							<th>최종학력</th>
							<td>
								<select id="comaca4" name="stdtCheck" style="width: 80px;">
									<option value="">최종학력</option>
									<option value="졸업">졸업</option>
									<option value="졸업예정">졸업예정</option>
								    <option value="재학중">재학중</option>
								    <option value="중퇴">중퇴</option>
								    <option value="수료">수료</option>
								    <option value="휴학">휴학</option>
							    </select>
							    <span class="join_hidden" id="alert_comaca4_null">필수입력사항입니다.</span>
							</td>
						</tr>
						<tr class="onlyStdt">
							<th>희망분야</th>
							<td>
								<select style="width: 80px;" id="major_sub" name="stdtCheck">
									<option value="">희망분야</option>
									<option value="자바">자바</option>
									<option value="정보보안">정보보안</option>
								</select>
								<span class="join_hidden" id="alert_major_sub_null">필수입력사항입니다.</span>
							</td>
						</tr>
						<%-- <tr class="onlyStdt" >
							<th>수강상태</th>
							<td>
								<input type="text" id="course" value="${userinfo.course}" disabled="disabled"/>
							</td>
						</tr> --%>
						<tr class="onlyStdt" id="certificationCont">
							<th>본인인증</th>
							<c:if test="${userinfo.dupinfo == '' || empty userinfo.dupinfo}">
								<td><a href="javascript:fnIpinPopup();">본인인증</a> &nbsp; 아직 인증되지 않은 계정입니다. 본인인증을 진행해주세요.</td>
							</c:if>
							<c:if test="${userinfo.dupinfo != '' && not empty userinfo.dupinfo}">
								<td>본인인증이 완료된 계정입니다. <a href="javascript:fnIpinPopup();">재인증</a></td>
							</c:if>
						</tr>
					</table>
					
					<!-- 수강생일 경우 -->
					<form name="form_ipin" method="post">
						<input type="hidden" name="m" value="pubmain">						<!-- 필수 데이타로, 누락하시면 안됩니다. -->
					    <input type="hidden" name="enc_data" value="${params.sEncData}">	<!-- 위에서 업체정보를 암호화 한 데이타입니다. -->
					    <input type="hidden" name="mode" value="update">
					    <input type="hidden" name="url" value="/login/insertUserFrm.kh">
					</form>
					
					<!-- 가상주민번호 서비스 팝업 페이지에서 사용자가 인증을 받으면 암호화된 사용자 정보는 해당 팝업창으로 받게됩니다.
						 따라서 부모 페이지로 이동하기 위해서는 다음과 같은 form이 필요합니다. -->
					<form name="vnoform" method="post">
						<input type="hidden" id="enc_data" name="enc_data">				<!-- 인증받은 사용자 정보 암호화 데이타입니다. -->
					</form>
					
					<div id="stdt_info">
					<input type="hidden" id="stdt_no" name="stdt_no" onkeyup="fnStdtNoOk();" value="${userinfo.stdt_no}" readonly>
					<div class="bar"></div>
					<p class="join_title">추가정보(선택입력)</p>
					<table class="join_table onlyStdt" cellpadding="0" cellspacing="0">
						<tr class="careerAppend">
							<th>경력</th>
							<td>
								<button type="button" id="careerPlus" onclick="fnCareerPlus();">추가</button>
								<input type="hidden" id="career" value="">
							</td>
						</tr>
						<tr class="govercountAppend">
							<th>국비수강 횟수</th>
							<td>
								<select style="width: 65px;" id="govercount" onchange="fnGovercount();">
										<option value="">0</option>
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
								</select>
								<input type="hidden" id="govercountPlus" value=""/>
							</td>
						</tr>
						<tr class="licenseAppend">
							<th>자격증</th>
							<td>
								<button type="button" id="licensePlus" onclick="fnLicensePlus();">추가</button>
								<input type="hidden" id="license" value="">
							</td>
						</tr>
					</table>
					<table class="join_table onlyNormal" cellpadding="0" cellspacing="0">
						<tr>
							<th>블로그/홈페이지</th>
							<td><input type="text" id="homepage" name="homepage" value="${userinfo.homepage}"></td>
						</tr>
						<tr>
							<th>생년월일</th>
							<td><input type="text" id="birth" name="birth" value="${userinfo.birth}"></td>
						</tr>
						<tr>
							<th>학교/회사명</th>
							<td><input type="text" id="groups" name="groups" value="${userinfo.groups}"></td>
						</tr>
						<tr>
							<th>관심분야</th>
							<td><input type="text" id="interest_field" name="interest_field" value="${userinfo.interest_field}"></td>
						</tr>
					</table>
						<div class="join_ok" id="join_ok">
							<a href="javascript:fnInsertUser();">정보수정완료</a>
							<a href="${pageContext.request.contextPath}/login/deleteUserFrm.kh" class="navy">회원 탈퇴</a>
						</div>
						<div class="join_ok" id="join_ok2">
							<a href="javascript:fnInsertUser();">정보수정완료</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	
	<!-- 	<jsp:include page="/WEB-INF/jsp/common/right.jsp"/> -->
	</div>
</div>
<jsp:include page="/WEB-INF/jsp/common/bottom.jsp"/>
</body>
</html>