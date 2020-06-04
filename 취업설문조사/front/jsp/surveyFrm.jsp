<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="/WEB-INF/tlds/c.tld" %> 
<%@ taglib prefix="fn" 		uri="/WEB-INF/tlds/fn.tld" %>
<%@ taglib prefix="fmt"		uri="/WEB-INF/tlds/fmt.tld" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/survey/surveyAppend.js"></script>
<c:if test="${result!=0}">
	<p class="research_title">${degree}차 설문조사</p>
	<div class="bar"></div>
	<div class="research_question">
		<c:forEach var="data" items="${data}" varStatus="vs">
			<!-- 질문제목 -->
			<p>${vs.count}. ${data.question}</p>
			<c:if test="${data.answer != '0'}">
				<ul id="q${vs.count}" class="multiple">
					<!-- 질문답변 -->
					<c:forEach var="aList" items="${data.aList}" varStatus="vqa"> 
						<li>
							<c:if test="${data.direct_input != 2}"> 
							<input type="radio" id="q${vs.count}_a${vqa.count}" name="q${vs.count}" class="multiple" value="${vqa.count}">
							</c:if>
							<c:if test="${data.direct_input == 2}"> 
							<input type="radio" id="q${vs.count}_a${vqa.count}" name="q${vs.count}" onClick="direct2Check('q${vs.count}_a_cont', '${vqa.count}')" class="multiple" value="${vqa.count}">
							</c:if>
							<label for="q${vs.count}_a${vqa.count}">
								${aList.answer}
								<c:if test="${vqa.last && data.direct_input == 1}"> 
									<input type="text" id="q${vs.count}_a_cont" style="width:600px;">
								</c:if>
							</label>
						</li>
						<c:if test="${vqa.last && data.direct_input == 2}"> 
							<div style="padding-bottom: 0px;"><textarea rows="" cols="" id="q${vs.count}_a_cont" style="display:none;"></textarea></div>
						</c:if>
					</c:forEach>
				</ul>
			</c:if>
			<c:if test="${data.answer == '0'}">
				<div id="q${vs.count}" class="single"><textarea rows="" cols="" id="q${vs.count}_a_cont"></textarea></div>
			</c:if>
		</c:forEach>
	</div>
	<div class="question_ok">
		<a onClick="fnCheck();">설문조사완료</a>
	</div>

	<script type="text/javascript">
		function direct2Check(input_id, count) {
			if (count < 4) {
				$("#" + input_id).hide();
			} else {
				$("#" + input_id).show();
			}
		}
		
		function fnSubmit(result){
			var params = {
					  curr_no		: '${curr_no}'
					, password      : '${password}'
					, degree		: '${degree}'
					, token			: '${token}'
					, classify      : ""
					, result		: result
				}
				
				$.ajax({
					url			: '${pageContext.request.contextPath}/login/saveSurvey.kh'
					, data			: params
					, dataType		: 'json'
					, type			: 'post'
					, async         : false
					, success		: function(data, textStatus){
						if(data['result']=='1'){
							var html = "<div class='result'><p class='title'>설문조사가 완료되었습니다.</p><p class='info'>감사합니다.</p><a href='${pageContext.request.contextPath}/login/survey.kh'>확인</a></div>";
							$("#login").html(html);
							scrollTo(0, 216);				
						} else if(data['result']=='2'){
							alert('이미 해당 설문번호로 등록되었습니다. 다른 PC로 참여해주십시오.');
						}
					}
					, error		: function(jqXHR, textStatus, errorThrown){
						alert('오류가 발생했습니다\n[' + textStatus + ']\n' + errorThrown);
					}
				});
		}

		function fnCheck(){
			var result = "";
			var i = 1;
			var count = '${data_length}'; //질문 갯수
			
			/* 2020. 04. 28 리팩토링 */
			/* surveyAppend.js 참고 */
			result = appendResult(result, count, i);
		
			if(result !== true && result !== ''){
				fnSubmit(result);
			}
		}
	</script>
</c:if>

<c:if test="${result==0}">
	<script type="text/javascript">
		jQuery(function(){
			alert("비밀번호가 일치하지 않습니다.");
		});
	</script>
</c:if>
