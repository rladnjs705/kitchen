<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<script type="text/javascript">
//엔터 처리
/* $(function(){
	   $("input").not($(":button")).keypress(function (evt) {
	        if (evt.keyCode == 13) {
	            var fields = $(this).parents('form,body').find('button,input,textarea,select');
	            var index = fields.index(this);
	            if ( index > -1 && ( index + 1 ) < fields.length ) {
	                fields.eq( index + 1 ).focus();
	            }
	            return false;
	        }
	     });
}); */
</script>
<br>
<div class="header-top" align="right">
            <c:if test="${empty sessionScope.member}">
                <a href="<%=cp%>/member/login.do">로그인</a>
                    &nbsp;&nbsp;&nbsp;
                <a href="<%=cp%>/">주문내역조회</a>
                &nbsp;&nbsp;&nbsp;
                <a href="<%=cp%>/">장바구니</a>
                &nbsp;&nbsp;&nbsp;
                <a href="<%=cp%>/">회원가입</a>
                &nbsp;&nbsp;&nbsp;
            	<a href="<%=cp%>/notice/list.do">고객센터</a><br>
            </c:if><br>
            <c:if test="${not empty sessionScope.member}">
                <span style="color:blue;">${sessionScope.member.userName}</span>님
                    &nbsp;&nbsp;&nbsp;
                    <a href="<%=cp%>/member/logout.do">로그아웃</a>
                    &nbsp;&nbsp;&nbsp;
                    <a href="<%=cp%>/member/mypage.do">마이페이지</a>
                	&nbsp;&nbsp;&nbsp;
                    <a href="<%=cp%>/">장바구니</a>
                	&nbsp;&nbsp;&nbsp;
            		<a href="<%=cp%>/event.do">고객센터</a><br>
            </c:if>
            
</div>
<br>
<div class="header-middle">
    <a href="<%=cp%>/main.do">
       <img src="<%=cp%>/resource/images/main.jpg" width="250" height="250" style="margin-left: auto; margin-right: auto; display: block;">
    </a>
</div><br>
		    <ul class="nav">
					<li>
						<a href="<%=cp%>/">
						<img src="<%=cp%>/resource/images/food.png" width="40" height="40"><br>
						 &nbsp;한&nbsp;식
						 </a>
					 </li>
					<li>
						<a href="#"style="margin-left: 100px;">
						<img src="<%=cp%>/resource/images/sus.png" width="40" height="40"><br>
						 &nbsp;일&nbsp;식
						 </a>
					 </li>
					<li>
						<a href="#"style="margin-left: 100px;">
						<img src="<%=cp%>/resource/images/steak.png" width="40" height="40"><br>
						 &nbsp;양&nbsp;식
						 </a>
					</li>
					<li>
						<a href="#"style="margin-left: 100px;">
						<img src="<%=cp%>/resource/images/jajang.png" width="50" height="50"><br>
						 &nbsp;중&nbsp;식
						 </a>
					 </li>
					<li>
						<a href="#" style="margin-left: 100px;">
						<img src="<%=cp%>/resource/images/pizza.png" width="40" height="40"><br>
						 &nbsp;피&nbsp;자
						 </a>
					 </li>
					<li>
						<a href="#" style="margin-left: 100px;">
						<img src="<%=cp%>/resource/images/roast-chicken.png" width="40" height="40"><br>
						&nbsp;치&nbsp;킨
						</a>
					</li>
				</ul>