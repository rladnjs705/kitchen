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
          return;
      }

  	  str = f.content.value;
      if(!str) {
          f.content.focus();
          return;
      }

     var mode="${mode}";
     /*  
  	  if(mode=="created"||mode=="update" && f.upload.value!="") {
  		if(! /(\.gif|\.jpg|\.png|\.jpeg)$/i.test(f.upload.value)) {
  			alert('이미지 파일만 가능합니다. !!!');
  			f.upload.focus();
  			return;
  		}
  	  } */
      
  	  if(mode=="created")
  		f.action="<%=cp%>/menu/created_ok.do";
  	  else if(mode=="update")
  		f.action="<%=cp%>/menu/update_ok.do";
		
  	f.submit();
		// <input type='submit' ..>,  <input type='image' ..>, <button>은 submit() 메소드 호출하면 두번전송

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
				<form name="photoForm" method="post">
					<!-- enctype="multipart/form-data"> -->
					<div class="bs-write">
						<table class="table">
							<tbody>
								<tr>
									<th>작성자명</th>
									<th>관리자</th>
								</tr>
								<tr>
									<th>메뉴이름 </th>
									<th colspan="3"><input type="text" name="subject"
										class="form-control input-sm" ></th>
								</tr>
								<tr>
									<th>메뉴가격 </th>
									<th colspan="3"><input type="text" name="price"
										class="form-control input-sm"></th>
								</tr>
								<tr>
									<th colspan="4" style="padding-bottom: 0px;">설명</th>
									<td></td>
								</tr>
								<tr>
									<td colspan="4"><textarea name="content"
											class="form-control" rows="7">${dto.content}</textarea>
									</td>
								</tr>

								<tr>
									<th>메뉴이미지</th>
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
							</tbody>
							<tfoot>
								<tr>
									<td colspan="4" style="text-align: center; padding-top: 15px;">
										<button type="submit" class="btn btn-primary" onclick="check();">
											등록 <span class="glyphicon glyphicon-ok"></span>
										</button>
										<button type="button" class="btn btn-danger"
											onclick="javascript:location.href='<%=cp%>/menu/menulist.do';">
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
						aria-label="Close">
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