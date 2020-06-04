<%@page import="java.util.Calendar"%>
<%@ page import="java.util.HashMap"%>
<%@page import="com.kh.utils.Utils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="/WEB-INF/tlds/c.tld" %> 
<%@ taglib prefix="fn" 		uri="/WEB-INF/tlds/fn.tld" %>
<%@ taglib prefix="functions"	uri="/WEB-INF/tlds/functions.tld" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>KH정보교육원 - 학습 동영상</title>
<jsp:include page="/WEB-INF/jsp/common/meta.jsp"/>
<style>
	.board_file {float: left;}
</style>
<script type="text/javascript">
var play_pos = 0;
var play_time = 0;
var play_area = new Array('0', '0', '0', '0', '0');

jQuery(function(){
	fnOnMenu(7, 3);
	
	window.addEventListener("message", receiveMessage, false);
	play();
});

function receiveMessage(dataFromPlayer) {
	if( typeof dataFromPlayer == "undefined" || dataFromPlayer == null ) {
		return;
	}
	
	var modified = false;
	
	console.log(dataFromPlayer.data);
	
	if( dataFromPlayer.data.type == 'flow' ) {
		play_pos = dataFromPlayer.data.mediaPos;
		play_time = dataFromPlayer.data.mediaPlayTime;
		
		if( play_area[0] != dataFromPlayer.data.play20 ) { 
			play_area[0] = dataFromPlayer.data.play20;
			modified = true;
		}
		if( play_area[1] != dataFromPlayer.data.play40 ) { 
			play_area[1] = dataFromPlayer.data.play40;
			modified = true;
		}
		if( play_area[2] != dataFromPlayer.data.play60 ) { 
			play_area[2] = dataFromPlayer.data.play60;
			modified = true;
		}
		if( play_area[3] != dataFromPlayer.data.play80 ) { 
			play_area[3] = dataFromPlayer.data.play80;
			modified = true;
		}
		if( play_area[4] != dataFromPlayer.data.play100 ) { 
			play_area[4] = dataFromPlayer.data.play100;
			modified = true;
		}
	}
	if( dataFromPlayer.data.type == 'finish' ) {
		modified = true;
	}
	
	updateMediaPlayTime( modified );
}

function updateMediaPlayTime(modified) {
	
	var user_id = '${sessionScope.USER.id}';
	if( user_id != null && modified == true ) {
		var params={
			  board_media_no : $("#board_media_no").val()
			, play_pos	: play_pos
			, play_time	: play_time 
			, play_area	: '' + play_area[0] + play_area[1] + play_area[2] + play_area[3] + play_area[4]
		};
		$.ajax({
			  url		: '${pageContext.request.contextPath}/login/updateMediaPlayTime.kh'
			, data		: params
			, dataType	: 'json'
			, type		: 'post'
			, success	: function(data, textStatus) {
				
			}
			, error		: function(jqXHR, textStatus, errorThrown) {
				alert('오류가 발생했습니다\n[' + textStatus + ']\n' + errorThrown);
			}
		});
	}
}


function play() {
	var object_id = $("#object_id").val();
	var p_pos = $("#play_pos").val();
	
	if( typeof object_id == "undefined" || object_id == null || object_id.length == 0 ) {
		$("#mediaView").attr("src", "");
	} else {
		if( p_pos ) {
			$("#mediaView").attr("src", "https://play.mbus.tv/" + object_id + "?start=" + p_pos);
		}
		else {
			$("#mediaView").attr("src", "https://play.mbus.tv/" + object_id + "?autoplay");
		}
	}
}

function fnComment(no){
	var comment =  $("#comment_area").val();
	
	if (comment == null || comment.trim() == '') {
		alert('댓글은 최소 1글자 이상 입력하셔야합니다.');
		return;
	}
	
	var params={
		  no		: no
		, comment	: comment 
		, id		: '${sessionScope.USER.id}'
		, mode		: 'insert'
	};
	$.ajax({
		  url		: '${pageContext.request.contextPath}/login/mediaBoardComment.kh'
		, data		: params
		, dataType	: 'json'
		, type		: 'post'
		, success	: function(data, textStatus) {
			var result = data['result'];
			if(result==0) {
				alert('댓글 등록에 실패하였습니다.');
			} else {
				alert('댓글이 등록되었습니다.');
				document.frm.action = '${pageContext.request.contextPath}/login/mediaBoardView.kh';
				document.frm.submit();
			}
		}
		, error		: function(jqXHR, textStatus, errorThrown) {
			alert('오류가 발생했습니다\n[' + textStatus + ']\n' + errorThrown);
		}
	});
}
function fnCommentDelete(no) {
	var	params	= {
			sub_no	: no,
			no		: "${mediaViewData.sub_no}",
			id		: '${sessionScope.USER.id}',
			mode	: 'delete'
	};
		
	$.ajax({
		url			: '${pageContext.request.contextPath}/login/mediaBoardComment.kh',
		dataType	: 'json',
		type		: 'post',
		data		: params,
		success		: function (data, textStatus) {
			var result = data['result'];
			if(result==0) {
				alert('댓글 삭제에 실패하였습니다.');
			} else {
				alert('댓글이삭제되었습니다.');
				document.frm.action = '${pageContext.request.contextPath}/login/mediaBoardView.kh';
				document.frm.submit();
			}
		},
		error		: function (jqXHR, textStatus, errorThrown) {
			alert('오류가 발생했습니다\n[' + textStatus + ']\n' + errorThrown);
		}
	});
}

function fnMovePage(no,rnum){
	$("#no").val(no);
	$("#rnum").val(rnum);
	document.frm.action = '${pageContext.request.contextPath}/login/mediaBoardView.kh';
	document.frm.submit();
}

function setFileInfo() {
	var files = this.files;
	myVideos.push(files[0]);
	var video = document.createElement('video');
	video.preload = 'metadata';
	
	video.onloadedmetadata = function() {
		window.URL.revokeObjectURL(video.src);
		var duration = video.duration;
		myVideos[myVideos.length - 1].duration = duration;
		updateInfos();
	}
	
	video.src = URL.createObjectURL(files[0]);;
}

function updateInfos() {
	var infos = document.getElementById('infos');
	infos.textContent = "";
	for (var i = 0; i < myVideos.length; i++) {
		infos.textContent += myVideos[i].name + " duration: " + myVideos[i].duration + '\n';
	}
}

window.onbeforeunload = function(e){
	updateMediaPlayTime(true);
}

</script>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/common/top.jsp"/>
<div id="content_sub" onmouseover="fnPrevDept();">
	<form name="dfrm" id="dfrm" method="post">
		<input type="hidden" name="name" id="name" />
		<input type="hidden" name="origiName" id="origiName" />
	</form>
	<div id="content_sub_wrap">
		<jsp:include page="/WEB-INF/jsp/login/left.jsp"/>
		<div id="content_right">
			<div class="subject">
				<span>학습 동영상</span>
				<p><img src="${pageContext.request.contextPath}/resources/images/common/point_home.jpg"><img src="${pageContext.request.contextPath}/resources/images/common/point_depth.jpg">마이페이지<img src="${pageContext.request.contextPath}/resources/images/common/point_depth.jpg">학습 동영상</p>
			</div>
			<p class="subject_comment">반갑습니다. KH정보교육원에 오신 걸 환영합니다.</p>
			<div id="board_view">
				<div class="board_view_subject">
					<p class="board_view_subject_left">
					[${mediaViewData.category}<c:if test="${mediaViewData.sub_category != '전체영상'}">/${mediaViewData.sub_category}</c:if>]
					<c:choose>
						<c:when test="${fn:length(mediaViewData.title) gt 30}">
						<c:out value="${fn:substring(mediaViewData.title,0,29)}" />...
						</c:when>
						
						<c:otherwise>
						<c:out value="${mediaViewData.title}" />
						</c:otherwise>
					</c:choose>
					</p>
					
					<p class="board_view_subject_right">${fn:substring(mediaViewData.reg_date, 0, 4) }.${fn:substring(mediaViewData.reg_date, 4, 6) }.${fn:substring(mediaViewData.reg_date, 6, 8) }
					</p>
				</div>
				<div class="board_view_content" style="padding: 40px 0 40px 0;">
					<iframe id="mediaView" width='796' height='446' src='https://play.mbus.tv/${mediaViewData.object_id}' frameborder='0' allowfullscreen></iframe>
				</div>
				<div class="content_text">
					<p class="upload_title">
					[${mediaViewData.category}<c:if test="${mediaViewData.sub_category != '전체영상'}">/${mediaViewData.sub_category}</c:if>]
					${mediaViewData.title}</p>
					<p class="upload_day02">[공유기간] ${mediaViewData.begin_date} ~ ${mediaViewData.end_date}</p>
					<p class="text" style="margin-bottom: 60px;">${mediaViewData.content}</p>
				</div>
				<input type="hidden" id="midi_thumbnail" name="midi_thumbnail" value="${mediaViewData.midi_thumbnail}">
				<input type="hidden" id="object_id" name="object_id" value="${mediaViewData.object_id}">
				<input type="hidden" id="media_id" name="media_id" value="${mediaViewData.media_id}">
				<input type="hidden" id="board_media_no" name="board_media_no" value="${mediaViewData.no}">
				<input type="hidden" id="play_pos" name="play_pos" value="${mediaViewData.play_pos}">
				<input type="hidden" id="play_time" name="play_pos" value="${mediaViewData.play_time}">
				
				<div id="board_reply">
					<c:forEach var="ld" items="${cList}">
					<div class="dotted"></div>
					<div class="board_replay_content">
					<c:if test="${ld.hide_flag != 1 }"> 
						<div class="info">
							<p class="left"><b>${ld.name==null||ld.name==''? ld.mname:ld.name}</b> <span>${fn:substring(ld.reg_date, 0, 4) }.${fn:substring(ld.reg_date, 4, 6) }.${fn:substring(ld.reg_date, 6, 8) } ${fn:substring(ld.reg_date, 8, 10) }:${fn:substring(ld.reg_date, 10, 12) }</span> 
								
								<c:if test="${sessionScope.USER.id==ld.reg_id || sessionScope.aduser!=null}">
									<a href="javascript:fnCommentDelete(${ld.sub_no});">삭제</a>
								</c:if>
								
							</p>
						</div>
						<div class="text updatetxt_${ld.sub_no}">${fn:replace(ld.comment, newline, "<br>")}</div>
					</c:if>
					
					<c:if test="${ld.hide_flag == 1 }"> 
						<div class="info">
						<p class="left">
							<b>${ld.name==null||ld.name==''? fn:substring(ld.mname,0,1):fn:substring(ld.name,0,1)}**</b> 
							<span>${fn:substring(ld.reg_date, 0, 4) }.${fn:substring(ld.reg_date, 4, 6) }.${fn:substring(ld.reg_date, 6, 8) } ${fn:substring(ld.reg_date, 8, 10) }:${fn:substring(ld.reg_date, 10, 12) }</span> 
							<a></a>
						</p>
						</div>
						<div class="text updatetxt_${ld.sub_no}" style="color: #b2b2b2;">운영규정 미준수로 인해 삭제된 댓글입니다.</div>
					</c:if>
					
					</div>
					</c:forEach>
					<div class="board_reply_frm">
						<c:if test="${sessionScope.USER==null}">
						<textarea id="comment_area" disabled="disabled">로그인 후 덧글을 작성하실 수 있습니다.</textarea>
						<a href="#">등록</a>
						</c:if>
						<c:if test="${sessionScope.USER!=null}">
						<textarea id="comment_area"></textarea>
						<a href="javascript:fnComment(${mediaViewData.sub_no});">등록</a>
						</c:if>
						<span>통신예절에 어긋나는 글이나 상업적인 글, 타 사이트에 관련된 글은 관리자에 의해 사전 통보없이 삭제될 수 있습니다.</span>
					</div>
				</div>
				<%-- <div class="board_view_prev">
				</div> --%>
				<div class="board_view_botton">
				<a href="javascript:void(0);" onClick="document.frm.submit();"><img src="${pageContext.request.contextPath}/resources/images/common/button_list.jpg" alt="목록"></a>
				</div>
			</div>
			<form action="${pageContext.request.contextPath}/login/mediaBoard.kh" method="post" id="frm" name="frm">
				<input type="hidden" id="cpage" name="cpage" value="${params.cpage}">
				<input type="hidden" id="no" name="no" value="${params.no}">
				<input type="hidden" id="sub_no" name="sub_no" value="${params.sub_no}">
				<input type="hidden" id="sortlist" name="sortlist" value="${params.sortlist}">
				<input type="hidden" id="rnum" name="rnum" value="">
				<input type="hidden" id="mode" name="mode" value="update">
				<input type="hidden" id="currno" name="currno" value="${params.currno}">
				<input type="hidden" id="searchKey" name="searchKey" value="${params.searchKey}">
				<input type="hidden" id="searchValue" name="searchValue" value="${params.searchValue}">
				<input type="hidden" id="searchCategory" name="searchCategory" value="${params.searchCategory}">
				<input type="hidden" id="searchSubCategory" name="searchSubCategory" value="${params.searchSubCategory}">
			</form>
		</div>
	</div>
	<jsp:include page="/WEB-INF/jsp/common/right.jsp"/>
</div>
<jsp:include page="/WEB-INF/jsp/common/bottom.jsp"/>
</body>
</html>