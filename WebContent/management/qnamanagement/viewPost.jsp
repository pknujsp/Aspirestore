<%@page import="model.QnaDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	QnaDTO questionData = (QnaDTO) request.getAttribute("QUESTION_DATA");
	QnaDTO answerData = (QnaDTO) request.getAttribute("ANSWER_DATA");

	pageContext.setAttribute("QUESTION_DATA", questionData);
	pageContext.setAttribute("ANSWER_DATA", answerData);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답변/문의 보기</title>
<link href="/AspireStore/css/bootstrap.css" rel="stylesheet">
<link href="/AspireStore/css/shop-homepage.css" rel="stylesheet">
</head>
<body>
	<div class="d-flex" id="wrapper">
		<div class="bg-light border-right" id="sidebar-wrapper">
			<!-- <div class="sidebar-heading">Start Bootstrap</div> -->
			<div class="list-group list-group-flush">
				<a href="#" class="list-group-item list-group-item-action bg-light">문의 목록</a>
				<a href="#" class="list-group-item list-group-item-action bg-light">답변 목록</a>
				<a href="#" class="list-group-item list-group-item-action bg-light">문의 통계</a>
			</div>
		</div>

		<div id="page-content-wrapper">
			<jsp:include page="../management_navbar.jsp"></jsp:include>

			<div class="container-fluid">
				<h5>문의 글</h5>
				<div class="form-group row">
					<label for="customerId" class="col-sm-2 col-form-label">고객 ID</label>
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
						<input type="button" class="btn btn-secondary" id="moveToListBtn" name="moveToListBtn" onclick="moveToAnswerList()" value="목록">
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="/AspireStore/jquery/jquery.js"></script>
	<script src="/AspireStore/js/bootstrap.bundle.js"></script>

	<script>
		$("#menu-toggle").click(function(e)
		{
			e.preventDefault();
			$("#wrapper").toggleClass("toggled");
		});

		function moveToAnswerList()
		{
			location.href = "/AspireStore/management/qnamanagement/answerlist.jsp";
		}
	</script>
</body>
</html>