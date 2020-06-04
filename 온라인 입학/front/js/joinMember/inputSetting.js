/**
 * 회원가입 등록, 수정시 추가정보 입력 이벤트 입니다
 * 경력, 국비수강횟수, 자격증
 */

/* 입력칸 세팅 */
var inputSetting = {
		career : function(i,value){
			const html = "<tr class='addCareerName' id='career_tr"+i+"'>"+
					     "<th></th>"+
					     "<td><input  type='text' id='career_"+i+"' value='"+value+"' placeholder='분야:xx, 회사명:xx컴퍼니, 근무기간:xx년' name='plusCareer' style='width: 275px;' ><button type='button' class='removeBtn' id='career_"+i+"' onclick='removeInput(this.id);'>삭제</button></td>"+
					     "</tr>";
			$('.careerAppend').after(html);
		},
		govercount: function(i,value){
			const html = "<tr class='addCurrName'>"+
					     "<th>수강과정명</th>"+
					     "<td><input type='text' id='currname"+i+"' value='"+value+"' name='plusCurr'></td>"+
					     "</tr>";
			$('.govercountAppend').after(html);
		},
		license : function(i,value){
			const html = "<tr class='addLicense' id='license_tr"+i+"'>"+
					     "<th></th>"+
					     "<td><input type='text' id='license_"+i+"' value='"+value+"' name='plusLicense'><button type='button' class='removeBtn' id='license_"+i+"' onclick='removeInput(this.id);'>삭제</button></td>"+
					     "</tr>";
			$('.licenseAppend').after(html);
		}
}

/* 입력칸 세팅(모바일) */
var minputSetting = {
		career : function(i,value){
			const html = "<tr class='addCareerName' id='career_tr"+i+"'>"+
					     "<th></th>"+
					     "<td><input  type='text' id='career_"+i+"' value='"+value+"' placeholder='분야:xx, 회사명:xx컴퍼니, 근무기간:xx년' name='plusCareer' style='width: 60%;' ><a class='removeBtn btn_sm' id='career_"+i+"' onclick='removeInput(this.id);'>삭제</a></td>"+
					     "</tr>";
			$('.careerAppend').after(html);
		},
		govercount: function(i,value){
			const html = "<tr class='addCurrName'>"+
					     "<th>수강과정명</th>"+
					     "<td><input type='text' id='currname"+i+"' value='"+value+"' name='plusCurr'></td>"+
					     "</tr>";
			$('.govercountAppend').after(html);
		},
		license : function(i,value){
			const html = "<tr class='addLicense' id='license_tr"+i+"'>"+
					     "<th></th>"+
					     "<td><input type='text' id='license_"+i+"' value='"+value+"' style='width: 60%;' name='plusLicense'><a class='removeBtn btn_sm' id='license_"+i+"' onclick='removeInput(this.id);'>삭제</a></td>"+
					     "</tr>";
			$('.licenseAppend').after(html);
		}
}

/* 삭제 기능 추가 */
function removeInput(id){
	const splitId = id.split('_');
	$('#'+splitId[0]+'_tr'+splitId[1]+'').remove();
}

/* 추가한데이터입력 */
function resettingPlus(){
	let plusCareer = document.getElementsByName('plusCareer');
	if(plusCareer.length > 0){
		let career = '';
		for(var i=0; i<plusCareer.length; i++){
			if(i === plusCareer.length-1){
				career += plusCareer[i].value;
			}
			else{
				career += plusCareer[i].value+"|";
			}
		}
		$('#career').val(career);
	} 
	 
	let plusLicense = document.getElementsByName('plusLicense');
	if(plusLicense.length > 0){
		let license = '';
		for(var i=0; i<plusLicense.length; i++){
			if(i === plusLicense.length-1){
				license += plusLicense[i].value;
			}
			else{
				license += plusLicense[i].value+"|";
			}
		}
		$('#license').val(license);
	}
	 
	 if($('#govercount').val() !== ''){
		let plusCurr = document.getElementsByName('plusCurr');
		let govercount = '';
		for(var i=0; i<plusCurr.length; i++){
			if(i === plusCurr.length-1){
				govercount += plusCurr[i].value;
			}
			else{
				govercount += plusCurr[i].value+"|";
			}
		}
		$('#govercountPlus').val(govercount);
	}
}