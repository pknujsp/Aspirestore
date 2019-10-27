<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%
	String userId = (String)session.getAttribute("SESSIONKEY");
	pageContext.setAttribute("USER_ID", userId);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의</title>
<link href="/AspireStore/css/bootstrap.css" rel="stylesheet">
<link href="/AspireStore/css/shop-homepage.css" rel="stylesheet">
</head>
<body>
	<jsp:include page="/navbar.jsp"></jsp:include>

	<div class="container-fluid">
		<div>
			<table class="table table-sm table-hover">
				<thead class="thead-light">
					<tr>
						<th scope="col">제목</th>
						<th scope="col">등록날짜</th>
						<th scope="col">처리 상태</th>
						<!-- 답변여부 -->
					</tr>
				</thead>
				<tbody id="question_tbody">
					<tr>
						<!-- 문의기록이 없으면 '문의내용이 없다고 표시' -->
					</tr>
				</tbody>
			</table>
		</div>
	</div>

	<jsp:include page="/footer.html" />

	<script src="/AspireStore/jquery/jquery.js"></script>
	<script src="/AspireStore/js/bootstrap.bundle.js"></script>

	<script type="text/javascript">
		var questionList = [];
		var pageData =
		{
			'total_page' : 0,
			'total_block' : 0,
			'num_per_page' : 0,
			'page_per_block' : 5,
			'list_size' : 0,
			'total_record' : 0, //전체 레코드 수
			'current_page' : 1, // 현재 페이지
			'current_block' : 1, //현재 블럭
			'begin_index' : 0, //QUERY select 시작번호
			'end_index' : 0
		//시작번호로 부터 가져올 레코드 갯수
		};
		
		(function()
		{

		})()

		function setQuestionTable()
		{
			var dataToBeSended = ;
			let xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function()
			{
				if (xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200)
				{

				}
			};

			xhr.open('POST', '/AspireStore/question/questionmanagement.aspire',
					true);
			xhr.setRequestHeader('Content-type',
					'application/x-www-form-urlencoded');
			xhr.send(dataToBeSended);
		}
	</script>
</body>
</html>