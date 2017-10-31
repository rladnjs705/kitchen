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
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=047fbf6a5f3a70d9e1be7af3d0178f4c"></script>


<link rel="stylesheet" href="<%=cp%>/resource/css/style.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/layout.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/jquery/css/smoothness/jquery-ui.min.css" type="text/css">
</head>

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
        border: 1px solid #bcbcbc;
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
      #article-sidebar {
     	display:inline-block;
        width: 290px;
        height: 700px;
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
      	height: 190px;
      	margin-bottom: 5px;
      }
      #article-sidebar-foot{
     	border: 1px solid #bcbcbc; 
      	position: relative;
      	clear: left;
      	float: left;
      	width: 295px;
      	margin-bottom: 10px;
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
	    cursor:cursor;
	    border-radius:4px;
	    background: #FF0000;
	    font-size: 22px;
	  }
	  #select-menu-order {
	  	border-bottom: 1px solid #bcbcbc;
	  	width: 295px;
	  }
      
  
</style>



<body>

<div class="header">
    <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>

<!-- 매장정보 및 좋아요(개수) -->
<!-- 좋아요 개수는 하트 클릭 시 1씩 증가(단, 한 ID 당 1개의 좋아요만 가능) -->

<div>
	<div id="article-container" align="left" style="background: #F6F6F6;"><h2>또순이네 - 당산점</h2></div>
	<div id="article-container_bottom">
		<div style="float: left; width: 15%" align="center"><img src="<%=cp%>/resource/images/1.png" width="100px;" height="100px"></div>
		<div style="float: left; width: 80%; margin-left: 10px;"><img src="<%=cp%>/resource/images/heart.PNG" style="margin-bottom: 5px; margin-right: 5px" width="25px" height="25px"><br>10개<br><br><b>최소주문금액 : </b>15,000원 이상<br><b>결제방법 : </b>현금, 카드</div>
	</div>
</div>

<!-- 메뉴 선택 -->
<!-- 메뉴 이미지, 내용 클릭하면 사이드바(결제)로 메뉴 추가 --> 
<form>
	<div id="article-content" align="left">
       	<div style="float: left; width: 20%;" align="center"><a href="#"><img src="<%=cp%>/resource/images/1.png" width="85px;" height="85px"></a></div>
       	<div style="float: left; border-left:1px solid #bcbcbc; height: 90px; padding-left: 10px;"><a href="#">비빔밥<br><br>나물, 소고기, 고추장 등의 재료가 들어간 한국 대표 음식<br><br>가격 : 9,000원</a></div>
	</div>
</form>      

<!-- 사이드바(결제, map, 주소) -->
<!-- 메뉴 선택 시  각 메뉴(금액) 아래로 나열됨 총 금액, 결제하기 -->
<form>
	<div id="article-sidebar" align="left">
       
        	<div id="article-sidebar-head">
        		<div style="background: #EAEAEA; height:30px; border-bottom: 1px solid #F6F6F6; padding-top: 10px; padding-bottom: 10px;"><h2 align="center">선 택 메 뉴</h2></div>
        		<div id="select-menu-order" style="height: 335px;">
        			<div style="295px; padding-top: 20px; padding-left: 10px; padding-right: 10px; border-bottom: 1px solid #bcbcbc;">
        				<div style="float: left;">비빔밥</div>
        				<div style="float: right;">금액</div>
        			</div>
        			<div style="295px; padding-top: 20px; padding-left: 10px; padding-right: 10px; border-bottom: 1px solid #bcbcbc;">
        				<div style="float: left;">비빔밥</div>
        				<div style="float: right;">금액</div>
        			</div>
        			<div style="295px; padding-top: 20px; padding-left: 10px; padding-right: 10px; border-bottom: 1px solid #bcbcbc;">
        				<div style="float: left;">비빔밥</div>
        				<div style="float: right;">금액</div>
        			</div>
        			<div style="295px; padding-top: 20px; padding-left: 10px; padding-right: 10px; border-bottom: 1px dashed #bcbcbc;">
        				<div style="float: right;">총금액</div>
        			</div>
        			
        		</div>
        		
        		        			
        			
        		
        			<a href="<%=cp%>/menu/payment.do">
        		<button type="button" class="btn"><b>주 문 하 기</b></button>
        		</a>
        	</div>
      	
        	
        	<!-- MAP -->
        	<div id="map" style="width:297px;height:190px;"></div>
        	<script>
				var container = document.getElementById('map'); // 지도를 표시할 div
				var options = {
					center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심 좌표
					level: 3 // 지도의 확대 레벨
				};

				var map = new daum.maps.Map(container, options); // 지도를 생성합니다.
				
				
				var markerPosition  = new daum.maps.LatLng(33.450701, 126.570667); // 마커가 표시될 위치  
				
				var marker = new daum.maps.Marker({position: markerPosition}); // 마커 생성
				
				marker.setMap(map); // 마커가 지도에 표시되도록 설정
			</script>
			
			<!-- 주소지 -->
      		<div id="article-sidebar-foot" style="font-size: 11px;">서울특별시 영등포구 선유로47길 16 오오1004빌딩<br><br>지번 : 지번주소 서울특별시 영등포구 양평동4가 81<br><br>전화번호 : 02-2672-2255</div>
    	<a href="<%=cp%>/menu/created.do"><button type="button" style="background: #efefef; width: 100px; height: 30px; float: bottom;">메뉴등록</button></a>
    </div>
   </form>    

<div class="footer">
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>

</body>
</html>