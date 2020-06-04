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
<c:if test="${result == '1'}">
<div class="login_wrapper">
	<div class="login_wrapper_in">
		<div class="sub_top sub_box">
			<div class="back_btn" onClick="location.href='${pageContext.request.contextPath}/mobile2017/main.kh'">
			</div>
			<h1 class="title">수강생등록</h1>
		</div>
			<div class="login_visual">
				<img src="${pageContext.request.contextPath}/app/images/join/join_bg2.jpg" alt="주민번호 이용에 대한 안내" />
			</div>
			<div class="login_content_bottom" style="padding:unset; text-align:center;padding:9% 0;">
				<p class="Resident_Registration">주민등록번호</p>
				<div class="login_input_box">
					<div class="login_input_id">
						<input type="tel" id="res_no1" name="" maxlength="6">
						<input type="tel" id="res_no2" name="" maxlength="7">
					</div>				
				</div><!-- //login_input_box -->
			</div><!-- //login_content_bottom -->
			<div class="footer" id="send_btn" onclick="fnValidate();">
				<p class="send_btn">전송</p>
			</div>
		</div><!-- //login_wrapper_in-->
	</div><!-- //login_wrapper -->
</c:if>
</body>
<script>
(function(){
	if('${result}' === "0" || '${result}' === "-1" || '${result}' === "-2"){
		alert('만료되었거나, 접속 불가능한 링크입니다.');
		window.location.href = '${pageContext.request.contextPath}/mobile2017/main.kh';
	}
})();

function fnValidate(){
	const res_no1 =  document.getElementById('res_no1').value;
	const res_no2 =  document.getElementById('res_no2').value;
	
	const pattern = /(^[0-9]{6}-[0-9]{7})/gi;   //패턴을 정의합니다
	const match = pattern.exec(res_no1+"-"+res_no2);  //입력된 값을 패턴에 적용한다
	const checker = [2, 3, 4, 5, 6, 7, 8, 9, 2, 3, 4, 5]; // 주민번호 체크용 리스트

	if (match == null){
		alert("올바른 주민번호를 입력해주세요.");
		return false;
	} else {
		const value = res_no1+"-"+res_no2;
		const lastValue = value.substr(value.length - 1, value.length);
		
		const value_change = value.substr(0, value.length - 1).replace("-", "");
		const values = [];
		
		//const values = Array.from(value.substr(0, value.length - 1).replace("-", ""), function(x) {return Number(x)});
		for(let i = 0; i<value_change.length ; i++){
			values.push(value_change.substr(i, 1));
		}
		// values 리스트와 checker 리스트의 같은 index에 위치한 수끼리 곱하고 해당 숫자들을 모두 더한 값
		const sum = (values.map(function(x, i) {return x * checker[i]})).reduce(function(a, b) {return a + b});
		let result = (11 - sum % 11) % 10;
		
		if (values[6] > 4) { // 외국인일경우
			if (result > 10) {
				result -= 10;
			}

			result += 2;

			if (result > 10) {
				result -= 10;
			}
		}
		
		if (result != lastValue) {
			alert("올바른 주민번호를 입력해주세요.");
			return false;
		}
	}
	fnSubmit(res_no1,res_no2);
}

function fnSubmit(res_no1,res_no2){
	document.frm.res_no.value = res_no1+"-"+res_no2;
	document.frm.submit();
}

</script>
<!-- action="/rad/question/confirmAuthenticCode" -->
<form method="post" name="frm" action="${pageContext.request.contextPath}/certify/KHAcademy/confirmAuthenticCode.kh">
	<input type="hidden" id="res_no" name="res_no"/>
	<input type="hidden" name="authenticCode" value="${params.authenticCode}"/>
	<input type="hidden" name="result" value="${result}"/>
</form>
</body>
</html>