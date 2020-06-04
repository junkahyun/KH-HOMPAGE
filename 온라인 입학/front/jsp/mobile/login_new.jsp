<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="/WEB-INF/tlds/c.tld" %> 
<%@ taglib prefix="fn" 		uri="/WEB-INF/tlds/fn.tld" %>
<%@ page import="com.kh.common.LoginConstants"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
</style>
</head>
<body>
<div class="login_wrapper">
	<div class="login_wrapper_in">
		<div class="sub_top sub_box">
			<div class="back_btn" onClick="location.href='${pageContext.request.contextPath}/mobile2017/main.kh'">
				<img src="${pageContext.request.contextPath}/app/images/sub/sub_back_btn.png" alt="뒤로가기버튼" />
			</div>
			<h1 class="title">로그인</h1>
		</div><!-- //sub_top -->
			<div class="login_content">
				<div class="login_visual">
					<img src="${pageContext.request.contextPath}/app/images/login/login_bg.jpg" alt="로그인페이지 이미지" />
				</div><!-- //login_visual -->
			<div class="login_content_bottom">
					<!-- <div class="login_radio_box">
						<input type="radio" id="member_flag_studnet" name="member_flag" checked="checked" value="T">
						<label for="member_flag_studnet">수강생</label>
						<input type="radio" id="member_flag_normal" name="member_flag" value="U">
						<label for="member_flag_normal">일반회원</label>
					</div> --><!-- //login_radio_box -->
				<div class="login_input_box">
					<div class="login_input_id">
						<input type="text" id="id" name="id" style="color:#9797a7;" placeholder="KH_id">
						<input type="password" id="password" name="password" style="color:#9797a7; margin-top:-1%;" placeholder="password">
					</div>
				<!-- 	<div class="find_wrapper">
						<div class="sub_find_box" style="border-top:0px; margin-top:0%; padding: 4% 6% 0% 0%;">
							<div class="sub_find_radio_box">
								<input type="radio" id="member_flag_studnet" name="member_flag" checked="checked" value="T">
								<label for="member_flag_studnet">수강생</label>
								<input type="radio" id="member_flag_normal" name="member_flag" value="U">
								<label for="member_flag_normal">일반회원</label>
							</div>
						</div>
					</div> -->
					<div class="login_auto">
						<p>자동로그인</p>
						<input type="checkbox" id="auto_login">
					</div>					
				</div><!-- //login_input_box -->
			<div class="login_btn">
				<p onclick="javascript:fnLogin();">로그인</p>
			</div>
			
			<div class="login_find">
				<p><a onclick="location.href='${pageContext.request.contextPath}/app/findAccount.mkh?mode=id'">아이디 · 비번찾기</a>&nbsp/&nbsp<a id="join_btn">회원가입</a></p>
			</div>
			</div><!-- //login_content_bottom -->
		</div><!-- //login_content -->
	</div><!-- //login_wrapper_in-->
</div><!-- //login_wrapper -->
</body>

<script type="text/javascript">

$(document).ready(function(){
	$('.login_wrapper').css({'height':window.innerHeight});
	
	$("#id").bind('keydown', function (e) {
	    if(e.keyCode === 13){
	    	$("#password").focus();
	    }
	});
	$("#password").bind('keydown', function (e) {
	    if(e.keyCode === 13){
	    	fnLogin();
	    }
	});
});


var FINISH_INTERVAL_TIME = 2000;
var backPressedTime = 0;

//Wait for PhoneGap to load
//
document.addEventListener("deviceready", onDeviceReady, false);

//PhoneGap is loaded and it is now safe to make calls PhoneGap methods
function onDeviceReady() { 
	document.addEventListener("backbutton", onBackKeyDown, false);
}

function onBackKeyDown() {
	console.log("BackPressed");
	
	var tempTime = new Date().getTime();
	var intervalTime = tempTime - backPressedTime;

	/* if (0 <= intervalTime && FINISH_INTERVAL_TIME >= intervalTime) {
		navigator.app.exitApp();
	} else {
		backPressedTime = tempTime;
		$.toast({
		    //heading: 'Information',
		    text: "\'뒤로\'버튼 한번 더 누르시면 종료됩니다.", 
		    icon: 'info',
		    loader: false,        		// Change it to false to disable loader
		    loaderBg: '#666666',  		// To change the background
		    textColor : '#fff',         // text color
		    bgColor : '#666666',        // Background color for toast
		    allowToastClose : false,    // Show the close button or not
			hideAfter : 2000,           // `false` to make it sticky or time in miliseconds to hide after
			stack : false,                  // `false` to show one stack at a time count showing the number of toasts that can be shown at once
	    	position : {
	        	left: 60,
	            top: 570
	        }     // bottom-left or bottom-right or bottom-center or top-left or top-right or top-center or mid-center or an object representing the left, right, top, bottom values to position the toast on page
		})
	} */
}

function fnLogin(){
	
	if(f_validate()) {
		var auto_check = document.getElementById("auto_login");
		var password = document.getElementById("password").value;
		var sha256_pass = SHA256(password);

		// 해당 부분은 본래 네이티브단의 암호화 로직과 맞추기 위해 encryptPasswordToMobile를 사용했으나
		// 홈페이지 모바일페이지를 통해 접속하는 페이지를 개발하면서 사용할 수 없게 되었음.
		// 2019-08-13

		// 비밀번호 맨앞에 숫자 1이 올 경우 JS로 변환하면 결과값 맨 앞에 0이 추가로 붙게된다.
		// 때문에 JAVA와 맞추기 위해 맨 앞자리를 제거한다.
		if(password[0] == '1') {
			sha256_pass = sha256_pass.substring(1);
		}
		//var member_flag1 = $('input[name=member_flag]:checked').val();
		var	params	= {
			id 			: $('#id').val(),
			password	: password/*,
			member_flag	: $('input[name=member_flag]:checked').val() ,
			auto_check : autoChk1 */
		};
		
		$.ajax({
			url		: '${pageContext.request.contextPath}/app/loginCheck.mkh',
			dataType	: 'json',
			type		: 'post',
			data		: params,
			success		: function (data, textStatus) {
				if (data['result'] == '<%=LoginConstants.SUCCESS%>') {
					location.href="${pageContext.request.contextPath}/app/main.mkh";					
				}
				else if(data['result'] == '<%=LoginConstants.INVALID_ID%>') {
					alert(data['message']);
				} 
				else if(data['result'] == '<%=LoginConstants.INVALID_PASSWORD%>') {
					alert(data['message']);
				} 
				else {
					alert("로그인에 실패했습니다.");
				}
			}, 
			error		: function (jqXHR, textStatus, errorThrown) {
				alert('오류가 발생했습니다\n[' + textStatus + ']\n' + errorThrown);
			}
		});
	}
}

function f_validate() {
	if($("#id").val()==null||$("#id").val()==""){
		alert('아이디를 입력해주세요.');
		document.getElementById("id").focus();
		return false;
	}
	if($("#password").val()==null||$("#password").val()==""){
		alert('비밀번호를 입력해주세요.');
		document.getElementById("password").focus();
		return false;
	}
	return true;
}

function f_login() {
	if(event.keyCode != 13) {
		return false;
	} else {
		fnLogin();
	}
}
const join_btn = document.getElementById('join_btn');
/* 회원가입 버튼 클릭시 회원가입 페이지로 이동 */
join_btn.addEventListener('click',function(){
	window.location.href = '${pageContext.request.contextPath}/app/joinMemberStepOne.mkh';
})
</script>

</html>