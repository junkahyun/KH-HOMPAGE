/**
 * 이메일 인증 기능입니다.
 */
var emailValidBtn = false; //이메일 인증 버튼 클릭여부를 나타내는 객체(true : 클릭, false : 미클릭)
var emailConfirmBtn = false; //이메일 인증 확인버튼 클릭여부를 나타내는 객체(true : 클릭, false : 미클릭)
var emailConfirmBtn = document.getElementById('emailConfirmBtn');

function validateEmail(pageContext,email){
	alert('메일을 발송하였습니다.');
	$('#emailValidationBtn').css({'cursor':'progress'});
	$.ajax({
		url:''+pageContext+'/login/emailValidation.kh',
		type:'post',
		dataType:'json',
		data:{email : email},
		beforeSend	: function(){$("#loading").show();}})
		.success(function(data){
			$('#loading').hide();
			emailValidBtn = true;
			$('#emailValidationBtn').hide();
			$('.emailVerify').show();
			$('#emailValidNum').show();
			$('#emailConfirmBtn').show();
			$('#emailValidationBtn').css({'cursor':''});
			/* 1초마다 시간을 찍어주는 함수입니다. */
      		showValidTime('availableTime','emailValidNum','emailConfirmBtn', 'emailValidationBtn');
      		confirmEmail(pageContext);
		})
		.error (function (jqXHR, textStatus, errorThrown) {
			alert('오류가 발생했습니다\n[' + textStatus + ']\n' + errorThrown);
		})
}

function confirmEmail(pageContext){
	$('#emailConfirmBtn').on('click', function (){
		$.ajax({
			url:''+pageContext+'/login/emailConfirm.kh',
			type:'post',
			dataType:'json',
			data:{emailValidNum : $('#emailValidNum').val()}})
			.success(function(data){
				if(data.result === 1){
					emailConfirmBtn = true;
					alert('인증되었습니다.');
					clearInterval(timeReversal);
					$('#availableTime').hide();
					$('#emailConfirmBtn').hide();
					$('#emailValidNum').prop("disabled",true);
				}
				else{
					alert('올바른 번호를 입력해주세요.');
				}
			})
			.error (function (jqXHR, textStatus, errorThrown) {
				alert('오류가 발생했습니다\n[' + textStatus + ']\n' + errorThrown);
			});
	});
}
