<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@ page import="java.util.HashMap" %>
<%@page import="com.kh.utils.Utils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="/WEB-INF/tlds/c.tld" %> 
<%@ taglib prefix="fn" 		uri="/WEB-INF/tlds/fn.tld" %>
<%@ taglib prefix="fmt"		uri="/WEB-INF/tlds/fmt.tld" %>
<%@ taglib prefix="utils"	uri="/WEB-INF/tlds/utils.tld" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String cpage = Utils.nvl((String)request.getAttribute("cpage"), "1");
    int sortpage = Integer.parseInt((String)request.getAttribute("sortpage"));
	int total = Integer.parseInt((String)request.getAttribute("total"));

	Date date = new Date();
	date.setDate(date.getDate()-7);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>KH정보교육원 - 학습 동영상</title>
<c:set var="currentDate"><fmt:formatDate value="<%=date%>" pattern="yyyyMMdd" /></c:set>
<jsp:include page="/WEB-INF/jsp/common/meta.jsp"/>
<style>
	/* 여러개 정렬 CSS */
	#list{width: 796px; border-bottom:2px solid #283444; border-top:2px solid #293444; margin-bottom: 30px;}
	#list td {width: 252px; padding:20px 20px 34px 0; position: relative;}
	#list td div[name="thumbnail_cover"] {top: 20px; position: absolute; width: 250px; height: 141px; opacity: 0.4; background: #000;}
	#list td img[name="play_btn"] {width: 45px; height: 45px; top: 71px; left: 105px; position: absolute;}
	#list td span[name="durationText"] {top: 138px; right: 22px; position: absolute; padding: 4px; font-size: 13px; background: #000; color: #fff;}
	#list td img {height:141px;}
	#list td span {display:inline-block;}
	#list td .video_box{width:252px; height:105px;}
	#list td .video_box .on{color:#fa5c3f; margin:8px 0;}
	#list td .video_box .off{color:#6d6e72; margin:8px 0;}
	#list td .video_box .update_date{font-size:12px;}
	#list td .title{border:none; padding:unset; margin:0px;}
	#list td .title02{max-width: 200px;white-space: nowrap;text-overflow: ellipsis;overflow: hidden;margin-top:15px; color:#000; font-weight:500; font-size:13.5px; vertical-align:sub;}
	#list td .date{width:252px; border-top:1px solid #f7f7f7;padding-top:15px; margin-top:5px; font-size:11px; color:#9a9a9a;}
	.board .attention td {background: #f9f9f9; color: #2b2b2b;}
	.list_file {display: inline-block; background: url(/resources/images/rad/rad_file.png) no-repeat; height: 13px; vertical-align: -2px; width: 13px;}
	.list_new {display: inline-block; background: url(/resources/images/sub07/sub07_new01.jpg) no-repeat; height: 13px; vertical-align: -2px; width: 13px;}
	.board .attention td {background: #f9f9f9; color: #2b2b2b;}
	.board tr {cursor: pointer;}
	.bar {width: 30px; margin: 25px 0 0 0; height: 2px; background: #283444;}
	.list_file {display: inline-block; background: url(/resources/images/rad/rad_file.png) no-repeat; height: 13px; vertical-align: -2px; width: 13px;}
	.list_new {display: inline-block; background: url(/resources/images/sub07/sub07_new01.jpg) no-repeat; height: 13px; vertical-align: -2px; width: 13px;}

	/* 일렬정렬 CSS */
	.video_horizontal .video_horizontal_in ul li.left div[name="thumbnail_cover"] {
		top: 0px; position: absolute; width: 250px; height: 141px; opacity: 0.4; background: #000;
	}
	.video_horizontal .video_horizontal_in ul li.left img[name="play_btn"] {
		width: 45px; height: 45px; top: 51px; left: 105px; position: absolute;
	}
	.video_horizontal .video_horizontal_in ul li.left span[name="durationText"] {
		bottom: 4px; right: 0px; position: absolute; padding: 4px; font-size: 13px; background: #000; color: #fff;
	}
	.upload_title a{margin-top:15px; color:#000; font-weight:500; font-size:13.5px; word-break:break-all;}
	
	#authPopup {display:none; width: 100%; height: 100%; position: fixed; z-index: 10;}
	#authPopup #authPopupImg {width: 630px; height: 480px; position: absolute; z-index: 12; left: 35%; top: 25%;}
	#authPopup #authPopupImg .popup_cont{background:#fff;}
	#authPopup #authPopupImg .authPopup_tit{font-size: 14px;font-weight: 600;text-align: center;line-height: 130%;color: #273341;letter-spacing: -0.5px;}
	#authPopup #authPopupImg .authPopup_list{padding: 30px 25px;margin: 20px 0;text-align: left;background:#f8f8f8;border:solid #e5e5e5;border-width:1px 0;}
	#authPopup #authPopupImg .authPopup_list ul{}
	#authPopup #authPopupImg .authPopup_list ul li{margin-bottom: 25px;}
	#authPopup #authPopupImg .authPopup_list ul li .authPopup_list_tit{color: #273341;}
	#authPopup #authPopupImg .authPopup_list ul li .authPopup_list_txt{margin: 5px 0 0 14px;font-size:12px;color:#9f9f9f;line-height: 140%;}
	#authPopup #authPopupImg .popup_btn{}
	#authPopup #authPopupImg .popup_btn a{width:88px;height:32px;margin: 0 auto;background: url(/resources/images/login/caution_popup_btn.jpg) no-repeat;}
	#authPopup #authPopupBg {width: 100%; height: 100%; position: absolute; z-index: 11; background: #000; opacity: 0.3;}

	.btn {width: 65px; height: 29px; line-height: 29px; text-align: center; background: #283444; color: #fff; display: inline-block;}
</style>
<script type="text/javascript">
jQuery(function(){
	$("#classify option[value='${params.classify}']").attr("selected", "selected");
	$(".customStyleSelectBoxInner").html($("#classify option:selected").html()).parent().addClass('changed');	
	golist("${params.sortlist}");	
	if("${sessionScope.USER.member_flag}" == 'T'){
		fnOnMenu(7, 3);
	}	
	if("${sessionScope.USER.member_flag}" != 'T'){
		fnOnMenu(7, 0);	
	}
}); 

function doPagingClick(page){
	$("#cpage").val(page)
	document.frm.action = '${pageContext.request.contextPath}/login/mediaBoard.kh';
	document.frm.submit();
}

function showList(value, page){
	$("#sortlist").val(value);
	$("#sortpage").val(page);
	document.frm.submit();
}

function golist(value){
	if(value === "one"){
		$("#one").show();
		$("#oneimage").attr("src" , "/resources/images/community/category_btn_on.png");
		$("#listimage").attr("src" , "/resources/images/community/category_btn_02_off.png");
		$("#list").hide();
	}
	else{
		$("#list").show();
		$("#oneimage").attr("src" , "/resources/images/community/category_btn.png");
		$("#listimage").attr("src" , "/resources/images/community/category_btn_02.png");
		$("#one").hide();
	}
}

function fnSelectView(category, no, sub_no, sortlist) {
	
	$("#media_category").val( category )
	$("#media_no").val( no )
	$("#media_sortlist").val( sortlist )
	$("#media_sub_no").val( sub_no )
	
	var auth = '${sessionScope.USER.auth}';
	if( category == '사전학습' && (auth == null || auth == '' || auth == 'false')) {
	 	//$("#authPopup").show();
		fnAuth();
	}
	else {
		document.frm.no.value = no;
		document.frm.sub_no.value = sub_no;
		document.frm.sortlist.value = sortlist;
		document.frm.action = '${pageContext.request.contextPath}/login/mediaBoardView.kh'
		document.frm.submit();
	}
}

function fnAuthPopupClose(){
	$("#authPopup").hide();
}

function fnAuth(){
	var params = "";
	$.ajax({
		  url		: '${pageContext.request.contextPath}/login/getIpinEncData.kh' 
		, data		: params
		, async		: true
		, type		: 'post'
		, beforeSend : function(xmlHttpRequest){
                xmlHttpRequest.setRequestHeader("AJAX", "true"); // ajax 호출을  header에 기록
		}
		, success	: function(data, textStatus) {
			
			if( data.error_code == '0' ) {
				if (data.enc_data == null || data.enc_data.length < 5) {
					alert("아이핀 인증에 에러가 발생했습니다. 관리자에 문의하세요. 에러코드 : " + data.enc_data);
					return;
				}
				
				$("#enc_data2").val( data.enc_data );
				
				window.open('', 'popupIPIN2', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
				document.form_ipin.target = "popupIPIN2";
				document.form_ipin.action = "https://cert.vno.co.kr/ipin.cb";
				document.form_ipin.submit();
			}
			else if( data.error_code == '4000' ) {
				alert( data.error_msg );
			}
		}
	});
}
function fnEvalStart()
{
	$("#media_enc_data").val( $("#enc_data").val() );
	document.form_media.action = "${pageContext.request.contextPath}/login/mediaBoardView.kh";
	document.form_media.submit();
}
</script>
</head>
<body >
<jsp:include page="/WEB-INF/jsp/common/top.jsp"/>
<div id="content_sub" onmouseover="fnPrevDept();">
	<form name="vnoform" method="post">
		<input type="hidden" id="recent_no" name="recent_no" >
		<input type="hidden" id="eval_number" name="eval_number" >
		<input type="hidden" id="ncs_no" name="ncs_no" >
		<input type="hidden" id="t_type" name="t_type" >
		<input type="hidden" id="q_type" name="q_type" >
		<input type="hidden" id="eval_token" name="eval_token" >
		<input type="hidden" id="enc_data" name="enc_data">				<!-- 인증받은 사용자 정보 암호화 데이타입니다. -->
	</form>
	
	<form name="form_ipin" method="post">
		<input type="hidden" name="m" value="pubmain">					<!-- 필수 데이타로, 누락하시면 안됩니다. -->
	    <input type="hidden" id="enc_data2" name="enc_data">			<!-- 위에서 업체정보를 암호화 한 데이타입니다. -->
	    <input type="hidden" name="mode" value="update">
	    <input type="hidden" name="url" value="/login/insertUserFrm.kh"><!-- 현재는 사용안함. -->
	</form>
	
	<form name="form_media" method="post">
		<input type="hidden" id="media_category" name="category">	
		<input type="hidden" id="media_no" name="no">	
		<input type="hidden" id="media_sortlist" name="sortlist">
		<input type="hidden" id="media_sub_no" name="sub_no">
		<input type="hidden" id="media_enc_data" name="enc_data">
	</form>

	<div id="authPopup">
		<div id="authPopupImg">
			<div class="popup_head">
				<span>훈련생 유의사항</span>
				<a href="javascript:fnAuthPopupClose();">&nbsp;</a>
			</div><!-- //popup_head -->
			<div class="popup_cont">
				<p class="authPopup_tit">귀하께서 수강 중인 NCS기반 훈련과정은 고용노동부로부터 실업자 직업능력 개발 훈련과정으로<br>지정 받은 과정입니다. 귀하께서는 아래의 사항에 유의하여 평가에 임해주시기 바랍니다.</p>
				<div class="authPopup_list">
					<ul>
						<li>
							<p class="authPopup_list_tit">① 이수기준</p>
							<p class="authPopup_list_txt">모든 평가에 참여해야 하며, 평가점수가 60점 이상 되어야 합니다.</p>
						</li>
						<li>
							<p class="authPopup_list_tit">② 평가 제출방법</p>
							<p class="authPopup_list_txt">입력한 답지는 자동적으로 저장이 됩니다.<br>단, 답안을 작성 후 최종적으로 화면 하단의 제출하기 버튼을 클릭하여야 입력한 전체 답지가 저장됩니다.</p>
						</li>
						<li style="margin-bottom:0;">
							<p class="authPopup_list_tit">③ 평가 피드백</p>
							<p class="authPopup_list_txt">평가 종료 후 10일 이내에 교사의 피드백을 확인할 수 있습니다.</p>
						</li>
					</ul>
				</div><!-- //authPopup_list -->
				<div class="popup_btn">
					<a href="javascript:fnAuth()"></a>
				</div><!-- //popup_btn -->
			</div><!-- //popup_cont -->
		</div><!-- //authPopupImg -->
		<div id="authPopupBg" onClick="fnAuthPopupClose()"></div>
	</div>

	<div id="content_sub_wrap">
		<jsp:include page="/WEB-INF/jsp/login/left.jsp"/>
		<div id="content_right">
			<div class="subject">
				<span>${sessionScope.USER.member_flag == 'T' ?'학습 동영상':'홍보 동영상'}</span>
				<p>
					<img src="${pageContext.request.contextPath}/resources/images/common/point_home.jpg">
					<img src="${pageContext.request.contextPath}/resources/images/common/point_depth.jpg">마이페이지
					<img src="${pageContext.request.contextPath}/resources/images/common/point_depth.jpg">${sessionScope.USER.member_flag == 'T' ?'학습 동영상':'홍보 동영상'}
				</p>
			</div>
			<c:if test="${sessionScope.USER.member_flag == 'T'}">
			<p class="subject_comment">반갑습니다. KH정보교육원에 오신 걸 환영합니다.</p>
			<h2 class="subject_title">[${cData.branch} ${cData.classroom}]${cData.pass_currname}</h2>
			<p class="subject_location">${cData.begin_date} ~ ${cData.end_date} | ${cData.begin_time} ~ ${cData.end_time}</p>
			<p class="teacher_name">${cData.prof} 강사님 | ${cData.e_charge} 취업담임</p>
			</c:if>
			<div class="all_video">
				<div class="all_video_left">
					<p>총 <span class="all_number">${total}</span>건</p>
				</div>
				<div class="all_video_right" style="display:${sessionScope.USER.member_flag == 'T'?'blcok':'none'};width: 710px;">
					<div class="category">
						<ul>
							<li onclick="showList('one','10');"><a ><img id="oneimage" style="margin-left:10px;" ></a></li>
							<li onclick="showList('list','9');"><a ><img id="listimage" style="margin-left:8px;" ></a></li>
						</ul>
					</div>
					<form action="${pageContext.request.contextPath}/login/mediaBoard.kh" method="post" id="frm" name="frm" style="float: right;">
						<!--width: 430px;   -->
						<input type="hidden" id="cpage" name="cpage" value="${params.cpage}">
						<input type="hidden" id="sortpage" name="sortpage" value="${params.sortpage}">
						<input type="hidden" id="sortlist" name="sortlist" value="${params.sortlist}">
						<input type="hidden" id="no" name="no">
						<input type="hidden" id="sub_no" name="sub_no">
						<input type="hidden" id="parent_no" name="parent_no" value="${params.parent_no}">
						<input type="hidden" id="mode" name="mode" value="insert">
						<input type="hidden" value="${params.searchCategory}">
						<input type="hidden"  value="${params.searchSubCategory}">
						<input type="hidden" id="currno" name="currno" value="${params.currno}">
					
						<%-- <select id="searchKey" name="searchKey" value="${params.searchKey}">
							<option value="TITLE">제목</option>
						</select>
						<input type="text" id="searchValue" name="searchValue" value="${params.searchValue}" />
						<button type="button" onClick="document.frm.cpage.value = 1; document.frm.submit();">검색</button> --%>
						<select id="searchCategory" name="searchCategory" 
								onchange="document.frm.cpage.value = 1; 
										  document.frm.searchSubCategory.value = '';
										  document.frm.submit();">
							<option value=""               ${params.searchCategory == ''?'selected':''}>         전체영상</option>
							<option value="${cData.gubun}" ${params.searchCategory == cData.gubun?'selected':''}>${cData.gubun} 영상</option>
							<option value="홍보"            ${params.searchCategory == '홍보'?'selected':''}>     홍보 영상</option>
							<option value="우리반영상"      ${params.searchCategory == '우리반영상'?'selected':''}>우리반 영상</option>
							<option value="사전학습"      ${params.searchCategory == '사전학습'?'selected':''}>사전학습 영상</option>
						</select>
						<select id="searchSubCategory" name="searchSubCategory" onchange="document.frm.submit();" style="width: 170px;">
							<c:if test="${params.searchCategory == '' or params.searchCategory == null}">
								<option value="">전체영상</option>
							</c:if>	
							<c:if test="${params.searchCategory == '자바' or params.searchCategory == '보안' or params.searchCategory == '사전학습'}">
								<option value="">전체영상</option>
							</c:if>	
							<c:forEach var="data" items="${categoryList}">
								<option value="${data.no}" ${params.searchSubCategory == data.no ?'selected':''}>${data.name}</option>
							</c:forEach>
						</select>
						<c:if test="${sessionScope.USER.member_flag == 'T'}">
						<select id="searchKey" name="searchKey" style="width: 90px;">
							<option value="TITLE" ${params.searchKey == 'TITLE'?'selected':''}>제목</option>
							<option value="NAME" ${params.searchKey == 'NAME'?'selected':''}>작성자</option>
						</select>
						<input type="text" id="searchValue" name="searchValue" size="35" onkeypress="if(event.keyCode==13) {document.frm.cpage.value = 1; document.frm.submit();}" style="width:120px;height:27px;border: 1px solid #e5e5e5;text-align: center;" value="${params.searchValue}">
						<a href="javascript:document.frm.cpage.value = 1; document.frm.submit();" class="btn">검색</a>
						</c:if>
					</form>
				</div>
			</div>
			
			<!-- 여러개 정렬 -->
			<c:if test="${total!=0}">
			<table id="list" cellpadding="0" cellspacing="0">
				<tr >
					<c:forEach  var="data" items="${list}" varStatus="vs">
					<c:set var="reg_date" value="${fn:substring(data.reg_date, 0,8)}"/>
					<td>
						<div style="cursor: pointer;"
							<c:if test="${data.share == '공유중'}">onClick="fnSelectView('${data.category}', '${data.no}', '${data.sub_no}', '${params.sortlist}')"</c:if>>
							<img <c:if test="${data.thumbnail != null && data.thumbnail != ''}">
									src="${pageContext.request.contextPath}/upload/contents/media/${fn:split(data.thumbnail, '|')[0]}" 
								 </c:if>
								 <c:if test="${data.thumbnail == null || data.thumbnail == ''}">
									src="https://${data.midi_thumbnail}" 
								 </c:if>
								 onerror="src='${pageContext.request.contextPath}/resources/images/login/gonggam_default.jpg'" 
								 style="width: 250px;">
							<div name="thumbnail_cover"></div>
							<img src="/resources/images/common/play_btn.png" name="play_btn">
							<span name="durationText">${fn:substring(data.duration, 3, 8)}</span>
						</div>
						
						<div class="video_box" style="cursor: pointer;" <c:if test="${data.share == '공유중'}">onClick="fnSelectView('${data.category}', '${data.no}', '${data.sub_no}','${params.sortlist}')"</c:if>>
							<span class="title title02" >[${data.category}<c:if test="${data.sub_category != '전체영상'}">/${data.sub_category}</c:if>]${data.title}</span>
							<span style="color: #000;"><c:if test="${data.comment_count > 0}">[${data.comment_count}]</c:if></span>
							 
							<c:if test="${(reg_date*1>currentDate*1) && data.share == '공유중'}">
							<img src="/resources/images/login/video_new.jpg" style="width:12px; height:11px;" alt="새글">
							</c:if>
							
							<span class="${data.share == '공유중'?'on':'off'}">[${data.share}]<span class="upload_date">${data.begin_date} ~ ${data.end_date}</span></span>
							<p class="date">Date : ${fn:substring(data.reg_date,0,4)}. ${fn:substring(data.reg_date,4,6)}. ${fn:substring(data.reg_date,6,8)} | View : ${data.hitcount}</p>
						</div>
					</td>
					<c:if test="${fn:length(list) == vs.count && vs.count % 3 != 0}">
						<c:forEach begin="1" end="${3 - fn:length(list) % 3}">
						<td></td>
						</c:forEach>
					</c:if>
					${vs.count % 3 == 0 && vs.count != 9 ? '</tr><tr>' : ''}
					</c:forEach>
				</tr>
			</table>
			</c:if>
			
			<!-- 일렬 정렬 -->
			<c:if test="${total!=0}">
			<div class="video_horizontal" id="one" style="margin-bottom: 30px;">
				<c:forEach  var="data" items="${list}" varStatus="vs">
				<div class="video_horizontal_in">
					<ul style="margin-top:20px;">
						<li class="left" <c:if test="${data.share == '공유중'}">onClick="fnSelectView('${data.category}', '${data.no}', '${data.sub_no}','${params.sortlist}')"</c:if>>
							<img <c:if test="${data.thumbnail != null && data.thumbnail != ''}">
									src="${pageContext.request.contextPath}/upload/contents/media/${fn:split(data.thumbnail, '|')[0]}" 
								 </c:if>
								 <c:if test="${data.thumbnail == null || data.thumbnail == ''}">
									src="https://${data.midi_thumbnail}" 
								 </c:if>
								 onerror="src='${pageContext.request.contextPath}/resources/images/login/gonggam_default.jpg'" 
								 style="width: 250px; height: 140px;">
							<div name="thumbnail_cover"></div>
							<img src="/resources/images/common/play_btn.png" name="play_btn">
							<span name="durationText">${fn:substring(data.duration, 3, 8)}</span>
						</li>
						<li class="middle ${data.share == '공유중'?'on':'off'}">
							${data.share}
							<br>
							<c:if test="${data.dday < 0}">D${data.dday}</c:if>
							<c:if test="${data.dday == 0}">D-DAY</c:if>
						</li>
						
						<li class="right">
							<p class="upload_title" >
								<a <c:if test="${data.share == '공유중'}">onClick="fnSelectView('${data.category}', '${data.no}', '${data.sub_no}','${params.sortlist}')"</c:if>>
								[${data.category}<c:if test="${data.sub_category != '전체영상'}">/${data.sub_category}</c:if>]${data.title} 
								</a>
								<c:if test="${data.comment_count > 0}">
								[${data.comment_count}]	
								</c:if>
                               	<c:set var="reg_date" value="${fn:substring(data.reg_date, 0,8)}"/>
								<c:if test="${(reg_date*1>currentDate*1) && data.share == '공유중'}">
                                <img src="/resources/images/login/video_new.jpg" class="video_new" alt="새글">
                                </c:if>
							</p>
							<span class="upload_day02">[공유기간] ${data.begin_date} ~ ${data.end_date}</span>
							<p class="text" style="display: block;height: 30px;overflow: hidden;">
								<c:if test="${fn:length(data.content) > 80 }" >
								${fn:substring(data.content,0,79)}...
								</c:if>
								
								<c:if test="${fn:length(data.content) < 80 }" >
								${data.content}
								</c:if>
							</p>
							<p class="date">Date : ${fn:substring(data.reg_date,0,4)}. ${fn:substring(data.reg_date,4,6)}. ${fn:substring(data.reg_date,6,8)} | View : ${data.hitcount}</p>
						</li>
					</ul>
					${vs.count==10?'<br>': ''}
				</div>
				</c:forEach>
			</div>
			</c:if>
			<c:if test="${total==0}">
				<div class="video_horizontal" style="margin-bottom: 30px;">
					<div style="text-align: center; padding: 100px; font-size: 15px;">공유된 동영상이 없습니다.</div>
				</div>
			</c:if>
			
			<div class="board_num" >
				<%=Utils.getPage(total, cpage, sortpage, 10) %>
			</div>
		</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/jsp/common/bottom.jsp"/>
</body>
</html>