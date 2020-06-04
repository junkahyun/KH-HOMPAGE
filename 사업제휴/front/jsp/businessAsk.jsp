<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="/WEB-INF/tlds/c.tld" %> 
<%@ taglib prefix="fn" 		uri="/WEB-INF/tlds/fn.tld" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>KH정보교육원 - 사업제휴</title>
<jsp:include page="/WEB-INF/jsp/common/meta.jsp"/>
<script type="text/javascript">
jQuery(function(){
	fnOnMenu(1, 4);
	//$("#thum_img").hide();
});
function multiFileUploadAction(){
	$("#thum_img").trigger("click");
}

function fnInsertBusiness() {
	var n = 0;
	$(".join_hidden").hide();
	
	/* if($('.file_hidden').val() == ""){
		$("#alert_thum_imgs").css("display", "block");
		$("#company").focus();
		n=1;
	} */
	
	if($("#company").val()==null || $("#company").val()=="") {
		$("#alert_company").css("display", "block");
		$("#company").focus();
		n=1;
	}
	
	if($("#title").val()==null || $("#title").val()=="") {
		$("#alert_title").css("display", "block");
		$("#title").focus();
		n=1;
	}
	
	if($("#manager_name").val()==null || $("#manager_name").val()=="") {
		$("#alert_manager_name").css("display", "block");
		$("#name").focus();
		n=1;
	}
	
	if($("#contents").val()==null || $("#contents").val()=="") {
		$("#alert_contents").css("display", "block");
		$("#contents").focus();
		n=1;
	}
	
	if($("#categorys").val()==null || $("#categorys").val()=="") {
		$("#alert_categorys").css("display", "block");
		n=1;
	}
	
	if($.trim($($('#mobile1')).val()) == '' || $.trim($($('#mobile2')).val()) == '' || $.trim($($('#mobile3')).val()) == '') {
		$("#alert_mobile_null").css("display", "block");
		n=1;
	} else {
		if(!isPhoneNumber1($('#mobile1').val(), 2)){
			$("#alert_mobile_check").css("display", "block");
			document.getElementById("mobile1").focus();
			n=1;
		}
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
	
	if(n!=0) {return;}
	var frm = document.frm;
	frm.category.value = $("#categorys option:selected").val();
	frm.mobile.value = $("#mobile1").val() +"-"+ $("#mobile2").val() +"-"+ $("#mobile3").val();
	frm.email.value = ($("#email1").val() + "@" + $("#email2").val()); 
	frm.submit();
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
</script>
<style>
.file_hidden { width: 88px; height: 25px; position: absolute; top:5px; right: 100px; z-index: 99; opacity: 0; filter: alpha(opacity=0); -ms-filter: "alpha(opacity=0)"; -khtml-opacity: 0; -moz-opacity: 0; }
.file_btn { height: 25px; line-height: 27px; color: #FFFFFF; background: #283442; border: 0; width:78px; margin-left:5px;float:left; }
</style>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/common/top.jsp"/>
<div id="content_sub" onmouseover="fnPrevDept();">
	<div id="content_sub_wrap">
		<jsp:include page="/WEB-INF/jsp/intro/left.jsp"/>
		<div id="content_right">
			<div class="subject">
				<span>사업제휴</span>
				<p><img src="${pageContext.request.contextPath}/resources/images/common/point_home.jpg"><img src="${pageContext.request.contextPath}/resources/images/common/point_depth.jpg">교육원소개<img src="${pageContext.request.contextPath}/resources/images/common/point_depth.jpg">사업제휴</p>
			</div>
			<div class="content_visual" style="background: url('${pageContext.request.contextPath}/resources/images/sub05/sub01_08_img01.jpg'); background-repeat: no-repeat; background-position: bottom;">
				<p class="subject_comment">KH정보교육원의 올바른 교육철학과 노하우가 함께합니다.</p>
				<p class="subject_subcomment">Business<br>Partnership</p>
			</div>
			<p class="recruit_title">
				<span>KH정보교육원은 참교육 실천 및 다양한 컨텐츠개발을 통한 국내 IT교육의 발전을 위하여 각 분야 <br>
				        개인, 기업, 단체 등의 소중한 제안을 기다리고 있습니다.</span>
				제휴구분 : 산학협력, 교육서비스제휴, 마케팅제휴, 공익사업제안, 4차산업제안, 기타제안 등<br>
				<span style="color: tomato; font-size: 13px;">(제휴담당자 전화번호: 02-6952-0548)</span>
			</p>
			<form name="frm" id="frm" enctype="multipart/form-data" method="post" action="${pageContext.request.contextPath}/intro/insertBusinessAsk.kh">
			<table id="recruit" cellpadding="0" cellspacing="0">
				<tr>
					<th>구분</th>
					<td>
					<input type="hidden" name="category" id="category"/>
					<input type="hidden" name="mobile" id="mobile"/>
					<input type="hidden" name="email" id="email"/>
					<select style="width: 100px;" id="categorys" >
						<option value="">제안구분</option>
						<option value="산학협력">산학협력</option>
						<option value="교육서비스">교육서비스</option>
						<option value="마케팅제휴">마케팅제휴</option>
						<option value="공익사업">공익사업</option>
						<option value="4차산업제안">4차산업제안</option>
						<option value="기타제안">기타제안</option>
					</select>
					<span class="join_hidden" id="alert_categorys">구분을 선택해주세요</span>
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td><input type="text" id="title" name="title" style="width: 230px;"><span class="join_hidden" id="alert_title">제목을 입력해주세요.</span></td>
				</tr>
				<tr>
					<th>회사명</th>
					<td>
						<input type="text" id="company" name="company" style="width: 230px;"><span class="join_hidden" id="alert_company">회사명을 입력해주세요.</span>
						
					</td>
				</tr>
				<tr>
					<th>담당자명</th>
					<td>
						<input type="text" id="manager_name" name="manager_name" style="width: 230px;"><span class="join_hidden" id="alert_manager_name">담당자명을 입력해주세요.</span>
					</td>
				</tr>
				<tr>
					<th>연락처</th>
					<td>
						<input type="text" id="mobile1" maxlength="3" style="width: 85px;" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');"> - 
						<input type="text" id="mobile2" maxlength="4" style="width: 85px;" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');"> -
						<input type="text" id="mobile3" maxlength="4" style="width: 85px;" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');">
						<span class="join_hidden" id="alert_mobile_null">필수입력사항입니다.</span>
						<span class="join_hidden" id="alert_mobile_check">정확한 연락처를 입력해주세요.</span>
					</td>
				</tr>
				<tr>
					<th>E-MAIL</th>
					<td>
						<input type="text" id="email1"  style="width: 140px;" > @ 
						<input type="text" id="email2"  style="width: 130px;">
						<select id="email_select" style="width: 140px;" onchange="fnChangeEmail();">
							<option value="">직접입력</option>
							<option value="naver.com">naver.com</option>
							<option value="daum.net">daum.net</option>
							<option value="hanmail.net">hanmail.net</option>
							<option value="nate.com">nate.com</option>
							<option value="gmail.com">gmail.com</option>
						</select>
						<span class="join_hidden" id="alert_email_null">필수입력사항입니다.</span>
						<span class="join_hidden" id="alert_email_check">정확한 이메일 주소를 입력해주세요.</span>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea rows="" cols="" style="width: 98%; height: 150px; border: 1px solid #ececec;" id="contents" name="contents"></textarea>
						<span class="join_hidden" id="alert_contents">내용을 입력해주세요.</span>
					</td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td style="position: relative;">
					<div style="width: 390px;height:23px;color:#1a1a1a;border:1px solid #ececec;float: left;">
						<input type="text" id="thum_img_text" name="thum_img" disabled="disabled" class="int" value="" style="width: 378px; color: black; background: #fff; border: 0px;">
					</div>
					<input type="file" id="thum_img" name="thum_img" class="file_hidden int" onchange="javacript:document.getElementById('thum_img_text').value=this.value" style="top:8px;">
					<input type="button" class="file_btn" value="찾기">
					</td>
				</tr>
			</table>
			<input type="hidden" value="hannju@hanmail.net " id="testemail" name="testemail" placeholder="테스트용 이메일"/>
			</form>
			<div id="recruit_button" >
				<a href="javascript:fnInsertBusiness();" style="width: 160px;">사업제휴 신청하기</a>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/jsp/common/right.jsp"/>
</div>
<jsp:include page="/WEB-INF/jsp/common/bottom.jsp"/>
</body>
</html>