<%@page import="model.fileDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.QnaDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	QnaDTO questionData = (QnaDTO) request.getAttribute("QUESTION_DATA");
	@SuppressWarnings("unchecked")
	ArrayList<fileDTO> questionFiles = (ArrayList<fileDTO>) request.getAttribute("QUESTION_FILES");

	pageContext.setAttribute("QUESTION_FILES", questionFiles);
	pageContext.setAttribute("QUESTION_DATA", questionData);
%>

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
				<form id="answer_form" name="answer_form" method="post" action="/AspireStore/csservice/applyPost.aspire" enctype="multipart/form-data">
					<div class="form-group row">
						<label for="inputSubject" class="col-sm-2 col-form-label">제목</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="inputSubject" name="inputSubject">
						</div>
					</div>
					<div class="form-group row">
						<label for="selectCategory" class="col-sm-2 col-form-label">카테고리</label>
						<div class="col-sm-10">
							<input type="text" readonly class="form-control-plaintext" id="inputCategory" name="inputCategory" value="${pageScope.QUESTION_DATA.category_desc }" readonly>
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
						<div>
							<label for="inputFile" class="col-sm-2 col-form-label">파일 첨부</label>
						</div>
						<div>
							<input type="button" onclick="addInputFile()" value="버튼 추가">
						</div>
						<div class="col-sm-10" id="input_file_row">
							<input multiple="multiple" type="file" class="form-control-file" id="inputFile" name="inputFile1">
						</div>
					</div>
					<div class="form-group row">
						<div class="col-sm-10">
							<input type="submit" class="btn btn-primary" id="applyAnswerBtn" name="applyAnswerBtn" value="답변 등록">
							<input type="button" class="btn btn-secondary" id="showQuestionBtn" name="showQuestionBtn" onclick="showQuestionPost()" value="문의 내용 보기">
							<input type="hidden" name="type" id="type" value="ANSWER">
							<input type="hidden" name="questionerId" id="questionerId" value="${pageScope.QUESTION_DATA.user_id }">
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
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="form-group row">
						<label for="customerId" class="col-sm-2 col-form-label">문의자 ID</label>
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
						<label for="questionPostDate" class="col-sm-2 col-form-label">등록 날짜</label>
						<div class="col-sm-10">
							<input type="text" readonly class="form-control-plaintext" id="questionPostDate" name="questionPostDate" value="${pageScope.QUESTION_DATA.post_date }" readonly>
						</div>
					</div>
					<div>
						<c:if test="${pageScope.QUESTION_FILES != null }">
							<div class="col-sm-10">
								<c:forEach var="file" items="${pageScope.QUESTION_FILES }" varStatus="status">
									<div>
										<input type="button" class="btn btn-secondary" id="questionAttachedFile[]" name="questionAttachedFile[]" onclick="downLoadFile('${file.file_uri}','${file.file_name }')" value="${file.file_name }">
									</div>
									<br>
								</c:forEach>
							</div>
						</c:if>
					</div>
				</div>
				<div class="modal-footer" id="modal_footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

	<form id="downloadForm" name="downloadForm" action="/AspireStore/filemanagement/fileDownload.jsp" method="get">
		<input type="hidden" id="fileUri" name="fileUri" value="">
		<input type="hidden" id="fileName" name="fileName" value="">
	</form>

	<script src="/AspireStore/jquery/jquery.js"></script>
	<script src="/AspireStore/js/bootstrap.bundle.js"></script>

	<script type="text/javascript">
		var questionData =
		{
			question_code : 0,
			questioner_id : '',
			subject : '',
			category_desc : '',
			content : '',
			post_date : '',
			ip : ''
		};

		(function()
		{
			setQuestionObject();
		})()

		function setQuestionObject()
		{
			questionData['question_code'] = $
			{
				pageScope.QUESTION_DATA['question_code']
			}
			;
			questionData['questioner_id'] = $
			{
				pageScope.QUESTION_DATA['user_id']
			}
			;
			questionData['subject'] = $
			{
				pageScope.QUESTION_DATA['subject']
			}
			;
			questionData['category_desc'] = $
			{
				pageScope.QUESTION_DATA['category_desc']
			}
			;
			questionData['category_code'] = $
			{
				pageScope.QUESTION_DATA['category_code']
			}
			;
			questionData['content'] = $
			{
				pageScope.QUESTION_DATA['content']
			}
			;
			questionData['post_date'] = $
			{
				pageScope.QUESTION_DATA['post_date']
			}
			;
			questionData['ip'] = $
			{
				pageScope.QUESTION_DATA['ip']
			}
			;
		}

		$("#menu-toggle").click(function(e)
		{
			e.preventDefault();
			$("#wrapper").toggleClass("toggled");
		});

		function addInputFile()
		{
			let divFileRow = document.getElementById('input_file_row');
			let newRow = document.createElement('input');

			newRow.setAttribute('type', 'file');
			newRow.setAttribute('multiple', 'multiple');
			newRow.setAttribute('class', 'form-control-file');
			newRow.setAttribute('id', 'inputFile');
			newRow.setAttribute('name', 'inputFile'
					+ String(divFileRow.childElementCount + 1));

			divFileRow.appendChild(newRow);
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