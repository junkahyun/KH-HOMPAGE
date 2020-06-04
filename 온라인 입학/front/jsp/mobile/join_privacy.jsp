<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="/WEB-INF/tlds/c.tld" %> 
<%@ taglib prefix="fn" 		uri="/WEB-INF/tlds/fn.tld" %>
<%@ taglib prefix="fmt"		uri="/WEB-INF/tlds/fmt.tld" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>With KH</title>
<jsp:include page="/WEB-INF/jsp/app/common/meta.jsp"/>
<script src="${pageContext.request.contextPath}/resources/js/validate/mobileDate.js"></script> 
<script src="${pageContext.request.contextPath}/resources/js/validate/validateValue.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/validate/validatePhoneNum.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/joinMember/schoolAuto.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/joinMember/certifyEmail.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/joinMember/inputSetting.js"></script>

<style>
	.popup_layer { display:none;  position:fixed; _position:absolute; top:0; left:0; width:100%; height:100%; z-index:10000;}
	.popup_layer .popup_layer_bg {position:absolute; top:0; left:0; width:100%; height:100%; background:#000; opacity:.5; filter:alpha(opacity=50);}
	.popup_layer .popup_layer_cont {background:#fff; width: 92%;}
	.address, .school, .id, .email, .removeBtn{background: #3b48c9; display: inline-block; float: right; margin:3%; line-height:160%; margin-right:2.5%;}
	.sub_modifybox .sub_modifybox_title{color:#222222; font-weight:normal;}
	.career, .license{background: #3b48c9; display: inline-block; float: left; margin:3%; line-height:160%; margin-right:2.5%;}
	.layer{display:none;}
	.next_page{width:100%; background:#0c0451; padding:5% 0; text-align:center;}
	/* .next_page:hover{background:#c8ceda; } */
	.next_page p{color:#fff;}
	.sub_modifybox .sub_modifybox_table td.only_tel{padding:2% 0}
	#id,  #email, #city {width: 47%;}
	#emer_tel {width: 92%;}
	#emailValidNum {width: 33%;}
	#availableTime {color: red; float: right; margin-right: 4%;}
	#mobile_Certification_Num{width: 37%;}
	#search_schoolname_list, #search_majorname_list{
		position: absolute;
		border: 1px solid #e6e9ec;
	    width: 55.5%;
	    height: 20%;
	    background: #fff;
	    overflow-y: scroll;
	    text-align: left;
	    display: none;
	}
	#emer_relation{width: 47.6%;}
	#emer_tel{width: 45%;}
	#graduation_date{width: 60%;}
	#graduation_month{width: 38%;}
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
					<h2>개인정보를 입력해주세요.</h2>
					<p>KH정보교육원은 상담, 서비스 신청 등을 위해<br>아래와 같은 개인정보를 수집하고 있습니다.</p>
				</div>
				<div class="popup_layer" id="loading">
					<div class="popup_layer_bg"></div>
					<div class="popup_layer_cont" style="background: none; height: 155px; width: 180px;">
						<img src="${pageContext.request.contextPath}/resources/images/sub06/sub06_loading.gif" alt="now loading....">
					</div>
				</div>
				<div class="sub_modifybox sub_box">
					<h2 class="sub_modifybox_title">기본정보(필수입력)</h2>
					<div class="sub_modifybox_table">
						<table cellpadding="0" cellspacing="0">
						<caption>기본정보(필수입력) 테이블</caption>
							<colgroup>
								<col width="33.7%"> 
								<col width="66.3%">
							</colgroup>
							<tbody>
								<tr>
									<th>회원 구분</th>
									<td class="td_disabled"><input type="text" value="${params.member_flag == 'P'?'수강생':'일반회원'}" disabled="disabled"/></td>
								</tr>
								<tr >
									<th>아이디</th>
									<td>
										<input type="text" id="id" name="inputCheck" data-message="아이디를 입력해주세요."/>
										<a class="btn_sm id" id="idVerify">중복확인</a>
									</td>
								</tr>
								<tr>
									<th>비밀번호</th>
									<td><input type="password" id="password" name="inputCheck" data-message="비밀번호를 입력해주세요."/></td>
								</tr>
								<tr>
									<th>비밀번호확인</th>
									<td><input type="password" id="password1" name="inputCheck" data-message="비밀번호를 입력해주세요."/></td>
								</tr>
								<tr>
									<th>이름</th>
									<td class="td_disabled"><input type="text" value="${params.stdtName}" id="name" name="inputCheck" data-message="이름을 입력해주세요."/></td>
								</tr>
								<tr>
									<th>휴대폰</th>
									<td class="td_disabled only_tel"><input type="tel" maxlength="13" id="mobile" class="mobile_input" name="inputCheck" value="${params.stdtMobile}" data-message="휴대폰번호를 입력해주세요."/></td>
								</tr>
								<tr class="onlyStdt">
									<th>비상연락망</th>
									<td>
										<input type="tel" id="emer_tel" maxlength="13" name="stdtCheck" data-message="비상연락망을 입력해주세요."/>
										<select id="emer_relation" name="stdtCheck" data-message="관계를 선택해주세요.">
											<option value="부">부</option>
											<option value="모">모</option>
											<option value="자매">자매</option>
											<option value="형제">형제</option>
											<option value="기타">기타</option>
										</select>
									</td>
								</tr>
								<tr class="onlyStdt">
									<th>생년월일</th>
									<td>
									<form name="form1">
										<script language="javascript"> Today('null','null','null'); </script>
									</form>
									</td>
								</tr>
								<tr>
									<th>e-mail</th>
									<td>
										<input type="text" id="email" name="inputCheck" data-message="이메일을 입력해주세요."/>
										<a class="btn_sm email" id="emailValidationBtn">인증하기</a>
									</td>
								</tr>
								<tr class="emailVerify">
									<th></th>
									<td>
										<input type="text" id="emailValidNum" maxlength="6"/>
										<a class="btn_sm email" id="emailConfirmBtn">확인</a>
										<span id="availableTime"></span>
									</td>
								</tr>
								<tr class="onlyStdt">
									<th>주소</th>
									<td>
										<input type="text" value="" id="city" name="city"/>
										<a class="btn_sm address" id="addressBtn">주소검색</a>
									</td>
								</tr>
								<tr class="onlyStdt">
									<th>상세주소</th>
									<td>
										<input type="text" value="" id="address_etc"/>
									</td>
								</tr>
								<tr class="onlyStdt">
									<th>학교구분</th>
									<td>
										<select id="academic" name="stdtCheck" data-message="학교구분을 선택해주세요.">
											<option value="" selected="selected">학교구분</option>
											<option value="고등학교 졸업">고등학교 졸업</option>
											<option value="대학(2,3년)">대학(2,3년)</option>
											<option value="대학(4년)">대학(4년)</option>
											<option value="대학원(석사/박사)">대학원(석사/박사)</option>
										</select>		
									</td>
								</tr>
								<tr class="onlyStdt">
									<th>학교명</th>
									<td>
										<input type="text" value="" id="comaca1" />
										<div id="search_schoolname_list" class="search_schoolname_list"></div>
									</td>
								</tr>
								<tr class="onlyStdt">
									<th>학과</th>
									<td>
										<input type="text" value="" id="comaca3"/>
										<div id="search_majorname_list" class="search_majorname_list"></div>
									</td>
								</tr>
								<tr class="onlyStdt">
									<th>졸업년도</th>
									<td>
										<c:set var="now" value="<%=new java.util.Date()%>" />
										<c:set var="year"><fmt:formatDate value="${now}" pattern="yyyy"/> </c:set>
										<select id="graduation_date">
											<option value="" selected="selected">졸업연도</option>
											<c:forEach begin="0" end="40" var="i">
											<option value="${(year+1)-i}">${(year+1)-i}</option>
											</c:forEach>
										</select>
										<select id="graduation_month">
											<option value="02" selected="selected">02</option>
											<c:forEach begin="3" end="12" var="i">
												<c:if test="${i <= 9}"><option value="0${i}">0${i}</option></c:if>
												<c:if test="${i > 9}"><option value="${i}">${i}</option></c:if>
											</c:forEach>
										</select>		
									</td>
								</tr>
								<tr class="onlyStdt">
									<th>최종학력</th>
									<td>
										<select id="comaca4" >
											<option value="" selected="selected">최종학력</option>
											<option value="졸업">졸업</option>
											<option value="졸업예정">졸업예정</option>
											<option value="재학중">재학중</option>
											<option value="중퇴">중퇴</option>
											<option value="수료">수료</option>
											<option value="휴학">휴학</option>
										</select>	
									</td>
								</tr>
								<tr class="onlyStdt">
									<th>희망분야</th>
									<td>
										<select id="major_sub" name="stdtCheck" data-message="희망분야를 선택해주세요.">
											<option value="" selected="selected">희망분야</option>
											<option value="자바">자바</option>
											<option value="정보보안">정보보안</option>
										</select>
									</td>
								</tr>
								<!-- <tr class="onlyStdt">
									<th></th>
									<td>
										<input type="text">
									</td>
								</tr> --> 
							</tbody>
						</table>	 
					</div><!-- //sub_modifybox_table -->
				</div><!-- //sub_modifybox -->
				
				<div class="sub_modifybox sub_box" style="margin-bottom: 0;border-bottom: 0; padding-bottom:10%;">
					<h2 class="sub_modifybox_title">추가정보(선택입력)</h2>
					<div class="sub_modifybox_table">
						<table cellpadding="0" cellspacing="0">
						<caption>선택입력 테이블</caption>
							<colgroup>
								<col width="33.7%"> 
								<col width="66.3%">
							</colgroup>
							<tbody class="onlyStdt">
								<tr class="careerAppend">
									<th>경력</th>
									<td>
										<a class="btn_sm career" id="careerPlus">추가</a>
										<input type="hidden" id="career" value="" name="plusStdt">
									</td>
								</tr>
								<tr class="govercountAppend">
									<th>국비수강횟수</th>									
									<td>
										<select id="govercount">
											<option value="" selected="selected">0</option>
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
										<a class="btn_sm license" id="licensePlus">추가</a>
										<input type="hidden" id="license" value="" name="plusStdt">
									</td>
								</tr>
							</tbody>
							<tbody class="onlyNormal">
								<tr>
									<th>블로그/홈페이지</th>
									<td><input type="text" id="homepage" name="plusNormal"></td>
								</tr>
								<tr>
									<th>생년월일</th>									
									<td><input type="text" id="birth" name="plusNormal" ></td>
								</tr>
								<tr>
									<th>학교/회사명</th>
									<td><input type="text" id="groups" name="plusNormal"></td>
								</tr>
								<tr>
									<th>관심분야</th>
									<td><input type="text" id="interest_field" name="plusNormal"></td>
								</tr>
							</tbody>
						</table>	 
					</div><!-- //sub_modifybox_table -->
				</div><!-- //sub_modifybox -->	
				<div class="next_page" id="nextBtn"><p>가입완료</p></div>
			</div><!-- //sub_content -->
		</div><!-- //modify_wrapper -->
	</div><!-- //sub_wrapper -->
	<jsp:include page="/WEB-INF/jsp/app/main/menu.jsp" />
</body>
<script>
$(document).ready(function(){
	$('.emailVerify').hide();
	fnMemberFlagSetting();
	fnUserIdSetting();
});

let idVerify = document.getElementById('idVerify');
let idCheck = false;//아이디 중복확인 클릭여부(클릭 : true, 클릭 x : false)
let nextBtn = document.getElementById('nextBtn');
let addressBtn = document.getElementById('addressBtn');
let emer_tel = document.getElementById('emer_tel');
let mobile = document.getElementById('mobile');
let govercount = document.getElementById('govercount');
let careerPlus = document.getElementById('careerPlus');
let licensePlus = document.getElementById('licensePlus');
let emailBtn = document.getElementById('emailValidationBtn');

/* 비상연락망 입력시 자동으로 - 붙혀주는 keydown 이벤트 */
emer_tel.addEventListener('keydown',function(event){
	var code = event.keyCode;
	if (code == 8 || code == 46) {
		return false;
	}		

	var value = $("#emer_tel").val();
	if (value.length == 3) {
		$("#emer_tel").val(value + "-");
	}
	if (value.length == 8) {
		$("#emer_tel").val(value + "-");
	}
});

/* 휴대폰 입력시 자동으로 - 붙혀주는 keydown 이벤트 */
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
 * 아이디 중복확인 버튼 click시 발생하는 이벤트
 */
idVerify.addEventListener('click',function(){
	fnIdCheck();
});

/*
 * 가입완료 버튼 click시 발생하는 이벤트
 */
nextBtn.addEventListener('click',function(){
	fnValidate();
});

/*
 * 이메일 인증하기 버튼 click시 발생하는 이벤트
 */
emailBtn.addEventListener('click',function(){
	checkInputValue();
});

/* 학교 자동검색 기능 */
$('#comaca1').autoSearch('${pageContext.request.contextPath}');
$('#comaca3').autoSearch('${pageContext.request.contextPath}');

/*
 * 추가입력부분 항목 추가 기능
   inputSetting.js 참고

 * 국비수강횟수 항목 change시 발생하는 이벤트
 */
govercount.addEventListener('change',function(event){
	let goverCount = event.target.value;
	$('.addCurrName').remove();
	if(goverCount !== ''){
		for(var i=0; i<goverCount; i++){
			minputSetting['govercount'](i,'');
		} 
	}
});

let ic = 0;
let lc = 0;
/*
 * 경력 click시 발생하는 이벤트
 */
careerPlus.addEventListener('click',function(event){
	ic++;
	minputSetting['career'](ic,'');
});

/*
 * 자격증 click시 발생하는 이벤트
 */
licensePlus.addEventListener('click',function(event){
	lc++;
	minputSetting['license'](lc,'');
});

/*
 * 주소검색 버튼 click시 발생하는 이벤트
 */
addressBtn.addEventListener('click',function loadPostCode(){
	daum.postcode.load( function () {
		new daum.Postcode({
			oncomplete: function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
				// 예제를 참고하여 다양한 활용법을 확인해 보세요.
				const addressType = data.userSelectedType;

				if (addressType == 'R') {
					$('#city').val(data.roadAddress);
				} else if (addressType == 'J') {
					$('#city').val(data.jibunAddress);
				} else {
					alert("잘못된 타입입니다. 올바른 주소를 선택해주세요.");
				}
				$('#postcode').val(data.zonecode);
			}
		}).open();
	});
});

/*
 * 일반회원,수강생 구분에 따른 입력 항목 세팅
 */
function fnMemberFlagSetting(){
	if('${params.member_flag}' === 'P'){
		$('#name').attr('disabled',true);
		$('#mobile').attr('style','background-color: #fafbfc;');
		$('.onlyStdt').show();
		$('.onlyNormal').remove();
	}
	if('${params.member_flag}' === 'U'){
		$('#name').parent().attr('class','');
		$('#mobile').parent().attr('class','only_tel');
		$('.onlyNormal').show();
		$('.onlyStdt').remove();
	}
};

/*
 * 재가입하는 경우 아이디 항목에 아이디 값 표출 하는 함수
 */
function fnUserIdSetting(){
	if('${params.khinfoResult}'.indexOf(":") !== -1){
		$('#id').val('${params.khinfoResult}'.split(':')[1]).attr("disabled",true);
		$('#idVerify').attr('style','display:none;');
		idCheck = true;
	}
}

/*
 * 이메일 입력 여부 & 유효성 검사하는 함수
 */
function checkInputValue(){
	const pattern_email = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/; // 이메일 유효성 검사 정규식입니다.
	const match_email = pattern_email.exec($("#email").val());
	
	if(match_email === null){
		alert('올바른 이메일을 입력해주세요.');
		$("#email").val('')
		return;
	}
	if(is_Empty($('#email').val()) === false){
		alert('이메일을 입력해주세요.');
		return;
	}
	$('#email').attr('disabled',true);
	validateEmail('${pageContext.request.contextPath}', $('#email').val());
}

//ID중복검사
function fnIdCheck() {
	let id = document.getElementById("id").value;
	let length = document.getElementById("id").value.length;
	
	if(is_Empty(id) === false){
		alert('빈칸을 입력해주세요.');
		return;
	}
	if(length < 5 || length > 12){
		alert('아이디는 5글자 이상 12글자 이하로 작성해주세요.');
		return;
	}
	$.ajax({
		url			: '${pageContext.request.contextPath}/login/selectIdCheck.kh',
		dataType	: 'json',
		type		: 'post',
		data		: {id : id},
		success		: function (data, textStatus) {
			if (data['result'] == 'O') {
				idCheck = true;
				alert('사용가능한 아이디 입니다.');
				return idCheck;
			}else {
				idCheck = false;
				alert('이미 사용중인 아이디 입니다.');
				$('#id').val('');
				$('#id').focus();
				return idCheck;
			}
		},
		error		: function (jqXHR, textStatus, errorThrown) {
			alert('오류가 발생했습니다\n[' + textStatus + ']\n' + errorThrown);
		}
	});
}
var emailValidBtn = false;//이메일 인증하기 버튼 클릭여부 (클릭 : true, 클릭 x : false)
var emailConfirmBtn = false;//이메일 인증확인 버튼 클릭여부 (클릭 : true, 클릭 x : false)

/*
 * 전체 입력값 유효성 검사하는 함수
 */
function fnValidate(){
	const inputCheck = document.getElementsByName('inputCheck');
	const inputLength = document.getElementsByName('inputCheck').length;
	const pattern_email = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/; // 이메일 유효성 검사 정규식입니다.
	const match_email = pattern_email.exec($('#email').val());
	const now = new Date();
	
	if(idCheck === false){
		alert('아이디 중복확인을 해주세요.');
		return false;
	}
	if($("#password").val().length < 6){
		alert('비밀번호는 6자리이상으로 입력해주세요.');
		return false;
	}
	else if($('#password').val() !== $('#password1').val()){
		alert("비밀번호가 일치하지 않습니다.");
		return false;
	}
	if(now.getFullYear() === parseInt($('#year').val())){
		alert('생년월일을 선택해주세요.');
		return;
	}
	if(emailValidBtn === false){
		alert('이메일 인증을 진행해주세요.');
		return false;
	}
	if(is_Empty($('#emailValidNum').val()) === false){
		alert('이메일 인증번호를 입력해주세요.');
		return false;
	}
	if(emailConfirmBtn === false){
		alert('이메일 인증을 완료해주세요.');
		return false;
	}
	if(match_email === null){
		alert('올바른 이메일을 입력해주세요.');
		return false;
	}
	for(var i=0; i<inputLength; i++){
		if(is_Empty(inputCheck[i].value) === false){
			alert(inputCheck[i].getAttribute('data-message'));
			return;
		}
	}
	/* 수강생만 입력하는 항목 유효성 체크*/
	if('${params.member_flag}' === 'P'){
		const stdtCheck = document.getElementsByName('stdtCheck');
		const stdtLength = document.getElementsByName('stdtCheck').length;
		
		for(var i=0; i<stdtLength; i++){
			if(is_Empty(stdtCheck[i].value) === false){
				alert(stdtCheck[i].getAttribute('data-message'));
				return;
			}
		}
		
		if(is_Empty($('#graduation_date').val()) === false){
			alert('졸업년도를 선택해주세요.');
			return;
		}
		if(is_Empty($('#city').val()) === false){
			alert('주소를 선택해주세요.');
			return;
		}
		if(is_Empty($('#comaca1').val()) === false){
			alert('학교명을 입력해주세요.');
			return;
		}
		if(is_Empty($('#comaca3').val()) === false){
			alert('학과를 입력해주세요.');
			return;
		}
		if(is_Empty($('#comaca4').val()) === false){
			alert('최종학력을 선택해주세요.');
			return;
		}
	}
	submitInfo(inputCheck,inputLength);
}

/*
 * 입력값 전송하는 함수
 */
function submitInfo(inputCheck,inputLength){
	if(confirm('회원 가입 하시겠습니까?') === true){
		var formData = new FormData();
		
		let params = function (commonNames,commonNamesSize){
				for(var i=0; i<commonNamesSize; i++){
					formData.append(commonNames[i].id , commonNames[i].value); 
				}
		}
		
		/* 공통요소 form에 담음 */
		params(inputCheck,inputLength);
		formData.append('member_flag' , '${params.member_flag}'); 
		
		/* 일반회원인 경우 */
		if('${params.member_flag}' === 'U'){
			var plusNormal = document.getElementsByName('plusNormal');//일반회원 선택입력
			var plusNormalLength = document.getElementsByName('plusNormal').length;
			
			params(plusNormal,plusNormalLength);
		}
		/* 수강생인 경우 */
		if('${params.member_flag}' === 'P'){
			resettingPlus();
			var stdtCheck = document.getElementsByName('stdtCheck');
			var stdtLength = document.getElementsByName('stdtCheck').length;
			var plusStdt = document.getElementsByName('plusStdt');//수강생 선택입력
			var plusStdtLength = document.getElementsByName('plusStdt').length;
			
			params(stdtCheck,stdtLength);
			params(plusStdt,plusStdtLength);
			
			formData.append('user_signature' , '${params.user_signature}');
			formData.append('khinfoResult' , '${params.khinfoResult}');
			formData.append('course' , '대기'); 
			formData.append('stdt_birth' , $('#year').val()+'.'+$('#month').val()+'.'+$('#day').val()); 
			formData.append('address' , '_'+$('#city').val()+'_'+$('#address_etc').val()); 
			formData.append('comaca' , $('#comaca1').val()+'_'+$('#comaca3').val()+'_'+$('#comaca4').val()); 
			formData.append('govercount' , $('#govercountPlus').val()); 
			formData.append('graduation_date' , $('#graduation_date').val()+"."+ $('#graduation_month').val()); 
			
		}
		$.ajax({
			url			: '${pageContext.request.contextPath}/login/insertUser.kh',		
			dataType	: 'json',
			type		: 'post',
			data		: formData,
			processData : false,
			contentType : false,
			success		: function (data, textStatus) {
				if (data['result'] == '0') {
					fnAlertOpen(data['message']);
				}else {
					alert('회원가입이 완료되었습니다.');
					window.location.href = '${pageContext.request.contextPath}/app/login.mkh';
				}
			},
			error		: function (jqXHR, textStatus, errorThrown) {
				alert('오류가 발생했습니다\n[' + textStatus + ']\n' + errorThrown);
			}
		}); 
	}
}

</script>
</html>