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
<script type="text/javascript">
String.prototype.replaceAll = function(str1, str2) {
	var temp_str = this.trim();
	temp_str = temp_str.replace(eval("/" + str1 + "/gi"), str2);
	return temp_str; 
}
var now = new Date();

jQuery(function(){
	fnOnMenu(7, 2);
	var month = now.getMonth()+1;
	var date = now.getDate();

	now = now.getFullYear()+"";
	if(month<10) now += "0"+month;
	else now+=month;
	if(date<10) now += "0"+date;
	else now+=date;
	
	fnLayerOpen('popup_survey');
	
	$(".popup_layer_bg").click(function(){
		$("#popup_survey").fadeOut(200);	
	});
});

function fnGetSurvey(curr_no){
	var params = {
		password	: $("#password").val()
	};

	$.ajax({
		  url		: '${pageContext.request.contextPath}/login/checkSurvey.kh'
		, data		: params
		, dataType	: 'json'
		, type		: 'get'
		, success	: function(data, textStatus){
			var degree = 0;

			if (data.flag == 0) {
				$(".popup_survey_error").text("해당되는 강의가 존재하지 않습니다.");
			}
			else if (data.flag == 2) { 
				$(".popup_survey_error").text("해당되는 과정을 선택해주세요.");
				
				var currList = '';
				for (var i = 0; i < data.currList.length; i++) {
					currList = '<div class="popup_survey_list"><a href="javascript:fnChange(' + data.currList[i].no + ')">' + data.currList[i].curr_name + '</a></div>';
					$(".popup_survey_error").append(currList);
				}
			}
			else if (data.flag == 1) {
				degree = getDegree(data);
				getSurvey(data.currList[0], degree);
			}
		}
		, error		: function(jqXHR, textStatus, errorThrown){
			alert('오류가 발생했습니다\n[' + textStatus + ']\n' + errorThrown);
		}
	});
}
function getDegree(data){
	$("#research_count > ul > li").removeClass();
	
	if (data.degree_first == 0) {
		$("#research_count > ul > li:nth-child(1)").addClass("select");
		return 1;
	}
	
	$("#research_count > ul > li:nth-child(1)").addClass("end");
	
	if (data.degree_second == 0) {
		$("#research_count > ul > li:nth-child(2)").addClass("select");
		$("#research_count > ul > li.end > a").css({"color": "#6d6e72"});
		return 2;
	}
	
	$("#research_count > ul > li:nth-child(2)").addClass("end");
	
	if (data.degree_third == 0) {
		$("#research_count > ul > li:nth-child(3)").addClass("select");
		$("#research_count > ul > li.end > a").css({"color": "#6d6e72"});
		return 3;
	}
}

function getSurvey(curr, degree){
	var survey_template = curr.survey_template.split("_");
	var params = {
		password    : $("#password").val(),
		degree      : degree,
		curr_no     : curr.no,
		curr_name   : curr.curr_name,
		survey_template  : survey_template[degree - 1]
	};

	$.ajax({
		url		: '${pageContext.request.contextPath}/login/checkSurveyFrm.kh'
		, data		: params
		, dataType	: 'html'
		, type		: 'post'
		, success	: function(data, textStatus){
			$("#research_second").html(data);
			fnLayerClose();
		}
	});
}

function fnChangeEnter(){
	if(event.keyCode==13) fnChange();
}
</script>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/common/top.jsp"/>
<div class="popup_layer" id="popup_survey">
	<div class="popup_layer_bg"></div>
	<div class="popup_layer_cont">
		<div class="popup_head">
			<span>학생설문조사 - 비밀번호</span>
			<a href="javascript:fnLayerClose();">&nbsp;</a>
		</div>
		<div class="popup_cont">
			<div class="popup_survey_text">설문조사 비밀번호를 입력해주세요.</div>
			<div class="popup_survey_pass">
				<input type="password" id="password" name="password" onkeydown="fnChangeEnter();"> 
			</div>
			<div class="popup_survey_error" style="margin-bottom:30px;"></div>
			
			<a href="javascript:fnGetSurvey();">확인</a>
		</div>
	</div>
</div>
		
<div id="content_sub" onmouseover="fnPrevDept();">
	<div id="content_sub_wrap">
		<jsp:include page="/WEB-INF/jsp/login/left.jsp"/>
		<div id="content_right">
			<div class="subject">
				<span>학생설문조사</span>
				<p><img src="${pageContext.request.contextPath}/resources/images/common/point_home.jpg"><img src="${pageContext.request.contextPath}/resources/images/common/point_depth.jpg">마이페이지<img src="${pageContext.request.contextPath}/resources/images/common/point_depth.jpg">학생설문조사</p>
			</div>
			<div class="content_visual" style="background: url('${pageContext.request.contextPath}/resources/images/sub07/sub07_01_img01.jpg'); background-repeat: no-repeat; background-position: bottom;">
				<p class="subject_comment">반갑습니다. KH정보교육원에 오신걸 환영합니다.</p>
				<p class="subject_subcomment">Research</p>
			</div>
			<div id="login">
				<p class="login_title">
					<span>KH정보교육원에서는 보다 나은 서비스 제공을 위해 설문조사를 실시하고 있습니다.</span>
					본 설문조사는 개인정보 이용에 관한 법률에 의거하여 교육서비스 개선 이외에는 사용하지 않습니다.<br>
					설문조사를 토대로 더 좋은 교육환경을 제공하는 KH정보교육원이 되도록 노력하겠습니다.
				</p>
				<div id="research_count">
					<ul>
						<li><a>1차 설문조사</a></li>
						<li><a>2차 설문조사</a></li>
						<li style="margin-right:0;"><a>3차 설문조사</a></li>
					</ul>
				</div>
				<div id="research_second">
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/jsp/common/right.jsp"/>
</div>
<jsp:include page="/WEB-INF/jsp/common/bottom.jsp"/>
</body>
</html>
