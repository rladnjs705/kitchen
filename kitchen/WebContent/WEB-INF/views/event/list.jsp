<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String cp=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트게시판입니다.</title>

<link rel="stylesheet" href="<%=cp%>/resource/css/style.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/layout.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/jquery/css/smoothness/jquery-ui.min.css" type="text/css">

<script type="text/javascript" src="<%=cp%>/resource/js/util.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
function searchList() {
	var f = document.searchForm;
	f.action = "<%=cp%>/event/list.do";
	f.submit();
}
</script>
<style type="text/css">
.menubar{
border:none;
border:0px;
margin:0px;
padding:0px;
font-family:"Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
font-size:14px;
font-weight:bold;
}

.menubar ul{
background: gray;
height:50px;
list-style:none;
margin:0;
padding:0;
}

.menubar li{
float:left;
padding:0px;
}

.menubar li a{
background: gray;
color:#cccccc;
display:block;
font-weight:normal;
line-height:50px;
margin:0px;
padding:0px 25px;
text-align:center;
text-decoration:none;
}

.menubar li a:hover, .menubar ul li:hover a{
background: rgb(71,71,71);
color:#FFFFFF;
text-decoration:none;
}

.menubar li ul{
background: gray;
display:none; 
height:auto;
padding:0px;
margin:0px;
border:0px;
position:absolute;
width:200px;
z-index:200;
/*top:1em;
/*left:0;*/
}
  
.menubar li:hover ul{
display:block; 
}

.menubar li li {
background: gray;
display:block;
float:none;
margin:0px;
padding:0px;
width:200px;
}

.menubar li:hover li a{
background:none;
}

.menubar li ul a{
display:block;
height:50px;
font-size:12px;
font-style:normal;
margin:0px;
padding:0px 10px 0px 15px;
text-align:left;
}

.menubar li ul a:hover, .menubar li ul li:hover a{
background: rgb(71,71,71);
border:0px;
color:#ffffff;
text-decoration:none;
}

.menubar p{
clear:left;
}

.containerList{
   width: 60%;
   margin: auto;
}


</style>
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
      <li><a href="<%=cp%>/notice/list.do">공지사항 </a></li>
      <li><a href="<%=cp%>/bbs/list.do">문의하기</a></li>
      <li><a href="<%=cp%>/qna/qna.do">질문과답변</a></li> 
      <li><a href="<%=cp%>/event/list.do" style="background: rgb(71,71,71);" id="current">이벤트</a>
         <ul>
           <li><a href="<%=cp%>/event/list.do?state=y">진행중인이벤트</a></li> 
           <li><a href="<%=cp%>/event/list.do?state=n">지난이벤트</a></li>
         </ul>
      </li>
  </ul>
</div>
</div>

<table style="width: 700px; margin: 30px auto 0px; border-spacing: 0px;">
<tr height="45">
	<td align="left" class="title">
		<h3><span>|</span> 이벤트 게시판</h3>
	</td>
</tr>
</table>

<table style="width: 700px; margin: 20px auto 0px; border-spacing: 0px;">
	<tr height="35">
		<td align="left" width="50%">
			${dataCount}개(${page}/${total_page} 페이지)
		</td>
		<td align="right">
			&nbsp;
		</td>
	</tr>
</table>

<table style="width: 700px; margin: 0px auto; border-spacing: 0px; border-collapse: collapse;">
	<tr align="center" bgcolor="#eeeeee" height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
		<th width="100" style="color: #787878;">이벤트 종료일</th>
		<th width="60" style="color: #787878;">번호</th>
		<th style="color: #787878;">제&nbsp;&nbsp;&nbsp;&nbsp;목</th>
		<th width="100" style="color: #787878;">작성자</th>
		<th width="80" style="color: #787878;">작성일</th>
		<th width="60" style="color: #787878;">조회수</th>
	</tr>

<c:forEach var="dto" items="${list}">
	<tr align="center" bgcolor="#ffffff" height="35" style="border-bottom: 1px solid #cccccc;">
		<td>${dto.eventEnd}</td>
		<td>${dto.listNum}</td>
		<td align="left" style="padding-left: 10px;">
			<a href="${articleUrl}&eventNum=${dto.eventNum}">${dto.eventSubject}</a>
		</td>
		<td>${dto.userName}</td>
		<td>${dto.eventCreated}</td>
		<td>${dto.eventHitcount}</td>
	</tr>
</c:forEach>
</table>

<table style="width: 700px; margin: 0px auto; border-spacing: 0px;">
	<tr height="35">
		<td align="center">
			<c:if test="${dataCount==0 }">
				등록된 게시물이 없습니다.
			</c:if>
			<c:if test="${dataCount!=0 }">
				${paging}
			</c:if>
		</td>
	</tr>
</table>

<table style="width: 700px; margin: 10px auto; border-spacing: 0px;">
	<tr height="40">
		<td align="left" width="100">
			<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/event/list.do';">새로고침</button>
		</td>
		<td align="center">
			<form name="searchForm" action="" method="post">
				<select name="searchKey" class="selectField">
					<option value="eventSubject">제목</option>
					<option value="userName">작성자</option>
					<option value="eventContent">내용</option>
					<option value="eventCreated">등록일</option>
				</select>
				<input type="text" name="searchValue" class="boxTF">
				<button type="button" class="btn" onclick="searchList()">검색</button>
			</form>
		</td>
		
		<c:if test="${roll!='guest'}">
      <td align="right" width="100">
          <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/event/created.do?page=${page}';">글올리기</button>
      </td>
      </c:if>
      
	</tr>
</table>

<br>
<br>
<br>
<div class="footer">
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>

<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery.ui.datepicker-ko.js"></script>
</body>
</html>