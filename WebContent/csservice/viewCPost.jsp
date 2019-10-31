<%@page import="model.QnaDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	QnaDTO questionData = (QnaDTO) request.getAttribute("QUESTION_DATA");
	QnaDTO answerData = (QnaDTO) request.getAttribute("ANSWER_DATA");
	int currentPage = (int) request.getAttribute("CURRENT_PAGE");

	pageContext.setAttribute("QUESTION_DATA", questionData);
	pageContext.setAttribute("ANSWER_DATA", answerData);
	pageContext.setAttribute("CURRENT_PAGE", currentPage);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의/답변 보기</title>
<link href="/AspireStore/css/bootstrap.css" rel="stylesheet">
<link href="/AspireStore/css/shop-homepage.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/navbar.jsp" />
	<div class="container-fluid">
		<h5>문의 글</h5>
		<div class="form-group row">
			<label for="customerId" class="col-sm-2 col-form-label">나의 ID</label>
			<div class="col-sm-10">
				<input type="text" readonly class="form-control-plaintext" id="customerId" name="customerId" value="${pageScope.QUESTION_DATA.user_id }" readonly>
			</div>
		</div>
		<div class="form-group row">
			<label for="questionSubject" class="col-sm-2 col-form-label">제목</label>
			<div class="col-sm-10">
				<input type="text" readonly class="form-control-plaintext" id="questionSubject" name="questinSubject" value="${pageScope.QUESTION_DATA.subject }" readonly>
			</div>
		</div>
		<div class="form-group row">
			<label for="questionCategory" class="col-sm-2 col-form-label">카테고리</label>
			<div class="col-sm-10">
				<input type="text" readonly class="form-control-plaintext" id="questionCategory" name="questionCategory" value="${pageScope.QUESTION_DATA.category_desc }" readonly>
			</div>
		</div>
		<div class="form-group row">
			<label for="questionContent" class="col-sm-2 col-form-label">내용</label>
			<div class="col">
				<p class="text-justify" id="questionContent">${pageScope.QUESTION_DATA.content }</p>
			</div>
		</div>
		<div class="form-group row">
			<label for="questionAttachedFiles" class="col-sm-2 col-form-label">첨부된 파일</label>
			<div class="col-sm-10">
				<input type="file" class="form-control-file" id="questionAttachedFiles" name="questionAttachedFiles">
			</div>
		</div>
		<div class="form-group row">
			<label for="questionPostDate" class="col-sm-2 col-form-label">등록 날짜</label>
			<div class="col-sm-10">
				<input type="text" readonly class="form-control-plaintext" id="questionPostDate" name="questionPostDate" value="${pageScope.QUESTION_DATA.post_date }" readonly>
			</div>
		</div>

		<hr>


		<c:choose>
			<c:when test="${pageScope.ANSWER_DATA != null }">

				<h5>답변 글</h5>
				<div class="form-group row">
					<label for="answerSubject" class="col-sm-2 col-form-label">제목</label>
					<div class="col-sm-10">
						<input type="text" readonly class="form-control-plaintext" id="answerSubject" name="answerSubject" value="${pageScope.ANSWER_DATA.subject }" readonly>
					</div>
				</div>
				<div class="form-group row">
					<label for="answerCategory" class="col-sm-2 col-form-label">카테고리</label>
					<div class="col-sm-10">
						<input type="text" readonly class="form-control-plaintext" id="answerCategory" name="answerCategory" value="${pageScope.ANSWER_DATA.category_desc }" readonly>
					</div>
				</div>
				<div class="form-group row">
					<label for="answerContent" class="col-sm-2 col-form-label">내용</label>
					<div class="col">
						<p class="text-justify" id="answerContent">${pageScope.ANSWER_DATA.content }</p>
					</div>
				</div>
				<div class="form-group row">
					<label for="answerAttachedFiles" class="col-sm-2 col-form-label">첨부된 파일</label>
					<div class="col-sm-10">
						<input type="file" class="form-control-file" id="answerAttachedFiles" name="answerAttachedFiles">
					</div>
				</div>
				<div class="form-group row">
					<label for="answerPostDate" class="col-sm-2 col-form-label">등록 날짜</label>
					<div class="col-sm-10">
						<input type="text" readonly class="form-control-plaintext" id="answerPostDate" name="answerPostDate" value="${pageScope.ANSWER_DATA.post_date }" readonly>
					</div>
				</div>
				<div class="form-group row">
					<div class="col-sm-10">
						<input type="button" class="btn btn-secondary" id="moveToListBtn" name="moveToListBtn" onclick="moveToRecordList()" value="목록">
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<strong>답변이 아직 등록되지 않았습니다!</strong>
			</c:otherwise>
		</c:choose>

		<form id="post_form" name="post_form" action="/AspireStore/csservice/qna.aspire" method="GET">
			<input type="hidden" name="type" id="type">
			<input type="hidden" name="current_page" id="current_page" value="${pageScope.CURRENT_PAGE }">
		</form>
	</div>

	<script src="/AspireStore/jquery/jquery.js"></script>
	<script src="/AspireStore/js/bootstrap.bundle.js"></script>

	<script type="text/javascript">
		function moveToRecordList()
		{
			document.post_form.type.value = "GET_QUESTION_LIST";
			document.post_form.submit();
		}
	</script>
</body>
</html>