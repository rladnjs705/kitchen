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
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script>
  $( function() {
    $( "#datepicker" ).datepicker();
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
if(typeof String.prototype.trim !== 'function') {
	String.prototype.trim = function() {
		var TRIM_PATTERN = /(^\s*)|(\s*$)/g
		return this.replace(TRIM_PATTERN, "");
	};
}

function sendEvent() {
	var f = document.eventForm;
	
	var str = f.eventSubject.value;
	if(!str) {
		alert("제목을 입력하세요. ");
		f.eventSubject.focus();
		return;
	}
	
	str = f.eventContent.value;
	if(!str) {
		alert("내용을 입력하세요. ");
		f.eventContent.focus();
		return;
	}
	
function notHangul(obj) {
		
	obj.value=obj.value.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g,'');
}
	
	var mode="${mode}";
	if(mode=="created")
		f.action = "<%=cp%>/event/created_ok.do";
	else if(mode=="update")
		f.action = "<%=cp%>/event/update_ok.do";
		
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
      <li><a href="<%=cp%>/notice/list.do">공지사항 </a></li>
      <li><a href="<%=cp%>/bbs/list.do">문의하기</a></li>
      <li><a href="<%=cp%>/qna/qna.do">자주묻는질문</a></li> 
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


<table style="width: 1000px; margin: 0px auto 0px; border-spacing: 0px;">
<tr height="45">
	<td align="left" class="title">
		<h3><span>|</span> 이벤트 게시판</h3>
	</td>
</tr>
</table>

<form name="eventForm" method="post">
	<table style="width: 1000px; margin: 0px auto 0px; border-spacing: 0px; border-collapse: collapse;">
	<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
		<td width="100" bgcolor="#eeeeee" style="text-align: center;">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
		<td style="padding-left:10px;">
			<input type="text" name="eventSubject" maxlength="100" class="boxTF" style="width: 95%;" value="${dto.eventSubject}">
			
		</td>
	</tr>
	
	<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
		<td width="100" bgcolor="#eeeeee" style="text-align: center;">작성자</td>
		<td style="padding-left: 10px;">
			${sessionScope.member.userId}
			</td>
		</tr>
		
	<tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
		<td width="100" bgcolor="#eeeeee" style="text-align: center;">이벤트종료일</td>
			
		<td style="padding-left:10px;">
		
			<!-- 글 업로드시 날짜 -->
			<p>Date: <input type="text" id="datepicker" name="eventEnd" value="${dto.eventEnd}"></p>
		</td>
	</tr>
		
	<tr align="left" style="border-bottom: 1px solid #cccccc;">
		<td width="100" bgcolor="#eeeeee" style="text-align: center; padding-top:5px;" valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
		<td valign="top" style="padding:5px 0px 5px 10px;">
			<textarea name="eventContent" rows="12" class="boxTA" style="width:95%; height:400px">${dto.eventContent}</textarea>
		</td>
	</tr>
	</table>
	
	<table style="width: 1000px; margin: 0px auto; border-spacing: 0px;">
		<tr height="45">
			<td align="center">
				<button type="button" class="btn" onclick="sendEvent();">${mode=='update'?'수정완료':'등록하기'}</button>
				<button type="reset" class="btn">다시입력</button>
				<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/event/list.do';">${mode=='update'?'수정취소':'등록취소'}</button>
				<c:if test="${mode=='update'}">
					<input type="hidden" name="eventNum" value="${dto.eventNum}">
					<input type="hidden" name="page" value="${page}">
				</c:if>
			</td>
		</tr>
	</table>
</form>

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