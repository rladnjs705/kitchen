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

<link rel="stylesheet" href="<%=cp%>/resource/jquery/css/smoothness/jquery-ui.min.css"	type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/resource/bootstrap/css/bootstrap.min.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/resource/bootstrap/css/bootstrap-theme.min.css"type="text/css"/>

<link rel="stylesheet" href="<%=cp%>/resource/css/style.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/resource/css/layout.css" type="text/css"/>
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
<script type="text/javascript" src="wickedpicker.js"></script>
	
<style type="text/css">
.bs-write table {
	width: 100%;
	border: 0;
	border-spacing: 0;
}

.table tbody tr td {
	border-top: none;
	font-weight: normal;
}

.bs-write table td {
	padding: 3px 3px 3px 3px;
}

</style>

<script type="text/javascript"
	src="<%=cp%>/resource/jquery/js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
  function check() {
      var f = document.photoForm;

  	var str = f.subject.value;
      if(!str) {
          f.subject.focus();
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
  		f.action="<%=cp%>/photo/update_ok.do";

		// <input type='submit' ..>,  <input type='image' ..>, <button>은 submit() 메소드 호출하면 두번전송
		return true;
	}

	function imageViewer(img) {
		var preViewer = $("#imageViewModal .modal-body");
		var s = "<img src='"+img+"' width='570' height='450'>";
		preViewer.html(s);

		$('#imageViewModal').modal('show');
	}
	function AddComma(data_value) {
		return Number(data_value).toLocaleString('en').split;
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
					<span class="glyphicon glyphicon-cutlery"></span> 메뉴등록
				</h4>
			</div>
			<div>
				<form name="photoForm" method="post" onsubmit="return check();"
					enctype="multipart/form-data">
					<div class="bs-write">
						<table class="table">
							<tbody>
								<tr>
									<th>작성자명</th>
									<th>관리자</th>
								</tr>
								<tr>
									<th>매장분류<th>
									<label><input TYPE='radio' name='group1' value='kor'/>한식</label>
									<label><input TYPE='radio' name='group1' value='japan'/>일식</label>
									<label><input TYPE='radio' name='group1' value='western'/>양식</label>
									<label><input TYPE='radio' name='group1' value='chinese'/>중식</label>
									<label><input TYPE='radio' name='group1' value='pizza'/>피자</label>
									<label><input TYPE='radio' name='group1' value='chicken'/>치킨</label>									
								</tr>
								<tr>
									<th>메뉴이름</th>
									<th colspan="3"><input type="text" name="subject"
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
									<th>메뉴 이미지</th>
									<td colspan="3"><input type="file" name="upload"
										accept="image/*" class="form-control input-sm"></td>
								</tr>

								<c:if test="${mode=='update'}">
									<tr>
										<td class="td1">메뉴이미지</td>
										<td colspan="3" class="td3"><img
											src="<%=cp%>/uploads/photo/${dto.imageFilename}" width="30"
											height="30" border="0"
											onclick="imageViewer('<%=cp%>/uploads/photo/${dto.imageFilename}');"
											style="cursor: pointer;"></td>
									</tr>
								</c:if>
								<tr>
									<th>주소</th>
									<td>우편번호
									<input type="text" name="zip1" style="width:60px;" value="${dto.shopZip1}"> -
									<input type="text" name="zip2" style="width:60px;" value="${dto.shopZip2}"><br>
									주소 <input type="text" name="addr1" style="margin:5px 5px;" value="${dto.shopAddr1}">
									 <br><input type="text" name="addr2" style="width:200px; font-size:15px;" value="${dto.shopAddr2}">상세주소</td>
								</tr>

								<tr>
									<th>핸드폰 번호</th>
									<td>
									<select name="argency" style="margin:0px 0px 5px;">
  								    <option value="SKO">SKO</option>
  									<option value="KM">KM</option>
   									<option value="LF">LF</option>
   									</select>
   									<br>
									<select name="tel1">
  								    <option value="010">010</option>
  									<option value="011">011</option>
   									<option value="016">016</option>
   									<option value="017">017</option>
   									<option value="018">018</option>
   									<option value="019">019</option>
   									</select> - 
									<input type="text" name="tel2" style="text-align: right; padding-left: 1px; width:50px;" value="${dto.shopTel1}"> - 
									<input type="text" name="tel3" style="text-align: right; padding-left: 1px; width:50px;" value="${dto.shopTel2}">
									</td>
								</tr>
								<tr>
								<tr>
									<th>배달 최소 비용</th>
									<td><input type="text" name="price" class="shopnumber" value="${dto.shopPrice}">원</td>
								</tr>
								<tr>
									<th>배달 소요 시간</th>
									<td><input type="text" name="shoptime" value="${dto.shopTime}">분</td>
								</tr>
								<tr>
									<th>영업 시간</th>
									<td><input type="text" name="timepicker" class="timepicker" value="${dto.shopStart}"/> ~ 
									<input type="text" name="timepicker" class="timepicker"value="${dto.shopEnd}"/></td>
								</tr>
							</tbody>
							<tfoot>
								<tr>
									<td colspan="4" style="text-align: center; padding-top: 15px;">
										<button type="submit" class="btn btn-primary">
											등록 <span class="glyphicon glyphicon-ok"></span>
										</button>
										<button type="button" class="btn btn-danger"
											onclick="javascript:location.href='<%=cp%>/photo/list.do';">
											취소</button> <c:if test="${mode=='update'}">
											<input type="hidden" name="num" value="${dto.num}">
											<input type="hidden" name="userId" value="${dto.userId}">
											<input type="hidden" name="imageFilename"
												value="${dto.imageFilename}">
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
</body>
</html>