<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	int iCode = Integer.parseInt(request.getParameter("detail_review_icode"));
	String cCode = request.getParameter("detail_review_ccode");

	pageContext.setAttribute("ICODE", iCode);
	pageContext.setAttribute("CCODE", cCode);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세 리뷰 작성</title>
<link href="/AspireStore/css/bootstrap.css" rel="stylesheet">
<link href="/AspireStore/css/shop-homepage.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/navbar.jsp" />

	<div class="container border">
		<form id="detail_review_form" name="detail_review_form" method="post" action="/AspireStore/items/review.aspire" enctype="multipart/form-data">
			<div class="form-group row">
				<label for="subject" class="col-sm-2 col-form-label">제목</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="subject" name="subject">
				</div>
			</div>
			<div class="form-group row">
				<label for="content" class="col-sm-2 col-form-label">내용</label>
				<div class="col-sm-10">
					<textarea style="resize: none;" class="form-control" id="content" name="content" rows="10">
							</textarea>
				</div>
			</div>
			<div class="form-group row">
				<label for="rating_radio" class="col-sm-2 col-form-label">평점</label>
				<div class="form-check form-check-inline" id="rating_radio">
					<input class="form-check-input" id="rating1" name="rating" type="radio" value="1">
					<label class="form-check-label" for="rating1">매우 비 추천</label>
					<input class="form-check-input" id="rating2" name="rating" type="radio" value="2">
					<label class="form-check-label" for="rating2">비 추천</label>
					<input class="form-check-input" id="rating3" name="rating" type="radio" value="3">
					<label class="form-check-label" for="rating3">보통</label>
					<input class="form-check-input" id="rating4" name="rating" type="radio" value="4">
					<label class="form-check-label" for="rating4">추천</label>
					<input class="form-check-input" id="rating5" name="rating" type="radio" value="5">
					<label class="form-check-label" for="rating5">매우 추천</label>
				</div>
			</div>
			<div class="form-group row">
				<div>
					<label for="file" class="col-sm-2 col-form-label">파일 첨부</label>
				</div>
				<div>
					<input type="button" onclick="addInputFile()" value="버튼 추가">
				</div>
				<div class="col-sm-10" id="input_file_row">
					<input multiple="multiple" type="file" class="form-control-file" id="file1" name="file1">
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-10">
					<input type="submit" class="btn btn-primary" id="applyDReviewBtn" name="applyDReviewBtn" value="리뷰 등록">
					<input type="hidden" name="type" id="type" value="APPLY_D_REVIEW">
					<input type="hidden" name="icode" id="icode" value="${pageScope.ICODE }">
					<input type="hidden" name="ccode" id="ccode" value="${pageScope.CCODE }">
				</div>
			</div>
		</form>
	</div>

	<%@ include file="/footer.html"%>

	<script src="/AspireStore/jquery/jquery.js"></script>
	<script src="/AspireStore/js/bootstrap.bundle.js"></script>

	<script>
		function addInputFile()
		{
			let fileDiv = document.getElementById('input_file_row');
			let newFileInput = document.createElement('input');

			newFileInput.setAttribute('multiple', 'multiple');
			newFileInput.setAttribute('type', 'file');
			newFileInput.setAttribute('class', 'form-control-file');
			newFileInput.setAttribute('id', 'file');
			newFileInput.setAttribute('name', 'file'
					+ String(fileDiv.childElementCount + 1));

			fileDiv.appendChild(newFileInput);
		}
	</script>
</body>
</html>