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
<script src="${pageContext.request.contextPath}/resources/js/validate/validatePhoneNum.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/joinMember/schoolAuto.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/joinMember/certifyEmail.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/validate/validateValue.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/joinMember/inputSetting.js"></script>

<style>
.emer_relation_layer{ display: none; float:right; position:relative; right:122px;}
#stdt_info {
	display: none;
}

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
#search_schoolname_list,#search_majorname_list {
	position: absolute;
	width: 226px;
	height: 300px;
	padding: 10px;
	overflow-y: scroll;
	display: none;
	background: #fff;
	z-index: 98;
	border: 1px solid #ececec;
	text-align: left;
}

</style>

</head>
<body>
<div class="popup_layer" id="input_ok">
	<div class="popup_layer_bg"></div>
	<div class="popup_layer_cont">
		<div class="popup_head">
			<span>회원가입 완료</span>
			<a href="${pageContext.request.contextPath}/login/login.kh">&nbsp;</a>
		</div>
		<div class="popup_cont">
			<p id="input_ok_ment">회원가입이 완료되었습니다.</p>
			<a href="${pageContext.request.contextPath}/login/login.kh" class="button">확인</a>
		</div>
	</div>
</div>
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
				</p>
				<div id="join_frm" style="border-top: #283444 solid 1px; padding-top: 15px;">
					<div>
					<p class="join_title">기본정보(필수입력)</p>
					<table class="join_table" cellpadding="0" cellspacing="0">
						<tr>
							<th>회원 구분</th>
							<td>
								<input type="radio" id="member_flag_studnet" name="member_flag" value="P" ${params.isStdt != 0?'checked':''} disabled>
								<label for="member_flag_studnet">수강생(예비)</label>&nbsp;&nbsp;
								<%-- <input type="radio" id="member_flag_normal" name="member_flag" value="U" ${params.isStdt == 0?'checked':''} disabled>
								<label for="member_flag_normal">일반회원</label> --%>
							</td>
						</tr>
						<tr>
							<th>아이디</th>
							<td>
								<input type="text" id="id" name="id" onkeypress="no_special();" onchange="fnChangeId();">
								<a href="javascript:fnIdCheck();" id="checkIdDuplicate">중복확인</a>
								<span>* 5~12자의 영문자, 소문자, 숫자만 사용가능합니다.</span>
								<span class="join_hidden" id="alert_id_null">필수입력사항입니다.</span>
								<span class="join_hidden" id="alert_id_val">정확한 아이디를 입력하세요.</span>
								<span class="join_hidden" id="alert_id_yet">이미 사용중인 아이디입니다.</span>
								<span class="join_hidden" id="alert_id_yes">사용가능한 ID입니다.</span>
								<span class="join_hidden" id="alert_id_check">아이디 중복확인이 필요합니다.</span>
							</td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td>
								<input type="password" id="password" name="password">
								<span class="join_hidden" id="alert_password">필수입력사항입니다.</span>
								<span class="join_hidden" id="alert_password_leng">비밀번호는 4자리 이상이어야합니다.</span>
							</td>
						</tr>
						<tr>
							<th>비밀번호 확인</th>
							<td>
								<input type="password" id="password1">
								<span class="join_hidden" id="alert_passcheck">비밀번호가 일치하지 않습니다.</span>
							</td>
						</tr>
						<tr>
							<th>이름</th>
							<td>
								<input type="text" id="name" name="name" value="${sData.sName == null? params.name:''}">
								<span class="join_hidden" id="alert_name">필수입력사항입니다.</span>
							</td>
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
								</select> - 
								<input type="text" style="width: 73px; margin-right: 0;" id="mobile2" name="mobile2" maxlength="4"> -
								<input type="text" style="width: 73px;" id="mobile3" name="mobile3" maxlength="4">
								<span class="join_hidden" id="alert_mobile_null">필수입력사항입니다.</span>
								<span class="join_hidden" id="alert_mobile_check">정확한 핸드폰 번호를 입력해주세요.</span>
							</td>
						</tr>
						<tr>
							<!-- 인증코드를 입력하게 변경 -->
							<th>이메일 주소</th>
							<td>
								<input type="text" style="width: 100px; margin-right: 0;" id="email1" name="email1"> @ 
								<input type="text" style="width: 180px;" id="email2" name="email2">
								<select style="width: 140px;" id="email_select" onchange="fnChangeEmail();">
									<option value="">직접입력</option>
									<option value="naver.com">naver.com</option>
									<option value="daum.net">daum.net</option>
									<option value="hanmail.net">hanmail.net</option>
									<option value="gmail.com">gmail.com</option>
								</select>
								<button type="button" id="emailValidationBtn" style="border:none; height: 25px;width: 75px; cursor:pointer;background: #283444;line-height: 25px;text-align: center;display: inline-block;color: #fff;font-size: 12px;">인증하기</button>
								<input type="text" id="emailValidNum" style="margin-top: 10px;width: 70px;" maxlength="6"/>
								<span id="availableTime" style="color: #fa5c3f;"></span>
								<button type="button" id="emailConfirmBtn" style="border:none; height: 25px;width: 75px;background: #283444;line-height: 25px;text-align: center;display: inline-block;color: #fff;font-size: 12px;">확인</button>
								<span class="join_hidden" id="alert_email_null">필수입력사항입니다.</span>
								<span class="join_hidden" id="alert_email_check">정확한 이메일 주소를 입력해주세요.</span>
								<span class="join_hidden" id="alert_email_certify">이메일 인증을 진행해주세요.</span>
								<span class="join_hidden" id="alert_email_confirm">이메일 인증을 완료해주세요.</span>
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
								<input type="text" style="width: 73px; margin-right: 0;" id="emer_tel1" name="emer_tel1" maxlength="4" value=""> -
								<input type="text" style="width: 73px;" id="emer_tel2" name="emer_tel2" maxlength="4" value="">
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
									<option value="">선택</option>
									<c:forEach begin="0" end="100" var="i">
									<option value="${year-i}">${year-i}</option>
									</c:forEach>
								</select>
								<select style="width: 65px;" id="birth2" name="stdtCheck">
									<option value="">선택</option>
									<c:forEach begin="1" end="12" var="i">
									<c:if test="${i <= 9}"><option value="0${i}">0${i}</option></c:if>
									<c:if test="${i > 9}"><option value="${i}">${i}</option></c:if>
									</c:forEach>
								</select>
								<select style="width: 65px;" id="birth3" name="stdtCheck">
									<option value="">선택</option>
									<c:forEach begin="1" end="31" var="i">
									<c:if test="${i <= 9}"><option value="0${i}">0${i}</option></c:if>
									<c:if test="${i > 9}"><option value="${i}">${i}</option></c:if>
									</c:forEach>
								</select>
								<span class="join_hidden" id="alert_birth_null">필수입력사항입니다.</span>
							</td>
						</tr>
						<tr class="onlyStdt">
							<th>주소</th>
							<td>
								<input type="text" id="city" name="stdtCheck" value=""/><button type="button" id="findAddress">주소검색</button><br>
								<input type="text" id="address_etc" value="" style="width:232px; margin-top:5px;" />
								<span class="join_hidden" id="alert_city_null">필수입력사항입니다.</span>
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
							<input type="text" id="comaca1" name="stdtCheck" placeholder="학교명" style="width: 150px; margin-right: 0;" autocomplete="off"/>
							    <!-- <a class="btn" href="javascript:fnSearchSchool();">검색</a>	    -->
							    <div id="search_schoolname_list" class="search_schoolname_list"></div>
							    <span class="join_hidden" id="alert_comaca1_null">필수입력사항입니다.</span>
							</td>
						</tr>
						<tr class="onlyStdt">
							<th>학과</th>
							<td>
								<input type="text" id="comaca3" name="stdtCheck" placeholder="학과/인문계" style="width: 150px; margin-right: 0;"  autocomplete="off"/>
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
						<!-- <tr class="onlyStdt">
							<th>수강상태</th>
							<td>
								<input type="text" id="course" value="대기" disabled="disabled"/>
							</td>
						</tr> -->
					</table>
					<!-- 이메일 인증 테스트 입니다. -->
					<!------------ start script ------------>
					<script>
					var emailConfirmBtn = false;//이메일 인증 확인버튼 클릭여부를 나타내는 객체(true : 클릭, false : 미클릭)
					var emailValidBtn = false; //이메일 인증 버튼 클릭여부를 나타내는 객체(true : 클릭, false : 미클릭)
					(function(){
						$('#emailValidNum').hide();
						$('#emailConfirmBtn').hide();
					})();
					
					document.getElementById('emailValidationBtn').addEventListener('click', function (){
						checkInputValue();
					});
					
					function checkInputValue(){
						if($('#email1').val() === '' || $('#email2').val() === ''){
							$("#alert_email_null").css("display", "block");
							return;
						}
						$('#email2').attr('disabled',true);
						$('#email_select').attr('disabled',true);
						validateEmail('${pageContext.request.contextPath}',$('#email1').val()+'@'+$('#email2').val());
					}
					</script>
					<!------------ end script ------------>
					<!-- start 주소찾기 api -->
					<script>
					document.getElementById('findAddress').addEventListener('click', function loadPostCode(){
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
					});
					</script>
					<!-- end 주소찾기 api -->
					
					</div>
					<div class="bar"></div>
					<p class="join_title">추가정보(선택입력)</p>
					<table class="join_table onlyStdt" cellpadding="0" cellspacing="0">
						<tr class="careerAppend">
							<th>경력</th>
							<td >
								<input type="hidden" id="career" value="">
								<button type="button" id="careerPlus">추가</button>
							</td>
						</tr>
						<tr class="govercountAppend">
							<th>국비수강횟수</th>
							<td>
								<select style="width: 65px;" id="govercount">
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
								<button type="button" id="licensePlus">추가</button>
								<input type="hidden" id="license" value="">
							</td>
						</tr>
					</table>
					<table class="join_table onlyNormal" cellpadding="0" cellspacing="0">
						<tr>
							<th>블로그/홈페이지</th>
							<td><input type="text" id="homepage" name="homepage"></td>
						</tr>
						<tr>
							<th>생년월일</th>
							<td>
								<input type="text" id="birth" name="birth">
							</td>
						</tr>
						<tr>
							<th>학교/회사명</th>
							<td><input type="text" id="groups" name="groups"></td>
						</tr>
						<tr>
							<th>관심분야</th>
							<td><input type="text" id="interest_field" name="interest_field"></td>
						</tr>
					</table>
					<div class="join_ok">
						<a href="javascript:fnInsertUser();">회원가입완료</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/jsp/common/right.jsp"/>
</div>
<jsp:include page="/WEB-INF/jsp/common/bottom.jsp"/>
</body>
<script type="text/javascript">
var idCheck = false;
// isStdt 0:flag가 일반회원 1:검사되지 않음 2:통과
var isStdt = '${params.isStdt}';
jQuery(function(){
	fnOnMenu(7, 1);
	
	/* 학교검색 자동기능 schoolAuto.js참고 */
	$("#comaca1").autoSearch('${pageContext.request.contextPath}');
	$("#comaca3").autoSearch('${pageContext.request.contextPath}');
	
	//수강생일경우와 아닐경우의 기본값 세팅해주는 함수.
	fnstdtSetting();
	fnUserIdSetting();
});

/*
 * 비상연락망 change시 발생하는 이벤트
    기타 선택한 경우 input칸 show
 */
$('#emer_relation').on('change',function(event){
	if($('#emer_relation').val() === '기타'){
		$('.emer_relation_layer').show();
	}
	else{
		$('.emer_relation_layer').hide();
	}
});

/*
 * 추가입력부분 항목 추가 기능
   inputSetting.js 참고
 */
let govercount = document.getElementById('govercount');
let careerPlus = document.getElementById('careerPlus');
let licensePlus = document.getElementById('licensePlus');

/** 
 * 국비수강횟수 항목 change시 발생하는 이벤트
 */
govercount.addEventListener('change',function(event){
	let goverCount = event.target.value;
	$('.addCurrName').remove();
	if(goverCount !== ''){
		for(var i=0; i<goverCount; i++){
			inputSetting['govercount'](i,'');
		} 
	}
});

let ic = 0;
let lc = 0;
/*
 * 경력 추가 버튼 click시 발생하는 이벤트
 */
careerPlus.addEventListener('click',function(event){
	ic++;
	inputSetting['career'](ic,'');
});

/*
 * 자격증 추가 버튼 click시 발생하는 이벤트
 */
licensePlus.addEventListener('click',function(event){
	lc++;
	inputSetting['license'](lc,'');
});

function fnstdtSetting(){
	if (isStdt == '') {
		isStdt = 1;
	}
	if (isStdt == 0) {//일반회원인 경우
		$("#stdt_info").hide();
		$(".onlyNormal").show();
		$(".onlyStdt").remove();
	}
	else if(isStdt == 1){//수강생인 경우
		const mobile = '${params.stdtMobile}'.split('-');
		$('#name').attr('disabled',true).val('${params.stdtName}');
		$("#mobile1 option[value='"+mobile[0]+"']").attr("selected", "selected");
		$("#span_mobile1").html($("#mobile1 option:selected").html()).parent().addClass('changed');
		$('#mobile1').attr('disabled',true);
		$('#mobile2').attr('disabled',true).val(mobile[1]);
		$('#mobile3').attr('disabled',true).val(mobile[2]);
		
		$("#stdt_info").show();
		$(".onlyStdt").show();
		$(".onlyNormal").remove();
	}
}

/*
 * 재가입하는 경우 아이디 항목에 아이디 값 표출 하는 함수
 */
function fnUserIdSetting(){
	if('${params.khinfoResult}'.indexOf(":") !== -1){
		$('#id').val('${params.khinfoResult}'.split(':')[1]).attr("disabled",true);
		$('#checkIdDuplicate').attr('style','display:none;');
		idCheck = true;
	}
}

function fnChangeId(){
	idCheck = false;
}

//ID중복검사
function fnIdCheck() {
	idCheck = false;
	$(".join_hidden").hide();
	
	if($.trim($($('#id')).val()) == '') {
		$("#alert_id_null").css("display", "block");
		document.getElementById("id").focus();
		return;
	}else if($.trim($($('#id')).val()).length < 5 || $.trim($($('#id')).val()).length > 12){
		$("#alert_id_val").css("display", "block");
		document.getElementById("id").focus();
		return;
	}else if(isID($.trim($($('#id')).val()))){
		$("#alert_id_val").css("display", "block");
		document.getElementById("id").focus();
		return;
	}
	
	var	params	= {
		id          : $('#id').val()
	};
	$.ajax({
		url			: '${pageContext.request.contextPath}/login/selectIdCheck.kh',
		dataType	: 'json',
		type		: 'post',
		data		: params,
		success		: function (data, textStatus) {
			if (data['result'] == 'O') {
				$("#alert_id_yes").css("display", "block");
				idCheck = true;
			}else {
				$("#alert_id_yet").css("display", "block");
				return false;
			}
		},
		error		: function (jqXHR, textStatus, errorThrown) {
			alert('오류가 발생했습니다\n[' + textStatus + ']\n' + errorThrown);
		}
	});
}

/*
 * 입력값 전송하는 함수
 */
function fnInsertUser() {
	// 수강생 번호 확인
	if (f_validate()) {
		if(confirm('회원 가입 하시겠습니까?')){
			//var stdt_no = $("#stdt_no").val();
			//if(isStdt==0 ) stdt_no='';
			resettingPlus();
			var	params	= {
					id					: $('#id').val(),
					password			: $('#password').val(),
					name				: $('#name').val(),
					mobile				: $('#mobile1').val()+'-'+ $('#mobile2').val()+'-'+$('#mobile3').val() ,
					email				: $('#email1').val()+'@'+$('#email2').val(),
					major_sub           : $('#major_sub').val(),
					comaca              : $('#comaca1').val()+"_"+$('#comaca3').val()+"_"+$('#comaca4').val(),
					academic            : $('#academic').val(),
					graduation_date     : $('#graduation_date').val()+"."+$('#graduation_month').val(),
					address             : "_"+$('#city').val()+"_"+$('#address_etc').val(),
					emer_tel            : $('#emer_tel0').val()+'-'+$('#emer_tel1').val()+'-'+$('#emer_tel2').val(),
					emer_relation       : $('#emer_relation').val(),
					course			    : '대기',
					member_flag			: $('input[name=member_flag]:checked').val(),
					career			    : $('#career').val(),
					govercount			: $('#govercountPlus').val(),
					license			    : $('#license').val(),
					homepage			: $('#homepage').val(),
					birth				: $('#birth').val(),
					stdt_birth          : $('#birth1').val()+"."+$('#birth2').val()+"."+$('#birth3').val(),
					groups				: $('#groups').val(),
					interest_field		: $('#interest_field').val(),
					khinfoResult        : '${params.khinfoResult}',
					user_signature      : '${params.user_signature}'
			};
			$.ajax({
				url			: '${pageContext.request.contextPath}/login/insertUser.kh',		
				dataType	: 'json',
				type		: 'post',
				data		: params,
				success		: function (data, textStatus) {
					if (data['result'] == '0') {
						fnAlertOpen(data['message']);
					}else {
						$('#login').load('${pageContext.request.contextPath}/result/insertUserResult.jsp');
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
 * 입력값 점검하는 함수
 */
function f_validate() {
	var n = 0;
	$(".join_hidden").hide();
	if($('input[name=member_flag]:checked').val() != 'P' && $('input[name=member_flag]:checked').val() != 'U') {
		$("#alert_member_flag").css("display", "block");
		n=1;
	}
	
	if($("#id").val()==null || $("#id").val()=="") {
		$("#alert_id_null").css("display", "block");
		n=1;
	} else {
		if(idCheck != true) {
			$("#alert_id_check").css("display", "block");
			n=1;
		}	
	}

	if($('#name').val()==null || $("#name").val()==""){
		$("#alert_name").css("display", "block");
		
		n=1;
	}
	if($.trim($($('#password')).val()) == '') {
		$("#alert_password").css("display", "block");
		n=1;
	} else if($.trim($($('#password')).val()).length < 4){
		$("#alert_password_leng").css("display", "block");
		return;
	} else {
		if($.trim($($('#password')).val()) != $.trim($($('#password1')).val())) {
			$("#alert_passcheck").css("display", "block");
			n=1;
		}
	}

	if($.trim($($('#mobile1')).val()) == '' || $.trim($($('#mobile2')).val()) == '' || $.trim($($('#mobile3')).val()) == '') {
		$("#alert_mobile_null").css("display", "block");
		n=1;
	} else {
		if(!isPhoneNumber($('#mobile2').val(), 3)){
			$("#alert_mobile_check").css("display", "block");
			n=1;
		}
		if(!isPhoneNumber($('#mobile3').val(), 4)){
			$("#alert_mobile_check").css("display", "block");
			n=1;
		}
	}

	if($.trim($($('#email1')).val()) == '' || $.trim($($('#email2')).val()) == '') {
		$("#alert_email_null").css("display", "block");
		n=1;
	} else if(isID($.trim($($('#email1')).val()))) {
		$("#alert_email_check").css("display", "block");
		n=1;
	} else if(email2Check($.trim($($('#email2')).val()))){
		$("#alert_email_check").css("display", "block");
		n=1;
	}
	else if(emailConfirmBtn === false || emailValidBtn === false){
		$("#alert_email_certify").css("display", "block");
		n=1;
	}
	else if($('#emailValidNum').val() === ''){
		$("#alert_email_confirm").css("display", "block");
		n=1;
	} 
	
	if($('input[name=member_flag]:checked').val() === 'P'){
		let commonNames = document.getElementsByName('stdtCheck');
		for(var i=0; i<commonNames.length; i++){
			if(is_Empty(commonNames[i].value) === false){
				$("#alert_"+commonNames[i].getAttribute('id')+"_null").css("display", "block");
				n=1;
			} 
			
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
		if($('#birth1').val() === '' || $('#birth2').val() === '' ||$('#birth3').val() === ''){
			$("#alert_birth_null").css("display", "block");
			n=1;
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
	var flag = $('input[name=member_flag]:checked').val();
	
	if(flag=='T'){
		$("#stdt_info").show(0);
		isStdt=1;
	} else {
		$("#stdt_info").hide(0);
		isStdt=0;
	}
}

</script>
</html>