<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
   String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Kwon's Kitchen</title>
<link rel="stylesheet" href="<%=cp%>/resource/css/style.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/layout.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/jquery/css/smoothness/jquery-ui.min.css" type="text/css">
</head>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<style>

	  #article-height{
		min-height:900px;
	  }
	  #article-container {
        width: 940px;
        margin: 0px auto;
        padding-top: 8px;
        padding-bottom: 8px;
        padding-left: 15px;
        padding-right: 15px;
        border-bottom: 1px solid #bcbcbc;
        margin-bottom: 20px;
      }
      #article-container_bottom {
        width: 940px;
        height: 100px;
        margin: 0px auto;
        padding-top: 8px;
        padding-bottom: 8px;
        padding-left: 15px;
        padding-right: 15px;
        border-bottom: 1px solid #bcbcbc;
        border-left: 1px solid #bcbcbc;
        border-right: 1px solid #bcbcbc;
        margin-bottom: 10px;
      }
      #article-content {
      	display:inline-block;
        width: 660px;
        height: 90px;
        margin-bottom: 10px;
        float: left;
        border: 1px solid #bcbcbc;
        margin-left: 24.4%;
      }
      #article-content-pay {
      	display:inline-block;
        width: 660px;
        height: 100px;
        margin-bottom: 10px;
        float: left;
        border: 1px solid #bcbcbc;
        margin-left: 24.4%;
      }
      #article-sidebar {
     	display:inline-block;
        width: 290px;
        height: 650px;
        margin-bottom: 30px;
    	margin-left:13px;
        margin-right: 24.8%;
      }
      #article-sidebar-head{
     	border: 1px solid #bcbcbc; 
      	width: 295px;
      	float: left;
      	height: 430px;
      	margin-bottom: 5px;
      }
      #article-sidebar-body{
      	border: 1px solid #bcbcbc; 
      	clear: left;
      	float: left;
      	width: 295px;
      	height: 100px;
      	margin-bottom: 5px;
      }
      #article-sidebar-foot{
     	border: 1px solid #bcbcbc; 
      	position: relative;
      	clear: left;
      	float: left;
      	width: 295px;
      	left: 0;
      	bottom: 0px;
      }
      .btn {
      	width: 295px;
      	height: 44px;
	    color:white;;
	    font-weight:500;
	    font-family:"Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
	    border:1px solid #cccccc;
	    background-color:#fff;
	    text-align:center;
	    border-radius:4px;
	    background: #FF0000;
	    font-size: 22px;
	  }
	  #select-menu-order {
	  	border-bottom: 1px solid #bcbcbc;
	  	width: 295px;
	  }
	  #payment-button{
	  
	  }
    
}

</style>

<script type="text/javascript">


</script>

<body>

<div class="header">
    <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>

<div>
	<div id="article-container" align="left"><h1>결 제 페 이 지</h1></div>
</div>
 
<form>
	<div id="article-content" align="left">
       	<div style="float: left; width: 20%; height:60px; padding-top: 30px; background: #D5D5D5;" align="center"><h2 align="center">주 소 정 보</h2></div>
       	<div style="float: left; border-left:1px solid #bcbcbc; height: 90px; padding-left: 5px;">
       		<div style="width: 500px; padding: 5px;">
       			<div style="height: 50%; width:70px; float: left;"><h3 style="padding-top: 8px;">주 소</h3></div>
       			<div style="float: left; width: 380px;"><input type="text" style="width: 430px; height: 30px; margin-bottom: 5px; border-radius: 3px;"></div>
       			<div style="height: 50%; width:70px; float: left;"><h3 style="padding-top: 8px;">상세주소</h3></div>
       			<div style="float: left; width: 380px;"><input type="text" style="width: 430px; height: 30px; border-radius: 3px;"></div>
			</div>
       	</div>
	</div>
</form>    

<form>
	<div id="article-content" align="left">
       	<div style="float: left; width: 20%; height:60px; padding-top: 30px; background: #D5D5D5;" align="center"><h2 align="center">전 화 번 호</h2></div>
       	<div style="float: left; border-left:1px solid #bcbcbc; height: 90px; padding-left: 5px;">
       		<div style="width: 500px; padding: 5px;">
       			<div style="height: 50%; width:70px; float: left;"><h3 style="padding-top: 8px;">휴대전화</h3></div>
       			<div style="float: left; width: 380px;"><input type="text" style="width: 430px; height: 30px; margin-bottom: 5px; border-radius: 3px;"></div>
       			<div style="height: 50%; width:55px;; float: left;"><h3 style="padding-top: 8px;">집전화</h3></div>
       			<div style="float: left; width: 380px;"><input type="text" style="width: 430px; height: 30px; margin-left: 15px; border-radius: 3px;"></div>
			</div>
       	</div>
	</div>
</form>

<form>
	<div id="article-content" align="left">
       	<div style="float: left; width: 20%; height:60px; padding-top: 30px; background: #D5D5D5;" align="center"><h3 align="center">주문 시 요청사항</h3></div>
       	<div style="float: left; border-left:1px solid #bcbcbc; height: 90px; padding-left: 5px;">
       		<div style="width: 400px; padding: 5px;">
       			<div style="width: 380px;"><input type="text" style="width: 505px; height: 75px; margin-bottom: 5px; border-radius: 3px;"></div>
			</div>
       	</div>
	</div>
</form>

<form>
	<div id="article-content" align="left">
       	<div style="float: left; width: 20%; height:60px; padding-top: 30px; background: #D5D5D5;" align="center"><h2 align="center">포인트 내역</h2></div>
       	<div style="float: left; border-left:1px solid #bcbcbc; height: 90px; padding-left: 5px;">
       		<div style="width: 500px; padding: 5px;">
       			<div style="width: 120px; float: left; margin-bottom: 8px;">사용가능포인트 : </div>
       			<div style="width: 380px; float: left; margin-bottom: 8px;">300 point</div>
       			<div style="width: 120px; float: left; margin-bottom: 8px;">사용할 포인트 : </div>
       			<input type="text" style="width: 70px; float: left; margin-bottom: 8px;">&nbsp;point
			</div>
       	</div>
	</div>
</form>

<form>
	<div id="article-content-pay" align="left">
       	<div style="float: left; width: 20%; height:70px; padding-top: 32px; background: #D5D5D5;" align="center"><h2 align="center">결 제 방 법</h2></div>
       	<div style="float: left; border-left:1px solid #bcbcbc; height: 100px; padding-left: 5px; width: 520px;">
       		<div id="btn1" style="width: 520px; padding: 2px;">
       			<div>
       				<h2><input id="payment-button" type="button" style="float: left; margin-top: 3px; background-color: white;" value="현금결제"></h2>
       			</div>
       			<div>
       				<input id="payment-button" type="button" style="float: left; margin-top: 3px; margin-left: 16px; background-color: white;" value="카드결제">
       			</div>
       			<div>
       				<input id="payment-button" type="button" style="float: left; margin-top: 3px; margin-left: 16px; background-color: white;"  value="포인트결제">
       			</div>
			</div>
       	</div>
	</div>
</form>

<!-- 사이드바-->
<form action="<%=cp%>/menu/payment.do" method="post">
	<div id="article-sidebar" align="left">
        	<div id="article-sidebar-head">
        		<div style="background: #D5D5D5; height:30px; border-bottom: 1px solid #F6F6F6; padding-top: 10px; padding-bottom: 10px; "><h2 align="center">선 택 메 뉴</h2></div>
        		<div id="select-menu-order" style="height: 335px;">
        		<c:forEach var="dto" items="${list}">
        			<div style="295px; padding-top: 20px; padding-left: 10px; padding-right: 10px; border-bottom: 1px solid #bcbcbc;">
        				<div style="float: left;">메뉴 : ${dto.menuname}</div>
        				<div style="float: right;">가격 : ${dto.menuprice}</div>
        			</div>
				</c:forEach>
        			<div style="295px; padding-top: 20px; padding-left: 10px; padding-right: 10px; border-bottom: 1px dashed #bcbcbc;">
        				<div style="float: right;">총금액 : 원</div>
        			</div>
        			
        		</div>
        			
        		<button type="submit" class="btn"><b>주 문 하 기</b></button>
        		</div>
    </div>
</form>    

<div class="footer">
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>

</body>
</html>