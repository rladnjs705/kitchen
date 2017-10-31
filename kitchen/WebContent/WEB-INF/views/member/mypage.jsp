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
 font-size: 25px;
 font-family:"Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
 text-align: left; 
 width: 800px; 
 height: 100px;
}

</style>

</head>
<body>


<div class="container">
    <div class="body-container" style="width: 1600px;">
        <div class="tabs">
            <span class="tab signin active"><a href="#">My Page</a></span>
        </div>
        
        <div align="center">
        	<table style="margin-top: 100px;">
        		<tr align="center" style="text-align: right;">
        			<td style="font-weight: 900;">아이디</td>
        			<td class="td">&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;${userId}</td>
        		</tr>
        		<tr align="center" style="text-align: right;">
        			<td style="font-weight: 900;">이름</td>
        			<td class="td">&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;${userName}</td>
        		</tr>
        		<tr align="center" style="text-align: right;">
        			<td style="font-weight: 900;">포인트</td>
        			<td class="td">&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;kddkkdkddk</td>
        		</tr>
        		<tr align="center" style="text-align: right;">
        			<td style="font-weight: 900;">전화번호</td>
        			<td class="td">&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;kddkkdkddk</td>
        		</tr>
        		<tr align="center" style="text-align: right;">
        			<td style="font-weight: 900;">이메일</td>
        			<td class="td">&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;kddkkdkddk</td>
        		</tr>
        		<tr align="center" style="text-align: right;">
        			<td style="font-weight: 900;">주소</td>
        			<td class="td">&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;kddkkdkddk</td>
        		</tr>
        		<tr align="center" style="text-align: right;">
        			<td></td>
        			<td style="width: 200px; height: 100px;">
        			<button type="button" class="submit">돌아가기</button>
        			<button type="button" class="submit" style="float: left;">거래내역 조회</button>
        			<button type="button" class="submit">수정</button>
        			</td>
        		</tr>
        	</table>
        
        
        
        
        
        
        
        </div>
        
        
        
        
        
        
        
    </div>
</div>



</body>
</html>