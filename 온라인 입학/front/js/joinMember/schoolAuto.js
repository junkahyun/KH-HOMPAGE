/**
 * 학교 자동 검색 기능
 */
$("body").on('click', function(e) {
	var clickPoint = $(e.target);
	
	if (!clickPoint.hasClass('search_schoolname_list')) {
		$("#search_schoolname_list").hide();
	}
	if (!clickPoint.hasClass('search_majorname_list')) {
		$("#search_majorname_list").hide();
	}
});

$.fn.autoSearch = function(pageContext) {
	var checkNo = function(keyword,gubun,schoolValue) {
		var params = {
			keyword		: keyword,
			gubun       : gubun,
			schoolValue : schoolValue
		};

		$.ajax({
			url		: ''+pageContext+'/login/school_finder.kh'
			, data		: params
			, dataType	: 'html'
			, type		: 'post'
			, success	: function(data, textStatus){
				$("#search_"+gubun+"name_list").show();
				$("#search_"+gubun+"name_list").html(data);
			}
			, error		: function(jqXHR, textStatus, errorThrown){
				alert('오류가 발생했습니다\n[' + textStatus + ']\n' + errorThrown);
			}
		});
	}

	// keyup check
	$(this).keyup(function() {
		var keyword = $(this).val();
		var id = $(this).attr('id');
		var schoolValue = '';
		let gubun = '';
		
		if(id === 'comaca1'){
			gubun = 'school'
		}
		else if(id === 'comaca3'){
			schoolValue = $('#comaca1').val();
			gubun = 'major'
		}
		checkNo(keyword,gubun,schoolValue);
	});
}

//학교선택
function fnSelect(scname){
	$("#comaca1").val(scname);
	$("#search_schoolname_list").hide();
}

//학과선택
function fnSelectMajor(major){
	$("#comaca3").val(major);
	$("#search_majorname_list").hide();
}