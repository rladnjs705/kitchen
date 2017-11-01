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
<title>공지사항입니다.</title>

<link rel="stylesheet" href="<%=cp%>/resource/css/style.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/layout.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/menubar.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/jquery/css/smoothness/jquery-ui.min.css" type="text/css">

<script type="text/javascript" src="<%=cp%>/resource/js/util.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
function searchList() {
	var f = document.searchForm;
	f.action = "<%=cp%>/notice/list.do";
	f.submit();
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
      <li><a href="<%=cp%>/qna/qna.do">질문과답변</a></li> 
      <li><a href="<%=cp%>/event/list.do" id="current">이벤트</a>
         <ul>
           <li><a href="<%=cp%>/event/list.do?state=y">진행중인이벤트</a></li>
           <li><a href="<%=cp%>/event/list.do?state=n">지난이벤트</a></li>
         </ul>
      </li>
  </ul>
</div>
</div>

<!-- 게시판 리스트폼 넣을 곳 -->
<div class="containerList">

<table style="width: 700px; margin:auto; border-spacing: 0px;">
   <tr height="35">
      <td align="left" width="50%">
          ${dataCount}개(${page}/${totalPage}페이지)
      </td>
      <td align="right">
          &nbsp;
      </td>
   </tr>
</table>

<table style="width: 700px; margin: 0px auto; border-spacing: 0px; border-collapse: collapse;">
  <tr align="center" bgcolor="#eeeeee" height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
      <th width="60" style="color: #787878;">번호</th>
      <th style="color: #787878;">제목</th>
      <th width="100" style="color: #787878;">작성자</th>
      <th width="80" style="color: #787878;">작성일</th>
      <th width="60" style="color: #787878;">조회수</th>
      <th width="50" style="color: #787878;">첨부</th>
  </tr>
 <c:forEach var="notice" items="${listNotice}">
  <tr align="center" bgcolor="#f3f3f3" height="35" style="border-bottom: 1px solid #cccccc;">
 	  
      <td>공지</td>
      
      <td align="left" style="padding-left: 10px;">
           <a href="${articleUrl}&num=${notice.num}">${notice.subject}</a>
      </td>
      <td>${notice.userName}</td>
      <td>${notice.created}</td>
      <td>${notice.hitCount}</td>
      <td>
      	<c:if test="${not empty notice.saveFileName}">
      		<span style="font-family: Wingdings"><</span>
      	</c:if>
      </td>
  </tr>
</c:forEach>
 <c:forEach var="dto" items="${list}">
  <tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;">
      <td>${dto.listNum}</td>
      
      <td align="left" style="padding-left: 10px;">
           <a href="${articleUrl}&num=${dto.num}">${dto.subject}</a>
      </td>
      <td>${dto.userName}</td>
      <td>${dto.created}</td>
      <td>${dto.hitCount}</td>
      <td>
      	<c:if test="${not empty dto.saveFileName}">
      		<span style="font-family: Wingdings"><</span>
      	</c:if>
      </td>
  </tr>
</c:forEach>

</table>
 
<table style="width: 700px; margin: 0px auto; border-spacing: 0px;">
   <tr height="35">
	<td align="center">
        ${paging}
	</td>
   </tr>
</table>

<table style="width: 700px; margin: 10px auto; border-spacing: 0px;">
   <tr height="40">
      <td align="left" width="100">
          <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/notice/list.do';">새로고침</button>
      </td>
      <td align="center">
          <form name="searchForm" action="" method="post">
            <select name="searchKey" class="selectField">
            	<option value="userName">작성자</option>
                <option value="subject">제목</option>
                <option value="content">내용</option>
            </select>
            <input type="text" name="searchValue" class="boxTF">
            <button type="button" class="btn" onclick="searchList()">검색</button>
        </form>
      </td>
      <c:if test="${roll!='guest'}">
      <td align="right" width="100">
          <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/notice/created.do?page=${page}';">글올리기</button>
      </td>
      </c:if>
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