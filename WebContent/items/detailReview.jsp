<%@page import="model.ReviewDTO"%>
<%@page import="model.FileDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	@SuppressWarnings("unchecked")
	ArrayList<FileDTO> files = (ArrayList<FileDTO>) request.getAttribute("ATTACHED_FILES");
	ReviewDTO review = (ReviewDTO) request.getAttribute("REVIEW");

	pageContext.setAttribute("ATTACHED_FILES", files);
	pageContext.setAttribute("REVIEW", review);
	pageContext.setAttribute("ITEM_CATEGORY_CODE", (String) request.getAttribute("CCODE"));
	pageContext.setAttribute("ITEM_CODE", (int) request.getAttribute("ICODE"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세 리뷰</title>
<link href="/AspireStore/css/bootstrap.css" rel="stylesheet">
<link href="/AspireStore/css/shop-homepage.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/navbar.jsp" />
	<div class="container-fluid">
		<h5>상세 리뷰</h5>
		<div class="form-group row">
			<label for="writerId" class="col-sm-2 col-form-label">작성자 ID</label>
			<div class="col-sm-10">
				<input type="text" readonly class="form-control-plaintext" id="writerId" name="writerId" value="${pageScope.REVIEW.writer_id }" readonly>
			</div>
		</div>
		<div class="form-group row">
			<label for="subject" class="col-sm-2 col-form-label">제목</label>
			<div class="col-sm-10">
				<input type="text" readonly class="form-control-plaintext" id="subject" name="subject" value="${pageScope.REVIEW.subject }" readonly>
			</div>
		</div>
		<div class="form-group row">
			<label for="rating" class="col-sm-2 col-form-label">평점</label>
			<div class="col-sm-10">
				<input type="text" readonly class="form-control-plaintext" id="rating" name="rating" value="${pageScope.REVIEW.rating }" readonly>
			</div>
		</div>
		<div class="form-group row">
			<label for="content" class="col-sm-2 col-form-label">내용</label>
			<div class="col">
				<p class="text-justify" id="content">${pageScope.REVIEW.content }</p>
			</div>
		</div>
		<div class="form-group row">
			<label for="questionAttachedFiles" class="col-sm-2 col-form-label">첨부된 파일</label>
			<c:if test="${pageScope.ATTACHED_FILES != null }">
				<div class="col-sm-10">
					<c:forEach var="file" items="${pageScope.ATTACHED_FILES }" varStatus="status">
						<div>
							<input type="button" class="btn btn-secondary" id="attachedFile[]" name="attachedFile[]" onclick="downLoadFile('${file.file_uri}','${file.file_name }')" value="${file.file_name }">
						</div>
						<br>
					</c:forEach>
				</div>
			</c:if>
		</div>
		<div class="form-group row">
			<label for="postDate" class="col-sm-2 col-form-label">등록 날짜</label>
			<div class="col-sm-10">
				<input type="text" readonly class="form-control-plaintext" id="postDate" name="postDate" value="${pageScope.REVIEW.post_date }" readonly>
			</div>
		</div>
		<input type="button" onclick="moveToBookPage()" value="목록">
		<form id="post_form" name="post_form" action="/AspireStore/items/item.aspire" method="GET">
			<input type="hidden" name="icode" value="${pageScope.ITEM_CODE }">
			<input type="hidden" name="ccode" value="${pageScope.ITEM_CATEGORY_CODE }">
		</form>

		<form id="downloadForm" name="downloadForm" action="/AspireStore/filemanagement/fileDownload.jsp" method="get">
			<input type="hidden" id="fileUri" name="fileUri" value="">
			<input type="hidden" id="fileName" name="fileName" value="">
		</form>
	</div>

	<script src="/AspireStore/jquery/jquery.js"></script>
	<script src="/AspireStore/js/bootstrap.bundle.js"></script>

	<script type="text/javascript">
		function moveToBookPage()
		{
			document.post_form.submit();
		}

		function downLoadFile(pFileUri, pFileName)
		{
			document.downloadForm.fileUri.value = pFileUri;
			document.downloadForm.fileName.value = pFileName;
			document.downloadForm.submit();
		}
	</script>
</body>
</html>