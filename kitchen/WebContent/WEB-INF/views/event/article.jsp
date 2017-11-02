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

</script>

<script>
  $( function() {
    $( "#accordion" ).accordion();
  } );
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

<script type="text/javascript">
function deleteEvent(eventNum) {
	if(confirm("이 게시물을 삭제 하시겠습니까 ?")) {
		var url="<%=cp%>/event/delete.do?eventNum="+eventNum+"&page=${page}";
		location.href=url;
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
<br><br>



<table style="width: 700px; margin: 0px auto 0px; border-spacing: 0px;">
<tr height="40">
	<td align="left" class="title">
		<h3><span>|</span> 이벤트 게시판</h3>
	</td>
</tr>
</table>

<table style="width: 700px; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
<tr height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
	<td colspan="2" align="center">
		${dto.eventSubject}
	</td>
</tr>

<tr height="35" style="border-bottom: 1px solid #cccccc;">
	<td width="50%" align="left" style="padding-left: 5px;">
		작성자 : ${dto.userName}
	</td>
	<td width="50%" align="right" style="padding-right: 5px;">
		${dto.eventCreated} | 조회 ${dto.eventHitcount}
	</td>
</tr>

<tr style="border-bottom: 1px solid #cccccc;">
	<td colspan="2" align="left" style="padding: 10px 5px;" valign="top" height="200">
		${dto.eventContent}
	</td>
</tr>

<tr height="35" style="border-bottom: 1px solid #cccccc;">
	<td colspan="2" align="left" style="padding-left: 5px;">
		이전글 : 
			<c:if test="${not empty preReadDto}">
				<a href="<%=cp%>/event/article.do?${query}&eventNum=${preReadDto.eventNum}">${preReadDto.eventSubject}</a>
			</c:if>
			<c:if test="${empty preReadDto}">이전글이 존재하지 않습니다.</c:if>
	</td>
</tr>

<tr height="35" style="border-bottom: 1px solid #cccccc;">
	<td colspan="2" align="left" style="padding-left: 5px;">
	다음글 :
		<c:if test="${not empty nextReadDto}">
			<a href="<%=cp%>/event/article.do?${query}&eventNum=${nextReadDto.eventNum}">${nextReadDto.eventSubject}</a>
		</c:if>
		<c:if test="${empty nextReadDto}">다음글이 존재하지 않습니다.</c:if>
	</td>
</tr>
</table>

<table style="width: 700px; margin: 0px auto 20px; border-spacing: 0px;">
<tr height="45">

		<c:if test="${roll!='guest'}">
	<td width="300" align="left">
	<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/event/update.do?eventNum=${dto.eventNum}&page=${page}';">
		수정</button>
			<button type="button" class="btn" onclick="deleteEvent('${dto.eventNum}');">삭제</button>
		</td>
	</c:if>
	
		<td align="right">
			<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/event/list.do?${query}';">리스트</button>	
	</td>
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