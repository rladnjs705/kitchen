<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>study</title>
<link rel="stylesheet" href="<%=cp%>/resource/css/style.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/layout.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/menubar.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/jquery/css/smoothness/jquery-ui.min.css" type="text/css">

<script type="text/javascript" src="<%=cp%>/resource/js/util.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-1.12.4.min.js"></script>

<script type="text/javascript">
function deleteBoard(num) {
	if(confirm('삭제하시겠습니까?')){
		var url = "<%=cp%>/notice/delete.do?num="+num+"&page=${page}";
		location.href = url;
	}
}
</script>
</head>

<body>
<div class="header">
    <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>

<div class="containerList">

<div class="body-title">
            <h3>고객센터 | </h3>
</div>
<div class="menubar">
   <ul>
      <li><a href="<%=cp%>/notice/list.do" style="background: rgb(71,71,71);">공지사항 </a></li>
      <li><a href="<%=cp%>/bbs/list.do">문의하기</a></li>
      <li><a href="#">질문과답변</a></li> 
      <li><a href="#" id="current">이벤트</a>
         <ul>
           <li><a href="#">진행중인이벤트</a></li> 
           <li><a href="#">지난이벤트</a></li>
         </ul>
      </li>
  </ul>
</div>
</div>

<div class="containerList">
<table style="width: 700px; margin:auto; border-spacing: 0px;">
<tr height="40"> 
	<td align="left" class="title">
		<h3><span>|</span> 게시판</h3>
	</td>
</tr>
</table>

<table style="width: 700px; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
<tr height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
    <td colspan="2" align="center">
	   ${dto.subject}
    </td>
</tr>

<tr height="35" style="border-bottom: 1px solid #cccccc;">
    <td width="50%" align="left" style="padding-left: 5px;">
       이름 : ${dto.userName}
    </td>
    <td width="50%" align="right" style="padding-right: 5px;">
        ${dto.created} | 조회 ${dto.hitCount}
    </td>
</tr>

<tr style="border-bottom: 1px solid #cccccc;">
  <td colspan="2" align="left" style="padding: 10px 5px;" valign="top" height="200">
      ${dto.content}
   </td>
</tr>

<c:if test="${not empty dto.saveFileName}">
	<tr height="35" style="border-bottom: 1px solid #cccccc;">
	    <td colspan="2" align="left" style="padding-left: 5px;">
		       첨부파일 :  
	       	<a href="<%=cp%>/notice/download.do?num=${dto.num}">${dto.saveFileName}</a>
	    </td>
	</tr>
</c:if>

<tr height="35" style="border-bottom: 1px solid #cccccc;">
    <td colspan="2" align="left" style="padding-left: 5px;">
       이전글 :  
       <c:if test="${not empty predto}">
       	<a href="<%=cp%>/notice/article.do?num=${predto.num}">${predto.subject}</a>
       </c:if>
       <c:if test="${empty predto}">${msgP}</c:if>
    </td>
</tr>

<tr height="35" style="border-bottom: 1px solid #cccccc;">
    <td colspan="2" align="left" style="padding-left: 5px;">
    다음글 : 
   		<c:if test="${not empty nextdto}">
       	<a href="<%=cp%>/notice/article.do?num=${nextdto.num}">${nextdto.subject}</a>
       </c:if>
       <c:if test="${empty nextdto}">${msgN}</c:if>
    </td>
</tr>
</table>

<table style="width: 700px; margin: 0px auto 20px; border-spacing: 0px;">
<tr height="45">
<c:if test="${roll!='guest'}">
    <td width="300" align="left">
        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/notice/update.do?num=${dto.num}&page=${page}';">수정</button>
        <button type="button" class="btn" onclick="deleteBoard('${dto.num}');">삭제</button>
    </td>
</c:if>
    <td align="right">
        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/notice/list.do?page=${page}${query}';">리스트</button>
    </td>
</tr>
</table>

</div>
<div class="footer">
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery.ui.datepicker-ko.js"></script>
</body>
</html>