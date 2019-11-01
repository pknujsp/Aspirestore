<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의하기</title>
</head>
<link href="/AspireStore/css/bootstrap.css" rel="stylesheet">
<link href="/AspireStore/css/shop-homepage.css" rel="stylesheet">
<body>
	<jsp:include page="../navbar.jsp" />

	<div class="container-fluid">
		<form id="question_form" name="question_form" method="post" action="/AspireStore/csservice/applyPost.aspire" enctype="multipart/form-data">
			<div class="form-group row">
				<label for="inputSubject" class="col-sm-2 col-form-label">제목</label>
				<div class="col-sm-10">
					<input type="text" class="form-control" id="inputSubject" name="inputSubject">
				</div>
			</div>
			<div class="form-group row">
				<label for="selectCategory" class="col-sm-2 col-form-label">카테고리</label>
				<div class="col-sm-10">
					<select id="selectCategory" name="selectCategory">
						<option value="1">도서 관련</option>
						<option value="2">환불 및 교환</option>
						<option value="3">배송</option>
						<option value="4">계정</option>
						<option value="5">주문 및 결제</option>
						<option value="6">웹 사이트</option>
						<option value="7">장바구니</option>
						<option value="8">아스파이어에 대해</option>
						<option value="9">대량구매</option>
					</select>
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
					<input type="button" onclick="addInputFile()" value="파일 첨부버튼 추가">
				</div>
				<div class="col-sm-10" id="input_file_row">
					<input multiple="multiple" type="file" class="form-control-file" id="inputFile" name="inputFile">
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-10">
					<input type="submit" class="btn btn-primary" id="applyAnswerBtn" name="applyAnswerBtn" value="답변 등록">
					<input type="hidden" name="type" id="type" value="QUESTION">
				</div>
			</div>
		</form>
	</div>

	<script src="/AspireStore/jquery/jquery.js"></script>
	<script src="/AspireStore/js/bootstrap.bundle.js"></script>

	<script>
		function addInputFile()
		{
			let divFileRow = document.getElementById('input_file_row');
			let newRow = document.createElement('input');

			newRow.setAttribute('type', 'file');
			newRow.setAttribute('multiple', 'multiple');
			newRow.setAttribute('class', 'form-control-file');
			newRow.setAttribute('id', 'inputFile');
			newRow.setAttribute('name', 'inputFile');

			divFileRow.appendChild(newRow);
		}
	</script>
</body>
</html>