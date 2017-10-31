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
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>spring</title>

<link rel="stylesheet" href="<%=cp%>/resource/jquery/css/smoothness/jquery-ui.min.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/resource/bootstrap/css/bootstrap.min.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/resource/bootstrap/css/bootstrap-theme.min.css" type="text/css"/>

<link rel="stylesheet" href="<%=cp%>/resource/css/style.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/resource/css/layout.css" type="text/css"/>

<style type="text/css">
.imgLayout{
	height: 50%;
	padding: 10px 5px 10px;
	margin: 15px auto 0px;
	border: 1px solid #DAD9FF;
	background: #F6F6F6;
}

.subject {
	 font-family: "Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
	 font-size: 21px;
     width:190px;
     height:25px;
     line-height:25px;
     margin:5px auto 0px;
     display: inline-block;
     white-space:nowrap;
     overflow:hidden;
     text-overflow:ellipsis;
     cursor: pointer;
     text-align: center;
}

</style>

<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
function article(num) {
	var url="${articleUrl}&num="+num;
	location.href=url;
}


</script>



</head>
<body>

<div class="header">
    <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>

<div class="container" role="main">
    <div class="col-sm-8" style="float:none; margin-left: auto; margin-right: auto;">
        
	    <div class="body-title">
	          <h3><img src="<%=cp%>/resource/images/food.png" style="width: 40px; height: 40px;"> 한식 </h3>
	    </div>

	<c:if test="${dataCount!=0}">    
	        <div style="clear: both; height: 30px; line-height: 30px;">
	            <div style="float: left;">${dataCount}개(${page}/${total_page} 페이지)</div>
	            <div style="float: right;">&nbsp;</div>
	        </div>
	        <div style="clear: both;">
	        
	                 <c:if test="${status.index==0}">
	                       <c:out value="<div style='clear: both; max-width:1100px; margin: 0px auto;'>" escapeXml="false"/>
	                 </c:if>
	                 <c:if test="${status.index!=0 && status.index%3==0}">
	                        <c:out value="</div><div style='clear: both; max-width:1100px; margin: 0px auto;'>" escapeXml="false"/>
	                 </c:if>
	        <div class="row">
	                <div class="col-sm-6">
				      <div class="imgLayout" >
		                     <div style="white-space:nowrap; overflow:auto;" class="inner">
		                     	<a href="#">
		                     	<img src="<%=cp%>/resource/images/1.png" style="width: 33%; height: 70px; float:left;">
		                     	</a>
		                     	<span class="subject" onclick="javascript:article('${dto.num}');" style="float:left; font-size: 18px;  font-weight: bold; ">
		                     	또순이네- 당산점
		                     	</span>
		                     	<div style="color: #FF6C6C;" align="right">
		                     	11:30 - 22:00
		                     	<hr></div>
		                     	<div style="clear: both;"></div>
		                     	<div style="float:left; color: #6B66FF; padding:5px;">서울 영등포구 선유로47길 16</div>
		                     	<div align="center">배달 소요시간: |  </div>
		                     </div>
	               		 </div>
				       </div>
	               <div class="col-sm-6">
				      <div class="imgLayout" >
		                     <div style="white-space:nowrap; overflow:auto;" class="inner">
		                     	<a href="#">
		                     	<img src="<%=cp%>/resource/images/1.png" style="width: 33%; height: 70px; float:left;">
		                     	</a>
		                     	<span class="subject" onclick="javascript:article('${dto.num}');" style="float:left; font-size: 18px;  font-weight: bold; ">
		                     	백반전문점-도봉쌍문점
		                     	</span>
		                     	<div style="color: #FF6C6C;" align="right">
		                     	10:00~20:00
		                     	<hr></div>
		                     	<div style="clear: both;"></div>
		                     	<div style="float:left; color: #6B66FF; padding:5px;">서울시 도봉구 방학동413-1</div>
		                     	<div align="center">배달 소요시간: |  </div>
		                     </div>
	               		 </div>
				       </div>
				     </div>
				  <div class="row">
	                <div class="col-sm-6">
				      <div class="imgLayout" >
		                     <div style="white-space:nowrap; overflow:auto;" class="inner">
		                     	<a href="#">
		                     	<img src="<%=cp%>/resource/images/1.png" style="width: 33%; height: 70px; float:left;">
		                     	</a>
		                     	<span class="subject" onclick="javascript:article('${dto.num}');" style="float:left; font-size: 18px;  font-weight: bold; ">
		                     	백반전문점-도봉쌍문점
		                     	</span>
		                     	<div style="color: #FF6C6C;" align="right">
		                     	10:00~20:00
		                     	<hr></div>
		                     	<div style="clear: both;"></div>
		                     	<div style="float:left; color: #6B66FF; padding:5px;">서울시 도봉구 방학동413-1</div>
		                     	<div align="center">배달 소요시간: |  </div>
		                     </div>
	               		 </div>
				       </div>
	               <div class="col-sm-6">
				      <div class="imgLayout" >
		                     <div style="white-space:nowrap; overflow:auto;" class="inner">
		                     	<a href="#">
		                     	<img src="<%=cp%>/resource/images/1.png" style="width: 33%; height: 70px; float:left;">
		                     	</a>
		                     	<span class="subject" onclick="javascript:article('${dto.num}');" style="float:left; font-size: 18px;  font-weight: bold; ">
		                     	백반전문점-도봉쌍문점
		                     	</span>
		                     	<div style="color: #FF6C6C;" align="right">
		                     	10:00~20:00
		                     	<hr></div>
		                     	<div style="clear: both;"></div>
		                     	<div style="float:left; color: #6B66FF; padding:5px;">서울시 도봉구 방학동413-1</div>
		                     	<div align="center">배달 소요시간: |  </div>
		                     </div>
	               		 </div>
				       </div>
				     </div>
				     <div class="row">
	                <div class="col-sm-6">
				      <div class="imgLayout" >
		                     <div style="white-space:nowrap; overflow:auto;" class="inner">
		                     	<a href="#">
		                     	<img src="<%=cp%>/resource/images/1.png" style="width: 33%; height: 70px; float:left;">
		                     	</a>
		                     	<span class="subject" onclick="javascript:article('${dto.num}');" style="float:left; font-size: 18px;  font-weight: bold; ">
		                     	백반전문점-도봉쌍문점
		                     	</span>
		                     	<div style="color: #FF6C6C;" align="right">
		                     	10:00~20:00
		                     	<hr></div>
		                     	<div style="clear: both;"></div>
		                     	<div style="float:left; color: #6B66FF; padding:5px;">서울시 도봉구 방학동413-1</div>
		                     	<div align="center">배달 소요시간: |  </div>
		                     </div>
	               		 </div>
				       </div>
	               <div class="col-sm-6">
				      <div class="imgLayout" >
		                     <div style="white-space:nowrap; overflow:auto;" class="inner">
		                     	<a href="#">
		                     	<img src="<%=cp%>/resource/images/1.png" style="width: 33%; height: 70px; float:left;">
		                     	</a>
		                     	<span class="subject" onclick="javascript:article('${dto.num}');" style="float:left; font-size: 18px;  font-weight: bold; ">
		                     	백반전문점-도봉쌍문점
		                     	</span>
		                     	<div style="color: #FF6C6C;" align="right">
		                     	10:00~20:00
		                     	<hr></div>
		                     	<div style="clear: both;"></div>
		                     	<div style="float:left; color: #6B66FF; padding:5px;">서울시 도봉구 방학동413-1</div>
		                     	<div align="center">배달 소요시간: |  </div>
		                     </div>
	               		 </div>
				       </div>
				     </div>
				     <div class="row">
	                <div class="col-sm-6">
				      <div class="imgLayout" >
		                     <div style="white-space:nowrap; overflow:auto;" class="inner">
		                     	<a href="#">
		                     	<img src="<%=cp%>/resource/images/1.png" style="width: 33%; height: 70px; float:left;">
		                     	</a>
		                     	<span class="subject" onclick="javascript:article('${dto.num}');" style="float:left; font-size: 18px;  font-weight: bold; ">
		                     	백반전문점-도봉쌍문점
		                     	</span>
		                     	<div style="color: #FF6C6C;" align="right">
		                     	10:00~20:00
		                     	<hr></div>
		                     	<div style="clear: both;"></div>
		                     	<div style="float:left; color: #6B66FF; padding:5px;">서울시 도봉구 방학동413-1</div>
		                     	<div align="center">배달 소요시간: |  </div>
		                     </div>
	               		 </div>
				       </div>
	               <div class="col-sm-6">
				      <div class="imgLayout" >
		                     <div style="white-space:nowrap; overflow:auto;" class="inner">
		                     	<a href="#">
		                     	<img src="<%=cp%>/resource/images/1.png" style="width: 33%; height: 70px; float:left;">
		                     	</a>
		                     	<span class="subject" onclick="javascript:article('${dto.num}');" style="float:left; font-size: 18px;  font-weight: bold; ">
		                     	백반전문점-도봉쌍문점
		                     	</span>
		                     	<div style="color: #FF6C6C;" align="right">
		                     	10:00~20:00
		                     	<hr></div>
		                     	<div style="clear: both;"></div>
		                     	<div style="float:left; color: #6B66FF; padding:5px;">서울시 도봉구 방학동413-1</div>
		                     	<div align="center">배달 소요시간: |  </div>
		                     </div>
	               		 </div>
				       </div>
				     </div>
				     <div class="row">
	                <div class="col-sm-6">
				      <div class="imgLayout" >
		                     <div style="white-space:nowrap; overflow:auto;" class="inner">
		                     	<a href="#">
		                     	<img src="<%=cp%>/resource/images/1.png" style="width: 33%; height: 70px; float:left;">
		                     	</a>
		                     	<span class="subject" onclick="javascript:article('${dto.num}');" style="float:left; font-size: 18px;  font-weight: bold; ">
		                     	백반전문점-도봉쌍문점
		                     	</span>
		                     	<div style="color: #FF6C6C;" align="right">
		                     	10:00~20:00
		                     	<hr></div>
		                     	<div style="clear: both;"></div>
		                     	<div style="float:left; color: #6B66FF; padding:5px;">서울시 도봉구 방학동413-1</div>
		                     	<div align="center">배달 소요시간: |  </div>
		                     </div>
	               		 </div>
				       </div>
	               <div class="col-sm-6">
				      <div class="imgLayout" >
		                     <div style="white-space:nowrap; overflow:auto;" class="inner">
		                     	<a href="#">
		                     	<img src="<%=cp%>/resource/images/1.png" style="width: 33%; height: 70px; float:left;">
		                     	</a>
		                     	<span class="subject" onclick="javascript:article('${dto.num}');" style="float:left; font-size: 18px;  font-weight: bold; ">
		                     	백반전문점-도봉쌍문점
		                     	</span>
		                     	<div style="color: #FF6C6C;" align="right">
		                     	10:00~20:00
		                     	<hr></div>
		                     	<div style="clear: both;"></div>
		                     	<div style="float:left; color: #6B66FF; padding:5px;">서울시 도봉구 방학동413-1</div>
		                     	<div align="center">배달 소요시간: |  </div>
		                     </div>
	               		 </div>
				       </div>
				     </div>
				     <div class="row">
	                <div class="col-sm-6">
				      <div class="imgLayout" >
		                     <div style="white-space:nowrap; overflow:auto;" class="inner">
		                     	<a href="#">
		                     	<img src="<%=cp%>/resource/images/1.png" style="width: 33%; height: 70px; float:left;">
		                     	</a>
		                     	<span class="subject" onclick="javascript:article('${dto.num}');" style="float:left; font-size: 18px;  font-weight: bold; ">
		                     	백반전문점-도봉쌍문점
		                     	</span>
		                     	<div style="color: #FF6C6C;" align="right">
		                     	10:00~20:00
		                     	<hr></div>
		                     	<div style="clear: both;"></div>
		                     	<div style="float:left; color: #6B66FF; padding:5px;">서울시 도봉구 방학동413-1</div>
		                     	<div align="center">배달 소요시간: |  </div>
		                     </div>
	               		 </div>
				       </div>
	               <div class="col-sm-6">
				      <div class="imgLayout" >
		                     <div style="white-space:nowrap; overflow:auto;" class="inner">
		                     	<a href="#">
		                     	<img src="<%=cp%>/resource/images/1.png" style="width: 33%; height: 70px; float:left;">
		                     	</a>
		                     	<span class="subject" onclick="javascript:article('${dto.num}');" style="float:left; font-size: 18px;  font-weight: bold; ">
		                     	백반전문점-도봉쌍문점
		                     	</span>
		                     	<div style="color: #FF6C6C;" align="right">
		                     	10:00~20:00
		                     	<hr></div>
		                     	<div style="clear: both;"></div>
		                     	<div style="float:left; color: #6B66FF; padding:5px;">서울시 도봉구 방학동413-1</div>
		                     	<div align="center">배달 소요시간: |  </div>
		                     </div>
	               		 </div>
				       </div>
				     </div>
				     <div class="row">
	                <div class="col-sm-6">
				      <div class="imgLayout" >
		                     <div style="white-space:nowrap; overflow:auto;" class="inner">
		                     	<a href="#">
		                     	<img src="<%=cp%>/resource/images/1.png" style="width: 33%; height: 70px; float:left;">
		                     	</a>
		                     	<span class="subject" onclick="javascript:article('${dto.num}');" style="float:left; font-size: 18px;  font-weight: bold; ">
		                     	백반전문점-도봉쌍문점
		                     	</span>
		                     	<div style="color: #FF6C6C;" align="right">
		                     	10:00~20:00
		                     	<hr></div>
		                     	<div style="clear: both;"></div>
		                     	<div style="float:left; color: #6B66FF; padding:5px;">서울시 도봉구 방학동413-1</div>
		                     	<div align="center">배달 소요시간: |  </div>
		                     </div>
	               		 </div>
				       </div>
	               <div class="col-sm-6">
				      <div class="imgLayout" >
		                     <div style="white-space:nowrap; overflow:auto;" class="inner">
		                     	<a href="#">
		                     	<img src="<%=cp%>/resource/images/1.png" style="width: 33%; height: 70px; float:left;">
		                     	</a>
		                     	<span class="subject" onclick="javascript:article('${dto.num}');" style="float:left; font-size: 18px;  font-weight: bold; ">
		                     	백반전문점-도봉쌍문점
		                     	</span>
		                     	<div style="color: #FF6C6C;" align="right">
		                     	10:00~20:00
		                     	<hr></div>
		                     	<div style="clear: both;"></div>
		                     	<div style="float:left; color: #6B66FF; padding:5px;">서울시 도봉구 방학동413-1</div>
		                     	<div align="center">배달 소요시간: |  </div>
		                     </div>
	               		 </div>
				       </div>
				     </div>
				     <div class="row">
	                <div class="col-sm-6">
				      <div class="imgLayout" >
		                     <div style="white-space:nowrap; overflow:auto;" class="inner">
		                     	<a href="#">
		                     	<img src="<%=cp%>/resource/images/1.png" style="width: 33%; height: 70px; float:left;">
		                     	</a>
		                     	<span class="subject" onclick="javascript:article('${dto.num}');" style="float:left; font-size: 18px;  font-weight: bold; ">
		                     	백반전문점-도봉쌍문점
		                     	</span>
		                     	<div style="color: #FF6C6C;" align="right">
		                     	10:00~20:00
		                     	<hr></div>
		                     	<div style="clear: both;"></div>
		                     	<div style="float:left; color: #6B66FF; padding:5px;">서울시 도봉구 방학동413-1</div>
		                     	<div align="center">배달 소요시간: |  </div>
		                     </div>
	               		 </div>
				       </div>
	               <div class="col-sm-6">
				      <div class="imgLayout" >
		                     <div style="white-space:nowrap; overflow:auto;" class="inner">
		                     	<a href="#">
		                     	<img src="<%=cp%>/resource/images/1.png" style="width: 33%; height: 70px; float:left;">
		                     	</a>
		                     	<span class="subject" onclick="javascript:article('${dto.num}');" style="float:left; font-size: 18px;  font-weight: bold; ">
		                     	백반전문점-도봉쌍문점
		                     	</span>
		                     	<div style="color: #FF6C6C;" align="right">
		                     	10:00~20:00
		                     	<hr></div>
		                     	<div style="clear: both;"></div>
		                     	<div style="float:left; color: #6B66FF; padding:5px;">서울시 도봉구 방학동413-1</div>
		                     	<div align="center">배달 소요시간: |  </div>
		                     </div>
	               		 </div>
				       </div>
				     </div>
				     <div class="row">
	                <div class="col-sm-6">
				      <div class="imgLayout" >
		                     <div style="white-space:nowrap; overflow:auto;" class="inner">
		                     	<a href="#">
		                     	<img src="<%=cp%>/resource/images/1.png" style="width: 33%; height: 70px; float:left;">
		                     	</a>
		                     	<span class="subject" onclick="javascript:article('${dto.num}');" style="float:left; font-size: 18px;  font-weight: bold; ">
		                     	백반전문점-도봉쌍문점
		                     	</span>
		                     	<div style="color: #FF6C6C;" align="right">
		                     	10:00~20:00
		                     	<hr></div>
		                     	<div style="clear: both;"></div>
		                     	<div style="float:left; color: #6B66FF; padding:5px;">서울시 도봉구 방학동413-1</div>
		                     	<div align="center">배달 소요시간: |  </div>
		                     </div>
	               		 </div>
				       </div>
	               <div class="col-sm-6">
				      <div class="imgLayout" >
		                     <div style="white-space:nowrap; overflow:auto;" class="inner">
		                     	<a href="#">
		                     	<img src="<%=cp%>/resource/images/1.png" style="width: 33%; height: 70px; float:left;">
		                     	</a>
		                     	<span class="subject" onclick="javascript:article('${dto.num}');" style="float:left; font-size: 18px;  font-weight: bold; ">
		                     	백반전문점-도봉쌍문점
		                     	</span>
		                     	<div style="color: #FF6C6C;" align="right">
		                     	10:00~20:00
		                     	<hr></div>
		                     	<div style="clear: both;"></div>
		                     	<div style="float:left; color: #6B66FF; padding:5px;">서울시 도봉구 방학동413-1</div>
		                     	<div align="center">배달 소요시간: |  </div>
		                     </div>
	               		 </div>
				       </div>
				     </div>
				     <div class="row">
	                <div class="col-sm-6">
				      <div class="imgLayout" >
		                     <div style="white-space:nowrap; overflow:auto;" class="inner">
		                     	<a href="#">
		                     	<img src="<%=cp%>/resource/images/1.png" style="width: 33%; height: 70px; float:left;">
		                     	</a>
		                     	<span class="subject" onclick="javascript:article('${dto.num}');" style="float:left; font-size: 18px;  font-weight: bold; ">
		                     	백반전문점-도봉쌍문점
		                     	</span>
		                     	<div style="color: #FF6C6C;" align="right">
		                     	10:00~20:00
		                     	<hr></div>
		                     	<div style="clear: both;"></div>
		                     	<div style="float:left; color: #6B66FF; padding:5px;">서울시 도봉구 방학동413-1</div>
		                     	<div align="center">배달 소요시간: |  </div>
		                     </div>
	               		 </div>
				       </div>
	               <div class="col-sm-6">
				      <div class="imgLayout" >
		                     <div style="white-space:nowrap; overflow:auto;" class="inner">
		                     	<a href="#">
		                     	<img src="<%=cp%>/resource/images/1.png" style="width: 33%; height: 70px; float:left;">
		                     	</a>
		                     	<span class="subject" onclick="javascript:article('${dto.num}');" style="float:left; font-size: 18px;  font-weight: bold; ">
		                     	백반전문점-도봉쌍문점
		                     	</span>
		                     	<div style="color: #FF6C6C;" align="right">
		                     	10:00~20:00
		                     	<hr></div>
		                     	<div style="clear: both;"></div>
		                     	<div style="float:left; color: #6B66FF; padding:5px;">서울시 도봉구 방학동413-1</div>
		                     	<div align="center">배달 소요시간: |  </div>
		                     </div>
	               		 </div>
				       </div>
				     </div>
				       

	    <c:set var="n" value="${list.size()}"/>
	    <c:if test="${n>0&&n%3!=0}">
			        <c:forEach var="i" begin="${n%3+1}" end="3" step="1">
				             <div class="imgLayout">&nbsp;</div>
			        </c:forEach>
	    </c:if>
		
	    <c:if test="${n!=0 }">
			       <c:out value="</div>" escapeXml="false"/>
	    </c:if>
	        </div>
	</c:if>
	
	        <div class="paging" style="text-align: center; min-height: 50px; line-height: 50px;">
	            <c:if test="${dataCount==0}">
	                  등록된 게시물이 없습니다.
	            </c:if>
	            <c:if test="${dataCount!=0}">
	                ${paging}
	            </c:if>
	        </div>        
	        
	        <div style="clear: both;">
	        		<div style="float: left; width: 20%; min-width: 85px;">
	        		    &nbsp;
	        		</div>
	        		<div style="float: left; width: 60%; text-align: center;">
	        		    &nbsp;
	        		</div>
	        		<div style="float: left; width: 20%; min-width: 85px; text-align: right;">
	        		    <button type="button" class="btn btn-primary btn-sm" onclick="javascript:location.href='<%=cp%>/shop/created.do';"><span class="glyphicon glyphicon glyphicon-pencil"></span> 등록하기</button>
	        		</div>
	        </div>
	        
	    </div>
		
    </div>


<div class="footer">
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>

<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery.ui.datepicker-ko.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>