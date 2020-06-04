<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="/WEB-INF/tlds/c.tld" %> 
<%@ taglib prefix="fn" 		uri="/WEB-INF/tlds/fn.tld" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
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
			<p class="meNual">주민번호 이용에 대한 안내</p>
			<p class="one_Chance">주민번호는 HRD 등록 시 1회만 이용되며 등록 즉시 파기됩니다.</p>
			<div class="Number"><input type="text" id="res_no1" maxlength="6">&nbsp;&nbsp;-&nbsp;&nbsp;<input type="text" id="res_no2" maxlength="7"></div>
			<div class="send_Btn" onclick="fnValidate();">
				<button>전송</button>
			</div>
		</div><!--//menual_visual-->
		</c:if>
		<!-- url에 사용자가 수정을 한경우 -->
		<c:if test="${result == 0 || result == -1 || result == -2}">
		<div class="meNual_visual">
			<p class="meNual" style="margin-bottom: 20px;">오류 발생!</p>
			<p class="one_Chance" style="margin-bottom: 40px;">잘못된 경로로 접근하였습니다.</p>
			<div class="send_Btn" onclick="javascript:window.close();">
				<button>이전페이지로 돌아가기</button>
			</div>
		</div><!--//menual_visual-->
		</c:if>
	<p class="Copyright">Copyright © KHIEI</p>
	</div><!--//Wrap_in-->
</div><!--//Wrap-->
<script>
(function(){
	if('${result}' === "0" || '${result}' === "-1" || '${result}' === "-2"){
		alert('만료되었거나, 접속 불가능한 링크입니다.');
		window.close();
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
			values.push(value_change.substr(i, 1 ));
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
};

function fnSubmit(res_no1,res_no2){
	document.frm.res_no.value = res_no1+"-"+res_no2;
	document.frm.submit();
}

</script>
<!-- action="/rad/question/confirmAuthenticCode" -->
<form method="post" name="frm" action="${pageContext.request.contextPath}/certify/KHAcademy/confirmAuthenticCode.kh">
	<input type="hidden" id="res_no" name="res_no" />
	<input type="hidden" name="authenticCode" value="${params.authenticCode}"/>
	<input type="hidden" name="result" value="${result}"/>
</form>
</body>
</html>