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

<table style="width: 900px; margin: 0px auto; border-spacing: 0">
<tr height="50">
<td align="center" width="400">
<div style="font-size: 30px;">어떻게 도와드릴까요?</div><br>
	<tbody>
		<tr height="50">
			<td align="center" width="400">
				<input type="text" name="searchqna" class="boxTF" style="width: 700px; height: 35px; font-size: 30px">
				<button type="button" class="btn" onclick="" style="height: 45px; width: 100px;"> 검색 </button>
			</td>
		</tr>
	</tbody>
</table>
<table style="width: 800px; margin: 30px auto 0px;">
	<tbody>
		<tr height="30">
			<td class="title">
				<div style="font-size: 20px;">| 자주묻는 질문입니다.</div>
			</td>
		</tr>
	</tbody>
</table>

<table style="width: 800px; margin: 30px auto 0px;">
	<tbody>
		<tr height="100">
			<td align="center" width="400">
				<div id="accordion">
  <h3 style="text-align: left;"> | 주문 메뉴를 변경하고 싶어요 </h3>
  <div>
    <p style="text-align: left;">
    메뉴에서 주문버튼
    </p>
  </div>
  
  <h3 style="text-align: left;"> | 메뉴를 선택하는데 </h3>
  <div>
    <p style="text-align: left;">
    무
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
  
  <h3 style="text-align: left;"> | 홈페이지에 있는 가격이 정확한 가격인가요? </h3>
  <div>
    <p style="text-align: left;">
    네
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
    ㅂ
    </p>
  </div>
  
  <h3 style="text-align: left;"> | 아이디, 비밀번호를 잃어버렸어요 </h3>
  <div>
    <p style="text-align: left;">
    ㄹ
    </p>
  </div>
  
  <h3 style="text-align: left;"> | 포인트 적립은 어떻게 하나요 </h3>
  <div>
    <p style="text-align: left;">
    ㄱ
    </p>
  </div>
  
  <h3 style="text-align: left;"> | 포인트 사용은 어떻게 하나요 </h3>
  <div>
    <p style="text-align: left;">
    ㄴ
    </p>
  </div>
  
  <h3 style="text-align: left;"> | 주문은 어떻게 하나요</h3>
  <div>
    <p style="text-align: left;">
    ㅅ
    </p>
  </div>
  
  <h3 style="text-align: left;"> | 주문은 어떻게 하나요</h3>
  <div>
    <p style="text-align: left;">
    ㄷ
    </p>
  </div>
  
  </div>
	</tbody>
</table>

<table >
</table>

</div>

<div class="footer">
    <jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
</div>

<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery.ui.datepicker-ko.js"></script>
</body>
</html>