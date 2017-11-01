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
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>spring</title>

<link rel="stylesheet" href="<%=cp%>/resource/css/style.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/layout.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/jquery/css/smoothness/jquery-ui.min.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/bootstrap/css/bootstrap.min.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/resource/bootstrap/css/bootstrap-theme.min.css" type="text/css"/>

<script type="text/javascript" src="<%=cp%>/resource/js/util.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-1.12.4.min.js"></script>

<script type="text/javascript">
function result(){
	var ans="${result}";
	if(ans=="succeed"){
		alert("가입이 완료 되었습니다.");	
		return;
	}else if(ans=="fail"){
		alert("가입 실패 했습니다. 다시 시도해주세요.");
		return;
	}else{
		return;
	}
	
}


</script>


</head>
<body onload="result();">
<div class="main-header">
	<img src="<%=cp%>/resource/images/main.jpg" width="550px" height="550px"
	style="margin-left: auto; margin-right: auto; display: block;"/>
</div><br>
<div style="height: 200px; width: 100%;">
<ul class="nav">
	<li>
		<a href="<%=cp%>/shop/shopmenu.do?state=한식" class="main-a">
		<img src="<%=cp%>/resource/images/1.png" width="200" height="200">
		 </a>
	 </li>
	<li>
		<a href="<%=cp%>/shop/shopmenu.do?state=일식" class="main-a" style="width: 210px;">
		<img src="<%=cp%>/resource/images/2.png" width="200" height="200">
		 </a>
	 </li>
	<li>
		<a href="<%=cp%>/shop/shopmenu.do?state=양식" class="main-a" style="width: 210px;">
		<img src="<%=cp%>/resource/images/6.png" width="200" height="200">
		 </a>
	</li>
	<li>
		<a href="<%=cp%>/shop/shopmenu.do?state=중식" class="main-a" style="width: 210px;">
		<img src="<%=cp%>/resource/images/3.png" width="200" height="200">
		 </a>
	 </li>
	<li>
		<a href="<%=cp%>/shop/shopmenu.do?state=치킨" class="main-a" style="width: 210px;">
		<img src="<%=cp%>/resource/images/5.png" width="200" height="200">
		 </a>
	 </li>
	<li>
		<a href="<%=cp%>/shop/shopmenu.do?state=피자" class="main-a" style="width: 210px;">
		<img src="<%=cp%>/resource/images/4.png" width="200" height="200">
		</a>
	</li>
</ul>
</div>
<br><br>
<div class="footer">
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>

<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery.ui.datepicker-ko.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>