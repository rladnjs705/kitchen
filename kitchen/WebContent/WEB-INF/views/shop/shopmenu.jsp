﻿<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
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
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>spring</title>

<link rel="stylesheet" href="<%=cp%>/resource/jquery/css/smoothness/jquery-ui.min.css" type="text/css" />
<link rel="stylesheet" href="<%=cp%>/resource/bootstrap/css/bootstrap.min.css" type="text/css" />
<link rel="stylesheet" href="<%=cp%>/resource/bootstrap/css/bootstrap-theme.min.css" type="text/css" />

<link rel="stylesheet" href="<%=cp%>/resource/css/style.css" type="text/css" />
<link rel="stylesheet" href="<%=cp%>/resource/css/layout.css" type="text/css" />

<style type="text/css">
.imgLayout {
	height: 50%;
	padding: 10px 5px 10px;
	margin: 15px auto 0px;
	border: 1px solid #DAD9FF;
	background: #F6F6F6;
}

.subject {
	font-family: sans-serif;
	font-size: 21px;
	width: 190px;
	height: 25px;
	line-height: 25px;
	margin: 5px auto 0px;
	display: inline-block;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	cursor: pointer;
	text-align: center;
}
.button {
	display: inline-block;
	zoom: 1; /* zoom and *display = ie7 hack for display:inline-block */
	*display: inline;
	vertical-align: baseline;
	margin: 0 2px;
	outline: none;
	cursor: pointer;
	text-align: center;
	text-decoration: none;
	font: 14px/100% Arial, Helvetica, sans-serif;
	padding: .5em 2em .55em;
	text-shadow: 0 1px 1px rgba(0,0,0,.3);
	-webkit-border-radius: .5em; 
	-moz-border-radius: .5em;
	border-radius: .5em;
	-webkit-box-shadow: 0 1px 2px rgba(0,0,0,.2);
	-moz-box-shadow: 0 1px 2px rgba(0,0,0,.2);
	box-shadow: 0 1px 2px rgba(0,0,0,.2);
}
.button:hover {
	text-decoration: none;
}
.button:active {
	position: relative;
	top: 1px;
}
.gray {
	color: #e9e9e9;
	border: solid 1px #555;
	background: #6e6e6e;
	background: -webkit-gradient(linear, left top, left bottom, from(#888), to(#575757));
	background: -moz-linear-gradient(top,  #888,  #575757);
	filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#888888', endColorstr='#575757');
}
.gray:hover {
	background: #616161;
	background: -webkit-gradient(linear, left top, left bottom, from(#757575), to(#4b4b4b));
	background: -moz-linear-gradient(top,  #757575,  #4b4b4b);
	filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#757575', endColorstr='#4b4b4b');
}
.gray:active {
	color: #afafaf;
	background: -webkit-gradient(linear, left top, left bottom, from(#575757), to(#888));
	background: -moz-linear-gradient(top,  #575757,  #888);
	filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#575757', endColorstr='#888888');
}

.bigrounded {
	-webkit-border-radius: 2em;
	-moz-border-radius: 2em;
	border-radius: 2em;
}
.medium {
	font-size: 12px;
	padding: .4em 1.5em .42em;
}
.small {
	font-size: 11px;
	padding: .2em 1em .275em;
}
.white {
	color: #606060;
	border: solid 1px #b7b7b7;
	background: #fff;
	background: -webkit-gradient(linear, left top, left bottom, from(#fff), to(#ededed));
	background: -moz-linear-gradient(top,  #fff,  #ededed);
	filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff', endColorstr='#ededed');
}
.white:hover {
	background: #ededed;
	background: -webkit-gradient(linear, left top, left bottom, from(#fff), to(#dcdcdc));
	background: -moz-linear-gradient(top,  #fff,  #dcdcdc);
	filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff', endColorstr='#dcdcdc');
}
.white:active {
	color: #999;
	background: -webkit-gradient(linear, left top, left bottom, from(#ededed), to(#fff));
	background: -moz-linear-gradient(top,  #ededed,  #fff);
	filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#ededed', endColorstr='#ffffff');
}
</style>

<script type="text/javascript"
	src="<%=cp%>/resource/jquery/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(function(){ 
	$("#allCheck").click(function(){
		if($("#allCheck").prop("checked")) { 
		$("input[type=checkbox]").prop("checked",true);
		} else { 
		$("input[type=checkbox]").prop("checked",false);
		} 
	});
});
function deleteShop() {  //체크한 리스트 삭제
	   var f = document.listForm;
	   var cnt=0;
	   
	   if(f.checkbox==undefined)
	      return;
	   
	   if(f.checkbox.length!=undefined){  //체크박스가 둘이상
	      for(var i=0;i<f.checkbox.length;i++){
	         if(f.checkbox[i].checked)
	            cnt++;
	      }
	   
	   }else{ //체크박스가 하나인경우
	      if(f.checkbox.checked)
	         cnt++;
	   }
	   
	   if(cnt==0){
	      alert("선택한 항목이 없습니다.");
	      return;
	   }
	   
	   if(confirm("선택한 항목을 삭제하시겟습니까?")){
	      f.action="<%=cp%>/shop/deleteList.do";
	      f.submit();
	   }
	      
	}
function article(shopNum) {
	var url="${articleUrl}&shopNum="+shopNum;
	location.href=url;
}

</script>

</head>
<body>

	<div class="header">
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</div>

	<form name="listForm" id="listForm" action="" method="post">
		<div class="container" role="main">
			<div class="col-sm-8"
				style="float: none; margin-left: auto; margin-right: auto;">

				<div class="body-title">
					<h3>
						<img src="<%=cp%>/resource/images/food.png"
							style="width: 40px; height: 40px;">${state}</h3>
				</div>
				<div style="clear: both; height: 30px; line-height: 30px;">

					<div style="float: left;">
						${dataCount}개(${page}/${total_page} 페이지)</div>
					&nbsp; <br> 
					 <c:if test="${roll!='guest'}">
					<div style="float: left;">
						<input id="allCheck" type="checkbox" onclick="check();"/>
						전체선택
					</div>
					</c:if>
					<div style="float: right;">&nbsp;</div>
				</div>
				<div style="clear: both;">
					<div class="row">
						<c:forEach var="dto" items="${list}">
							<div class="col-sm-6">
								<div class="imgLayout">
									<div style="white-space: nowrap; overflow: auto;" class="inner">
										<img src="<%=cp%>/resource/images/${dto.saveFilename}"										
											style="width: 20%; height: 70px; float: left;"> <span
											class="subject"
											onclick="javascript:article('${dto.shopNum}');"
											style="float: left; font-size: 18px; font-weight: bold;" onclick="javascript:article('${dto.shopNum}');">
											${dto.shopName} </span>
										<div style="float: left; color: #8C8C8C; font-size: 13px;">
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${dto.created}
										</div>
										<div style="color: #FF6C6C; padding: 5px;" align="right">
											${dto.shopStart}~${dto.shopEnd} &nbsp;<input type="checkbox"
												name="checkbox" value="${dto.shopNum}" />
											<hr>
										</div>
										<div style="font-size: 13px; margin: 0px 0px 0px 50px;">${dto.content}</div>
										<div style="clear: both;"></div>
										<div style="float: left; color: #6B66FF; padding: 5px;">${dto.shopZip1}<br>
											${dto.shopAddr1} - ${dto.shopAddr2}
										</div>
										<div style="font-size: 15px; float: right;">배달 소요시간: | ${dto.shopTime} 분
											 <c:if test="${roll!='guest'}">
											<button type="button" class="button gray small"
											onclick="javascript:location.href='<%=cp%>/shop/update.do?shopNum=${dto.shopNum}&${query}';">
											수정
											</button>
											</c:if>
										</div>	
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>


				<div class="paging"
					style="text-align: center; min-height: 50px; line-height: 50px;">
					<c:if test="${dataCount==0 }">
	                  등록된 게시물이 없습니다.
	            </c:if>
					${paging}

				</div>

				<div style="clear: both;">
					<div style="float: left; width: 20%; min-width: 85px;">
						&nbsp;</div>
					<div style="float: left; width: 60%; text-align: center;">
						&nbsp;</div>
					 <c:if test="${roll!='guest'}">
					<div
						style="float: left; width: 20%; min-width: 85px; text-align: right;">
						<button type="button" class="button white bigrounded"
							onclick="javascript:location.href='<%=cp%>/shop/created.do';">
							<span class="glyphicon glyphicon glyphicon-pencil"></span> 매장등록
						</button>
						<button type="button" class="button white bigrounded" style="margin: 5px;"
							onclick="deleteShop('${dto.shopNum}');">
						 매장삭제
						</button>
					</div>
					</c:if>
				</div>
			</div>
		</div>
	</form>


	<div class="footer">
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	</div>

	<script type="text/javascript"
		src="<%=cp%>/resource/jquery/js/jquery-ui.min.js"></script>
	<script type="text/javascript"
		src="<%=cp%>/resource/jquery/js/jquery.ui.datepicker-ko.js"></script>
	<script type="text/javascript"
		src="<%=cp%>/resource/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>