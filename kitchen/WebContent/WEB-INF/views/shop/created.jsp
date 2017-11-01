<%@ page contentType="text/html; charset=UTF-8"%>
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
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery-ui.min.js"></script>
<link rel="stylesheet" href="<%=cp%>/resource/bootstrap/css/bootstrap.min.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/resource/bootstrap/css/bootstrap-theme.min.css"type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/resource/css/style.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/resource/css/layout.css" type="text/css"/>

<script type="text/javascript">
  function check() {
      var f = document.photoForm;

  	var str = f.shopName.value;
      if(!str) {
          f.shopName.focus();
          return false;
      }

  	  str = f.content.value;
      if(!str) {
          f.content.focus();
          return false;
      }

      var mode="${mode}";
  	  if(mode=="created"||mode=="update" && f.upload.value!="") {
  		if(! /(\.gif|\.jpg|\.png|\.jpeg)$/i.test(f.upload.value)) {
  			alert('이미지 파일만 가능합니다. !!!');
  			f.upload.focus();
  			return false;
  		}
  	  }
      
  	  if(mode=="created")
  		f.action="<%=cp%>/shop/created_ok.do";
  	  else if(mode=="update")
  		f.action="<%=cp%>/shop/update_ok.do";

		// <input type='submit' ..>,  <input type='image' ..>, <button>은 submit() 메소드 호출하면 두번전송
		return true;
	}

	function imageViewer(img) {
		var preViewer = $("#imageViewModal .modal-body");
		var s = "<img src='"+img+"' width='570' height='450'>";
		preViewer.html(s);

		$('#imageViewModal').modal('show');
	}
	function numberWithCommas(num){
	    var len, point, str; 
	       
	    num = num + ""; 
	    point = num.length % 3 ;
	    len = num.length; 
	   
	    str = num.substring(0, point); 
	    while (point < len) { 
	        if (str != "") str += ","; 
	        str += num.substring(point, point + 3); 
	        point += 3; 
	    } 
	     
	    return str;
	 
	}

</script>


</head>
<body>

	<div class="header">
		<jsp:include page="/WEB-INF/views/layout/header.jsp"></jsp:include>
	</div>

	<div class="container" role="main">
		<div class="bodyFrame col-sm-4"
			style="float: none; margin-left: auto; margin-right: auto;">
			<div class="body-title">
				<h4>
					<span class="glyphicon glyphicon-cutlery"></span> 매장등록
				</h4>
			</div>
			<div>
				<form name="photoForm" method="post" onsubmit="return check();"
					enctype="multipart/form-data">
					<div class="bs-write">
						<table class="table">
							<tbody>
								<tr>
									<th style="width:150px;">작성자명</th>
									<th>관리자</th>
								</tr>
								<tr>
									<th>매장분류<th>
									<label><input TYPE='radio' name='categoryName' value="한식" checked="checked"/>한식</label>
									<label><input TYPE='radio' name='categoryName' value="일식"/>일식</label>
									<label><input TYPE='radio' name='categoryName' value="양식"/>양식</label>
									<label><input TYPE='radio' name='categoryName' value="중식"/>중식</label>
									<label><input TYPE='radio' name='categoryName' value="피자"/>피자</label>
									<label><input TYPE='radio' name='categoryName' value="치킨"/>치킨</label>									
								</tr>
								<tr>
									<th>매장이름</th>
									<th colspan="3"><input type="text" name="shopName"
										class="form-control input-sm" required="required" value="${dto.shopName}"></th>
								</tr>
								<tr>
									<th colspan="4" style="padding-bottom: 0px;">설명</th>
									<td></td>
								</tr>
								<tr>
									<td colspan="4"><textarea name="content"
											class="form-control" rows="7" required="required">${dto.content}</textarea>
									</td>
								</tr>

								<tr>
									<th>매장 이미지</th>
									<td colspan="3"><input type="file" name="upload"
										accept="image/*" class="form-control input-sm"></td>
								</tr>

								<c:if test="${mode=='update'}">
									<tr>
										<td class="td1">메뉴이미지</td>
										<td colspan="3" class="td3"><img
											src="<%=cp%>/uploads/shop/${dto.saveFilename}" width="30"
											height="30" border="0"
											onclick="imageViewer('<%=cp%>/uploads/shop/${dto.saveFilename}');"
											style="cursor: pointer;"></td>
									</tr>
								</c:if>
								<tr>
									<th>주소</th>
									<td>
									<button style="height: 35px; float: left;" class="btn" type="button" onclick="sample6_execDaumPostcode()">우편번호 찾기</button>
									<input style="width: 200px; margin: 5px;" type="text" name="shopZip1" id="sample6_postcode" placeholder="우편번호" value="${dto.shopZip1}">
									<input style="width: 300px; margin: 5px;" type="text" name="shopAddr1" id="sample6_address" placeholder="주소" value="${dto.shopAddr1}">
									<input style="width: 250px; margin: 5px;" type="text" name="shopAddr2" id="sample6_address2" placeholder="상세주소" value="${dto.shopAddr2}">			  		
			  						</td>
		
								<tr>
									<th>매장 번호</th>
									<td>
									<select name="argency" style="margin:0px 0px 5px;">
  								    <option value="SKO">SKO</option>
  									<option value="KM">KM</option>
   									<option value="LF">LF</option>
   									<option value="없음" selected="selected">없음</option>
   									</select>
   									<br>
									<select name="tel1">
									<option value="02">02</option>
  								    <option value="010">010</option>
  									<option value="011">011</option>
   									<option value="016">016</option>
   									<option value="017">017</option>
   									<option value="018">018</option>
   									<option value="019">019</option>
   									</select> - 
									<input type="text" name="shopTel1" style="text-align: right; padding-left: 1px; width:50px;" value="${dto.shopTel1}"> - 
									<input type="text" name="shopTel2" style="text-align: right; padding-left: 1px; width:50px;" value="${dto.shopTel2}">
									</td>
								</tr>
								<tr>
								<tr>
									<th>배달 최소 비용</th>
									<td><input type="text" name="shopPrice" value="${dto.shopPrice}" onkeypress="numberWithCommas()">원</td>
								</tr>
								<tr>
									<th>배달 소요 시간</th>
									<td><input type="text" name="shopTime" value="${dto.shopTime}">분</td>
								</tr>
								<tr>
									<th>영업 시간</th>
									<td><input type="text" name="shopStart" class="timepicker" value="${dto.shopStart}"/> ~ 
									<input type="text" name="shopEnd" class="timepicker"value="${dto.shopEnd}"/></td>
								</tr>
								<tr>
									<th>매장 위치</th>
									<td>
										<input type="text" name="latitude" value="${dto.latitude}">위도
										<input type="text" name="longitude" value="${dto.longitude}">경도
									</td>
								</tr>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="4" style="text-align: center; padding-top: 15px;">
										<button type="submit" class="btn btn-primary">
											등록 <span class="glyphicon glyphicon-ok"></span>
										</button>
										<button type="button" class="btn btn-danger"
											onclick="javascript:location.href='<%=cp%>/shop/shopmenu.do';">
											취소</button> <c:if test="${mode=='update'}">
											<input type="hidden" name="shopNum" value="${dto.shopNum}">
											<input type="hidden" name="page" value="${page}">
										</c:if>
									</td>
								</tr>
							</tfoot>
						</table>
					</div>
				</form>
			</div>

		</div>
	</div>

	<div class="footer">
		<jsp:include page="/WEB-INF/views/layout/footer.jsp"></jsp:include>
	</div>

	<div class="modal fade" id="imageViewModal" tabindex="-1" role="dialog"
		aria-labelledby="imageViewModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close" onclick="check();">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="imageViewModalLabel"
						style="font-family: 나눔고딕, 맑은 고딕, sans-serif; font-weight: bold;">등록
						이미지</h4>
				</div>
				<div class="modal-body"></div>
			</div>
		</div>
	</div>

	<script type="text/javascript"
		src="<%=cp%>/resource/jquery/js/jquery-ui.min.js"></script>
	<script type="text/javascript"
		src="<%=cp%>/resource/jquery/js/jquery.ui.datepicker-ko.js"></script>
	<script type="text/javascript"
		src="<%=cp%>/resource/bootstrap/js/bootstrap.min.js"></script>
		<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
		<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('sample6_address').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('sample6_address2').focus();
            }
        }).open();
    }
</script>
</body>
</html>