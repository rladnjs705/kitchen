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
$(function() {
	  $( "#datepicker2" ).datepicker({
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
	
$(document).ready(function(){
    $(".menu>a").click(function(){
        var submenu = $(this).next("ul");

        // submenu 가 화면상에 보일때는 위로 보드랍게 접고 아니면 아래로 보드랍게 펼치기
        if( submenu.is(":visible") ){
            submenu.slideUp();
        }else{
            submenu.slideDown();
        }
    }).click(function(){
        $(this).next("ul").slideDown();
    });
});

$(document).ready(function(){
	$('.menu a').click(function(){
		//엘리먼트 p a에 접근,그리고 클릭시 이벤트 발생 
		$('#box1').animate( {
			'height':'200px',opacity:1
			},1000);
		
		//발생하는이벤트.#box 아이디의 엘리먼트의 속성 
		//가로가 500px 세로는 300px로 늘어나고 투명도는 0.4 
		// 그리고 1초의속도로 애니메이션이전개된다.	
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
ul{
list-style:none;
}
.menu{
	width: 300px;
}


.menu a{
cursor:pointer;
}

.menu .hide{
display:none;
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
				<input id="datepicker2" type="text" name="searchDateValue2" />
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
	      <th width="300" style="color: #787878;">구입메뉴 목록</th>
  		</tr>
		
		<tr>
	<c:forEach var="dto" items="${list}">
		<tr id="box1" align="center" bgcolor="#ffffff" height="35" style="text-align: center; border-bottom: 1px solid #cccccc;">
		      <td>${dto.purchasedate}</td>
		      <td align="center" style=" padding-left: 10px;">
		           <a href="<%=cp%>/menu/article.do?page=1&state=${dto.categoryname}&shopNum=${dto.shopnum}">${dto.shopname}</a>
		      </td>
		      <td>${dto.purchaseprice}</td>
		      <td> 
					<ul >
				        <li class="menu">
				            <a style="text-align: top;"><img src="" alt="메뉴"/></a>
				            <ul class="hide">
				                <li>메뉴1-1</li>
				                <li>메뉴1-2</li>
				                <li>메뉴1-3</li>
				                <li>메뉴1-4</li>
				                <li>메뉴1-5</li>
				                <li>메뉴1-6</li>
				            </ul>
				        </li>
				    </ul>
    		</td>
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