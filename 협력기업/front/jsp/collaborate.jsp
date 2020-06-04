<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="/WEB-INF/tlds/c.tld" %> 
<%@ taglib prefix="fn" 		uri="/WEB-INF/tlds/fn.tld" %>
<%@ taglib prefix="fmt"		uri="/WEB-INF/tlds/fmt.tld" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>KH정보교육원 - 협력기업 LIST</title>
<jsp:include page="/WEB-INF/jsp/common/meta.jsp"/>
<script type="text/javascript">
jQuery(function(){
	fnOnMenu(3, 0);
});
</script>
<style type="text/css">
	#content_sub_wrap{width: 100%; min-width: 1200px; background-repeat: no-repeat; background-position: top center; line-height: 1.5;}

	#quick{height:104px; background-color:#f8f8f8;}	

	#collaborate{width:100%;overflow:hidden; background:url(/resources/images/recruit/back_2.jpg) no-repeat;background-position:top center; margin:0 auto;}
    #collaborate .box1{width:762px;height:267px;margin:0 auto;margin-top:90px}
    #visual{height:auto; width:1060px;margin:0 auto;background:#f8f8f8;margin-top:-62px;overflow:hidden;margin-bottom:20px;border-bottom:1px solid #efefef;}
	
	#box2{width:740px;height:115px;margin:0 auto;margin-top:19px;position:relative;}
	#box2 ul{overflow:hidden;width:770px;}
	#box2 li{float:left;}
	#box2 .left{width:370px;height:115px;background:url(/resources/images/recruit/java_on.jpg);}
	#box2 .right{width:370px;height:115px;background:url(/resources/images/recruit/screit_off.jpg);}
	
	#visual .all_box{width:961px;margin:0 auto;overflow:hidden;margin-bottom:40px;}
	#visual .all_box ul li {font-size:12px;}
    #visual .all_box ul{padding:30px 0 30px 0; box-sizing:border-box}
    #visual .one_box{width:230px;height:100%;background:#fff;float:left;text-align:center;line-height:2.5;}
    #visual .two_box{width:230px;height:100%;background:#fff;float:left;text-align:center;line-height:2.5;margin-left:14px;}
    #visual .three_box{width:230px;height:100%;background:#fff;float:left;text-align:center;line-height:2.5;margin-left:14px;}
    #visual .four_box{width:230px;height:100%;background:#fff;float:left;text-align:center;line-height:2.5;margin-left:13px;}

    #visual .inner{width:1060px;height:184px;}
	#visual .inner2{width:200px;height:17px;margin:0 auto;padding-left:10px;box-sizing:border-box;font-size:7px;margin-top:3px;}
    #visual .it_company{margin-top:86px;margin-left:450px;}
    
	#footer{width:1060px;height:55px;margin:0 auto;background:url(/resources/images/recruit/more.jpg) no-repeat; margin-top:20px;margin-bottom:80px;padding-top:20px;box-sizing:border-box;}
	#footer .txt{width:180px;height:18px;margin:0 auto;}
	#footer .txt .m{margin-right:4px;}
	#footer .txt li{float:left}
</style>

<script type="text/javascript">
	$(document).ready(function(){
		/*넘어가야되는 것. 페이지 넘버와, 자바*/
		goSubject("1","자바");
		
		var myclick = 1;
		$("#java").click(function(){
			emptySpace();
			if($("#clicknum").val() > 1){
				myclick = 1;
			}
		});
		
		$("#screit").click(function(){
			emptySpace();
			if($("#clicknum").val() > 1){
				myclick = 1;
			}
		});
		
		$("#showmore").click(function(){
			myclick++;
			showMore(myclick);
		});
		
	});
	
	function emptySpace(){
		$(".one_box").empty();
		$(".two_box").empty();
		$(".three_box").empty();
		$(".four_box").empty();
	}
	
	function goSubject(cpage,filed){
		$("#filed").val(filed);
		var form_data = {"cpage":cpage,"filed":filed};
		
		changeColor(filed);
		
		$.ajax({
			url:"${pageContext.request.contextPath}/recruit/collaborateJava.kh",
			type:"post",
			dataType:"json",
			data:form_data,
			success:function(data){
				var list = data["list"];
				var html = "";
				$("#suit_count").html(filed+"분야 협력 기업 : "+Number(data.count).toLocaleString());
				if(list.length > 0){
					for(var i=0; i<list.length; i++){
						html = "<li>"+list[i].COMPANY_NAME+"</li>";
						
						if(i<5 && i>0){
							$(".one_box").append(html);
						}
						if(i<10 && i>5){
							$(".two_box").append(html);
						}
						if(i<15 && i>10){
							$(".three_box").append(html);
						}
						if(i<20 && i>15){
							$(".four_box").append(html);
						}
						if(i<25 && i>20){
							$(".one_box").append(html);
						}
						if(i<30 && i>25){
							$(".two_box").append(html);
						}
						if(i<35 && i>30){
							$(".three_box").append(html);
						}
						if(i<40 && i>35){
							$(".four_box").append(html);
						}
						if(i<45 && i>40){
							$(".one_box").append(html);
						}
						if(i<50 && i>45){
							$(".two_box").append(html);
						}
						if(i<55 && i>50){
							$(".three_box").append(html);
						}
						if(i<60 && i>55){
							$(".four_box").append(html);
						}
						if(i<65 && i>60){
							$(".one_box").append(html);
						}
						if(i<70 && i>65){
							$(".two_box").append(html);
						}
						if(i<75 && i>70){
							$(".three_box").append(html);
						}
						if(i>75){
							$(".four_box").append(html);
						}
					}
				}
				if(data.end > data.count){
					data.end = data.count;
				}
				
				$(".m").html("더보기("+Number(data.end).toLocaleString()+"/"+Number(data.count).toLocaleString()+")");
				
				$("#maxCount").val(data.count);
			},
			error:function(jqXHR, textStatus, errorThrown){
				alert("오류가 발생했습니다\n["+textStatus+"]\n"+errorThrown);
			}
		});
		
		
	}
	
	function changeColor(filed){
		if(filed == "보안"){
			$(".left").css("background","url(/resources/images/recruit/java_off.jpg)");
			$(".right").css("background","url(/resources/images/recruit/screit_on.jpg)");
			
		}
		else{
			$(".left").css("background","url(/resources/images/recruit/java_on.jpg)");
			$(".right").css("background","url(/resources/images/recruit/screit_off.jpg)");
		
		}
	}
	
	function showMore(myclick){
		$("#clicknum").val(myclick);
		
		var max = $("#maxCount").val();
		var filed = $("#filed").val();
		
		var clicknum = Math.ceil(parseInt(max)/80);
		
		if(filed == "보안" && myclick <= parseInt(clicknum)){
			goSubject(myclick,filed);
		}
		if(filed == "자바" && myclick <= parseInt(clicknum)){
			goSubject(myclick,filed);
		}
		
	}
	
</script>

</head>
<body>
<jsp:include page="/WEB-INF/jsp/common/top.jsp"/>
<div id="content_sub" >
<!-- onmouseover="fnPrevDept();" -->
	<div id="content_sub_wrap" style="width:100%">
	
	<div id="collaborate">
		<div class="box1"></div>	
		<div style="color: white;font-weight: bolder;font-size: 32pt;padding-bottom: 10px;font-family: 'DINBol';" align="center"><fmt:formatNumber pattern="#,###" value="${total}"/></div>
		<div id="box2">
		<ul>
		<li class="left" id="java"  onclick="javascript:goSubject('1','자바');" style="cursor: pointer;"></li>
		<li class="right" id="screit"  onclick="javascript:goSubject('1','보안');" style="cursor: pointer;"></li>
		</ul>
		</div>
		
		<input type="hidden" value="" id="filed" name="filed"/>
		<input type="hidden" value="" id="maxCount" name="maxCount"/>
		
		<div id="visual">
		<div class="inner"> <img src="/resources/images/recruit/IT.png" alt="" class="it_company">
		<div class="inner2">
		<p id="suit_count" align="center"></p>
		</div>
		</div>
		
	    <div class="all_box" style="">
	        <ul class="one_box">
			</ul>

			<ul class="two_box">
			</ul>

			<ul class="three_box">
			</ul>

			<ul class="four_box">
			</ul>
		</div>
		
	    </div>
        <div id="footer">
        <input type="hidden" id="clicknum" value=""/>
			<div class="txt">
			<ul style="cursor: pointer;" id="showmore">
			<li class="m" style="font-size: 15px;color: #283444;"></li>
			<!-- 더보기 클릭 해당 필드명과 다음 cpage 를가지고 이동함. 아래로 덧붙혀서 보여주기 -->
			<li><img src="/resources/images/recruit/more_img.jpg" alt="" class=""></li>
			</ul>
			</div>
	    </div>
	    
		<div id="quick">
			<jsp:include page="/WEB-INF/jsp/common/quick.jsp"/>
		</div>
	</div>
	</div>
</div>
<jsp:include page="/WEB-INF/jsp/common/bottom.jsp"/>
</body>
</html>