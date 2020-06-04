<%@ page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" 		uri="/WEB-INF/tlds/c.tld" %> 
<%@ taglib prefix="fn" 		uri="/WEB-INF/tlds/fn.tld" %>
<%@ taglib prefix="fmt"		uri="/WEB-INF/tlds/fmt.tld" %>
<!-- 운영과정관리 자동검색어   -->
<style>
    .passFinder_list_li {font-size: 13px; padding-bottom: 7px; cursor: pointer; font-weight: 300;}
    .passFinder_list_li:hover {color: black;}
    .passFinder_list_li_category{font-size: 13px; padding-bottom: 7px; cursor: pointer; font-weight: 300; color:#ff554d;}
    #board_search .board_search_line div {text-align: left;}
</style>
<div>
<c:if test="${fn:length(sList) != 0 }">
	<ul>
        <c:forEach items="${sList}" var="data" varStatus="status">
            <li onClick="fnSelectMajor('${data.major}')" class="passFinder_list_li">
                ${data.major} - ${data.campus }
            </li>
        </c:forEach>
    </ul>
</c:if> 
<c:if test="${fn:length(sList) == 0 }">
	<script>
	$('#search_majorname_list').hide();
	</script>
</c:if>
</div>