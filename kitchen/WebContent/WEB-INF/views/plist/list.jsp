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
<title>질문과답변입니다.</title>

<link rel="stylesheet" href="<%=cp%>/resource/css/style.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/layout.css" type="text/css">
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/js/util.js"></script>
<link rel="stylesheet" href="<%=cp%>/resource/jquery/css/smoothness/jquery-ui.min.css" type="text/css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>

<script>
$(function() {
  $( "#datepicker1" ).datepicker({
    dateFormat: 'yy-mm-dd',
    prevText: '이전 달',
    nextText: '다음 달',
    monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
    monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
    dayNames: ['일','월','화','수','목','금','토'],
    dayNamesShort: ['일','월','화','수','목','금','토'],
    dayNamesMin: ['일','월','화','수','목','금','토'],
    showMonthAfterYear: true,
    changeMonth: true,
    changeYear: true,
    yearSuffix: '년'
  });
});
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

input[type=text].datetype{padding:4px 2px 5px 25px; width:95px; border:1px solid #CACACA;
                 font-size:11px; color:#666;
                 background:url('<%=cp%>/resource/images/btn_date.png') no-repeat 2px 2px; background-size:15px}

</style>
<script type="text/javascript">

function dateCheck(){
	var f=document.dateForm;
	if(f.searchDateValue1.value>f.searchDateValue2.value){
		//됨ㅋ
		alert("이전 날짜와 이후날짜가 바뀌었습니다. 다시 설정해주세요.");
		return;
	}
	f.action="<%=cp%>/plist/list.do";
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
            <h3>결제내역 | </h3>
</div>

<br><br>

<form name="dateForm" method="post" >
<table style="width: 800px; margin: 1px auto 0px;">
	<tbody>
		<tr height="10">
			<td class="title">
				<div style="font-size: 20px; margin-left: 10px;">
				&ensp;&ensp;&ensp;&ensp;&ensp;
				<span style="font-size: 14px;">기간별 조회</span>
				<input id="datepicker1" type="text" name="searchDateValue1"/>
				&ensp;~&ensp;<input type="hidden" name="userId" value="${userId}">
				<input id="datepicker1" type="text" name="searchDateValue2" />
				<input type="button" class="btn" onclick="dateCheck();" value="조회">
				</div>
			</td>
		</tr>
	</tbody>
</table>
</form>



<table style="width: 800px; margin: 1px auto 0px;">
	<tbody>
		<tr align="center" bgcolor="#eeeeee" height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
	      <th width="300" style="color: #787878;">주문 날짜</th>
	      <th width="300" style="color: #787878;">지점명(링크)</th>
	      <th width="300" style="color: #787878;">지불금액</th>
  		</tr>
		
		<tr>
	<c:forEach var="dto" items="${list}">
		<tr align="center" bgcolor="#ffffff" height="35" style="text-align: center; border-bottom: 1px solid #cccccc;">
		      <td>${dto.purchasedate}</td>
		      <td align="center" style=" padding-left: 10px;">
		           <a href="<%=cp%>/menu/article.do?page=1&state=${dto.categoryname}&shopNum=${dto.shopnum}">${dto.shopname}</a>
		      </td>
		      <td>${dto.purchaseprice}</td>
	  	</tr>
  	</c:forEach>
  </tr>
	</tbody>
	
  
</table>
	${paging}

</div>

<div class="footer">
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>






</body>
</html>