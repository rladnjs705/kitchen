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
  // 좌우의 공백을 제거하는 함수
  if(typeof String.prototype.trim !== 'function') {
    String.prototype.trim = function() {
        var TRIM_PATTERN = /(^\s*)|(\s*$)/g;
        return this.replace(TRIM_PATTERN, "");
    };
  }

  
  function sendBoard() {
        var f = document.boardForm;
		
    	var str = f.subject.value;
        if(!str) {
            alert("제목을 입력하세요. ");
            f.subject.focus();
            return;
        }

    	str = f.content.value;
        if(!str) {
            alert("내용을 입력하세요. ");
            f.content.focus();
            return;
        }
        
        //var size = document.getElementById("fileInput").files[0].size;
        //if(size>1024*1024*20){
	    //    alert("파일크기는 최대 **입니다.");
        //	return;
        //}

        var mode="${mode}";
        if(mode=="created")
            f.action = "<%=cp%>/notice/created_ok.do";
        else if(mode=="update")
            f.action = "<%=cp%>/notice/update_ok.do";

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

<div class="containerList">
<table style="width: 900px; margin: auto; border-spacing: 0px;">
<tr height="45">
	<td align="left" class="title">
		<h3><span>|</span> 공지사항</h3>
	</td>
</tr>
</table>

<form name="boardForm" method="post" enctype="multipart/form-data">	<!-- enctype="multipart/form-data" 이게 있어야 파일업로드가능! -->
  <table style="width: 900px; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
      <td width="100" bgcolor="#eeeeee" style="text-align: center;">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
      <td style="padding-left:10px;"> 
        <input type="text" name="subject" maxlength="100" class="boxTF" style="width: 60%;" value ="${dto.subject}">
        																						<!-- update일 때만 value값나온다. -->
	    <label for="isNotice">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;공지여부</label> 
	    <c:if test="${dto.notice=='1'}">
	    	<input type="checkbox" checked="checked" name="isNotice">
	    </c:if> 
	    <c:if test="${dto.notice!='1'}">
	    	<input type="checkbox" name="isNotice">
	    </c:if>       																						
      </td>
  </tr>

  <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
      <td width="100" bgcolor="#eeeeee" style="text-align: center;">작성자</td>
      <td style="padding-left:10px;"> 
        	${sessionScope.member.userName}
      </td>
  </tr>

  <tr align="left" style="border-bottom: 1px solid #cccccc;"> 
  
      <td width="100" bgcolor="#eeeeee" style="text-align: center; padding-top:5px;" valign="middle">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
      <td valign="top" style="padding:5px 0px 5px 10px;"> 
        <textarea name="content" rows="12" class="boxTA" style="width: 95%;" >${dto.content}</textarea>
      </td>
  </tr>
<c:if test="${not empty dto.saveFileName}">
	<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
	
	 <!-- 수정필요-3 -->
		
		<td width="100" bgcolor="#eeeeee" align="center">기존 첨부파일</td>
		<td style="padding-left: 10px;">
			${dto.saveFileName}&nbsp;
			<label for="male"><span style="font-family: Wingdings">x</span></label>
  			<input type="image" name="deleteFile" id="male" value="" onclick="deleteFile();">
		</td>
	</tr>
</c:if>
	<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
		<td width="100" bgcolor="#eeeeee" align="center">첨부파일</td>
		<td style="padding-left: 10px;">
			<input type="file" id="fileInput" name="upload" class="boxTF" style="width: 95%; height: 25px;">
		</td>
	</tr>
	
	<!-- 수정필요 -2 -->
	
	<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
		<td width="100" bgcolor="#eeeeee" align="center">비밀번호</td>
		<td style="padding-left: 10px;">
			<input type="password" id="pwd" name="pwd" class="boxTF" style="width: 30%;">
		</td>
	</tr>

  </table>

  <table style="width: 600px; margin: auto; border-spacing: 0px;">
     <tr height="45"> 
      <td align="center">
        <c:if test="${mode=='update'}">
        <input type="hidden" name = "num" value="${dto.num}">
        <input type="hidden" name = "page" value="${page}">
        <input type="hidden" name="saveFilename" value="${dto.saveFileName}">
        <input type="hidden" name="originalFilename" value="${dto.originalFileName}">
        </c:if>
        <button type="button" class="btn" onclick="sendBoard();">${mode=="created"?"등록하기":"수정완료"}</button>
        <button type="reset" class="btn">다시입력</button>
        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/notice/list.do?page=${page}';">${mode=="created"?"등록취소":"수정취소"}</button>
      </td>
    </tr>
  </table>
</form>
</div>
<div class="footer">
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery.ui.datepicker-ko.js"></script>
</body>
</html>