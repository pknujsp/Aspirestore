<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답변하기</title>
<link href="/AspireStore/css/bootstrap.css" rel="stylesheet">
<link href="/AspireStore/css/shop-homepage.css" rel="stylesheet">
<link href="/AspireStore/css/sidebar.css" rel="stylesheet">
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
				<form id="answer_form" name="answer_form" method="post" action="/AspireStore/csservice/qna.aspire" enctype="multipart/form-data">
					<div class="form-group row">
						<label for="userName" class="col-sm-2 col-form-label">고객 ID</label>
						<div class="col-sm-10">
							<input type="text" readonly class="form-control-plaintext" id="userName" name="userName" value="" readonly>
						</div>
					</div>
					<div class="form-group row">
						<label for="inputSubject" class="col-sm-2 col-form-label">제목</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="inputSubject" name="inputSubject">
						</div>
					</div>
					<div class="form-group row">
						<label for="selectCategory" class="col-sm-2 col-form-label">카테고리</label>
						<div class="col-sm-10">
							<input type="text" readonly class="form-control-plaintext" id="inputCategory" name="inputCategory" value="" readonly>
						</div>
					</div>
					<div class="form-group row">
						<label for="textareaContent" class="col-sm-2 col-form-label">내용</label>
						<div class="col-sm-10">
							<textarea style="resize: none;" class="form-control" id="textareaContent" name="textareaContent" rows="10">
							</textarea>
						</div>
					</div>

					<div class="form-group row">
						<label for="inputFile" class="col-sm-2 col-form-label">파일 첨부</label>
						<div class="col-sm-10">
							<input type="file" class="form-control-file" id="inputFile[]" name="inputFile[]">
						</div>
					</div>
					<div class="form-group row">
						<div class="col-sm-10">
							<input type="button" class="btn btn-primary" id="applyAnswerBtn" name="applyAnswerBtn" onclick="applyAnswer()" value="답변 등록">
							&nbsp;
							<input type="button" class="btn btn-secondary" id="showQuestionBtn" name="showQuestionBtn" onclick="showQuestionPost()" data-toggle="modal" data-target="#modal" value="문의 글 보기">
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>

	<div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="modal_label" aria-hidden="true">
		<div class="modal-dialog modal-dialog-scrollable modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal_title">문의 사항</h5>
					&nbsp;
					<h6 class="modal-title" id="modal_question_category"></h6>

					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<pre id="modal_content"></pre>
				</div>
				<div class="modal-footer" id="modal_footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

	<script src="/AspireStore/jquery/jquery.js"></script>
	<script src="/AspireStore/js/bootstrap.bundle.js"></script>

	<script type="text/javascript">
		$("#menu-toggle").click(function(e)
		{
			e.preventDefault();
			$("#wrapper").toggleClass("toggled");
		});

		function applyAnswer()
		{

		}

		function showQuestionPost()
		{

		}
	</script>
</body>
</html>