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

<script type="text/javascript">
$(function(){
	$(document).on("click", ".menuselect", function(){
		var menuname=$(this).attr("data-menuname");
		var menuprice=parseInt($(this).attr("data-menuprice"));
		var selectTotal=$("#selectTotal").text();
		selectTotal=parseInt(selectTotal)+menuprice;
		
		var s="<div style='295px; padding-top: 20px; padding-left: 10px; padding-right: 10px; border-bottom: 1px solid #bcbcbc;'>";
		s+="<div style='float: left;'>"+menuname+"</div>";
		s+="<div style='float: right;'>"+menuprice+" | <span style='cursor: pointer;' class='deleteMenuItem' data-menuprice='"+menuprice+"'>X</span>";
		s+="<input type='hidden' name='menuname' value='"+menuname+"'>";
		s+="<input type='hidden' name='menuprice' value='"+menuprice+"'>";
		s+="</div>"
		alert(s);
		$("#selectMenuLayout").append(s);
		$("#selectTotal").text(selectTotal);
	});
});

$(function(){
	$(document).on("click", ".deleteMenuItem", function(){
		var menuprice=parseInt($(this).attr("data-menuprice"));
		var selectTotal=$("#selectTotal").text();
		selectTotal=parseInt(selectTotal)-menuprice;
		$("#selectTotal").text(selectTotal);
		var div=$(this).parent().parent();
		$(div).remove();
	});
});
</script>
</head>
 
<body>

<div class="header">
    <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>

<!-- 매장정보 및 좋아요(개수) -->
<!-- 좋아요 개수는 하트 클릭 시 1씩 증가(단, 한 ID 당 1개의 좋아요만 가능) -->

<div>
	<div id="article-container" align="left" style="background: #F6F6F6;"><h2>${dto.shopName}</h2></div>
	<div id="article-container_bottom">
		<div style="float: left; width: 15%" align="center"><img src="<%=cp%>/resource/images/${dto.saveFilename}" width="130px;" height="90px"></div>
		<div style="float: left; width: 80%; margin-left: 10px;"><br><b>최소주문금액 : ${dto.shopPrice}원 이상</b><br><b>결제방법 : </b>현금, 카드</div>
	</div>
</div>

<!-- 메뉴 선택 -->
<!-- 메뉴 이미지, 내용 클릭하면 사이드바(결제)로 메뉴 추가 --> 
<form>
<c:forEach var="dto" items="${list}">
	<div id="article-content" align="left">
       	<div style="float: left; width: 20%;" align="center"><a href="#"><img src="<%=cp%>/resource/images/${dto.savefilename}" width="130px;" height="90px"></a></div>
       	<div style="float: left; border-left:1px solid #bcbcbc; height: 90px; padding-left: 10px;">
       	     <span class="menuselect" style="cursor: pointer;" data-menuname="${dto.menuname}" data-menuprice="${dto.menuprice}">${dto.menuname}<br><br>${dto.menucontent}<br><br>${dto.menuprice}</span></div>
	</div>
</c:forEach>
</form>      

<!-- 사이드바(결제, map, 주소) -->
<!-- 메뉴 선택 시  각 메뉴(금액) 아래로 나열됨 총 금액, 결제하기 -->
<form>
	<div id="article-sidebar" align="left">
       
        	<div id="article-sidebar-head">
        		<div style="background: #EAEAEA; height:30px; border-bottom: 1px solid #F6F6F6; padding-top: 10px; padding-bottom: 10px;"><h2 align="center">선 택 메 뉴</h2></div>
        		<div id="select-menu-order" style="height: 335px;">
        		    <div id="selectMenuLayout" style="clear: both;">
        		    </div>
        			
        			<div style="295px; padding-top: 20px; padding-left: 10px; padding-right: 10px; border-bottom: 1px dashed #bcbcbc;clear: both;">
        				<div style="float: right;">총금액 : <span id="selectTotal">0</span>원</div>
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
					center: new daum.maps.LatLng(${dto.latitude}, ${dto.longitude}), // 지도의 중심 좌표
					level: 3 // 지도의 확대 레벨
				};

				var map = new daum.maps.Map(container, options); // 지도를 생성합니다.
				
				
				var markerPosition  = new daum.maps.LatLng(${dto.latitude}, ${dto.longitude}); // 마커가 표시될 위치  
				
				var marker = new daum.maps.Marker({position: markerPosition}); // 마커 생성
				
				marker.setMap(map); // 마커가 지도에 표시되도록 설정
			</script>
			
			<!-- 주소지 -->
      		<div id="article-sidebar-foot" style="font-size: 11px;">${dto.shopAddr1}<br>${dto.shopAddr2}<br>${dto.shopTel1}-${dto.shopTel2}</div>
    	<a href="<%=cp%>/menu/created.do?page=${page}&state=${state}&shopNum=${shopNum}"><button type="button" style="background: #efefef; width: 100px; height: 30px; float: bottom;">메뉴등록</button></a>
    </div>
   </form>    

<div class="footer">
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>

</body>
</html>