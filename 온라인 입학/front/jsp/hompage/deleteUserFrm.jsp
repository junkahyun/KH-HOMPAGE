<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="/WEB-INF/tlds/c.tld" %> 
<%@ taglib prefix="fn" 		uri="/WEB-INF/tlds/fn.tld" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>KH정보교육원 - 회원가입</title>
<jsp:include page="/WEB-INF/jsp/common/meta.jsp"/>
<script type="text/javascript">
var idCheck = false;
var member_flag = '${userinfo.member_flag}';
jQuery(function(){
	
	$('#member_flag_studnet').val(member_flag);
	
	if(member_flag === 'T' || member_flag === 'P'){
		fnOnMenu(7, 4);	
	}	
	if(member_flag !== 'T' && member_flag !== 'P'){
		fnOnMenu(7, 2);	
	}	
	
	$(":radio[value='${userinfo.member_flag}']").attr("checked", "checked");
});

/**
 * 입력값 점검
 */
function f_validate() {
	let course = '${userinfo.course}';
	if($('#password').val()==null || $('#password').val()=="") {
		$("#alert_pw").css("display", "block");
		return false;
	}
	
	if(course === '수강'){
		alert('수강생으로 등록이 완료된 경우에는 탈퇴가 불가능합니다.');
		return false;
	}
	
	return true;
}

function fnDeleteUser() {
	if (f_validate()) {
		if(confirm('회원탈퇴를 진행하시겠습니까?') === true){
			var	params	= {
					  id			: $('#id').val()
					, password		: $("#password").val()
					, flag			: '${userinfo.member_flag}'
					, no            : '${userinfo.stdt_no}'
					, course        : '${userinfo.course}'
			};
				
			$.ajax({
				url			: '${pageContext.request.contextPath}/login/deleteUser.kh',		
				dataType	: 'json',
				type		: 'post',
				data		: params,
				success		: function (data, textStatus) {
					if(data['result']==0){
						$("#alert_fail").css("display", "block");
					} else {
						alert(data.message);
						location.href='${pageContext.request.contextPath}/login/deleteUserResult.kh';
					}
				},
				error		: function (jqXHR, textStatus, errorThrown) {
					alert('오류가 발생했습니다\n[' + textStatus + ']\n' + errorThrown);
				}
			});
		}
		else{
			return;
		}
	}
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
				<span>회원탈퇴</span>
				<p><img src="${pageContext.request.contextPath}/resources/images/common/point_home.jpg"><img src="${pageContext.request.contextPath}/resources/images/common/point_depth.jpg">마이페이지<img src="${pageContext.request.contextPath}/resources/images/common/point_depth.jpg">회원탈퇴</p>
			</div>
			<div class="content_visual" style="background: url('${pageContext.request.contextPath}/resources/images/sub07/sub07_01_img01.jpg'); background-repeat: no-repeat; background-position: bottom;">
				<p class="subject_comment">반갑습니다. KH정보교육원에 오신걸 환영합니다.</p>
				<p class="subject_subcomment">Membership</p>
			</div>
			<div id="login">
				<p class="login_title">
					<span>KH정보교육원 회원탈퇴 안내입니다.</span>
					회원탈퇴시 모든 정보가 삭제되오니 신중하게 탈퇴 신청을 해주시기 바랍니다.<br>
					회원님의 정보보호를 위해 비밀번호를 다시한번 입력해주시기 바랍니다.
				</p>
				<div id="join_frm">
					<div class="bar"></div>
					<p class="join_title">회원정보확인</p>
					<table class="join_table" cellpadding="0" cellspacing="0">
						<tr>
							<th>회원 구분</th>
							<td>
								${userinfo.member_flag == 'T' || userinfo.member_flag == 'P' ?'수강생':'일반회원'}
							</td>
						</tr>
						<tr>
							<th>이름</th>
							<td><input type="text" id="name" name="name" value="${userinfo.name}" readonly="readonly"></td>
						</tr>
						<tr>
							<th>아이디</th>
							<td><input type="text" id="id" name="id" value="${userinfo.id}" readonly="readonly"></td>
						</tr>
						<tr>
							<th>비밀번호 확인</th>
							<td><input type="password" id="password" name="password"><span class="join_hidden" id="alert_pw">비밀번호를 입력해주세요.</span><span class="join_hidden" id="alert_fail">회원정보가 일치하지 않습니다.</span></td>
						</tr>
					</table>
					<div class="join_ok">
						<a href="javascript:fnDeleteUser();">회원탈퇴</a>
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