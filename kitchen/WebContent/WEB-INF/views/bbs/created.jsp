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
<title>spring</title>

<link rel="stylesheet" href="<%=cp%>/resource/css/style.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/layout.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/menubar.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/jquery/css/smoothness/jquery-ui.min.css" type="text/css">

<script type="text/javascript" src="<%=cp%>/resource/js/util.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
  function sendOk() {
      var f = document.boardForm;
var format;

var mode="${mode}";
var type="${type}";

if(type=="inquiry"){
	format = /^01([0|1|6|7|8|9])/;
	if(! format.test(f.tel1.value)) {
   		alert("전화번호를 확인해주세요.");
   		f.tel1.focus();
   		return false;
   	}
	
	format = /^[0-9]{3,4}/;
	if(! format.test(f.tel2.value)) {
   		alert("전화번호를 확인해주세요.");
   		f.tel2.focus();
   		return false;
   	}
	
	format = /^[0-9]{4}/;
	if(! format.test(f.tel3.value)) {
   		alert("전화번호를 확인해주세요.");
   		f.tel3.focus();
   		return false;
   	}
}
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
      
      str = f.pwd.value;
      if(!str) {
    	  
          alert("비밀번호를 입력하세요. ");
          f.pwd.focus();
          return;
      }

  	
  	if(mode=="created"){
  		if(type=="inquiry")
  			f.action="<%=cp%>/bbs/created_ok.do";
		else
			f.action="<%=cp%>/bbs/reply_ok.do";
	}
	else if(mode=="update"){
			f.action="<%=cp%>/bbs/update_ok.do";
	}
	
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
      <li><a href="<%=cp%>/bbs/list.do"  style="background: rgb(71,71,71);">문의하기</a></li>
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

<div class="container">
    <div class="body-container" style="width: 700px;">
        <div>
			<form name="boardForm" method="post" enctype="multipart/form-data">
			  <table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
			   <tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">작성자</td>
			      <td style="padding-left:10px;"> 
			          ${sessionScope.member.userName}
			      </td>
			  </tr>
			  <c:if test="${type=='inquiry'}">
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">연락처</td>
			      <td style="padding-left:10px;"> 
			      <input type="text" name="tel1" maxlength="100" class="boxTF" style="width: 10%;" value ="${tel1}">&nbsp;-&nbsp;
			      <input type="text" name="tel2" maxlength="100" class="boxTF" style="width: 10%;" value ="${tel2}">&nbsp;-&nbsp;
			      <input type="text" name="tel3" maxlength="100" class="boxTF" style="width: 10%;" value ="${tel3}">
			      </td>
			  </tr>
			 
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">문의유형</td>
			      <td style="padding-left:10px;">
			       <select id="questionType" name="questionType" class="selectField">
		            	<option value="store">매장문의</option>
		                <option value="delivery">배달문의</option>
		                <option value="system">시스템오류문의</option>
		                <option value="cooperate" >제휴문의</option>
		                <option value="and">기타</option>
            	  </select> 
			      </td>
			  </tr>
			   </c:if>
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
			      <td style="padding-left:10px;"> 
			      <input type="text" name="subject" maxlength="100" class="boxTF" style="width: 60%;" value ="${dto.subject}">
			      </td>
			  </tr>
			
			  <tr align="left" style="border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center; padding-top:5px;" valign="middle">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
			      <td valign="top" style="padding:5px 0px 5px 10px;"> 
			        <textarea name="content" rows="12" class="boxTA" style="width: 95%;">${dto.content}</textarea>
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
			  <tr align="left" height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
			      <td width="100" bgcolor="#eeeeee" style="text-align: center;">비밀번호</td>
			      <td style="padding-left:10px;"> 
			      <input type="password" name="pwd" maxlength="100" class="boxTF" style="width: 60%;" value ="">
			      </td>
			  </tr>
			  </table>
			
			  <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			     <tr height="45"> 
			      <td align="center" >
			        <button type="button" class="btn" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}</button>
			        <button type="reset" class="btn">다시입력</button>
			        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/bbs/list.do';">${mode=='update'?'수정취소':'등록취소'}</button>
			     	<c:if test="${type=='reply'}">
                    <input type="hidden" name="page" value="${page}">
                    <input type="hidden" name="groupNum" value="${dto.groupNum}">
                    <input type="hidden" name="orderNo" value="${dto.orderNo}">
                    <input type="hidden" name="depth" value="${dto.depth}">
                    <input type="hidden" name="parent" value="${dto.questionNum}">
              		</c:if>
			     	<c:if test="${mode=='update'}">
			        <input type="hidden" name = "num" value="${dto.questionNum}">
			        <input type="hidden" name = "page" value="${page}">
			        <input type="hidden" name="saveFilename" value="${dto.saveFileName}">
			        <input type="hidden" name="originalFilename" value="${dto.originalFileName}">
			        </c:if>
			      </td>
			    </tr>
			  </table>
			</form>
        </div>

    </div>
</div>

<div class="footer">
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>

<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery.ui.datepicker-ko.js"></script>
</body>
</html>