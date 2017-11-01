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
<link rel="stylesheet" href="<%=cp%>/resource/jquery/js/jquery-ui.min.js" type="text/js">
<link rel="stylesheet" href="<%=cp%>/resource/jquery/js/jquery-1.12.4.min.js" type="text/js">
<link rel="stylesheet" href="<%=cp%>/resource/jquery/css/smoothness/jquery-ui.min.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/style.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/layout.css" type="text/css">


<style type="text/css">
@charset "UTF-8";
* {
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
}
p{
	width: 100%;
}
.container {
	margin-top: 5px;
    width:100%;
    text-align:left;
}

.body-container {
	width: 100px;
    clear:both;
    margin: 0px auto 15px;
    min-height: 400px;
}
input {
  font-size: 14px;
  width: 100%;
  height: 20px;
  padding: 16px 13px;
  color: #000000;
  border: 1px solid #d9d9d9;
  background: transparent;
  -moz-border-radius: 2px;
  -webkit-border-radius: 2px;
  border-radius: 2px;
}
input::-webkit-input-placeholder {
  font-size: 14px;
  color: #999999;
  font-family: 'Lato', sans-serif;
}
input:-moz-placeholder {
  font-size: 14px;
  color: #999999;
  font-family: 'Lato', sans-serif;
}
input::-moz-placeholder {
  font-size: 14px;
  color: #999999;
  font-family: 'Lato', sans-serif;
}
input:-ms-input-placeholder {
  font-size: 14px;
  color: #999999;
  font-family: 'Lato', sans-serif;
}
input:focus {
  border-color: #999999;
}
button.submit {
  float: right;
  margin-left: 1px;
  font-size: 14px;
  line-height: 42px;
  display: block;
  width: 150px;
  height: 42px;
  cursor: pointer;
  vertical-align: middle;
  letter-spacing: 2px;
  text-transform: uppercase;
  color: #263238;
  border: 1px solid #263238;
  background: transparent;
  -moz-border-radius: 5px;
  -webkit-border-radius: 2px;
  border-radius: 2px;
}
button.submit:hover {
  background-color: #263238;
  color: #ffffff;
  -moz-transition: all 0.2s;
  -o-transition: all 0.2s;
  -webkit-transition: all 0.2s;
  transition: all 0.2s;
}
input:focus {
  outline: none;
}
button.submit {
  float: right;
  margin-left: 1px;
  font-size: 14px;
  line-height: 42px;
  display: block;
  width: 150px;
  height: 42px;
  cursor: pointer;
  vertical-align: middle;
  letter-spacing: 2px;
  text-transform: uppercase;
  color: #263238;
  border: 1px solid #263238;
  background: transparent;
  -moz-border-radius: 5px;
  -webkit-border-radius: 2px;
  border-radius: 2px;
}
button.submit:hover {
  background-color: #263238;
  color: #ffffff;
  -moz-transition: all 0.2s;
  -o-transition: all 0.2s;
  -webkit-transition: all 0.2s;
  transition: all 0.2s;
}
body .container .tabs {
  width: 100%;
  margin-bottom: 29px;
  border-bottom: 1px solid #000000;
}
body .container .tabs .tab {
  display: inline-block;
  margin-bottom: -1px;
  padding: 20px 15px 10px;
  cursor: pointer;
  letter-spacing: 0;
  border-bottom: 1px solid #000000;
  -moz-user-select: -moz-none;
  -ms-user-select: none;
  -webkit-user-select: none;
  user-select: none;
  transition: all 0.1s ease-in-out;
}
body .tabs .tab a {
  font-size: 14px;
  text-decoration: none;
  text-transform: uppercase;
  color: #000000;
  transition: all 0.1s ease-in-out;
}
body .tabs .tab.active a, body .container .tabs .tab:hover a {
  color: #263238;
}
body .tabs .tab.active {
  border-bottom: 1px solid #000000;
}

.selectField {
    border:1px solid #999999;
    padding:2px 5px 4px;
    border-radius:4px;
    font-family:"Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
}

</style>


<script type="text/javascript">

function isValidDateFormat(str){
	var n=str.match(/-/g);
	if(n==2 && str.length==10){
		return true;
	}
	return false;
}


function memberOk() {
	var f = document.memberForm;
	var str;

	str = f.userId.value;
	str = str.trim();
	if(!str) {
		alert("아이디를 입력하세요. ");
		f.userId.focus();
		return;
	}
	if(!/^[a-z][a-z0-9_]{4,9}$/i.test(str)) { 
		alert("아이디는 5~10자이며 첫글자는 영문자이어야 합니다.");
		f.userId.focus();
		return;
	}
	f.userId.value = str;

	str = f.userPwd.value;
	str = str.trim();
	if(!str) {
		alert("패스워드를 입력하세요. ");
		f.userPwd.focus();
		return;
	}
	if(!/^(?=.*[a-z])(?=.*[!@#$%^*+=-]|.*[0-9]).{5,10}$/i.test(str)) { 
		alert("패스워드는 5~10자이며 하나 이상의 숫자나 특수문자가 포함되어야 합니다.");
		f.userPwd.focus();
		return;
	}
	f.userPwd.value = str;

	if(str!= f.userPwdCheck.value) {
        alert("패스워드가 일치하지 않습니다. ");
        f.userPwdCheck.focus();
        return;
	}
	
    str = f.userName.value;
	str = str.trim();
    if(!str) {
        alert("이름을 입력하세요. ");
        f.userName.focus();
        return;
    }
    f.userName.value = str;

    str = f.birth.value;
	str = str.trim();
	if(str != ""){
		if(isValidDateFormat(str)){
			alert("생년월일을 정확히 입력하세요 YYYY-MM-DD");
			
			f.birth.focus();
			return;
		}
	}
    
    str = f.tel1.value;
	str = str.trim();
    if(!str) {
        alert("전화번호를 입력하세요. ");
        f.tel1.focus();
        return;
    }

    str = f.tel2.value;
	str = str.trim();
    if(!str) {
        alert("전화번호를 입력하세요. ");
        f.tel2.focus();
        return;
    }
    if(!/^(\d+)$/.test(str)) {
        alert("숫자만 가능합니다. ");
        f.tel2.focus();
        return;
    }

    str = f.tel3.value;
	str = str.trim();
    if(!str) {
        alert("전화번호를 입력하세요. ");
        f.tel3.focus();
        return;
    }
    if(!/^(\d+)$/.test(str)) {
        alert("숫자만 가능합니다. ");
        f.tel3.focus();
        return;
    }
    
    str = f.email1.value;
	str = str.trim();
    if(!str) {
        alert("이메일을 입력하세요. ");
        f.email1.focus();
        return;
    }

    str = f.email2.value;
	str = str.trim();
    if(!str) {
        alert("이메일을 입력하세요. ");
        f.email2.focus();
        return;
    }

    var mode="${mode}";
    if(mode=="created") {
    	f.action = "<%=cp%>/member/memberCreatedSubmit.do";
    } else if(mode=="update") {
    	f.action = "<%=cp%>/member/memberUpdateSubmit.do";
    }

    f.submit();
}

function changeEmail() {
    var f = document.memberForm;
	    
    var str = f.selectEmail.value;
    if(str!="direct") {
        f.email2.value=str; 
        f.email2.readOnly = true;
        f.email1.focus(); 
    }
    else {
        f.email2.value="";
        f.email2.readOnly = false;
        f.email1.focus();
    }
}

function userIdCheck() {
	var f= document.memberForm;
	str = f.userId.value;
	if(!/^[a-z][a-z0-9_]{4,9}$/i.test(str)) { 
		alert("아이디는 5~10자이며 첫글자는 영문자이어야 합니다.");
		f.userId.focus();
		return;
	}
	f.action="<%=cp%>/member/userIdCheck.do";
	f.submit();
}
</script>
</head>
<body>

<div>
    <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>
	
<div class="container">
    <div class="body-container" style="width: 1600px;">
        <div class="tabs">
            <span class="tab signin active"><a href="#">Sign up</a></span>
        </div>
			        	
			        	<c:if test="${mode=='created'}">
        
        <div style="width: 100%;">
			<form name="memberForm" method="post">
			  <table style="width: 100%; margin: 20px auto 0px; margin-left: 300px; border-spacing: 0px;">
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">아이디</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			      
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <input type="text" name="userId" id="userId" value="${userId}"
                         onchange="userIdCheck();" style="width: 30%;"
                         maxlength="15" placeholder="아이디"> ${userId!=null ? (userIdCheck>=1 ? '<span style="color: red;">중복된 아이디 입니다.</span>' : '사용 가능 합니다.') : '아이디를 입력해 주세요.' }
			        </p>
			        <p class="help-block">아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.</p>
			      </td>
			  </tr>
			
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">패스워드</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <input type="password" name="userPwd" maxlength="15"
			                       style="width: 30%;" placeholder="패스워드">
			        </p>
			        <p class="help-block">패스워드는 5~10자 이내이며, 하나 이상의 숫자나 특수문자가 포함되어야 합니다.</p>
			      </td>
			  </tr>
			
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">패스워드 확인</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <input type="password" name="userPwdCheck" maxlength="15"
			                       style="width: 30%;" placeholder="패스워드 확인">
			        </p>
			        <p class="help-block">패스워드를 한번 더 입력해주세요.</p>
			      </td>
			  </tr>
			
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">이름</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <input type="text" name="userName" value="${dto.userName}" maxlength="30"
		                      style="width: 40%;"
		                      placeholder="이름">
			        </p>
			      </td>
			  </tr>
			
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">생년월일</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <input type="text" name="birth" value="${dto.birth}" maxlength="10" 
			                       style="width: 40%;" placeholder="생년월일">
			        </p>
			        <p class="help-block">생년월일은 2000-01-01 형식으로 입력 합니다.</p>
			      </td>
			  </tr>
			  
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">이메일</label>
			      </td>
			      <td width="100" style="padding: 0 0 15px 15px;">
			      	
			            <select name="selectEmail" onchange="changeEmail();" class="selectField">
			                <option value="">선 택</option>
			                <option value="naver.com" ${dto.email2=="naver.com" ? "selected='selected'" : ""}>네이버 메일</option>
			                <option value="hanmail.net" ${dto.email2=="hanmail.net" ? "selected='selected'" : ""}>한 메일</option>
			                <option value="hotmail.com" ${dto.email2=="hotmail.com" ? "selected='selected'" : ""}>핫 메일</option>
			                <option value="gmail.com" ${dto.email2=="gmail.com" ? "selected='selected'" : ""}>지 메일</option>
			                <option value="direct">직접입력</option>
			            </select>

			            <input type="text" name="email1" value="${dto.email1}" size="13" maxlength="20" style="width: 20%;">
			            @<input type="text" name="email2" value="${dto.email2}" size="13" maxlength="30" readonly="readonly" style="width: 30%;">
			      </td>
			  </tr>
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">전화번호</label>
			      </td>
			      <td width="100" style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <select class="selectField" id="tel1" name="tel1" >
			                <option value="">선 택</option>
			                <option value="010" ${dto.tel1=="010" ? "selected='selected'" : ""}>010</option>
			                <option value="011" ${dto.tel1=="011" ? "selected='selected'" : ""}>011</option>
			                <option value="016" ${dto.tel1=="016" ? "selected='selected'" : ""}>016</option>
			                <option value="017" ${dto.tel1=="017" ? "selected='selected'" : ""}>017</option>
			                <option value="018" ${dto.tel1=="018" ? "selected='selected'" : ""}>018</option>
			                <option value="019" ${dto.tel1=="019" ? "selected='selected'" : ""}>019</option>
			            </select>
			            -
			            <input type="text" name="tel2" value="${dto.tel2}" maxlength="4" style="width: 10%;">
			            -
			            <input type="text" name="tel3" value="${dto.tel3}" maxlength="4" style="width: 10%;">
			        </p>
			      </td>
			  </tr>
			  
			  <tr>
			  		<td width="100" valign="top" style="text-align: right; padding-top: 18px;">
			            <label style="font-weight: 900;">주소</label>
			      	</td>
			  		<td width="100" style="padding: 0 0 15px 15px;">
			  			<p style="height: 50px; margin-top: 1px; margin-bottom: 5px;">
						<button style="height: 35px; float: left;" class="btn" type="button" onclick="sample6_execDaumPostcode()">우편번호 찾기</button>
						<input style="width: 200px; margin-left: 2px;" type="text" name="zip" id="sample6_postcode" placeholder="우편번호">
			  			</p>
			  			<p style="margin-top: 1px; margin-bottom: 5px;">
							<input style="width: 300px;" type="text" name="addr_1" id="sample6_address" placeholder="주소">
							<input style="width: 250px;" type="text" name="addr_2" id="sample6_address2" placeholder="상세주소">			  		
			  			</p>
			  		</td>
			  </tr>
				  <tr>
				      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
				            <label style="font-weight: 900;">약관동의</label>
				      </td>
				      <td width="100px" style="margin-top: 1px; margin-bottom: 5px;">
					      	<p style="width: 150px; text-align: center; margin-left: 2px; margin-top: 5px; margin-bottom: 5px;">
				      			<a href="#">이용약관</a>에 동의합니다.
					      		<input style="margin-left: 100px;" id="agree" name="agree" type="checkbox" checked="checked"
					                      onchange="form.sendButton.disabled = !checked" >
					      	</p>
				      </td>
				  </tr>
			  </table>
			
			  <table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
			     <tr height="45"> 
			      <td align="center">
			        <button type="reset" class="submit">다시입력</button>
			        <button type="button" class="submit" onclick="javascript:location.href='<%=cp%>/';" style="margin-left: 10px; margin-right: 10px;">가입취소</button>
			        <button type="button" name="sendButton" class="submit" onclick="memberOk();">회원가입</button>
			      </td>
			    </tr>
			    <tr height="30">
			        <td align="center" style="color: blue;">${message}</td>
			    </tr>
			  </table>
			</form>
        </div>
							</c:if>
							
							
							
							
							<c:if test="${mode=='update'}">
							
		<div style="width: 100%;">
			<form name="memberForm" method="post">
			  <table style="width: 100%; margin: 20px auto 0px; margin-left: 300px; border-spacing: 0px;">
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">아이디</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			      
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <input type="text" name="userId" id="userId" value="${userId}"
                         onchange="userIdCheck();" style="width: 30%;"
                         maxlength="15" readonly="readonly" placeholder="아이디">
			        </p>
			        <p class="help-block">아이디는 5~10자 이내이며, 첫글자는 영문자로 시작해야 합니다.</p>
			      </td>
			  </tr>
			
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">패스워드</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <input type="password" name="userPwd" maxlength="15"
			                       style="width: 30%;" placeholder="패스워드">
			        </p>
			        <p class="help-block">패스워드는 5~10자 이내이며, 하나 이상의 숫자나 특수문자가 포함되어야 합니다.</p>
			      </td>
			  </tr>
			
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">패스워드 확인</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <input type="password" name="userPwdCheck" maxlength="15"
			                       style="width: 30%;" placeholder="패스워드 확인">
			        </p>
			        <p class="help-block">패스워드를 한번 더 입력해주세요.</p>
			      </td>
			  </tr>
			
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">이름</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <input type="text" name="userName" value="${userName}" maxlength="30"
		                      style="width: 40%;" readonly="readonly"
		                      placeholder="이름">
			        </p>
			      </td>
			  </tr>
			
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">생년월일</label>
			      </td>
			      <td style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <input type="text" name="birth" value="${birth}" maxlength="10" 
			                       style="width: 40%;" readonly="readonly" placeholder="생년월일">
			        </p>
			        <p class="help-block">생년월일은 2000-01-01 형식으로 입력 합니다.</p>
			      </td>
			  </tr>
			  
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">이메일</label>
			      </td>
			      <td width="100" style="padding: 0 0 15px 15px;">
			      	
			            <select name="selectEmail" onchange="changeEmail();" class="selectField">
			                <option value="">선 택</option>
			                <option value="naver.com" ${dto.email2=="naver.com" ? "selected='selected'" : ""}>네이버 메일</option>
			                <option value="hanmail.net" ${dto.email2=="hanmail.net" ? "selected='selected'" : ""}>한 메일</option>
			                <option value="hotmail.com" ${dto.email2=="hotmail.com" ? "selected='selected'" : ""}>핫 메일</option>
			                <option value="gmail.com" ${dto.email2=="gmail.com" ? "selected='selected'" : ""}>지 메일</option>
			                <option value="direct">직접입력</option>
			            </select>

			            <input type="text" name="email1" size="13" maxlength="20" style="width: 20%;">
			            @<input type="text" name="email2" size="13" maxlength="30" readonly="readonly" style="width: 30%;">
			      </td>
			  </tr>
			  <tr>
			      <td width="100" valign="top" style="text-align: right; padding-top: 5px;">
			            <label style="font-weight: 900;">전화번호</label>
			      </td>
			      <td width="100" style="padding: 0 0 15px 15px;">
			        <p style="margin-top: 1px; margin-bottom: 5px;">
			            <select class="selectField" id="tel1" name="tel1" >
			                <option value="">선 택</option>
			                <option value="010" ${dto.tel1=="010" ? "selected='selected'" : ""}>010</option>
			                <option value="011" ${dto.tel1=="011" ? "selected='selected'" : ""}>011</option>
			                <option value="016" ${dto.tel1=="016" ? "selected='selected'" : ""}>016</option>
			                <option value="017" ${dto.tel1=="017" ? "selected='selected'" : ""}>017</option>
			                <option value="018" ${dto.tel1=="018" ? "selected='selected'" : ""}>018</option>
			                <option value="019" ${dto.tel1=="019" ? "selected='selected'" : ""}>019</option>
			            </select>
			            -
			            <input type="text" name="tel2" maxlength="4" style="width: 10%;">
			            -
			            <input type="text" name="tel3" maxlength="4" style="width: 10%;">
			        </p>
			      </td>
			  </tr>
			  
			  <tr>
			  		<td width="100" valign="top" style="text-align: right; padding-top: 18px;">
			            <label style="font-weight: 900;">주소</label>
			      	</td>
			  		<td width="100" style="padding: 0 0 15px 15px;">
			  			<p style="height: 50px; margin-top: 1px; margin-bottom: 5px;">
						<button style="height: 35px; float: left;" class="btn" type="button" onclick="sample6_execDaumPostcode()">우편번호 찾기</button>
						<input style="width: 200px; margin-left: 2px;" type="text" name="zip" id="sample6_postcode" placeholder="우편번호">
			  			</p>
			  			<p style="margin-top: 1px; margin-bottom: 5px;">
							<input style="width: 300px;" type="text" name="addr_1" id="sample6_address" placeholder="주소">
							<input style="width: 250px;" type="text" name="addr_2" id="sample6_address2" placeholder="상세주소">			  		
			  			</p>
			  		</td>
			  </tr>
			  </table>
			
			  <table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
			     <tr height="45"> 
			      <td align="center">
			        <button type="reset" class="submit">다시입력</button>
			        <button type="button" class="submit" onclick="javascript:location.href='<%=cp%>/member/mypage.do';" style="margin-left: 10px; margin-right: 10px;">수정취소</button>
			        <button type="button" name="sendButton" class="submit" onclick="memberOk();">수정완료</button>
			      </td>
			    </tr>
			    <tr height="30">
			        <td align="center" style="color: blue;">${message}</td>
			    </tr>
			  </table>
			</form>
        </div>
        						</c:if>
    </div>
</div>

<div class="footer">
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>

<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('sample6_address').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('sample6_address2').focus();
            }
        }).open();
    }
</script>


</body>
</html>