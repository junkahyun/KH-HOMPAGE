<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="/WEB-INF/tlds/c.tld" %> 
<%@ taglib prefix="fn" 		uri="/WEB-INF/tlds/fn.tld" %>
<%@ taglib prefix="fmt"		uri="/WEB-INF/tlds/fmt.tld" %>
<!DOCTYPE html >
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/resources/css/select.css" />
<style>
/* 필수 입력 항목 알림 */
.survey_tip{
	color: #ff554d;
	display: none;
}

#require_tip{
	text-align: right;
	padding-top: 10px;
}

.require_input{
    margin-left: 1px;
    color: #ff554d;
 	font-weight: 600; 	   
}


</style>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/select.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/survey/surveyAppend.js?202005270000000"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/survey/surveyLocation.js?202005270000000"></script>
<c:if test="${degree != 3}">
<table cellpadding="0" cellspacing="0">
<caption>취업설문조사${degree}차</caption>
	<thead>
		<tr>
			<th>
				<p class="title">${templateName.survey_name} (총 ${data_length}문항)</p>
			</th>
		</tr>
		<tr>
			<td id="require_tip_td" style="background-color: #ffffff; padding-top: 0px; padding-bottom: 10px;">
				<p id="require_tip"><span class="require_input">*</span> : 필수 입력사항 </p>
			</td>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="data" items="${data}" varStatus="qvs">
		<tr>
			<td class="survey_question">${qvs.count}. ${data.question}<span class="require_input">*</span></td>
		</tr>
		<%-- 답변항목이 주관식인 경우 --%>
		<c:if test="${data.answer == 0}">
		<tr class="single" id="q${qvs.count}">
			<td class="survey_answer">
				<textarea id="q${qvs.count}_a_cont"></textarea>
			</td>
		</tr>
		</c:if>
		<%-- 답변항목이 객관식인 경우 --%>
		<c:if test="${data.answer > 0}">
		<tr class="multiple" id="q${qvs.count}">
			<td class="survey_graph">
				<div class="graph_wrap">
					<div class="graph_list_edit" >
					<c:forEach var="aData" items="${data.aList}" varStatus="avs">
						<p><input type="radio" id="q${qvs.count}_a${avs.count}" name="q${qvs.count}" class="multiple" data-text="${aData.answer}" value="${avs.count}"/>${aData.answer}
						<%-- 답변 마지막 항목이 기타인 경우  --%>
						<c:if test="${avs.last && data.direct_input == 1}">
							<input type="text" class="etc_text" id="q${qvs.count}_a_cont" style="border:1px solid #ececec; height: 35px; width:90%; padding:0 5px; margin-left: 5px;"/>
						</c:if>
						</p>
					</c:forEach>
					</div>
				</div>
			</td>
		</tr>
		</c:if>
		</c:forEach>
	</tbody>
</table>
</c:if>

<c:if test="${degree == 3}">
<table cellpadding="0" cellspacing="0">
	<caption>취업설문조사${degree}차</caption>
	<thead>
		<tr>
			<th>
				<p class="title">${templateName.survey_name}</p>
			</th>
		</tr>
	</thead>
</table>

<p id="require_tip"><span class="require_input">*</span> : 필수 입력사항 </p>

<!-- 1.인적사항-->
<table cellpadding="0" cellspacing="0">
	<tbody>
		<tr>
			<td class="title_num num1">1. 인적사항</td>
		</tr>
		<table class="scrolltable std_information std_information1" cellpadding="0" cellspacing="0">
			<tbody>
				<tr>
					<th>학생명</th>
					<td>${sessionScope.USER.name}</td>
					<th>생년월일</th>
					<td>${fn:split(user.res_no,'-')[0]}</td>
				</tr>
				<tr>
					<th>휴대폰</th>
					<td>${user.mobile}</td>
					<th>이메일</th>
					<td>${user.email}</td>
				</tr>
				<tr>
					<th>주소</th>
					<td colspan="3">${fn:replace(user.address,'_',' ')}</td>
				</tr>
				<tr>
					<th >학교</th>
					<td>${fn:split(user.comaca,'_')[0]}</td>
					<th>전공</th>
					<td>${fn:split(user.comaca,'_')[1]}</td>
				</tr>
				<tr>
					<th>최종학력</th>
					<td>${user.academic}</td>
					<th>구분/졸업년도</th>
					<td>${fn:split(user.comaca,'_')[2]}(${user.graduation_date})</td>
				</tr>
				<tr>
					<th>자격증</th>
					<td colspan="3">${user.license}</td>
				</tr>
			</tbody>
		</table>
	</tbody>
</table>

<c:forEach var="data" items="${data}" varStatus="qvs">
<table cellpadding="0" cellspacing="0">
	<tbody>
		<tr>
			<td class="title_num">${qvs.count + 1 }. ${data.question} </td>
		</tr>
		<table class="scrolltable std_information std_information${qvs.count + 1}" cellpadding="0" cellspacing="0">
			<tbody>
				<%-- 카운트 세팅 --%>
				<c:set var="count" value="0"/>
				
				<c:if test="${data.question_form == '1'}">
					<!-- (설문조사 3차의 2번) 가능skill -->
					<c:if test="${qvs.count == 1}">
						<tr>
							<th style="width:120px;">구분</th>
							<th style="width:60%;">내용</th>
							<th>능력</th>
						</tr>	
					</c:if>
					
					<%-- (설문조사 3차의 3번) 취업관련 --%>
					<c:if test="${qvs.count == 2}">
						<tr>
							<th>질문</th>
							<th class="answer_th">답변 </th>
						</tr>
					</c:if>
					
				<c:if test="${qvs.count == 3}">
				<tr>
					<th style="width: 14%;">평가요소</th>
					<th>평가기준</th>
					<th colspan="3" style="width: 22%;">평가</th>
				</tr>
				</c:if>
				<c:forEach var="sList" items="${data.sList}" varStatus="bvs" >
				
				<%-- 1, 3번 문제인 경우 (설문조사 기준 2,4번) --%>
				<c:if test="${qvs.count != 2 && sList.question != '공인점수'}">
				<tr class="multiple" name="q${qvs.count}">  <!-- 구분 cell안의 첫번째 내용cell -->
					<td rowspan="${sList.count == 0 ? '' : sList.count}" 
						style="${qvs.count == 3 ? 'text-align: center;' : ''}"
						class="skill_title">						
						${sList.question}<c:if test="${sList.question != '외국어'}"><span class="require_input">*</span></c:if>
					</td>
					<%-- 문제 depth가 1 이상인 경우 --%>
					<c:if test="${sList.count > 0}">
						<c:forEach var="bList" items="${sList.bList}">
						<c:forEach var="bList1" items="${bList}" varStatus="bvs1" begin="0" end="0">
							<td class="skill_title" style="border-right: 1px solid #ececec;">${bList1.question}<br/>
							<c:set var="count_id" value="${count+1}"/>	
						<span id="q${qvs.count}_${count_id}" class="survey_tip">필수 선택 항목입니다.</span>
							</td>
							
							<%-- 답변 항목이 객관식/주관식인 경우 --%>
							<c:if test="${bList1.direct_input == 0}">
							<td>
								<c:set var="sum_count" value="${count+1}"/>
								<c:set var="count" value="${sum_count}"/>
								<c:forEach var="aList" items="${bList1.aList}" varStatus="avs" >
									<input type="radio" id="q${bList1.q_no}_a${avs.count}" name="q${qvs.count}_${count}" value="${aList.a_no}" class="multiple">&nbsp;${aList.answer}&nbsp;&nbsp;
								</c:forEach>
							</td>
							</c:if>
						</c:forEach>
						</c:forEach>
					</c:if> <%-- 문제 depth가 1 이상인 경우 끝 --%>
					
					<%-- 문제 depth가 1 이상이 아닌 경우 --%>
					<c:if test="${sList.count == 0 }">
					<c:if test="${sList.question != '외국어'}">
					<td colspan="2">
						<c:set var="sum_count" value="${count+1}"/>
						<c:set var="count" value="${sum_count}"/>
						<textarea id="q${qvs.count}_${count}" name="q${qvs.count}_${count}" class="single" placeholder="본인이 활용 가능한 보안솔루션 기입" 
						          cols="50" rows="2" style="width:100%; border-color:#ececec; float: left; padding: 10px; box-sizing: border-box; height:38px;"></textarea>
						<span id="sol${qvs.count}_${count}" class="survey_tip">필수 입력 항목입니다.</span>
					</td>
					</c:if>
					<c:if test="${sList.question == '외국어'}">
					<td style="border-right:1px solid #ececec">
						<c:set var="sum_count" value="${count+1}"/>
						<c:set var="count" value="${sum_count}"/>
						<textarea id="q${qvs.count}_${count}" name="q${qvs.count}_${count}" class="single"
						          placeholder="외국어 자격증명 입력" cols="50" rows="2" style="border-color:#ececec; padding:10px; box-sizing: border-box; height:38px;"></textarea>
					</td>
					<td>
						공인점수: <input type="text" id="q${qvs.count}_${count+1}" name="q${qvs.count}" class="single"
						                style=" outline:none; border:1px solid #ececec; width:54px; height:35px; padding-left: 5px; box-sizing: border-box;">
					</td> 
					</c:if>
					</c:if>
				</tr>
				
				<%-- 문제 depth가 1 이상인 경우 --%>
				<c:if test="${sList.count > 0}">
				<c:forEach var="bList" items="${sList.bList}">
				<c:forEach var="bList1" items="${bList}" varStatus="bvs1" begin="1" >
				<tr class="multiple" name="q${qvs.count}">
					
					<td class="skill_title" style="border-right: 1px solid #ececec;">${bList1.question} <br/>
						<c:set var="count_id" value="${count+1}"/>	
						<span id="q${qvs.count}_${count_id}" class="survey_tip">필수 선택 항목입니다.</span>
					</td>

					<%-- 답변 항목이 객관식/주관식인 경우 --%>
					<c:if test="${bList1.direct_input == 0}">
					<td>
						<c:set var="sum_count" value="${count+1}"/>
						<c:set var="count" value="${sum_count}"/>
						<c:forEach var="aList" items="${bList1.aList}" varStatus="avs" >
							<input type="radio" id="q${bList1.q_no}_a${avs.count}" name="q${qvs.count}_${count}" value="${aList.a_no}" class="multiple">&nbsp;${aList.answer}&nbsp;&nbsp;
						</c:forEach>
					</td>
					</c:if>
				</tr>
				</c:forEach>
				</c:forEach>
				</c:if>
				</c:if>
				<%-- 1, 3번 문제인 경우 (설문조사 기준 2,4번) 끝 --%>
				
				<%-- 2번 문제인경우 (설문조사 기준 3차 3번) --%>
				<c:if test="${qvs.count == 2}">
				
				<tr>
					<%-- 질문 --%>
					<td>${sList.question}<span class="require_input">*</span></td>
						
					<%-- 답변 항목이 select인 경우 --%>
					<c:if test="${sList.direct_input == 2}">
					<td colspan="${sList.count}">
						<ul>
							<c:forEach var="bList" items="${sList.bList}">
							<c:forEach var="bList1" items="${bList}" varStatus="bvs1" >
							<c:set var="sum_count" value="${count+1}"/>
							<c:set var="count" value="${sum_count}"/>							
							<li style="${sList.count != bvs1.count ? 'margin: 6px;' : ''}" >
							<span>${fn:split(bList1.question,'_')[0]}&nbsp;&nbsp;</span>	
							<c:if test="${sList.question != '희망 근무 지역'}">
								<select id="q${qvs.count}_${count}" name="q${qvs.count}" class="s_multiple" data-attribute="${sList.question}" style="width: 150px; height: 30px;">
									<c:forEach var="aList" items="${bList1.aList}" varStatus="avs" >
										<option value="${aList.a_no}">${aList.answer}</option>
									</c:forEach>
								</select>
							</c:if>
							<c:if test="${sList.question == '희망 근무 지역'}">
							<select id="q${qvs.count}_${count}_1" class="s_multiple" onchange="fnChangeLocation(this.value, this.id);"
							        style="width: 150px; height: 30px;">
						        <option value="">선택</option>
								<option value="전지역">전지역</option>
								<option value="서울특별시">서울특별시</option>
								<option value="부산광역시">부산광역시</option>
								<option value="대구광역시">대구광역시</option>
								<option value="인천광역시">인천광역시</option>
								<option value="광주광역시">광주광역시</option>
								<option value="대전광역시">대전광역시</option>
								<option value="울산광역시">울산광역시</option>
								<option value="세종특별자치시">세종특별자치시</option>
								<option value="경기도">경기도</option>
								<option value="강원도">강원도</option>
								<option value="충청북도">충청북도</option>
								<option value="충청남도">충청남도</option>
								<option value="전라북도">전라북도</option>
								<option value="전라남도">전라남도</option>
								<option value="경상북도">경상북도</option>
								<option value="경상남도">경상남도</option>
								<option value="제주특별자치도">제주특별자치도</option>
							</select>
							<select id="q${qvs.count}_${count}_2" class="s_multiple" name="types" 
							        style="width: 150px; height: 30px;" onchange="fnPutLocation(this.value, this.id);">
								<option value="" id="q${qvs.count}_${count}_3">선택</option>
							</select><br/>
							<span id="tip${qvs.count}_${count}_2" class="survey_tip">필수 선택 항목입니다.</span>
							<input type="hidden" id="q${qvs.count}_${count}" name="q${qvs.count}" data-attribute="${sList.question}" class="s_multiple"/>
							</c:if>
							&nbsp;&nbsp;${fn:split(bList1.question,'_')[1]}<br/>
							</li>
							</c:forEach>
							</c:forEach>
						</ul>
					</td>
					</c:if>
					<%-- 답변 항목이 객관식/주관식인 경우 --%>
					<c:if test="${sList.direct_input == 0}">
					<td name="q${qvs.count}">
						<c:set var="sum_count" value="${count+1}"/>
						<c:set var="count" value="${sum_count}"/>
						<c:forEach var="bList" items="${sList.bList}">
						<c:forEach var="bList1" items="${bList}" varStatus="bvs1" >
						<c:forEach var="aList" items="${bList1.aList}" varStatus="avs" >
							<input type="radio" id="q${bList1.q_no}_a${avs.count}" name="q${qvs.count}_${count}" class="multiple" data-attribute="${sList.question}" value="${aList.a_no}">&nbsp;${aList.answer}&nbsp;&nbsp;
						</c:forEach>
						<span id="q${qvs.count}_${count}" class="survey_tip">필수 선택 항목입니다.</span>
						</c:forEach>
						</c:forEach>
					</td>
					</c:if>
				</tr>
				</c:if>
				
				</c:forEach>
				</c:if>
				
				<%-- 답변 항목이 객관식/주관식인 경우 --%>
				<c:if test="${data.question_form == 0}">
				
				<%-- 답변 항목이 객관식/주관식인 경우 --%>
				<c:if test="${data.direct_input == 0 }">
				<tr>
					<th style="text-align: left;">취업과 관련하여 개인 상담 시 얘기 나누고 싶은 부분이 있다면 적어주세요.</th>
				</tr>
				<tr class="single" id="q${qvs.count}">
				<td class="survey_answer">
					<textarea id="q${qvs.count}_a_cont"></textarea>
				</td>
				</tr>
				</c:if>
				
				</c:if>
			</tbody>
		</table>
	</tbody>
</table>
</c:forEach>
<input type="hidden" id="hope_area"/><%-- 지역 --%>
<input type="hidden" id="hope_pay"/><%-- 보수 --%>
<input type="hidden" id="hope_field"/><%-- 분야 --%>
<input type="hidden" id="hope_reside"/><%-- 거주형태 --%>
</c:if>

<script type="text/javascript">
/*
 * 설문조사 3차인 경우 학생 취업 희망사항에 UPDATE되도록 하는 함수_2020.05.28
 */
function settingStdtHope(){
	let q2 = document.getElementsByName('q2');
	let value1 = '';
	let value2 = '';
	let value3 = '';
	q2.forEach(function(entry,index){
		let attr = q2[index].dataset.attribute;
		if(attr !== undefined){
			if(attr === '희망 근무 지역'){
				value1 += q2[index].value.split('§')[0]+'/';
			}
			else if(attr === '최소 희망 연봉'){
				value2 += $('#'+q2[index].id+' option:selected').text()+'/';
			}
			else if(attr === '희망분야 및 직종'){
				value3 += $('#'+q2[index].id+' option:selected').text()+'/';
			}
		}
	});
	$('#hope_area').val(value1);
	$('#hope_pay').val(value2);
	$('#hope_field').val(value3);
}
/*
 * 입력값 전송하는 함수
 */
function fnSubmit(result){
	var params = {
			  curr_no		: '${curr_no}'
			, password      : 'password'
			, degree		: '${degree}'
			, stdt_no       : '${user.stdt_no}'
			, classify      : 'E'
			, result		: result
			, hope_area     : $('#hope_area').val()
			, hope_pay      : $('#hope_pay').val()
			, hope_field    : $('#hope_field').val()
			, hope_reside   : $('#hope_reside').val()
		}
		
	$.ajax({
		url			: '${pageContext.request.contextPath}/login/saveSurvey.kh'
		, data			: params
		, dataType		: 'json'
		, type			: 'post'
		, async         : false
		, success		: function(data, textStatus){
			if(data['result']=='1'){
				alert('설문조사가 완료되었습니다.');
				window.location.href = '${pageContext.request.contextPath}/login/mypage.kh'
			} 
		}
		, error		: function(jqXHR, textStatus, errorThrown){
			alert('오류가 발생했습니다\n[' + textStatus + ']\n' + errorThrown);
		}
	}); 
}

/*
 * 입력값 체크하는 함수
 */
function fnCheck(){
	var result = "";
	var i = 1;
	var count = '${data_length}'; //질문 갯수
	
	settingStdtHope();
	
	//surveyAppend.js 참고
	if('${degree}' === '3'){//설문조사 3차인경우
		const curr_classify = '${templateName.curr_classify}';
		result = appendTableResult(result, count, i, curr_classify);
	}
	else{
		result = appendResult(result, count, i);
	}

	if(result !== true && result !== undefined && result !== ''){
		let confirmMessage = confirm('설문제출 후 답변 수정이 불가합니다. 제출하시겠습니까?');
		if(confirmMessage === true){
			fnSubmit(result);
		}
	}
}
</script>