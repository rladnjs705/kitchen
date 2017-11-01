<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String cp=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=cp%>/resource/jquery/js/jquery-ui.min.js" type="text/js">
<link rel="stylesheet" href="<%=cp%>/resource/jquery/js/jquery-1.12.4.min.js" type="text/js">
<link rel="stylesheet" href="<%=cp%>/resource/jquery/css/smoothness/jquery-ui.min.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/style.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/layout.css" type="text/css">
<style type="text/css">
@charset "UTF-8";
body{
	font-size: 14px;
}
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
.td{
 font-size: 20px;
 font-family:"Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
 text-align: left; 
 width: 800px; 
 height: 60px;
}

</style>

<script type="text/javascript">
function send(){
	var f=document.mypageForm;
	
	f.action="<%=cp%>/member/memberUpdate.do";
	f.submit();
}


</script>



</head>
<body>
<div class="header">
    <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>

<div class="container">
    <div class="body-container" style="width: 1600px;">
        <div class="tabs">
            <span class="tab signin active"><a href="<%=cp%>/member/mypage.do">My Page</a></span>
        </div>
        
        <div align="center">
        	<form name="mypageForm" method="post">
        	<table style="width: 60%; margin-bottom: 100px;">
        	
        		<tr style="text-align: right;">
        			<td><button type="button" class="submit" style="float: left;">결제내역 조회</button></td>
        			<td style="width: 200px; height: 100px;">
        			<button type="button" class="submit" style="margin-right: 100px; margin-left: 20px;" onclick="javascript:location.href='<%=cp%>/shop/shopmenu.do';">돌아가기</button>
        			
        			<button type="button" class="submit" onclick="send();">수정</button>
        			</td>
        		</tr>
        		<tr style="text-align: right;">
        			<td style="font-weight: 900;">아이디</td>
        			<td class="td">&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;${userId}<input type="hidden" name="userId" value="${userId}"></td>
        		</tr>
        		<tr style="text-align: right;">
        			<td style="font-weight: 900;">이름</td>
        			<td class="td">&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;${userName}<input type="hidden" name="userName" value="${userName}"></td>
        		</tr>
        		<tr style="text-align: right;">
        			<td style="font-weight: 900;">생년월일</td>
        			<td class="td">&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;${member.birth}<input type="hidden" name="birth" value="${member.birth}"></td>
        		</tr>
        		<tr style="text-align: right;">
        			<td style="font-weight: 900;">포인트</td>
        			<td class="td">&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;${member.point}</td>
        		</tr>
        		<tr style="text-align: right;">
        			<td style="font-weight: 900;">전화번호</td>
        			<td class="td">&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;${member.tel}<input type="hidden" name="tel" value="${member.tel}"></td>
        		</tr>
        		<tr style="text-align: right;">
        			<td style="font-weight: 900;">이메일</td>
        			<td class="td">&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;${member.email}<input type="hidden" name="email" value="${member.email}"></td>
        		</tr>
        		<tr style="text-align: right;">
        			<td style="font-weight: 900;">주소</td>
        			<td class="td">
        			<input type="hidden" name="zip" value="${member.zip}">
        			&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;
        			${member.addr_1}
        			<input type="hidden" name="addr_1" value="${member.addr_1}">
        			&ensp;&ensp;
        			나머지주소: ${member.addr_2}
        			<input type="hidden" name="addr_1" value="${member.addr_2}">
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


</body>
</html>