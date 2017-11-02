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
<link rel="stylesheet" href="<%=cp%>/resource/jquery/css/smoothness/jquery-ui.min.css" type="text/css">

<script type="text/javascript" src="<%=cp%>/resource/js/util.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
$( function() {
  $( "#accordion" ).accordion();
} );
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


</style>
</head>

<body>
<div class="header">
    <jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
</div>

<div class="containerList">

<div class="body-title">
            <h3>고객센터 | </h3>
</div>

<div class="menubar">
   <ul>
      <li><a href="<%=cp%>/notice/list.do" >공지사항 </a></li>
      <li><a href="<%=cp%>/bbs/list.do">문의하기</a></li>
      <li><a href="<%=cp%>/qna/qna.do" style="background: rgb(71,71,71);">질문과답변</a></li> 
      <li><a href="<%=cp%>/event/list.do" id="current">이벤트</a>
         <ul>
           <li><a href="<%=cp%>/event/list.do?state=y">진행중인이벤트</a></li> 
           <li><a href="<%=cp%>/event/list.do?state=n">지난이벤트</a></li>
         </ul>
      </li>
  </ul>
</div>
<br><br>
<table style="width: 1000px; margin: 0px auto; border-spacing: 0">
<tr height="50">
<td align="center" width="400">
<div style="font-size: 30px;">어떻게 도와드릴까요?</div><br>

</table>
<table style="width: 1000px; margin: 30px auto 0px;">
	<tbody>
		<tr height="30">
			<td class="title">
				<div style="font-size: 20px;">| 자주묻는 질문입니다.</div>
			</td>
		</tr>
	</tbody>
</table>
<table style="width: 1000px; margin: 10px auto 0px;">
	<tbody>
		<tr height="100">
			<td align="center" width="400">
				<div id="accordion">
  <h3 style="text-align: left;"> | 주문 메뉴를 변경하고 싶어요 </h3>
  <div>
    <p style="text-align: left;">
    - 주문이 접수 전이라면 업소에서 확인 전으로 어플에서 직접 취소 후 재주문 부탁 드립니다.<br>
	다만, 주문이 "접수 완료" 인 경우 메뉴 변경이 어려울 수 있으니 업소 혹은 권식당 고객센터 ( 0000-0000 )로 연락 부탁 드립니다. 
    </p>
</div>
  <h3 style="text-align: left;"> | 이번 달 이벤트는 어떻게 되나요? </h3>
  <div>
    <p style="text-align: left;">
    - 권식당에서는 고객님들께 더 많은 혜택을 제공해드리기 위해 노력하고 있습니다.<br>
    진행하고 있는 이벤트는 아래의 경로를 통하여 확인하실 수 있습니다.
    <br>
    <br>
    <br>
    - 고객센터 -> 이벤트 -> 진행중인 이벤트
    </p>
  </div>
  
  <h3 style="text-align: left;"> | 주문 취소방법을 알려주세요 </h3>
  <div>
    <p style="text-align: left;">
- 주문취소는 ' 접수대기' 상태이면, 직접 취소가능하며 '주문완료' 상태일 때는 [전화 걸기]를 눌러 
주문한 매장으로 직접 전화하여 취소 가능합니다. '접수대기' 상태는 업소에서 주문을 접수 하기 전으로  
취소방법은 하기와 같습니다. 
    </p>
  </div>
  
  <h3 style="text-align: left;"> | 배달예정시간보다 훨씬 늦게 음식이 도착하면 환불이나 보상이 되나요? </h3>
  <div>
    <p style="text-align: left;">
    - 권식당은 주문 내역에 대한 정보를 제공하고 결제 관련 판매 중개만을 하고 있습니다.<br>
배달 서비스나 배달 음식의 품질에 대해서는 업소에서 진행하는 부분으로,<br>
만약 환불이나 보상을 원하신다면 번거롭더라도 업소와 확인을 부탁 드립니다.<br>
    </p>
  </div>
  
  <h3 style="text-align: left;"> | 메일 주소를 모르겠어요 </h3>
  <div>
    <p style="text-align: left;">
- 메일주소는 홈페이지를 통해 직접 찾으실 수 있습니다. 홈페이지에서도 찾기가 어려우시다면 고객센터로 문의 부탁 드립니다.
본인 정보 확인 후 친절하게 안내 드리겠습니다.
    </p>
  </div>
  
  <h3 style="text-align: left;"> | 탈퇴 후 동일한 ID로 가입이 가능한가요? </h3>
  <div>
    <p style="text-align: left;">
    - 네. 동일한 이메일 ID로 재가입이 가능합니다.<br>
단, 기존의 쿠폰/포인트, 주문내역과 같은 정보는 모두 소멸되며 복구가 불가한 점 유의하시어 진행 부탁드립니다.
    </p>
  </div>
  
  <h3 style="text-align: left;"> | 주류 구매 시 연령인증은 꼭 해야 하나요? </h3>
  <div>
    <p style="text-align: left;">
    - 청소년보호법에 따라 19세 미만에게는 주류 판매가 금지되고 있어, 주류 구매 시에는 연령인증이 필요합니다.<br>
번거로우시더라도 건전한 음주문화를 위해 연령 인증 후 구매 부탁 드립니다.
    </p>
  </div>
  
  <h3 style="text-align: left;"> | 주문결제 내역에서 메뉴(혹은 수량)을 변경하고 싶어요. </h3>
  <div>
    <p style="text-align: left;">
    - 죄송합니다. 결제한 주문에서 부분 취소/변경은 어려우며 주문을 취소하신 후 재주문 및 결제를 하셔야 합니다. <br>
이미 업소에서 주문을 접수한 경우, 번거롭지만 해당 업소로 전화하여 취소를 하신 후 주문을 다시 진행 부탁 드립니다.
    </p>
  </div>
  
  <h3 style="text-align: left;"> | 동일 업소에서 주문거부를 지속 하여 불편합니다. </h3>
  <div>
    <p style="text-align: left;">
    - 권식당 서비스 이용 중 불편을 드려 죄송합니다. <br>
    권식당 고객센터 ( 0000-0000 ) 혹은 1:1 문의하기를 통해 말씀해주시면 해당 업소에 사실 여부를 확인하여 동일한 일이 발생하지 않도록 주의 조치를 하겠습니다.
    </p>
  </div>

  <h3 style="text-align: left;"> | 장바구니 사용법을 알려주세요! </h3>
  <div>
    <p style="text-align: left;">
    - 장바구니는 주문할 메뉴들을 임시로 보관하는 기능으로 한 업소에서 담은 메뉴들만 보관 가능 합니다.<br>
     배달업소에서 보여주는 메뉴 목록 화면에서 우측 상단에 장바구니 버튼 선택하면 보관한 메뉴들을 볼 수 있습니다. 
다만, 장바구니에 한 번에 여러 업소의 음식을 주문하고 싶으신 경우 업소 별로 주문을 해주셔야 하니 참고 부탁 드립니다.
    </p>
  </div>
  
  </div>
	</tbody>
</table>


</div>

<div class="footer">
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>

<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery.ui.datepicker-ko.js"></script>
</body>
</html>