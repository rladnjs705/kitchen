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
<link rel="stylesheet" href="<%=cp%>/resource/jquery/css/smoothness/jquery-ui.min.css" type="text/css">

<script type="text/javascript" src="<%=cp%>/resource/js/util.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
    function sendOk() {
        var f = document.boardForm;
		var format;
		
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

    	var mode="${mode}";
    	if(mode=="created")
    		f.action="<%=cp%>/bbs/created_ok.do?mode=${mode}";
    	else if(mode=="update")
    		f.action="<%=cp%>/";

        f.submit();
    }
   
</script>
</head>
<body>

<div class="header">
    <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
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
		            	<option value="매장문의">매장문의</option>
		                <option value="배달문의">배달문의</option>
		                <option value="시스템오류문의">시스템오류문의</option>
		                <option value="제휴문의" >제휴문의</option>
		                <option value="기타">기타</option>
            	  </select> 
			      </td>
			  </tr>
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