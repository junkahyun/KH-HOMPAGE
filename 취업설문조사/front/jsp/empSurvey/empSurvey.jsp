<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="/WEB-INF/tlds/c.tld" %> 
<%@ taglib prefix="fn" 		uri="/WEB-INF/tlds/fn.tld" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>KH정보교육원 - 설문조사</title>
<jsp:include page="/WEB-INF/jsp/common/meta.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/eval.css?201912190721" />
<script type="text/javascript">
jQuery(function(){
	//상단 메뉴바 포커싱
	fnOnMenu(7);
	
	//설문조사 가져오는 함수
	getSurvey('${params.curr_no}', '${params.degree}');
});

/*
 * 설문조사 가져오는 함수
 */
function getSurvey(curr, degree){
	var params = {
		degree      : degree,
		curr_no     : curr,
		survey_template  : '${params.emp_template}',
		classify    : 'E'
	};

	$.ajax({
		url		: '${pageContext.request.contextPath}/login/checkEmpSurveyFrm.kh'
		, data		: params
		, dataType	: 'html'
		, type		: 'post'
		, success	: function(data, textStatus){
			$("#survey_form").html(data);
			fnLayerClose();
		}
	});
}
</script>
</head>
<body>
<body>
		<jsp:include page="/WEB-INF/jsp/common/top.jsp"/>

		<div id="content_sub">
			<div id="content_sub_wrap">
				<div class="myinfo_wrap" style="overflow:initial;">
					<div id="left_nav_e">
						<div class="left_subject_e left_subject_s">
							<ul>
								<li class="name">${sessionScope.USER.name}</li><!-- 이름 -->
								<li class="class">${cData.pass_currname }</li><!-- 과정명&회차 --><!--  1회차 -->
								<li class="classroom">[${cData.branch} ${cData.classroom}] ${cData.begin_time} ~ ${cData.end_time}</li><!-- 강의장 (오전, 오후) -->
								<li>${cData.prof} 강사님 | ${cData.e_charge} 취업담임</li><!-- 강사님 성함 -->
								<li>${cData.begin_date } ~ ${cData.end_date }</li><!-- 개강날짜~종강날짜 -->
							</ul>
						</div>
						<!--//left_subject_e-->
					</div>
					<!--//left_nav_e-->
					<!--right_nav_survey-->
					<div id="right_nav_survey">
						<div class="right_table">
							<div class="survey_form" id="survey_form">
								<!--설문조사 내용-->
							</div>
							<!--//survey_form-->
						</div>
						<!--//right_nav_survey-->
					</div>
					<!--//myinfo_wrap-->
					<!--btn_wrap-->
					<div class="btn_wrap">
						<div class="submit_btn" onclick="fnCheck();">
							<a>제출</a>
						</div>
					</div>
					<!--//btn_wrap-->
				</div>
				<!--//content_sub_wrap-->
			</div>
			<!--//content_sub-->
		<jsp:include page="/WEB-INF/jsp/common/bottom2.jsp"/>
	</body>
</body>
</html>
